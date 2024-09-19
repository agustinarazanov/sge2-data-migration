update "public"."LibroAutor" set "autorNombre" = replace("autorNombre", 'Ã¡', 'á') where "autorNombre" like '%Ã¡%';
