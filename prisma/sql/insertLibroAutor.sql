insert into "public"."LibroAutor" ("autorNombre", "usuarioCreadorId")
select distinct "autor", $1
from "old"."libros";
