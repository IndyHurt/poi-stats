drop table if exists schools;
create table schools (query_name text, value real);

--How many school points are there?*
insert into schools (query_name, value) values ('school_points_total', (select count(*) from planet_osm_point where amenity in ('college', 'kindergarten', 'school', 'university')));

--How many school polygons are there?*
insert into schools (query_name, value) values ('school_polygons_total', (select count(*) from planet_osm_polygon where amenity in ('college', 'kindergarten', 'school', 'university')));

--How many school points have a cooresponding polygon?*
insert into schools (query_name, value) values ('school_points_with_poly', (select count(distinct planet_osm_point.osm_id) from planet_osm_point, planet_osm_polygon where st_within(planet_osm_point.way, planet_osm_polygon.way) and planet_osm_point.amenity in ('college', 'kindergarten', 'school', 'university') and planet_osm_polygon.amenity in ('college', 'kindergarten', 'school', 'university')));

--How many schools do not have a cooresponding polygon?*
insert into schools (query_name, value) values ('school_points_no_poly', ((select value from schools where query_name = 'school_points_total') - (select value from schools where query_name = 'school_points_with_poly')));

--How many school points are new or modified since the targeted editing post on December 10th (tweet time was 2:45pm PST)?*
insert into schools (query_name, value) values ('school_points_total_new', (select count (*) from planet_osm_point where amenity in ('college', 'kindergarten', 'school', 'university') and osm_timestamp > '2015-12-10 22:45:00-08'));

--How many school polygons are new or modified since the targeted editing post on December 10th (tweet time was 2:45pm PST)?*
insert into schools (query_name, value) values ('school_polygons_total_new', (select count (*) from planet_osm_polygon where amenity in ('college', 'kindergarten', 'school', 'university') and osm_timestamp > '2015-12-10 22:45:00-08'));

--How many school points are new or modified since the post and have a cooresponding polygons?*
insert into schools (query_name, value) values ('school_points_with_poly_new', (select count(distinct planet_osm_point.osm_id) from planet_osm_point, planet_osm_polygon where st_within(planet_osm_point.way, planet_osm_polygon.way) and planet_osm_point.amenity in ('college', 'kindergarten', 'school', 'university') and planet_osm_point.osm_timestamp > '2015-12-10 22:45:00-08' and planet_osm_polygon.amenity in ('college', 'kindergarten', 'school', 'university')));

--How many new or modified schools do not have a cooresponding polygon?
insert into schools (query_name, value) values ('school_points_no_poly_new', ((select value from schools where query_name = 'school_points_total_new') - (select value from schools where query_name = 'school_points_with_poly_new')));

--Calculate percent increase in school polygons

--How many school polygons where their prior to the blog post?
insert into schools (query_name, value) values ('school_polys_pre_post', ((select value from schools where query_name = 'school_polygons_total') - (select value from schools where query_name = 'school_polygons_total_new')));

--increase = current total - previous total
insert into schools (query_name, value) values ('school_polys_increase', ((select value from schools where query_name = 'school_polygons_total') - (select value from schools where query_name = 'school_polys_pre_post')));

--percent increase = increase / previous total * 100

insert into schools (query_name, value) values ('school_poly_percent_increase', (((select value from schools where query_name = 'school_polys_increase') / (select value from schools where query_name = 'school_polys_pre_post')) * 100));

select * from schools;
