create extension plv8;

create function format_name(first_name text, middle_name text, last_name text)
returns text AS $$

  var name = first_name

  if(middle_name) {
    name += " " + middle_name
  }

  name += " " + last_name

  return name
$$ language plv8 immutable;

select format_name('John', NULL, 'Smith');

select format_name('John', 'Mark', 'Smith');
