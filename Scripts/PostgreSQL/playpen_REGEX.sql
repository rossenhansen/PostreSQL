

select 'hello'::numeric as test;

SELECT '1.125' as value ,(regexp_matches('1.256','[0-9]+'))[1] as test ,(regexp_matches('1.256','[.]+'))[1] as test2 ,(regexp_matches('1.256','^[0-9]+$'))[1] as test3 

SELECT 'Hello' as value ,(regexp_matches('Hello','[0-9]+'))[1] as test ,(regexp_matches('Hello','[.]+'))[1] as test2

select case when 1.2356 = cast(1.2356 as integer) then true else false end as test


select '$128' as value ,(regex_matches('$128','\p{Currency_Symbol}+'))[1] as test

-- \p{Sc} or \p{Currency_Symbol}



select	 name_string ,names
		,array_length(names,1) as num_names
		,case when array_length(names,1) = 1 then null else names[1] end as first_name
		,case when array_length(names,1) > 2 then array_to_string(names[2:(array_length(names,1)-1)],' ') else null end as other_name   
		,names[array_length(names,1)] as last_name
--from  (	select regexp_split_to_array('Mark Rossen Hansen', E'\\s+') as names ) as name_array
from  (	select 'Mark' as name_string ,regexp_split_to_array('Mark', E'\\s+') as names union
		select 'Mark Hansen' as name_string ,regexp_split_to_array('Mark Hansen', E'\\s+') as names union
		select 'Mark Rossen Hansen' as name_string ,regexp_split_to_array('Mark Rossen Hansen', E'\\s+') as names union
		select 'David Mark Rossen Hansen' as name_string ,regexp_split_to_array('David Mark Rossen Hansen', E'\\s+') as names union
		select 'Mark.Hansen' as name_string ,regexp_split_to_array('Mark.Hansen', E'\\s+') as names union
		select 'Mark Rossen-Hansen' as name_string ,regexp_split_to_array('Mark Rossen-Hansen', E'\\s+') as names 
) as name_array;



