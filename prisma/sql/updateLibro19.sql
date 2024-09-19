update "public"."Libro" set "titulo" = replace("titulo", 'ï¿½', 'á')
where "titulo" like '%nï¿½lisis%' or "titulo" like '%dinï¿½mica%';
