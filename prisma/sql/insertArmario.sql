insert into "public"."Armario" ("nombre", "laboratorioId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "armario", "labo"."id", $1, $1
from "old"."armarios" "a"
join "old"."laboratorios" "l" on "a"."laboratorio_id" = "l"."laboratorio_id"
join "public"."Laboratorio" "labo" on "l"."laboratorio" = "labo"."nombre";
