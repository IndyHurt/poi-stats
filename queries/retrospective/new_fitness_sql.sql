drop table if exists new_fitness;
create table new_fitness (query_name text, value real);

insert into new_fitness (query_name, value) values ('fitness_points', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0));

insert into new_fitness (query_name, value) values ('fitness_polygons', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0));

insert into new_fitness (query_name, value) values ('fitness_points_new', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_polygons_new', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_points_with_housenumber', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and "addr:housenumber" is not null));

insert into new_fitness (query_name, value) values ('fitness_polygons_with_housenumber', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and "addr:housenumber" is not null));

insert into new_fitness (query_name, value) values ('fitness_points_with_housenumber_new', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and "addr:housenumber" is not null and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_polygons_with_housenumber_new', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and "addr:housenumber" is not null and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_points_with_website', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into new_fitness (query_name, value) values ('fitness_polygons_with_website', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into new_fitness (query_name, value) values ('fitness_points_with_website_new', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'website' or tags ? 'url') and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_polygons_with_website_new', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'website' or tags ? 'url') and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_points_with_hours', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into new_fitness (query_name, value) values ('fitness_polygons_with_hours', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into new_fitness (query_name, value) values ('fitness_points_with_hours_new', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours') and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_polygons_with_hours_new', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours') and osm_timestamp > '2016-02-11 14:00:00-08'));

insert into new_fitness (query_name, value) values ('fitness_total', (select sum(value) from new_fitness where query_name = 'fitness_points' or query_name = 'fitness_polygons'));

insert into new_fitness (query_name, value) values ('fitness_total_new', (select sum(value) from new_fitness where query_name = 'fitness_points_new' or query_name = 'fitness_polygons_new'));

insert into new_fitness (query_name, value) values ('fitness_total_new_pct', (((select value from new_fitness where query_name = 'fitness_total_new')/(select value from new_fitness where query_name = 'fitness_total')) *100));

insert into new_fitness (query_name, value) values ('fitness_with_address_total', (select sum(value) from new_fitness where query_name = 'fitness_points_with_housenumber' or query_name = 'fitness_polygons_with_housenumber'));

insert into new_fitness (query_name, value) values ('fitness_with_address_total_new', (select sum(value) from new_fitness where query_name = 'fitness_points_with_housenumber_new' or query_name = 'fitness_polygons_with_housenumber_new'));

insert into new_fitness (query_name, value) values ('fitness_with_website_total', (select sum(value) from new_fitness where query_name = 'fitness_points_with_website' or query_name = 'fitness_polygons_with_website'));

insert into new_fitness (query_name, value) values ('fitness_with_website_total_new', (select sum(value) from new_fitness where query_name = 'fitness_points_with_website_new' or query_name = 'fitness_polygons_with_website_new'));

insert into new_fitness (query_name, value) values ('fitness_with_hours_total', (select sum(value) from new_fitness where query_name = 'fitness_points_with_hours' or query_name = 'fitness_polygons_with_hours'));

insert into new_fitness (query_name, value) values ('fitness_with_hours_total_new', (select sum(value) from new_fitness where query_name = 'fitness_points_with_hours_new' or query_name = 'fitness_polygons_with_hours_new'));

insert into new_fitness (query_name, value) values ('fitness_with_address_pct', (((select value from new_fitness where query_name = 'fitness_with_address_total')/(select value from new_fitness where query_name = 'fitness_total')) *100));

insert into new_fitness (query_name, value) values ('fitness_with_address_pct_new', (((select value from new_fitness where query_name = 'fitness_with_address_total_new')/(select value from new_fitness where query_name = 'fitness_total_new')) *100));

insert into new_fitness (query_name, value) values ('fitness_with_website_pct', (((select value from new_fitness where query_name = 'fitness_with_website_total')/(select value from new_fitness where query_name = 'fitness_total')) *100));

insert into new_fitness (query_name, value) values ('fitness_with_website_pct_new', (((select value from new_fitness where query_name = 'fitness_with_website_total_new')/(select value from new_fitness where query_name = 'fitness_total_new')) *100));

insert into new_fitness (query_name, value) values ('fitness_with_hours_pct', (((select value from new_fitness where query_name = 'fitness_with_hours_total')/(select value from new_fitness where query_name = 'fitness_total')) *100));

insert into new_fitness (query_name, value) values ('fitness_with_hours_pct_new', (((select value from new_fitness where query_name = 'fitness_with_hours_total_new')/(select value from new_fitness where query_name = 'fitness_total_new')) *100));

select * from new_fitness;
