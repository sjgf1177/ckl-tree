
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

	<div class="stepInline">
		<ul>
			<c:url value="list.do?option1=${code.code }&menuNo=${param.menuNo }" var="url" />
			<li <c:if test="${empty paramVO.option1 }">class="on"</c:if>><a href="<c:out value='${url }'  />">전체</a></li>
			<c:url value=""  var="url"/>
				<c:forEach var="code" items="${COM101CodeList}" varStatus="status">
					<c:url value="list.do?option1=${code.code }&menuNo=${paramVO.menuNo }" var="url" />
					<li <c:if test="${paramVO.option1 eq code.code }">class="on"</c:if>><a href="<c:out value='${url }' />"><c:out value="${code.codeNm}" /></a></li>
					<c:url value=""  var="url"/>
				</c:forEach>
		</ul>
	</div>


<!-- bdList -->
	<div class="alert formLine1">
		<form action="/<c:out value="${paramVO.siteName }"/>/bbs/${paramVO.bbsId}/list.do" class="form-inline" method="post">
			<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" /> <input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" />" /> <input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />" />
			<fieldset>
				<legend></legend>
				<div class="clearfix">
					<select name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
					</select> <input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd }" /> 
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-primary" title="검색" />
					<c:if test="${not empty paramVO.searchWrd }">
						<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
					</c:if>
				</div>
			</fieldset>
		</form>
	</div>

<!--content-->



	<div class="row mt10 mb5">
		<div class="col-md-12">
			총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /></strong> Page
		</div>
	</div>

	<div class="bdList">
		<table class="table">
			<caption>취업가이드 목록</caption>
			<colgroup>
				<col style="width: 8%;" />
				<col />
				<col style="width: 10%;" />
				<col style="width: 8%;" />
			</colgroup>
			<thead>

					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.nttType=='1' ? '공지' : (resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
						<td class="tal">
						<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}"  />
							<a href="<c:out value='${url}' escapeXml='false'/>">
							<c:out value='${result.nttSj}' />
						</a>
						</td>
						<td><c:out value="${result.frstRegisterPnttm}" /></td>
						<td class="brn"><c:out value="${result.inqireCo}" /></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
	</c:if>
	<!-- //paging -->

