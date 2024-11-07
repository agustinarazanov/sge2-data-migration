import { PrismaClient } from '@prisma/client';
import * as sql from '@prisma/client/sql';
import * as fs from 'fs';
import csv = require('csv-parser');

const prisma = new PrismaClient();

async function main() {
    console.log('Comenzando migración...');

    await prisma.$queryRawTyped(sql.insertDocumentoTipo());
    await prisma.$queryRawTyped(sql.insertPais());
    await prisma.$queryRawTyped(sql.insertProvincia());

    type UserData = { email: string; id: string; usuario_id: bigint; atributo: string };
    const userdata: UserData[] = await Promise.all(
        (await prisma.$queryRawTyped(sql.selectUserdata())).map(async u => {
            const { id } = await prisma.user.create({
                data: {
                    name: u.email.split('@')[0],
                    email: u.email,
                },
            });
            return {
                ...u,
                id,
                atributo: u.atributo
                    .split(',')
                    .map(v => parseInt(v, 16).toString(2).padStart(4, '0'))
                    .join(''),
            };
        }),
    );

    await prisma.$queryRawTyped(sql.updateUser());
    const admin = userdata.find(u => Number(u.usuario_id) === 3571)?.id ?? '';
    await prisma.$queryRawTyped(sql.insertTutor(admin));
    const roles: Record<string, number> = {};
    const promises: Promise<void>[] = [];

    fs.createReadStream('./scripts/permissions.csv')
        .pipe(csv({ separator: ';', mapHeaders: ({ header }) => header.trim() }))
        .on('data', async data => {
            if (!data.grupo || !data.nombre) return;
            if (data.nombre.includes('grupo')) {
                const promise = prisma.rol
                    .create({
                        data: {
                            nombre: data.nombre.split('grupo ')[1],
                            usuarioCreadorId: admin,
                            usuarioModificadorId: admin,
                        },
                    })
                    .then(role => {
                        roles[data.bit] = role.id;
                    });
                promises.push(promise);
            } else {
                await prisma.permiso.create({
                    data: {
                        sgeNombre: data.sgeNombre,
                        grupo: data.grupo,
                        nombre: data.nombre,
                        enDesuso: data.enDesuso === 'TRUE',
                        usuarioCreadorId: admin,
                        usuarioModificadorId: admin,
                    },
                });
            }
        })
        .on('end', async () => {
            await Promise.all(promises);
            await prisma.$queryRawTyped(sql.insertRolPermiso(admin));

            for (const u of userdata) {
                Array.from(u.atributo).forEach(async (bit, i) => {
                    if (bit === '1' && roles[i])
                        await prisma.$queryRawTyped(sql.insertUsuarioRol(u.id, roles[i], admin));
                });
            }
        });

    await prisma.$queryRawTyped(sql.insertSede());
    await prisma.$queryRawTyped(sql.insertLaboratorio(admin));
    await prisma.$queryRawTyped(sql.insertArmario(admin));
    await prisma.$queryRawTyped(sql.insertEstante(admin));

    await prisma.$queryRawTyped(sql.insertSoftware(admin));
    await prisma.$queryRawTyped(sql.insertSoftwareLaboratorio(admin));

    await prisma.$queryRawTyped(sql.insertEquipoTipo(admin));
    await prisma.$queryRawTyped(sql.insertEquipoMarca(admin));
    await prisma.$queryRawTyped(sql.insertEquipoEstado(admin));
    await prisma.$queryRawTyped(sql.insertEquipo(admin));

    await prisma.$queryRawTyped(sql.insertLibroAutor(admin));
    await prisma.$queryRawTyped(sql.insertLibroIdioma(admin));
    await prisma.$queryRawTyped(sql.insertLibroEditorial(admin));
    await prisma.$queryRawTyped(sql.insertLibro(admin));

    await prisma.$queryRawTyped(sql.insertMateria(admin));
    await prisma.$queryRawTyped(sql.insertMateriaJefeTp());
    await prisma.$queryRawTyped(sql.insertLibroMateria(admin));
    await prisma.$queryRawTyped(sql.insertMateriaCorrelativa(admin));

    await prisma.$queryRawTyped(sql.insertDivision(admin));
    await prisma.$queryRawTyped(sql.insertCurso(admin));
    await prisma.$queryRawTyped(sql.insertCursoAyudante(admin));
    await prisma.$queryRawTyped(sql.updateUserEsDocente());

    await prisma.$queryRawTyped(sql.updateLibro1());
    await prisma.$queryRawTyped(sql.updateLibro2());
    await prisma.$queryRawTyped(sql.updateLibro3());
    await prisma.$queryRawTyped(sql.updateLibro4());
    await prisma.$queryRawTyped(sql.updateLibro5());
    await prisma.$queryRawTyped(sql.updateLibro6());
    await prisma.$queryRawTyped(sql.updateLibro7());
    await prisma.$queryRawTyped(sql.updateLibro8());
    await prisma.$queryRawTyped(sql.updateLibro9());
    await prisma.$queryRawTyped(sql.updateLibro10());
    await prisma.$queryRawTyped(sql.updateLibro11());
    await prisma.$queryRawTyped(sql.updateLibro12());
    await prisma.$queryRawTyped(sql.updateLibro13());
    await prisma.$queryRawTyped(sql.updateLibro14());
    await prisma.$queryRawTyped(sql.updateLibro15());
    await prisma.$queryRawTyped(sql.updateLibro16());
    await prisma.$queryRawTyped(sql.updateLibro17());
    await prisma.$queryRawTyped(sql.updateLibro18());
    await prisma.$queryRawTyped(sql.updateLibro19());
    await prisma.$queryRawTyped(sql.updateLibro20());
    await prisma.$queryRawTyped(sql.updateLibro21());
    await prisma.$queryRawTyped(sql.updateLibro22());
    await prisma.$queryRawTyped(sql.updateLibro23());

    await prisma.$queryRawTyped(sql.updateLibroAutor1());
    await prisma.$queryRawTyped(sql.updateLibroAutor2());
    await prisma.$queryRawTyped(sql.updateLibroAutor3());
    await prisma.$queryRawTyped(sql.updateLibroAutor4());
    await prisma.$queryRawTyped(sql.updateLibroAutor5());
    await prisma.$queryRawTyped(sql.updateLibroAutor6());
    await prisma.$queryRawTyped(sql.updateLibroAutor7());
    await prisma.$queryRawTyped(sql.updateLibroAutor8());
    await prisma.$queryRawTyped(sql.updateLibroAutor9());
    await prisma.$queryRawTyped(sql.updateLibroAutor10());
    await prisma.$queryRawTyped(sql.updateLibroAutor11());

    await prisma.$queryRawTyped(sql.updateMateria1());
    await prisma.$queryRawTyped(sql.updateMateria2());
    await prisma.$queryRawTyped(sql.updateMateria3());
    await prisma.$queryRawTyped(sql.updateMateria4());
    await prisma.$queryRawTyped(sql.updateMateria5());

    await prisma.$queryRawTyped(sql.updateEquipo1());
    await prisma.$queryRawTyped(sql.updateEquipo2());
    await prisma.$queryRawTyped(sql.updateEquipo3());
    await prisma.$queryRawTyped(sql.updateEquipo4());

    console.log('¡Migración completa!');
    console.log('Verificando datos...');

    console.assert(
        (await prisma.libro.count()) === (await prisma.libros.count()),
        'Hubo errores en la migración de libros',
    );
    console.assert(
        (await prisma.materia.count()) === (await prisma.materias.count()),
        'Hubo errores en la migración de materias',
    );
    console.assert(
        (await prisma.equipo.count()) === (await prisma.equipos.count()),
        'Hubo errores en la migración de equipos',
    );
    console.assert(
        (await prisma.curso.count()) ===
            (await prisma.cursos.count({ where: { horainicio: { not: null } } })),
        'Hubo errores en la migración de cursos',
    );
    console.assert(
        (await prisma.division.count()) === (await prisma.divisiones.count()),
        'Hubo errores en la migración de divisiones',
    );

    console.log('¡Verificación completa!');
}

main()
    .then(async () => {
        await prisma.$disconnect();
    })
    .catch(async e => {
        console.error(e);
        await prisma.$disconnect();
        process.exit(1);
    });
