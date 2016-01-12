/*jslint browser: true*/
/*global Tangram */
var picking = false;
map = (function () {
// (function () {
    // 'use strict';

    // defaults
    var map_start_location = [0, 0, 2]; // world
    var style_file = 'fitness.yaml';

    /*** URL parsing ***/

    // leaflet-style URL hash pattern:
    // #[zoom],[lat],[lng]
    var url_hash = window.location.hash.slice(1).split('/');

    // location
    var defaultpos = true; // use default position
    // location is passed through url
    if (url_hash.length == 3) {
        var defaultpos = false;
        console.log('hash:', url_hash);
        map_start_location = [url_hash[1],url_hash[2], url_hash[0]];
        // convert from strings
        map_start_location = map_start_location.map(Number);
    }

    // normal case, eg: http://tangrams.github.io/nameless-maps/?roads#4/0/0
    var url_search = window.location.search.slice(1).split('/')[0];
    // console.log('url_search', url_search);
    if (url_search.length > 0) {
        style_file = url_search + ".yaml";
        // console.log('style_file', style_file);
    }

    /*** Map ***/

    var map = L.map('map',
        {"keyboardZoomOffset" : .05, "scrollWheelZoom": false }
    );
    map.setView(map_start_location.slice(0, 2), map_start_location[2]);

    var layer = Tangram.leafletLayer({
        scene: style_file,
        attribution: '<a href="https://mapzen.com/tangram" target="_blank">Tangram</a> | &copy; OSM contributors | <a href="https://mapzen.com/" target="_blank">Mapzen</a>'
    });

    window.layer = layer;
    var scene = layer.scene;
    window.scene = scene;
    var latlng = [];

    // setView expects format ([lat, long], zoom)
    var hash = new L.Hash(map);

    function updateKey(value) {
        keytext = value;

        for (layer in scene.config.layers) {
            if (layer == "earth") continue;
            scene.config.layers[layer].properties.key_text = value;
        }
        scene.rebuildGeometry();
        scene.requestRedraw();
    }

    function updateValue(value) {
        valuetext = value;

        for (layer in scene.config.layers) {
            if (layer == "earth") continue;
            scene.config.layers[layer].properties.value_text = value;
        }
        scene.rebuildGeometry();
        scene.requestRedraw();
    }

    // Feature selection
    function initFeatureSelection () {
        var info = document.getElementById('info'); // rollover-popup
        var popup = document.getElementById('popup'); // click-popup

        map.addEventListener('mousemove', function (e) { latlng = [e.latlng.lat, e.latlng.lng]; });

        // feature edit popup
        map.getContainer().addEventListener('mousemove', function (event) {
            picking = true;
            info.style.visibility = 'hidden';

            var pixel = { x: event.clientX, y: event.clientY };

            scene.getFeatureAt(pixel).then(function(selection) {
                var feature = selection.feature;
                if (!selection || feature == null) {
                    picking = false;
                    popup.style.visibility = 'hidden';
                    return;
                }

                // generate osm edit link
                var url = 'https://www.openstreetmap.org/edit?';

                var position = '19' + '/' + latlng[0] + '/' + latlng[1];

                if (scene.selection.feature && scene.selection.feature.properties.id) {
                    url += 'node=' + scene.selection.feature.properties.id + '#map=' + position;
                }

                var josmUrl = 'http://www.openstreetmap.org/edit?editor=remote#map='+position;
                
                // extra label information - currently unused
                var label = '';
                if (feature.properties != null) {
                    var obj = JSON.parse(JSON.stringify(feature.properties));
                    label = "";
                    for (x in feature.properties) {
                        if (x == "sort_key" || x == "id") continue;
                        val = feature.properties[x];
                        label += "<span class='labelLine' key="+x+" value="+val+">"+x+" : "+val+"</span><br>"
                    }
                }

                popup.style.left = (pixel.x + 0) + 'px';
                popup.style.top = (pixel.y + 0) + 'px';
                
                if ( (scene.selection.feature.properties.kind == 'fitness' || scene.selection.feature.properties.kind == 'gym') && !scene.selection.feature.properties.name ) 
                {
	                popup.style.visibility = 'visible';
	            }
                popup.innerHTML = '<span class="labelInner">' + 'You found a gym to enhance!' + '</span><br>';
                popup.innerHTML += '<span class="labelInner">' + '<a target="_blank" href="' + url + '" onclick="trackOutboundLink("' + url + ', residential_buildings"); return false;">Edit with iD ➹</a>' + '</span><br>';
                popup.innerHTML += '<span class="labelInner">' + '<a target="_blank" href="' + josmUrl + '" onclick="trackOutboundLink("' + josmUrl + ', residential_buildings"); return false;">Edit with JOSM ➹</a>' + '</span><br>';
            });
        });

        map.getContainer().addEventListener('mousedown', function (event) {
            info.style.visibility = 'hidden';
            popup.style.visibility = 'hidden';
        });
    }

	function long2tile(lon,zoom) { return (Math.floor((lon+180)/360*Math.pow(2,zoom))); }
	function lat2tile(lat,zoom)  { return (Math.floor((1-Math.log(Math.tan(lat*Math.PI/180) + 1/Math.cos(lat*Math.PI/180))/Math.PI)/2 *Math.pow(2,zoom))); }    

    /***** Render loop *****/
	
	function addGUI () {
		// Link to edit in OSM - hold 'e' and click
		function onMapClick(e) {
			if (key.shift) {
				var url = 'https://www.openstreetmap.org/edit?';

				if (scene.selection.feature && scene.selection.feature.id) {
					url += 'way=' + scene.selection.feature.id;
				}

				if (scene.center) {
					url += '#map=' + scene.baseZoom(scene.zoom) + '/' + scene.center.lat + '/' + scene.center.lng;
				}

				window.open(url, '_blank');
			}

 			if (key.command) {
				var url = 'http://vector.mapzen.com/osm/all/' + scene.tile_zoom + '/' + long2tile(e.latlng.lng,scene.tile_zoom)  + '/' + lat2tile(e.latlng.lat,scene.tile_zoom) + '.topojson?api_key=vector-tiles-HqUVidw';
				window.open(url, '_blank');
				//console.log( e );
			}
		}

		map.on('click', onMapClick);		
	}

    function inIframe () {
        try {
            return window.self !== window.top;
        } catch (e) {
            return true;
        }
    }
    
    // Add map
    window.addEventListener('load', function () {
        // Scene initialized
        layer.on('init', function() {
	        addGUI();
            initFeatureSelection();
            //console.log('1 map loc:', map_start_location, '\ncamera pos:', scene.camera.position);
            if (defaultpos && typeof scene.camera.position != "undefined") {
                map_start_location = [scene.camera.position[1], scene.camera.position[0], scene.camera.position[2]]
            }
            map.setView([map_start_location[0], map_start_location[1]], map_start_location[2]);
        });
        if (!inIframe()) {
            map.scrollWheelZoom.enable();
        }
        layer.addTo(map);
    });

    return map;

}());

