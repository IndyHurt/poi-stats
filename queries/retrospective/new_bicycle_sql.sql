DROP TABLE IF EXISTS new_bicycle;

CREATE TABLE new_bicycle 
             ( 
                          query_name TEXT, 
                          value REAL 
             ); 

-- what's the length of bike tracks which are paths separate from the road?

INSERT INTO new_bicycle
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_track', 
                        ( 
                               SELECT Sum(St_length(way))/1000 
                               FROM   planet_osm_line 
                               WHERE  ( 
                                             highway = 'cycleway' 
                                      AND    osm_id > 0) 
                               OR     ( 
                                             highway IS NOT NULL 
                                      AND    tags @> '"cycleway"=>"track"' 
                                      AND    osm_id > 0) 
                               OR     ( 
                                             highway IS NOT NULL 
                                      AND    bicycle = 'use_sidepath')) 
            ); 

-- what's the length of bike tracks which are paths separate from the road and new or modified since the post?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_track_new', 
                        ( 
                               SELECT Sum(St_length(way))/1000 
                               FROM   planet_osm_line 
                               WHERE  ( 
                                             highway = 'cycleway' 
                                      AND    osm_id > 0 
                                      AND    osm_timestamp > '2016-05-19 17:57:00-07') 
                               OR     ( 
                                             highway IS NOT NULL 
                                      AND    tags @> '"cycleway"=>"track"' 
                                      AND    osm_id > 0 
                                      AND    osm_timestamp > '2016-05-19 17:57:00-07') 
                               OR     ( 
                                             highway IS NOT NULL 
                                      AND    bicycle = 'use_sidepath' 
                                      AND    osm_timestamp > '2016-05-19 17:57:00-07')) 
            ); 

-- what's the length of bike lanes which are paths on the road?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_lane', 
                        ( 
                               SELECT Sum(St_length(way))/1000 
                               FROM   planet_osm_line 
                               WHERE  tags ? 'cycleway' 
                               AND    highway IS NOT NULL 
                               AND    osm_id > 0) 
            ); 

-- what's the length of bike lanes which are paths on the road and new or modified since the post?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_lane_new', 
                        ( 
                               SELECT Sum(St_length(way))/1000 
                               FROM   planet_osm_line 
                               WHERE  tags ? 'cycleway' 
                               AND    highway IS NOT NULL 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            ); 

-- what's the length of bike routes

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_route', 
                        ( 
                               SELECT Sum(St_length(way))/1000 
                               FROM   planet_osm_line 
                               WHERE  route = 'bicycle' 
                               AND    osm_id < 0) 
            ); 

-- what's the length of bike routes and new or modified since the post?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_route_new', 
                        ( 
                               SELECT Sum(St_length(way))/1000 
                               FROM   planet_osm_line 
                               WHERE  route = 'bicycle' 
                               AND    osm_id < 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            ); 

-- how many bicycle parking areas are there?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_parking_polygons', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  amenity = 'bicycle_parking' 
                               AND    osm_id > 0) 
            );

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_parking_points', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  amenity = 'bicycle_parking' 
                               AND    osm_id > 0) 
            ); 

-- how many bicycle parking areas are there and new or modified since the post?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_parking_polygons_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  amenity = 'bicycle_parking' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            );

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_parking_points_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  amenity = 'bicycle_parking' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            ); 

-- how many bicycle repair stations are there?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_repair_polygons', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  amenity = 'bicycle_repair_station' 
                               AND    osm_id > 0) 
            );

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_repair_points', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  amenity = 'bicycle_repair_station' 
                               AND    osm_id > 0) 
            ); 

-- how many bicycle repair stations are there and new or modified since the post?


INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_repair_polygons_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  amenity = 'bicycle_repair_station' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            );

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_repair_points_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  amenity = 'bicycle_repair_station' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            ); 

-- how many bicycle rental locations are there?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_rental_polygons', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  amenity = 'bicycle_rental' 
                               AND    osm_id > 0) 
            );


INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_rental_points', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  amenity = 'bicycle_rental' 
                               AND    osm_id > 0) 
            ); 

-- how many bicycle rental locations are there and new or modified since the post?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_rental_polygons_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  amenity = 'bicycle_rental' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            );

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_rental_points_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  amenity = 'bicycle_rental' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            ); 

-- how many bicycle shops are there?


INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_shop_polygons', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  shop = 'bicycle' 
                               AND    osm_id > 0) 
            );

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_shop_points', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  shop = 'bicycle' 
                               AND    osm_id > 0) 
            ); 

-- how many bicycle shops are there?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_shop_polygons_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_polygon 
                               WHERE  shop = 'bicycle' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            );


INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_shop_points_new', 
                        ( 
                               SELECT Count(*) 
                               FROM   planet_osm_point 
                               WHERE  shop = 'bicycle' 
                               AND    osm_id > 0 
                               AND    osm_timestamp > '2016-05-19 17:57:00-07') 
            ); 

-- what's the total count of bicycle related points of interest?


INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_pois', 
                        ( 
                               SELECT Sum(value) 
                               FROM   new_bicycle 
                               WHERE  query_name = 'bike_parking_polygons' 
                               OR     query_name = 'bike_parking_points' 
                               OR     query_name = 'bike_repair_polygons' 
                               OR     query_name = 'bike_repair_points' 
                               OR     query_name = 'bike_rental_polygons' 
                               OR     query_name = 'bike_rental_points' 
                               OR     query_name = 'bike_shop_polygons' 
                               OR     query_name = 'bike_shop_points') 
            ); 

-- what's the total count of bicycle related points of interest that are new or modified since the post?


INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_pois_new', 
                        ( 
                               SELECT Sum(value) 
                               FROM   new_bicycle 
                               WHERE  query_name = 'bike_parking_polygons_new' 
                               OR     query_name = 'bike_parking_points_new' 
                               OR     query_name = 'bike_repair_polygons_new' 
                               OR     query_name = 'bike_repair_points_new' 
                               OR     query_name = 'bike_rental_polygons_new' 
                               OR     query_name = 'bike_rental_points_new' 
                               OR     query_name = 'bike_shop_polygons_new' 
                               OR     query_name = 'bike_shop_points_new') 
            ); 

-- what percent of the bicycle related points of interest are new or modified since the post?

INSERT INTO new_bicycle 
            ( 
                        query_name, 
                        value 
            ) 
            VALUES 
            ( 
                        'bike_pios_new_pct', 
                        ( ( 
                        ( 
                               SELECT value 
                               FROM   new_bicycle 
                               WHERE  query_name = 'bike_pois_new') / 
                        ( 
                               SELECT value 
                               FROM   new_bicycle 
                               WHERE  query_name = 'bike_pois') ) * 100 ) 
            );


SELECT * 
FROM   new_bicycle;