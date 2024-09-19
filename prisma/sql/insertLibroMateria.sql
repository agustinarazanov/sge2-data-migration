insert into "public"."LibroMateria" ("libroId", "materiaId", "usuarioCreadorId")
select distinct "libro"."id", "materia"."id", $1
from generate_series(1, 10) "num"
cross join lateral (
    select "libro_id", split_part("materias", ',', "num")::int "materia_id"
    from "old"."libros"
    where split_part("materias", ',', "num") <> ''
) "t"
join "old"."libros" "l" on "t"."libro_id" = "l"."libro_id"
join "old"."materias" "m" on "t"."materia_id" = "m"."materia_id"
join "public"."Materia" "materia" on "m"."codigo" = "materia"."codigo"
join "public"."Libro" "libro" on "l"."titulo" = "libro"."titulo" and "l"."isbn" = "libro"."isbn";
