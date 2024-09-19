insert into "public"."EquipoMarca" ("nombre", "usuarioCreadorId")
select distinct "marca", $1
from "old"."equipos";
