create or replace function make_contact_insert_new_proc() returns boolean as $$

begin
	--match existing client records BEFORE insert
	update raw_client_customer set contact_id = contacts.id from contacts where raw_client_customer.contact = ( contacts.firstname || ' ' || contacts.othername || ' ' || contacts.lastname ) and raw_client_customer.client_id = contacts.client_id and raw_client_customer.contact_id is null;
	--new client records
	insert into contacts (client_id ,location_id ,firstname ,othername ,lastname ,email ,created_at ,updated_at ,synched_at)
	select	  client_id
			,null as location_id
			--,regexp_split_to_array(contact, E'\\s+') as name_array --CALC convert contact name string to name array: regexp_split_to_array(contact, E'\\s+')
			--,array_length(regexp_split_to_array(contact, E'\\s+'),1) as name_array_length --CALC length of name array: array_length(regexp_split_to_array(contact, E'\\s+')
			--first_name CASE when only one name set to null else set to first name
			,case when array_length(regexp_split_to_array(contact, E'\\s+'),1) = 1 then null else (regexp_split_to_array(contact, E'\\s+'))[1] end as firstname
			--other_name SLICE name array from [ 2 : array_length-1 ]
			,array_to_string((regexp_split_to_array(contact, E'\\s+'))[2:(array_length(regexp_split_to_array(contact, E'\\s+'),1)-1)],' ') as othername
			--last_name set to last name whis is at array_length
			,(regexp_split_to_array(contact, E'\\s+'))[array_length(regexp_split_to_array(contact, E'\\s+'),1)] as lastname
			,email
			,now() as created_at
			,now() as updated_at
			,max(synched_at) as synched_at
	from 	clean_client_contact_view
	where 	contact_id is null
	group by client_id ,contact ,email; 
	--match existing client records AFTER insert
	update raw_client_customer set contact_id = contacts.id from contacts where raw_client_customer.contact = ( contacts.firstname || ' ' || contacts.othername || ' ' || contacts.lastname ) and raw_client_customer.client_id = contacts.client_id and raw_client_customer.contact_id is null;
	--execution sucessful
	return true;
	--return false when execution fails
	exception when others then
    	return false;

end;
$$
strict
language plpgsql volatile;

/*
do $$ begin
	perform make_contact_insert_new_proc();
end $$;

select make_contact_insert_new_proc()
*/
