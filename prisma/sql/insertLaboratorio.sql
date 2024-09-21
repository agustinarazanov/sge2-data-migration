insert into "public"."Laboratorio" ("nombre", "tienePc", "esReservable", "sedeId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "laboratorio", ("tiene_pc"::int)::boolean, ("para_reservas"::int)::boolean, "sede"."id", $1, $1
from "old"."laboratorios" "l"
join "old"."sedes" "s" on "l"."sede_id" = "s"."sede_id"
join "public"."Sede" "sede" on "s"."sede" = "sede"."nombre";
