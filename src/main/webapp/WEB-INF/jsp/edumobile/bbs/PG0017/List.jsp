
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>



<!--content-->

	<!-- bdList -->
	<div class="col-12 show-table sub_board_header control_board_header">
		<div class="col-5 show-tablecell fn vm board_title">
			<h4>총 <span class="board_count"><c:out value="${resultCnt }" />개</span>의 게시글 등록</h4>
		</div>
		<div class="col-7 show-tablecell fn vm tr board_sorting_con">
			<form action="/<c:out value="${paramVO.siteName }"/>/bbs/${paramVO.bbsId}/list.do" class="form-inline" method="post">
				<input type="hidden" name="menuNo" value="${param.menuNo }" >
				<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
				<input type="hidden" name="pageQueryString" value="<c:out value='${pageQueryString}'  escapeXml='false'/>" />
				<span class="tl select_box">
					<select name="searchCnd" id="searchCnd" class="select_style_0" title="검색목록">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
					</select>
					<label for="board_sort"></label>
				</span>
				<span class="tl input_search_con">
					<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." placeholder="검색어 입력" value="${paramVO.searchWrd }" />
					<input type="submit" id="input2" name="input2" value="검색" class="search_summit btn-primary" />
				</span>
				<c:if test="${not empty paramVO.searchWrd }">
					<a href="/edumobile/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
				</c:if>
			</form>
		</div>
	</div>

	<table class="board_type_0">
		<caption><c:out value="${masterVO.bbsNm}" /> 목록</caption>
		<colgroup>
			<col width="auto" class="count_column">
			<col width="auto">
			<col width="auto" class="write_date_column">
			<col width="90px">
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<tr>
			<td><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
			<td>
				<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
				<a href="<c:out value='${url}' escapeXml='false'/>">
					<c:out value='${result.nttSj}' />
				</a>
			</td>
			<td>${result.frstRegisterPnttm}</td>
			<td>${result.inqireCo}</td>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->

	<sec:authorize ifAnyGranted="ROLE_USER">
		<c:if test="${userVO.mentoYn eq 'Y' }">
			<div class="board_util_btn_con">
				<a href="/edumobile/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="btn_style_0 full add btn-primary">글쓰기</a>
			</div>
		</c:if>
	</sec:authorize>

