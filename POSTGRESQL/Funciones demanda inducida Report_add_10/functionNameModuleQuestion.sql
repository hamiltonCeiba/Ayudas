CREATE OR REPLACE FUNCTION ipshorisoes.functionNameModuleQuestion(
	id_module_question integer[],
	schema_table text)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
DECLARE
cont int := 1;
idReturn text;
resp text :='';
begin
schema_table = concat(schema_table,'.');
    loop
		RAISE NOTICE 'schema %',schema_table;
		EXECUTE 'SELECT ecmq.name_module_question FROM ' || schema_table ||'eccnt_module_question ecmq INNER JOIN '|| schema_table ||'eccnt_module em ON ecmq.id_module = em.id_module WHERE ecmq.id_module_question = '|| id_module_question[cont] INTO resp;		
		idReturn := concat(idReturn,'|',resp);
		cont :=cont+1;
    EXIT WHEN cont = array_length(id_module_question,1)+1;
   END LOOP;
   idReturn := regexp_replace(idReturn, '\|', '');
  	RAISE NOTICE 'respuesta %',idReturn;
    return idReturn;	
end;
$BODY$;