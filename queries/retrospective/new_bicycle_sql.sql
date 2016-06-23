drop table if exists new_bicycle;
create table new_bicycle (query_name text, value real);

-- what's the length of bike tracks which are paths separate from the road?
insert into new_bicycle (query_name, value) values ('bike_track', (select sum(st_length(way))/1000 from planet_osm_line where (highway = 'cycleway' and osm_id > 0) or (highway is not null and tags @> '"cycleway"=>"track"' and osm_id > 0) or (highway is not null and bicycle = 'use_sidepath')));

-- what's the length of bike tracks which are paths separate from the road and new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_track_new', (select sum(st_length(way))/1000 from planet_osm_line where (highway = 'cycleway' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07') or (highway is not null and tags @> '"cycleway"=>"track"' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07') or (highway is not null and bicycle = 'use_sidepath' and osm_timestamp > '2016-05-19 17:57:00-07')));

-- what's the length of bike lanes which are paths on the road?
insert into new_bicycle (query_name, value) values ('bike_lane', (select sum(st_length(way))/1000 from planet_osm_line where tags ? 'cycleway' and highway is not null and osm_id > 0));

-- what's the length of bike lanes which are paths on the road and new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_lane_new', (select sum(st_length(way))/1000 from planet_osm_line where tags ? 'cycleway' and highway is not null and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));

-- what's the length of bike routes
insert into new_bicycle (query_name, value) values ('bike_route', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bicycle' and osm_id < 0));

-- what's the length of bike routes and new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_route_new', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bicycle' and osm_id < 0 and osm_timestamp > '2016-05-19 17:57:00-07'));

-- how many bicycle parking areas are there?
insert into new_bicycle (query_name, value) values ('bike_parking_polygons', (select count(*) from planet_osm_polygon where amenity = 'bicycle_parking' and osm_id > 0));
insert into new_bicycle (query_name, value) values ('bike_parking_points', (select count(*) from planet_osm_point where amenity = 'bicycle_parking' and osm_id > 0));

-- how many bicycle parking areas are there and new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_parking_polygons_new', (select count(*) from planet_osm_polygon where amenity = 'bicycle_parking' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));
insert into new_bicycle (query_name, value) values ('bike_parking_points_new', (select count(*) from planet_osm_point where amenity = 'bicycle_parking' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));

-- how many bicycle repair stations are there?
insert into new_bicycle (query_name, value) values ('bike_repair_polygons', (select count(*) from planet_osm_polygon where amenity = 'bicycle_repair_station' and osm_id > 0));
insert into new_bicycle (query_name, value) values ('bike_repair_points', (select count(*) from planet_osm_point where amenity = 'bicycle_repair_station' and osm_id > 0));

-- how many bicycle repair stations are there and new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_repair_polygons_new', (select count(*) from planet_osm_polygon where amenity = 'bicycle_repair_station' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));
insert into new_bicycle (query_name, value) values ('bike_repair_points_new', (select count(*) from planet_osm_point where amenity = 'bicycle_repair_station' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));

-- how many bicycle rental locations are there?
insert into new_bicycle (query_name, value) values ('bike_rental_polygons', (select count(*) from planet_osm_polygon where amenity = 'bicycle_rental' and osm_id > 0));
insert into new_bicycle (query_name, value) values ('bike_rental_points', (select count(*) from planet_osm_point where amenity = 'bicycle_rental' and osm_id > 0));

-- how many bicycle rental locations are there and new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_rental_polygons_new', (select count(*) from planet_osm_polygon where amenity = 'bicycle_rental' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));
insert into new_bicycle (query_name, value) values ('bike_rental_points_new', (select count(*) from planet_osm_point where amenity = 'bicycle_rental' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));

-- how many bicycle shops are there?
insert into new_bicycle (query_name, value) values ('bike_shop_polygons', (select count(*) from planet_osm_polygon where shop = 'bicycle' and osm_id > 0));
insert into new_bicycle (query_name, value) values ('bike_shop_points', (select count(*) from planet_osm_point where shop = 'bicycle' and osm_id > 0));

-- how many bicycle shops are there?
insert into new_bicycle (query_name, value) values ('bike_shop_polygons_new', (select count(*) from planet_osm_polygon where shop = 'bicycle' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));
insert into new_bicycle (query_name, value) values ('bike_shop_points_new', (select count(*) from planet_osm_point where shop = 'bicycle' and osm_id > 0 and osm_timestamp > '2016-05-19 17:57:00-07'));

-- what's the total count of bicycle related points of interest?
insert into new_bicycle (query_name, value) values ('bike_pois', (select sum(value) from new_bicycle where query_name = 'bike_parking_polygons' or query_name = 'bike_parking_points' or query_name = 'bike_repair_polygons' or query_name = 'bike_repair_points' or query_name = 'bike_rental_polygons' or query_name = 'bike_rental_points' or query_name = 'bike_shop_polygons' or query_name = 'bike_shop_points'));

-- what's the total count of bicycle related points of interest that are new or modified since the post?
insert into new_bicycle (query_name, value) values ('bike_pois_new', (select sum(value) from new_bicycle where query_name = 'bike_parking_polygons_new' or query_name = 'bike_parking_points_new' or query_name = 'bike_repair_polygons_new' or query_name = 'bike_repair_points_new' or query_name = 'bike_rental_polygons_new' or query_name = 'bike_rental_points_new' or query_name = 'bike_shop_polygons_new' or query_name = 'bike_shop_points_new'));

select * from new_bicycle;