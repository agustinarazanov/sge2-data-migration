update "public"."Libro" set "titulo" = replace("titulo", 'Ã¡', 'á') where "titulo" like '%Ã¡%';
