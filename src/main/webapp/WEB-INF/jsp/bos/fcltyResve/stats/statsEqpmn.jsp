<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
//<![CDATA[
$(function() {

	$('#tbList').rowspan(0,"총계");

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
		$("#statsForm").attr("action","/bos/fcltyResve/stats/downloadExcelStatsEqpmn.xls");
		$("#statsForm").submit();
		$("#statsForm").attr("action","/bos/fcltyResve/stats/statsEqpmn.do");

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
<form name="statsForm" id="statsForm" method="get" action="/bos/fcltyResve/stats/statsEqpmn.do">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<div class="sh form-inline pr10">
	<fieldset>
		<legend>시설예약 통계(장비)</legend>
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
						<th scope="row" >장비</th>
						<td>
							<select name="eqpmnSn" id="eqpmnSn" title="장비구분을 선택해 주세요.">
								<option value="">장비구분 선택</option>
								<c:forEach var="item" items="${listEqpmnNm }">
									<option value="<c:out value="${item.eqpmnSn }" />" <c:if test="${item.eqpmnSn eq param.eqpmnSn }">selected="selected"</c:if>><c:out value="${item.eqpmnNm }" /></option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" >예약일자</th>
						<td><input type="text" id="resveSdate" name="resveSdate"  class="sdate" title="예약일자 시작일 입력" style="width:130px" value="<c:out value="${paramVO.resveSdate }" />" readonly="readonly" />
							~
							<input type="text" id="resveEdate" name="resveEdate"  class="edate" title="예약일자 종료일 입력" style="width:130px" value="<c:out value="${paramVO.resveEdate }" />" readonly="readonly" />

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
</form>
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
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="row"  rowspan="2">장비구분</th>
				<th scope="row"  colspan="6">승인상태</th>
				<th scope="row"  colspan="4">사용여부</th>
			</tr>
			<tr>
				<th scope="row" >승인대기</th>
				<th scope="row" >승인완료</th>
				<th scope="row" >승인불가</th>
				<th scope="row" >대기예약</th>
				<th scope="row" >예약취소</th>
				<th scope="row" >계</th>
				<th scope="row" >사용</th>
				<th scope="row" >미사용</th>
				<th scope="row" >대기</th>
				<th scope="row" >계</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td scope="row"><c:out value="${result.eqpmnNm }" /></td>
				<td><fmt:formatNumber value="${result.sttus01 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus02 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus04 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus03 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus05 }" type="number" /></td>
				<td><strong><fmt:formatNumber value="${result.sttusall }" type="number" /></strong></td>
				<td><fmt:formatNumber value="${result.useYes }" type="number" /></td>
				<td><fmt:formatNumber value="${result.useNo }" type="number" /></td>
				<td><fmt:formatNumber value="${result.useWait }" type="number" /></td>
				<td><strong><fmt:formatNumber value="${result.sttusall }" type="number" /></strong></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

</div>
<!-- //boardView -->

<div class="btn_set"><a class="btn btn-info" href="#self" id="excelBtn"><span>엑셀로 저장</span></a></div>