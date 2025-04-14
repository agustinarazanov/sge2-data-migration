select
    concat("r"."fecha"::text, ' ', "r"."hora_inicio", ':00')::timestamp + interval '3 hour' as "fechaHoraInicio",
    concat("r"."fecha"::text, ' ', "r"."hora_fin", ':00')::timestamp + interval '3 hour' as "fechaHoraFin",
    "solicito"."id" as "usuarioSolicitoId",
    "aprobo"."id" as "usuarioAprobadorId",
    "tutor"."id" as "usuarioTutorId",
    "r"."especialidad" as "especialidad",
    "r"."descripcion" as "descripcion",
    "r"."cant_personas" as "concurrentes",
    (case "r"."lababierto_tipo"
        when 1 then 'LA'
        when 2 then 'TLA_BASICA'
        when 3 then 'TLA'
    end)::"LaboratorioAbiertoTipo" as "tipo",
    "labo"."sedeId" as "sedeId",
    "labo"."id" as "laboratorioId"
from "old"."lababierto" "r"
join "old"."userdata" "u" on "r"."usuario_id" = "u"."usuario_id"
left join "old"."userdata" "asigno" on "r"."asigno_userid" = "asigno"."usuario_id"
left join "old"."userdata" "t" on "r"."asignado_tutor_id" = "t"."usuario_id"
left join "old"."laboratorios" "l" on "r"."laboratorio_id" = "l"."laboratorio_id"
join "public"."User" "solicito" on "u"."email" = "solicito"."email"
left join "public"."User" "aprobo" on "asigno"."email" = "aprobo"."id"
left join "public"."User" "tutor" on "t"."email" = "tutor"."email"
left join "public"."Laboratorio" "labo" on "l"."laboratorio" = "labo"."nombre"
where "r"."fecha" > '1900-01-01';
