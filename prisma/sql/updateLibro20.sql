update "public"."Libro" set "titulo" = replace("titulo", 'ï¿½', 'ó')
where "titulo" like '%lectrï¿½nic%' or "titulo" like '%ntroducciï¿½n%' or "titulo" like '%ediciï¿½n%' or "titulo" like '%conmutaciï¿½n%';
