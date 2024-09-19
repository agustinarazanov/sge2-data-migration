update "public"."Materia" set "nombre" = replace("nombre", 'Ã©', 'é') where "nombre" like '%Ã©%';
