<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.member.service.UserMemberService" var="UserMemberService"/>

<!DOCTYPE html>
<html lang="ko">
<head>
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
<!--
function checkForm(form) {
	var v = new MiyaValidator(form);
    v.add("searchType", {
        required: true
    });
    v.add("searchTxt", {
        required: true
    });
	var result = v.validate();
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

//-->
</script>
</head>
<body>

<form method="post" name="frm" action="/bos/user/member/list.do?programId=userMember">
	<div id="content">
		<div class="hgroup">
			<h3>회원관리</h3>
		</div>

		<!-- 게시판 게시물검색 start -->

		<div class="sh">
			<fieldset class="pt10">
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
<!--
	<div class="btn_set">
		<span class="button sky"><a href="javascript:applyAuthor();">권한적용</a></span>
		<span class="button sky"><input type="submit" id="" name="" value="등록" class="input_submit" /></span>
	</div>
 -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="*" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="fir">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">회원구분</th>
					<th scope="col">가입일</th>
					<th scope="col">비밀번호</th>
					<th scope="col">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:url var="url" value="/bos/user/member/forUpdate.do">
					<c:param name="searchType" value="${param.searchType}" ></c:param>
					<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
					<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
					<c:param name="userId" value="${result.userId}" ></c:param>
					<c:param name="programId" value="${param.programId}" ></c:param>
				</c:url>
				<c:url var="pwdUrl" value="/bos/user/member/pwdReset/${result.userId}.do">
					<c:param name="searchType" value="${param.searchType}" ></c:param>
					<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
					<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
					<c:param name="programId" value="${param.programId}" ></c:param>
				</c:url>
				<tr>
					<td>${(resultCnt) - (cmmVO.pageSize * (cmmVO.pageIndex-1))}</td>
					<td class="tal"><a href="${url}">${result.userId}</a></td>
					<td>${result.userName}</td>
					<td>
						<c:choose>
							<c:when test="${result.memberType eq UserMemberService.BASIC_MEMBER_TYPE}">일반회원</c:when>
							<c:when test="${result.memberType eq UserMemberService.COMPANY_MEMBER_TYPE}">기업회원</c:when>
							<c:when test="${result.memberType eq UserMemberService.PARENT_MEMBER_TYPE}">어린이회원</c:when>
							<c:when test="${result.memberType eq UserMemberService.FOREIGN_MEMBER_TYPE}">외국인회원</c:when>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td><a href="${pwdUrl}" >[초기화]</a></td>
					<td>
						${result.delState eq '1' ? '사용' : '미사용'}
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

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
