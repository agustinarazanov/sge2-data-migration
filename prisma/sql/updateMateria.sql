update "public"."Materia"
set "nombre" = replace(
                  replace(
                    replace(
                      replace(
                        replace("nombre", 'Ã¡', 'á'),
                      'Ã©', 'é'),
                    'Ã³', 'ó'),
                  'Ã±', 'ñ'),
                'Ã­', 'í')
where "nombre" like '%Ã%';
