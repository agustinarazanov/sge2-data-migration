insert into "RolPermiso" ("rolId", "permisoId", "usuarioCreadorId")
select distinct "rol"."rolId", "permiso"."permisoId", $1
from "UsuarioRol" "rol"
join "UsuarioPermiso" "permiso" on "rol"."userId" = "permiso"."userId";
