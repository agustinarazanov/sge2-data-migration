insert into "public"."UsuarioRol" ("userId", "rolId", "usuarioCreadorId")
select "userId", "rol"."id", $1
from "public"."Rol" "rol"
join "public"."Permiso" "permiso" on "rol"."nombre" = split_part("permiso"."nombre", 'grupo ', 2)
join "public"."UsuarioPermiso" "up" on "permiso"."id" = "up"."permisoId"
where "permiso"."nombre" like '%pertenece al grupo%';
