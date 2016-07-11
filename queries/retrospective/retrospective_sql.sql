DROP TABLE IF EXISTS retrospective; 

CREATE TABLE retrospective 
  ( 
     query_name TEXT, 
     value      REAL 
  ); 

-- km of commonly routable roads
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'roads_for_routing_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway IN ( 'motorway', 'motorway_link', 'trunk', 
                                   'trunk_link', 
                                   'primary', 'primary_link', 'secondary', 
                                   'secondary_link', 
                                   'residential', 'residential_link', 'service', 
                                   'tertiary', 
                                   'tertiary_link', 'road', 'track', 
                                   'unclassified', 
                                   'living_street' ) 
                      AND ( osm_id > 0 ))); 

-- km of commonly routable roads with names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'roads_for_routing_km_named', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway IN ( 'motorway', 'motorway_link', 'trunk', 
                                   'trunk_link', 
                                   'primary', 'primary_link', 'secondary', 
                                   'secondary_link', 
                                   'residential', 'residential_link', 'service', 
                                   'tertiary', 
                                   'tertiary_link', 'road', 'track', 
                                   'unclassified', 
                                   'living_street' ) 
                      AND ( osm_id > 0 ) 
                      AND ( name IS NOT NULL 
                             OR ref IS NOT NULL ))); 

-- km of motorways
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'motorway_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'motorway' 
                      AND osm_id > 0)); 

-- km of motorways without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'motorway_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'motorway' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_id > 0)); 

-- % unnamed motorways (of motorways)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('motorway_unnamed_motorway_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'motorway_unnamed_km') / 
                     (SELECT value 
                      FROM   retrospective 
                      WHERE  query_name = 'motorway_km') ) * 100 )); 

-- % unnamed motorways (of all roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('motorway_unnamed_all_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'motorway_unnamed_km') / 
                     (SELECT value 
                      FROM   retrospective 
                      WHERE  query_name = 'roads_for_routing_km') ) * 100 ));

-- km of primary roads
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'primary_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'primary' 
                      AND osm_id > 0)); 

-- km of primary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'primary_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'primary' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_id > 0)); 

-- % unnamed primary roads (of primary)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('primary_unnamed_primary_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'primary_unnamed_km') / 
                   (SELECT value 
                    FROM   retrospective 
                    WHERE  query_name = 'primary_km') ) * 100 )); 

-- % unnamed primary roads (of all roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('primary_unnamed_all_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'primary_unnamed_km') / 
                   (SELECT value 
                    FROM   retrospective 
                    WHERE  query_name = 'roads_for_routing_km') ) * 100 )); 

-- km of secondary roads 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'secondary_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'secondary' 
                      AND osm_id > 0)); 

-- km of secondary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'secondary_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'secondary' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_id > 0)); 

-- % unnamed secondary roads (of secondary)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('secondary_unnamed_secondary_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'secondary_unnamed_km') / (SELECT value 
                                                                 FROM 
                 retrospective 
                                                                 WHERE 
                     query_name = 'secondary_km') ) * 100 )); 

-- % unnamed secondary roads (of all roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('secondary_unnamed_all_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'secondary_unnamed_km') / (SELECT value 
                                                                 FROM 
                 retrospective 
                                                                 WHERE 
                     query_name = 'roads_for_routing_km') ) * 100 ));

-- km of tertiary roads
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiary_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary' 
                      AND osm_id > 0)); 

-- km of tertiary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiary_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_id > 0)); 

-- % unnamed tertiary roads (of tertiary)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('tertiary_unnamed_tertiary_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'tertiary_unnamed_km') / 
                     (SELECT value 
                      FROM   retrospective 
                      WHERE  query_name = 'tertiary_km') ) * 100 )); 

-- % unnamed tertiary roads (of all roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('tertiary_unnamed_all_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'tertiary_unnamed_km') / 
                     (SELECT value 
                      FROM   retrospective 
                      WHERE  query_name = 'roads_for_routing_km') ) * 100 ));


-- km of residential roads
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential' 
                      AND osm_id > 0)); 

-- km of residential roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_id > 0)); 

-- % unnamed residential roads (of residential)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('residential_unnamed_residential_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'residential_unnamed_km') / (SELECT value 
                                                                   FROM 
                 retrospective 
                                                                   WHERE 
                     query_name = 'residential_km') ) * 100 )); 

-- % unnamed residential roads (of all roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('residential_unnamed_all_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'residential_unnamed_km') / (SELECT value 
                                                                   FROM 
                 retrospective 
                                                                   WHERE 
                     query_name = 'roads_for_routing_km') ) * 100 )); 

-- km of new commonly routable roads
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'roads_for_routing_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway IN ( 'motorway', 'motorway_link', 'trunk', 
                                   'trunk_link', 
                                   'primary', 'primary_link', 'secondary', 
                                   'secondary_link', 
                                   'residential', 'residential_link', 'service', 
                                   'tertiary', 
                                   'tertiary_link', 'road', 'track', 
                                   'unclassified', 
                                   'living_street' ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08'
                      AND ( osm_id > 0 ))); 

-- km of new commonly routable roads with names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'roads_for_routing_km_new_named', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway IN ( 'motorway', 'motorway_link', 'trunk', 
                                   'trunk_link', 
                                   'primary', 'primary_link', 'secondary', 
                                   'secondary_link', 
                                   'residential', 'residential_link', 'service', 
                                   'tertiary', 
                                   'tertiary_link', 'road', 'track', 
                                   'unclassified', 
                                   'living_street' ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08'
                      AND ( osm_id > 0 ) 
                      AND ( name IS NOT NULL 
                             OR ref IS NOT NULL ))); 

-- km of new motorways since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'motorway_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'motorway' 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- km of motorways without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'motorway_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'motorway' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- % unnamed motorways new (of motorways)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('motorway_unnamed_motorway_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'motorway_unnamed_new_km') / (SELECT value 
                                                                    FROM 
                 retrospective 
                                                                    WHERE 
                     query_name = 'motorway_new_km') ) * 100 )); 

-- % unnamed motorways new (of all new roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('motorway_unnamed_all_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'motorway_unnamed_new_km') / (SELECT value 
                                                                    FROM 
                 retrospective 
                                                                    WHERE 
                     query_name = 'roads_for_routing_new_km') ) * 100 ));

-- km of primary roads since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'primary_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'primary' 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- km of primary roads without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'primary_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'primary' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- % unnamed primary roads, new (of primary)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('primary_unnamed_primary_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'primary_unnamed_new_km') / (SELECT value 
                                                                   FROM 
                 retrospective 
                                                                   WHERE 
                     query_name = 'primary_new_km') ) * 100 )); 

-- % unnamed primary roads, new (of all new roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('primary_unnamed_all_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'primary_unnamed_new_km') / (SELECT value 
                                                                   FROM 
                 retrospective 
                                                                   WHERE 
                     query_name = 'roads_for_routing_new_km') ) * 100 ));

-- km of secondary roads since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'secondary_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'secondary' 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- km of secondary roads without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'secondary_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'secondary' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- % unnamed secondary, new (of secondary)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('secondary_unnamed_secondary_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'secondary_unnamed_new_km') / (SELECT 
                 value 
                                                                     FROM 
                 retrospective 
                                                                     WHERE 
                     query_name = 'secondary_new_km') ) * 100 )); 

-- % unnamed secondary, new (of all new roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('secondary_unnamed_all_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'secondary_unnamed_new_km') / (SELECT 
                 value 
                                                                     FROM 
                 retrospective 
                                                                     WHERE 
                     query_name = 'roads_for_routing_new_km') ) * 100 )); 

-- km of tertiary roads since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiary_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary' 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- km of tertiary roads without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiary_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- % unnamed tertiary, new (of tertiary)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('tertiary_unnamed_tertiary_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'tertiary_unnamed_new_km') / (SELECT value 
                                                                    FROM 
                 retrospective 
                                                                    WHERE 
                     query_name = 'tertiary_new_km') ) * 100 )); 

-- % unnamed tertiary, new (of all new roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('tertiary_unnamed_all_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'tertiary_unnamed_new_km') / (SELECT value 
                                                                    FROM 
                 retrospective 
                                                                    WHERE 
                     query_name = 'roads_for_routing_new_km') ) * 100 ));

-- km of residential roads since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential' 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- km of residential roads without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential' 
                      AND ( name IS NULL 
                            AND ref IS NULL ) 
                      AND osm_timestamp > '2015-12-02 19:37:00-08' 
                      AND osm_id > 0)); 

-- % unnamed residential, new (of residential)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('residential_unnamed_residential_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'residential_unnamed_new_km') / (SELECT 
                 value 
                                                                       FROM 
                 retrospective 
                                                                       WHERE 
                     query_name = 'residential_new_km') ) * 100 )); 

-- % unnamed residential, new (of all new roads for routing)
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('residential_unnamed_all_new_pct', 
             ( ( (SELECT value 
                  FROM   retrospective 
                  WHERE  query_name = 'residential_unnamed_new_km') / (SELECT 
                 value 
                                                                       FROM 
                 retrospective 
                                                                       WHERE 
                     query_name = 'roads_for_routing_new_km') ) * 100 ));

INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('motorway_unnamed_pre_post', 
             ( (SELECT value 
                FROM   retrospective 
                WHERE  query_name = 'motorway_unnamed_km') - (SELECT value 
                                                              FROM 
               retrospective 
                                                              WHERE 
                 query_name = 'motorway_unnamed_new_km') )); 

INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('primary_unnamed_pre_post', 
             ( (SELECT value 
                FROM   retrospective 
                WHERE  query_name = 'primary_unnamed_km') - (SELECT value 
                                                             FROM 
               retrospective 
                                                             WHERE 
                 query_name = 'primary_unnamed_new_km') )); 

INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('secondary_unnamed_pre_post', 
             ( (SELECT value 
                FROM   retrospective 
                WHERE  query_name = 'secondary_unnamed_km') - (SELECT value 
                                                               FROM 
               retrospective 
                                                               WHERE 
                 query_name = 'secondary_unnamed_new_km') )); 

INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('tertiary_unnamed_pre_post', 
             ( (SELECT value 
                FROM   retrospective 
                WHERE  query_name = 'tertiary_unnamed_km') - (SELECT value 
                                                              FROM 
               retrospective 
                                                              WHERE 
                 query_name = 'tertiary_unnamed_new_km') )); 

INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ('residential_unnamed_pre_post', 
             ( (SELECT value 
                FROM   retrospective 
                WHERE  query_name = 'residential_unnamed_km') - (SELECT value 
                                                                 FROM 
               retrospective 
                                                                 WHERE 
                 query_name = 'residential_unnamed_new_km') )); 

select * from retrospective;

