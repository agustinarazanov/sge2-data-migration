insert into "public"."Pais" ("iso", "nombreEspanol", "nombreIngles", "iso3", "codigoNumerico")
select distinct "iso", "es", "en", "iso3", "numcode"
from "old"."country";
