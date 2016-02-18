-- Create a table of stadium polygons that are larger than 2000 square meters
drop table if exists stadium_polygons;
create table stadium_polygons as select osm_id, name, building, landuse, leisure, sport, tags, way from planet_osm_polygon where (osm_id > 0 and way_area > 2000) and (leisure = 'stadium' or building = 'stadium');

-- Create a table of parking polygons 
drop table if exists parking_polygons;
create table parking_polygons as select osm_id, name, landuse, amenity, tags, way from planet_osm_polygon where osm_id > 0 and amenity = 'parking';

-- Create a table of parking aisles
drop table if exists parking_aisles;
create table parking_aisles as select osm_id, name, amenity, highway, service, tags, way from planet_osm_line where osm_id > 0 and service = 'parking_aisle';

-- Create indices to speed up queries
analyze parking_polygons;
analyze stadium_polygons;

create index parking_polygons_gist_idx on parking_polygons using gist(way);
create index parking_aisles_gist_idx on parking_aisles using gist(way);


-- Create a table of stadiums that do not have any parking polygons within 100 meters (about 330 ft) 
drop table if exists stadiums_without_nearby_parking;
create table stadiums_without_nearby_parking as 
SELECT stadium_polygons.name as stadium_name, parking_polygons.name as parking_name
 FROM stadium_polygons LEFT JOIN parking_polygons 
   ON ST_DWithin(stadium_polygons.way, parking_polygons.way, 100)
   WHERE parking_polygons.osm_id IS NULL;

-- Create a table of stadiums that do not have any parking polygons with parking aisles within 100 meters (about 330 ft)
drop table if exists stadiums_without_nearby_parking_aisles;
create table stadiums_without_nearby_parking_aisles as 
SELECT stadium_polygons.name as stadium_name, parking_aisles.name as parking_aisle_name
 FROM stadium_polygons LEFT JOIN parking_aisles 
   ON ST_DWithin(stadium_polygons.way, parking_aisles.way, 100)
   WHERE parking_aisles.osm_id IS NULL;


-- Create a table to store the number of stadiums and percentages with parking and parking aisles
drop table if exists stadium_eval;
create table stadium_eval (query_name text, value real);
insert into stadium_eval (query_name, value) values ('stadium_polygons', (select count (*) from stadium_polygons));
insert into stadium_eval (query_name, value) values ('stadium_without_parking_nearby', (select count(*) from stadiums_without_nearby_parking));
insert into stadium_eval (query_name, value) values ('stadium_without_parking_aisles_nearby', (select count(*) from stadiums_without_nearby_parking_aisles));
insert into stadium_eval (query_name, value) values ('stadium_with_nearby_parking_pct', ((1 -(select value from stadium_eval where query_name = 'stadium_without_parking_nearby')/(select value from stadium_eval where query_name = 'stadium_polygons'))*100)); 
insert into stadium_eval (query_name, value) values ('stadium_with_nearby_parking_aisles_pct', ((1 -(select value from stadium_eval where query_name = 'stadium_without_parking_aisles_nearby')/(select value from stadium_eval where query_name = 'stadium_polygons'))*100));


select * from stadium_eval;




