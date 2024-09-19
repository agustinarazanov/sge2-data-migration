insert into "public"."LibroIdioma" ("idioma", "usuarioCreadorId")
select distinct "idioma", $1
from "old"."libros_idiomas";
