select 
  array_to_string(ary[1:len - 1], ' ') as first_name, 
  ary[len] as last_name 
from (
  select ary, array_length(ary, 1) as len
  from (
    select regexp_split_to_array(full_name, E'\\s+') as ary 
    from names
  ) sub1
) sub2;