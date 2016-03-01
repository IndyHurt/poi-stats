drop table if exists fitness;
create table fitness (query_name text, value real);

insert into fitness (query_name, value) values ('fitness_points', (select count(*) from planet_osm_point where amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym') and osm_id > 0));

insert into fitness (query_name, value) values ('fitness_polygons', (select count(*) from planet_osm_polygon where amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym') and osm_id > 0));

insert into fitness (query_name, value) values ('fitness_points_with_housenumber', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and "addr:housenumber" is not null));

insert into fitness (query_name, value) values ('fitness_polygons_with_housenumber', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and "addr:housenumber" is not null));

insert into fitness (query_name, value) values ('fitness_points_with_website', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into fitness (query_name, value) values ('fitness_polygons_with_website', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into fitness (query_name, value) values ('fitness_points_with_hours', (select count(*) from planet_osm_point where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into fitness (query_name, value) values ('fitness_polygons_with_hours', (select count(*) from planet_osm_polygon where (amenity in ('fitness_center', 'fitness_centre', 'fitness', 'gym') or leisure in ('fitness_center', 'fitness_centre', 'fitness') or sport in ('fitness', 'gym')) and osm_id > 0 and (tags ? 'opening_hours' or tags ? 'operating_hours')));

insert into fitness (query_name, value) values ('fitness_total', (select sum(value) from fitness where query_name = 'fitness_points' or query_name = 'fitness_polygons'));

insert into fitness (query_name, value) values ('fitness_with_address_total', (select sum(value) from fitness where query_name = 'fitness_points_with_housenumber' or query_name = 'fitness_polygons_with_housenumber'));

insert into fitness (query_name, value) values ('fitness_with_website_total', (select sum(value) from fitness where query_name = 'fitness_points_with_website' or query_name = 'fitness_polygons_with_website'));

insert into fitness (query_name, value) values ('fitness_with_hours_total', (select sum(value) from fitness where query_name = 'fitness_points_with_hours' or query_name = 'fitness_polygons_with_hours'));

insert into fitness (query_name, value) values ('fitness_with_address_pct', (((select value from fitness where query_name = 'fitness_with_address_total')/(select value from fitness where query_name = 'fitness_total')) *100));

insert into fitness (query_name, value) values ('fitness_with_website_pct', (((select value from fitness where query_name = 'fitness_with_website_total')/(select value from fitness where query_name = 'fitness_total')) *100));

insert into fitness (query_name, value) values ('fitness_with_hours_pct', (((select value from fitness where query_name = 'fitness_with_hours_total')/(select value from fitness where query_name = 'fitness_total')) *100));

select * from fitness;
