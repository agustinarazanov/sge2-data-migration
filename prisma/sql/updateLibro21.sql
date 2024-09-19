update "public"."Libro" set "titulo" = replace("titulo", 'ï¿½', 'í')
where "titulo" like '%eorï¿½a%';
