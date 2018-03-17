--create materialized view clean_raw_client_customer as 

select	 distinct 
		 client
		
from 	raw_client_customer