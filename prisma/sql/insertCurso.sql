insert into "public"."Curso" ("horaInicio1", "duracion1", "horaInicio2", "duracion2", "dia1", "dia2", "anioDeCarrera", "activo", "ac", "sedeId", "materiaId", "divisionId", "turno", "profesorId", "usuarioCreadorId", "usuarioModificadorId")
select "horainicio", "c"."duracion", nullif("horainicio2", ''), nullif("duracion2", ''), upper(replace(replace("dia1"."dia", 'é', 'e'), 'á', 'a'))::"CursoDia", upper(replace(replace(nullif("dia2"."dia", ''), 'é', 'e'), 'á', 'a'))::"CursoDia", "c"."anio", ("activo"::int)::boolean, "AC", "sede"."id", "materia"."id", "division"."id", upper(replace("turno", 'ñ', 'n'))::"TurnoCurso", "user"."id", $1, $1
from "old"."cursos" "c"
join "old"."userdata" "u" on "u"."usuario_id" = "c"."profesor_userid"::int
join "old"."sedes" "s" on "c"."sede_id" = "s"."sede_id"
join "old"."materias" "m" on "c"."materia_id" = "m"."materia_id"
join "old"."divisiones" "d" on "c"."division_id" = "d"."division_id"
join "old"."cursos_turno" "t" on "c"."turno_id" = "t"."turno_id"
join "old"."dias" "dia1" on "c"."dia" = "dia1"."dia_id"
left join "old"."dias" "dia2" on "c"."dia2" = "dia2"."dia_id"
join "public"."Sede" "sede" on "s"."sede" = "sede"."nombre"
join "public"."Materia" "materia" on "m"."codigo" = "materia"."codigo"
join "public"."Division" "division" on "d"."division" = "division"."nombre"
join "public"."User" "user" on "user"."email" = "u"."email";
