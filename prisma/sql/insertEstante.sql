insert into "public"."Estante" ("nombre", "armarioId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "estante", "armario"."id", $1, $1
from "old"."estantes" "e"
join "old"."armarios" "a" on "e"."armario_id" = a."armario_id"
join "old"."laboratorios" "l" on "a"."laboratorio_id" = "l"."laboratorio_id"
join "public"."Laboratorio" "labo" on "l"."laboratorio" = "labo"."nombre"
join "public"."Armario" "armario" on "labo"."id" = "armario"."laboratorioId" and "armario"."nombre" = "a"."armario";
