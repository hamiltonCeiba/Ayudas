-- FUNCTION: ipshorisoes.functioninduceddemandboolvec(integer[], text, numeric)

-- DROP FUNCTION ipshorisoes.functioninduceddemandboolvec(integer[], text, numeric);

CREATE OR REPLACE FUNCTION ipshorisoes.functioninduceddemandboolvec(
	id_module_question numeric,
	tablename text,
	id_person_historic numeric)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
DECLARE
idd text;
idPH int;
idReturn text;
begin
   RAISE NOTICE '------------------ ';
         RAISE NOTICE 'id_module_question %',id_module_question;
		 RAISE NOTICE 'id_person_historic %',id_person_historic;
		 RAISE NOTICE 'table_name %',tableName;
   
    EXECUTE 'select q_'||cast(id_module_question as character varying)||' from '|| tableName||
    ' where id_person_historic = '||id_person_historic  into idd;
     if (idd is null) then 
        idd:=0;
        else idd:=idd;
    end if;   
	RAISE NOTICE 'result booleana %',idd; 
    return idd;
end;
$BODY$;

ALTER FUNCTION ipshorisoes.functioninduceddemandboolvec(integer[], text, numeric)
    OWNER TO postgres;
