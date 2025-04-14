import {
    LaboratorioAbiertoTipo,
    PrismaClient,
    ReservaEstatus,
    ReservaTipo,
    SgeNombre,
} from '@prisma/client';
import * as sql from '@prisma/client/sql';
import * as fs from 'fs';
import csv = require('csv-parser');

const prisma = new PrismaClient();

async function main() {
    console.log('Comenzando migración...');

    await prisma.$queryRawTyped(sql.insertDocumentoTipo());
    await prisma.$queryRawTyped(sql.insertPais());
    await prisma.$queryRawTyped(sql.insertProvincia());

    const filteredUsers = await prisma.$queryRawTyped(sql.selectUserdata());
    const userdata = await prisma.user.createManyAndReturn({
        data: filteredUsers.map(user => ({
            ...user,
            name: user.name ?? '',
        })),
    });

    await prisma.$queryRawTyped(sql.updateUser());
    const admin = userdata.find(u => u.name === 'hspataro')?.id ?? '';
    await prisma.$queryRawTyped(sql.insertTutor(admin));

    const sedes = await prisma.$queryRawTyped(sql.insertSede());
    const medranoId = sedes.find(sede => sede.nombre === 'Medrano')?.id ?? 1;

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

    const reservasCerradas = await prisma.$queryRawTyped(sql.selectReservaCerrada());

    await Promise.all(
        reservasCerradas.map(async reserva => {
            const reservaCreada = await prisma.reserva.create({
                data: {
                    estatus: reserva.estatus ?? ReservaEstatus.FINALIZADA,
                    fechaHoraInicio: reserva.fechaHoraInicio ?? '',
                    fechaHoraFin: reserva.fechaHoraFin ?? '',
                    tipo: ReservaTipo.LABORATORIO_CERRADO,
                    usuarioSolicitoId: reserva.usuarioSolicitoId,
                    usuarioAprobadorId: reserva.usuarioAprobadorId,
                    fechaModificacion: new Date(),
                    usuarioCreadorId: reserva.usuarioSolicitoId,
                    usuarioModificadorId: reserva.usuarioSolicitoId,
                },
            });

            await prisma.reservaLaboratorioCerrado.create({
                data: {
                    descripcion: reserva.descripcion ?? undefined,
                    requierePC: reserva.requierePC ?? undefined,
                    reservaId: reservaCreada.id,
                    sedeId: reserva.sedeId,
                    laboratorioId: reserva.laboratorioId,
                    cursoId: reserva.cursoId,
                    esDiscrecional: reserva.esDiscrecional ?? undefined,
                    discrecionalMateriaId: reserva.discrecionalMateriaId,
                    discrecionalDocenteId: reserva.discrecionalDocenteId,
                    usuarioCreadorId: reserva.usuarioSolicitoId,
                    usuarioModificadorId: reserva.usuarioSolicitoId,
                },
            });
        }),
    );

    const reservasAbiertas = await prisma.$queryRawTyped(sql.selectReservaAbierta());

    await Promise.all(
        reservasAbiertas.map(async reserva => {
            const reservaCreada = await prisma.reserva.create({
                data: {
                    estatus: ReservaEstatus.FINALIZADA,
                    fechaHoraInicio: reserva.fechaHoraInicio ?? '',
                    fechaHoraFin: reserva.fechaHoraFin ?? '',
                    tipo: ReservaTipo.LABORATORIO_ABIERTO,
                    usuarioSolicitoId: reserva.usuarioSolicitoId ?? admin,
                    usuarioAprobadorId: reserva.usuarioAprobadorId,
                    fechaModificacion: new Date(),
                    usuarioCreadorId: reserva.usuarioSolicitoId ?? admin,
                    usuarioModificadorId: reserva.usuarioSolicitoId ?? admin,
                },
            });

            await prisma.reservaLaboratorioAbierto.create({
                data: {
                    especialidad: reserva.especialidad ?? '',
                    descripcion: reserva.descripcion ?? undefined,
                    concurrentes: reserva.concurrentes ?? 0,
                    laboratorioAbiertoTipo: reserva.tipo ?? LaboratorioAbiertoTipo.LA,
                    reservaId: reservaCreada.id,
                    sedeId: reserva.sedeId ?? medranoId,
                    laboratorioId: reserva.laboratorioId,
                    usuarioCreadorId: reserva.usuarioSolicitoId ?? admin,
                    usuarioModificadorId: reserva.usuarioSolicitoId ?? admin,
                },
            });
        }),
    );

    const reservasEquipos = await prisma.$queryRawTyped(sql.selectReservaEquipo());

    await Promise.all(
        reservasEquipos.map(async reserva => {
            const reservaCreada = await prisma.reserva.create({
                data: {
                    estatus: ReservaEstatus.FINALIZADA,
                    fechaHoraInicio: reserva.fechaHoraInicio ?? '',
                    fechaHoraFin: reserva.fechaHoraFin ?? '',
                    tipo: ReservaTipo.INVENTARIO,
                    usuarioSolicitoId: reserva.usuarioSolicitoId,
                    usuarioAprobadorId: reserva.usuarioAprobadorId,
                    usuarioRecibioId: reserva.usuarioRecibioId,
                    fechaRecibido: reserva.fechaRecibido ?? undefined,
                    usuarioRenovoId: reserva.usuarioRenovoId,
                    fechaRenovacion: reserva.fechaRenovacion ?? undefined,
                    fechaModificacion: new Date(),
                    usuarioCreadorId: reserva.usuarioSolicitoId,
                    usuarioModificadorId: reserva.usuarioSolicitoId,
                },
            });

            await prisma.reservaEquipo.create({
                data: {
                    fechaEntregado: reserva.fechaHoraInicio ?? '',
                    reservaId: reservaCreada.id,
                    equipoId: reserva.equipoId,
                    usuarioCreadorId: reserva.usuarioSolicitoId,
                    usuarioModificadorId: reserva.usuarioSolicitoId,
                },
            });
        }),
    );

    const reservasLibros = await prisma.$queryRawTyped(sql.selectReservaLibro());

    await Promise.all(
        reservasLibros.map(async reserva => {
            const reservaCreada = await prisma.reserva.create({
                data: {
                    estatus: ReservaEstatus.FINALIZADA,
                    fechaHoraInicio: reserva.fechaHoraInicio ?? '',
                    fechaHoraFin: reserva.fechaHoraFin ?? '',
                    tipo: ReservaTipo.LIBRO,
                    usuarioSolicitoId: reserva.usuarioSolicitoId,
                    usuarioAprobadorId: reserva.usuarioAprobadorId,
                    usuarioRecibioId: reserva.usuarioRecibioId,
                    fechaRecibido: reserva.fechaRecibido ?? undefined,
                    usuarioRenovoId: reserva.usuarioRenovoId,
                    fechaRenovacion: reserva.fechaRenovacion ?? undefined,
                    fechaModificacion: new Date(),
                    usuarioCreadorId: reserva.usuarioSolicitoId,
                    usuarioModificadorId: reserva.usuarioSolicitoId,
                },
            });

            await prisma.reservaLibro.create({
                data: {
                    fechaEntregado: reserva.fechaHoraInicio ?? '',
                    reservaId: reservaCreada.id,
                    libroId: reserva.libroId,
                    usuarioCreadorId: reserva.usuarioSolicitoId,
                    usuarioModificadorId: reserva.usuarioSolicitoId,
                },
            });
        }),
    );

    const permisos: {
        rubro: string;
        nombre: string;
        incluido: boolean;
        sgeNombre: SgeNombre;
        usuarioCreadorId: string;
        usuarioModificadorId: string;
    }[] = [];

    function readPermisosCsv() {
        return new Promise<void>((resolve, reject) => {
            fs.createReadStream('scripts/permisos.csv')
                .pipe(csv({ separator: ';', mapHeaders: ({ header }) => header.trim() }))
                .on('data', row => {
                    permisos.push({
                        ...row,
                        incluido: row.incluido === 'TRUE',
                        usuarioCreadorId: admin,
                        usuarioModificadorId: admin,
                    });
                })
                .on('end', () => resolve())
                .on('error', error => reject(error));
        });
    }

    const roles: Record<string, string[]> = {};

    function readRolesCsv() {
        return new Promise<void>((resolve, reject) => {
            fs.createReadStream('scripts/roles.csv')
                .pipe(csv({ separator: ';', mapHeaders: ({ header }) => header.trim() }))
                .on('data', row => {
                    if (!roles[row.rol]) roles[row.rol] = [];
                    roles[row.rol].push(row.permiso);
                })
                .on('end', () => resolve())
                .on('error', error => reject(error));
        });
    }

    try {
        await readPermisosCsv();
        await prisma.permiso.createMany({ data: permisos });
        await readRolesCsv();
        for (const [rol, permisos] of Object.entries(roles)) {
            await prisma.rol.create({
                data: {
                    nombre: rol,
                    RolPermiso: {
                        create: [
                            ...permisos.map(permiso => ({
                                usuarioCreadorId: admin,
                                Permiso: { connect: { sgeNombre: permiso as SgeNombre } },
                            })),
                        ],
                    },
                    UsuarioRol: {
                        create: {
                            userId: admin,
                            usuarioCreadorId: admin,
                        },
                    },
                    usuarioCreadorId: admin,
                    usuarioModificadorId: admin,
                },
            });
        }
        await prisma.$queryRawTyped(sql.insertUsuarioRol(admin));
    } catch (error) {
        console.error('Error processing CSV file:', error);
    }

    await prisma.$queryRawTyped(sql.updateLibro());
    await prisma.$queryRawTyped(sql.updateLibroAutor());
    await prisma.$queryRawTyped(sql.updateMateria());
    await prisma.$queryRawTyped(sql.updateEquipo());

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
