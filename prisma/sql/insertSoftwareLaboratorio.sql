insert into "public"."SoftwareLaboratorio"("softwareId", "laboratorioId", "usuarioCreadorId")
select "software"."id", "labo"."id", $1
from generate_series(1, 10) "num"
cross join lateral (
    select "programa", split_part("laboratorios", ',', "num")::int "laboratorio_id"
    from "old"."laboratorios_aplicaciones"
    where split_part("laboratorios", ',', "num") <> ''
) "t"
join "old"."laboratorios" "l" on "l"."laboratorio_id" = "t"."laboratorio_id"
join "public"."Laboratorio" "labo" on "labo"."nombre" = "l"."laboratorio"
join "public"."Software" "software" on "software"."nombre" = "t"."programa";
