insert into "public"."UsuarioRol" ("userId", "rolId", "usuarioCreadorId")
values
($1, 1, $1),
($2, 2, $1),
($3, 3, $1);
