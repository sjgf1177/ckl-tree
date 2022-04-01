
        var isVisibleMarkerInfo = 0; //마커의 Visible 상태를 저장함
        var oMarkers = new Array();     // 마커
        var oPolylines = new Array(); // 라인
        var oPolygons = new Array(); // 도형
        var oCircles = new Array(); 	// 원
        var oInfoWindows = new Array();  // 정보창
        var trafficLayer; //교통 정보
        var markerCluster = null;  //줌 아웃(와이드)로 볼 경우 많은 마커를 하나로 보이도록 설정
        var overlayMap = null;
        
        init(37.5010226, 127.0396037); // 시작 위치

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

        function init(Lat, Lng) {
            var company = getQuerystring("Company");
            if(hex_md5(company) != "27bf04637aece773c6b9ee11645c8152") return;

            var mapOptions = {
                center: new google.maps.LatLng(Lat, Lng),
                zoom: 19,
                maxZoom: 19,
                disableDoubleClickZoom: true,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                mapTypeControl: false,
                panControlOptions: {
                    position: google.maps.ControlPosition.TOP_RIGHT
                },
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE,
                    position: google.maps.ControlPosition.TOP_RIGHT
                }
            };        
            oMap = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

            //미니맵
            overlayMap = new google.maps.Map(
              document.getElementById('overlay_map'), {
              mapTypeId: google.maps.MapTypeId.ROADMAP, 
              disableDefaultUI: true
            });
            
            //지도 클릭 이벤트 핸들러 등록
            google.maps.event.addListener(oMap, 'click', function(e) {
                window.external.ScriptCallback_MapClick("Map", e.latLng.lat(), e.latLng.lng(), "", oMap.getZoom()/*고도*/);
            });

            //지도 우 클릭 이벤트 핸들러 등록
            google.maps.event.addListener(oMap, 'rightclick', function(e) {
                window.external.ScriptCallback_MapContextmenu("Map", e.latLng.lat(), e.latLng.lng(), "", oMap.getZoom()/*고도*/);
            });

            //지도 더블 클릭 이벤트 핸들러 등록
            google.maps.event.addListener(oMap, 'dblclick', function(e) {
                window.external.ScriptCallback_MapDblclick("Map", e.latLng.lat(), e.latLng.lng(), "", oMap.getZoom()/*고도*/);
            });

            //지도 마우스 Up 클릭 이벤트 핸들러 등록
            google.maps.event.addListener(oMap, 'mouseup', function(e) {
                window.external.ScriptCallback_MapMouseup("Map", e.latLng.lat(), e.latLng.lng(), "", oMap.getZoom()/*고도*/);
            });
            
            //지도 마우스 mousemove 클릭 이벤트 핸들러 등록
            google.maps.event.addListener(oMap, 'mousemove', function(e) {
                window.external.ScriptCallback_MapMousemove("Map", e.latLng.lat(), e.latLng.lng(), "", oMap.getZoom()/*고도*/);
            });

            //미니맵을 위한 이벤트
            google.maps.event.addListener(oMap, 'zoom_changed', function() {
                var newZoom = Math.max(oMap.getZoom() - 4, 0);
                if (overlayMap.getZoom() != newZoom) overlayMap.setZoom(newZoom);
            });
            //미니맵을 위한 이벤트
            google.maps.event.addListener(overlayMap, 'zoom_changed', function() {
                var newZoom = overlayMap.getZoom() + 4;
                if (oMap.getZoom() != newZoom) oMap.setZoom(newZoom);
            });

            //미니맵 설정
            overlayMap.bindTo('center', oMap, 'center');
            /**
             * attach the overview map to the main map and set positioning
             */
            var overDiv = overlayMap.getDiv();
            oMap.getDiv().appendChild(overDiv);
            overDiv.style.position = "absolute";
            overDiv.style.right = "0px";
            overDiv.style.bottom = "19px";
            overDiv.style.zIndex = 10;
            
            google.maps.event.addListener(overlayMap, 'idle', function() {
              overlayMap.getDiv().style.zIndex = 10;
            });
            //여기까지 미니맵 설정

            //oMap.enableKeyDragZoom();

            var mcOptions = {gridSize: 50, maxZoom: 12};
            markerCluster = new MarkerClusterer(oMap, [], mcOptions);
        }
        
        function setCenter(Lat, Lng) {
            try
            {
                oPoint = new google.maps.LatLng(Lat, Lng);
                oMap.setCenter(oPoint);
            }
            catch(e) { }
        }

        function getCenter() {
            var pos = oMap.getCenter();
            return pos.lat() + "," + pos.lng();
        }

        function Resize(width, height) {
            //Auto Resize
        }

        function setLevel(Level) {
            oMap.setZoom(Level);
        }

        function getLevel() {
            return oMap.getZoom();
        }

        function setMapMode(mapMode) {
            if(mapMode == 0)
              oMap.setMapTypeId(google.maps.MapTypeId.ROADMAP); //일반 지도
            else if(mapMode == 1)
              oMap.setMapTypeId(google.maps.MapTypeId.HYBRID);  //겹침 지도
            else if(mapMode == 2)
              oMap.setMapTypeId(google.maps.MapTypeId.SATELLITE); //위성 지도
            else if(mapMode == 3)
              oMap.setMapTypeId(google.maps.MapTypeId.TERRAIN);  //지형 지도
        }

        function setGISMarker(iKey, Lat, Lng, iMsg, markerURL, widthSize, heightSize) {
            try
            {
                if (Lat == null || Lng == null || Lat == "" || Lng == "" || Lat == 0 || Lng == 0) {
                    return;
                }
                var sMCnt = oMarkers.length;
    
                // 마크 위치
                var oPoint = new google.maps.LatLng(Lat, Lng);

                // 등록된 키가 있는지 확인
                var KeyChk = -1;
                if (sMCnt > 0) {
                    for (var i in oMarkers) {
                        if (oMarkers[i] != null && oMarkers[i].Key == iKey) {
                            // 동일한 키가 있으면 위치 이동을 함!
                            KeyChk = i;
                            break;
                        }
                    }
                }

                if (KeyChk > -1) {
                    oMarkers[KeyChk].Marker.setPosition(oPoint); // 마크의 위치 이동
                    oMarkers[KeyChk].Marker.icon = markerURL;
                }
                else {
                    var image = markerURL;

                    var oMarker = new google.maps.Marker({
                                  position: oPoint,
                                  map: oMap,
                                  icon: image,
                                  title: iKey});

                    var sObj = new Object();
                    sObj.Key = iKey;
                    sObj.Marker = oMarker;

                    //마커 클릭 이벤트 핸들러 등록
                    var click_Listenerhandle = google.maps.event.addListener(oMarker, 'click', function() {
                      window.external.ScriptCallback_MapClick("Marker", oMarker.getPosition().lat(), oMarker.getPosition().lng(), oMarker.getTitle(), oMap.getZoom()/*고도*/);
                    });
                    sObj.click_Listenerhandle = click_Listenerhandle;

                    //마커 우 클릭 이벤트 핸들러 등록
                    var rightclick_Listenerhandle = google.maps.event.addListener(oMarker, 'rightclick', function() {
                      window.external.ScriptCallback_MapContextmenu("Marker", oMarker.getPosition().lat(), oMarker.getPosition().lng(), oMarker.getTitle(), oMap.getZoom()/*고도*/);
                    });
                    sObj.rightclick_Listenerhandle = rightclick_Listenerhandle;

                    //마커 더블 클릭 이벤트 핸들러 등록
                    var dblclick_Listenerhandle = google.maps.event.addListener(oMarker, 'dblclick', function() {
                      window.external.ScriptCallback_MapDblclick("Marker", oMarker.getPosition().lat(), oMarker.getPosition().lng(), oMarker.getTitle(), oMap.getZoom()/*고도*/);
                    });
                    sObj.dblclick_Listenerhandle = dblclick_Listenerhandle;
                    
                    //마커 Over 이벤트 핸들러 등록
                    var mouseover_Listenerhandle = google.maps.event.addListener(oMarker, 'mouseover', function() {
                      window.external.ScriptCallback_MapMousemove("Marker", oMarker.getPosition().lat(), oMarker.getPosition().lng(), oMarker.getTitle(), oMap.getZoom()/*고도*/);
                    });
                    sObj.mouseover_Listenerhandle = mouseover_Listenerhandle;
                    
                    //마커 Out 클릭 이벤트 핸들러 등록
                    var mouseout_Listenerhandle = google.maps.event.addListener(oMarker, 'mouseout', function() {
                      window.external.ScriptCallback_MapMousemove("Map", 0, 0, "", 0/*고도*/);
                    });
                    sObj.mouseout_Listenerhandle = mouseout_Listenerhandle;

                    oMarkers[sMCnt] = sObj; // 이벤트 핸들러 등록 후 배열에 마커 정보 추가

                    markerCluster.addMarker(oMarker);
                }
            }
            catch(e) { }
        }
        
        // 지정된 마크 제거
        function delMarker(iKey) {
            try
            {
                if (iKey == "") 
                {
                    for (var i in oMarkers) 
                    {
                        if (oMarkers[i].Marker != null) 
                        {
                            //이벤트 핸들러 제거
                            google.maps.event.removeListener(oMarkers[i].click_Listenerhandle);
                            google.maps.event.removeListener(oMarkers[i].rightclick_Listenerhandle);
                            google.maps.event.removeListener(oMarkers[i].dblclick_Listenerhandle);
                            google.maps.event.removeListener(oMarkers[i].mouseover_Listenerhandle);
                            google.maps.event.removeListener(oMarkers[i].mouseout_Listenerhandle);

                            markerCluster.removeMarker(oMarkers[i].Marker);

                            oMarkers[i].Marker.setMap(null);
                            var result = oMarkers.splice(i, 1);
                            result = null;
                        }
                    }
    
                    //등록된 라벨 삭제
                    /*for (var labelCount in oLabels) 
                    {
                        if (oLabels[labelCount].MarkerLabel != null) {
                            oMap.removeOverlay(oLabels[labelCount].MarkerLabel);
                            var result = oLabels.splice(labelCount, 1);
                            result = null;
                        }
                    }*/
                }
                else 
                {
                    for (var j in oMarkers) 
                    {
                        if (oMarkers[j] != null && oMarkers[j].Key == iKey) 
                        {
                            if (oMarkers[j].Marker != null) 
                            {
                                //이벤트 핸들러 제거
                                google.maps.event.removeListener(oMarkers[j].click_Listenerhandle);
                                google.maps.event.removeListener(oMarkers[j].rightclick_Listenerhandle);
                                google.maps.event.removeListener(oMarkers[j].dblclick_Listenerhandle);
                                google.maps.event.removeListener(oMarkers[j].mouseover_Listenerhandle);
                                google.maps.event.removeListener(oMarkers[j].mouseout_Listenerhandle);

                                markerCluster.removeMarker(oMarkers[j].Marker);

                                oMarkers[j].Marker.setMap(null);
                                var result = oMarkers.splice(j, 1);
                                result = null;
                                break;
                            }
                        }
                    }
    
                    //등록된 라벨 삭제
                    /*for (var labelCount2 in oLabels) 
                    {
                        if (oLabels[labelCount2].Key != null && oLabels[labelCount2].Key == iKey) 
                        {
                            if (oLabels[labelCount2].MarkerLabel != null) 
                            {
                                //TODO: 제거를 하니 자바스크립트에서 오류남
                                //oLabels[labelCount2] = null;
                                //oLabels[labelCount2].MarkerLabel.setVisible(false);
                                
                                oMap.removeOverlay(oLabels[labelCount2].MarkerLabel);
                                //oLabels[labelCount2] = null;
                                var result = oLabels.splice(labelCount2, 1);
                                result = null;
                            }
                            break;
                        }
                    }
                    */
                }
            }
            catch(e) { }
        }

        //마커 Visible
        function VisibleMarker(visible, iKey) {
            try
            {
                // 등록된 키가 있는지 확인
                var KeyChk = -1;
                var sMCnt = oMarkers.length;
                if (sMCnt > 0) {
                    for (var i in oMarkers) {
                        if (oMarkers[i] != null && oMarkers[i].Key == iKey) {
                            KeyChk = i;
                            break;
                        }
                    }
                }
    
                if (KeyChk > -1) {
                    oMarkers[KeyChk].Marker.setVisible(visible);
                }
            }
            catch(e) { }
        }

        function setLine(iKey, MapLines, strokeColor, strokeWidth, strokeOpacity, strokeStyle) {
            try
            {
                var sLCnt = oPolylines.length;
    
                // 좌표를 배열에 넣음
                var sMap = MapLines.split(";");
                var sLine = new Array();
                for (i = 0; i < sMap.length; i++) {
                    var sGPS = sMap[i].split(",");
                    sLine[i] = new google.maps.LatLng(sGPS[0], sGPS[1]);
                }
    
                // 중복 키 확인
                var KeyChk = -1;
                if (sLCnt > 0) {
                    for (var i in oPolylines) {
                        if (oPolylines[i] != null && oPolylines[i].Key == iKey) {
                            // 동일한 키가 있으면 위치 이동을 함!
                            KeyChk = i;
                            break;
                        }
                    }
                }
    
                if (KeyChk > -1) {
                    oPolylines[KeyChk].Polyline.setPath(sLine);
                }
                else {
                    var tPolyline = new google.maps.Polyline({
                                    path: sLine,
                                    strokeColor: strokeColor,
                                    strokeOpacity: strokeOpacity,
                                    strokeWeight: strokeWidth});
                    tPolyline.setMap(oMap);


                    var sObj = new Object();
                    sObj.Key = iKey;
                    sObj.Polyline = tPolyline;
                    oPolylines[sLCnt] = sObj; // 배열에 마크 추가
                }
            }
            catch(e) { }
        }
        
        // 지정된 라인 제거
        function delLine(iKey) {
            try
            {
                if (iKey == "") {
                    for (var i in oPolylines) {
                        if (oPolylines[i] != null && oPolylines[i].Polyline != null) {
                            oPolylines[i].Polyline.setMap(null);
                            var result = oPolylines.splice(i, 1);
                            result = null;
                        }
                    }
                }
                else {
                    for (var j in oPolylines) {
                        if (oPolylines[j] != null && oPolylines[j].Key == iKey) {
                            if (oPolylines[j].Polyline != null) {
                                oPolylines[j].Polyline.setMap(null);
                                var result = oPolylines.splice(j, 1);
                                result = null;
                            }
                            break;
                        }
                    }
                }
            }
            catch(e) { }
        }
        
        function setCircle(iKey, Lat, Lng, radius, strokeColor, strokeWidth, strokeOpacity, fillColor, fillOpacity) {
            try
            {
                var cPoint = new google.maps.LatLng(Lat, Lng);
    
                // 등록된 키가 있는지 확인
                var sMCnt = oCircles.length;
                var KeyChk = -1;
                if (sMCnt > 0) {
                    for (var i in oCircles) {
                        if (oCircles[i] != null && oCircles[i].Key == iKey) {
                            // 동일한 키가 있으면 위치 이동을 함!
                            KeyChk = i;
                            break;
                        }
                    }
                }
    
                if (KeyChk > -1) {
                    oCircles[KeyChk].Circle.setCenter(cPoint);
                    oCircles[KeyChk].Circle.setRadius(radius);
                }
                else {
                    var populationOptions = {
                        strokeColor: strokeColor,
                        strokeOpacity: strokeOpacity,
                        strokeWeight: strokeWidth,
                        fillColor: fillColor,
                        fillOpacity: fillOpacity,
                        map: oMap,
                        center: cPoint,
                        radius: radius
                      };
                    var oCircle = new google.maps.Circle(populationOptions);
    
                    var sObj = new Object();
                    sObj.Key = iKey;
                    sObj.Circle = oCircle;
                    oCircles[sMCnt] = sObj; // 배열에 마크 추가
                }
            }
            catch(e) { }
        }
        
        function delCircle(iKey) {
            try
            {
                if (iKey == "") {
                    for (var i in oCircles) {
                        if (oCircles[i] != null && oCircles[i].Circle != null) {
                            oCircles[i].Circle.setMap(null);
                            var result = oCircles.splice(i, 1);
                            result = null;
                        }
                    }
                }
                else {
                    for (var j in oCircles) {
                        if (oCircles[j] != null && oCircles[j].Key == iKey) {
                            if (oCircles[j].Circle != null) {
                                oCircles[j].Circle.setMap(null);
                                var result = oCircles.splice(j, 1);
                                result = null;
                            }
                            break;
                        }
                    }
                }
            }
            catch(e) { }
        }
        
        function setPolygon(iKey, MapLines, strokeColor, strokeWidth, strokeOpacity, strokeStyle, fillColor, fillOpacity) {
            try
            {
                var sLCnt = oPolygons.length;
    
                // 좌표를 배열에 넣음
                var sMap = MapLines.split(";");
                var sLine = new Array();
                for (i = 0; i < sMap.length; i++) {
                    var sGPS = sMap[i].split(",");
                    if (sGPS[0] != 0 && sGPS[1] != 0) {
                        sLine[i] = new google.maps.LatLng(sGPS[0], sGPS[1]);
                    }
                }
    
                // 중복 키 확인
                var KeyChk = -1;
                if (sLCnt > 0) {
                    for (var i in oPolygons) {
                        if (oPolygons[i] != null && oPolygons[i].Key == iKey) { // 동일한 키가 있으면 위치 이동을 함!
                            KeyChk = i;
                            break;
                        }
                    }
                }
    
                if (KeyChk > -1) {
                    oPolygons[KeyChk].Polygon.setPath(sLine);
                }
                else {
                    var tPolygon = new google.maps.Polygon({
                      paths: sLine,
                      strokeColor: strokeColor,
                      strokeOpacity: strokeOpacity,
                      strokeWeight: strokeWidth,
                      fillColor: fillColor,
                      fillOpacity: fillOpacity
                    });
                    tPolygon.setMap(oMap);
                    
                    var sObj = new Object();
                    sObj.Key = iKey;
                    sObj.Polygon = tPolygon;
                    oPolygons[sLCnt] = sObj;
                }
            }
            catch(e) { }
        }
        
        function delPolygon(iKey) {
            try
            {
                if (iKey == "") {
                    for (var i in oPolygons) {
                        if (oPolygons[i] != null && oPolygons[i].Polygon != null) {
                            oPolygons[i].Polygon.setMap(null);
                            var result = oPolygons.splice(i, 1);
                            result = null;
                        }
                    }
                }
                else {
                    for (var j in oPolygons) {
                        if (oPolygons[j] != null && oPolygons[j].Key == iKey) {
                            oPolygons[j].Polygon.setMap(null);
                            var result = oPolygons.splice(j, 1);
                            result = null;
                            break;
                        }
                    }
                }
            }
            catch(e) { }
        }

        function setInfoWindow(iKey, Lat, Lng, Msg, MarkerName) {
            try
            {
                var cPoint = new google.maps.LatLng(Lat, Lng);

                // 등록된 키가 있는지 확인
                var sMCnt = oInfoWindows.length;
                var KeyChk = -1;
                if (sMCnt > 0) {
                    for (var i in oInfoWindows) {
                        if (oInfoWindows[i] != null && oInfoWindows[i].Key == iKey + MarkerName) {
                            KeyChk = i;
                            break;
                        }
                    }
                }
    
                if (KeyChk > -1) {
                    //oInfoWindows[KeyChk].InfoWindow.setPoint(cPoint);
                    return;
                }
                else {
                    for (var j in oMarkers) {
                        if (oMarkers[j] != null && oMarkers[j].Key == MarkerName) {
                            var tInfoWindow = new google.maps.InfoWindow({
                                content: Msg,
                                position: cPoint
                            });
                            
                            //tInfoWindow.pixelOffset = new google.maps.Size(-100, -100);
                            
                            var sObj = new Object();
                            sObj.Key = iKey + MarkerName;
                            sObj.InfoWindow = tInfoWindow;
                            oInfoWindows[sMCnt] = sObj; // 배열에 마크 추가

                            var mouseover_Listenerhandle = google.maps.event.addListener(oMarkers[j].Marker, 'mouseover', function() {
                                oInfoWindows[sMCnt].InfoWindow.open(oMap, oMarkers[j].Marker);
                            });
                            sObj.mouseover_Listenerhandle = mouseover_Listenerhandle;
                            
                            var mouseout_Listenerhandle = google.maps.event.addListener(oMarkers[j].Marker, 'mouseout', function() {
                                oInfoWindows[sMCnt].InfoWindow.close();
                            });
                            sObj.mouseout_Listenerhandle = mouseout_Listenerhandle;

                            return;
                        }
                    }
                }
            }
            catch(e) { }
        }

        function delInfoWindow(iKey, MarkerName) {
            try
            {
                if (iKey == "") {
                    for (var i in oInfoWindows) {
                        if (oInfoWindows[i] != null && oInfoWindows[i].InfoWindow != null) {
                            google.maps.event.removeListener(oInfoWindows[i].mouseover_Listenerhandle);
                            google.maps.event.removeListener(oInfoWindows[i].mouseout_Listenerhandle);
                            var result = oInfoWindows.splice(i, 1);
                            result = null;
                        }
                    }
                }
                else {
                    for (var j in oInfoWindows) 
                    {
                        if (oInfoWindows[j] != null && oInfoWindows[j].Key == iKey + MarkerName) 
                        {
                            if (oInfoWindows[j].InfoWindow != null) 
                            {
                                google.maps.event.removeListener(oInfoWindows[j].mouseover_Listenerhandle);
                                google.maps.event.removeListener(oInfoWindows[j].mouseout_Listenerhandle);
                                var result = oInfoWindows.splice(j, 1);
                                result = null;
                            }
                            break;
                        }
                    }
                }
            }
            catch(e) { }
        }

        function activateTrafficMap(flag) {
            if(flag == true)
            {
                trafficLayer = new google.maps.TrafficLayer();
                trafficLayer.setMap(oMap);
            }
            else trafficLayer.setMap(null);
        }

        function LoadKMLLayer(url) {
            var kmlLayer = new google.maps.KmlLayer(url);
            kmlLayer.setMap(oMap);
        }
