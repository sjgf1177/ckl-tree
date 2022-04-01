<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.EgovWebUtil"%>
<%
	int i;
	String strDiv;
	java.util.Calendar cal = java.util.Calendar.getInstance();
	int currentYear = cal.get ( cal.YEAR );
	strDiv = request.getParameter("div")!=null?request.getParameter("div"):"";
	strDiv = EgovWebUtil.clearXSSMaximum(strDiv);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>달력 - 날짜선택</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<link rel="stylesheet" href="/common/calendarPop/reset.css" type="text/css" />
<link rel="stylesheet" href="/common/calendarPop/calendar.css" type="text/css" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/common/calendarPop/calendar.js"></script>
<script type="text/javascript" src="/common/calendarPop/eventhandling.js"></script>
 
<script type="text/javascript"> 
//<![CDATA[
var WeekColor = "";
var TodayColor = "#f4844e";
var today = new Date();

var s_shange = false ;
$(document).ready(function(){
	$('select').bind('change' , function(){
		s_shange = true;
	})
	$('.btn_submit').bind('click' , function(){
		s_shange = false;
	})
})

function DaySelect(y,m,d){
    try{
		if (s_shange)
			{
				alert('적용을 클릭해야 해당(년월) 날짜를 선택할수 있습니다.')
				document.getElementById('btn_submit').focus();
				return false;
			}
        var objDate;
        if(parseInt(m,10) < 10){m = "0" + m };
        if(parseInt(d,10) < 10){d = "0" + d };

        objDate = opener.document.getElementById('<%=strDiv%>');
        objDate.value = y +"-"+ m +"-"+ d;
        window.close();
    } catch(e) {
        alert(e);
    }
}

function CheckYear(obj) {
    if(CheckNumber(obj.value)) {
       if(obj.value.length == 4) {
           currentDate.setFullYear(obj.value);
           drawCalendar(currentDate);
       }
    } else
	  obj.value = "";
}

function CheckNumber(CheckValue){
    var anum=/(^\d+$)|(^\d+\.\d+$)/
    if (anum.test(CheckValue))
        return true;
    else
        return false;
}

function checkDate(){
    currentDate.setFullYear(document.getElementById("curYear").value);
    currentDate.setMonth(document.getElementById("curMonth").value-1);
    drawCalendar(currentDate);
	return false;
}
//]]>
</script>
</head>
<body id="calender" >
	<div id="popup" class="calendar">
		<form action="/common/calendarPop/calendarPop.jsp" method="post" id="date-select" name="date-select" onsubmit="return  checkDate();">
		<div class="date-sell alignC">
		   <select id="curYear" name="curYear" title="년도 선택">
<% for(i = currentYear+10; i >= 1950; i--) {	%>
			<option value="<%=i%>"><%=i%></option>
<% } %>
		   </select> 년
		   <select id="curMonth" name="curMonth" title="월 선택">
			<option value="01">1</option>
			<option value="02">2</option>
			<option value="03">3</option>
			<option value="04">4</option>
			<option value="05">5</option>
			<option value="06">6</option>
			<option value="07">7</option>
			<option value="08">8</option>
			<option value="09">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
		   </select> 월
			<input type="submit" value="적용" class="btn btn_submit" />
		</div>
		</form>
		<div style="margin-top:10px;"></div>
		<div id="calForm" class="mT10" >
			<table width="230" summary="요일로 구분된 달력테이블입니다.해당날짜를 클릭하면 선택되며 이창은 닫힙니다.">
				<caption>달력</caption>
				<thead>
				<tr>
					<th scope="col">일</th>
					<th scope="col">월</th>
					<th scope="col">화</th>
					<th scope="col">수</th>
					<th scope="col">목</th>
					<th scope="col">금</th>
					<th scope="col">토</th>
				</tr>
				</thead>
				<tbody>
				<tr id="t0">
					<td id="d0" class="sun"><span id="s0"></span></td>
					<td id="d1"><span id="s1"></span></td>
					<td id="d2"><span id="s2"></span></td>
					<td id="d3"><span id="s3"></span></td>
					<td id="d4"><span id="s4"></span></td>
					<td id="d5"><span id="s5"></span></td>
					<td id="d6"><span id="s6"></span></td>
				</tr>
				<tr id="t1">
					<td id="d7" class="sun"><span id="s7"></span></td>
					<td id="d8"><span id="s8"></span></td>
					<td id="d9"><span id="s9"></span></td>
					<td id="d10"><span id="s10"></span></td>
					<td id="d11"><span id="s11"></span></td>
					<td id="d12"><span id="s12"></span></td>
					<td id="d13"><span id="s13"></span></td>
				</tr>
				<tr id="t2">
					<td id="d14" class="sun"><span id="s14"></span></td>
					<td id="d15"><span id="s15"></span></td>
					<td id="d16"><span id="s16"></span></td>
					<td id="d17"><span id="s17"></span></td>
					<td id="d18"><span id="s18"></span></td>
					<td id="d19"><span id="s19"></span></td>
					<td id="d20"><span id="s20"></span></td>
				</tr>
				<tr id="t3">
					<td id="d21" class="sun"><span id="s21"></span></td>
					<td id="d22"><span id="s22"></span></td>
					<td id="d23"><span id="s23"></span></td>
					<td id="d24"><span id="s24"></span></td>
					<td id="d25"><span id="s25"></span></td>
					<td id="d26"><span id="s26"></span></td>
					<td id="d27"><span id="s27"></span></td>
				</tr>
				<tr id="t4">
					<td id="d28" class="sun"><span id="s28"></span></td>
					<td id="d29"><span id="s29"></span></td>
					<td id="d30"><span id="s30"></span></td>
					<td id="d31"><span id="s31"></span></td>
					<td id="d32"><span id="s32"></span></td>
					<td id="d33"><span id="s33"></span></td>
					<td id="d34"><span id="s34"></span></td>
				</tr>
				<tr id="t5">
					<td id="d35"><span id="s35"></span></td>
					<td id="d36"><span id="s36"></span></td>
					<td id="d37"><span id="s37"></span></td>
					<td id="d38"><span id="s38"></span></td>
					<td id="d39"><span id="s39"></span></td>
					<td id="d40"><span id="s40"></span></td>
					<td id="d41"><span id="s41"></span></td>
				</tr>
				</tbody>
			</table>
		</div>
		<!-- <p id="close"><a href="#popup" class="close" onclick="self.close();return false;" title="창닫기">닫기</a></p> -->
	</div>
<script type="text/javascript">
drawCalendar(currentDate);
</script><noscript>현재날짜를 표시하기 위한 스크립트입니다. 이 브라우저는 자바스크립트를 지원하지 않습니다.</noscript>
</body>
</html>