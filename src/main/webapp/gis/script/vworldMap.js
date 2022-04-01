
        var SOPPlugin;
        var lastClickLongitude;
        var lastClickLatitude;
        var lastRMouseUpLongitude;
        var lastRMouseUpLatitude;
        var lastLMouseUpLongitude;
        var lastLMouseUpLatitude;
        var lastRMouseDownLongitude;
        var lastRMouseDownLatitude;
        var lastAltitude;           //마우스로 클릭한 지점의 고도

        //마우스 클릭시 객체를 저장
        var selectedObj;
        //마우스 클릭시 객체 선택 이벤트
        var lClickSelectedObj;
        var rClickSelectedObj

        var directTimerID;
        var directValue = 360;

        setTimeout(function() {
            sop.earth.createInstance('VworldMap', initCall, failureCall);
        }, 1);

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

        function initCall(obj) {
            var company = getQuerystring("Company");
            if(hex_md5(company) != "27bf04637aece773c6b9ee11645c8152") return;

            SOPPlugin = obj;
            //SOPPlugin.getViewCamera().moveLonLat(127.0405,37.5016); //초기 서울 원거리로 보기 강남
            SOPPlugin.getViewCamera().moveLonLat(127.092534179821, 37.6063659001898); //중량구
            SOPPlugin.getViewCamera().setAltitude(7000);

            //클릭 이벤트 추가
            window.sop.earth.addEventListener(SOPPlugin, "click", eventClickListenerCallback);

            //오른쪽 마우스 업 이벤트 추가
            window.sop.earth.addEventListener(SOPPlugin, "rmouseup", eventRMouseUpListenerCallback);

            //왼쪽 마우스 업 이벤트 추가
            window.sop.earth.addEventListener(SOPPlugin, "lmouseup", eventLMouseUpListenerCallback);

            //오른쪽 마우스 다운 이벤트 추가
            window.sop.earth.addEventListener(SOPPlugin, "rmousedown", eventRMouseDownListenerCallback);
            window.sop.earth.addEventListener(SOPPlugin, "mouseover", eventMouseOverListenerCallback);
            window.sop.earth.addEventListener(SOPPlugin, "mouseout", eventMouseOutListenerCallback);

            //마우스 이동
            window.sop.earth.addEventListener(SOPPlugin, "mousemove", eventMouseMoveListenerCallback);

            //마우스 더블클릭 이벤트
            window.sop.earth.addEventListener(SOPPlugin, "dblclick", eventMouseDoubleListenerCallback);
            
            //영상 출처 정보 감추기
            SOPPlugin.getOption().setMetaInfoVisible(sop.cons.enums.SOPVISIBLE_OFF);
        }

        //지도 초기화
        function InitializeMap() {
            try {
                if (SOPPlugin == null) {
                    return -1;
                }
                else return 1;
            }
            catch (e) { }
        }

        //클릭한 좌표에 대하여 위/경도를 저장한다.
        function eventClickListenerCallback(e) {
            try {
                //var point = e.getMapCoordinate();
                //if (point == null) return;

                //lastClickLongitude = point.longitude;
                //lastClickLatitude = point.latitude;

                lastClickLongitude = e.lon;
                lastClickLatitude = e.lat;
                
                //여기서 고도 구하면 UI에서 버벅이는 현상 발생
                //클릭 지점의 실제 위 경도의 고도를 구할려면 GetAltitudeByPosition()를 이용
                //lastAltitude = SOPPlugin.getView().getTerrHeight(lastRMouseUpLongitude, lastRMouseUpLatitude);

                var markerName = "";
                var eventObject = "Map";

                if (e.getTarget() != null) {
                    if (e.getTarget().getType() == "SOPPoint") {
                        selectedObj = e.getTarget();
                        markerName = selectedObj.getId();
                        eventObject = "Marker";
                    }
                }

                window.external.ScriptCallback_MapClick(eventObject, e.lat, e.lon, markerName, lastAltitude);
            }
            catch (e) { }
        }

        //마우스 우 클릭 업 좌표에 대하여 위/경도를 저장한다.
        function eventRMouseUpListenerCallback(e) {
            try {
                //var point = e.getMapCoordinate();
                lastRMouseUpLongitude = e.lon;
                lastRMouseUpLatitude = e.lat;

                //여기서 고도 구하면 UI에서 버벅이는 현상 발생
                //클릭 지점의 실제 위 경도의 고도를 구할려면 GetAltitudeByPosition()를 이용
                //lastAltitude = SOPPlugin.getView().getTerrHeight(lastRMouseUpLongitude, lastRMouseUpLatitude);

                var markerName = "";
                var eventObject = "Map";

                //마우스 우 클릭 업 시 마커가 선택되어 있는지 확인
                if (e.getTarget() != null) {
                    if (e.getTarget().getType() == "SOPPoint") {
                        selectedObj = e.getTarget();
                        markerName = selectedObj.getId();
                        eventObject = "Marker";
                    }
                }

                window.external.ScriptCallback_MapContextmenu(eventObject, e.lat, e.lon, markerName, lastAltitude);
            }
            catch (e) { }
        }

        //마우스 좌 클릭 업 좌표에 대하여 위/경도를 저장한다.
        function eventLMouseUpListenerCallback(e) {
            try {
            
                //var point = e.getMapCoordinate();
                lastLMouseUpLongitude = e.lon;
                lastLMouseUpLatitude = e.lat;

                //여기서 고도 구하면 UI에서 버벅이는 현상 발생
                //클릭 지점의 실제 위 경도의 고도를 구할려면 GetAltitudeByPosition()를 이용
                //lastAltitude = SOPPlugin.getView().getTerrHeight(lastLMouseUpLongitude, lastLMouseUpLatitude);

                var markerName = "";
                var eventObject = "Map";

                //마우스 우 클릭 업 시 마커가 선택되어 있는지 확인
                if (e.getTarget() != null) {
                    if (e.getTarget().getType() == "SOPPoint") {
                        selectedObj = e.getTarget();
                        markerName = selectedObj.getId();
                        eventObject = "Marker";
                    }
                }

                window.external.ScriptCallback_MapMouseup(eventObject, e.lat, e.lon, markerName, lastAltitude);
            }
            catch (e) { }
        }

        function eventRMouseDownListenerCallback(e) {
            try {
                //var point = e.getMapCoordinate();
                lastRMouseDownLongitude = e.lon;
                lastRMouseDownLatitude = e.lat;

                //여기서 고도 구하면 UI에서 버벅이는 현상 발생
                //클릭 지점의 실제 위 경도의 고도를 구할려면 GetAltitudeByPosition()를 이용
                //lastAltitude = SOPPlugin.getView().getTerrHeight(lastRMouseUpLongitude, lastRMouseUpLatitude);
            }
            catch (e) { }
        }
        
        function eventMouseOverListenerCallback(e) {
            try {
                if (e.getTarget() != null) {
                    if (e.getTarget().getType() == "SOPPoint") {
                        window.external.ScriptCallback_MapMouseOver("Marker", e.lat, e.lon, e.getTarget().getId());
                    }
                }
                else window.external.ScriptCallback_MapMouseOver("Map", e.lat, e.lon, "");
            }
            catch (e) { }
        }
        
        function eventMouseOutListenerCallback(e) {
            try {
                var markerName = "";
                var eventObject = "Map";
                if (e.getTarget() != null) {
                    if (e.getTarget().getType() == "SOPPoint") {
                        selectedObj = e.getTarget();
                        markerName = selectedObj.getId();
                        eventObject = "Marker";
                    }
                }
                window.external.ScriptCallback_MapMouseOut(eventObject, e.lat, e.lon, markerName);
            }
            catch (e) { }
        }
        
        function eventMouseMoveListenerCallback(e) {
            try {
                //window.external.ScriptCallback_MapMousemove(e.lat, e.lon);
                window.external.ScriptCallback_MapMousemove("Map", e.lat, e.lon, "", 0/*고도*/);
            }
            catch (e) { }
        }
        
        function eventMouseDoubleListenerCallback(e) {
            try {
                //var point = e.getMapCoordinate();
                lastLMouseUpLongitude = e.lon;
                lastLMouseUpLatitude = e.lat;

                //여기서 고도 구하면 UI에서 버벅이는 현상 발생
                //클릭 지점의 실제 위 경도의 고도를 구할려면 GetAltitudeByPosition()를 이용
                //lastAltitude = SOPPlugin.getView().getTerrHeight(lastLMouseUpLongitude, lastLMouseUpLatitude);

                var markerName = "";
                var eventObject = "Map";

                //마우스 우 클릭 업 시 마커가 선택되어 있는지 확인
                if (e.getTarget() != null) {
                    if (e.getTarget().getType() == "SOPPoint") {
                        selectedObj = e.getTarget();
                        //alert(selectedObj.getId());

                        markerName = selectedObj.getId();
                        eventObject = "Marker";
                    }
                }

                window.external.ScriptCallback_MapDblclick(eventObject, e.lat, e.lon, markerName, lastAltitude);
            }
            catch (e) { }
        }

        //장치 ID, 마커 이름, 위경도, terrHeight: 장치 높이(고도)
        function AddMarker(deviceID, markerName, lon, lat, altitide, markerIconURL, widthSize, heightSize) {
            try {
                if (SOPPlugin == null) return -1;

                var vec3_1 = SOPPlugin.createVec3();
                vec3_1.set(lon, lat, altitide);   //고도를 정확하게 입력하지 않으면 지도가 움직일때 같이 움직임

                var vecarray = SOPPlugin.createVec3Array();
                vecarray.push(vec3_1);
                var va = vecarray

                //입력점은 각각 SOPVec3객체에 프로퍼티로 저장되며, 저장된 SOPVec3객체를 SOPVec3Array객체에서 리스트로 관리합니다.
                //여러 입력점 중 첫번째 입력한 지점의 좌표를 추출합니다.
                pt = va.get(0);
                var poi, symbolizdPoi;
                var objId = deviceID;

                // Placemark 객체를 생성합니다.
                poi = SOPPlugin.createPoint(objId);

                // 생성된 Polygon객체에 입력점을 적용합니다
                poi.Set(pt)

                //Polygon 객체에 스타일을 적용합니다.
                //스타일 적용은 먼저 해당 객체에 있는 SOPStyle객체를 반환받아 스타일을 적용합니다.
                //Placemark의 아이콘은 SOPStyle객체에서 SOPIcon객체를 반환받아, SOPIcon객체에 아이콘이미지의 절대경로나 URL을 입력한 후 
                //입력한 SOPIcon객체를 SOPStyle객체에 삽입하여 적용합니다.
                var sym = poi.getSymbol();
                var icon = sym.getIcon();

                icon.setNormalIcon(markerIconURL);  //TEST URL http://vworld.kr/images/op02/map_point.png

                sym.setIcon(icon);
                poi.setSymbol(sym);

                //Placemark의 아래에 표시할 텍스트를 설정합니다.
                poi.setName(markerName);

                //지도에 Placemark를 설정합니다.
                SOPPlugin.getView().addChild(poi, 8);
                SOPPlugin.getView().setWorkMode(sop.cons.mouseState.SOPMOUSE_MOVEGRAB);
                //window.sop.earth.addEventListener(poi, "mouseover", Event_SOPBalloon);    //툴팁처럼 사용 안함
            }
            catch (e) { }
        }

        function Event_SOPBalloon(event) {
            try {
                if (SOPPlugin != null) {
                    var targetName = event.getTarget().getId();
                    SOPPlugin.closeBalloon();
                    var balloon = SOPPlugin.createHtmlBalloon();
                    balloon.setTarget(event.getTarget());
                    balloon.setMaxWidth(150);
                    balloon.setMaxHeight(20);
                    balloon.setMinWidth(150);
                    balloon.setMinHeight(20);
                    balloon.setCloseButton(true);
                    balloon.setHtmlString(targetName);
                    balloon.setWidth_(150);
                    balloon.setHeight_(20);
                    balloon.show_(true);
                    SOPPlugin.setBalloon(balloon, true);
                }
            }
            catch (e) { }
        }

        //마우스 오른쪽 클릭 업 이벤트 발생시 오브젝트의 ID
        function GetSelectedID() {
            try {
                if (selectedObj != null) {
                    rClickSelectedObj = "";
                    lClickSelectedObj = "";

                    return selectedObj.getId();
                }
            }
            catch (e) { }
        }

        //선택된 마커 삭제
        function RemoveMarker() {
            try {
                if (SOPPlugin == null || selectedObj == null) return;
                if (selectedObj) {
                    SOPPlugin.getUserLayer().removeAtObject(selectedObj);
                    SOPPlugin.getView().MapRender();
                }
            }
            catch (e) { }
        }

        //특정 마커 삭제
        function RemoveMarkerAtID(markerID) {
            try {
                if (SOPPlugin == null) return;

                var SOPObject = SOPPlugin.getUserLayer().keyAtObject(markerID);
                if (SOPPlugin.getUserLayer().keyAtObject(markerID) != null) {
                    SOPPlugin.getUserLayer().removeAtID(markerID);
                }
            }
            catch (e) { }
        }

        //모든 마커 삭제
        function RemoveAllMarker() {
            try {
                if (SOPPlugin == null) return;
                SOPPlugin.getUserLayer().removeAll();
            }
            catch (e) { }
        }

        //마커의 Visible 상태 변경
        function SetMarkerVisible(markerID, isVisible) {
            try {
                if (SOPPlugin == null) return;

                if (SOPPlugin.getUserLayer().keyAtObject(markerID) != null) {
                    if (isVisible == true) SOPPlugin.getUserLayer().keyAtObject(markerID).setVisible(SOPPlugin.SOPVISIBLE_ON);
                    else SOPPlugin.getUserLayer().keyAtObject(markerID).setVisible(SOPPlugin.SOPVISIBLE_OFF);
                }
            }
            catch (e) { }
        }

        //레이어 Visible 상태 변경
        function SetLayerVisible(name, visibility) {
            try {
                /*
                건물 : facility_build
                교량 : facility_bridge 
                주요시설 명칭 : poi_base 
                도로 및 도로시설물 명칭 : poi_road 
                국가 및 행정구역명칭 : poi_bound 
                지번: poi_jibun 
                도로(고속, 국도등) : hybrid_road 
                국가 및 행정경계 : hybrid_bound 
                지적선 : hybrid_jijukline 
                가로등 : bill_tree 
                */

                if (SOPPlugin != null) {
                    if (name == "") name = 'hybrid_road';

                    var str = "";
                    var SOPLayerList = SOPPlugin.getLayerList();
                    var vis = SOPLayerList.getVisible(name);
                    if (visibility == true) {
                        vis = SOPPlugin.SOPVISIBLE_ON;
                    }
                    else {
                        vis = SOPPlugin.SOPVISIBLE_OFF;
                    }

                    SOPLayerList.setVisible(name, vis);
                }
            }
            catch (e) { }
        }

        //도로 주변 경관 보기 실행
        function StartGroundLandscape() {
            try {
                if (SOPPlugin == null) return;
                var analysis = SOPPlugin.getAnalysis();
                analysis.startGroundLandscape();
            }
            catch (e) { }
        }

        //건물 주변 경관 보기 실행
        function StartBuildLandscape() {
            try {
                if (SOPPlugin == null) return;
                var analysis = SOPPlugin.getAnalysis();
                analysis.startBuildLandscape();
            }
            catch (e) { }
        }

        //건물 주변 경관 보기 상태 설정
        function SetBuildLandscapeMode(mode) {
            try {
                if (SOPPlugin == null) return;
                var analysis = SOPPlugin.getAnalysis();
                analysis.setBuildLandscapeMode(mode);
            }
            catch (e) { }
        }

        //도로 주변 경관 보기 상태 설정
        function SetGroundLandscapeMode(mode) {
            try {
                if (SOPPlugin == null) return;
                var analysis = SOPPlugin.getAnalysis();
                analysis.setGroundLandscapeMode(mode);
            }
            catch (e) { }
        }

        function EventRClickDown() {
            var r = rClickDown;
            rClickDown = "";
            return r;
        }
        //C#으로 가져가기 위한 함수
        function getClickLongitude() {
            return lastClickLongitude;
        }
        //C#으로 가져가기 위한 함수
        function getClickLatitude() {
            return lastClickLatitude;
        }
        //C#으로 마우스 오른쪽 업 가져가기 위한 함수
        function getRClickUpLongitude() {
            return lastRMouseUpLongitude;
        }
        //C#으로 마우스 오른쪽 업 가져가기 위한 함수
        function getRClickUpLatitude() {
            return lastRMouseUpLatitude;
        }

        //C#으로 마우스 왼쪽 업 가져가기 위한 함수
        function getLClickUpLongitude() {
            return lastLMouseUpLongitude;
        }
        //C#으로 마우스 왼쪽 업 가져가기 위한 함수
        function getLClickUpLatitude() {
            return lastLMouseUpLatitude;
        }

        //C#으로 마우스 오른쪽 클릭시 가져가기 위한 함수
        function getRClickDownLongitude() {
            return lastRMouseDownLongitude;
        }

        //C#으로 마우스 오른쪽 클릭시 가져가기 위한 함수
        function getRClickDownLatitude() {
            return lastRMouseDownLatitude;
        }

        function getTerrHeightOfMouseClick() {
            return lastAltitude;
        }

        function failureCall(msg) {
            alert(msg);
        }

        function Resize(width, height) {
            try {
                if (SOPPlugin == null) return;
                SOPPlugin.width = width;
                SOPPlugin.height = height
            }
            catch (e) { }
        }

        function getCenter() {
            try {
                if (SOPPlugin == null) return null;

                var SOPVec3 = SOPPlugin.getViewCamera().getCenterPoint();

                return SOPVec3.latitude + "," + SOPVec3.longitude;
            }
            catch (e) { }
        }

        //위치 이동
        function MoveLonLat(lon, lat) {
            try {
                if (SOPPlugin != null)
                    SOPPlugin.getViewCamera().moveLonLat(lon, lat);
            }
            catch (e) { }
        }

        //고도 변경
        function SetAltitude(altitude) {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    SOPCamera.setAltitude(altitude); //카메라 고도 설정
                }
            }
            catch (e) { }
        }

        //고도 가져오기
        function GetAltitude() {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    return SOPCamera.getAltitude();
                }
            }
            catch (e) { }
        }
        
        //위 경도의 고도 가져오기
        function GetAltitudeByPosition(lon, lat) {
            try {
                if (SOPPlugin != null) {
                    return SOPPlugin.getView().getTerrHeight(lon, lat);
                }
            }
            catch (e) { }
        }

        //회전값 가져오기
        function GetDirect() {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    return SOPCamera.getDirect();
                }
            }
            catch (e) { }
        }

        //각도 변경
        function SetTilt(tilt) {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    SOPCamera.setTilt(tilt); //카메라 각도설정
                }
            }
            catch (e) { }
        }

        //각도 가져오기
        function GetTilt() {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    return SOPCamera.getTilt();
                }
            }
            catch (e) { }
        }

        //방향 설정
        function setDirect(direct) {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    SOPCamera.setDirect(direct); //카메라 방향(회전)설정
                }
            }
            catch (e) { }
        }

        //북쪽 바라보기
        function ViewNorth() {
            try {
                if (SOPPlugin != null) {
                    var SOPCamera = SOPPlugin.getViewCamera();
                    return SOPCamera.viewNorth();
                }
            }
            catch (e) { }
        }

        //프린트
        function Print() {
            try {
                if (SOPPlugin != null) {
                    var SOPUtil = SOPPlugin.getUtil();
                    SOPUtil.printScreen();
                }
            }
            catch (e) { }
        }

        //이미지 저장
        function SaveImage(fileName) {
            try {
                if (SOPPlugin != null) {
                    var SOPUtil = SOPPlugin.getUtil();
                    SOPUtil.saveScreenImg(fileName);
                }
            }
            catch (e) { }
        }

        function setDirectTimer(interval) {
            try {
                directValue = GetDirect();
                directTimerID = setInterval(DirectTimer, interval);
            }
            catch (e) { }
        }

        function DirectTimer() {
            try {
                if (directValue == 1) directValue = 360;
                directValue = directValue - 1;
                SetDirect(directValue);
            }
            catch (e) { }
        }

        function setDirectTimerStop() {
            clearInterval(directTimerID);
        }

        //거리측정
        function DistanceMeasure() {
            try {
                /*if (SOPPlugin != null) 
                {
                SOPPlugin.getView().setWorkMode(sop.cons.mouseState.SOPMOUSE_ANAAREA);
                }*/

                if (SOPPlugin != null && SOPPlugin.getView().getWorkMode() != 81) {
                    SOPPlugin.getView().setWorkMode(81);
                }
            }
            catch (e) { }
        }

        //면적 측정
        function AreaMeasure() {
            try {
                if (SOPPlugin != null && SOPPlugin.getView().getWorkMode() != sop.cons.mouseState.SOPMOUSE_ANAAREA) {
                    SOPPlugin.getView().setWorkMode(sop.cons.mouseState.SOPMOUSE_ANAAREA);
                }
            }
            catch (e) { }
        }

        //거리/면적측정 종료
        function StopMeasure() {
            try {
                /*if (SOPPlugin != null) 
                {
                SOPPlugin.getView().setWorkMode(sop.cons.mouseState.SOPMOUSE_MOVEGRAB);
                
                SOPPlugin.getAnalysis().clearArea();
                }*/

                if (SOPPlugin != null) {
                    SOPPlugin.getAnalysis().clearArea();
                    SOPPlugin.getAnalysis().clearDist();
                    SOPPlugin.getView().setWorkMode(1);
                }
            }
            catch (e) { }
        }