insert into "public"."RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select 1, "id", $1
from "public"."Permiso"
limit 5;
