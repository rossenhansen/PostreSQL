create or replace function clean_istruncated_fn(text,text,int) returns varchar as $$
begin
	return case	when length($1) > $3 
				then 'truncate-string: data= '|| $2 || '; length= ' || cast(length($1) as varchar) || '; truncated_value= ' || left($1, $3) 
				else null end; 
end;
$$
strict
language plpgsql immutable;