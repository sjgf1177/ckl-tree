<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<base target="_self">
<title>회원관리</title>
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
function selectDept(deptCode, deptNm)
{
	opener.setAuthoValue(deptCode, deptNm, '${param.idx}');
	self.close();
}
function returnUser(deptId, userId, userName)
{
	var retVal   = new Object();
	retVal.deptId = deptId;
	retVal.userId  = userId;
	retVal.userName  = userName;
	window.returnValue = retVal;
	window.close();
}

function checkForm(form)
{
	if(!form.searchKeyword.value)
	{
		alert("부서명을 입력하세요.");
		form.searchKeyword.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body>

<form method="post" name="frm" action="/bos/member/listPop">
	<input type="hidden" name="viewType" value="Pop" />
	<div id="content">
		<div class="hgroup">
			<h3>회원관리</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<select id="larCd" name="larCd" title="소속청선택" style="width:150px">
				   <option value=''>--소속청선택</option>
					<c:forEach var="data" items="${larCdList}" varStatus="status">
					<option value="${data.larCd}" <c:if test="${data.larCd eq param.larCd}">selected="selected"</c:if>>${data.larNm}</option>
					</c:forEach>
				</select>
				<select id="midCd" name="midCd" title="소속서선택" style="width:150px">
				   <option value=''>--소속서선택</option>
					<c:forEach var="data" items="${midCdList}" varStatus="status">
					<option value="${data.midCd}" <c:if test="${data.midCd eq param.midCd}">selected="selected"</c:if>>${data.midNm}</option>
					</c:forEach>
				</select>
				<select id="smCd" name="smCd" title="소속과선택" style="width:150px">
				   <option value=''>--소속과선택</option>
					<c:forEach var="sm" items="${smCdList}" varStatus="status">
					<option value="${sm.smCd}" <c:if test="${sm.smCd eq param.smCd}">selected="selected"</c:if>>${sm.smNm}</option>
					</c:forEach>
				</select>
			</fieldset>
		</div>
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<span class="search_tit"><label for="authorCode" class="blind">권한</label></span>
				<select id="authorCode" name="authorCode" title="검색조건">
					<option value="">권한선택</option>
				<c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
					<option value="${authorManage.authorCode}" <c:if test="${param.authorCode == authorManage.authorCode}">selected="selected"</c:if>>${authorManage.authorNm}</option>
				</c:forEach>
				</select>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="0" <c:if test="${param.searchCnd == '0'}">selected="selected"</c:if> >아이디</option>
				   <option value="1" <c:if test="${param.searchCnd == '1'}">selected="selected"</c:if> >이름</option>
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
				<col width="8%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">권한</th>
					<th scope="col">부서명</th>
					<th scope="col">발급일</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(resultList) > 0}" >
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:set var="deptId" value="${result.larCd}${result.midCd}${result.smCd}" />
				<tr>
					<td>${resultCnt - zvl.pageSize * (zvl.pageIndex-1)}</td>
					<td class="tal">
				<c:set var="url" value="javascript:returnUser('${deptId}', '${result.aid}', '${result.adnm}');" />
				<a href="${url}">${result.aid}</a>
					</td>
					<td><a href="${url}">${result.adnm}</a></td>
					<td><a href="${url}">${result.authorNm}</a></td>
					<td><a href="${url}">${result.smNm}</a></td>
					<td>${result.upDate}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			</c:if>
			<c:choose>
				<c:when test="${param.flag == 1}"><tr><td colspan="7">검색버튼을 눌러주세요</td></tr></c:when>
				<c:otherwise>
					<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:self.close();"><span>닫기</span></a>
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
