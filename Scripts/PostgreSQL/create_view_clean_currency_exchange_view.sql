--CLEAN VIEW
--drop view clean_currency_exchange_view
--create view clean_currency_exchange_view as
select	 id as id_int
		,left(currency, 50) as currency_varchar50 
		,left(currency_code, 10) as currency_code_varchar10 
		,cast(local_to_aud as float) as local_to_aud_float  
		,cast(aud_to_local as float) as aud_to_local_float 
		,synched_at as synched_at_timestamp 

from	raw_currency_exchange
where 	clean_isnumeric_fn(local_to_aud) and clean_isnumeric_fn(aud_to_local)
  and	length(currency) <= 50 and length(currency_code) <= 10;

--VALIDATION VIEW
--drop view clean_currency_exchange_validation_check_view
--create view clean_currency_exchange_validation_check_view as 
select	 id
		,currency
		,local_to_aud
		,aud_to_local
		,currency_code
		,synched_at
		-- data validation flags
		,clean_isnumeric_fn(local_to_aud) as local_to_aud_isnumeric_flag 
		,clean_isnumeric_fn(aud_to_local) as aud_to_local_isnumeric_flag
		,clean_istruncated_fn(currency,'currency',50) as currency_length_check
		,clean_istruncated_fn(currency_code,'currency_code',10) as currency_code_length_check
from	raw_currency_exchange
where 	not clean_isnumeric_fn(local_to_aud) or not clean_isnumeric_fn(aud_to_local)
  or	length(currency) > 50 or length(currency_code) > 10;
