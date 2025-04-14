select
    (case
        when "r"."cancelo_userid" is not null then 'CANCELADA'
        else 'FINALIZADA'
    end)::"ReservaEstatus" as "estatus",
    concat(
        "r"."fecha"::text,
        case
            case extract(dow from "r"."fecha")
                when 0 then 'DOMINGO'
                when 1 then 'LUNES'
                when 2 then 'MARTES'
                when 3 then 'MIERCOLES'
                when 4 then 'JUEVES'
                when 5 then 'VIERNES'
                when 6 then 'SABADO'
            end::"CursoDia"
        when "curso"."dia1" then
            case "curso"."turno"
            when 'MANANA' then
                case "curso"."horaInicio1"::int
                when 0 then ' 07:45:00'
                when 1 then ' 08:30:00'
                when 2 then ' 09:15:00'
                when 3 then ' 10:15:00'
                when 4 then ' 11:00:00'
                when 5 then ' 11:45:00'
                when 6 then ' 12:30:00'
                end
            when 'TARDE' then
                case "curso"."horaInicio1"::int
                when 0 then ' 13:30:00'
                when 1 then ' 14:15:00'
                when 2 then ' 15:00:00'
                when 3 then ' 16:00:00'
                when 4 then ' 16:45:00'
                when 5 then ' 17:30:00'
                when 6 then ' 18:15:00'
                end
            when 'NOCHE' then
                case "curso"."horaInicio1"::int
                when 0 then ' 18:15:00'
                when 1 then ' 19:00:00'
                when 2 then ' 19:45:00'
                when 3 then ' 20:45:00'
                when 4 then ' 21:30:00'
                when 5 then ' 22:15:00'
                end
            end
        when "curso"."dia2" then
            case "curso"."turno"
            when 'MANANA' then
                case "curso"."horaInicio2"::int
                when 0 then ' 07:45:00'
                when 1 then ' 08:30:00'
                when 2 then ' 09:15:00'
                when 3 then ' 10:15:00'
                when 4 then ' 11:00:00'
                when 5 then ' 11:45:00'
                when 6 then ' 12:30:00'
                end
            when 'TARDE' then
                case "curso"."horaInicio2"::int
                when 0 then ' 13:30:00'
                when 1 then ' 14:15:00'
                when 2 then ' 15:00:00'
                when 3 then ' 16:00:00'
                when 4 then ' 16:45:00'
                when 5 then ' 17:30:00'
                when 6 then ' 18:15:00'
                end
            when 'NOCHE' then
                case "curso"."horaInicio2"::int
                when 0 then ' 18:15:00'
                when 1 then ' 19:00:00'
                when 2 then ' 19:45:00'
                when 3 then ' 20:45:00'
                when 4 then ' 21:30:00'
                when 5 then ' 22:15:00'
                end
            end
        else
            case "curso"."turno"
            when 'MANANA' then ' 07:45:00'
            when 'TARDE' then ' 13:30:00'
            when 'NOCHE' then ' 18:15:00'
            end
        end
    )::timestamp + interval '3 hour' as "fechaHoraInicio",
    concat(
        "r"."fecha"::text,
        case
            case extract(dow from "r"."fecha")
                when 0 then 'DOMINGO'
                when 1 then 'LUNES'
                when 2 then 'MARTES'
                when 3 then 'MIERCOLES'
                when 4 then 'JUEVES'
                when 5 then 'VIERNES'
                when 6 then 'SABADO'
            end::"CursoDia"
        when "curso"."dia1" then
            case "curso"."turno"
            when 'MANANA' then
                case ("curso"."horaInicio1"::int - 1 + "curso"."duracion1"::int)
                when 0 then ' 08:30:00'
                when 1 then ' 09:15:00'
                when 2 then ' 10:00:00'
                when 3 then ' 11:00:00'
                when 4 then ' 11:45:00'
                when 5 then ' 12:30:00'
                when 6 then ' 13:15:00'
                end
            when 'TARDE' then
                case ("curso"."horaInicio1"::int - 1 + "curso"."duracion1"::int)
                when 0 then ' 14:15:00'
                when 1 then ' 15:00:00'
                when 2 then ' 15:45:00'
                when 3 then ' 16:45:00'
                when 4 then ' 17:30:00'
                when 5 then ' 18:15:00'
                when 6 then ' 19:00:00'
                end
            when 'NOCHE' then
                case ("curso"."horaInicio1"::int - 1 + "curso"."duracion1"::int)
                when 0 then ' 19:00:00'
                when 1 then ' 19:45:00'
                when 2 then ' 20:30:00'
                when 3 then ' 21:30:00'
                when 4 then ' 22:15:00'
                when 5 then ' 23:00:00'
                end
            end
        when "curso"."dia2" then
            case "curso"."turno"
            when 'MANANA' then
                case ("curso"."horaInicio2"::int - 1 + "curso"."duracion2"::int)
                when 0 then ' 08:30:00'
                when 1 then ' 09:15:00'
                when 2 then ' 10:00:00'
                when 3 then ' 11:00:00'
                when 4 then ' 11:45:00'
                when 5 then ' 12:30:00'
                when 6 then ' 13:15:00'
                end
            when 'TARDE' then
                case ("curso"."horaInicio2"::int - 1 + "curso"."duracion2"::int)
                when 0 then ' 14:15:00'
                when 1 then ' 15:00:00'
                when 2 then ' 15:45:00'
                when 3 then ' 16:45:00'
                when 4 then ' 17:30:00'
                when 5 then ' 18:15:00'
                when 6 then ' 19:00:00'
                end
            when 'NOCHE' then
                case ("curso"."horaInicio2"::int - 1 + "curso"."duracion2"::int)
                when 0 then ' 19:00:00'
                when 1 then ' 19:45:00'
                when 2 then ' 20:30:00'
                when 3 then ' 21:30:00'
                when 4 then ' 22:15:00'
                when 5 then ' 23:00:00'
                end
            end
        else
            case "curso"."turno"
            when 'MANANA' then ' 13:15:00'
            when 'TARDE' then ' 19:00:00'
            when 'NOCHE' then ' 23:00:00'
            end
        end
    )::timestamp + interval '3 hour' as "fechaHoraFin",
    "solicito"."id" as "usuarioSolicitoId",
    "aprobo"."id" as "usuarioAprobadorId",
    "r"."observaciones" as "descripcion",
    ("r"."necesita_pc"::int)::boolean as "requierePC",
    ("r"."necesita_proyector"::int)::boolean as "requiereProyector",
    "curso"."sedeId" as "sedeId",
    "labo"."id" as "laboratorioId",
    "curso"."id" as "cursoId",
    ("r"."fuera_de_cursada"::int)::boolean as "esDiscrecional",
    case when "r"."fuera_de_cursada" = 1 then "curso"."materiaId" end as "discrecionalMateriaId",
    case when "r"."fuera_de_cursada" = 1 then "curso"."profesorId" end as "discrecionalDocenteId"
from "old"."laboratorios_reservas" "r"
join "old"."cursos" "c" on "r"."curso_id" = "c"."curso_id"
join "old"."divisiones" "d" on "c"."division_id" = "d"."division_id"
join "old"."materias" "m" on "c"."materia_id" = "m"."materia_id"
join "old"."userdata" "p" on "c"."profesor_userid"::int = "p"."usuario_id"
left join "old"."laboratorios" "l" on "r"."laboratorio_id" = "l"."laboratorio_id"
join "old"."userdata" "reservo" on "r"."reservo_userid" = "reservo"."usuario_id"
left join "old"."userdata" "asigno" on "r"."asignolab_userid" = "asigno"."usuario_id"
join "public"."Division" "division" on "division"."nombre" = "d"."division"
join "public"."Materia" "materia" on "m"."codigo" = "materia"."codigo"
join "public"."User" "profesor" on "p"."email" = "profesor"."email"
join "public"."Curso" "curso" on "curso"."profesorId" = "profesor"."id"
    and "curso"."materiaId" = "materia"."id"
    and "curso"."divisionId" = "division"."id"
    and "c"."duracion" = "curso"."duracion1"
join "public"."User" "solicito" on "reservo"."email" = "solicito"."email"
left join "public"."User" "aprobo" on "asigno"."email" = "aprobo"."email"
left join "public"."Laboratorio" "labo" on "l"."laboratorio" = "labo"."nombre"
where "c"."division_id" is not null and "r"."fecha" > '1900-01-01';
