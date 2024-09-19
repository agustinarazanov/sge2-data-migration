update "public"."Equipo" set "observaciones" = replace("observaciones", 'Ã³', 'ó') where "observaciones" like '%Ã³%';
