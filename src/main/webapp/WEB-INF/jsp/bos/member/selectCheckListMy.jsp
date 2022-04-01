<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>로그인 복원(경찰가족사랑방)</title>
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
<!--

function fncCheckAll() {

	if($("#checkAll")[0].checked) $(":checkbox").attr("checked", true);
	else $(":checkbox").attr("checked", false);
}

function fncManageChecked() {

	if( $(":checkbox:checked").length == 0 ){
        alert("선택된 사용자가 없습니다.");
        return false;
	}
	return true;
}

function fncAddDeptAuthorInsert() {

    if(!fncManageChecked()) return;

    if(confirm("복원하시겠습니까?")) {
        document.listForm.action = "<c:url value='/bos/member/checkRestoreMy.do'/>";
        document.listForm.submit();
    }
}

//-->
</script>
</head>
<body>

<form method="post" name="listForm" action="<c:url value='/bos/member/checkListMy.do'/>">
	<div id="content">
		<div class="hgroup">
			<h3>로그인 복원(경찰가족사랑방)</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${param.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
				   <option value="4" <c:if test="${param.searchCnd == '4'}">selected="selected"</c:if> >이름</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${param.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
<!-- 게시판 게시물검색 end -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="6%" />
				<col width="17%" />
				<col width="17%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir"><input type="checkbox" id="checkAll" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">소속청</th>
					<th scope="col">소속과</th>
					<th scope="col">소속서</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(resultList) > 0}" >
			<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">
				<tr>
					<td><input type="checkbox" name="checkId" value="<c:out value="${resultList[x].fuserid}"/>"/> </td>
					<td>${fn:replace(resultList[x].fuserid, "@police.go.kr", "")}</td>
					<td>${resultList[x].fnamekr}</td>
					<td>${resultList[x].company}</td>
					<td>${resultList[x].department}</td>
					<td>${resultList[x].gubun}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			</c:if>
			<c:choose>
				<c:when test="${param.flag == 1}"><tr><td colspan="7">검색버튼을 눌러주세요</td></tr></c:when>
				<c:otherwise>
					<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fncAddDeptAuthorInsert()"><span>복원</span></a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
