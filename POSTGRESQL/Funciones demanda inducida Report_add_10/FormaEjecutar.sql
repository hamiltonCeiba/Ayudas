SELECT eph.*,epd.*,echlp.home,echlp.living_place  ,tb1000.q_9 ,
(SELECT name_module FROM ipshorisoes.eccnt_module WHERE id_module = ecid.id_module) ,
(SELECT string_agg(ecmq.name_module_question, ', ')name_module_question FROM ipshorisoes.eccnt_module_question ecmq INNER JOIN ipshorisoes.eccnt_module em ON ecmq.id_module = em.id_module WHERE ecmq.id_module_question = Any(ecid.id_module_question)),
(SELECT ipshorisoes.functioninduceddemand(ecid.id_module_question,ecid.id_person_historic,'ipshorisoes'))as answer 
FROM ipshorisoes.ecr_person_historic eph 
INNER JOIN ipshorisoes.es_person_data epd ON eph.id_person_data = epd.id_person_data 
INNER JOIN ipshorisoes.ec_home_living_place_per echlp ON echlp.id_person_historic = eph.id_person_historic   INNER JOIN ipshorisoes.ecr_module_charact_1 tb1000 ON eph.id_person_historic = tb1000.id_person_historic  FULL JOIN ipshorisoes.ec_induced_demand ecid ON ecid.id_person_historic = eph.id_person_historic WHERE eph.id_type_card = 1 AND (SELECT case when op.programs @> '{173}'::int[] then true else false end from (select conteo, id_person_historic,programs from  
(SELECT id_person_historic, count(id_module)as conteo, array_agg(id_module)as programs
from ipshorisoes.ec_induced_demand where id_person_historic = eph.id_person_historic
group by id_person_historic)as p) as op) 
		 and (case when ecid.id_module in(173) then true else false end) AND epd.id_administrator IN(1)  ;

--SELECT ipshorisoes.functioninduceddemandboolvec(2350,ipshorisoes.ecr_module_pe_dt_173,33604) as q_ecr_module_pe_dt_173
--select id_module_question  from ipshorisoes.eccnt_module_question where id_module_question = 2351;
--select * from ipshorisoes
--select * from ipshorisoes.ec_induced_demand
--SELECT * from ipshorisoes.functioninduceddemandmulvec(2351,'ipshorisoes.ecr_module_pe_dt_173',33604)
--SELECT * from ipshorisoes.functioninduceddemandboolvec(2350,'ipshorisoes.ecr_module_pe_dt_173',33604)