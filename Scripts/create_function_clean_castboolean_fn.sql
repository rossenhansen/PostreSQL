create or replace function clean_castboolean_fn(text) returns boolean as $$
declare value varchar;
begin
	value = lower(trim(coalesce($1,'1')));
	return 	case value 
			when 'yes' then true
			when 'no' then false
			when 'true' then true
			when 'false' then false
			when '1' then true
			when '0' then false
			when '-1' then false
			else null end;
end;
$$
strict
language plpgsql immutable;