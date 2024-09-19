update "public"."Libro" set "titulo" = replace("titulo", 'ï¿½', '''')
where "titulo" like '%amateurï¿½s%';
