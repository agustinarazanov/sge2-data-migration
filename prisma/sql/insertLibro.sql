insert into "public"."Libro" ("bibliotecaId", "inventarioId", "titulo", "anio", "isbn", "laboratorioId", "armarioId", "estanteId", "autorId", "idiomaId", "editorialId", "sedeId", "usuarioCreadorId", "usuarioModificadorId")
select distinct "biblioteca_id", "inventario", "titulo", "anio"::int, "isbn", "labo"."id", "armario"."id", "estante"."id", "autor"."id", "idioma"."id", "editorial"."id", "sede"."id", $1, $1
from "old"."libros" "l"
join "old"."libros_idiomas" "li" on "l"."idioma_id" = "li"."idioma_id"
join "old"."libros_editoriales" "le" on "l"."editorial_id" = "le"."editorial_id"
join "old"."laboratorios" "la" on "l"."laboratorio_id" = "la"."laboratorio_id"
join "old"."armarios" "a" on "l"."armario_id" = "a"."armario_id" and "a"."laboratorio_id" = "la"."laboratorio_id"
join "old"."estantes" "e" on "l"."estante_id" = "e"."estante_id" and "e"."armario_id" = "a"."armario_id"
join "public"."LibroIdioma" "idioma" on "li"."idioma" = "idioma"."idioma"
join "public"."LibroEditorial" "editorial" on "le"."editorial" = "editorial"."editorial"
join "public"."Laboratorio" "labo" on "la"."laboratorio" = "labo"."nombre"
join "public"."Armario" "armario" on "a"."armario" = "armario"."nombre" and "armario"."laboratorioId" = "labo"."id"
join "public"."Estante" "estante" on e."estante" = "estante"."nombre" and "estante"."armarioId" = "armario"."id"
join "public"."Sede" "sede" on "labo"."sedeId" = "sede"."id"
join "public"."LibroAutor" "autor" on "l"."autor" = "autor"."autorNombre";
