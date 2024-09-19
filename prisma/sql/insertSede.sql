insert into "public"."Sede" ("nombre")
select distinct "sede"
from "old"."sedes";
