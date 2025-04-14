update "public"."LibroAutor"
set "autorNombre" = replace(
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
                                                replace("autorNombre", 'Ã¡', 'á'),
                                                'Ã©', 'é'
                                            ), 'Ã­', 'í'
                                        ), 'Juliï¿½n', 'Julián'
                                    ), 'Borï¿½sov', 'Borísov'
                                ), 'Ibaï¿½ez', 'Ibañez'
                            ), 'Shalï¿½mova', 'Shalímova'
                        ), 'Fiï¿½dorov', 'Fiódorov'
                    ), 'Brï¿½dov', 'Brédov'
                ), 'Rumiï¿½ntsev', 'Rumiántsev'
            ), 'Renï¿½', 'René'
        ), 'Gonzï¿½lez', 'González'
    ), 'Queï¿½', 'Que'
)
where "autorNombre" like '%Ã%'
or "autorNombre" like '%ï¿½%';
