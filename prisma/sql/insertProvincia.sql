insert into "public"."Provincia" ("iso", "nombre", "paisIso")
select distinct "pr"."iso31662id", "pr"."name", "pr"."country"
from "old"."provinces" "pr"
join "public"."Pais" "pa" on "pr"."country" = "pa"."iso";
