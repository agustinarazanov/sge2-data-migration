import { PrismaClient } from "@prisma/client";
import * as sql from "@prisma/client/sql";

const prisma = new PrismaClient();

async function main() {
    console.log("Comenzando migración...");

    await prisma.$queryRawTyped(sql.insertDocumentoTipo());
    await prisma.$queryRawTyped(sql.insertPais());
    await prisma.$queryRawTyped(sql.insertProvincia());

    const userdata = await prisma.userdata.findMany({
        select: { usuario_id: true, email: true },
        where: { email: { contains: "@frba.utn.edu.ar" } },
    });

    await prisma.user.createMany({ data: userdata.map((u) => ({ email: u.email })) });

    await prisma.$queryRawTyped(sql.updateUser());

    const admin =
        (
            await prisma.user.findFirst({
                select: { id: true },
                where: { email: userdata.find((u) => Number(u.usuario_id) === 3571)?.email },
            })
        )?.id ?? "";

    const ayudante =
        (
            await prisma.user.findFirst({
                select: { id: true },
                where: { email: userdata.find((u) => Number(u.usuario_id) === 3849)?.email },
            })
        )?.id ?? "";

    const alumno =
        (
            await prisma.user.create({
                data: {
                    email: "alumno@frba.utn.edu.ar",
                    nombre: "Alumno",
                    apellido: "Anónimo",
                    legajo: "123456",
                    name: "alumno",
                },
            })
        ).id ?? "";

    await prisma.$queryRawTyped(sql.insertSede());
    await prisma.$queryRawTyped(sql.insertLaboratorio(admin));
    await prisma.$queryRawTyped(sql.insertArmario(admin));
    await prisma.$queryRawTyped(sql.insertEstante(admin));

    await prisma.$queryRawTyped(sql.insertEquipoTipo(admin));
    await prisma.$queryRawTyped(sql.insertEquipoMarca(admin));
    await prisma.$queryRawTyped(sql.insertEquipoEstado(admin));
    await prisma.$queryRawTyped(sql.insertEquipo(admin));

    await prisma.$queryRawTyped(sql.insertLibroAutor(admin));
    await prisma.$queryRawTyped(sql.insertLibroIdioma(admin));
    await prisma.$queryRawTyped(sql.insertLibroEditorial(admin));
    await prisma.$queryRawTyped(sql.insertLibro(admin));

    await prisma.$queryRawTyped(sql.insertMateria(admin));
    await prisma.$queryRawTyped(sql.insertLibroMateria(admin));
    await prisma.$queryRawTyped(sql.insertMateriaCorrelativa(admin));

    await prisma.$queryRawTyped(sql.insertDivision(admin));
    await prisma.$queryRawTyped(sql.insertCurso(admin));
    await prisma.$queryRawTyped(sql.insertCursoProfesor(admin));
    await prisma.$queryRawTyped(sql.insertCursoAyudante(admin));

    await prisma.$queryRawTyped(sql.insertPermiso(admin));
    await prisma.$queryRawTyped(sql.insertRol(admin));
    await prisma.$queryRawTyped(sql.insertUsuarioRol(admin, ayudante, alumno));

    await prisma.$queryRawTyped(sql.insertRolPermisoAdministrador(admin));
    await prisma.$queryRawTyped(sql.insertRolPermisoDocente(admin));
    await prisma.$queryRawTyped(sql.insertRolPermisoAlumno(admin));
    await prisma.$queryRawTyped(sql.insertRolPermisoPanolero(admin));
    await prisma.$queryRawTyped(sql.insertRolPermisoSecretario(admin));

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

    console.log("Migración completa!");
    console.log("Verificando datos...");

    console.assert(await prisma.libro.count() === await prisma.libros.count());
    console.assert(await prisma.materia.count() === await prisma.materias.count());
    console.assert(await prisma.equipo.count() === await prisma.equipos.count());
    console.assert(await prisma.curso.count() === await prisma.cursos.count({ where: { horainicio: { not: null } } }));
    console.assert(await prisma.division.count() === await prisma.divisiones.count());

    console.log("Verificación completa!");
}

main()
    .then(async () => {
        await prisma.$disconnect();
    })
    .catch(async (e) => {
        console.error(e);
        await prisma.$disconnect();
        process.exit(1);
    });
