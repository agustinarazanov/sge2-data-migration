insert into "public"."Division" ("nombre", "anio", "usuarioCreadorId")
select distinct "division", "anio", $1
from "old"."divisiones";
