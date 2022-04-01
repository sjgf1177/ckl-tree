<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />



<link href="/bos/css/board.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript">

	function checkForm(form)
	{
		var v = new MiyaValidator(form);
	    v.add("searchType", {
	        required: true
	    });
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}
		else
		{
			return true;
		}
	}

</script>

</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3 class="tit_03">지부</h3>
		</div>

<!-- board list start -->
<form name="frm2" method="post">
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>민원업무 및 담당자를 검색</caption>
			<colgroup>
				<col width="10%" />
				<col width="10%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">지부</th>
					<th scope="col">주소</th>
					<th scope="col">전화</th>
					<th scope="col">팩스</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(resultList) > 0}" >
				<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">
				<tr>
					<td>${fn:length(resultList) - x}</td>
					<td>${resultList[x].brnhName}</td>
					<td>${resultList[x].brnhZip} ${resultList[x].brnhAddr}</td>
					<td>${resultList[x].brnhTel}</td>
					<td>${resultList[x].brnhFax}</td>
				</tr>
				</c:forEach>
				</c:if>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->
</form>

</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>