<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
		$("#statsForm").attr("action","/bos/fcltyResve/stats/downloadExcelStatsVisit.xls");
		$("#statsForm").submit();
		$("#statsForm").attr("action","/bos/fcltyResve/stats/statsVisit.do");

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
<form name="statsForm" id="statsForm" method="get" action="/bos/fcltyResve/stats/statsVisit.do">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<div class="sh form-inline pr10">
	<fieldset>
		<legend>시설예약 통계(열린공간 방문) 검색</legend>
		<div class="shView">
			<table class="table">
				<caption>
				</caption>
				<colgroup>
				<col />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >기간</th>
						<td><input type="text" id="resveSdate" name="resveSdate"  class="sdate" title="시작일 입력" style="width:130px" value="<c:out value="${paramVO.resveSdate }" />" readonly="readonly" />
							~
							<input type="text" id="resveEdate" name="resveEdate"  class="edate" title="종료일 입력" style="width:130px" value="<c:out value="${paramVO.resveEdate }" />" readonly="readonly" />

							<a class="btn btn-default" href="#self" id="term01Btn"><span>1개월</span></a>
							<a class="btn btn-default" href="#self" id="term03Btn"><span>3개월</span></a>
							<a class="btn btn-default" href="#self" id="term06Btn"><span>6개월</span></a>
							<a class="btn btn-default" href="#self" id="term12Btn"><span>12개월</span></a>

						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</div>
<!-- //게시판 게시물검색 -->
<div class="row clear mt20 tac">
	<div class="col-md-12"><input type="submit" class="btn btn-primary" value="확인" /></div>
</div>

<div class="row mt10 mb5">
	<fmt:parseDate value="${paramVO.resveSdate}" var="sdateFmt" pattern="yyyy-MM-dd"/>
	<fmt:parseDate value="${paramVO.resveEdate}" var="edateFmt" pattern="yyyy-MM-dd"/>
	<div class="col-md-12"> 기간 : <fmt:formatDate value="${sdateFmt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${edateFmt}" pattern="yyyy년 MM월 dd일"/> </div>
</div>

<!-- boardView -->
<div class="bdList">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col style="width:30%" />
		<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >공간명</th>
				<th scope="row" >계</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<th>
					<c:out value="${result.visitIp }" />
					<c:choose>
						<c:when test="${result.visitIp eq '127.0.0.2' }">(2층)</c:when>
						<c:when test="${result.visitIp eq '127.0.0.10' }">(10층)</c:when>
						<c:when test="${result.visitIp eq '127.0.0.14' }">(14층)</c:when>
						<c:when test="${result.visitIp eq '총계' }"></c:when>
						<c:otherwise>(기타)</c:otherwise>
					</c:choose>
				</th>
				<td class="tac"><strong><c:out value="${result.visitCount }" /></strong></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<!-- //boardView -->
</form>
<div class="btn_set"><a class="btn btn-info" href="#self" id="excelBtn"><span>엑셀로 저장</span></a></div>