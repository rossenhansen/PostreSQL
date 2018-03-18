create or replace function clean_isboolean_fn(text) returns boolean as $$
declare value varchar;
begin
	value = lower(Ltrim(RTrim(coalesce($1,'1'))));
	return 	case value 
			when 'yes' then true
			when 'no' then true
			when 'true' then true
			when 'false' then true
			when '1' then true
			when '0' then true
			when '-1' then true
			else false end;
end;
$$
strict
language plpgsql immutable;

