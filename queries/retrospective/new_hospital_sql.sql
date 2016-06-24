drop table if exists new_hospital_features;
create table new_hospital_features (query_name text, value real);

--How many hospital points are there?*
insert into new_hospital_features (query_name, value) values ('hospital_points_total', (select count(*) from planet_osm_point where amenity = 'hospital'));

--How many hospital polygons are there?*
insert into new_hospital_features (query_name, value) values ('hospital_polygons_total', (select count(*) from planet_osm_polygon where amenity = 'hospital'));

--How many hospital points have a cooresponding polygon?*
insert into new_hospital_features (query_name, value) values ('hospital_points_with_poly', (select count(distinct planet_osm_point.osm_id) from planet_osm_point, planet_osm_polygon where st_within(planet_osm_point.way, planet_osm_polygon.way) and planet_osm_point.amenity = 'hospital' and planet_osm_polygon.amenity = 'hospital'));

--How many hospitals do not have a cooresponding polygon?*
insert into new_hospital_features (query_name, value) values ('hospital_points_no_poly', ((select value from new_hospital_features where query_name = 'hospital_points_total') - (select value from new_hospital_features where query_name = 'hospital_points_with_poly')));

--How many hospital points are new or were modified since the targeted editing post on December 7th
insert into new_hospital_features (query_name, value) values ('hospital_points_total_new', (select count (*) from planet_osm_point where amenity = 'hospital' and osm_timestamp > '2015-12-07 17:49:00-08'));

--How many hospital polygons are new or were modified since the targeted editing post on December 7th
insert into new_hospital_features (query_name, value) values ('hospital_polygons_total_new', (select count (*) from planet_osm_polygon where amenity = 'hospital' and osm_timestamp > '2015-12-07 17:49:00-08'));

--How many hospital points are new or modified since the post and have a cooresponding polygons?*
insert into new_hospital_features (query_name, value) values ('hospital_points_with_poly_new', (select count(distinct planet_osm_point.osm_id) from planet_osm_point, planet_osm_polygon where st_within(planet_osm_point.way, planet_osm_polygon.way) and planet_osm_point.amenity = 'hospital' and planet_osm_point.osm_timestamp > '2015-12-07 17:49:00-08' and planet_osm_polygon.amenity = 'hospital'));

--How many new or modified hospitals since the post do not have a cooresponding polygon?
insert into new_hospital_features (query_name, value) values ('hospital_points_no_poly_new', ((select value from new_hospital_features where query_name = 'hospital_points_total_new') - (select value from new_hospital_features where query_name = 'hospital_points_with_poly_new')));

--Calculate percent increase in hospital polygons

--How many hospital polygons where their prior to the blog post?
insert into new_hospital_features (query_name, value) values ('hospital_polys_pre_post', ((select value from new_hospital_features where query_name = 'hospital_polygons_total') - (select value from new_hospital_features where query_name = 'hospital_polygons_total_new')));

--increase = current total - previous total
insert into new_hospital_features (query_name, value) values ('hospital_polys_increase', ((select value from new_hospital_features where query_name = 'hospital_polygons_total') - (select value from new_hospital_features where query_name = 'hospital_polys_pre_post')));

--percent increase = increase / previous total * 100

insert into new_hospital_features (query_name, value) values ('hospital_poly_percent_increase', (((select value from new_hospital_features where query_name = 'hospital_polys_increase') / (select value from new_hospital_features where query_name = 'hospital_polys_pre_post')) * 100));

select * from new_hospital_features;