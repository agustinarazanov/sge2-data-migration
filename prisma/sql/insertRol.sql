insert into "public"."Rol" ("nombre", "usuarioCreadorId", "usuarioModificadorId")
values
('Administrador', $1, $1),
('Docente', $1, $1),
('Alumno', $1, $1),
('Pañolero', $1, $1),
('Secretario', $1, $1),
('Consejero', $1, $1),
('Tutor', $1, $1);
