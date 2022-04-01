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

//공통 코드목록 화면처리
function getCodeList(elemntId, codeId, upperCode, depth, code) {
	var $obj = $("#"+ elemntId);
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};
	$.get(url, params, function(data) {
		if (data) {
			$obj.empty();
			$("<option>").text("분류 선택").attr("value","").appendTo($obj);
			$.each(data.list, function(key,item) {
				var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
				if (code == item.code) $codeItem.attr("selected",true);
				$codeItem.appendTo($obj);
			});
			if ("prgCl" == elemntId && "" == upperCode) {
				$("<option>").text("분류 선택").attr("value","").appendTo($("#prgCl").empty());
			}
		}
	},"json");
}

</script>

<form id="frm" name="frm" method="post" action="/bos/concert/info/list.do?menuNo=${param.menuNo}" class="form-inline">
	<fieldset>
		<legend></legend>
			<div class="bdView mb0">
				<table class="table table-bordered">
					<caption>
					</caption>
					<colgroup>
					<col span="3">
					<col>
					</colgroup>
					<tbody>
						<tr>
							<th><label for="concertType">공연구분</label></th>
							<td><input type="text" name="concertType" id="concertType" value="${param.concertType}"></td>
							<th><label for="concertName">공연명</label></th>
							<td><input type="text" name="concertTitle" id="concertTitle" value="${param.concertTitle}"></td>
							<%-- 
							 --%>
						</tr>
						<tr>
							<th>시작일</th>
							<td>
								<input type="text" id="sdate" name="sdate" value="${param.sdate}" style="width:130px" title="시작 일시" />
							</td>
							<th>종료일</th>
							<td>
							    <input type="text" id="edate" name="edate" value="${param.edate}" style="width:130px" title="종료 일시" />
							</td>
						</tr>
					</tbody>  
				</table>
			</div>
			<div class="btnSet">
				<input type="submit" class="btn btn-primary" value="검색" />
				<a class="btn btn-primary" href="/bos/concert/info/forInsert.do?${pageQueryString}"><span>공연 등록</span></a>
			</div>
	</fieldset>
</form>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width: 40px;">
		<col style="width: 66px;">
		<col>
		<col style="width: 80px;">
		<col style="width: 80px;">
		<col style="width: 131px;">
		<col style="width: 40px;">
		<col>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>공연구분</th>
				<th>공연명</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>예약현황</th>
				<th>관리</th> 
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.concertType}</td>
					<td><a href="/bos/concert/info/view.do?concertId=${result.concertId}&${pageQueryString}">${result.concertTitle}</a></td>
					<td>${result.concertStartDate }</td>
					<td>${result.concertEndDate }</td> 
					<td class="tac">
						<a class="btn btn-default btn-sm" href="/bos/concert/time/list.do?concertId=${result.concertId}&menuNo=${param.menuNo}">
							<span>
								예약현황보기
							</span>
						</a>
					</td>
					<td><a class="btn btn-primary btn-sm" href="/bos/concert/info/forUpdate.do?concertId=${result.concertId}&${pageQueryString}"><span>관리</span></a></td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="11">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<%-- 
<div class="btn_set">
	<a class="btn btn-success" href="/bos/concert/info/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
	<a class="btn btn-primary" href="/bos/concert/info/forInsert.do?${pageQueryString}"><span>프로그램 신규 등록</span></a>
</div> 
 --%>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paginationSet">
			${pageNav}
		</div>
	</div>
</c:if>

