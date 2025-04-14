update "public"."Libro"
set "titulo" = replace(
    replace(
        replace(
            replace(
                replace(
                    replace(
                        replace(
                            replace(
                                replace(
                                    replace(
                                        replace(
                                            replace(
                                                replace(
                                                    replace(
                                                        replace(
                                                            replace(
                                                                replace(
                                                                    replace(
                                                                        replace(
                                                                            replace(
                                                                                replace(
                                                                                    replace(
                                                                                        replace(
                                                                                            replace("titulo", 'Ã¡', 'á'),
                                                                                            'Ã©', 'é'
                                                                                        ), 'Ã±', 'ñ'
                                                                                    ), 'Ã³', 'ó'
                                                                                ), 'Ã¬', 'í'
                                                                            ), 'Ã­', 'í'
                                                                        ), 'rï¿½a', 'ría'
                                                                    ), 'lectrï¿½nic', 'lectrónic'
                                                                ), 'Sï¿½lido', 'Sólido'
                                                            ), 'nï¿½lisis', 'nálisis'
                                                        ), 'gï¿½a', 'gía'
                                                    ), 'Electromagnï¿½tica', 'Electromagnética'
                                                ), 'Automï¿½tico', 'Automático'
                                            ), 'Seï¿½ales', 'Señales'
                                        ), 'radiotï¿½cnicos', 'radiotécnicos'
                                    ), 'ciï¿½n', 'ción'
                                ), 'Elï¿½ctrica', 'Eléctrica'
                            ), 'Diseï¿½o', 'Diseño'
                        ), 'designerÂ´s', 'designer''s'
                    ), 'dinï¿½mica', 'dinámica'
                ), 'tï¿½cnica', 'técnica'
            ), 'amateurï¿½s', 'amateur''s'
        ), 'Informï¿½tica', 'Informática'
    ), 'clï¿½sica', 'clásica'
)
where "titulo" like '%Ã%'
or "titulo" like '%Â´%'
or "titulo" like '%ï¿½%';
