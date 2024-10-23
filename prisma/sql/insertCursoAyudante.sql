insert into "public"."CursoAyudante" ("cursoId", "userId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "curso"."id", "ayudante"."id", $1, $1
from generate_series(1, 5) "num"
cross join lateral (
    select "division_id", "profesor_userid"::int, split_part("ayudante_userid", ',', "num")::int "ayudante_id"
    from "old"."cursos"
    where "ayudante_userid" <> '' and split_part("ayudante_userid", ',', "num") <> ''
) "c"
join "old"."userdata" "u" on "u"."usuario_id" = "c"."ayudante_id"
join "old"."userdata" "u2" on "u2"."usuario_id" = "c"."profesor_userid"
join "old"."divisiones" "d" on "d"."division_id" = "c"."division_id"
join "public"."Division" "division" on "division"."nombre" = "d"."division"
join "public"."User" "ayudante" on "u"."email" = "ayudante"."email"
join "public"."User" "profesor" on "u2"."email" = "profesor"."email"
join "public"."Curso" "curso" on "curso"."divisionId" = "division"."id" and "curso"."profesorId" = "profesor"."id";
