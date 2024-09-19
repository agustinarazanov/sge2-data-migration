insert into "public"."DocumentoTipo" ("nombre")
select distinct "documento"
from "old"."documento";
