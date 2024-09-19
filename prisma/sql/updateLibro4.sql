update "public"."Libro" set "titulo" = replace("titulo", 'Ã±', 'ñ') where "titulo" like '%Ã±%';
