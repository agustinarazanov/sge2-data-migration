update "public"."Materia" set "nombre" = replace("nombre", 'Ã³', 'ó') where "nombre" like '%Ã³%';
