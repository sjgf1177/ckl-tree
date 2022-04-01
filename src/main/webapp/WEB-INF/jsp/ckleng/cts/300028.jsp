<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<h2>Map</h2>
<div id = "tNavmap" style="height:450px"></div>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDAruEHPCh2QUYBsNshr2Tou2CF5fDS1kg&amp;region=KR&amp;language=en&amp;signed_in=true"></script>
<script>
	function initialize(xx,yy,targetId,mapName) {
	  var myLatlng = new google.maps.LatLng(xx,yy);
	  var mapOptions = {
		zoom: 18,
		center: myLatlng
	  }
	  var map = new google.maps.Map(document.getElementById(targetId), mapOptions);
	  var marker = new google.maps.Marker({
		  position: myLatlng,
		  map: map,
		  title: mapName
	  });
	}
	google.maps.event.addDomListener(window, "load", initialize(37.5765592,127.0015608,"tNavmap","Contents Korea Lab "));
</script>


  
<h2 class="mt40">How to get there  </h2>
<div class="bdView">
	<table class="table">
	<colgroup>
		<col style="width:8%" />
		<col style="width:24%" />
		<col />
	</colgroup>
	<caption>How to get there  </caption>
		<tbody>
			<tr>
				<th rowspan="2" scope="row">Subway </th>
				<td>
					<!-- <span class="subWay subWay1">1</span>호선 <span class="subWay1t">종로5가역</span> 하차 -->
					Take Subway Line <span class="subWay subWay1">1</span> and get off at '<span class="subWay1t">Jongro 5 ga</span>' station. 
				</td>
				<td>
					<!-- 2번 출구 방면으로 이동 <img src="/ckl/images/sub1/arrow.gif" alt="" /> 이화사거리 방면으로 약 800m 직전 (도보 7분) -->
					Take Subway Line 1 and get off at 'Jongro 5 ga' station. Go out of Exit 2 and go straight about 800m in 'Ehwasageori' direction (7 mins by foot) 
				</td>
			</tr>
			<tr>
				<td>
					<!-- <span class="subWay subWay4">4</span>호선 <span class="subWay4t">혜화역</span> 하차 -->
					Take Subway Line <span class="subWay subWay4">4</span> and get off at '<span class="subWay4t">Hyehwa</span>' station. 
				</td>
				<td>Go out of Exit 3 and go straight about 800m in 'Ehwasageori' direction (7 mins by foot) and cross the street.</td>
			</tr>
			<tr>
				<th rowspan="4" scope="row">Bus </th>
				<td><strong>Get off at Ehwasageori station (01572) and take a bus No.</strong></td>
				<td>
					<!-- 종로 05번 마을버스(혜화역 3번출구 <img src="/ckl/images/sub1/arrow.gif" alt="" /> 홍익대 대학로 캠퍼스 운행) -->
					Jongro 05 (Exit 3 of Hyehwa Station, the bus stops at Daehakro campus of Hongik University) 
				</td>
			</tr>
			<tr>
				<td><strong>Get off at Ehwachang station (01-223) and take a bus No. </strong></td>
				<td>109, 273, 601, 2112 or 7025. </td>
			</tr>
			<tr>
				<td><strong>Get off at Tongshindae station (01-219) and take a bus No. </strong></td>
				<td>104, 106, 107, 140, 143, 150, 160, 273, 710 or 2112. </td>
			</tr>
			<tr>
				<td><strong>Get off at Hyundai Group building station (01-218) and take a bus No. </strong></td>
				<td>102, 107, 108, 109, 162, 301 or 7025. </td>
			</tr>
			<tr>
				<th rowspan="3" scope="row">Car </th>
				<td><strong>If you come from Sungbuk or Nowon area</strong></td>
				<td>
				you can drive along the street 'Yulgokro' for 2Km,
				make a U-turn at 'Ehwasageori', 
				drive along the street ‘Yulgokro’ for 112m. 
				You can see a Hongik Univ Daehakro Artcenter parking lot on your right at 'Yulgokro 13 gil' 
				</td>
			</tr>
			<tr>
				<td><strong>If you come from City Hall or Eulgiro area</strong></td>
				<td>you can make a left turn at 'Jongro 5 ga' in 'Ehwasageori' direction and drive along the street 'Daehakro' for 563m, make a left turn again at 'Ehwasageori' in 'Changdeok Palace' direction, drive along the street ‘yulgokro’ for 112m. You can see a Hongik Univ Daehakro Artcenter parking lot on your right.</td>
			</tr>
			<tr>
				<td><strong>If you come from Angukdong area</strong></td>
				<td>you can drive along the street 'Yulgokro' for 2Km, make a U-turn at 'Ehwasageori', drive along street ‘Yulgokro’ for 112m. You can see a Hongik Univ Daehakro Artcenter parking lot on your right at 'Yulgokro 13 gil'.  </td>
			</tr>
		</tbody>
	</table>
</div>


<h2>Parking </h2>
<ul class="bull">
	<li>Third and Fourth basement floor are available for parking/ bus and large vehicles are not eligible for parking (height limit : 2.1M)</li>
	<li><strong>Fee</strong> : 2,000 KRW per initial 30 mins / 500 KRW charged when exceeding every 10 mins</li>
	<li><strong>Discount </strong> : Members can receive 50% discount ticket at information center</li>
	<li><strong>Parking lot management by </strong>KORAIL Networks</li>
	<li><strong>If you have any inquiries on parking, please call us at </strong> 02)3675-6550</li>
</ul>
