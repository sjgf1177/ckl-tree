<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>달력 &lt; KOCCA</title>

<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="/edu/css/bootstrap.reset.css"/>
<link rel="stylesheet" type="text/css" href="/edu/css/sub.css"/>

<style type="text/css">
body {background:#fff; margin:0; padding:5px;}
img {border:0; vertical-align:middle;}
a {text-decoration:none;}
/* 뚜껑~ */
div#calendar {width:340px; margin:10px auto 0 auto;}

/* << 월/일 >>  선택 셀렉트 박스 부분 */
div#popTable {width:100%; zoom:1; text-align:center; padding-bottom:5px;}
div#popTable img {position:relative; top:1px; vertical-align:top; cursor:pointer;}
div#popTable img.preMonth {margin-right:5px;} /* << 이미지 */
div#popTable select {vertical-align:top;font-size:14px;}
div#popTable select.slt_year {width:80px; margin-right:5px;} /* 년도 셀렉트박스 */
div#popTable select.slt_month {width:60px; margin-right:5px;} /* 월도 셀렉트박스 */
div#popTable img.nextMonth {} /* >> 이미지 */

/* 날짜테이터 테이블 */
table {border-collapse:collapse; margin:0 auto;}
table caption, .thidden{position:absolute;z-index:1;width:0;height:0;font-size:1px;overflow:hidden;text-inent:100%;white-space:nowrap}
table {width:98%; border:none;}
table thead th {padding:3px; text-align: center;font-size:14px; border-right:1px solid #fff; border-bottom:1px solid #fff; color:#fff; background:#595757;} /* 월화...금토일 (요일표시) */
table thead th.sat {background-color:#2484c6;} /* 토요일제목 */
table thead th.sun {background-color:#eb1c24;} /* 일요일제목 */
table tbody td {height:24px; padding:1px !important; border-right:1px solid #fff; border-bottom:1px solid #595757; color:#fff; text-align:center; font-size: 14px}
table td.sat,
table td.sat a {color:#00F !important;} /* 토요일표시 */
table td.sat a:hover {color:#fff !important;}
table td.sun, table td.sun a {color:#F00 !important;} /* 일요일표시 */
table td.sun a:hover {color:#fff !important;}
table td a:link,
table td a:visited {display:block; padding:0px; padding-top:3px; line-height:24px; text-decoration:none; color:#124388;}
table td a:hover {color:#fff; background:#124388;}
table td a:active {display:block; padding:0px; padding-top:3px; line-height:24px; text-decoration:none; color:#124388;}
table td.empty {padding:0; height:30px; color:#e7f5ff !important;} /* 달력에서 숫자들 안나오는 칸에 _ 를 색깔줘야함 배경과 같은색!!! */
.currentDay, .currentDay a{background:#000;color:#fff !important;font-weight:bold}

/* 오늘날짜 입력하기 */
.todays{background:#f00;}
.today_txt {overflow:hidden; padding:5px 0 0 3px;}
.today_txt .intoDay{background:url(/images/common/cal_todayAon.gif) no-repeat;width: 145px;height: 35px;line-height: 30px}
.today_txt .intoDay:hover, .intoDay .btn:focus, .intoDay .btn:active{background:url(/images/common/cal_todayAoff.gif) no-repeat;}
a.closeCal{display: inline-block;position: absolute;right: 0;bottom: 0;width: 50px;height: 40px;background: url(/images/common/calCloser.gif) no-repeat 100% 100%;
font-size:0;line-height:0;overflow:hidden; text-indent:100%; white-space: nowrap;border:none;}
a.closeCal, a.closeCal:hover, a.closeCal:active, a.closeCal:focus {float:right; color:#fff; background-color: transparent;}/* 닫기 */
</style>

<script type="text/javascript">
var windowName = this.name;

var target_input = windowName.split('-');

// 값 넘겨 봅시다
function insertData(year, month, date){
	if(month < 10){ month = "0"+month }; // 2008-10-01처럼 01의 반환을 위해서 한자리는 0를 붙임
	if(date < 10){ date = "0"+date };
	var target = parent.document;
	target.getElementById(target_input[0])["value"] = year+"-"+month+"-"+date;
	target.getElementById(target_input[0]+"-lry").style.display = "none";
	target.getElementById(target_input[0]).focus();
}

function createCalendar(year, month, date, focusN){
	var calendar_target = document.getElementById("calendar");

	if(calendar_target.hasChildNodes()){ // calendar 안에 내용이 있으면 초기화
		calendar_target.innerHTML = "";
	}

	var ld = new Array();
	ld[1] = 31;
	ld[2] = (year % 4 == 0)?29:28; // 4년에 한번 4의배수가 되는 년도의 2월 말일인 28일이다.
	ld[3] = 31;
	ld[4] = 30;
	ld[5] = 31;
	ld[6] = 30;
	ld[7] = 31;
	ld[8] = 31;
	ld[9] = 30;
	ld[10] = 31;
	ld[11] = 30;
	ld[12] = 31;

	var first_day = new Date(year, month-1, 1);
	var x = (first_day.getDay());
	// 해당달의 1일 이전 공백갯수를 계산을 위해서 1일의 요일을 검사함
	// 일(0), 월(1), 화(2), 수(3), 목(4), 금(5), 토(6)
	// 반환하는 값이 이렇게 때문에 해당숫자만큼 담에 공백이 생김

	var lastday_num = ld[month];
	// 이로써 기본적으로 달력에 필요한 두가지를 모두 구했음~
	// first_day - 해당달의 1일에 앞에 공백
	// lastday_num - 해당달의 마지막 일자

	var today = new Date();
	var today_year = today.getYear(); if(today_year < 2000) {today_year += 1900;}
	var today_month = today.getMonth();
	var today_date = today.getDate();


	var root = document.createElement("div"); //var root = document.createElement("calendar_content"); 수정
	calendar_target.appendChild(root);

	// div 이것은....     << [2008] [11] >>        부분입니다.
	var calendar_select = document.createElement("div");
	calendar_select.setAttribute("id", "popTable");
	root.appendChild(calendar_select);

	// << 이미지
	var preMonth = document.createElement("img");
	preMonth.setAttribute("src", "/images/common/cal_left.gif");
	preMonth.setAttribute("alt", "이전 달 선택");
	preMonth.className = "preMonth";

	var preMonthA = document.createElement("a");
	preMonthA.setAttribute("href", "javascript:void(0);");
	preMonthA.appendChild(preMonth);
	calendar_select.appendChild(preMonthA);

	preMonthA.onclick = function(){
		if(sltBx2.value == "1") createCalendar(parseInt(year)-1, 12, date, 2);
		else createCalendar(year, parseInt(sltBx2.value)-1, date, 2);
	}

	// 년도 셀렉트 박스
	var sltBx1 = document.createElement("select");
	sltBx1.setAttribute("id", "select_year");
	sltBx1.setAttribute("title", "년도 선택");
	sltBx1.className = "slt_year";
	calendar_select.appendChild(sltBx1);

	var sltBx1_temp = new Array();

	//for(var i=parseInt(year, 10)-50; i<=parseInt(year, 10)+50; i++){
	for(var i=1900; i<=2000+50; i++){
		sltBx1_temp[i] = document.createElement("option");
		sltBx1_temp[i].setAttribute("value", i);
		sltBx1_temp[i].appendChild(document.createTextNode(i));
		sltBx1.appendChild(sltBx1_temp[i]);
		if(i == year) sltBx1_temp[i].selected = 1;
	}
	sltBx1.onchange = function(){
		createCalendar(sltBx1.value, sltBx2.value, date, 0);
	}

	// 월도 셀렉트 박스
	var sltBx2 = document.createElement("select");
	sltBx2.setAttribute("id", "select_month");
	sltBx2.setAttribute("title", "월 선택");
	sltBx2.className = "slt_month";
	calendar_select.appendChild(sltBx2);
	var sltBx2_temp = new Array();

	for(var i=1; i<=12; i++){
		sltBx2_temp[i] = document.createElement("option");
		sltBx2_temp[i].setAttribute("value", i);
		sltBx2_temp[i].appendChild(document.createTextNode(i));
		sltBx2.appendChild(sltBx2_temp[i]);

		if(i == month){
			sltBx2_temp[i].selected = 1;
		}

	}
	sltBx2.onchange = function(){
		createCalendar(sltBx1.value, sltBx2.value, date, 1);
	}

	// >> 이미지
	var nextMonth = document.createElement("img");
	nextMonth.setAttribute("src", "/images/common/cal_right.gif");
	nextMonth.setAttribute("alt", "다음 달 선택");
	nextMonth.className = "nextMonth";

	var nextMonthA = document.createElement("a");
	nextMonthA.setAttribute("href", "javascript:void(0);");
	nextMonthA.appendChild(nextMonth);
	calendar_select.appendChild(nextMonthA);

	nextMonthA.onclick = function(){
		if(sltBx2.value == "12") createCalendar(parseInt(year)+1, 1, date, 3);
		else createCalendar(year, parseInt(sltBx2.value)+1, date, 3);
	}

	// 테이블 생성
	var dom_table = document.createElement("table");
	root.appendChild(dom_table);
	dom_table.setAttribute("id", "calendar_table1");
	dom_table.setAttribute("className", "calendar_table1");
	dom_table.setAttribute("summary", "일, 월, 화, 수, 목, 금, 토로 구분되는 달력");
	var dom_caption = document.createElement("caption");
	dom_caption.appendChild(document.createTextNode(year+"년 "+month+"월 달력"));
	dom_table.appendChild(dom_caption);

	// 테이블 th
	var th_title = new Array();
	th_title[0] = "일";
	th_title[1] = "월";
	th_title[2] = "화";
	th_title[3] = "수";
	th_title[4] = "목";
	th_title[5] = "금";
	th_title[6] = "토";

	var dom_thead = document.createElement("thead");
	var dom_tr = document.createElement("tr");
	dom_table.appendChild(dom_thead);
	dom_thead.appendChild(dom_tr);

	for(var i=0; i<7; i++){
		var dom_th = document.createElement("th");
		dom_th.setAttribute("scope", "col");
		dom_th.appendChild(document.createTextNode(th_title[i]));
		if(i==6) dom_th.className = "sat";
		if(i==0) dom_th.className = "sun";
		dom_tr.appendChild(dom_th);
	}

	// 전월 공백
	var dom_tbody = document.createElement("tbody");
	var dom_tr = document.createElement("tr");
	dom_table.appendChild(dom_tbody);
	dom_tbody.appendChild(dom_tr);

	var x_day = x;

	for(var i = 0; i < x_day; i++){
		var dom_td = document.createElement("td");
		if((i+(x_day-1))%7 == 0) dom_td.className = "sun";
		else if((i+(x_day-1))%7 == 6) dom_td.className = "sat";
		dom_td.appendChild(document.createTextNode(" "));
		dom_tr.appendChild(dom_td);
	}

	for(var i=1; i<=lastday_num; i++){
		if((i+x-1)%7 == 0){
			var dom_tr = document.createElement("tr");
			dom_tbody.appendChild(dom_tr);
		}

		var dom_td = document.createElement("td");
		if((i+x-1)%7 == 0) dom_td.className = "sun";
		else if((i+x-1)%7 == 6) dom_td.className = "sat";

		//오 날짜 추가
		if(today_year == year && today_month+1 == month && i == date) {
			var currentTxts = document.createElement("span");
			currentTxts.setAttribute("class", "thidden");
			currentTxts.textContent = "오늘날짜 : ";
			dom_td.className = "currentDay";
			dom_td.appendChild(currentTxts);
		}


		var dom_a = document.createElement("a");
		var num = document.createTextNode(i);

		dom_a.setAttribute("href", "javascript:void(0);");
		dom_a.setAttribute("title", i);
		dom_a.onclick = function(){
			insertData(sltBx1.value, sltBx2.value, this.title);
			return false;
		}

		dom_tr.appendChild(dom_td);
		dom_td.appendChild(dom_a);
		dom_a.appendChild(num);
	}

	for(var i=0; i<(42-x-lastday_num); i++){
		if((i+x+lastday_num)%7 == 0){
			var dom_tr = document.createElement("tr");
			dom_tbody.appendChild(dom_tr);
		}

		var dom_td = document.createElement("td");
		if((i+x+lastday_num)%7 == 0) dom_td.className = "empty sun";
		else if((i+x+lastday_num)%7 == 6) dom_td.className = "empty sat";
		else dom_td.className = "empty";

		dom_tr.appendChild(dom_td);
		dom_td.appendChild(document.createTextNode("_"));
	}

	// 선택된 포커스 이동
	if(focusN==0) sltBx1.focus();
	if(focusN==1) sltBx2.focus();
	if(focusN==2) preMonthA.focus();
	if(focusN==3) nextMonthA.focus();

	// 오늘날짜 입력하기
	var today_txt = document.createElement("DIV");
	calendar_target.appendChild(today_txt);
	today_txt.className = "today_txt";

	var today_a = document.createElement("A");
	today_a.setAttribute("href", "javascript:void(0);");
	today_a.appendChild(document.createTextNode("오늘날짜 입력"));
	today_a.className = "btn btn-sm intoDay";
	today_txt.appendChild(today_a);

	today_a.onclick = function(){
		insertData(today_year, today_month+1, today_date);
	}

	var closeCal_a = document.createElement("A");
	closeCal_a.setAttribute("href", "javascript:void(0);");
	today_txt.appendChild(closeCal_a);
	closeCal_a.appendChild(document.createTextNode("[닫기]"));
	closeCal_a.className = "closeCal";

	closeCal_a.onclick = function(){
		parent.document.getElementById(target_input[0]+"-lry").style.display = "none";
		parent.document.getElementById(target_input[0]+"-lry").previousElementSibling.focus(); //previousElementSibling
	}
}

window.onload = function(){
	var today = new Date();
	var today_year = today.getYear(); if(today_year < 2000) {today_year += 1900;}
	var today_month = today.getMonth();
	var today_date = today.getDate();

	createCalendar(today_year, today_month+1, today_date); // today.getMonth();는 해당다보다 1이 작은 값을 반환하기 때문에 +1해서 해당당을 넘김
}
</script>

</head>
<body>
<div id="calendar"></div>
</body>
</html>