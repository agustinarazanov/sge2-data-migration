update "public"."User" "user" set
    "esDocente" = true
from "public"."Curso" "curso"
left join "public"."CursoAyudante" "ca" on "curso"."id" = "ca"."cursoId"
where "curso"."profesorId" = "user"."id" or "ca"."userId" = "user"."id";
