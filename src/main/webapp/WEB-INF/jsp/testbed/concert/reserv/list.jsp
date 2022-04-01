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

//선택 참석여부 변경
function changeStatus(){
	
}

//예약내역출력
function printReservList(){
	
}

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

<h4>■ 예약현황</h4>

<div class="bdView">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col span="3">
		<col>
		<col>
		<col>
		<col span="10">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2">총좌석</th>
				<th scope="col" rowspan="2">온라인예약</th>
				<th scope="col" rowspan="2">전화예약</th>
				<th scope="col" rowspan="2">현장예약　</th>
				<th scope="col" colspan="2">성별</th>
				<th scope="col" colspan="4">회원구분</th>
			</tr>
			<tr>
				<th scope="col">남</th>
				<th scope="col">여</th>
				<th scope="col">10대</th>
				<th scope="col">20대</th>
				<th scope="col">30대</th>
				<th scope="col">40대</th>
			<!-- 
			<tr>
				<th scope="col" colspan="2"></th>
				<th scope="col" colspan="4">나이</th>
			</tr>
			<tr>
				<th scope="col">남</th>
				<th scope="col">여</th>
				<th scope="col">20대</th>
				<th scope="col">30대</th>
				<th scope="col">40대</th>
				<th scope="col">50대</th>
			</tr>
			 -->
		</thead>
		<tbody>
			
				<tr>
					<td>현장교육</td>
					<td>게임리터러시교육</td>
					<td>0</td>
					<td>81(0)</td>
					<td>80(0)</td>
					<td>1(0)</td>
					<td>0(0)</td>
					<td>0(0)</td>
					<td>0(0)</td>
					<td>0(0)</td>
				</tr>
			
		</tbody>
	</table>
</div>



<h4>■ 검색</h4>

<form id="frm" name="frm" method="post" action="/bos/concert/reserv/list.do?menuNo=${param.menuNo}" class="form-inline">
	<input type="hidden" name="siteSe" value="${param.siteSe}" >
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
							<th>
								<select id="searchType" name="searchType" title="담당부서">
								    <option value="">선택</option>
									<option value="userId">아이디</option>
								</select>
							</th>
							<td>
								<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}">
							</td>
							<th><label for="mbtlnum">연락처</label></th>
							<td><input type="text" name="mbtlnum" id="mbtlnum" value="${param.mbtlnum}"></td>
							<%-- 
							 --%>
						</tr>
						<tr>
							<th>예약구분</th>
							<td colspan="3">
								<label for="reservType1"> <input type="checkbox" name="reservType" value="01" id="reservType1">온라인</label>
								<label for="reservType2"> <input type="checkbox" name="reservType" value="02" id="reservType2">전화</label>
								<label for="reservType3"> <input type="checkbox" name="reservType" value="03" id="reservType3">현장</label>
							</td>
						</tr>
					</tbody>  
				</table>
			</div>
			<div class="btnSet">
				<input type="submit" class="btn btn-primary" value="검색" title="검색"/>
				<%-- 
				<a class="btn btn-primary" href="/bos/concert/reserv/forInsert.do?${pageQueryString}"><span>공연 등록</span></a>
				 --%>
			</div>
	</fieldset>
</form>



<h4>■ 예약리스트</h4>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width: 40px;">
		<col>
		<col style="width: 80px;">
		<col style="width: 66px;">
		<col style="width: 131px;">
		<col style="width: 131px;">
		<col style="width: 66px;">
		<col style="width: 40px;">
		<col>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>예약넘버</th>
				<th>아이디</th>
				<th>이름</th>
				<th>연락처</th>
				<th>좌석</th>
				<th>예약구분</th> 
				<th>참석</th> 
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="tac">${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td><a href="/bos/concert/reserv/view.do?concertReservId=${result.concertReservId}&${pageQueryString}">
						${result.reservCode}</a></td>
					<td><a href="/bos/concert/reserv/view.do?concertReservId=${result.concertReservId}&${pageQueryString}">
						${result.userId}</a></td>
					<td class="tac"><a href="/bos/concert/reserv/view.do?concertReservId=${result.concertReservId}&${pageQueryString}">
						${result.userNm}</a></td> 
					<td>${result.mbtlnum}</td>
					<td>${result.sitSeq}</td>
					<td>예약구분</td>
					<td>${result.status eq '1'? 'O' : 'X' }</td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="11">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="fl">
	<a class="btn btn-primary" id="" href="javascript:changeStatus();"><span>선택 참석여부 변경</span></a>
	<a class="btn btn-primary" id="" href="javascript:printReservList();"><span>예약내역출력</span></a>
</div>

<div class="btnSet">
	<a class="btn btn-primary" href="/bos/concert/reserv/forInsert.do?${pageQueryString}"><span>등록하기</span></a>
	<a class="btn btn-primary" href="/bos/concert/time/list.do?${pageQueryString}"><span>목록</span></a>
	<%-- 
	<a class="btn btn-primary" href="/bos/concert/time/forInsert.do?${pageQueryString}"><span>공연일정 등록</span></a>
	 --%>
</div>

<%-- 
<div class="btn_set">
	<a class="btn btn-success" href="/bos/concert/info/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
</div> 
 --%>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paginationSet">
			${pageNav}
		</div>
	</div>
</c:if>

