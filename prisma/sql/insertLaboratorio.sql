insert into "public"."Laboratorio" ("nombre", "tienePc", "esReservable", "incluirEnReporte", "sedeId", "usuarioCreadorId", "usuarioModificadorId")
select distinct 
    "laboratorio",
    ("tiene_pc"::int)::boolean,
    ("para_reservas"::int)::boolean,
    case 
        when "laboratorio" in ('LAB061', 'LAB062', 'LAB063', 'LAB064', 'LAB101', 'LAB104', 'LAB105', 'LAB108', 'LAB109', 'LAB110')
        then true 
        else false 
    end,
    "sede"."id",
    $1,
    $1
from "old"."laboratorios" "l"
join "old"."sedes" "s" on "l"."sede_id" = "s"."sede_id"
join "public"."Sede" "sede" on "s"."sede" = "sede"."nombre";
