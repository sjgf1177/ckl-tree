<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
hr{
	visibility:inherit!important;
	position:unset!important;
	margin:0px!important;
	width: 100%;
}
</style>

<script type="text/javascript">
//<![CDATA[
$(function() {

	$("#term01Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),1);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#term03Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),3);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#term06Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),6);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#term12Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),12);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#excelBtn").click(function() {
		$("#statsForm").attr("action","/bos/hkEtcResve/resveSttus/downloadExcelResveStats.xls");
		$("#statsForm").submit();
		$("#statsForm").attr("action","/bos/hkEtcResve/resveSttus/resveStats.do");

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

<!-- 게시판 게시물검색 -->
<form name="statsForm" id="statsForm" method="get" action="/bos/hkEtcResve/resveSttus/resveStats.do">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<div class="sh form-inline pr10">
	<fieldset>
		<legend>장비예약 통계</legend>
		<div class="shView">
			<table class="table">
				<caption>
				</caption>
				<colgroup>
				<col />
				<col />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >기간</th>
						<td><input type="text" id="resveSdate" name="resveSdate"  class="sdate" title="시작일 입력" style="width:90px" value="<c:out value="${paramVO.resveSdate }" />" readonly="readonly" />
							~
							<input type="text" id="resveEdate" name="resveEdate"  class="edate" title="종료일 입력" style="width:90px" value="<c:out value="${paramVO.resveEdate }" />" readonly="readonly" />

							<a class="btn btn-default" href="#self" id="term01Btn"><span>1개월</span></a>
							<a class="btn btn-default" href="#self" id="term03Btn"><span>3개월</span></a>
							<a class="btn btn-default" href="#self" id="term06Btn"><span>6개월</span></a>
							<!-- <a class="btn btn-default" href="#self" id="term12Btn"><span>12개월</span></a> -->

						</td>
						<td>
							<div class="btn_set">
								<input type="submit" class="btn btn-primary" value="확인" style="width: 90px;height: 35px;"/>
								<a class="btn btn-info" href="#self" id="excelBtn"><span>엑셀로 저장</span></a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</div>
<!-- //게시판 게시물검색 -->
<!-- <div class="row clear mt20 tac">
	<div class="col-md-12"><input type="submit" class="btn btn-primary" value="확인" /></div>
</div> -->

<div class="row mt10 mb5">
	<fmt:parseDate value="${paramVO.resveSdate}" var="sdateFmt" pattern="yyyy-MM-dd"/>
	<fmt:parseDate value="${paramVO.resveEdate}" var="edateFmt" pattern="yyyy-MM-dd"/>
	<div class="col-md-12"> 기간 : <fmt:formatDate value="${sdateFmt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${edateFmt}" pattern="yyyy년 MM월 dd일"/> </div>
</div>

<!-- boardView -->
<div class="bdList" style="overflow-x:auto;">
	<table class="table table-bordered">
		<thead>
			<tr>
				<th scope="row" colspan="2" style="width: 200px;">장비명</th>
				<c:forEach var="result" items="${dateList}" varStatus="status">
				<fmt:parseDate value="${result.genDate}" var="dateFmt" pattern="yyyyMMdd"/>
				<th scope="row" ><fmt:formatDate value="${dateFmt}" pattern="MM월dd일"/></th>
				</c:forEach>
				<th scope="row" >합계</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="eqpmnSn"></c:set>
		<c:set var="hour">0</c:set>
		<c:set var="wait">0</c:set>
		<c:set var="complete">0</c:set>
		<c:set var="cancle">0</c:set>
		<c:set var="tdStyle"></c:set>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${eqpmnSn != result.eqpmnSn }">
				<c:set var="eqpmnSn">${result.eqpmnSn }</c:set>
				<c:if test="${status.count != 1 }">
				<td class="tac" style="font-weight: bold;">
					${hour }
					<hr>
					${wait }
					<hr>
					${complete }
					<hr>
					${cancle }
				</td>
				<c:set var="hour">0</c:set>
				<c:set var="wait">0</c:set>
				<c:set var="complete">0</c:set>
				<c:set var="cancle">0</c:set>
				</c:if>
			</tr>
			<tr>
				<th style="vertical-align: middle;">
					<div style="min-width: 70px;" >${result.eqpmnNm }</div>
				</th>
				<th>
					이용시간(H)
					<hr style="min-width:65px!important;">
					승인대기
					<hr style="min-width:65px!important;">
					예약완료
					<hr style="min-width:65px!important;">
					예약취소
				</th>
			</c:if>
				<c:set var="hour">${hour+result.resveHour }</c:set>
				<c:set var="wait">${wait+result.resveWait }</c:set>
				<c:set var="complete">${complete+result.resveComplete }</c:set>
				<c:set var="cancle">${cancle+result.resveCancle }</c:set>
				<td class="tac">
					<c:if test="${result.resveHour != 0 }">
						<c:set var="tdStyle">style="color:red;font-weight: bold;"</c:set>
					</c:if>
					<strong ${tdStyle }>${result.resveHour }</strong>
					<c:set var="tdStyle"></c:set>
					<c:if test="${result.resveWait != 0 }">
						<c:set var="tdStyle">style="color:red;font-weight: bold;"</c:set>
					</c:if>
					<hr>
					<strong ${tdStyle }>${result.resveWait }</strong>
					<c:set var="tdStyle"></c:set>
					<c:if test="${result.resveComplete != 0 }">
						<c:set var="tdStyle">style="color:red;font-weight: bold;"</c:set>
					</c:if>
					<hr>
					<strong ${tdStyle }>${result.resveComplete }</strong>
					<c:set var="tdStyle"></c:set>
					<c:if test="${result.resveCancle != 0 }">
						<c:set var="tdStyle">style="color:red;font-weight: bold;"</c:set>
					</c:if>
					<hr>
					<strong ${tdStyle }>${result.resveCancle }</strong>
					<c:set var="tdStyle"></c:set>
				</td>
			<c:if test="${status.count == fn:length(resultList) }">
				<td class="tac" style="font-weight: bold;">
					${hour }
					<hr>
					${wait }
					<hr>
					${complete }
					<hr>
					${cancle }
				</td>
				<c:set var="hour">0</c:set>
				<c:set var="wait">0</c:set>
				<c:set var="complete">0</c:set>
				<c:set var="cancle">0</c:set>
			</tr>
			</c:if>
		</c:forEach>
		</tbody>
	</table>
</div>
<!-- //boardView -->
</form>
