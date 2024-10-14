select "usuario_id", "email", "atributo"
from "old"."userdata"
left join "old"."cursos" on "usuario_id" = "profesor_userid"::int
where ("email" like '%@frba.utn.edu.ar' or
    "curso_id" is not null) and
    "legajo" not in (
        select "legajo" from "old"."userdata"
        where "email" like '%frba.utn.edu.ar' and "legajo" ~ '\d' and "legajo" !~ '^0+$'
        group by "legajo" having count(*) > 1
    )
group by "usuario_id", "email";
