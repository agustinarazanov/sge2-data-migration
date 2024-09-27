insert into "public"."MateriaJefeTp" ("materiaId", "jefeTrabajoPracticoUsuarioId")
select distinct "materia"."id", "usuario"."id"
from generate_series(1,3) "num"
cross join lateral (
    select "codigo", split_part("jtp_userid", ',', "num")::int "jtp_id"
    from "old"."materias"
    where "jtp_userid" <> ',' and split_part("jtp_userid", ',', "num") <> ''
) "t"
join "old"."userdata" "u" on "u"."usuario_id" = "t"."jtp_id"
join "public"."Materia" "materia" on "materia"."codigo" = "t"."codigo"
join "public"."User" "usuario" on "usuario"."email" = "u"."email";
