insert into "public"."Software" ("nombre", "version", "estado", "usuarioCreadorId", "usuarioModificadorId")
select "programa", "version", "estado", $1, $1
from "old"."laboratorios_aplicaciones";
