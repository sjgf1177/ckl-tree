<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">-->
 <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> 
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/common.css"> -->
<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.child4 li{
	width: 22%;
}
.noLink li.on{
	border: 1px solid #40abd4;
	border-bottom-color: transparent;
	color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
	text-decoration: unset;
}
.noLink li{
	border-bottom-color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
}
.sr-only{
	display: none!important;
}
.reservSet h4{
	font-size: 1.45rem;
}
.reserv_ltbx>li li a{
	font-size: 11px;
}
.reserv_ltbx2>li a{
	font-size: 11px;
}


.timerHTxt{
	font-size: 10px;
}
@media (min-width: 800px) {
	.tabs{
		min-width: 750px;
	}
	.reservSet{
		width: 825px;
	}
	.reservSet>ul>li.stp03.on{
		width: 320px;
	}
	.reservSet>ul>li.stp03,.reservSet>ul>li.stp03.off{
		width: 320px;
	}
	.stp01,.stp01.off,.stp01.on{
		width: 130px!important;
	}
	.stp02,.stp02.off,.stp02.on{
		width: 130px!important;
	}
	.stp05,.stp05.off{
		width: 240px!important;
	}
	.stp05.on{
		width: 240px!important;
	}
	.stp04,.stp04.off{
		width: 220px!important;
	}
}

@media (max-width: 800px) {
.tabs{
		min-width: none;
}
 .tabs ol li{
 	display: none;
 }
 .tabs ol li.on{
 	display:block;
 	width: 100%;
 }
 .reservSet{
 	width: 100%;
 }
 .reservSet>ul>li.on{
 	width: 100%;
 }
 .reservSet>ul>li{
 	width: 100%;
 }
 .reservSet>ul>li.stp03{
 	width: 100%;
 }
 .reservSet>ul>li.stp03.on{
	width: 100%;
 }
 .reservSet>ul>li.stp04{
 	height: 200px;
 }
 .icoBacks{
 	margin-top: 25px;
 }
}

.btn.btn-default.btnSm{
	padding: 3px 5px;
	border-radius : 3px;
}

#relation_site{
background-image:url('/edu/new_image/relation_site_arrow.png')!important;
background-repeat:no-repeat!important;
border:none!important;
border-bottom:2px solid white!important;
background-position:right 7px!important;
background-size:8px!important;
line-height:2.0rem!important;
}

.scrollY{
	font-size: 1.6rem;
}
</style>

<script type="text/javascript">
//<![CDATA[
var codeIdVal = "<c:out value="${ codeId0 }" />";
var areaSeVal = "<c:out value="${empty result ? paramVO.areaSe : result.areaSe }" />" == "" ? "01" : "<c:out value="${ empty result ? paramVO.areaSe : result.areaSe }" />";
var lcSeVal = "<c:out value="${empty result ? paramVO.lcSe : result.lcSe }" />";
var fcltySeVal = "<c:out value="${empty result ? paramVO.fcltySe : result.fcltySe }" />";
var spceNmVal = "<c:out value="${empty result ? paramVO.spceNm : result.spceNm }" />";
var fcltySnVal = "<c:out value="${empty result ? paramVO.fcltySn : result.fcltySn }" />";
var resveDtVal = "<c:out value="${result.resveDt }" />";
var resveBeginTimeVal = "<c:out value="${result.resveBeginTime }" />";
var resveEndTimeVal = "<c:out value="${result.resveEndTime }" />";
var eqpnmUseYnVal = "<c:out value="${result.eqpnmUseYn }" />";
var todayYY = "<c:out value="${todayYY}" />";
var todayMM = "<c:out value="${todayMM}" />";
var locationTp = "<c:out value="${param.locationTp}" />";

$(function() {
		
	fnLoadCanlendar($("#calendarDiv"));

	if (locationTp == "prev" || locationTp == "curr") {
		$(".reservSysSet").fadeIn("slow");
	}

	$("#agreeBtn").click(function() {
		$("#greeField").hide();
		$(".reservSysSet").fadeIn("slow");
		/* if (fcltySeVal == "010402") {
			alert("3D 프린터 예약 시 하루 전체를 예약해주시기 바랍니다.\n레이저커터는 어느 시간대를 예약해도 17:00 이후에만 사용가능합니다.");
		} */
		return false;
	});

	$("#cancelResveBtn").click(function() {
		$(".reservSysSet").fadeOut("slow");
		$("#greeField").show();
		return false;
	});

	$("#resetBtn").click(function() {

		lcSeVal = "";
		fcltySeVal = "";
		spceNmVal = "";
		fcltySnVal = "";
		resveDtVal = "";
		resveBeginTimeVal = "";
		resveEndTimeVal = "";
		eqpnmUseYnVal = "N";
		//fnResetStep(2);
		//fnAreaSeList($("#areaSeDiv"), codeIdVal,0,'01');
		fnLoadCanlendar($("#calendarDiv"));
		return false;
	});

	$("#prevBtn").click(function() {
		window.location.href = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/step1.do?menuNo=<c:out value="${param.menuNo}" />";
		return false;
	});

	fnAreaSeList($("#areaSeDiv"), codeIdVal,0,areaSeVal);  //COM059

	//지역 정보 클릭 event
	$("#areaSeDiv").delegate("a","click",function() {
		fnResetStep(2);
		$("#areaSeDiv").find("a").removeClass("on");
		$(this).addClass("on");

		fnLcSeList($("#lcSeDiv"), codeIdVal, $(this).attr("data-value"), 2);
		return false;
	});

	//지역 정보2 클릭 event
	$("#lcSeDiv").delegate(".fcltySeDiv a","click",function() {
		/* if ($(this).attr("data-value") == "010402") {
			alert("3D 프린터 예약 시 하루 전체를 예약해주시기 바랍니다.\n레이저커터는 어느 시간대를 예약해도 17:00 이후에만 사용가능합니다.");
		} */
		fnResetStep(3);
		$(".fcltySeDiv").find("a").removeClass("on");
		$(this).addClass("on");
		//$(".stp01").removeClass("on").addClass("off");
		//$(".stp02").addClass("on");
		//$("#spceNmBlock").hide();
		var areaSe = $("#areaSeDiv").find("a").filter(".on").attr("data-value");
		var lcSe = $(".fcltySeDiv").find("a").filter(".on").closest("ul").parent().children("a").attr("data-value");
		var fcltySe = $(".fcltySeDiv").find("a").filter(".on").attr("data-value");
		fnSpceNmList($("#spceNmDiv"), areaSe, lcSe, fcltySe);
		return false;
	});
	//공간정보 클릭 event
	$("#spceNmDiv").delegate(".spceSelctBtn","click",function() {
		fnResetStep(4);
		var fcltySn = $(this).attr("data-value");
		$("#spceNmDiv").find(".spceSelctBtn").removeClass("on");
		$(this).addClass("on");
		//$(".stp02").removeClass("on").addClass("off");
		//$(".stp03").addClass("on");
		//$("#calendarBlock").hide();
		fnLoadCanlendar($("#calendarDiv"));

		return false;
	});

	//공간보기 event
	$("#spceNmDiv").delegate(".spceViewBtn","click",function() {
		var params = {viewType : "CONTBODY", fcltySn : $(this).attr("data-value")};
	  	$("#spceViewPopupCont").load("/bos/hkEtcResve/fclty/view.do", params, function() {
	  		spceViewPopup.dialog("open");
	  		$(this).find(".btnSet").hide();
	  	});
		return false;
	});


	//달력 이전 달 가기 event
	$(".headStep3").find(".prevMonth").click(function() {
		fnResetStep(4);
		//$(".stp03").addClass("on");
		var yearMonth = $(this).attr("data-value");
		var date = yearMonth.split("-");
		if (Number(todayYY+todayMM) > Number(yearMonth.replace("-",""))) {
			alert("지난 달은 조회 할 수 없습니다.");
			return false;
		}
		var fcltySn = $("#spceNmDiv").find(".spceSelctBtn").filter(".on").attr("data-value");
		var year = Number(date[0]);
		var month = Number(date[1]);


		fnLoadCanlendar($("#calendarDiv"), year, month, "");

		return false;
	});

	//달력 다음 달 가기 event
	$(".headStep3").find(".nextMonth").click(function() {
		fnResetStep(4);
		//$(".stp03").addClass("on");
		var yearMonth = $(this).attr("data-value");
		var date = yearMonth.split("-");
		var fcltySn = $("#spceNmDiv").find(".spceSelctBtn").filter(".on").attr("data-value");
		var year = Number(date[0]);
		var month = Number(date[1]);
		var chkSum = $("#chkSum").val();
		fnLoadCanlendar($("#calendarDiv"), year, month, "", chkSum);

		return false;
	});


	//달력 이후일짜 클릭시 event
	$("#calendarDiv").delegate(".cal_none a","click",function() {
		alert("예약 할 수 없는 일자 입니다.");
		return false;
	});

	//달력 공백 클릭시 event
	$("#calendarDiv").delegate(".cal_blank a","click",function() {
		return false;
	});

	//달력 예약불가 클릭시 event
	$("#calendarDiv").delegate(".cal_reserv_end a","click",function() {
		alert("예약 할 수 없는 일자 입니다.");
		return false;
	});

	//달력 대기예약 클릭시 event
	$("#calendarDiv").delegate(".cal_reserv_ing a","click",function() {
		fnResetStep(5);
		
		var bday = $("#calendarDiv").find("td a.on").attr("data-value");
		$("#calendarDiv").find("td a.on").attr("title", bday + "일" + " 대기예약");
		$("#calendarDiv").find("td a.on").removeClass("on");
		
		$(this).addClass("on");
		//$(".stp03").removeClass("on").addClass("off");
		//$(".stp04").addClass("on");
		//$("#timeBlock").hide();
		
		if($(this).hasClass("on")){
			var day = $(this).attr("data-value");
			$(this).attr("title", day + "일 선택됨");
		}
		resveBeginTimeVal = "";
		resveEndTimeVal = "";
		fnLoadTimes($("#timeDiv"), day,  "resve_wait");

		return false;
	});

	//달력 예약 클릭시 event
	$("#calendarDiv").delegate(".cal_reserv_ok a","click",function() {
		fnResetStep(5);
		
		var bday = $("#calendarDiv").find("td a.on").attr("data-value");
		$("#calendarDiv").find("td a.on").attr("title", bday + "일" + " 예약가능");
		$("#calendarDiv").find("td a.on").removeClass("on");
		
		$(this).addClass("on");
		//$(".stp03").removeClass("on").addClass("off");
		//$(".stp04").addClass("on");
		//$("#timeBlock").hide();
		var day = $(this).attr("data-value");
		$(this).attr("title", day + "일 선택됨");
		fnLoadTimes($("#timeDiv"), day,  "resve_ok");

		return false;
	});


	//시간 선택 클릭시 event
	$("#timeDiv").delegate(".timerBox li>a","click",function() {

		var timeNum = Number($(this).attr("data-value"));
		var preNum = timeNum-1;
		var nextNum = timeNum+1;

		if ($(this).closest("li").hasClass("reserve_dot2") && $(".timerBox li").find("a.on").closest("li").filter(".resve_ok").size() > 0) {
			//예약완료,승인,대기 상태를 포함하면 대기예약으로 예약할수있음
			alert("예약된 시간을 포함합니다. 다시 선택해 주시기 바랍니다.");
			return false;
		}

		else if ($(this).closest("li").hasClass("resve_ok") &&  $(".timerBox li").find("a.on").closest("li").filter(".reserve_dot2").size() > 0) {
			//예약완료,승인,대기 상태를 포함하면 대기예약으로 예약할수있음
			alert("예약된 시간을 포함합니다. 다시 선택해 주시기 바랍니다.");
			return false;
		}

		if (!$(this).hasClass("on")) {
			if ($(".timerBox li").find("a.on").size() > 0 && timeNum > 9 && timeNum < 21 && !$("#time"+(timeNum-1)).hasClass("on")  && !$("#time"+(timeNum+1)).hasClass("on")) {
				alert("연속되지 않은 시간을 선택할 수 없습니다.");
				return false;
			}
			else if ($(".timerBox li").find("a.on").size() > 0 && timeNum == 9 && !$("#time"+(timeNum+1)).hasClass("on")) {
				alert("연속되지 않은 시간을 선택할 수 없습니다.");
				return false;
			}
			else if ($(".timerBox li").find("a.on").size() > 0 && timeNum == 21 && !$("#time"+(timeNum-1)).hasClass("on")) {
				alert("연속되지 않은 시간을 선택할 수 없습니다.");
				return false;
			}

			$(this).addClass("on");
			$(this).attr("title", $(this).attr("data-value") + "시 선택됨");
		}
		else {

			if ($(".timerBox li").find("a.on").size() > 0 && timeNum > 9 && timeNum < 21 && $("#time"+(timeNum-1)).hasClass("on")  && $("#time"+(timeNum+1)).hasClass("on")) {
				alert("선택취소가 불가능한 시간대 입니다.");
				return false;
			}
			else if ($(".timerBox li").find("a.on").size() > 1 && timeNum == 9 && !$("#time"+(timeNum+1)).hasClass("on")) {
				alert($("#time"+(timeNum+1)).hasClass("on"));
				alert("선택취소가 불가능한 시간대 입니다.");
				return false;
			}
			else if ($(".timerBox li").find("a.on").size() > 1 && timeNum == 21 && !$("#time"+(timeNum-1)).hasClass("on")) {
				alert("선택취소가 불가능한 시간대 입니다.");
				return false;
			}
			$(this).removeClass("on");
			$(this).removeAttr("title");
		}

		$("#resveBtnDiv").hide();
		fnResetStep(6);
		$(".stp04").addClass("on");
		
		if ($(".timerBox li").find("a.on").size() ==  0) {
			alert("예약시간을 선택해 주세요.");
			return false;
		}

		fnLoadEqpmnList($("#eqpmnDiv"));


		return false;
	});

	//시간 선택 장비조회 클릭시 event
	/* $("#eqpmnSrchBtn").click(function() {


		if ($(".timerBox li").find("a.on").size() ==  0) {
			alert("예약시간을 선택해 주세요.");
			return false;
		}

		fnLoadEqpmnList($("#eqpmnDiv"));

		return false;
	}); */


	// 장비이용안함 event
	$("#eqpmnDiv").delegate("#noEqpnm", "click", function() {
		/* if ($(this).filter(":checked").val() == 'N') $("#eqpmnList").hide();
		else  $("#eqpmnList").fadeIn("slow"); */
	});


	$("#eqpmnDiv").delegate("input[name=eqpmnSn]", "click", function() {
		
		 if (typeof $(this).filter(":checked").val() != 'undefined') {
			var qtyNum = Number($(this).closest("div").find("input[name=inputEqpmnQy]").val());
			var remndrQy = Number($(this).closest("li").find(".remndrQy").text());

			if (remndrQy == 0) {
				return false;
			}

			$(this).closest("li").find(".qtyNum").text(1);
			$(this).closest("li").find("input[name=inputEqpmnQy]").val(1);
		}
		else {
			$(this).closest("li").find(".qtyNum").text(0);
			$(this).closest("li").find("input[name=inputEqpmnQy]").val(0);
		} 
	});



	// 장비수량 up event
	$("#eqpmnDiv").delegate(".plusBtn","click",function() {

		if ($(this).closest("li").find("input[name=eqpmnSn]:checked").size() == 0) {
			alert("해당장비를 선택해 주세요.");
			var obj = $(this).closest("li").find("input[name=eqpmnSn]");
			obj.focus();
			return false;
		}

		var qtyNum = Number($(this).closest("div").find("input[name=inputEqpmnQy]").val());
		var remndrQy = Number($(this).closest("li").find(".remndrQy").text());

		if (qtyNum == remndrQy) return false;
		$(this).closest("div").find(".qtyNum").text(qtyNum+1);
		$(this).closest("div").find("input[name=inputEqpmnQy]").val(qtyNum+1);
		return false;
	});

	// 장비수량 down event
	$("#eqpmnDiv").delegate(".minusBtn","click",function() {

		if ($(this).closest("li").find("input[name=eqpmnSn]:checked").size() == 0) {
			alert("해당장비를 선택해 주세요.");
			var obj = $(this).closest("li").find("input[name=eqpmnSn]");
			obj.focus();
			return false;
		}

		var qtyNum = Number($(this).closest("div").find("input[name=inputEqpmnQy]").val());

		if (qtyNum == 1) return false;
		$(this).closest("div").find(".qtyNum").text(qtyNum-1);
		$(this).closest("div").find("input[name=inputEqpmnQy]").val(qtyNum-1);
		return false;
	});


	// 예약하기 버튼 event
	$("#resveBtn").click(function() {
		fnResveSave("ok");
		return false;
	});

	// 대기예약하기 버튼 event
	$("#waitBtn").click(function() {
		fnResveSave("wait");
		return false;
	});
});

//전체시간선택
function AllTimeClick(){
	if(!$("#AllTime").hasClass("on")){
		$(".timerBox li>a").each(function(i,e){
			if(!$(this).hasClass("on")) {
				$(this).addClass("on");
				$(this).attr("title", $(this).attr("data-value") + "시 선택됨");
			}
		});
		$("#AllTime").addClass("on")
		fnLoadEqpmnList($("#eqpmnDiv"));
	}else{
		$(".timerBox li>a").each(function(i,e){
			if($(this).hasClass("on")) {
				$(this).removeClass("on");
				$(this).removeAttr("title");
			}
		});
		$("#AllTime").removeClass("on")
	}


}


// step reset 처리
function fnResetStep(stepNum) {
	if (stepNum == 2) {
		$("#spceNmBlock").fadeIn("slow");
		$(".stp01").removeClass("off").removeClass("on");
		fnResetStep(3);
	}
	else if (stepNum == 3) {
		$("#calendarBlock").fadeIn("slow");
		$(".stp02").removeClass("off").removeClass("on");
		fnResetStep(4);
	}
	else if (stepNum == 4) {
		$("#timeBlock").fadeIn("slow");
		$(".stp03").removeClass("off").removeClass("on");
		fnResetStep(5);
	}
	else if (stepNum == 5) {
		//$("#eqpmnDiv").text("◀ STEP 4 예약시간을 선택하여 주세요.");
		$("#eqpmnBlock").fadeIn("slow");
		$(".stp04").removeClass("off").removeClass("on");
		$("#resveBtnDiv").hide();
		fnResetStep(6);
	}
	else if (stepNum == 6) {

		$(".stp05").removeClass("off").removeClass("on");
	}
}

function fnAreaSeList(obj, codeId, upperCode, code) {

	var $obj = obj;
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};

	$obj.empty();

	$.get(url, params, function(data) {
		if (data) {
			$.each(data.list, function(key,item) {
				//<a data-value="01" href="#self"><span class="icoSm icoCir"></span>대학로</a>
				var $codeItem = $("<a>").attr({'data-value' : item.code, 'href': '#self'});
				var $span = $("<span>").attr("class","icoSm icoCir");
				$span.appendTo($codeItem);
				$codeItem.append(item.codeNm);
				if (item.code == code) {
					$codeItem.addClass("on");
					$(".stp01").addClass("on");
					$("#lcSeBlock").hide();

					fnLcSeList($("#lcSeDiv"), codeIdVal, areaSeVal, 2);
				}
				$codeItem.appendTo($obj);
			});
		}
	},"json");
}


function fnLcSeList(obj, codeId, upperCode, depth) {

	$(".stp01").addClass("on");
	$("#lcSeBlock").hide();

	var $obj = obj;
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};

	$obj.empty();

	$.get(url, params, function(data) {
		if (data) {

			if (depth == 3 && data.list.length == 0) {
				var $li = $("<li>").attr("class","noData fs11").text("※ 예약 가능한 공간이 없습니다.");
				$obj.closest("li").after($li);
			}

			var $subUl = "";
			$.each(data.list, function(key,item) {
				var $codeItem = $("<a>").attr({'data-value' : item.code, 'href': '#self'}).text(item.codeNm);
				if (depth == 3 && item.code == fcltySeVal) {
					$codeItem.addClass("on");
				}
				var $li = $("<li>");
				$codeItem.appendTo($li);
				if (depth == 2) {
					$subUl = $("<ul>").attr({"class": "fcltySeDiv"});
					$subUl.appendTo($li);
				}
				$li.appendTo($obj);

				var areaSe = $("#areaSeDiv").find("a.on").attr("data-value");
				var lcSe = $(".fcltySeDiv").find("a.on").closest("ul").parent().children("a").attr("data-value");
				var fcltySe = $(".fcltySeDiv").find("a.on").attr("data-value");

				if (depth == 2) fnLcSeList($subUl, codeId, item.code, 3);
				if (depth == 3 && item.code == fcltySeVal) fnSpceNmList($("#spceNmDiv"), areaSe, lcSe, fcltySe);

			});
		}
	},"json");
}

function fnSpceNmList(obj, pAreaSe, pLcSe, pFcltySe) {

	$(".stp01").removeClass("on").addClass("off");
	$(".stp02").addClass("on");
	$("#spceNmBlock").hide();

	var $obj = obj;
	var url = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/listFcltySpceNm.json";
	var params = {
		areaSe : pAreaSe,
		lcSe : pLcSe,
		fcltySe : pFcltySe
	};

	$obj.empty();

	$.get(url, params, function(data) {
		if (data) {

			if (data.resultList.length == 0 ) {
				 var $li = $("<li>").text("※ 이용 가능한 공간이 없습니다.");
				 $li.appendTo($obj);
			 }

			$.each(data.resultList, function(key,item) {
				var $codeItem = $("<a>").attr({'class':'spceSelctBtn', 'data-value' : item.fcltySn, 'href': '#self'}).text(item.spceNm);
				if (item.fcltySn == fcltySnVal) {
					$codeItem.addClass("on");
				}
				var $btnItem = $("<a>").attr({
					'class': "bgn spceViewBtn",
					'data-value' : item.fcltySn,
					'href': "/edu/hkEtcResve/fclty/viewPopup.do?fcltySn="+item.fcltySn + "&viewType=BODY",
					'onclick' : "window.open(this.href,'eqpmnPop','width=800, height=855, scrollbars=no');return false;"
				}).html("<span class='icoSm icoPic'><span class='sr-only'>공간보기</span></span>");

				//<a href="<c:out value="${eqpmnVO.eqpmnSn }"/>&amp;viewType=BODY" onclick="" class="text-danger db">
				var $li = $("<li>");
				$codeItem.appendTo($li);
				$btnItem.appendTo($li);
				$li.appendTo($obj);

				if (item.fcltySn == fcltySnVal) {
					var resveDtArr = resveDtVal.split("-");
					fnLoadCanlendar($("#calendarDiv"),resveDtArr[0],resveDtArr[1],resveDtArr[2]);
				}

			});
		}
	},"json");
}


//예약 달력화면 불러오기
function fnLoadCanlendar(obj, pYear, pMonth, pDay, chkSum) {

	$(".stp02").removeClass("on").addClass("off");
	$(".stp03").addClass("on");
	$("#calendarBlock").hide();

	var $obj = obj;
	$obj.empty();
	var url = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/listCal.do";
	var params = {
		year  : pYear,
		month : pMonth,
		viewType : "CONTBODY",
		chkSum  : chkSum
	};
	$.post(url, params, function(data) {
		if (data) {
			$obj.html(data);

			if (pDay != "" && typeof pDay != "undefined") {
				var $timeobj = $("#calendarDiv").find("td a").filter("[data-value="+pDay.replace("0","")+"]");
				var resveTp = "";
				$timeobj.addClass("on");
				if ($timeobj.hasClass("resve_wait")) resveTp = "resve_wait";
				fnLoadTimes($("#timeDiv"), pDay, resveTp);
			}
		}



	});

}


//예약 시간화면 불러오기
function fnLoadTimes(obj,pDay, resveTp) {

	$(".stp03").removeClass("on").addClass("off");
	$(".stp04").addClass("on");
	$("#timeBlock").hide();

	var $obj = obj;
	$obj.empty();

	var year = $(".yearmonth").find(".year").text();
	var month = $(".yearmonth").find(".month").text();

	if (typeof pDay != "undefined" && pDay.length == 1) pDay = "0"+ pDay;
	var resveDt = year + month + pDay;

	var fcltySn = $("#spceNmDiv").find(".spceSelctBtn").filter(".on").attr("data-value");

	var url = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/listTime.do";
	var params = {
		resveTp : resveTp,
		resveDt  : resveDt,
		fcltySn : fcltySn,
		viewType : "CONTBODY"
	};
	$.post(url, params, function(data) {
		if (data) $obj.html(data);

		if (resveBeginTimeVal != "" && resveEndTimeVal != "") {
			var $firstTd = $(".timerBox li>a").filter("[data-value="+resveBeginTimeVal+"]");
			var $lastTd = $(".timerBox li>a").filter("[data-value="+resveEndTimeVal+"]");

			if (resveBeginTimeVal == resveEndTimeVal) {
				$firstTd.addClass("on");
			}
			else  {
				for (var i=Number(resveBeginTimeVal); i <= Number(resveEndTimeVal); i++) {
					$(".timerBox li>a").filter("[data-value="+i+"]").addClass("on");
				}
				//$firstTd.addClass("on");
				//$lastTd.addClass("on");
				//$firstTd.closest("li").nextUntil($lastTd.closest("li")).find("a").addClass("on");
			}


			fnLoadEqpmnList($("#eqpmnDiv"));
		}
		else {
			var fcltySe = $(".fcltySeDiv").find("a").filter(".on").attr("data-value");
			if (fcltySe == "010402") {
				$(".timerBox li>a").addClass("on");
			}
		}
	});
}

//예약 장비 화면 불러오기
function fnLoadEqpmnList(obj) {

	$(".stp04").removeClass("on").addClass("off");
	$(".stp05").addClass("on");
	$("#eqpmnBlock").hide();

	var $obj = obj;
	$obj.empty();

	var year = $(".yearmonth").find(".year").text();
	var month = $(".yearmonth").find(".month").text();
	var day = $("#calendarDiv").find("td a.on").text();
	if (day.length == 1) day = "0"+ day;
	var resveDt = year + month + day;


	var beginTime = $(".timerBox li>a.on").first().attr("data-value");
	var endTime = $(".timerBox li>a.on").last().attr("data-value");
	if (typeof endTime == "undefined" || endTime == "") endTime = beginTime;

	var fcltySn = $("#spceNmDiv").find(".spceSelctBtn").filter(".on").attr("data-value");

	var url = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/listEqpmn.do";
	var params = {
		resveDt  : resveDt,
		beginTime : beginTime,
		endTime : endTime,
		fcltySn : fcltySn,
		viewType : "CONTBODY"
	};
	$.post(url, params, function(data) {
		if (data) {
			$obj.html(data);

			if (eqpnmUseYnVal != "N") {
				<c:if test="${fn:length(result.eqpmnList) > 0}">
				var eqpmnList = [];
				var item = {};
				<c:forEach var="eqpmnSelctItem" items="${result.eqpmnList}" varStatus="status">
				item.eqpmnSn = "${eqpmnSelctItem.eqpmnSn}";
				item.eqpmnQy = "${eqpmnSelctItem.eqpmnQy}";
				eqpmnList.push(item);
				</c:forEach>


				$("#eqpmnList").find("li").find("input[name=eqpmnSn]").each(function(n) {
					var $this = $(this);
					$.each(eqpmnList,function(key, value) {
						if ($this.val() == value.eqpmnSn) {
							$this.attr("checked",true);
							$this.closest("li").find("input[name=inputEqpmnQy]").val(value.eqpmnQy);
							$this.closest("li").find(".qtyNum").text(value.eqpmnQy);
							return;
						}
					});
				});
				</c:if>
				
				$("#eqpmnList").fadeIn("slow");

				if ($("#eqpmnList").find("li.nodata").size() == 1) {
					$("#noEqpnm").attr("checked",true);
				}
				else {
					$("#noEqpnm").attr("checked",false);
				}


			}
			else {
				$("#noEqpnm").attr("checked",true);
				$("#eqpmnList").hide();
			}
	
			var waitTp = $("#calendarDiv").find("td a.on").closest("td").hasClass("cal_reserv_ing");
			
			$("#resveBtnDiv").show();
			$("#prevBtn").hide();
			
			if (waitTp) {
				$("#resveBtn").hide();
				$("#waitBtn").show();
			}
			else {
				if ($(".timerBox li").find("a.on").eq(0).closest("li").hasClass("reserve_dot2")) {
					$("#resveBtn").hide();
					$("#waitBtn").show();
				}
				else {
					$("#resveBtn").show();
					$("#waitBtn").hide();
				}


			}

		}
	});
}

function fnChkResveEnd(findex, lindex) {
	var $tmpobj = $(".timeTable").find("td").eq(findex).nextUntil($(".timeTable").find("td").eq(lindex)).filter(".reserve_dot2");
	if ($tmpobj.size() > 0 ) {
		alert("예약된 시간을 포함합니다. 다시 선택해 주시기 바랍니다.");
		return false;
	}
	return true;
}

// 시설예약 저장하기 함수
function fnResveSave(resveTp) {

	var areaSe = $("#areaSeDiv").find("a").filter(".on").attr("data-value");
	var lcSe = $(".fcltySeDiv").find("a").filter(".on").closest("ul").parent().children("a").attr("data-value");
	var fcltySe = $(".fcltySeDiv").find("a").filter(".on").attr("data-value");
	var spceNm = $("#spceNmDiv").find(".spceSelctBtn").filter(".on").text();

	var fcltySn = $("#spceNmDiv").find(".spceSelctBtn").filter(".on").attr("data-value");
	var year = $(".yearmonth").find(".year").text();
	var month = $(".yearmonth").find(".month").text();
	var day = $("#calendarDiv").find("td a.on").text();
	if (day.length == 1) day = "0"+ day;
	var resveDt = year +"-"+ month +"-"+ day;
	var beginTime = $(".timerBox li").find("a.on").first().attr("data-value");
	var endTime = $(".timerBox li").find("a.on").last().attr("data-value");

	if(beginTime==null ||  endTime == null ){
		alert("STEP4. 시간을 선택해 주세요.");
		return false;
	}

	var resveTpVal = resveTp == "wait" ? "03" : "01";

	var noEqpnm = $("#noEqpnm:checked").val();
	var eqpmnsStr = "";
	if ($("#noEqpnm:checked").val() != "N") {
		var eqpmnList = [];
		if ($("#eqpmnList").find("li").find("input[name=eqpmnSn]:checked").size() == 0) {
			alert("STEP5. 장비를 선택해 주세요.");
			return false;
		}

		var flag = false;
		$("#eqpmnList").find("li").find("input[name=eqpmnSn]:checked").each(function(n) {
			var item = {};
			item.eqpmnSn = $(this).closest("li").find("input[name=eqpmnSn]").val();
			item.eqpmnNm = $(this).closest("li").find("input[name=eqpmnNm]").val();
			item.eqpmnQy = $(this).closest("li").find("input[name=inputEqpmnQy]").val();

			var inputEqpmnQy = $(this).closest("li").find("input[name=inputEqpmnQy]").val();
			var remndrQy = $(this).closest("li").find(".remndrQy").text();

			if (inputEqpmnQy == "0" && remndrQy != inputEqpmnQy) {
				alert("신청 수량을 선택해 주세요.");
				var $input = $(this).closest("li").find("input[name=inputEqpmnQy]");
				$input.focus();
				flag = true;
				return false;
			}

			var detailSnStr = $(this).closest("li").find("input[name=eqpmnDetailSnStr]").val();
			var dtlSnArr = detailSnStr.split(",");
			var tmpSnArr = [];
			for (var i=0 ; i < inputEqpmnQy; i++) {
				tmpSnArr.push(dtlSnArr[i]);
			}
			item.eqpmnDetailSnStr = tmpSnArr.join(",");

			eqpmnList.push(item);
		});

		if (flag) return false;

		eqpmnsStr = JSON.stringify(eqpmnList);
		eqpmnsStr = Base64.encode(eqpmnsStr);
	}


	var vwSpceAllNm = "";
	vwSpceAllNm += $("#areaSeDiv").find("a").filter(".on").text();
	vwSpceAllNm += " > "+ $(".fcltySeDiv").find("a").filter(".on").closest("ul").parent().children("a").text();
	vwSpceAllNm += " > "+ $(".fcltySeDiv").find("a").filter(".on").text();
	vwSpceAllNm += " > "+ $("#spceNmDiv").find(".spceSelctBtn").filter(".on").text();

	var url = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/step3.do";


	if (confirm("예약 하시겠습니까?")) {

		$("#areaSe").val(areaSe);
		$("#lcSe").val(lcSe);
		$("#fcltySe").val(fcltySe);
		$("#spceNm").val(spceNm);

		$("#fcltySn").val(fcltySn);
		$("#resveDt").val(resveDt);
		$("#resveBeginTime").val(beginTime);
		if (typeof endTime == "undefined") endTime = beginTime;
		$("#resveEndTime").val(endTime);
		$("#resveSttus").val(resveTpVal);
		$("#vwSpceAllNm").val(vwSpceAllNm);
		$("#eqpmnsStr").val(eqpmnsStr);
		$("#eqpnmUseYn").val(noEqpnm);


		$("#resveForm").attr("action", url);
		$("#resveForm").submit();
	}



	return false;
}

//]]>
</script>

<div class="tabs child4 noLink">
	<ol>
		<li>개인정보 동의</li>
		<li class="on">장비 및 일자/시간 선택<span class="sr-only">(현재단계)</span></li>
		<li>예약자 정보 입력</li>
		<li>예약완료</li>
	</ol>
</div>


<fieldset id="greeField">
	<legend>장비 예약 운영정책 안내 입력양식</legend>
	<form name="agreeForm" action="" method="post">
			<h2>장비 예약 운영정책 안내</h2>
			<div tabindex="0" class="scrollY">

<h3>주의사항 </h3>
<ul class="bull">
	<li>본 시설과 장비는 콘텐츠인재캠퍼스에서 진행되는 교육 및 교육 대상자들에 한하여 제한적으로 운영됩니다.</li>
	<li>콘텐츠인재캠퍼스의 교육 외 지원사업, 행사 등 교육과 관계 없는 기재 및 시설(장비 포함)의 경우 사용이 일부 제한될 수 있습니다.</li>
	<li>사용중에 발생한 시설, 장비, 집기 등 파손에 대한 책임은 전적으로 이용자에게 있으며 또한 타인에게 방해가 되는 행동(고성방가, 화기사용, 음식물 반입 등)을 금합니다.</li>
	<li>토,일요일을 제외한 법정공휴일 및 별도지정 안내일 휴관합니다.</li>
</ul>
<h3>장비 예약 안내 </h3>
<ul class="bull">
	<li>이용일 기준 30일 전부터 3일 전까지 예약이 가능합니다.</li>
	<li>이용자는 하루 1건까지 대기 예약 가능합니다.<br />
		※ 대기예약 안내
		<ul class="m1">
			<li>예약 시간 외에는 대기예약 신청만 가능합니다.</li>
			<li>다른 사람이 이미 예약한 공간에 대해 대기예약을 신청할 수 있고, 예약이 취소되는 경우 운영담당자가 대기예약 신청자에게 개별 연락 후 승인합니다.</li>
		</ul>
	</li>
	<li>예약 취소는 예약일 기준, 전일 24:00까지 가능합니다.</li>
	<li>90일 이내에 예약취소 없이 2회 이상 미사용 한 경우, 30일간 예약이 금지됩니다.</li>
	<!--<li>일요일을 제외한 법정공휴일에는 운영하지 않습니다.</li>-->
	<!-- <li>2F/10F 연중무휴(법정공휴일 및 별도지정 안내일 휴관)</li>
	<li>14F/15F 주중운영(주말/법정공휴일 및 별도지정 안내일 휴관)</li> -->
</ul>

<!-- <div class="well">관련 문의사항 : 02-6310-0627</div> -->

			<!--
			<div class="agreeScrBtm tar">
					<span class="dib fl">	위 개인정보 수집 및 이용 내용에 </span>
					<label for="rdoGp1_0" class="mr20"><input type="radio" name="rdoGp1" value="라디오" id="rdoGp1_0" /> 동의합니다. </label>
					<label for="rdoGp1_1"><input type="radio" name="rdoGp1" value="라디오" id="rdoGp1_1" /> 동의하지 않습니다. </label>
			</div>
			 -->
		</div>


		<div class="btnSet board_util_btn_con">
			<a href="#self" class="btn_style_0 green radius" id="agreeBtn">장비 예약 운영정책에 동의합니다.</a>
		</div>

	</form>
</fieldset>




<!-- 시설 박스 정보 -->
<div class="reservSysSet" style="display:none;position: inherit;">
	<div class="">
	  <div class="head" style="display: none;">
	  	<span><span class="icoSm icoMap"></span> 시설을 이용하실 지역을 선택하세요.</span>
	  	<span class="icoSm icoArr"></span>
	  	<span id="areaSeDiv">

	  	</span>
	  </div>
	  <div class="boxGray reservSet">
	    <ul>
	      <!-- <li class="stp01" >	//step의 정보 on(활성화), off(완료시), 없을때  적용
	        <h4>STEP1. 시설정보 <span class="icoSm icoArr1"></span></h4>
	        <div class="scrollY" tabindex="0">
	          <div class="graybox tac" id="lcSeBlock">
	        	<span class="dib icoSm icoMd icoBacks"></span>
	        	<p class="mt10">지역을<br />선택하여 주세요.</p>
	          </div>
	          <ul class="reserv_ltbx buListRev" id="lcSeDiv">
	          	<li class="noData fs11">※ 예약가능 공간이 없습니다.</li>
	          </ul>
	        </div>
	      </li> -->
	      <!-- <li class="stp02" >	//step의 정보 on(활성화), off(완료시), 없을때  적용
	        <h4>STEP2. 공간선택 <span class="icoSm icoArr1"></span></h4>
	        <div class="scrollY" tabindex="0">
	        	<div class="graybox tac" id="spceNmBlock">
	        		<span class="dib icoSm icoMd icoBacks"></span>
	        		<p class="mt10">시설정보를<br />선택하여 주세요.</p>
	        	</div>
	        	<ul class="reserv_ltbx2" id="spceNmDiv">
	            	<li></li>
	            	
	            	<li><a class="spceSelctBtn" data-value="4" href="#self">프로젝트룸 1</a>
	            		<a class="bgn spceViewBtn" data-value="4" href="#self"><span class="icoSm icoPic"><span class="sr-only">공간보기</span></span></a>
	            	</li>
	            	
	        	</ul>
	        </div>
	      </li> -->
	      <li class="stp03">	<!-- //step의 정보 on(활성화), off(완료시), 없을때  적용 -->
	        <h4>STEP1. 일자선택 <span class="icoSm icoArr1"></span></h4>
	        <div class="scrollY main_cal" id="main_cal">
	        	<div class="graybox tac" id="calendarBlock">
	        		<span class="dib icoSm icoMd icoBacks"></span>
	        		<p class="mt20">공간정보를 선택하여 주세요.</p>
	        	</div>
	       		<div class="cal_head tac headStep3" style="">
	       			<div class="calHMonth yearmonth">
						<a href="javascript:void(0);" class="icoSm icoMd prevMonth" data-value="08"><span class="sr-only">이전 달 보기</span></a>
							<strong><span class="year"></span><span class="sr-only">년</span></strong> -
							<strong><span class="month"></span><span class="sr-only">월</span></strong>
						<a href="javascript:void(0);" class="icoSm icoMd nextMonth" data-value="10"><span class="sr-only">다음 달 보기</span></a>
					</div>


		            <ul class="cal_ico headStep3_ico mt30 mb10">
		            	<!-- <li><span class="cal_today"><span class="sr-only">오늘 표시</span></span> 오늘</li> -->
						<li><span class="cal_reserv_ok"><span class="sr-only">예약가능 표시</span></span><em class="uline fcGreen">예약가능</em></li>
						<li><span class="cal_reserv_end"><span class="sr-only">예약불가 표시</span></span>예약불가</li>
						<li><span class="cal_reserv_ing"><span class="sr-only">대기예약 표시</span></span>대기예약</li>
		            </ul>
					<div class="cal_table_wrap">
						<div class="posr" id="calendarDiv">

						</div>
						<p style="color: red;text-align:left;padding-top:10px;">※ 오늘기준 3일까지는 무조건 대기예약으로만 예약됩니다.<p>
					</div>
				</div>
	        </div>
	      </li>
	      <li class="stp04">	<!-- //step의 정보 on(활성화), off(완료시), 없을때  적용 -->
	        <h4>STEP2. 시간선택 <span class="icoSm icoArr1"></span></h4>
	        <div class="scrollY fs12">
	        	<div class="graybox tac" id="timeBlock">
	        		<span class="dib icoSm icoMd icoBacks"></span>
	        		<p class="mt10">이용하실 일자를<br />선택하여 주세요.</p>
	        	</div>
				<!-- <div class="timerHTxt">
					<p>예약가능 시간이 없을 경우, 시간 및 장비를 선택한 후 <span class="fcRed">‘대기예약’</span>을 클릭하여 주세요.</p>
					<p class="fcRed"><span class="icoSm icoInfo"></span> 예약가능 시간과 예약완료 시간은 함께 선택할 수 없으며, 예약완료 시간을 선택하시면 대기예약으로 예약신청이 진행됩니다.</p>
				</div> -->

	          <div class="cal_timer"  id="timeDiv"></div>
	          <!-- <div class="fcRed clear" style="font-size: 10px;">
	          	<p>대기 예약은 이용 확정이 아니며, 이전 예약자가 예약취소 하였을 경우, 담당자가 대기 예약순으로 연락을 드린 후 이용이 가능합니다.</p>
	          </div> -->
	          <div class="clear fr mt10" style="display: none;">
	        		<a href="#self" class="btn btn-sm btn-primary pl20" id="eqpmnSrchBtn"><span class="icoSm btnIcZoom"></span>장비조회</a>
	          </div>
	        </div>
	      </li>
	      <li class="stp05">	<!-- //활성화 시 on -->
	        <h4>STEP3. 장비선택 <span class="icoSm icoArr1"></span></h4>
	        <div class="scrollY">
	        	<div class="graybox"></div>
	        	<div class="graybox tac" id="eqpmnBlock">
	        		<span class="dib icoSm icoMd icoBacks"></span>
	        		<p class="mt10">이용하실 시간을<br /> 선택하여 주세요.</p>
	        	</div>
	        	<div id="eqpmnDiv" class="tal"></div>
	        </div>
	      </li>
	    </ul>
	  </div>



		<div class="fl clear" style="width:100%">
			<div class="btnSet">
				<div class="row board_util_btn_con" style="max-width:1000px;">
					<div class="col-md-12 tal">
						<a href="javascript:void(0);" class="btn_style_0 blue radius" id="prevBtn">이전</a>
						<!-- <a href="javascript:void(0);" class="btn_style_0 green radius" id="resetBtn">초기화</a> -->
					</div>
					<div class="col-md-12 tar">
						<div id="resveBtnDiv" style="display:none;">
							<button type="button" class="btn_style_0 green radius" id="resveBtn" style="diplay:none;">예약하기</button>
							<button type="button" class="btn_style_0 green radius" id="waitBtn" style="diplay:none;">대기예약</button>
							<a href="javascript:void(0);" class="btn_style_0 blue radius" id="cancelResveBtn">취소</a> 
						</div>
					</div>
				</div>
			</div>
		</div>

		<form name="resveForm" id="resveForm" method="post" action="<c:out value="${action }" />" class="form-inline">
			<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
			<input type="hidden" name="pageQueryString" id="pageQueryString" value="${pageQueryString }" />
			<input type="hidden" name="resveSn" id="resveSn" value="<c:out value="${result.resveSn }" />" />
			<input type="hidden" name="fcltySn" id="fcltySn" value="" />
			<input type="hidden" name="areaSe" id="areaSe" value="" />
			<input type="hidden" name="lcSe" id="lcSe" value="" />
			<input type="hidden" name="fcltySe" id="fcltySe" value="" />
			<input type="hidden" name="spceNm" id="spceNm" value="" />
			<input type="hidden" name="resveDt" id="resveDt" value="" />
			<input type="hidden" name="resveBeginTime" id=resveBeginTime value="" />
			<input type="hidden" name="resveEndTime" id="resveEndTime" value="" />
			<input type="hidden" name="resveSttus" id="resveSttus" value="" />
			<input type="hidden" name="vwSpceAllNm" id="vwSpceAllNm" value="" />
			<input type="hidden" name="eqpmnsStr" id="eqpmnsStr" value="" />
			<input type="hidden" name="eqpnmUseYn" id="eqpnmUseYn" value="" />

		</form>
	</div>
</div>
<!-- //시설 박스 정보 -->



