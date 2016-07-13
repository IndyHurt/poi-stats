-- Create a table of stadium polygons that are larger than 2000 square meters
drop table if exists stadium_polygons;
create table stadium_polygons as select osm_id, name, building, landuse, leisure, sport, tags, way from planet_osm_polygon where (osm_id > 0 and way_area > 2000) and (leisure = 'stadium' or building = 'stadium');


-- Create a table of stadium polygons that are larger than 2000 square meters new or modified since post
drop table if exists stadium_polygons_new;
create table stadium_polygons_new as select osm_id, name, building, landuse, leisure, sport, tags, way from planet_osm_polygon where (osm_id > 0 and way_area > 2000) and (leisure = 'stadium' or building = 'stadium') and osm_timestamp > '2016-02-04 14:00:00-08';


-- Create a table of parking polygons 
drop table if exists parking_polygons;
create table parking_polygons as select osm_id, name, landuse, amenity, tags, way from planet_osm_polygon where osm_id > 0 and amenity = 'parking';


-- Create a table of parking polygons new or modified since post
drop table if exists parking_polygons_new;
create table parking_polygons_new as select osm_id, name, landuse, amenity, tags, way from planet_osm_polygon where osm_id > 0 and amenity = 'parking' and osm_timestamp > '2016-02-04 14:00:00-08';


-- Create a table of parking aisles
drop table if exists parking_aisles;
create table parking_aisles as select osm_id, name, amenity, highway, service, tags, way from planet_osm_line where osm_id > 0 and service = 'parking_aisle';


-- Create a table of parking aisles new or modified since post
drop table if exists parking_aisles_new;
create table parking_aisles_new as select osm_id, name, amenity, highway, service, tags, way from planet_osm_line where osm_id > 0 and service = 'parking_aisle' and osm_timestamp > '2016-02-04 14:00:00-08';


-- Create indices to speed up queries
analyze parking_polygons;
analyze stadium_polygons;

create index parking_polygons_gist_idx on parking_polygons using gist(way);
create index parking_aisles_gist_idx on parking_aisles using gist(way);

-- Create indices to speed up queries for new or modified since post
analyze parking_polygons_new;
analyze stadium_polygons_new;

create index parking_polygons_gist_idx_new on parking_polygons_new using gist(way);
create index parking_aisles_gist_idx_new on parking_aisles_new using gist(way);


-- Create a table of stadiums that do not have any parking polygons within 100 meters (about 330 ft) 
drop table if exists stadiums_without_nearby_parking;
create table stadiums_without_nearby_parking as 
SELECT stadium_polygons.name as stadium_name, parking_polygons.name as parking_name
 FROM stadium_polygons LEFT JOIN parking_polygons 
   ON ST_DWithin(stadium_polygons.way, parking_polygons.way, 100)
   WHERE parking_polygons.osm_id IS NULL;
  

-- Create a table of stadiums that do not have any parking polygons within 100 meters (about 330 ft) considering new or modified since post
drop table if exists stadiums_without_nearby_parking_new;
create table stadiums_without_nearby_parking_new as 
SELECT stadium_polygons_new.name as stadium_name_new, parking_polygons_new.name as parking_name_new
 FROM stadium_polygons_new LEFT JOIN parking_polygons_new 
   ON ST_DWithin(stadium_polygons_new.way, parking_polygons_new.way, 100)
   WHERE parking_polygons_new.osm_id IS NULL;  
 

-- Create a table of stadiums that do not have any parking polygons with parking aisles within 100 meters (about 330 ft)
drop table if exists stadiums_without_nearby_parking_aisles;
create table stadiums_without_nearby_parking_aisles as 
SELECT stadium_polygons.name as stadium_name, parking_aisles.name as parking_aisle_name
 FROM stadium_polygons LEFT JOIN parking_aisles 
   ON ST_DWithin(stadium_polygons.way, parking_aisles.way, 100)
   WHERE parking_aisles.osm_id IS NULL;
 

-- Create a table of stadiums that do not have any parking polygons with parking aisles within 100 meters (about 330 ft) considering new or modified since post
drop table if exists stadiums_without_nearby_parking_aisles_new;
create table stadiums_without_nearby_parking_aisles_new as 
SELECT stadium_polygons_new.name as stadium_name_new, parking_aisles_new.name as parking_aisle_name_new
 FROM stadium_polygons_new LEFT JOIN parking_aisles_new 
   ON ST_DWithin(stadium_polygons_new.way, parking_aisles_new.way, 100)
   WHERE parking_aisles_new.osm_id IS NULL;
 

-- Create a table of parking polygon counts near stadiums that have been added or edited since the post
drop table if exists stadiums_new_parking;
create table stadiums_new_parking as 
SELECT count(*) as new_stadium_parking
 FROM stadium_polygons LEFT JOIN parking_polygons_new 
   ON ST_DWithin(stadium_polygons.way, parking_polygons_new.way, 100)
   WHERE parking_polygons_new.osm_id IS NOT NULL;
     

-- Create a table of parking aisle counts near stadiums that have been added or edited since the post
drop table if exists stadiums_new_parking_aisles;
create table stadiums_new_parking_aisles as 
SELECT count(*) as new_stadium_parking_aisles
 FROM stadium_polygons LEFT JOIN parking_aisles_new 
   ON ST_DWithin(stadium_polygons.way, parking_aisles_new.way, 100)
   WHERE parking_aisles_new.osm_id IS NOT NULL;
    

-- Create a table to store the number of stadiums and percentages with parking and parking aisles
drop table if exists stadium_eval;
create table stadium_eval (query_name text, value real);
insert into stadium_eval (query_name, value) values ('stadium_polygons', (select count (*) from stadium_polygons));
insert into stadium_eval (query_name, value) values ('stadium_without_parking_nearby', (select count(*) from stadiums_without_nearby_parking));
insert into stadium_eval (query_name, value) values ('stadium_without_parking_aisles_nearby', (select count(*) from stadiums_without_nearby_parking_aisles));
insert into stadium_eval (query_name, value) values ('stadium_with_nearby_parking_pct', ((1 -(select value from stadium_eval where query_name = 'stadium_without_parking_nearby')/(select value from stadium_eval where query_name = 'stadium_polygons'))*100)); 
insert into stadium_eval (query_name, value) values ('stadium_with_nearby_parking_aisles_pct', ((1 -(select value from stadium_eval where query_name = 'stadium_without_parking_aisles_nearby')/(select value from stadium_eval where query_name = 'stadium_polygons'))*100));
insert into stadium_eval (query_name, value) values ('stadium_polygons_new', (select count (*) from stadium_polygons_new));
insert into stadium_eval (query_name, value) values ('stadium_without_parking_nearby_new', (select count(*) from stadiums_without_nearby_parking_new));
insert into stadium_eval (query_name, value) values ('stadium_without_parking_aisles_nearby_new', (select count(*) from stadiums_without_nearby_parking_aisles_new));
insert into stadium_eval (query_name, value) values ('stadium_with_nearby_parking_pct_new', ((1 -(select value from stadium_eval where query_name = 'stadium_without_parking_nearby_new')/(select value from stadium_eval where query_name = 'stadium_polygons_new'))*100)); 
insert into stadium_eval (query_name, value) values ('stadium_with_nearby_parking_aisles_pct_new', ((1 -(select value from stadium_eval where query_name = 'stadium_without_parking_aisles_nearby_new')/(select value from stadium_eval where query_name = 'stadium_polygons_new'))*100));
insert into stadium_eval (query_name, value) values ('stadiums_new_parking', (select new_stadium_parking from stadiums_new_parking));
insert into stadium_eval (query_name, value) values ('stadiums_new_parking_aisles', (select new_stadium_parking_aisles from stadiums_new_parking_aisles));

select * from stadium_eval;