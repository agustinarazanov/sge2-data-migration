insert into "public"."Equipo" ("inventarioId", "modelo", "numeroSerie", "observaciones", "palabrasClave", "imagen", "tipoId", "marcaId", "sedeId", "laboratorioId", "armarioId", "estanteId", "estadoId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "inventario", "modelo", "numeroserie", "observaciones", "palabras_claves", "imagen_path", "tipo"."id", "marca"."id", "sede"."id", "labo"."id", "armario"."id", "estante"."id", "estado"."id", $1, $1
from "old"."equipos" "e"
left join "old"."equipos_tipos" "et" on "e"."tipo_id" = "et"."tipo_id"
left join "old"."sedes" "s" on "e"."sede_id" = "s"."sede_id"
left join "old"."laboratorios" "l" on "e"."laboratorio_id" = "l"."laboratorio_id" and "e"."sede_id" = "l"."sede_id"
left join "old"."armarios" "a" on "e"."armario_id" = "a"."armario_id" and "e"."laboratorio_id" = "a"."laboratorio_id"
left join "old"."estantes" "es" on "e"."estante_id" = "es"."estante_id" and "e"."armario_id" = "e"."armario_id"
left join "old"."equipos_estados" "ee" on "e"."estado_id" = "ee"."estado_id"
left join "public"."EquipoTipo" "tipo" on "et"."tipo" = "tipo"."nombre"
left join "public"."Sede" "sede" on "s"."sede" = "sede"."nombre"
left join "public"."Laboratorio" "labo" on "l"."laboratorio" = "labo"."nombre"
left join "public"."Armario" "armario" on "a"."armario" = "armario"."nombre" and "armario"."laboratorioId" = "labo"."id"
left join "public"."Estante" "estante" on "es"."estante" = "estante"."nombre" and "estante"."armarioId" = "armario"."id"
left join "public"."EquipoEstado" "estado" on "ee"."estado" = "estado"."nombre"
left join "public"."EquipoMarca" "marca" on "e"."marca" = "marca"."nombre";
