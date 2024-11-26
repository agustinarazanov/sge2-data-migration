insert into "public"."UsuarioRol" ("userId", "rolId", "usuarioCreadorId")
select "u"."id", "r"."id", $1
from "User" "u"
join "Rol" "r" on "r"."nombre" = case when "u"."esDocente" or "u"."esTutor" then 'Docente' else 'Alumno' end
where "u"."id" <> $1;
