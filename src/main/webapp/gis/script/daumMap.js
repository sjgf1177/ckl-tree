
    init(37.5010226, 127.0396037); // 시작 위치

    var isVisibleMarkerInfo = 0; //마커의 Visible 상태를 저장함
    var EventLatLng = "0,0"; // 이벤트 좌표값
    var EventKey = "";  // 이벤트 키
    var MouseMoveEventKey = "";  // 마우스 우클릭이 지원되지 않기 때문에 마우스 무브 이벤트로 EventKey를 따로 저장하기로 함
    var EventObject = ""; // 이벤트 종류 (Marker,Polyline,Polygon,Circle,InfoWindow...)
    var lastClickEventKey = ""; //마커의 더블클릭이 안되기 때문
    var isMarkerMouseOver = false;

    //마우스 오버시 사용하는 라벨
    //var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
    //oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는

    //특정 마커에 대한 라벨을 항상 보여주거나 보여주지 않을 경우에 사용하는 라벨
    var oLabels = new Array();      // 마커 정보들

    var oMarkers = new Array();     // 마커
    var lMarkers = new Array();     // 라벨 마커
    var oPolylines = new Array();   // 라인
    var oPolygons = new Array();    // 도형
    var oCircles = new Array(); 	  // 원
    var oInfoWindows = new Array(); // 정보창
        
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

    function ShowErrorMsg() {
      document.write("Error");
      alert("Error");
    }
    
    function init(Lat, Lng) {
        var company = getQuerystring("Company");
        if(hex_md5(company) != "27bf04637aece773c6b9ee11645c8152") 
        {
            ShowErrorMsg();
            return;
        }

        var position = new daum.maps.LatLng(Lat, Lng);

        oMap = new daum.maps.Map(document.getElementById('map'), {
            center: position,
            level: 4,
            //mapTypeId: daum.maps.MapTypeId.HYBRID
            mapTypeId: daum.maps.MapTypeId.ROADMAP
        });

        //컨트롤 넣기
        var zoomControl = new daum.maps.ZoomControl();
        oMap.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
        //var mapTypeControl = new daum.maps.MapTypeControl();
        //oMap.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

        //툴바에 위/경도 표시
        daum.maps.event.addListener(oMap, "mousemove", function(event) {
            if(isMarkerMouseOver == false)
            {
                window.external.ScriptCallback_MapMousemove("Map", event.latLng.getLat(), event.latLng.getLng(), "", oMap.getLevel()/*고도*/);
            }
        });

        //마커에 대한 마우스 우클릭 이벤트가 없고 지도에 대한 마우스 우 클릭시 좌표를 전달
        daum.maps.event.addListener(oMap, "rightclick", function(event) {
            EventObject = "Map"; // 이벤트에 발생한 객체
            EventLatLng = event.latLng.getLat() + "," + event.latLng.getLng(); // 이벤트에 발생한 좌표 세팅
            window.external.ScriptCallback_MapContextmenu(EventObject, event.latLng.getLat(), event.latLng.getLng(), "", oMap.getLevel()/*고도*/);
        });

        daum.maps.event.addListener(oMap, "mouseup", function(event) {
            EventObject = "Map"; // 이벤트에 발생한 객체
            EventLatLng = event.latLng.getLat() + "," + event.latLng.getLng(); // 이벤트에 발생한 좌표 세팅
            window.external.ScriptCallback_MapMouseup(EventObject, event.latLng.getLat(), event.latLng.getLng(), "", oMap.getLevel()/*고도*/);
        });

        daum.maps.event.addListener(oMap, "click", function(event) {
            EventObject = "Map"; // 이벤트에 발생한 객체
            EventLatLng = event.latLng.getLat() + "," + event.latLng.getLng(); // 이벤트에 발생한 좌표 세팅
            window.external.ScriptCallback_MapClick(EventObject, event.latLng.getLat(), event.latLng.getLng(), "", oMap.getLevel()/*고도*/);
        });

        daum.maps.event.addListener(oMap, "dblclick", function(event) {
            EventObject = "Map"; // 이벤트에 발생한 객체
            EventLatLng = event.latLng.getLat() + "," + event.latLng.getLng(); // 이벤트에 발생한 좌표 세팅
            var sendKey = lastClickEventKey;
            if (lastClickEventKey != "") {
                EventObject = "Marker";
                lastClickEventKey = "";
            }
            window.external.ScriptCallback_MapDblclick(EventObject, event.latLng.getLat(), event.latLng.getLng(), sendKey, oMap.getLevel()/*고도*/);
        });
    }

    //중심점 이동
    function setCenter(Lat, Lng) {
        try
        {
            oMap.setCenter(new daum.maps.LatLng(Lat, Lng));
        }
        catch(e) { }
    }

    //중심점 부드럽게 이동
    function setSoftCenter(Lat, Lng) {
        try
        {
            oMap.panTo(new daum.maps.LatLng(Lat, Lng));
        }
        catch(e) { }
    }

    function getCenter() {
        try
        {
            var pos = oMap.getCenter();
            return pos.getLat() + "," + pos.getLng();
        }
        catch(e) { }
        
        return 0 + "," + 0;
    }

    function Resize(width, height) {
        var nSize = new daum.maps.Size(width, height);
    }

    function setLevel(Level) {
        oMap.setLevel(Level);
    }

    function getLevel() {
        return oMap.getLevel();
    }

    function setMapMode(mapMode) {
        if (mapMode == 0)
            oMap.setMapTypeId(daum.maps.MapTypeId.ROADMAP);
        else if (mapMode == 1)
            oMap.setMapTypeId(daum.maps.MapTypeId.HYBRID);
        else if (mapMode == 2)
            oMap.setMapTypeId(daum.maps.MapTypeId.SKYVIEW);
    }

    var isDrawing = false;
    
    function setPolygon(iKey, MapLines, strokeColor, strokeWidth, strokeOpacity, strokeStyle, fillColor, fillOpacity) {
        try
        {
            if(isDrawing) return;
        
            isDrawing = true;
        
            var sLCnt = oPolygons.length;
    
            // 좌표를 배열에 넣음
            var sMap = MapLines.split(";");
            var sLine = new Array();
            for (i = 0; i < sMap.length; i++) {
                var sGPS = sMap[i].split(",");
                if (sGPS[0] != 0 && sGPS[1] != 0) {
                    sLine[i] = new daum.maps.LatLng(sGPS[0], sGPS[1]);
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
                var tPolygon = new daum.maps.Polygon({
                    strokeWeight: strokeWidth,
                    strokeColor: strokeColor,
                    strokeOpacity: strokeOpacity,
                    fillColor: fillColor,
                    fillOpacity: fillOpacity
                });
    
                tPolygon.setPath(sLine);
                tPolygon.setMap(oMap);
    
                var sObj = new Object();
                sObj.Key = iKey;
                sObj.Polygon = tPolygon;
                oPolygons[sLCnt] = sObj;
    
                //tPolygon.setPath(sLine);
                //tPolygon.setMap(oMap);
            }
            
            sLine = null;
        }
        catch(e) { }
        
        isDrawing = false;
    }

    function delPolygon(iKey) {
        try
        {
            if (iKey == "") {
                for (var i in oPolygons) {
                    if (oPolygons[i] != null && oPolygons[i].Polygon != null) {
                        oPolygons[i].Polygon.setMap(null);
                        //oPolygons[i] = null;
                        var result = oPolygons.splice(i, 1);
                        result = null;
                    }
                }
            }
            else {
                for (var j in oPolygons) {
                    if (oPolygons[j] != null && oPolygons[j].Key == iKey) {
                        if (oPolygons[j].Polygon != null) {
                            oPolygons[j].Polygon.setMap(null);
                            //oPolygons[j] = null;
                            var result = oPolygons.splice(j, 1);
                            result = null;
                        }
                        break;
                    }
                }
            }
        }
        catch(e) { }
    }

    //총 길이를 m(미터)단위로 반환
    function getPolygonLength(iKey) {
        try
        {
            var KeyChk = -1;
            for (var i in oPolygons) {
                if (oPolygons[i] != null && oPolygons[i].Key == iKey) {
                    KeyChk = i;
                    break;
                }
            }
    
            if (KeyChk > -1) {
                return oPolygons[KeyChk].Polygon.getLength();
            }
        }
        catch(e) { }
        return 0;
    }

    //영역의 넓이를 ㎡(제곱미터)단위로 반환
    function getPolygonArea(iKey) {
        try
        {
            var KeyChk = -1;
            for (var i in oPolygons) {
                if (oPolygons[i] != null && oPolygons[i].Key == iKey) {
                    KeyChk = i;
                    break;
                }
            }
    
            if (KeyChk > -1) {
                return oPolygons[KeyChk].Polygon.getArea();
            }
        }
        catch(e) { }
        return 0;
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
                sLine[i] = new daum.maps.LatLng(sGPS[0], sGPS[1]);
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
                var tPolyline = new daum.maps.Polyline({
                    strokeWeight: strokeWidth,
                    strokeColor: strokeColor,
                    strokeOpacity: strokeOpacity,
                    fillColor: 0,
                    fillOpacity: 0,
                    endArrow: false
                });
    
                var sObj = new Object();
                sObj.Key = iKey;
                sObj.Polyline = tPolyline;
                oPolylines[sLCnt] = sObj; // 배열에 마크 추가
    
                tPolyline.setPath(sLine);
                tPolyline.setMap(oMap);
            }
            
            sLine = null;
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
                        //oPolylines[i] = null;
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
                            //oPolylines[j] = null;
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

    function setInfoWindow(iKey, Lat, Lng, Msg) {
        try
        {
            var cPoint;
            cPoint = new daum.maps.LatLng(Lat + 0.00009, Lng);
    
            // 등록된 키가 있는지 확인
            var sMCnt = oInfoWindows.length;
            var KeyChk = -1;
            if (sMCnt > 0) {
                for (var i in oInfoWindows) {
                    if (oInfoWindows[i] != null && oInfoWindows[i].Key == iKey) {
                        // 동일한 키가 있으면 위치 이동을 함!
                        KeyChk = i;
                        break;
                    }
                }
            }
    
            if (KeyChk > -1) {
                oInfoWindows[KeyChk].InfoWindow.setPosition(cPoint);
                oInfoWindows[KeyChk].InfoWindow.setContent(Msg);
            }
            else {
                var tInfoWindow = new daum.maps.InfoWindow({
                    position: cPoint,
                    content: Msg,
                    disableAutoPan: true
                });
    
                var sObj = new Object();
                sObj.Key = iKey;
                sObj.InfoWindow = tInfoWindow;
                oInfoWindows[sMCnt] = sObj; // 배열에 마크 추가
    
                //oMap.addOverlay(oInfoWindows[sMCnt].InfoWindow); // 마크를 지도에 추가
    
                tInfoWindow.open(oMap);
    
            }
        }
        catch(e) { }
    }

    function delInfoWindow(iKey) {
        try
        {
            if (iKey == "") {
                for (var i in oInfoWindows) {
                    if (oInfoWindows[i] != null && oInfoWindows[i].InfoWindow != null) {
                        oInfoWindows[i].InfoWindow.close();
                        //oInfoWindows[i].InfoWindow.open(null);
                        //oInfoWindows[i] = null;
                        var result = oInfoWindows.splice(i, 1);
                        result = null;
                    }
                }
            }
            else {
                for (var j in oInfoWindows) {
                    if (oInfoWindows[j] != null && oInfoWindows[j].Key == iKey) {
                        if (oInfoWindows[j].InfoWindow != null) {
                            oInfoWindows[j].InfoWindow.close();
                            //oInfoWindows[j].InfoWindow.open(null);
                            //oInfoWindows[j] = null;
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

    function setCircle(iKey, Lat, Lng, radius, strokeColor, strokeWidth, strokeOpacity, fillColor, fillOpacity) {
        try
        {
            var cPoint;
            cPoint = new daum.maps.LatLng(Lat, Lng);
    
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
                oCircles[KeyChk].Circle.setPosition(cPoint);
                oCircles[KeyChk].Circle.setRadius(radius);
            }
            else {
                var oCircle = new daum.maps.Circle({
                    center: new daum.maps.LatLng(Lat, Lng),
                    radius: radius,
                    strokeWeight: strokeWidth,
                    strokeColor: strokeColor,
                    fillColor: fillColor,
                    fillOpacity: fillOpacity
                });
    
                var sObj = new Object();
                sObj.Key = iKey;
                sObj.Circle = oCircle;
                oCircles[sMCnt] = sObj; // 배열에 마크 추가
    
                oCircle.setMap(oMap);
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
                        //oCircles[i] = null;
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
                            //oCircles[j] = null;
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

    function setGISMarker(iKey, Lat, Lng, iMsg, markerURL, widthSize, heightSize) {
        try
        {
            if (Lat == null || Lng == null || Lat == "" || Lng == "" || Lat == 0 || Lng == 0) {
                return;
            }
            var sMCnt = oMarkers.length;
    
            // 마크 위치
            var oPoint;
            oPoint = new daum.maps.LatLng(Lat, Lng);
    
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
                oMarkers[KeyChk].Marker.setPosition(oPoint);

                var icon = new daum.maps.MarkerImage(markerURL, new daum.maps.Size(widthSize, heightSize), new daum.maps.Point(widthSize / 2, heightSize / 2), "poly", "1,20,1,9,5,2,10,0,21,0,27,3,30,9,30,20,17,33,14,33");
                oMarkers[KeyChk].Marker.setImage(icon);
            }
            else {
                //TRIUMi Marker Image
                var icon = new daum.maps.MarkerImage(markerURL, new daum.maps.Size(widthSize, heightSize), new daum.maps.Point(widthSize / 2, heightSize / 2), "poly", "1,20,1,9,5,2,10,0,21,0,27,3,30,9,30,20,17,33,14,33");

                var oMarker = new daum.maps.Marker({
                    position: new daum.maps.LatLng(Lat, Lng),
                    image: icon
                });

                var sObj = new Object();
                sObj.Key = iKey;
                sObj.Marker = oMarker;
                oMarkers[sMCnt] = sObj; // 배열에 마크 추가

                oMarker.setMap(oMap);
                oMarker.setTitle(iMsg);
                oMarker.setDraggable(false);
                oMarker.setVisible(true);

                daum.maps.event.addListener(oMarker, "click", function(event) {
                    //alert("왼쪽 클릭!");
                    //infowindow.open(oMap, oMarker);

                    EventObject = "Marker"; // 이벤트에 발생한 객체
                    EventLatLng = oMarker.getPosition().getLat() + "," + oMarker.getPosition().getLng(); // 이벤트에 발생한 좌표 세팅
                    EventKey = oMarker.getTitle(); // 이벤트에 발생한 키 세팅

                    //같이 저장함
                    if (oMarker.getTitle() != "mapClick" && oMarker.getTitle() != "선택") {
                        lastClickEventKey = oMarker.getTitle();
                    }

                    //click = 1;
                    window.external.ScriptCallback_MapClick(EventObject, oMarker.getPosition().getLat(), oMarker.getPosition().getLng(), EventKey, oMap.getLevel()/*고도*/);
                });

                //실제 Map의 rightclick 이벤트는 되나 Marker의 rightclick는 다음에서 지원되지 않음
                //daum.maps.event.addListener(oMarker, "rightclick", function(event) 
                //{
                //EventObject = "Marker"; // 이벤트에 발생한 객체
                ////EventLatLng = oMarker.getPosition().getLat() + "," + oMarker.getPosition().getLng(); // 이벤트에 발생한 좌표 세팅
                //EventLatLng = event.latLng.getLat() + "," + event.latLng.getLng(); // 이벤트에 발생한 좌표 세팅
                //EventKey = oMarker.getTitle(); // 이벤트에 발생한 키 세팅
                //contextmenu = 1;
                //window.external.ScriptCallback_MapContextmenu(EventObject, oMarker.getPosition().getLat(), oMarker.getPosition().getLng(), EventKey, oMap.getLevel()/*고도*/);
                //});

                //rightclick가 지원되지 않기 때문에 mouseover로 판단함
                daum.maps.event.addListener(oMarker, "mouseover", function(event) {
                    isMarkerMouseOver = true;
                    EventObject = "Marker"; // 이벤트에 발생한 객체
                    EventLatLng = oMarker.getPosition().getLat() + "," + oMarker.getPosition().getLng(); // 이벤트에 발생한 좌표 세팅
                    MouseMoveEventKey = oMarker.getTitle(); // 이벤트에 발생한 키를 MouseMoveEventKey로 별도 저장함
                    window.external.ScriptCallback_MapMousemove(EventObject, oMarker.getPosition().getLat(), oMarker.getPosition().getLng(), MouseMoveEventKey, oMap.getLevel()/*고도*/);
                });

                daum.maps.event.addListener(oMarker, "mouseout", function(event) {
                    isMarkerMouseOver = false;
                    EventObject = "Map";
                    MouseMoveEventKey = "";
                    window.external.ScriptCallback_MapMousemove(EventObject, oMarker.getPosition().getLat(), oMarker.getPosition().getLng(), "", oMap.getLevel()/*고도*/);
                });

                /*daum.maps.event.addListener(oMarker, "dblclick", function(event) {
                    alert("더블 클릭!");
                });*/
            }
        }
        catch(e) { }
    }

    // 지정된 마크 제거
    function delMarker(iKey) {
        try
        {
            if (iKey == "") {
                for (var i in oMarkers) {
                    if (oMarkers[i].Marker != null) {
                        //다음 마커 이벤트 제거
                        daum.maps.event.removeListener(oMarkers[i].Marker, "click", function() { });

                        oMarkers[i].Marker.setMap(null);
                        //oMarkers[i] = null;
                        var result = oMarkers.splice(i, 1);
                        result = null;
                    }
                }
    
                //등록된 라벨 삭제
                //다음은 라벨이 없음
                DelTextMarker(iKey);
            }
            else {
                for (var j in oMarkers) {
                    if (oMarkers[j] != null && oMarkers[j].Key == iKey) {
                        //다음 마커 이벤트 제거
                        daum.maps.event.removeListener(oMarkers[j].Marker, "click", function() { });
    
                        oMarkers[j].Marker.setMap(null);
                        //oMarkers[j] = null;
                        var result = oMarkers.splice(j, 1);
                        result = null;
                        break;
                    }
                }
    
                //등록된 라벨 삭제
                //다음은 라벨이 없음
                DelTextMarker(iKey);
            }
        }
        catch(e) { }
    }
    
    function SetDaumSimpleTextMarker(iKey, Lat, Lng, iMsg, isfacility) 
    {
        try
        {
            var sMCnt = lMarkers.length;
    
            // 마크 위치
            var oPoint = new daum.maps.LatLng(Lat, Lng);
    
            // 등록된 키가 있는지 확인
            var KeyChk = -1;
            if (sMCnt > 0) {
                for (var i in lMarkers) {
                    if (lMarkers[i] != null && lMarkers[i].Key == iKey) {
                        // 동일한 키가 있으면 위치 이동을 함!
                        KeyChk = i;
                        break;
                    }
                }
            }
    
            if (KeyChk > -1) 
            {
                lMarkers[KeyChk].Marker.setPosition(oPoint);
            }
            else
            {
                var marker = new SimpleTextMarker(oPoint, iMsg, isfacility);
                
                var sObj = new Object();
                sObj.Key = iKey;
                sObj.Marker = marker;
                lMarkers[sMCnt] = sObj; // 배열에 마크 추가
    
                marker.setMap(oMap);
            }
        }
        catch(e) { }
    }
    
    function DelTextMarker(iKey) 
    {
        try
        {
            var KeyChk = -1;
            var sMCnt = lMarkers.length;
            if (sMCnt > 0) {
                for (var i in lMarkers) {
                    if (lMarkers[i] != null && lMarkers[i].Key == iKey) {
                        KeyChk = i;
                        break;
                    }
                }
            }
            if (KeyChk > -1) {
                lMarkers[KeyChk].Marker.setMap(null);
                //lMarkers[KeyChk] = null;
                var result = lMarkers.splice(KeyChk, 1);
                result = null;
            }
        }
        catch(e) { }
    }
    
    function SimpleTextMarker(position, text, isfacility) 
    {
        try
        {
          	this.position_ = position;
          	this.node_ = document.createElement('div');
          	this.node_.style.position = 'absolute';
          	this.node_.style.whiteSpace = 'nowrap';
          	if(isfacility == 1)
              	this.node_.style.color = 'red';
            else this.node_.style.color = 'blue';
          	this.node_.style.background = 'white';
          	this.node_.style.filter = 'alpha(opacity=70)';
          	this.node_.appendChild(document.createTextNode(text));
      	}
        catch(e) { }
    }
    
    SimpleTextMarker.prototype = new daum.maps.AbstractOverlay;
     
    SimpleTextMarker.prototype.onAdd = function() {
    	  var panel = this.getPanels().overlayLayer;
    	  panel.appendChild(this.node_);
    };
     
    SimpleTextMarker.prototype.onRemove = function() {
    	  this.node_.parentNode.removeChild(this.node_);
    };
     
    SimpleTextMarker.prototype.draw = function() {
      	var projection = this.getProjection();
      	var point = projection.pointFromCoords(this.position_);
      	var width = this.node_.offsetWidth;
      	var height = this.node_.offsetHeight;
      	
      	this.node_.style.left = (point.x - width/2) + "px";
      	this.node_.style.top = (point.y - height/2 + 30) + "px";
    };

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

    function LoadView(Lat, Lng) {
        //var rv = new DRoadView("roadview",{point : new DLatLng(Lat, Lng),width:600,height:400,pan:159.42550649515107,tilt:-12.867677148979645,zoom:1 })

        var rv = new daum.maps.Roadview("map", { point: new daum.maps.LatLng(Lat, Lng), width: 600, height: 400, pan: 159.42550649515107, tilt: -12.867677148979645, zoom: 1 })

        /*var p = new daum.maps.LatLng(Lat, Lng);
        var rc = new daum.maps.RoadviewClient();
        //var rv = new daum.maps.Roadview(document.getElementById("roadview"));
        var rv = new daum.maps.Roadview('map');
        //alert('1');

          	rc.getNearestPanoId(p, 100, function(panoid) 
        {
        rv.setPanoId(panoid);
        });
        */
    }

    // 이벤트 처리
    function getEventObject() {
        if (EventObject == null) return "";
        return EventObject;
    }

    // 마우스 우클릭이 지원되지 않기 때문에 마우스 무브 이벤트로 EventKey를 따로 저장하기로 함
    function getMouseMoveEventKey() {
        var r = MouseMoveEventKey;
        //MouseMoveEventKey = ""; //삭제하지 않음
        return r;
    }
	
