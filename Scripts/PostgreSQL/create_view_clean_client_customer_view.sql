--CLEAN VIEW client
--drop view clean_client_view
--create view clean_client_view as
select	 id
		,client as client_varchar
		,address1 as address1
		,address2 as address2 
		,address3 as address3
		,city as city
		,state as state
		,zipcode as zipcode
		,country as country
		,primary_location as primary_location_boolean
		,phone as phone_varchar50
		,fax as fax_
		,currency as currency
		,primary_currency as primary_currency_boolean
		,contact as contact_varchar765
		,primary_contact as primary_contact_boolean
		,direct_phone as direct_phone_varchar50
		,mobile as mobile_varchar50
		,email as email_varchar500
		,synched_at as synched_at_timestamp
		,client_id as client_id_int
		,location_id as location_id_int
		,contact_id as contact_id_int
from 	raw_client_customer
where not (
		length(contact) > 765
 or		length(email) > 255
 or		length(address1) > 255
 or		(length(address2) + length(address3)) > 510 
 or		length(city) > 100
 or		length(state) > 50
 or		length(zipcode) > 10
 or		length(country) > 50
 --or		not clean_isboolean_fn(coalesce(primary_location,'1')) 
 or		length(phone) > 50
 or		length(fax) > 50
 or		length(currency) > 10
 --or		not clean_isboolean_fn(coalesce(primary_currency,'1')) 
 or		length(contact) > 765
 --or		not clean_isboolean_fn(coalesce(primary_contact,'1')) 
 or		length(direct_phone) > 50 
 or		length(mobile) > 50
 or		length(email) > 510
 --or 	email_count > 1
 );

--VALIDATION VIEW client contact
--drop view clean_raw_client_customer_view
--create view clean_client_contact_validation_check_view as
select	 id
		,client
		,address1
		,address2
		,address3
		,city
		,state
		,zipcode
		,country
		,primary_location
		,phone
		,fax
		,currency
		,primary_currency
		,contact
		,primary_contact
		,direct_phone
		,mobile
		,email
		,synched_at
		,client_id
		,location_id
		,contact_id
		--data validation		
		,clean_istruncated_fn(address1,'address1',255) as address1_length_check
		,clean_istruncated_fn(address2 || address3,'address2_address3',510) as address2_address3_length_check
		,clean_istruncated_fn(city,'city',100) as city_length_check
		,clean_istruncated_fn(state,'state',50) as state_length_check
		,clean_istruncated_fn(zipcode,'zipcode',10) as zipcode_length_check
		,clean_istruncated_fn(country,'country',50) as country_length_check
		,clean_isboolean_fn(coalesce(primary_location,'1')) as primary_location_isboolean_flag
		,clean_istruncated_fn(phone,'phone',50) as _length_check
		,clean_istruncated_fn(fax,'fax',50) as fax_length_check
		,clean_istruncated_fn(currency,'currency',10) as currency_length_check
		,clean_isboolean_fn(coalesce(primary_currency,'1')) as primary_currency_isboolean_flag 
		,clean_istruncated_fn(contact,'contact',765) as contact_length_check
		,clean_isboolean_fn(coalesce(primary_contact,'1')) as primary_contact_isboolean_flag
		,clean_istruncated_fn(direct_phone,'direct_phone',50) as direct_phone_length_check
		,clean_istruncated_fn(mobile,'mobile',50) as mobile_length_check
		,clean_istruncated_fn(email,'email',510) as email_length_check
		,email_count
from 	raw_client_customer
		left outer join ( select contact as contact1 ,count(distinct email) as email_count from raw_client_customer group by contact ) raw_client_contact_multiple_email
			on raw_client_contact_multiple_email.contact1 = raw_client_customer.contact 
where 	length(contact) > 765
 or		length(email) > 255
 or		length(address1) > 255
 or		(length(address2) + length(address3)) > 510 
 or		length(city) > 100
 or		length(state) > 50
 or		length(zipcode) > 10
 or		length(country) > 50
 or		not clean_isboolean_fn(coalesce(primary_location,'1')) 
 or		length(phone) > 50
 or		length(fax) > 50
 or		length(currency) > 10
 or		not clean_isboolean_fn(coalesce(primary_currency,'1')) 
 or		length(contact) > 765
 or		not clean_isboolean_fn(coalesce(primary_contact,'1')) 
 or		length(direct_phone) > 50 
 or		length(mobile) > 50
 or		length(email) > 510
 or 	email_count > 1;

-- ,case when count(distinct email) > 1 then 'duplicate: ' || min(email) || ', ' || max(email) else null end as email_duplictes_check