drop table if exists new_airport_features;
create table new_airport_features (query_name text, value real);

--How many airport points are there?*
insert into new_airport_features (query_name, value) values ('airport_points_total', (select count(*) from planet_osm_point where aeroway = 'aerodrome'));

--How many airport polygons are there?*
insert into new_airport_features (query_name, value) values ('airport_polygons_total', (select count(*) from planet_osm_polygon where aeroway = 'aerodrome'));

--How many airport points have a cooresponding polygon?*
insert into new_airport_features (query_name, value) values ('airport_points_with_poly', (select count(distinct planet_osm_point.osm_id) from planet_osm_point, planet_osm_polygon where st_within(planet_osm_point.way, planet_osm_polygon.way) and planet_osm_point.aeroway = 'aerodrome' and planet_osm_polygon.aeroway = 'aerodrome'));

--How many new_airport_features do not have a cooresponding polygon?*
insert into new_airport_features (query_name, value) values ('airport_points_no_poly', ((select value from new_airport_features where query_name = 'airport_points_total') - (select value from new_airport_features where query_name = 'airport_points_with_poly')));

--How many airport points are new since the targeted editing post on December 14th (tweet time was 2:45pm PST)?*
insert into new_airport_features (query_name, value) values ('airport_points_total_new', (select count (*) from planet_osm_point where aeroway = 'aerodrome' and osm_timestamp > '2015-12-14 18:13:00-08'));

--How many airport polygons are new since the targeted editing post on December 14th (tweet time was 2:45pm PST)?*
insert into new_airport_features (query_name, value) values ('airport_polygons_total_new', (select count (*) from planet_osm_polygon where aeroway = 'aerodrome' and osm_timestamp > '2015-12-14 18:13:00-08'));

--How many airport points are new since the post and have a cooresponding polygons?*
insert into new_airport_features (query_name, value) values ('airport_points_with_poly_new', (select count(distinct planet_osm_point.osm_id) from planet_osm_point, planet_osm_polygon where st_within(planet_osm_point.way, planet_osm_polygon.way) and planet_osm_point.aeroway = 'aerodrome' and planet_osm_point.osm_timestamp > '2015-12-14 18:13:00-08' and planet_osm_polygon.aeroway = 'aerodrome'));

--How many new new_airport_features do not have a cooresponding polygon?
insert into new_airport_features (query_name, value) values ('airport_points_no_poly_new', ((select value from new_airport_features where query_name = 'airport_points_total_new') - (select value from new_airport_features where query_name = 'airport_points_with_poly_new')));

--Calculate percent increase in airport polygons

--How many airport polygons where their prior to the blog post?
insert into new_airport_features (query_name, value) values ('airport_polys_pre_post', ((select value from new_airport_features where query_name = 'airport_polygons_total') - (select value from new_airport_features where query_name = 'airport_polygons_total_new')));

--increase = current total - previous total
insert into new_airport_features (query_name, value) values ('airport_polys_increase', ((select value from new_airport_features where query_name = 'airport_polygons_total') - (select value from new_airport_features where query_name = 'airport_polys_pre_post')));

--percent increase = increase / previous total * 100

insert into new_airport_features (query_name, value) values ('airport_poly_percent_increase', (((select value from new_airport_features where query_name = 'airport_polys_increase') / (select value from new_airport_features where query_name = 'airport_polys_pre_post')) * 100));
	
select * from new_airport_features;	