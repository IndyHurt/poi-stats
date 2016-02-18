drop table if exists lodging;
create table lodging (query_name text, value real);

insert into lodging (query_name, value) values ('lodging_points', (select count(*) from planet_osm_point where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0));

insert into lodging (query_name, value) values ('lodging_polygons', (select count(*) from planet_osm_polygon where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0));

insert into lodging (query_name, value) values ('lodging_points_with_housenumber', (select count(*) from planet_osm_point where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0 and "addr:housenumber" is not null));

insert into lodging (query_name, value) values ('lodging_polygons_with_housenumber', (select count(*) from planet_osm_polygon where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0 and "addr:housenumber" is not null));

insert into lodging (query_name, value) values ('lodging_points_with_website', (select count(*) from planet_osm_point where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into lodging (query_name, value) values ('lodging_polygons_with_website', (select count(*) from planet_osm_polygon where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0 and (tags ? 'website' or tags ? 'url')));

insert into lodging (query_name, value) values ('lodging_points_with_phone_number', (select count(*) from planet_osm_point where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0 and (tags ? 'phone')));

insert into lodging (query_name, value) values ('lodging_polygons_with_phone_number', (select count(*) from planet_osm_polygon where (tourism in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or building in ('hotel', 'hostel', 'hotel', 'chalet', 'guest_house') or amenity in ('love_hotel', 'motel') or (tags ? 'guest_house=bed_and_breakfast')) and osm_id > 0 and (tags ? 'phone')));

insert into lodging (query_name, value) values ('lodging_total', (select sum(value) from lodging where query_name = 'lodging_points' or query_name = 'lodging_polygons'));

insert into lodging (query_name, value) values ('lodging_with_address_total', (select sum(value) from lodging where query_name = 'lodging_points_with_housenumber' or query_name = 'lodging_polygons_with_housenumber'));

insert into lodging (query_name, value) values ('lodging_with_website_total', (select sum(value) from lodging where query_name = 'lodging_points_with_website' or query_name = 'lodging_polygons_with_website'));

insert into lodging (query_name, value) values ('lodging_with_phone_number_total', (select sum(value) from lodging where query_name = 'lodging_points_with_phone_number' or query_name = 'lodging_polygons_with_phone_number'));

insert into lodging (query_name, value) values ('lodging_with_address_pct', (((select value from lodging where query_name = 'lodging_with_address_total')/(select value from lodging where query_name = 'lodging_total')) *100));

insert into lodging (query_name, value) values ('lodging_with_website_pct', (((select value from lodging where query_name = 'lodging_with_website_total')/(select value from lodging where query_name = 'lodging_total')) *100));

insert into lodging (query_name, value) values ('lodging_with_phone_number_pct', (((select value from lodging where query_name = 'lodging_with_phone_number_total')/(select value from lodging where query_name = 'lodging_total')) *100));

select * from lodging

