insert into "public"."RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select 5, "id", $1
from "public"."Permiso"
where "nombre" like 'Cursos%' or "nombre" like 'Divisiones%'
limit 5;
