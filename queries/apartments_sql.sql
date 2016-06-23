drop table if exists apartments;
create table apartments (query_name text, value real);

insert into apartments (query_name, value) values ('apartment_points', (select count(*) from planet_osm_point where building in ('apartment', 'apartments') and osm_id > 0));

insert into apartments (query_name, value) values ('apartment_polygons', (select count(*) from planet_osm_polygon where building in ('apartment', 'apartments') and osm_id > 0));

insert into apartments (query_name, value) values ('apartment_total', (select sum(value) from apartments where query_name in ('apartment_points', 'apartment_polygons')));

insert into apartments (query_name, value) values ('apartment_points_named', (select count(*) from planet_osm_point where building in ('apartment', 'apartments') and name is not null and osm_id > 0));

insert into apartments (query_name, value) values ('apartment_polygons_named', (select count(*) from planet_osm_polygon where building in ('apartment', 'apartments') and name is not null and osm_id > 0));

insert into apartments (query_name, value) values ('apartment_named_total', (select sum(value) from apartments where query_name in ('apartment_points_named', 'apartment_polygons_named')));

insert into apartments (query_name, value) values ('apartment_named_pct', (((select value from apartments where query_name = 'apartment_named_total')/(select value from apartments where query_name = 'apartment_total')) *100));

insert into apartments (query_name, value) values ('apartment_points_new', (select count(*) from planet_osm_point where building in ('apartment', 'apartments') and osm_id > 0 and osm_timestamp > '2016-01-08 21:50:00-08'));

insert into apartments (query_name, value) values ('apartment_polygons_new', (select count(*) from planet_osm_polygon where building in ('apartment', 'apartments') and osm_id > 0 and osm_timestamp > '2016-01-08 21:50:00-08'));

insert into apartments (query_name, value) values ('apartment_total_new', (select sum(value) from apartments where query_name in ('apartment_points_new', 'apartment_polygons_new')));

insert into apartments (query_name, value) values ('apartment_points_named_new', (select count(*) from planet_osm_point where building in ('apartment', 'apartments') and name is not null and osm_id > 0 and osm_timestamp > '2016-01-08 21:50:00-08'));

insert into apartments (query_name, value) values ('apartment_polygons_named_new', (select count(*) from planet_osm_polygon where building in ('apartment', 'apartments') and name is not null and osm_id > 0 and osm_timestamp > '2016-01-08 21:50:00-08'));

insert into apartments (query_name, value) values ('apartment_named_total_new', (select sum(value) from apartments where query_name in ('apartment_points_named_new', 'apartment_polygons_named_new')));

insert into apartments (query_name, value) values ('apartment_named_pct_new', (((select value from apartments where query_name = 'apartment_named_total_new')/(select value from apartments where query_name = 'apartment_total_new')) *100));