select pricing from legacy.listings where id=216359;

select *
from json_each((select pricing::json from legacy.listings where id=216359));

select key, count(*)
from json_each((select pricing::json from legacy.listings))
group by key;

select key, count(*)
from legacy.listings l
  cross join lateral (select * from json_each(l.pricing::json)) t
group by key;

