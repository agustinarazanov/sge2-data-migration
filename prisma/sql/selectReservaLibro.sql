select
    "date_desde"::timestamp + interval '3 hour' as "fechaHoraInicio",
    "date_hasta"::timestamp + interval '3 hour' as "fechaHoraFin",
    "solicito"."id" as "usuarioSolicitoId",
    "aprobo"."id" as "usuarioAprobadorId",
    "recibio"."id" as "usuarioRecibioId",
    "r"."recibio_datetime" + interval '3 hour' as "fechaRecibido",
    "renovo"."id" as "usuarioRenovoId",
    "r"."renovo_datetime" + interval '3 hour' as "fechaRenovacion",
    "libro"."id" as "libroId"
from "old"."libros_prestamos" "r"
join "old"."libros" "l" on "r"."libro_id" = "l"."libro_id"
join "old"."userdata" "prestado_a" on "r"."prestado_a_userid" = "prestado_a"."usuario_id"
join "old"."userdata" "presto" on "r"."presto_userid" = "presto"."usuario_id"
left join "old"."userdata" "rec" on "r"."recibio_userid" = "rec"."usuario_id"
left join "old"."userdata" "ren" on "r"."renovo_userid" = "ren"."usuario_id"
join "public"."Libro" "libro" on "l"."inventario" = "libro"."inventarioId"
join "public"."User" "solicito" on "prestado_a"."email" = "solicito"."email"
join "public"."User" "aprobo" on "presto"."email" = "aprobo"."email"
left join "public"."User" "recibio" on "rec"."email" = "recibio"."email"
left join "public"."User" "renovo" on "ren"."email" = "renovo"."email";
