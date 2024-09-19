insert into "public"."MateriaCorrelativa" ("materiaPrerequisitoId", "correlativaId", "estatusCorrelativa", "usuarioCreadorId", "usuarioModificadorId")
select distinct "materia"."id", "correlativa"."id", "corr"."estatus", $1, $1
from (
    select "estatus", "correlativa", "materia_id"
    from generate_series(1, 10) "num"
    cross join lateral (
        select 'CURSAR_REGULARIZADA'::"EstatusCorrelativa" "estatus", split_part("cursar_regularizadas", ',', "num") "correlativa", "materia_id"
        from "old"."correlativas"
        where split_part("cursar_regularizadas", ',', "num") <> ''
    ) "cursar_regularizadas"
    union
    select "estatus", "correlativa", "materia_id"
    from generate_series(1, 10) "num"
    cross join lateral (
        select 'CURSAR_APROBADA'::"EstatusCorrelativa" "estatus", split_part("cursar_aprobadas", ',', "num") "correlativa", "materia_id"
        from "old"."correlativas"
        where split_part("cursar_aprobadas", ',', "num") <> ''
    ) "cursar_aprobadas"
    union
    select "estatus", "correlativa", "materia_id"
    from generate_series(1, 10) "num"
    cross join lateral (
        select 'RENDIR_APROBADA'::"EstatusCorrelativa" "estatus", split_part("rendir_aprobadas", ',', "num") "correlativa", "materia_id"
        from "old"."correlativas"
        where split_part("rendir_aprobadas", ',', "num") <> ''
    ) "rendir_aprobadas"
) "corr"
join "old"."materias" "m" on "corr"."materia_id" = "m"."materia_id"
join "old"."materias" "c" on "corr"."correlativa"::int = "c"."materia_id"
join "public"."Materia" "materia" on "m"."codigo" = "materia"."codigo"
join "public"."Materia" "correlativa" on "c"."codigo" = "correlativa"."codigo";
