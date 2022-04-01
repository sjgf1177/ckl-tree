
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	java.util.Calendar c = java.util.Calendar.getInstance();
	int year = c.get(java.util.Calendar.YEAR);
	pageContext.setAttribute("year", year);
%>
<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />



<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>

<script type="text/javascript">

function search() {
	var form = $("#frm")[0];
	var v = new MiyaValidator(form);
    v.add("syear", {
        required: true
    });
    v.add("smonth", {
        required: true
    });
    v.add("eyear", {
        required: true
    });
    v.add("emonth", {
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
<form id="frm" name="frm" action ="/bos/visitorLog/getByMonth" method="post">
	<input type="hidden" name="vlSiteId" value="${param.vlSiteId}" />
	<input type="hidden" name="sdate" value="${param.sdate}" />
	<input type="hidden" name="edate" value="${param.edate}" />
	<div id="content">

		<div class="hgroup">
			<h3>${masterVO.bbsNm}</h3>
			<a class="btn btn-success" href="/bos/forprint.jsp" id="print" title="새창" onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i> <span>인쇄하기</span></a>
		</div>

<ul class="tab_list">
	<!--현재 페이지일 경우 class="on" -->
	<li ><a href="/bos/visitorLog/getByDay?vlSiteId=${param.vlSiteId}&sdate=${param.sdate}&edate=${param.edate}"><span>일별</span></a></li>
	<li class="on"><a href="/bos/visitorLog/getByMonth?vlSiteId=${param.vlSiteId}&sdate=${param.sdate}&edate=${param.edate}"><span>월별</span></a></li>
	<li ><a href="/bos/visitorLog/getByMenu?vlSiteId=${param.vlSiteId}&sdate=${param.sdate}&edate=${param.edate}"><span>메뉴별</span></a></li>
</ul>

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
					<select id="syear" name="syear" title="검색조건">
					   <option selected="selected" value''>--년도선택</option>
					<c:forEach var="i" begin="2013" end="${year}">
						<option value="${i}" <c:if test="${param.syear eq i}">selected="selected"</c:if>>${i}</option>
					</c:forEach>
					</select>
					<select id="smonth" name="smonth" title="검색조건">
					   <option value=''>--월선택</option>
					<c:forEach var="i" begin="1" end="12">
						<c:set var="m"><util:fillZero source='${i}' resultLen='2' isFront='true' /></c:set>
						<option value="${m}" <c:if test="${param.smonth eq m}">selected="selected"</c:if>>${i}</option>
					</c:forEach>
					</select>	~
					<select id="eyear" name="eyear" title="검색조건">
					   <option selected="selected" value''>--년도선택</option>
					<c:forEach var="i" begin="2013" end="${year}">
						<option value="${i}" <c:if test="${param.eyear eq i}">selected="selected"</c:if>>${i}</option>
					</c:forEach>
					</select>
					<select id="emonth" name="emonth" title="검색조건">
					   <option value=''>--월선택</option>
					<c:forEach var="i" begin="1" end="12">
						<c:set var="m"><util:fillZero source='${i}' resultLen='2' isFront='true' /></c:set>
						<option value="${m}" <c:if test="${param.emonth eq m}">selected="selected"</c:if>>${i}</option>
					</c:forEach>
					</select>
					<a href="javascript:search();" class="btn btn-seach">검색</a>
				</td>
			</tr>
			<tr>
				<th>기간</th>
				<td>
					<c:if test="${not empty param.syear}">
					${param.syear}년${param.smonth}월 ~ ${param.eyear}년${param.emonth}월
					</c:if>
				</td>
				<th>총방문자수</th>
				<td>${totCnt}</td>
				<th>월평균</th>
				<td><fmt:formatNumber pattern="#.##" value="${avrTotalByDay}" /></td>
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
					<th scope="col">기간</th>
					<th scope="col">방문자수</th>
					<th scope="col">비율</th>

				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${result.year}-${result.month}</td>
					<td class="output">${result.cnt}</td>
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