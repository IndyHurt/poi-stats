-- Create a table of stadium polygons that are larger than 2000 square meters
drop table if exists stadium_polygons;
create table stadium_polygons as select osm_id, name, building, landuse, leisure, sport, tags, way from planet_osm_polygon where (osm_id > 0 and way_area > 2000) and (leisure = 'stadium' or building = 'stadium');

-- Create a table of parking polygons
drop table if exists parking_polygons;
create table parking_polygons as select osm_id, name, landuse, amenity, tags, way from planet_osm_polygon where osm_id > 0 and amenity = 'parking';

-- Create a table of parking aisles
drop table if exists parking_aisles;
create table parking_aisles as select osm_id, name, amenity, highway, service, tags, way from planet_osm_line where osm_id > 0 and service = 'parking_aisle';

-- Create a table of parking polygons that are within 100 meters (about 330 ft) of a stadium polygon
drop table if exists stadium_parking_polygons;
create table stadium_parking_polygons as select stadium_polygons.osm_id as stadium_id, stadium_polygons.name as stadium_name, parking_polygons.osm_id as parking_id, parking_polygons.name as parking_name, parking_polygons.way as way from stadium_polygons inner join parking_polygons on st_dwithin(stadium_polygons.way, parking_polygons.way, 100);

-- Create a table of stadium parking areas that have parking aisles
drop table if exists stadium_parking_with_aisles
create table stadium_parking_with_aisles as select distinct stadium_parking_polygons.stadium_id, stadium_parking_polygons.stadium_name,stadium_parking_polygons.way from stadium_parking_polygons inner join parking_aisles on st_intersects(stadium_parking_polygons.way, parking_aisles.way);

-- Create a table to store the number of stadiums and percentages with parking and parking aisles
drop table if exists stadium_eval
create table stadium_eval (query_name text, value real);
insert into stadium_eval (query_name, value) values ('stadium_polygons', (select count (*) from stadium_polygons));
insert into stadium_eval (query_name, value) values ('stadium_parking_polygons', (select count (*) from stadium_parking_polygons));
insert into stadium_eval (query_name, value) values ('stadium_parking_with_aisles', (select count(*) from stadium_parking_with_aisles));
insert into stadium_eval (query_name, value) values ('stadium_with_parking_polygons_pct', (((select value from stadium_eval where query_name = 'stadium_parking_polygons')/(select value from stadium_eval where query_name = 'stadium_polygons'))*100));
insert into stadium_eval (query_name, value) values ('stadium_with_parking_polygons_and_aisles_pct', (((select value from stadium_eval where query_name = 'stadium_parking_with_aisles')/(select value from stadium_eval where query_name = 'stadium_polygons'))*100));

select * from stadium_eval


select * from stadium_polygons
select * from parking_polygons 
select * from parking_aisles
select * from stadium_parking_polygons 
select * from stadium_parking_with_aisles

