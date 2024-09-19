insert into "public"."CursoProfesor" ("cursoId", "userId", "usuarioCreadorId", "usuarioModificadorId")
select "curso"."id", "usuario"."id", $1, $1
from "old"."cursos" "c"
join "old"."divisiones" "d" on "d"."division_id" = "c"."division_id"
join "old"."userdata" "u" on "c"."profesor_userid"::int = "u"."usuario_id"
join "public"."Division" "division" on "division"."nombre" = "d"."division"
join "public"."Curso" "curso" on "division"."id" = "curso"."divisionId"
join "public"."User" "usuario" on "u"."email" = "usuario"."email";
