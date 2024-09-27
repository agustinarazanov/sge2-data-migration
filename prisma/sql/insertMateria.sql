insert into "public"."Materia" ("nombre", "codigo", "anio", "duracion", "tipo", "directorUsuarioId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "materia", "codigo", "anio", upper("d"."duracion")::"MateriaDuracion", upper(t."tipo")::"MateriaTipo", "director"."id", $1, $1
from "old"."materias" "m"
join "old"."materias_duracion" "d" on "m"."duracion" = "d"."duracion_id"
join "old"."materias_tipo" "t" on "m"."tipo" = "t"."tipo_id"
left join "old"."userdata" "u" on case when "director_userid" = ',' then null else replace("m"."director_userid", ',', '')::int end = "u"."usuario_id"
left join "public"."User" "director" on "director"."email" = "u"."email";
