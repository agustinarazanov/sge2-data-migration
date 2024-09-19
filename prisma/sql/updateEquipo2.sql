update "public"."Equipo" set "observaciones" = replace("observaciones", 'Ã­', 'í') where "observaciones" like '%Ã­%';
