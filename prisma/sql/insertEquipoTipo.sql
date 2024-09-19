insert into "public"."EquipoTipo" ("nombre", "usuarioCreadorId")
select distinct "tipo", $1
from "old"."equipos_tipos";
