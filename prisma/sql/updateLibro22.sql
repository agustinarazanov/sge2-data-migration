update "public"."Libro" set "titulo" = replace("titulo", 'ï¿½', 'é')
where "titulo" like '%ï¿½cnica%';
