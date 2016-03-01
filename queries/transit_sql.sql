﻿drop table if exists transit;
create table transit (query_name text, value real);

-- Investigating the Railway key	

-- Calculate the length of light rails, rails, and subways associated with the railway key for all ways

insert into transit (query_name, value) values ('railway_light_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and osm_id > 0));

insert into transit (query_name, value) values ('railway_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and osm_id > 0));

insert into transit (query_name, value) values ('railway_subway_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and osm_id > 0));

insert into transit (query_name, value) values ('railway_all_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('light_rail', 'rail', 'subway') and osm_id > 0));

-- Calculate the number of unique names for light rails, rails, and subways associated with the railway key for all ways.  Do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('railway_light_rail_way_names', (select count (distinct name) from planet_osm_line where railway = 'light_rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_rail_way_names', (select count (distinct name) from planet_osm_line where railway = 'rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_subway_way_names', (select count (distinct name) from planet_osm_line where railway = 'subway' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_all_way_names', (select count (distinct name) from planet_osm_line where railway in ('light_rail', 'rail', 'subway') and name is not null and osm_id > 0));

--Calculate the length of light rails, rails and subways associated with the railway key that also have the color tag for all ways

insert into transit (query_name, value) values ('railway_light_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and (tags ?| array ['color', 'colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and (tags ?| array ['color', 'colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_subway_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and (tags ?| array ['color', 'colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_all_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('light_rail', 'rail', 'subway') and (tags ?| array ['color', 'colour']) and osm_id > 0));

--Calculate the percentage of length that has the color tag for light rails, rails and subways associated with the railway key for all ways

insert into transit (query_name, value) values ('railway_light_rail_color_way_km_pct', (((select value from transit where query_name = 'railway_light_rail_color_way_km')/(select value from transit where query_name = 'railway_light_rail_way_km')) *100));

insert into transit (query_name, value) values ('railway_rail_color_way_km_pct', (((select value from transit where query_name = 'railway_rail_color_way_km')/(select value from transit where query_name = 'railway_rail_way_km')) *100));

insert into transit (query_name, value) values ('railway_subway_color_way_km_pct', (((select value from transit where query_name = 'railway_subway_color_way_km')/(select value from transit where query_name = 'railway_subway_way_km')) *100));
	
insert into transit (query_name, value) values ('railway_all_color_way_km_pct', (((select value from transit where query_name = 'railway_all_color_way_km')/(select value from transit where query_name = 'railway_all_way_km')) *100));
	

-- Calculate the length of light rails, rails, and subways associated with the railway key for all relations

insert into transit (query_name, value) values ('railway_light_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and osm_id < 0));

insert into transit (query_name, value) values ('railway_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and osm_id < 0));

insert into transit (query_name, value) values ('railway_subway_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and osm_id < 0));

insert into transit (query_name, value) values ('railway_all_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('light_rail', 'rail', 'subway') and osm_id < 0));
	
-- Calculate the number of unique names for light rails, rails, and subways associated with the railway key for all relations - do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('railway_light_rail_rel_names', (select count (distinct name) from planet_osm_line where railway = 'light_rail' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_rail_rel_names', (select count (distinct name) from planet_osm_line where railway = 'rail' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_subway_rel_names', (select count (distinct name) from planet_osm_line where railway = 'subway' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_all_rel_names', (select count (distinct name) from planet_osm_line where railway in ('light_rail', 'rail', 'subway') and name is not null and osm_id < 0));

--Calculate the length of light rails, rails and subways associated with the railway key that also have the color tag for all relations

insert into transit (query_name, value) values ('railway_light_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and (tags ?| array ['color', 'colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and (tags ?| array ['color', 'colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_subway_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and (tags ?| array ['color', 'colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_all_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('light_rail', 'rail', 'subway') and (tags ?| array ['color', 'colour']) and osm_id < 0));

--Calculate the percentage of length that has the color tag for light rails, rails and subways associated with the railway key for all relations

insert into transit (query_name, value) values ('railway_light_rail_color_rel_km_pct', (((select value from transit where query_name = 'railway_light_rail_color_rel_km')/(select value from transit where query_name = 'railway_light_rail_rel_km')) *100));

insert into transit (query_name, value) values ('railway_rail_color_rel_km_pct', (((select value from transit where query_name = 'railway_rail_color_rel_km')/(select value from transit where query_name = 'railway_rail_rel_km')) *100));

insert into transit (query_name, value) values ('railway_subway_color_rel_km_pct', (((select value from transit where query_name = 'railway_subway_color_rel_km')/(select value from transit where query_name = 'railway_subway_rel_km')) *100));
	
insert into transit (query_name, value) values ('railway_all_color_rel_km_pct', (((select value from transit where query_name = 'railway_all_color_rel_km')/(select value from transit where query_name = 'railway_all_rel_km')) *100));	


-- Investigating the Route key

-- Calculate the length of light rails, rails, railways, subways and trains associated with the route key for all ways

insert into transit (query_name, value) values ('route_light_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and osm_id > 0));

insert into transit (query_name, value) values ('route_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and osm_id > 0));

insert into transit (query_name, value) values ('route_railway_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and osm_id > 0));
	
insert into transit (query_name, value) values ('route_subway_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and osm_id > 0));

insert into transit (query_name, value) values ('route_train_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and osm_id > 0));	

insert into transit (query_name, value) values ('route_all_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('light_rail', 'rail', 'railway', 'subway', 'train') and osm_id > 0));

-- Calculate the number of unique names for light rails, rails, railways, subways and trains associated with the route key for all ways - do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('route_light_rail_way_names', (select count (distinct name) from planet_osm_line where route = 'light_rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_rail_way_names', (select count (distinct name) from planet_osm_line where route = 'rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_railway_way_names', (select count (distinct name) from planet_osm_line where route = 'railway' and name is not null and osm_id > 0));
	
insert into transit (query_name, value) values ('route_subway_way_names', (select count (distinct name) from planet_osm_line where route = 'subway' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_train_way_names', (select count (distinct name) from planet_osm_line where route = 'train' and name is not null and osm_id > 0));	

insert into transit (query_name, value) values ('route_all_way_names', (select count (distinct name) from planet_osm_line where route in ('light_rail', 'rail', 'railway', 'subway', 'train') and name is not null and osm_id > 0));

--Calculate the length of light rails, rails, railways, subways and trains associated with the route key that also have the color tag for all ways

insert into transit (query_name, value) values ('route_light_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and (tags ?| array ['color', 'colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and (tags ?| array ['color', 'colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_railway_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and (tags ?| array ['color', 'colour']) and osm_id > 0));
	
insert into transit (query_name, value) values ('route_subway_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and (tags ?| array ['color', 'colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_train_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and (tags ?| array ['color', 'colour']) and osm_id > 0));	

insert into transit (query_name, value) values ('route_all_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('light_rail', 'rail', 'railway', 'subway', 'train') and (tags ?| array ['color', 'colour']) and osm_id > 0));

--Calculate the percentage of length that has the color tag for llight rails, rails, railways, subways and trains associated with the route key for all ways

insert into transit (query_name, value) values ('route_light_rail_color_way_km_pct', (((select value from transit where query_name = 'route_light_rail_color_way_km')/(select value from transit where query_name = 'route_light_rail_way_km')) *100));

insert into transit (query_name, value) values ('route_rail_color_way_km_pct', (((select value from transit where query_name = 'route_rail_color_way_km')/(select value from transit where query_name = 'route_rail_way_km')) *100));

insert into transit (query_name, value) values ('route_railway_color_way_km_pct', (((select value from transit where query_name = 'route_railway_color_way_km')/(select value from transit where query_name = 'route_railway_way_km')) *100));
	
insert into transit (query_name, value) values ('route_subway_color_way_km_pct', (((select value from transit where query_name = 'route_subway_color_way_km')/(select value from transit where query_name = 'route_subway_way_km')) *100));
	
insert into transit (query_name, value) values ('route_train_color_way_km_pct', (((select value from transit where query_name = 'route_train_color_way_km')/(select value from transit where query_name = 'route_train_way_km')) *100));		

insert into transit (query_name, value) values ('route_all_color_way_km_pct', (((select value from transit where query_name = 'route_all_color_way_km')/(select value from transit where query_name = 'route_all_way_km')) *100));

-- Calculate the length of light rails, rails, railways, subways and trains associated with the route key for all relations

insert into transit (query_name, value) values ('route_light_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and osm_id < 0));

insert into transit (query_name, value) values ('route_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and osm_id < 0));

insert into transit (query_name, value) values ('route_railway_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and osm_id < 0));
	
insert into transit (query_name, value) values ('route_subway_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and osm_id < 0));
	
insert into transit (query_name, value) values ('route_train_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and osm_id < 0));		

insert into transit (query_name, value) values ('route_all_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('light_rail', 'rail', 'railway', 'subway', 'train') and osm_id < 0));

-- Calculate the number of unique names for light rails, rails, railways, subways and trains associated with the route key for all relations - do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('route_light_rail_rel_names', (select count (distinct name) from planet_osm_line where route = 'light_rail' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_rail_rel_names', (select count (distinct name) from planet_osm_line where route = 'rail' and name is not null and osm_id < 0));
	
insert into transit (query_name, value) values ('route_railway_rel_names', (select count (distinct name) from planet_osm_line where route = 'railway' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('route_subway_rel_names', (select count (distinct name) from planet_osm_line where route = 'subway' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_train_rel_names', (select count (distinct name) from planet_osm_line where route = 'train' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_all_rel_names', (select count (distinct name) from planet_osm_line where route in ('light_rail', 'rail', 'railway', 'subway', 'train') and name is not null and osm_id < 0));

--Calculate the length of light rails, rails, railways, subways and trains associated with the route key that also have the color tag for all relations

insert into transit (query_name, value) values ('route_light_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and (tags ?| array ['color', 'colour']) and osm_id < 0));

insert into transit (query_name, value) values ('route_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and (tags ?| array ['color', 'colour']) and osm_id < 0));

insert into transit (query_name, value) values ('route_railway_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and (tags ?| array ['color', 'colour']) and osm_id < 0));
	
insert into transit (query_name, value) values ('route_subway_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and (tags ?| array ['color', 'colour']) and osm_id < 0));
	
insert into transit (query_name, value) values ('route_train_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and (tags ?| array ['color', 'colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('route_all_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('light_rail', 'rail', 'railway', 'subway', 'train') and (tags ?| array ['color', 'colour']) and osm_id < 0));

--Calculate the percentage of length that has the color tag for light rails, rails, railways, subways and trains associated with the route key for all relations

insert into transit (query_name, value) values ('route_light_rail_color_rel_km_pct', (((select value from transit where query_name = 'route_light_rail_color_rel_km')/(select value from transit where query_name = 'route_light_rail_rel_km')) *100));

insert into transit (query_name, value) values ('route_rail_color_rel_km_pct', (((select value from transit where query_name = 'route_rail_color_rel_km')/(select value from transit where query_name = 'route_rail_rel_km')) *100));

insert into transit (query_name, value) values ('route_railway_color_rel_km_pct', (((select value from transit where query_name = 'route_railway_color_rel_km')/(select value from transit where query_name = 'route_railway_rel_km')) *100));
	
insert into transit (query_name, value) values ('route_subway_color_rel_km_pct', (((select value from transit where query_name = 'route_subway_color_rel_km')/(select value from transit where query_name = 'route_subway_rel_km')) *100));
	
insert into transit (query_name, value) values ('route_train_color_rel_km_pct', (((select value from transit where query_name = 'route_train_color_rel_km')/(select value from transit where query_name = 'route_train_rel_km')) *100));	

insert into transit (query_name, value) values ('route_all_color_rel_km_pct', (((select value from transit where query_name = 'route_all_color_rel_km')/(select value from transit where query_name = 'route_all_rel_km')) *100));

select * from transit;
