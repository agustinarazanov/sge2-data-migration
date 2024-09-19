update "public"."Materia" set "nombre" = replace("nombre", 'Ã­', 'í') where "nombre" like '%Ã­%';
