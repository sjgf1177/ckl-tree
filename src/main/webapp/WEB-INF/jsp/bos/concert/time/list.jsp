<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.testbed.concert.service.ConcertMngService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<%-- <c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/> --%>

<script type="text/javascript">

$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

/* 	if (prgSeVal != "") getCodeList("prgCl", codeIdVal, $("#prgSe").val(), 2, prgClVal);

	$("select[name=prgSe]").change(function(){
		var val = $(this).val();
		getCodeList("prgCl", codeIdVal, val, 2);
	}); */
});

function updateDeadline( concertTimeId, offReserv ){
	var msg = "";
	var statusOff = 0;
	if ( offReserv == 0 ){ //진행중인경우
		msg= "정말 마감 하시겠습니까?";
		statusOff = 1;
	} else if ( offReserv == 1 ){ //임의 마감 처리 된 경우
		msg= "마감을 취소 하시겠습니까?";
		statusOff = 0;
	}
	
	if (confirm(msg)) 
		$.get("/bos/concert/time/updateTimeOff.json"
				, { statusOff : statusOff, concertTimeId : concertTimeId }
				, function(data) {
					if (data.resultCode == 'success') {
						alert("정상적으로 수정되었습니다.");
						location.reload();
					} else {
						alert(data.msg);
					}
				},"json");
}

</script>

<h4>■ 예약현황</h4>

<form id="frm" name="frm" method="post" action="/bos/concert/time/list.do?menuNo=${param.menuNo}" class="form-inline">
	<input type="hidden" name="siteSe" value="${param.siteSe}" >
	<fieldset>
		<legend></legend>
			<div class="bdView mb0">
				<table class="table table-bordered">
					<caption>
					</caption>
					<colgroup>
					<col span="4">
					<col>
					</colgroup>
					<tbody>
						<tr>
							<th>공연명</th>
							<td colspan="4">${concertResult.concertTitle }</td>
						</tr>
						<tr>
							<th>공연구분</th>
							<td>
								${concertResult.concertType }
							</td>
							<th>공연구분</th>
							<td>
								${concertResult.concertPlace }
							</td>
						</tr>
						<tr>
							<th>공연기간</th>
							<td colspan="4">${concertResult.concertStartDate } ~ ${concertResult.concertEndDate }</td>
						</tr>
					</tbody>  
				</table>
			</div>
			<%-- 
			<div class="btnSet">
				<input type="submit" class="btn btn-primary" value="검색" />
				<a class="btn btn-primary" href="/bos/concert/time/forInsert.do?${pageQueryString}"><span>공연일정 등록</span></a>
			</div>
			 --%>
	</fieldset>
</form>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<h4>■ 공연정보 및 예약현황</h4>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width: 40px;">
		<col >
		<col >
		<col style="width: 80px;">
		<col style="width: 131px;">
		<col style="width: 40px;">
		<col style="width: 40px;">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>공연일</th>
				<th>시간</th>
				<th>비고</th>
				<th>진행상태</th>
				<th>예약현황<br>(총좌석/예약/남은좌석)</th>
				<th>마감</th>
			</tr>
		</thead>
		<tbody>
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate var="today" value="${now}" pattern="yyyyMMddHHmm"/>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					 <td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.concertDt}</td>
					<td class="tac">${result.startTime} ~ ${result.endTime}</td>
					<td>${result.commentMsg }</td>
					<td>
						<fmt:parseDate var="startDateStr" value="${result.concertDt}${result.startTime}" pattern="yyyy-MM-ddHH:mm" />
						<fmt:formatDate var="startDate" value="${startDateStr}" pattern="yyyyMMddHHmm"/>
						<c:choose>
							<c:when test="${result.remainCnt <= 0 }">매진</c:when>
							<c:when test="${startDate - today < 0 }">마감</c:when>
							<c:otherwise>진행</c:otherwise>
						</c:choose>
					</td>
					<td class="tac">
						<a class="btn btn-default btn-sm" href="/bos/concert/reserv/list.do?concertTimeId=${result.concertTimeId}&concertId=${result.concertId}&menuNo=${param.menuNo}">
							<span>
								${result.reservOnlineSitNum }/${result.reservedCnt}/${result.remainCnt }
							</span>
						</a>
					</td>
					<td>
						<c:if test="${result.remainCnt > 0 && startDate - today >= 0 }">
							<a class="btn btn-sm ${result.offReserv eq 0? 'btn-danger':'btn-primary' }" href="javascript:updateDeadline('${result.concertTimeId }', '${result.offReserv }')">
								<span>${result.offReserv eq 0? "마감처리":"마감취소" }</span>
							</a>
						</c:if>
					</td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="11">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet">
	<a class="btn btn-primary" href="/bos/concert/info/list.do?${pageQueryString}"><span>목록</span></a>
</div>

<%-- 
<div class="btn_set">
	<a class="btn btn-success" href="/bos/concert/time/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
	<a class="btn btn-primary" href="/bos/concert/time/forInsert.do?${pageQueryString}"><span>프로그램 신규 등록</span></a>
</div> 
 --%>

<%-- <c:if test="${fn:length(resultList) > 0}"> --%>
<!-- 	<div class="paging"> -->
<!-- 		<div class="paginationSet"> -->
<%-- 			${pageNav} --%>
<!-- 		</div> -->
<!-- 	</div> -->
<%-- </c:if> --%>

