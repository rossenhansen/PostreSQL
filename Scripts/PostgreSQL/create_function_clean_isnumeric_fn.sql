create or replace function clean_isnumeric_fn(text) returns boolean as $$
declare value numeric;
begin
    value = $1::numeric;
    return true;
exception when others then
    return false;
end;
$$
strict
language plpgsql immutable;


