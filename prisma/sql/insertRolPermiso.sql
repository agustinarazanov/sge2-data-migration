insert into "RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select "rol"."id", "permiso"."id", $1
from "Permiso" "permiso", "Rol" "rol";
