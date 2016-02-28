--Questions:  How many transit related features are there, and what percentage have color?

--Evaluate the ways:
	--What percentage of the transit ways have a populated color/colour tag?
	--How many distinct names are there?  (number of lines and is it close to what is expected?)
--Evaluate the relations:
	--What percentage of the transit ways are part of a relation?
	--What percentage of the relations have a populated color/colour tag?
	
-- Identifying transit related colors associated with the railway tag on ways
drop table if exists transit_railway_ways;
create table transit_railway_ways as 
select railway, count(*) as total, sum(st_length(way))/1000 as km_ways, count(tags->'colour') as
num_colour, count(tags->'color') as num_color from planet_osm_line
where railway in ('rail', 'subway', 'light_rail') and osm_id > 0 group by railway;

select * from transit_railway_ways;

-- Identifying transit related colors associated with the railway tag on relations
drop table if exists transit_railway_relations;
create table transit_railway_relations as
select railway, count(*) as total, sum(st_length(way))/1000 as km_relations, count(tags->'colour') as
num_colour, count(tags->'color') as num_color from planet_osm_line
where railway in ('rail', 'subway', 'light_rail') and osm_id < 0 group by railway;

select * from transit_railway_relations;

-- Identifying transit related colors associated with the route tag on ways
drop table if exists transit_route_ways;
create table transit_route_ways as
select route, count(*) as total, sum(st_length(way))/1000 as km_ways, count(tags->'colour') as
num_colour, count(tags->'color') as num_color from planet_osm_line
where route in ('rail', 'train', 'railway', 'subway', 'light_rail') and osm_id > 0
group by route;

select * from transit_route_ways;

-- Identifying transit related colors associated with the route tag on relations
drop table if exists transit_route_relations;
create table transit_route_relations as
select route, count(*) as total, sum(st_length(way))/1000 as km_relations, count(tags->'colour') as
num_colour, count(tags->'color') as num_color from planet_osm_line
where route in ('rail', 'train', 'railway', 'subway', 'light_rail') and osm_id < 0
group by route;

select * from transit_railway_ways;
