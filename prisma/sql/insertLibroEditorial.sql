insert into "public"."LibroEditorial" ("editorial", "usuarioCreadorId")
select distinct "editorial", $1
from "old"."libros_editoriales";
