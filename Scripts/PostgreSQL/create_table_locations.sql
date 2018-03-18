-- drop table locations;

create table locations (
	 id int generated by default as identity primary key
	,client_id int
	,location_name varchar
	,location_type varchar(50)
	,address_prefix varchar(255)
	,address_street varchar(510)
	,location varchar(100)
	,state varchar(50)
	,postcode varchar(10)
	,country varchar(50) default 'Australia'
	,currency_code varchar(3) default 'AUD'
	,created_at timestamp not null default now()
	,updated_at timestamp null
	,synched_at timestamp not null default now()
	,constraint fk_locations_clients
     	foreign key (client_id) 
     	references clients (id)
);

create index locations_location_name_idx on locations using btree (lower(location_name));
create index locations_location_type_idx on locations using btree (lower(location_type));
create index locations_address_idx on locations using btree (lower(address_prefix),lower(address_street),lower(location),lower(state),lower(country));
create index locations_postcode_idx on locations using btree (postcode);
create index locations_currency_code_idx on locations using btree (currency_code);
create index locations_created_at_updated_at_idx on locations using btree (created_at,updated_at);

