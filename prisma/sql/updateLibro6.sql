update "public"."Libro" set "titulo" = replace("titulo", 'Ã¬', 'í') where "titulo" like '%Ã¬%';
