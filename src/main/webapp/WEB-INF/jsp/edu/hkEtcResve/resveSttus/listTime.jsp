<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- <p class="timerHead">
	<span class="fcGreen" style="padding-left:5px;font-size: 10px;"><span class="reserve_dot1"></span>예약가능</span>
	<span class="fcRed" style="display: block;font-size: 10px;"><span class="reserve_dot2 ml5"></span>예약완료</span>
</p> -->
<div class="timerBox" style="font-size: 10px;">
	<div class="timerAm">
		<ul>
			<li class="<c:out value="${not empty resultTime.time0 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time0" href="#none" data-sttus="<c:out value="${resultTime.time0 }" />" data-value="0">00:00</a></li>
			<li class="<c:out value="${not empty resultTime.time1 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time1" href="#none" data-sttus="<c:out value="${resultTime.time1 }" />" data-value="1">01:00</a></li>
			<li class="<c:out value="${not empty resultTime.time2 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time2" href="#none" data-sttus="<c:out value="${resultTime.time2 }" />" data-value="2">02:00</a></li>
			<li class="<c:out value="${not empty resultTime.time3 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time3" href="#none" data-sttus="<c:out value="${resultTime.time3 }" />" data-value="3">03:00</a></li>
			<li class="<c:out value="${not empty resultTime.time4 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time4" href="#none" data-sttus="<c:out value="${resultTime.time4 }" />" data-value="4">04:00</a></li>
			<li class="<c:out value="${not empty resultTime.time5 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time5" href="#none" data-sttus="<c:out value="${resultTime.time5 }" />" data-value="5">05:00</a></li>
			<li class="<c:out value="${not empty resultTime.time6 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time6" href="#none" data-sttus="<c:out value="${resultTime.time6 }" />" data-value="6">06:00</a></li>
			<li class="<c:out value="${not empty resultTime.time7 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time7" href="#none" data-sttus="<c:out value="${resultTime.time7 }" />" data-value="7">07:00</a></li>
			<li class="<c:out value="${not empty resultTime.time8 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time8" href="#none" data-sttus="<c:out value="${resultTime.time8 }" />" data-value="8">08:00</a></li>
			<li class="<c:out value="${not empty resultTime.time9 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time9" href="#none" data-sttus="<c:out value="${resultTime.time9 }" />" data-value="9">09:00</a></li>
			<li class="<c:out value="${not empty resultTime.time10 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time10" href="#none" data-sttus="<c:out value="${resultTime.time10 }" />" data-value="10">10:00</a></li>
			<li class="<c:out value="${not empty resultTime.time11 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time11" href="#none" data-sttus="<c:out value="${resultTime.time11 }" />" data-value="11">11:00</a></li>
			<li class="<c:out value="${not empty resultTime.time12 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time12" href="#none" data-sttus="<c:out value="${resultTime.time12 }" />" data-value="12">12:00</a></li>
		</ul>
	</div>
	<div class="timerPm">
		<ul>
			<li class="<c:out value="${not empty resultTime.time13 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time13" href="#none" data-sttus="<c:out value="${resultTime.time13 }" />" data-value="13">13:00</a></li>
			<li class="<c:out value="${not empty resultTime.time14 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time14" href="#none" data-sttus="<c:out value="${resultTime.time14 }" />" data-value="14">14:00</a></li>
			<li class="<c:out value="${not empty resultTime.time15 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time15" href="#none" data-sttus="<c:out value="${resultTime.time15 }" />" data-value="15">15:00</a></li>
			<li class="<c:out value="${not empty resultTime.time16 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time16" href="#none" data-sttus="<c:out value="${resultTime.time16 }" />" data-value="16">16:00</a></li>
			<li class="<c:out value="${not empty resultTime.time17 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time17" href="#none" data-sttus="<c:out value="${resultTime.time17 }" />" data-value="17">17:00</a></li>
			<li class="<c:out value="${not empty resultTime.time18 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time18" href="#none" data-sttus="<c:out value="${resultTime.time18 }" />" data-value="18">18:00</a></li>
			<li class="<c:out value="${not empty resultTime.time19 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time19" href="#none" data-sttus="<c:out value="${resultTime.time19 }" />" data-value="19">19:00</a></li>
			<li class="<c:out value="${not empty resultTime.time20 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time20" href="#none" data-sttus="<c:out value="${resultTime.time20 }" />" data-value="20">20:00</a></li>
			<li class="<c:out value="${not empty resultTime.time21 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time21" href="#none" data-sttus="<c:out value="${resultTime.time21 }" />" data-value="21">21:00</a></li>
			<li class="<c:out value="${not empty resultTime.time22 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time22" href="#none" data-sttus="<c:out value="${resultTime.time21 }" />" data-value="22">22:00</a></li>
			<li class="<c:out value="${not empty resultTime.time23 ? 'reserve_dot2' : 'resve_ok' }" />"><a id="time23" href="#none" data-sttus="<c:out value="${resultTime.time21 }" />" data-value="23">23:00</a></li>
			<li class="resve_ok"><div><a id="AllTime" data-value="23" href="javascript:AllTimeClick();" >전체선택</a></div></li>
		</ul>
		
	</div>
</div>

