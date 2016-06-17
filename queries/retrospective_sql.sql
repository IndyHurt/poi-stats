drop table if exists retrospective;
create table  retrospective (query_name text, value real);

-- km of commonly routable roads
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'roads_for_routing_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway IN ( 'motorway', 'motorway_link', 
					           'trunk', 'trunk_link', 
                                                  'primary', 'primary_link', 
                                                  'secondary', 'secondary_link', 
                                                  'residential', 'residential_link', 
                                                  'service', 'tertiary', 'tertiary_link', 
                                                  'road', 'track', 'unclassified', 'living_street' )
			AND (osm_id > 0)));


-- km of commonly routable roads with names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'roads_for_routing_km_named', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway IN ( 'motorway', 'motorway_link', 
					           'trunk', 'trunk_link', 
                                                  'primary', 'primary_link', 
                                                  'secondary', 'secondary_link', 
                                                  'residential', 'residential_link', 
                                                  'service', 'tertiary', 'tertiary_link', 
                                                  'road', 'track', 'unclassified', 'living_street' ) 
		      AND (osm_id > 0)	
                      AND ( NAME IS NOT NULL 
                             OR ref IS NOT NULL ))); 

-- km of motorways 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'motorway_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'motorway' AND osm_id > 0));

-- km of motorways without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'motorway_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'motorway'
               AND (NAME is NULL AND ref is NULL) AND osm_id > 0));               

-- km of primary roads 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'primary_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'primary' AND osm_id > 0));

-- km of primary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'primary_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'primary'
               AND (NAME is NULL AND ref is NULL) AND osm_id > 0)); 

-- km of secondary roads 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'secondary_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'secondary' AND osm_id > 0));

-- km of secondary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'secondary_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'secondary'
               AND (NAME is NULL AND ref is NULL) AND osm_id > 0));  

-- km of tertiary roads 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiery_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary' AND osm_id > 0));

-- km of tertiary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiery_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary'
               AND (NAME is NULL AND ref is NULL) AND osm_id > 0));    

-- km of residential roads 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential' AND osm_id > 0));

-- km of primary roads without names
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_unnamed_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential'
               AND (NAME is NULL AND ref is NULL) AND osm_id > 0));        

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
               AND (NAME is NULL AND ref is NULL)
               AND osm_timestamp > '2015-12-02 19:37:00-08'
               AND osm_id > 0));  
	    

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
               AND (NAME is NULL AND ref is NULL)
               AND osm_timestamp > '2015-12-02 19:37:00-08'
               AND osm_id > 0)); 

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
               AND (NAME is NULL AND ref is NULL)
               AND osm_timestamp > '2015-12-02 19:37:00-08'
               AND osm_id > 0));  

-- km of tertiary roads since post 
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiery_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary'
               AND osm_timestamp > '2015-12-02 19:37:00-08'
               AND osm_id > 0));

-- km of tertiary roads without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'tertiery_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'tertiary'
               AND (NAME is NULL AND ref is NULL)
               AND osm_timestamp > '2015-12-02 19:37:00-08'
               AND osm_id > 0));    

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

-- km of primary roads without names since post
INSERT INTO retrospective 
            (query_name, 
             value) 
VALUES      ( 'residential_unnamed_new_km', 
              (SELECT Sum(St_length(way)) / 1000 
               FROM   planet_osm_line 
               WHERE  highway = 'residential'
               AND (NAME is NULL AND ref is NULL)
               AND osm_timestamp > '2015-12-02 19:37:00-08'
               AND osm_id > 0));    
                                                              

-- calculate percent change for roads w/o names

-- unnamed road length before the blog post

INSERT INTO retrospective (query_name, value) values ('motorway_unnamed_pre_post', ((select value from retrospective where query_name = 'motorway_unnamed_km') - (select value from retrospective where query_name = 'motorway_unnamed_new_km')));

INSERT INTO retrospective (query_name, value) values ('primary_unnamed_pre_post', ((select value from retrospective where query_name = 'primary_unnamed_km') - (select value from retrospective where query_name = 'primary_unnamed_new_km')));  

INSERT INTO retrospective (query_name, value) values ('secondary_unnamed_pre_post', ((select value from retrospective where query_name = 'secondary_unnamed_km') - (select value from retrospective where query_name = 'secondary_unnamed_new_km'))); 

INSERT INTO retrospective (query_name, value) values ('tertiery_unnamed_pre_post', ((select value from retrospective where query_name = 'tertiery_unnamed_km') - (select value from retrospective where query_name = 'tertiery_unnamed_new_km')));     

INSERT INTO retrospective (query_name, value) values ('residential_unnamed_pre_post', ((select value from retrospective where query_name = 'residential_unnamed_km') - (select value from retrospective where query_name = 'residential_unnamed_new_km')));    

select * from retrospective
                 