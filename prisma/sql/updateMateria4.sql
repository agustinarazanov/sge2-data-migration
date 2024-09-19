update "public"."Materia" set "nombre" = replace("nombre", 'Ã±', 'ñ') where "nombre" like '%Ã±%';
