select "usuario_id", "email"
from "old"."userdata"
left join "old"."cursos" on "usuario_id" = "profesor_userid"::int
where "email" like '%@frba.utn.edu.ar' or "curso_id" is not null
group by "usuario_id", "email";
