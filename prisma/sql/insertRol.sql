insert into "public"."Rol" ("nombre", "usuarioCreadorId", "usuarioModificadorId")
select split_part("nombre", 'grupo ', 2), $1, $1
from "public"."Permiso"
where "nombre" like '%pertenece al grupo%';
