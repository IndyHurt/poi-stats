drop table if exists banks;
create table banks (query_name text, value real);

insert into banks (query_name, value) values ('banks_points', (select count(*) from planet_osm_point where (amenity = 'bank' or building = 'bank') and osm_id > 0));

insert into banks (query_name, value) values ('atm_points', (select count(*) from planet_osm_point where (amenity = 'atm') and osm_id > 0));	

insert into banks (query_name, value) values ('banks_polygons', (select count(*) from planet_osm_polygon where (amenity = 'bank' or building = 'bank') and osm_id > 0));

insert into banks (query_name, value) values ('banks_points_with_housenumber', (select count(*) from planet_osm_point where (amenity = 'bank' or building = 'bank') and osm_id > 0 and "addr:housenumber" is not null));

insert into banks (query_name, value) values ('banks_polygons_with_housenumber', (select count(*) from planet_osm_polygon where (amenity = 'bank' or building = 'bank') and osm_id > 0 and "addr:housenumber" is not null));

insert into banks (query_name, value) values ('banks_points_with_website', (select count(*) from planet_osm_point where (amenity = 'bank' or building = 'bank') and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into banks (query_name, value) values ('banks_polygons_with_website', (select count(*) from planet_osm_polygon where (amenity = 'bank' or building = 'bank') and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into banks (query_name, value) values ('banks_points_with_hours', (select count(*) from planet_osm_point where (amenity = 'bank' or building = 'bank') and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into banks (query_name, value) values ('banks_polygons_with_hours', (select count(*) from planet_osm_polygon where (amenity = 'bank' or building = 'bank') and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into banks (query_name, value) values ('banks_total', (select sum(value) from banks where query_name = 'banks_points' or query_name = 'banks_polygons'));

insert into banks (query_name, value) values ('banks_with_address_total', (select sum(value) from banks where query_name = 'banks_points_with_housenumber' or query_name = 'banks_polygons_with_housenumber'));

insert into banks (query_name, value) values ('banks_with_website_total', (select sum(value) from banks where query_name = 'banks_points_with_website' or query_name = 'banks_polygons_with_website'));

insert into banks (query_name, value) values ('banks_with_hours_total', (select sum(value) from banks where query_name = 'banks_points_with_hours' or query_name = 'banks_polygons_with_hours'));

insert into banks (query_name, value) values ('banks_with_address_pct', (((select value from banks where query_name = 'banks_with_address_total')/(select value from banks where query_name = 'banks_total')) *100));

insert into banks (query_name, value) values ('banks_with_website_pct', (((select value from banks where query_name = 'banks_with_website_total')/(select value from banks where query_name = 'banks_total')) *100));

insert into banks (query_name, value) values ('banks_with_hours_pct', (((select value from banks where query_name = 'banks_with_hours_total')/(select value from banks where query_name = 'banks_total')) *100));

select * from banks