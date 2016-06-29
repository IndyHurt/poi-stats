DROP TABLE IF EXISTS apartments; 

CREATE TABLE apartments 
  ( 
     query_name TEXT, 
     value      REAL 
  ); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_points', 
             (SELECT Count(*) 
              FROM   planet_osm_point 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND osm_id > 0)); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_polygons', 
             (SELECT Count(*) 
              FROM   planet_osm_polygon 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND osm_id > 0)); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_total', 
             (SELECT Sum(value) 
              FROM   apartments 
              WHERE  query_name IN ( 'apartment_points', 'apartment_polygons' )) 
); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_points_named', 
             (SELECT Count(*) 
              FROM   planet_osm_point 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND name IS NOT NULL 
                     AND osm_id > 0)); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_polygons_named', 
             (SELECT Count(*) 
              FROM   planet_osm_polygon 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND name IS NOT NULL 
                     AND osm_id > 0)); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_named_total', 
             (SELECT Sum(value) 
              FROM   apartments 
              WHERE  query_name IN ( 'apartment_points_named', 
                                     'apartment_polygons_named' ))); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_named_pct', 
             ( ( (SELECT value 
                  FROM   apartments 
                  WHERE  query_name = 'apartment_named_total') / (SELECT value 
                                                                  FROM 
                 apartments 
                                                                  WHERE 
                     query_name = 'apartment_total') ) * 100 )); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_points_new', 
             (SELECT Count(*) 
              FROM   planet_osm_point 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND osm_id > 0 
                     AND osm_timestamp > '2016-01-08 21:50:00-08')); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_polygons_new', 
             (SELECT Count(*) 
              FROM   planet_osm_polygon 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND osm_id > 0 
                     AND osm_timestamp > '2016-01-08 21:50:00-08')); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_total_new', 
             (SELECT Sum(value) 
              FROM   apartments 
              WHERE  query_name IN ( 'apartment_points_new', 
                                     'apartment_polygons_new' ))); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_total_new_pct', 
             ( ( (SELECT value 
                  FROM   apartments 
                  WHERE  query_name = 'apartment_total_new') / (SELECT 
                 value 
                                                                      FROM 
                 apartments 
                                                                      WHERE 
                     query_name = 'apartment_total') ) * 100 ));                                    

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_points_named_new', 
             (SELECT Count(*) 
              FROM   planet_osm_point 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND name IS NOT NULL 
                     AND osm_id > 0 
                     AND osm_timestamp > '2016-01-08 21:50:00-08')); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_polygons_named_new', 
             (SELECT Count(*) 
              FROM   planet_osm_polygon 
              WHERE  building IN ( 'apartment', 'apartments' ) 
                     AND name IS NOT NULL 
                     AND osm_id > 0 
                     AND osm_timestamp > '2016-01-08 21:50:00-08')); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_named_total_new', 
             (SELECT Sum(value) 
              FROM   apartments 
              WHERE  query_name IN ( 'apartment_points_named_new', 
                                     'apartment_polygons_named_new' ))); 

INSERT INTO apartments 
            (query_name, 
             value) 
VALUES      ('apartment_named_pct_new', 
             ( ( (SELECT value 
                  FROM   apartments 
                  WHERE  query_name = 'apartment_named_total_new') / (SELECT 
                 value 
                                                                      FROM 
                 apartments 
                                                                      WHERE 
                     query_name = 'apartment_total_new') ) * 100 ));

select * from apartments;