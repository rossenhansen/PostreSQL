create table phone_numbers (
	 id int generated by default as identity primary key
	,client_id int
	,contact_id int
	,phone_number varchar(50)
	,phone_number_label varchar(10)
	,created_at timestamp default now()
	,updated_at timestamp
	,constraint fk_phone_number_clients
     	foreign key (client_id) 
     	references clients (id)
	,constraint fk_phone_number_contacts
     	foreign key (contact_id) 
     	references contacts (id)
);

create index phone_numbers_phone_number_idx on phone_numbers using btree (phone_number);
create index phone_numbers_client_id_idx on phone_numbers using btree (client_id);
create index phone_numbers_contact_id_idx on phone_numbers using btree (contact_id);
create index phone_numbers_created_at_updated_at_idx on phone_numbers using btree (created_at,updated_at);


-- drop table phone_numbers;

