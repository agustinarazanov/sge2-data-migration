update "public"."Equipo" set "palabrasClave" = replace("palabrasClave", 'Ã³', 'ó') where "palabrasClave" like '%Ã³%';
