update "public"."User" "user" set
    "nombre" = "u"."nombre",
    "apellido" = "u"."apellido",
    "ciudad" = "u"."ciudad",
    "codigoPostal" = "u"."codigo_postal",
    "departamento" = "u"."depto",
    "direccion" = "u"."direccion",
    "fechaNacimiento" = case when "u"."date_nacimiento" < '1900-01-01' then null else "u"."date_nacimiento" end,
    "fechaRegistro" = "u"."date_registro",
    "fechaUltimaActualizacion" = coalesce("u"."date_ultima_actualizacion", now()),
    "fechaUltimoAcceso" = "u"."date_ultimo_acceso",
    "documentoNumero" = "u"."documento_numero",
    "gitlab" = "u"."gitlab",
    "legajo" = case when "u"."legajo" ~ '\d' and "u"."legajo" !~ '^0+$' then regexp_replace("u"."legajo", '\D', '', 'g') end,
    "piso" = "u"."piso",
    "telefonoCasa" = "u"."telefono_casa",
    "telefonoCelular" = "u"."telefono_celular",
    "telefonoLaboral" = "u"."telefono_laboral",
    "documentoTipoId" = "documento"."id",
    "provinciaIso" = "provincia"."iso",
    "paisIso" = "pais"."iso",
    "esTutor" = case when "t"."userid" is null then false else true end
from "old"."userdata" "u"
left join "old"."documento" "d" on "d"."documento_id" = "u"."documento_tipo"
left join "old"."lababierto_tutores" "t" on "u"."usuario_id" = "t"."userid"
left join "public"."DocumentoTipo" "documento" on "documento"."nombre" = "d"."documento"
left join "public"."Pais" "pais" on "nacionalidad" = "pais"."iso"
left join "public"."Provincia" "provincia" on "provincia" = "provincia"."iso" and "pais"."iso" = "provincia"."paisIso"
where "user"."email" = "u"."email";
