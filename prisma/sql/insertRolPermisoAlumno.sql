insert into "public"."RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select 3, "id", $1
from "public"."Permiso"
where "nombre" like 'Actividades%' or "nombre" like 'Laboratorio abierto%'
limit 5;
