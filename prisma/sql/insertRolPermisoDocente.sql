insert into "public"."RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select 2, "id", $1
from "public"."Permiso"
where "nombre" like '%aboratorio%' or "nombre" like 'Cursos%'
limit 5;
