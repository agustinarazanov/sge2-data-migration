update "public"."LibroAutor" set "autorNombre" = replace("autorNombre", 'Ã©', 'é') where "autorNombre" like '%Ã©%';
