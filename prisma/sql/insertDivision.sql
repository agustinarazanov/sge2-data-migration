insert into "public"."Division" ("nombre", "anio", "usuarioCreadorId", "usuarioModificadorId")
select distinct "division", "anio", $1, $1
from "old"."divisiones";
