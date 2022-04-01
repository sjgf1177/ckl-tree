<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<!-- bdList -->

<div class="tar alert formLine1">
	<form action="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo }" class="form-inline" method="post">
		<fieldset>
			<legend><c:out value="${masterVO.bbsNm}" /> 검색 양식</legend>
			<div class="clearfix">
				<select name="searchCnd" id="searchCnd" title="검색 구분을 선택해 주세요.">
					<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
					<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
				</select>
				<input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="<c:out value="${paramVO.searchWrd}" />" />
				<input type="submit" id="input2" name="input2" value="검색" class="btn btn-primary" />
				<c:if test="${not empty paramVO.searchWrd }">
					<a href="/${paramVO.siteName }/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
				</c:if>
			</div>
		</fieldset>
	</form>
</div>
<div class="clear">
	<div> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /> </strong> Page </div>
</div>

<div class="bdList">
	<ul class="tableUl">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:url var="url" value="/edumobile/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
		<li><a href="<c:out value='${url}' escapeXml='false'/>" class="db"><span class="title db"><c:out value="${result.nttSj}"/></span>
			<span class="info1">게시일 : <span class="date"><c:out value="${result.frstRegisterPnttm}" /></span></span>
			<span class="info2">조회수 : <span class="count"><c:out value="${result.inqireCo}" /></span></span>
			</a>
		</li>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<li>데이터가 없습니다.</li>
		</c:if>
	</ul>
</div>

<!-- paging -->
<div class="paging">${pageNav}</div>
<!-- //paging -->
<!-- //List -->