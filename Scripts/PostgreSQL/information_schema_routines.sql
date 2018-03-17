/*
SELECT * --routines.routine_name, parameters.data_type, parameters.ordinal_position
FROM information_schema.routines
    LEFT JOIN information_schema.parameters ON routines.specific_name=parameters.specific_name
WHERE routines.specific_schema='Tutorial'
ORDER BY routines.routine_name, parameters.ordinal_position;
*/

select 	 routine_name 
		,routine_type
		,specific_schema
		,specific_catalog
		,schema_level_routine
		,sql_data_access
		,is_deterministic
		,parameter_style
		,external_language
		,routine_body
		,data_type
		,routine_definition
		--,string_to_array(routine_definition, text [, text])
		,string_to_array(routine_definition, '\n' )
		
from 	information_schema.routines
where	routines.specific_schema='Tutorial'
order by routines.specific_schema ,routines.routine_name

-- {
declare value numeric;
begin
    value = $1::numeric;
    return true;
exception when others then
    return false;
end;
}


/* 
declare value numeric;
begin
    value = $1::numeric;
    return true;
exception when others then
    return false;
end;
*/