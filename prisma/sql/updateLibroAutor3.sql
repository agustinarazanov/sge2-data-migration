update "public"."LibroAutor" set "autorNombre" = replace("autorNombre", 'Ã­', 'í') where "autorNombre" like '%Ã­%';
