drop table if exists grocery;
create table grocery (query_name text, value real);

insert into grocery (query_name, value) values ('grocery_points', (select count(*) from planet_osm_point where shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0));

insert into grocery (query_name, value) values ('grocery_polygons', (select count(*) from planet_osm_polygon where shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0));

insert into grocery (query_name, value) values ('grocery_points_with_housenumber', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0)  and "addr:housenumber" is not null));

insert into grocery (query_name, value) values ('grocery_polygons_with_housenumber', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0)  and "addr:housenumber" is not null));

insert into grocery (query_name, value) values ('grocery_points_with_website', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0)  and (tags ? 'website' or tags ? 'url')));

insert into grocery (query_name, value) values ('grocery_polygons_with_website', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0)  and (tags ? 'website' or tags ? 'url')));

insert into grocery (query_name, value) values ('grocery_points_with_hours', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0)  and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into grocery (query_name, value) values ('grocery_polygons_with_hours', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket' and osm_id > 0)  and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into grocery (query_name, value) values ('grocery_total', (select sum(value) from grocery where query_name = 'grocery_points' or query_name = 'grocery_polygons'));

insert into grocery (query_name, value) values ('grocery_with_address_total', (select sum(value) from grocery where query_name = 'grocery_points_with_housenumber' or query_name = 'grocery_polygons_with_housenumber'));

insert into grocery (query_name, value) values ('grocery_with_website_total', (select sum(value) from grocery where query_name = 'grocery_points_with_website' or query_name = 'grocery_polygons_with_website'));

insert into grocery (query_name, value) values ('grocery_with_hours_total', (select sum(value) from grocery where query_name = 'grocery_points_with_hours' or query_name = 'grocery_polygons_with_hours'));

insert into grocery (query_name, value) values ('grocery_with_address_pct', (((select value from grocery where query_name = 'grocery_with_address_total')/(select value from grocery where query_name = 'grocery_total')) *100));

insert into grocery (query_name, value) values ('grocery_with_website_pct', (((select value from grocery where query_name = 'grocery_with_website_total')/(select value from grocery where query_name = 'grocery_total')) *100));

insert into grocery (query_name, value) values ('grocery_with_hours_pct', (((select value from grocery where query_name = 'grocery_with_hours_total')/(select value from grocery where query_name = 'grocery_total')) *100));

select * from grocery