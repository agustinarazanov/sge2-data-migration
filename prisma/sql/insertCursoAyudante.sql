insert into "public"."CursoAyudante" ("cursoId", "userId", "usuarioCreadorId", "usuarioModificadorId")
select "curso"."id", "usuario"."id", $1, $1
from generate_series(1, 5) "num"
cross join lateral (
    select "division_id", split_part("ayudante_userid", ',', "num")::int "ayudante_userid"
    from "old"."cursos"
    where split_part("ayudante_userid", ',', "num") <> ''
) "c"
join "old"."divisiones" "d" on "d"."division_id" = "c"."division_id"
join "old"."userdata" "u" on "c"."ayudante_userid" = "u"."usuario_id"
join "public"."Division" "division" on "division"."nombre" = "d"."division"
join "public"."Curso" "curso" on "division"."id" = "curso"."divisionId"
join "public"."User" "usuario" on "u"."email" = "usuario"."email";
