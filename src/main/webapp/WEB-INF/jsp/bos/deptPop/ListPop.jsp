<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript">
function returnUser(teamName, deptId)
{
	var patName1 = '${param.patName1}';
	var patName2 = '${param.patName2}';

	//관리자 게시판에서 소속과 찾기 했을때랑 안했을때..
	var valGubun = '${param.board}';
	//일반 게시판
	if(patName1 != '' && patName2 != ''){
		window.opener.document.getElementById(patName1).value = teamName;
		window.opener.document.getElementById(patName2).value = deptId;
		window.close();
	}else if(valGubun == 'Y'){
		opener.board.deptName.value = teamName;
		opener.board.deptId.value = deptId;
		window.close();
	//관리자관리
	}else{
		opener.f_regi.teamName.value = teamName;
		opener.f_regi.staffPlace.value = deptId;
		window.close();
	}


}
</script>
<title>부서검색하기</title>
</head>
<body id="wrap_pop">
	<div id="content">
		<div class="hgroup">
			<h3>부서검색</h3>
		</div>

	<form name="frm" action ="/bos/deptPop/list.do?board=${param.board}&amp;patName1=${param.patName1}&amp;patName2=${param.patName2}" method="post">
		<input id="searchCnd" type="hidden" name="searchCnd" value='1' />
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="input1"> 부서검색
					<input id="input1" type="text" class="searchinput" title="검색어입력" style="width:130px" name="searchWrd" value='${param.searchWrd}' />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
		</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->
	</form>

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">부서이름</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(resultList) > 0}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<c:set var="url" value="javascript:returnUser('${result.deptName}','${result.deptId}');" />
						<td>${resultCnt - zvl.pageSize * (zvl.pageIndex-1)}</td>
		                <td class="tal">
							<a href="${url}">${result.deptName}</a>
						</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(resultList) == 0}">
				<tr><td colspan="6">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
		</table>
	</div>
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>