insert into "public"."RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select 4, "id", $1
from "public"."Permiso"
where "nombre" like 'Biblioteca%' or "nombre" like 'Equipo%' or "nombre" like '%falla%'
limit 5;
