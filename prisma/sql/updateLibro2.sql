update "public"."Libro" set "titulo" = replace("titulo", 'Ã©', 'é') where "titulo" like '%Ã©%';
