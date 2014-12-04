select row_to_json(r)
from reservations r;

select json_agg(row_to_json(r))
from reservations r;
