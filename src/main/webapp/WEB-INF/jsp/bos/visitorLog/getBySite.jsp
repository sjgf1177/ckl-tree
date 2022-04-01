
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>

<script type="text/javascript" src="/js/miya_validator.js"></script>

<script type="text/javascript">
$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});

function search() {
	var form = $("#frm")[0];
	var v = new MiyaValidator(form);
    v.add("sdate", {
        required: true
    });
    v.add("edate", {
        required: true
    });
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	form.submit();
}
</script>

<title>${masterVO.bbsNm}</title>
</head>
<body>
<form id="frm" name="frm" action ="/bos/visitorLog/getBySite" method="post">
	<div id="content">

		<div class="hgroup">
			<h3>${masterVO.bbsNm}</h3>
			<a class="btn btn-success" href="/bos/forprint.jsp" id="print" title="새창" onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i> <i class="fa fa-hover fa-print"></i> <span>인쇄하기</span></a>
		</div>

		<table class="t_result_search">
 			<colgroup>
				<col width="13%" />
				<col width="*" />
				<col width="20%" />
				<col width="13%" />
				<col width="13%" />
				<col width="14%" />
			</colgroup>
			<tr>
				<th class="th_freak01">검색조건</th>
				<td colspan="5" class="th_freak02">
				<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />
					<a href="javascript:search();" class="btn btn-seach">검색</a>
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<td>
					<c:if test="${not empty param.sdate and not empty param.edate}">
					${param.sdate} ~ ${param.edate}
					</c:if>
				</td>
				<th>총방문자수</th>
				<td>${totCnt}</td>
			</tr>
		</table>

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="40%" />
				<col width="30%" />
				<col width="30%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">사이트</th>
					<th scope="col">방문자수</th>
					<th scope="col">비율</th>

				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${result.siteDesc}</td>
					<td class="output">${result.cnt}(<fmt:formatNumber value="${result.avrByDay}" pattern="0.00"/>)</td>
					<td class="output"><fmt:formatNumber type="percent" maxIntegerDigits="3" value="${result.avrByTotCnt}" /></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->
</div>

</form>
<c:catch var ="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>