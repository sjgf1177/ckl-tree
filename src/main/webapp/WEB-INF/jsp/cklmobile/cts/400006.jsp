<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>



<div class="contentSetIn contentMap">
	<h2>지도안내</h2>

	<!-- ckl.dev.kr : b7612661d544478ef7524156c5a8a5aa -->
	<!-- Web  www.ckl.or.kr:446 : 461fd6f9b20b29e6cbd623471abe5e56 -->
	<!-- http://wtest.ckl.or.kr/ : 0499bc92acc566c1abf1f2419a7b434a -->
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/naverMap.naver?ver=2.0&amp;key=f60efa872102302b3f8599dd065636fd"></script>
	<div id = "tNavmap"></div>

	<script type="text/javascript">
	//<![CDATA[
	var oPoint = new nhn.api.map.LatLng(37.5765592, 127.0015608);
	var oPoint2 = new nhn.api.map.LatLng(37.5765592, 127.0015608);
	   nhn.api.map.setDefaultPoint('LatLng');
	   oMap = new nhn.api.map.Map('tNavmap', {
	      center : oPoint,
	      level : 13, // - 초기 줌 레벨은 10이다.
	      enableWheelZoom : true,
	      enableDragPan : true,
	      enableDblClickZoom : false,
	      mapMode : 0,
	      activateTrafficMap : false,
	      activateBicycleMap : false,
	      activateRealtyMap : true,
	      minMaxLevel : [ 1, 14 ],
	      size : new nhn.api.map.Size($("#tNavmap").width(), 240)
	   });

	   var mapZoom = new nhn.api.map.ZoomControl(); // - 줌 컨트롤 선언
	   mapZoom.setPosition({left:0, bottom:40}); // - 줌 컨트롤 위치 지정.
	   oMap.addControl(mapZoom); // - 줌 컨트롤 추가.


	   var oSize = new nhn.api.map.Size(40, 60);
	   var oOffset = new nhn.api.map.Size(20, 30);
	   var oIcon = new nhn.api.map.Icon('/ckl/images/common/pin_spot2.png', oSize, oOffset);

	   var oMarker = new nhn.api.map.Marker(oIcon, { title : '콘텐츠코리아랩' });  //마커를 생성한다
	   oMarker.setPoint(oPoint); //마커의 좌표를 oPoint 에 저장된 좌표로 지정한다

	   oMap.addOverlay(oMarker); //마커를 네이버 지도위에 표시한다

	   var oLabel = new nhn.api.map.MarkerLabel(); // 마커 라벨를 선언한다.
	   oMap.addOverlay(oLabel); // - 마커의 라벨을 지도에 추가한다.


	   oMap.attach('mouseenter', function(oCustomEvent) {
	    var oTarget = oCustomEvent.target;
	    // 마커위에 마우스 올라가면 title 오버되기
	    if (oTarget instanceof nhn.api.map.Marker) {
	     var oMarker = oTarget;
	     oLabel.setVisible(true, oMarker);
	    }
	   });

	   oMap.attach('mouseleave', function(oCustomEvent) {
	    var oTarget = oCustomEvent.target;
	    // 마커위에 마우스 벗어나면 title 아웃되기
	    if (oTarget instanceof nhn.api.map.Marker) {
	     var oMarker = oTarget;
	     oLabel.setVisible(false, oMarker);
	    }
	   });



	//]]>
	        </script>

	<div class="tMapInfoDesc">
		<h2 class="mt20">주소 및 연락처</h2>

		<ul class="bull">
			<li><strong>주소</strong> [03082] 서울시 종로구 연건동 대학로 57 홍익대 아트센터 교육동 건물 1F, 2F(사무실), 10F, 14F, 15F<br />
			</li>
			<li><strong>연락처</strong> 대표전화 : 02-2161-0000</li>
		</ul>

		<h2 class="mt20">교통수단별 오시는 길</h2>
		<h3>지하철</h3>
		<p><span class="subWay subWay1">1</span>호선 <span class="subWay1t">종로5가역</span> 하차<br />
		2번 출구 방면으로 이동 <img src="/ckl/images/sub1/arrow.gif" alt="" /> 이화사거리 방면으로 약 800m 직전 (도보 7분)</p>
		<p><span class="subWay subWay4">4</span>호선 <span class="subWay4t">혜화역</span> 하차<br />
		3번 출구 방면으로 이동  이화사거리 방면으로 약 800m 직진 (도보 7분)후 횡단보도 이용</p>


		<h3 class="mt20">버스</h3>
		<p><strong>이화사거리(01572) 하차</strong><br />
		종로 05번 마을버스(혜화역 3번출구 <img src="/ckl/images/sub1/arrow.gif" alt="" /> 홍익대 대학로 캠퍼스 운행)</p>
		<p><strong>이화장(01-223) 하차</strong><br />
		109, 273, 601, 2112, 7025</p>
		<p><strong>통신대(01-219) 하차</strong><br />
		104, 106, 107, 140, 143, 150, 160, 273, 710, 2112</p>
		<p><strong>현대그룹빌딩(01-218) 하차</strong></p>
		<p>102, 107, 108, 109, 162, 301, 7025</p>




		<h3 class="mt20">승용차</h3>
		<p><strong>성북, 노원 방면에서 오실 경우</strong><br />
		율곡로를 따라 2Km이동 <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		이화사거리에서 유턴 <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		‘율곡로’를 따라 112m 이동 <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		율곡로 13길 진입  <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		우측 홍익대 대학로 아트센터 주차장 진입</p>
		<p><strong>시청, 을지로 방면에서 오실 경우</strong><br />
		종로 5가에서 ‘이화사거리’ 방면으로 좌회전  <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		대학로를 따라 563m 이동 <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		이화사거리에서 ‘창덕궁’ 방면으로 좌회전 <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		‘율곡로’를 따라 112m 이동  <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		우측 홍익대 대학로 아트센터 주차장 진입</p>
		<p><strong>안국동 방면에서 오실 경우</strong><br />
		율곡로를 따라 2Km 이동  <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		이화사거리에서 유턴  <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		‘율곡로’를 따라 112m 이동   <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		율곡로 13길 진입   <img src="/ckl/images/sub1/arrow.gif" alt="다음" />
		우측 홍익대 대학로 아트센터 주차장 진입</p>






		<h2 class="mt50">주차안내</h2>
		<ul class="bull">
			<li>아트센터 지하 3,4층 이용 가능 / 버스 및 대형차량 주차 불가(높이제한 2.1M)</li>
			<li><strong>이용요금</strong> : 기본 30분 2,000원 / 10분 초과 시 500원 추가</li>
			<li><strong>주차할인</strong> : 이용회원에 한하여 인포메이션에서 50% 주차할인권 배부</li>
			<li><strong>주차장 운영업체</strong> : 코레일 네트웍스</li>
			<li><strong>주차관련 문의</strong> : 02)3675-6550</li>
		</ul>
	</div>
</div>
