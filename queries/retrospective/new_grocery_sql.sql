drop table if exists new_grocery;
create table new_grocery (query_name text, value real);

insert into new_grocery (query_name, value) values ('grocery_points', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0));

insert into new_grocery (query_name, value) values ('grocery_polygons', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0));

insert into new_grocery (query_name, value) values ('grocery_points_new', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_polygons_new', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_points_with_housenumber', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and "addr:housenumber" is not null));

insert into new_grocery (query_name, value) values ('grocery_polygons_with_housenumber', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and "addr:housenumber" is not null));

insert into new_grocery (query_name, value) values ('grocery_points_with_housenumber_new', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and "addr:housenumber" is not null and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_polygons_with_housenumber_new', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and "addr:housenumber" is not null and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_points_with_website', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into new_grocery (query_name, value) values ('grocery_polygons_with_website', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into new_grocery (query_name, value) values ('grocery_points_with_website_new', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'website' or tags ? 'url') and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_polygons_with_website_new', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'website' or tags ? 'url') and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_points_with_hours', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into new_grocery (query_name, value) values ('grocery_polygons_with_hours', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into new_grocery (query_name, value) values ('grocery_points_with_hours_new', (select count(*) from planet_osm_point where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours') and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_polygons_with_hours_new', (select count(*) from planet_osm_polygon where (shop in ('supermarket', 'greengrocer', 'grocery', 'convenience') or building = 'supermarket') and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours') and osm_timestamp > '2016-01-19 14:00:00-08'));

insert into new_grocery (query_name, value) values ('grocery_total', (select sum(value) from new_grocery where query_name = 'grocery_points' or query_name = 'grocery_polygons'));

insert into new_grocery (query_name, value) values ('grocery_total_new', (select sum(value) from new_grocery where query_name = 'grocery_points_new' or query_name = 'grocery_polygons_new'));

insert into new_grocery (query_name, value) values ('grocery_total_new_pct', (((select value from new_grocery where query_name = 'grocery_total_new')/(select value from new_grocery where query_name = 'grocery_total')) *100));

insert into new_grocery (query_name, value) values ('grocery_with_address_total', (select sum(value) from new_grocery where query_name = 'grocery_points_with_housenumber' or query_name = 'grocery_polygons_with_housenumber'));

insert into new_grocery (query_name, value) values ('grocery_with_address_total_new', (select sum(value) from new_grocery where query_name = 'grocery_points_with_housenumber_new' or query_name = 'grocery_polygons_with_housenumber_new'));

insert into new_grocery (query_name, value) values ('grocery_with_website_total', (select sum(value) from new_grocery where query_name = 'grocery_points_with_website' or query_name = 'grocery_polygons_with_website'));

insert into new_grocery (query_name, value) values ('grocery_with_website_total_new', (select sum(value) from new_grocery where query_name = 'grocery_points_with_website_new' or query_name = 'grocery_polygons_with_website_new'));

insert into new_grocery (query_name, value) values ('grocery_with_hours_total', (select sum(value) from new_grocery where query_name = 'grocery_points_with_hours' or query_name = 'grocery_polygons_with_hours'));

insert into new_grocery (query_name, value) values ('grocery_with_hours_total_new', (select sum(value) from new_grocery where query_name = 'grocery_points_with_hours_new' or query_name = 'grocery_polygons_with_hours_new'));

insert into new_grocery (query_name, value) values ('grocery_with_address_pct', (((select value from new_grocery where query_name = 'grocery_with_address_total')/(select value from new_grocery where query_name = 'grocery_total')) *100));

insert into new_grocery (query_name, value) values ('grocery_with_address_pct_new', (((select value from new_grocery where query_name = 'grocery_with_address_total_new')/(select value from new_grocery where query_name = 'grocery_total_new')) *100));

insert into new_grocery (query_name, value) values ('grocery_with_website_pct', (((select value from new_grocery where query_name = 'grocery_with_website_total')/(select value from new_grocery where query_name = 'grocery_total')) *100));

insert into new_grocery (query_name, value) values ('grocery_with_website_pct_new', (((select value from new_grocery where query_name = 'grocery_with_website_total_new')/(select value from new_grocery where query_name = 'grocery_total_new')) *100));

insert into new_grocery (query_name, value) values ('grocery_with_hours_pct', (((select value from new_grocery where query_name = 'grocery_with_hours_total')/(select value from new_grocery where query_name = 'grocery_total')) *100));

insert into new_grocery (query_name, value) values ('grocery_with_hours_pct_new', (((select value from new_grocery where query_name = 'grocery_with_hours_total_new')/(select value from new_grocery where query_name = 'grocery_total_new')) *100));

select * from new_grocery;