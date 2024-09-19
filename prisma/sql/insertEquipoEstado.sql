insert into "public"."EquipoEstado" ("nombre", "usuarioCreadorId")
select distinct "estado", $1
from "old"."equipos_estados";
