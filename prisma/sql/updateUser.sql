update "public"."User" "user" set
    "nombre" = "u"."nombre",
    "apellido" = "u"."apellido",
    "name" = split_part("u"."email",  '@', 1),
    "ciudad" = "u"."nacionalidad",
    "codigoPostal" = "u"."codigo_postal",
    "departamento" = "u"."depto",
    "direccion" = "u"."direccion",
    "fechaNacimiento" = "u"."date_nacimiento",
    "fechaRegistro" = "u"."date_registro",
    "fechaUltimaActualizacion" = coalesce("u"."date_ultima_actualizacion", now()),
    "fechaUltimoAcceso" = "u"."date_ultimo_acceso",
    "documentoNumero" = "u"."documento_numero",
    "gitlab" = "u"."gitlab",
    "legajo" = "u"."legajo",
    "piso" = "u"."piso",
    "sexo" = ("u"."sexo"::int)::boolean,
    "telefonoCasa" = "u"."telefono_casa",
    "telefonoCelular" = "u"."telefono_celular",
    "telefonoLaboral" = "u"."telefono_laboral",
    "documentoTipoId" = "documento"."id",
    "provinciaIso" = "provincia"."iso",
    "paisIso" = "pais"."iso"
from "old"."userdata" "u"
left join "old"."documento" "d" on "d"."documento_id" = "u"."documento_tipo"
left join "public"."DocumentoTipo" "documento" on "documento"."nombre" = "d"."documento"
left join "public"."Pais" "pais" on "nacionalidad" = "pais"."iso"
left join "public"."Provincia" "provincia" on "provincia" = "provincia"."iso" and "pais"."iso" = "provincia"."paisIso"
where "user"."email" = "u"."email";
