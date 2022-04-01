<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
$(function(){
	$("#term01Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		$(this).closest("span").find("a").removeClass("on");
		$(this).addClass("on");
		var edate = fnAddCalMonth($("#resveStDt").val(),1);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#term03Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		$(this).closest("span").find("a").removeClass("on");
		$(this).addClass("on");
		var edate = fnAddCalMonth($("#resveStDt").val(),3);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#term06Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		$(this).closest("span").find("a").removeClass("on");
		$(this).addClass("on");
		var edate = fnAddCalMonth($("#resveStDt").val(),6);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#term12Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		$(this).closest("span").find("a").removeClass("on");
		$(this).addClass("on");
		var edate = fnAddCalMonth($("#resveStDt").val(),12);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#submitBtn2").click(function() {
		$("#submitBtn").click();
		return false;
	});

	$(".resveCancelBtn").click(function() {
		if (confirm("예약을 취소하시겠습니까?")) {
			var url = "/<c:out value="${paramVO.siteName}" />/fcltyResve/resveSttus/cancelResveSttus.json";
			var params = {
				resveSn : $(this).closest("li.item").find("input[name=resveSn]").val()
			};
			$.post(url, params, function(data) {
				if (data.resultCode == "success") {
					alert("예약취소가 완료되었습니다.");
					window.location.reload();
				}
				else {
					alert("예약취소가 실패하였습니다.");
				}
			},"json");
		}
		return false;
	});
});


function fnAddCalMonth(date, addMonth) {
	var dateArray = date.split("-");
	var tmpDate = new Date(dateArray[0], Number(dateArray[1])-1 ,dateArray[2]);
	tmpDate.setMonth(Number(dateArray[1])-1+ addMonth);

	var year = tmpDate.getFullYear();
	var month = tmpDate.getMonth()+1;
	if (month < 10) month = "0"+month;
	var day = tmpDate.getDate();
	if (day < 10) day = "0"+day;
	var resultDate = year + "-" + month + "-" +  day;
	return resultDate;
}
//]]>
</script>



<div class="box text-danger fs12 pl10 pr10"><span class="icons icoAlert"></span> 모바일에서는 예약에 대한 조회 / 취소가 가능합니다. </div>

<form id="resveSttusForm" name="resveSttusForm" method="get" class="form-inline" action="/<c:out value="${paramVO.siteName }" />/fcltyResve/resveSttus/listMypage.do">
<input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />" />
<div class="tac alert formLine1">
		<fieldset>
			<legend>예약신청현황 검색</legend>
			<div class="clearfix">
			<span class="btn-group mb5">
				<a href="#self" class="btn btn-sm btn-default on" id="term01Btn">1개월</a>
				<a href="#self" class="btn btn-sm btn-default" id="term03Btn">3개월</a>
				<a href="#self" class="btn btn-sm btn-default" id="term06Btn">6개월</a>
				<a href="#self" class="btn btn-sm btn-default" id="term12Btn">12개월 이전</a>
			</span>
			<div class="db">

				<input type="date" id="resveStDt" name="resveStDt"  class="sdate" title="예약일자 시작일 입력" value="<c:out value="${paramVO.resveStDt }" />" />
					~
				<input type="date" id="resveEdDt" name="resveEdDt"  class="edate" title="예약일자 종료일 입력" value="<c:out value="${paramVO.resveEdDt }" />" />
			</div>
			<button class="btn btn-sm mt10" id="submitBtn"><span class="icoSm btnIcZoom"></span> 검색하기</button>
			</div>
		</fieldset>
</div>


<div class="clear tar mb10 pr10">
	<label for="resveSttus">승인상태</label>
	<select name="resveSttus" id="resveSttus" title="승인상태를 선택해 주세요.">
		<option value="">상태선택</option>
		<c:forEach var="item" items="${COM071CodeList }">
			<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.resveSttus }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
		</c:forEach>
	</select>
	<a href="javascript:void(0);" class="btn btn-sm btn-black" id="submitBtn2">확인</a>
</div>
</form>



<div class="reservTable">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li class="item">
			<div class="infoTop">
				<span class="title">예약번호 : <span class="text-danger"><c:out value="${result.resveNo }" /><input type="hidden" name="resveSn" value="<c:out value="${result.resveSn }" />" /></span></span>

				<c:if test="${result.resveSttus eq '02' }">
				<div class="fr">
				<c:choose>
					<c:when test="${result.useAt eq 'Y'}"><span class="btn btn-sm"><span class="icoSm icoCheck"></span>사용</span></c:when>
					<c:when test="${result.useAt eq 'W'}"><span class="btn btn-sm btn-gray">대기</span></c:when>
					<c:otherwise><span class="btn btn-sm btn-default">미사용</span></c:otherwise>
				</c:choose>
				</div>
				</c:if>
			</div>
			<div class="list">
				<ul class="bull">
					<li><c:out value="${result.lcSeNm }" /> / <c:out value="${result.spceNm }" /></li>
					<li><c:out value="${result.resveDt }" /> / <c:out value="${result.resveBeginTime }" />시~<c:out value="${result.resveEndTime }" />시</li>
					<li>장비 : <c:out value="${result.eqpmnNms }" /></li>
					<li>승인상태 :
					<c:choose>
						<c:when test="${result.resveSttus eq '01' }"><strong class="text-primary"><c:out value="${result.resveSttusNm }" /></strong>
							<c:if test="${result.useAt ne 'N' && result.cancelUseAt eq 'Y' }">
							<p class="fr"><a href="#self" class="btn btn-sm btn-danger resveCancelBtn">예약취소</a></p>
							</c:if>
						</c:when>
						<c:when test="${result.resveSttus eq '02' }"><strong class="text-success"><c:out value="${result.resveSttusNm }" /></strong>
							<c:if test="${result.useAt ne 'N' && result.cancelUseAt eq 'Y' }">
							<p><a href="#self" class="btn btn-xs btn-gray resveCancelBtn">예약취소</a></p>
							</c:if>
						</c:when>
						<c:when test="${result.resveSttus eq '03' }"><strong class="text-danger"><c:out value="${result.resveSttusNm }" /></strong>
							<c:if test="${result.useAt ne 'N' && result.cancelUseAt eq 'Y' }">
							<p class="fr"><a href="#self" class="btn btn-sm btn-danger resveCancelBtn">예약취소</a></p>
							</c:if>
						</c:when>
						<c:when test="${result.resveSttus eq '04' }"><strong class="text-danger"><c:out value="${result.resveSttusNm }" /></strong></c:when>
						<c:when test="${result.resveSttus eq '05' }"><strong class="text-danger"><c:out value="${result.resveSttusNm }" /></strong></c:when>
					</c:choose>
					</li>
				</ul>
			</div>
			<div class="reservMore">
				<a href="#self" class="openRv">상세보기<span class="icoSm icoArrOpen"></span></a>
			</div>


			<div class="detailReserv">
				<ul class="bull">
					<li>등록일시 			: <strong><c:out value="${result.frstRegistPnttm }" /></strong></li>
					<li>나이 				: <strong><c:out value="${result.ageSeNm }" /></strong></li>
					<li>직업 				: <strong><c:out value="${result.jobSeNm }" /></strong></li>
					<li>거주지역 			: <strong><c:out value="${result.resdncSeNm }" /></strong></li>
					<li>사용인원 			: <strong><c:out value="${result.useNmpr }" />명</strong></li>
					<li>사용목적 			: <strong><c:out value="${result.usePurposeSeNm }" /></strong></li>
					<li>예약정보 수신방법 		: <strong><c:out value="${result.resveRecptnSeNm }" /></strong></li>
					<li>코멘트 			: <strong><c:out value="${result.admCmmnt }" /></strong></li>
				</ul>
				<div class="reservMore">
					<a href="#self" class="closeRv">접기<span class="icoSm icoArrClose"></span></a>
				</div>
			</div>
		</li>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<li>- 검색 결과가 없습니다 -</li>
		</c:if>
	</ul>
</div>
<script type="text/javascript">
//<![CDATA[
  $('.openRv').click(function() {
		$(".detailReserv").removeClass('on');
		$(this).parent().next().addClass('on');
		return false;
  });

  $('.closeRv').click(function() {
		$(".detailReserv").removeClass('on');
		$(this).parent().parent().prev().find('.openRv').focus();
		return false;
  });
//]]>
</script>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
