insert into "public"."Materia" ("nombre", "codigo", "anio", "duracion", "tipo", "directorUsuarioId", "jefeTrabajoPracticoUsuarioId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "materia", "codigo", "anio", upper("d"."duracion")::"MateriaDuracion", upper(t."tipo")::"MateriaTipo", $1, $1, $1, $1
from "old"."materias" "m"
join "old"."materias_duracion" "d" on "m"."duracion" = "d"."duracion_id"
join "old"."materias_tipo" "t" on "m"."tipo" = "t"."tipo_id";
