update "public"."Materia" set "nombre" = replace("nombre", 'Ã¡', 'á') where "nombre" like '%Ã¡%';
