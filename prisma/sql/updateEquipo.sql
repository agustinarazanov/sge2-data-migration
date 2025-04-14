update "public"."Equipo"
set "observaciones" = replace(
    replace(
        "observaciones",
        'Ã³', 'ó'
    ), 'Ã­', 'í'
),
"palabrasClave" = replace("palabrasClave", 'Ã³', 'ó')
where "observaciones" like '%Ã­%'
or "palabrasClave" like '%Ã%';
