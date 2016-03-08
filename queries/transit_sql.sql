drop table if exists transit;
create table transit (query_name text, value real);	

-- Investigating the Railway key	

-- Calculate the length of funiculars, light rails, monorails, rails, subways and trams associated with the railway key for all ways

insert into transit (query_name, value) values ('railway_funicular_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'funicular' and osm_id > 0));

insert into transit (query_name, value) values ('railway_light_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and osm_id > 0));

insert into transit (query_name, value) values ('railway_monorail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'monorail' and osm_id > 0));	

insert into transit (query_name, value) values ('railway_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and osm_id > 0));

insert into transit (query_name, value) values ('railway_subway_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and osm_id > 0));

insert into transit (query_name, value) values ('railway_tram_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'tram' and osm_id > 0));	

insert into transit (query_name, value) values ('railway_all_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('funicular', 'light_rail', 'monorail', 'rail', 'subway', 'tram') and osm_id > 0));

-- Calculate the number of unique names for funiculars, light rails, monorails, rails, subways and trams associated with the railway key for all ways.  Do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('railway_funicular_way_names', (select count (distinct name) from planet_osm_line where railway = 'funicular' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_light_rail_way_names', (select count (distinct name) from planet_osm_line where railway = 'light_rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_monorail_way_names', (select count (distinct name) from planet_osm_line where railway = 'monorail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_rail_way_names', (select count (distinct name) from planet_osm_line where railway = 'rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_subway_way_names', (select count (distinct name) from planet_osm_line where railway = 'subway' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('railway_tram_way_names', (select count (distinct name) from planet_osm_line where railway = 'tram' and name is not null and osm_id > 0));	

insert into transit (query_name, value) values ('railway_all_way_names', (select count (distinct name) from planet_osm_line where railway in ('funicular', 'light_rail', 'monorail', 'rail', 'subway', 'tram') and name is not null and osm_id > 0));

--Calculate the length of funiculars, light rails, monorails, rails, subways and trams associated with the railway key that also have the color tag for all ways

insert into transit (query_name, value) values ('railway_funicular_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'funicular' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_light_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_monorail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'monorail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_subway_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_tram_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'tram' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('railway_all_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('funicular', 'light_rail', 'monorail', 'rail', 'subway', 'tram') and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

--Calculate the percentage of length that has the color tag for funiculars, light rails, monorails, rails, subways and trams associated with the railway key for all ways

insert into transit (query_name, value) values ('railway_funicular_color_way_km_pct', (((select value from transit where query_name = 'railway_funicular_color_way_km')/(select value from transit where query_name = 'railway_funicular_way_km')) *100));

insert into transit (query_name, value) values ('railway_light_rail_color_way_km_pct', (((select value from transit where query_name = 'railway_light_rail_color_way_km')/(select value from transit where query_name = 'railway_light_rail_way_km')) *100));

insert into transit (query_name, value) values ('railway_monorail_color_way_km_pct', (((select value from transit where query_name = 'railway_monorail_color_way_km')/(select value from transit where query_name = 'railway_monorail_way_km')) *100));	

insert into transit (query_name, value) values ('railway_rail_color_way_km_pct', (((select value from transit where query_name = 'railway_rail_color_way_km')/(select value from transit where query_name = 'railway_rail_way_km')) *100));

insert into transit (query_name, value) values ('railway_subway_color_way_km_pct', (((select value from transit where query_name = 'railway_subway_color_way_km')/(select value from transit where query_name = 'railway_subway_way_km')) *100));

insert into transit (query_name, value) values ('railway_tram_color_way_km_pct', (((select value from transit where query_name = 'railway_tram_color_way_km')/(select value from transit where query_name = 'railway_tram_way_km')) *100));	

insert into transit (query_name, value) values ('railway_all_color_way_km_pct', (((select value from transit where query_name = 'railway_all_color_way_km')/(select value from transit where query_name = 'railway_all_way_km')) *100));
	
-- Calculate the length of funiculars, light rails, monorails, rails, subways and trams associated with the railway key for all relations

insert into transit (query_name, value) values ('railway_funicular_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'funicular' and osm_id < 0));

insert into transit (query_name, value) values ('railway_light_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and osm_id < 0));

insert into transit (query_name, value) values ('railway_monorail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'monorail' and osm_id < 0));	

insert into transit (query_name, value) values ('railway_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and osm_id < 0));

insert into transit (query_name, value) values ('railway_subway_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and osm_id < 0));

insert into transit (query_name, value) values ('railway_tram_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'tram' and osm_id < 0));	

insert into transit (query_name, value) values ('railway_all_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('funicular', 'light_rail', 'monorail', 'rail', 'subway', 'tram') and osm_id < 0));
	
-- Calculate the number of unique names for funiculars, light rails, monorails, rails, subways and trams associated with the railway key for all relations - do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('railway_funicular_rel_names', (select count (distinct name) from planet_osm_line where railway = 'funicular' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_light_rail_rel_names', (select count (distinct name) from planet_osm_line where railway = 'light_rail' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_monorail_rel_names', (select count (distinct name) from planet_osm_line where railway = 'monorail' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('railway_rail_rel_names', (select count (distinct name) from planet_osm_line where railway = 'rail' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_subway_rel_names', (select count (distinct name) from planet_osm_line where railway = 'subway' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_tram_rel_names', (select count (distinct name) from planet_osm_line where railway = 'tram' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('railway_all_rel_names', (select count (distinct name) from planet_osm_line where railway in ('funicular', 'light_rail', 'monorail', 'rail', 'subway', 'tram') and name is not null and osm_id < 0));

--Calculate the length of funiculars, light rails, monorails, rails, subways and trams associated with the railway key that also have the color tag for all relations

insert into transit (query_name, value) values ('railway_funicular_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'funicular' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_light_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'light_rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_monorail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'monorail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('railway_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_subway_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'subway' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('railway_tram_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway = 'tram' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('railway_all_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where railway in ('funicular', 'light_rail', 'monorail', 'rail', 'subway', 'tram') and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

--Calculate the percentage of length that has the color tag for funiculars, light rails, monorails, rails, subways and trams associated with the railway key for all relations

insert into transit (query_name, value) values ('railway_funicular_color_rel_km_pct', (((select value from transit where query_name = 'railway_funicular_color_rel_km')/(select value from transit where query_name = 'railway_funicular_rel_km')) *100));

insert into transit (query_name, value) values ('railway_light_rail_color_rel_km_pct', (((select value from transit where query_name = 'railway_light_rail_color_rel_km')/(select value from transit where query_name = 'railway_light_rail_rel_km')) *100));

insert into transit (query_name, value) values ('railway_monorail_color_rel_km_pct', (((select value from transit where query_name = 'railway_monorail_color_rel_km')/(select value from transit where query_name = 'railway_monorail_rel_km')) *100));

insert into transit (query_name, value) values ('railway_rail_color_rel_km_pct', (((select value from transit where query_name = 'railway_rail_color_rel_km')/(select value from transit where query_name = 'railway_rail_rel_km')) *100));

insert into transit (query_name, value) values ('railway_subway_color_rel_km_pct', (((select value from transit where query_name = 'railway_subway_color_rel_km')/(select value from transit where query_name = 'railway_subway_rel_km')) *100));

insert into transit (query_name, value) values ('railway_tram_color_rel_km_pct', (((select value from transit where query_name = 'railway_tram_color_rel_km')/(select value from transit where query_name = 'railway_tram_rel_km')) *100));	
	
insert into transit (query_name, value) values ('railway_all_color_rel_km_pct', (((select value from transit where query_name = 'railway_all_color_rel_km')/(select value from transit where query_name = 'railway_all_rel_km')) *100));	


-- Investigating the Route key

-- Calculate the length of buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key for all ways

insert into transit (query_name, value) values ('route_bus_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bus' and osm_id > 0));

insert into transit (query_name, value) values ('route_funicular_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'funicular' and osm_id > 0));	

insert into transit (query_name, value) values ('route_light_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and osm_id > 0));

insert into transit (query_name, value) values ('route_monorail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'monorail' and osm_id > 0));	

insert into transit (query_name, value) values ('route_rail_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and osm_id > 0));

insert into transit (query_name, value) values ('route_railway_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and osm_id > 0));
	
insert into transit (query_name, value) values ('route_subway_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and osm_id > 0));

insert into transit (query_name, value) values ('route_train_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and osm_id > 0));	

insert into transit (query_name, value) values ('route_trolleybus_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'trolleybus' and osm_id > 0));

insert into transit (query_name, value) values ('route_tram_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'tram' and osm_id > 0));	

insert into transit (query_name, value) values ('route_all_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('bus', 'funicular', 'light_rail', 'monorail', 'rail', 'railway', 'subway', 'train', 'trolleybus', 'tram') and osm_id > 0));

-- Calculate the number of unique names for buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key for all ways - do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('route_bus_way_names', (select count (distinct name) from planet_osm_line where route = 'bus' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_funicular_way_names', (select count (distinct name) from planet_osm_line where route = 'funicular' and name is not null and osm_id > 0));	

insert into transit (query_name, value) values ('route_light_rail_way_names', (select count (distinct name) from planet_osm_line where route = 'light_rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_monorail_way_names', (select count (distinct name) from planet_osm_line where route = 'monorail' and name is not null and osm_id > 0));	

insert into transit (query_name, value) values ('route_rail_way_names', (select count (distinct name) from planet_osm_line where route = 'rail' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_railway_way_names', (select count (distinct name) from planet_osm_line where route = 'railway' and name is not null and osm_id > 0));
	
insert into transit (query_name, value) values ('route_subway_way_names', (select count (distinct name) from planet_osm_line where route = 'subway' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_train_way_names', (select count (distinct name) from planet_osm_line where route = 'train' and name is not null and osm_id > 0));

insert into transit (query_name, value) values ('route_trolleybus_way_names', (select count (distinct name) from planet_osm_line where route = 'trolleybus' and name is not null and osm_id > 0));	

insert into transit (query_name, value) values ('route_tram_way_names', (select count (distinct name) from planet_osm_line where route = 'tram' and name is not null and osm_id > 0));	

insert into transit (query_name, value) values ('route_all_way_names', (select count (distinct name) from planet_osm_line where route in ('bus', 'funicular', 'light_rail', 'monorail', 'rail', 'railway', 'subway', 'train', 'trolleybus', 'tram') and name is not null and osm_id > 0));

--Calculate the length of buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key that also have the color tag for all ways

insert into transit (query_name, value) values ('route_bus_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bus' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_funicular_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'funicular' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));	

insert into transit (query_name, value) values ('route_light_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_monorail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'monorail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));	

insert into transit (query_name, value) values ('route_rail_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_railway_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));
	
insert into transit (query_name, value) values ('route_subway_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_train_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

insert into transit (query_name, value) values ('route_trolleybus_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'trolleybus' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));	

insert into transit (query_name, value) values ('route_tram_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'tram' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));	

insert into transit (query_name, value) values ('route_all_color_way_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('bus', 'funicular', 'light_rail', 'monorail', 'rail', 'railway', 'subway', 'train', 'trolleybus', 'tram') and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id > 0));

--Calculate the percentage of length that has the color tag for buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key for all ways

insert into transit (query_name, value) values ('route_bus_color_way_km_pct', (((select value from transit where query_name = 'route_bus_color_way_km')/(select value from transit where query_name = 'route_bus_way_km')) *100));

insert into transit (query_name, value) values ('route_funicular_color_way_km_pct', (((select value from transit where query_name = 'route_funicular_color_way_km')/(select value from transit where query_name = 'route_funicular_way_km')) *100));	

insert into transit (query_name, value) values ('route_light_rail_color_way_km_pct', (((select value from transit where query_name = 'route_light_rail_color_way_km')/(select value from transit where query_name = 'route_light_rail_way_km')) *100));

insert into transit (query_name, value) values ('route_monorail_color_way_km_pct', (((select value from transit where query_name = 'route_monorail_color_way_km')/(select value from transit where query_name = 'route_monorail_way_km')) *100));	

insert into transit (query_name, value) values ('route_rail_color_way_km_pct', (((select value from transit where query_name = 'route_rail_color_way_km')/(select value from transit where query_name = 'route_rail_way_km')) *100));

insert into transit (query_name, value) values ('route_railway_color_way_km_pct', (((select value from transit where query_name = 'route_railway_color_way_km')/(select value from transit where query_name = 'route_railway_way_km')) *100));
	
insert into transit (query_name, value) values ('route_subway_color_way_km_pct', (((select value from transit where query_name = 'route_subway_color_way_km')/(select value from transit where query_name = 'route_subway_way_km')) *100));
	
insert into transit (query_name, value) values ('route_train_color_way_km_pct', (((select value from transit where query_name = 'route_train_color_way_km')/(select value from transit where query_name = 'route_train_way_km')) *100));	

insert into transit (query_name, value) values ('route_tram_color_way_km_pct', (((select value from transit where query_name = 'route_tram_color_way_km')/(select value from transit where query_name = 'route_tram_way_km')) *100));

insert into transit (query_name, value) values ('route_trolleybus_color_way_km_pct', (((select value from transit where query_name = 'route_trolleybus_color_way_km')/(select value from transit where query_name = 'route_trolleybus_way_km')) *100));	

insert into transit (query_name, value) values ('route_all_color_way_km_pct', (((select value from transit where query_name = 'route_all_color_way_km')/(select value from transit where query_name = 'route_all_way_km')) *100));

-- Calculate the length of buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key for all relations

insert into transit (query_name, value) values ('route_bus_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bus' and osm_id < 0));

insert into transit (query_name, value) values ('route_funicular_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'funicular' and osm_id < 0));	

insert into transit (query_name, value) values ('route_light_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and osm_id < 0));

insert into transit (query_name, value) values ('route_monorail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'monorail' and osm_id < 0));	

insert into transit (query_name, value) values ('route_rail_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and osm_id < 0));

insert into transit (query_name, value) values ('route_railway_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and osm_id < 0));
	
insert into transit (query_name, value) values ('route_subway_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and osm_id < 0));
	
insert into transit (query_name, value) values ('route_train_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and osm_id < 0));	

insert into transit (query_name, value) values ('route_trolleybus_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'trolleybus' and osm_id < 0));	

insert into transit (query_name, value) values ('route_tram_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'tram' and osm_id < 0));	

insert into transit (query_name, value) values ('route_all_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('bus', 'funicular', 'light_rail', 'monorail', 'rail', 'railway', 'subway', 'train', 'trolleybus', 'tram') and osm_id < 0));

-- Calculate the number of unique names for buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key for all relations - do the counts seem reasonable?  Extremely high numbers could mean inconsistant naming and spelling.

insert into transit (query_name, value) values ('route_bus_rel_names', (select count (distinct name) from planet_osm_line where route = 'bus' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_funicular_rel_names', (select count (distinct name) from planet_osm_line where route = 'funicular' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('route_light_rail_rel_names', (select count (distinct name) from planet_osm_line where route = 'light_rail' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_monorail_rel_names', (select count (distinct name) from planet_osm_line where route = 'monorail' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('route_rail_rel_names', (select count (distinct name) from planet_osm_line where route = 'rail' and name is not null and osm_id < 0));
	
insert into transit (query_name, value) values ('route_railway_rel_names', (select count (distinct name) from planet_osm_line where route = 'railway' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('route_subway_rel_names', (select count (distinct name) from planet_osm_line where route = 'subway' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_train_rel_names', (select count (distinct name) from planet_osm_line where route = 'train' and name is not null and osm_id < 0));

insert into transit (query_name, value) values ('route_trolleybus_rel_names', (select count (distinct name) from planet_osm_line where route = 'trolleybus' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('route_tram_rel_names', (select count (distinct name) from planet_osm_line where route = 'tram' and name is not null and osm_id < 0));	

insert into transit (query_name, value) values ('route_all_rel_names', (select count (distinct name) from planet_osm_line where route in ('bus', 'funicular', 'light_rail', 'monorail', 'rail', 'railway', 'subway', 'train', 'trolleybus', 'tram') and name is not null and osm_id < 0));

--Calculate the length of buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key that also have the color tag for all relations

insert into transit (query_name, value) values ('route_bus_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'bus' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('route_funicular_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'funicular' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('route_light_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'light_rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('route_monorail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'monorail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('route_rail_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'rail' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

insert into transit (query_name, value) values ('route_railway_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'railway' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));
	
insert into transit (query_name, value) values ('route_subway_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'subway' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));
	
insert into transit (query_name, value) values ('route_train_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'train' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('route_trolleybus_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'trolleybus' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('route_tram_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route = 'tram' and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));	

insert into transit (query_name, value) values ('route_all_color_rel_km', (select sum(st_length(way))/1000 from planet_osm_line where route in ('bus', 'funicular', 'light_rail', 'monorail', 'rail', 'railway', 'subway', 'train', 'trolleybus', 'tram') and (tags ?| array ['color', 'colour', 'gtfs_route_color', 'gtfs_route_colour']) and osm_id < 0));

--Calculate the percentage of length that has the color tag for buses, funiculars, light rails, monorails, rails, railways, subways, trains, trolleybuses, and trams associated with the route key for all relations

insert into transit (query_name, value) values ('route_bus_color_rel_km_pct', (((select value from transit where query_name = 'route_bus_color_rel_km')/(select value from transit where query_name = 'route_bus_rel_km')) *100));

insert into transit (query_name, value) values ('route_funicular_color_rel_km_pct', (((select value from transit where query_name = 'route_funicular_color_rel_km')/(select value from transit where query_name = 'route_funicular_rel_km')) *100));	

insert into transit (query_name, value) values ('route_light_rail_color_rel_km_pct', (((select value from transit where query_name = 'route_light_rail_color_rel_km')/(select value from transit where query_name = 'route_light_rail_rel_km')) *100));

insert into transit (query_name, value) values ('route_monorail_color_rel_km_pct', (((select value from transit where query_name = 'route_monorail_color_rel_km')/(select value from transit where query_name = 'route_monorail_rel_km')) *100));	

insert into transit (query_name, value) values ('route_rail_color_rel_km_pct', (((select value from transit where query_name = 'route_rail_color_rel_km')/(select value from transit where query_name = 'route_rail_rel_km')) *100));

insert into transit (query_name, value) values ('route_railway_color_rel_km_pct', (((select value from transit where query_name = 'route_railway_color_rel_km')/(select value from transit where query_name = 'route_railway_rel_km')) *100));
	
insert into transit (query_name, value) values ('route_subway_color_rel_km_pct', (((select value from transit where query_name = 'route_subway_color_rel_km')/(select value from transit where query_name = 'route_subway_rel_km')) *100));
	
insert into transit (query_name, value) values ('route_train_color_rel_km_pct', (((select value from transit where query_name = 'route_train_color_rel_km')/(select value from transit where query_name = 'route_train_rel_km')) *100));	

insert into transit (query_name, value) values ('route_trolleybus_color_rel_km_pct', (((select value from transit where query_name = 'route_trolleybus_color_rel_km')/(select value from transit where query_name = 'route_trolleybus_rel_km')) *100));	

insert into transit (query_name, value) values ('route_tram_color_rel_km_pct', (((select value from transit where query_name = 'route_tram_color_rel_km')/(select value from transit where query_name = 'route_tram_rel_km')) *100));	

insert into transit (query_name, value) values ('route_all_color_rel_km_pct', (((select value from transit where query_name = 'route_all_color_rel_km')/(select value from transit where query_name = 'route_all_rel_km')) *100));

select * from transit;
