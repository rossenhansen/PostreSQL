create or replace function make_client_insert_new_proc() returns boolean as $$

begin
	--match existing client records BEFORE insert
	update raw_client_customer set client_id = clients.id from clients where client = client_name and client_id is null;
	--new client records
	insert into clients (client_name ,primary_location_id ,primary_contact_id ,primary_currency_code ,created_at ,updated_at ,synched_at)
	select	 client_varchar as client_name
			,null as primary_location_id
			,null as primary_contact_id
			,null as primary_currency_code
			,now() as created_at
			,now() as updated_at
			,max(synched_at_timestamp) as synched_at
	from 	clean_client_view
	where 	client_id_int is null
	group by client_varchar;
	--match existing client records AFTER insert
	update raw_client_customer set client_id = clients.id from clients where client = client_name and client_id is null;
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
	perform make_client_insert_new_proc();
end $$;

select make_client_insert_new_proc()
*/


