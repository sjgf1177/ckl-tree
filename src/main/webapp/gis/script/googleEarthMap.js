        var isVisibleMarkerInfo = 0; //마커의 Visible 상태를 저장함
        var oMarkers = new Array();     // 마커
        var oPolylines = new Array(); // 라인
        var oPolygons = new Array(); // 도형
        var oCircles = new Array(); 	// 원
        var oInfoWindows = new Array();  // 정보창
        var trafficLayer; //교통 정보
        var markerCluster = null;  //줌 아웃(와이드)로 볼 경우 많은 마커를 하나로 보이도록 설정
        var eventStartDate = null;

        var ge;
        google.load("earth", "1");

        function init() {
            google.earth.createInstance('map3d', initCB, failureCB);
        }

        function getQuerystring(key, default_)
    	  {
        		if (default_==null) default_=""; 
        		key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
        		var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
        		var qs = regex.exec(window.location.href);
        		if(qs == null)
        		   return default_;
        		else
        		   return qs[1];
    	  }

        function initCB(instance) {
            var company = getQuerystring("Company");
            if(hex_md5(company) != "27bf04637aece773c6b9ee11645c8152") return;

            ge = instance;
            ge.getWindow().setVisibility(true);
            ge.getNavigationControl().setVisibility(ge.VISIBILITY_AUTO);
            
            ge.getOptions().setStatusBarVisibility(true);
            ge.getOptions().setScaleLegendVisibility(true);
            ge.getOptions().setUnitsFeetMiles(true);
            ge.getOptions().setOverviewMapVisibility(true);
            ge.getOptions().setAtmosphereVisibility(true);

            // Move the camera.
            //var la = ge.createLookAt('');
            //la.set(37.5010226, 127.0396037, 0, ge.ALTITUDE_RELATIVE_TO_GROUND, -8.541, 66.213, 20000);
            //ge.getView().setAbstractView(la);

            //마커 클릭 / 우 클릭 이벤트 핸들러 등록
            google.earth.addEventListener(ge.getGlobe(), 'mouseup', function(event) {
              // 우 클릭
              if (event && event.getButton() == 2) {

                  //마커의 우클릭과 지도의 우클릭이벤트가 같이 발생하기 때문
                  var differenceTime = new Date() - eventStartDate;
                  if(differenceTime == 1) return;

                  event.preventDefault(); 
                  window.external.ScriptCallback_MapContextmenu("Map", event.getLatitude(), event.getLongitude(), "", event.getAltitude()/*고도*/);
              }
              else {
              // 좌 클릭
                  window.external.ScriptCallback_MapClick("Map", event.getLatitude(), event.getLongitude(), "", event.getAltitude()/*고도*/);
              }
            });

            //지도 더블 클릭 이벤트 핸들러 등록
            google.earth.addEventListener(ge.getGlobe(), 'dblclick', function(event) {
            
                //마커의 더블 클릭과 지도의 더블 클릭이벤트가 같이 발생하기 때문
                var differenceTime = new Date() - eventStartDate;
                if(differenceTime == 1) return;
                  
                event.preventDefault(); 
                if (event && event.getButton() == 2) return;
                window.external.ScriptCallback_MapDblclick("Map", event.getLatitude(), event.getLongitude(), "", event.getAltitude()/*고도*/);
            });

            //지도 마우스 Up 클릭 이벤트 핸들러 등록
            google.earth.addEventListener(ge.getGlobe(), 'mouseup', function(event) {
                window.external.ScriptCallback_MapMouseup("Map", event.getLatitude(), event.getLongitude(), "", event.getAltitude()/*고도*/);
            });
            
            //지도 마우스 mousemove 클릭 이벤트 핸들러 등록
            google.earth.addEventListener(ge.getGlobe(), 'mousemove', function(event) {
                window.external.ScriptCallback_MapMousemove("Map", event.getLatitude(), event.getLongitude(), "", event.getAltitude()/*고도*/);
            });
            
            
            setInterval(function() 
            {
                window.external.ScriptCallback_GoogleStreamingPercent(ge.getStreamingPercent());
            }, 200);
        }

        function failureCB(errorCode) {
            if (errorCode == "ERR_CREATE_PLUGIN") {
                alert("Plugin not installed")
            } else {
                alert("Other failure loading the Google Earth Plugin: " + errorCode);
            }
        }
        
        //지도 초기화
        function InitializeMap() {
            try {
                if (ge == null) {
                    return -1;
                }
                else return 1;
            }
            catch (e) { }
        }
        
        function AddMarker(deviceID, markerName, lon, lat, altitide, markerIconURL, widthSize, heightSize) {
            try {
                // Create the placemark.
                var placemark = ge.createPlacemark(deviceID);
                placemark.setName(markerName);

                // Define a custom icon.
                var icon = ge.createIcon('');
                icon.setHref(markerIconURL);
                var style = ge.createStyle(''); //create a new style
                style.getIconStyle().setIcon(icon); //apply the icon to the style
                placemark.setStyleSelector(style); //apply the style to the placemark

                // Set the placemark location.  
                var point = ge.createPoint('');
                point.setLatitude(lat);
                point.setLongitude(lon);
                placemark.setGeometry(point);

                // Add the placemark to Earth.
                ge.getFeatures().appendChild(placemark);
                
                //마커 클릭 이벤트 핸들러 등록 - mouseup 이벤트에서 적용
                //var click_Listenerhandle = google.earth.addEventListener(placemark, 'click', function(event) {
                //    //window.external.ScriptCallback_MapClick("Marker", placemark.getGeometry().getLatitude(), placemark.getGeometry().getLongitude(), placemark.getName(), oMap.getLevel()/*고도*/);
                //    window.external.ScriptCallback_MapClick("Marker", event.getLatitude(), event.getLongitude(), placemark.getName(), event.getAltitude()/*고도*/);
                //});
                //마커 클릭 / 우 클릭 이벤트 핸들러 등록
                var rightclick_Listenerhandle = google.earth.addEventListener(placemark, 'mouseup', function(event) {
                  // 우 클릭
                  if (event && event.getButton() == 2) {
                      eventStartDate = new Date();
                      window.external.ScriptCallback_MapContextmenu("Marker", event.getLatitude(), event.getLongitude(), placemark.getName(), event.getAltitude()/*고도*/);
                  }
                  else {
                  // 좌 클릭
                      window.external.ScriptCallback_MapClick("Marker", event.getLatitude(), event.getLongitude(), placemark.getName(), event.getAltitude()/*고도*/);
                  }
                });
                 //마커 더블 클릭 이벤트 핸들러 등록
                var dblclick_Listenerhandle = google.earth.addEventListener(placemark, 'dblclick', function(event) {
                    eventStartDate = new Date();
                    window.external.ScriptCallback_MapDblclick("Marker", event.getLatitude(), event.getLongitude(), placemark.getName(), event.getAltitude()/*고도*/);
                });
                //마커 Over 이벤트 핸들러 등록
                var mouseover_Listenerhandle = google.earth.addEventListener(placemark, 'mousemove', function(event) {
                    window.external.ScriptCallback_MapMouseOver("Marker", event.getLatitude(), event.getLongitude(), placemark.getName());
                });
                //마커 Out 클릭 이벤트 핸들러 등록
                var mouseout_Listenerhandle = google.earth.addEventListener(placemark, 'mouseout', function(event) {
                    window.external.ScriptCallback_MapMouseOut("Map", 0, 0, "");
                });
            }
            catch (e) { }
        }

        function RemoveMarkerAtID(markerID) {
            try {
                var features=ge.getGlobe().getFeatures().getChildNodes();
                for (var idx = 0; idx < features.getLength(); idx++) 
                {
                    if (features.item(idx).getId() == markerID) 
                    {
                        ge.getFeatures().removeChild(features.item(idx));
                        break;
                    } 
                    else 
                    {
                        continue;
                    }
                }
            }
            catch (e) { }
        }
        
        function getCenter() {
            try {
                if (ge == null) return null;
                //var lookAt = ge.getView().copyAsLookAt(ge.ALTITUDE_RELATIVE_TO_GROUND);
                //return lookAt.getLatitude() + "," + lookAt.getLongitude();
                
                var camera = ge.getView().copyAsCamera(ge.ALTITUDE_RELATIVE_TO_GROUND);
                return camera.getLatitude() + "," + camera.getLongitude();
            }
            catch (e) { }
        }
        
        function setCenter(Lng, Lat) {
            try
            {
                if (ge == null) return null;
                //var lookAt = ge.getView().copyAsLookAt(ge.ALTITUDE_RELATIVE_TO_GROUND);
                //lookAt.setLatitude(Lat);
                //lookAt.setLongitude(Lng);
                //ge.getView().setAbstractView(lookAt);
                
                var camera = ge.getView().copyAsCamera(ge.ALTITUDE_RELATIVE_TO_GROUND);
                camera.setLatitude(Lat);
                camera.setLongitude(Lng);
                ge.getView().setAbstractView(camera);
            }
            catch(e) { }
        }
        
        function MoveLonLat(lon, lat) {
            setCenter(lat, lon);
        }
        
        function setCenter(Lng, Lat, Altitude) {
            try
            {
                if (ge == null) return null;

                var camera = ge.getView().copyAsCamera(ge.ALTITUDE_RELATIVE_TO_GROUND);
                if(Lat != 0) camera.setLatitude(Lat);
                if(Lng != 0) camera.setLongitude(Lng);
                if(Altitude != 0) camera.setAltitude(Altitude);

                ge.getView().setAbstractView(camera);
            }
            catch(e) { }
        }

        //고도 가져오기
        function GetAltitude() {
            try {
                if (ge == null) return null;
                var camera = ge.getView().copyAsCamera(ge.ALTITUDE_RELATIVE_TO_GROUND);
                return camera.getAltitude();
            }
            catch (e) { }
        }
        
        //고도 변경
        function SetAltitude(altitude) {
            try {
                if (ge == null) return null;
                
                var camera = ge.getView().copyAsCamera(ge.ALTITUDE_RELATIVE_TO_GROUND);
                camera.setAltitude(altitude);
                
                ge.getView().setAbstractView(camera);
            }
            catch (e) { }
        }
        
        //위 경도의 실제 고도 가져오기
        function GetAltitudeByPosition(lon, lat) {
            try {
                if (ge == null) return null;
                
                var groundAltitude = ge.getGlobe().getGroundAltitude(lat, lon);
                return groundAltitude;
            }
            catch (e) { }
        }
        
        function showSun() 
        {  
            ge.getSun().setVisibility(true);
        }
        function hideSun() 
        {  
            ge.getSun().setVisibility(false);
        }
        
        google.setOnLoadCallback(init);
