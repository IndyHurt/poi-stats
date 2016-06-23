drop table if exists bicycle;
create table bicycle (query_name text, value real);

-- what's the length of bike tracks which are paths separate from the road?
insert into bicycle (query_name, value) values ('bike_track', (select sum(st_length(way))/1000 from planet_osm_line where (highway = 'cycleway' and osm_id > 0) or (highway is not null and tags @> '"cycleway"=>"track"' and osm_id > 0) or (highway is not null and bicycle = 'use_sidepath')));

-- what's the length of bike lanes which are paths on the road?
insert into bicycle (query_name, value) values ('bike_lane', (select sum(st_length(way))/1000 from planet_osm_line where tags ? 'cycleway' and highway is not null and osm_id > 0));

-- what's the length of bike routes
insert into bicycle (query_name, value) values ('bike_route', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bicycle' and osm_id < 0));

-- how many bicycle parking areas are there?
insert into bicycle (query_name, value) values ('bike_parking_polygons', (select count(*) from planet_osm_polygon where amenity = 'bicycle_parking' and osm_id > 0));
insert into bicycle (query_name, value) values ('bike_parking_points', (select count(*) from planet_osm_point where amenity = 'bicycle_parking' and osm_id > 0));

-- how many bicycle repair stations are there?
insert into bicycle (query_name, value) values ('bike_repair_polygons', (select count(*) from planet_osm_polygon where amenity = 'bicycle_repair_station' and osm_id > 0));
insert into bicycle (query_name, value) values ('bike_repair_points', (select count(*) from planet_osm_point where amenity = 'bicycle_repair_station' and osm_id > 0));

-- how many bicycle rental locations are there?
insert into bicycle (query_name, value) values ('bike_rental_polygons', (select count(*) from planet_osm_polygon where amenity = 'bicycle_rental' and osm_id > 0));
insert into bicycle (query_name, value) values ('bike_rental_points', (select count(*) from planet_osm_point where amenity = 'bicycle_rental' and osm_id > 0));

-- how many bicycle shops are there?
insert into bicycle (query_name, value) values ('bike_shop_polygons', (select count(*) from planet_osm_polygon where shop = 'bicycle' and osm_id > 0));
insert into bicycle (query_name, value) values ('bike_shop_points', (select count(*) from planet_osm_point where shop = 'bicycle' and osm_id > 0));

-- what's the total count of bicycle related points of interest?
insert into bicycle (query_name, value) values ('bike_pois', (select sum(value) from bicycle where query_name = 'bike_parking_polygons' or query_name = 'bike_parking_points' or query_name = 'bike_repair_polygons' or query_name = 'bike_repair_points' or query_name = 'bike_rental_polygons' or query_name = 'bike_rental_points' or query_name = 'bike_shop_polygons' or query_name = 'bike_shop_points'));

