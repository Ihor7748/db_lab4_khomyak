-- if no market insert market.location_id is not in location table add location
create or replace function f_create_location_if_doesnt_exist() returns trigger as
$$
begin
	if new.location_id not in (select location_id from location) then
		insert into location (location_id, locality_name, country_name)
			values (new.location_id, NULL, NULL);
	end if;
	return new;
end;
$$ language 'plpgsql';

create trigger create_location_if_doesnt_exist before insert on market 
for each row execute procedure f_create_location_if_doesnt_exist();
