insert into "public"."Tutor" ("userId", "diasHorarios", "activo", "especialidad", "usuarioCreadorId")
select "usuario"."id", "t"."observaciones", ("t"."activo"::int)::boolean, case when "t"."especialidades" <> '' then replace("t"."especialidades", 'Ã¡', 'á') else 'Básica' end, $1
from "public"."User" "usuario"
join "old"."userdata" "u" on "usuario"."email" = "u"."email"
join "old"."lababierto_tutores" "t" on "u"."usuario_id" = "t"."userid";
