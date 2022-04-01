<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>


<div class="col-12 show-table sub_board_header control_board_header">
	<div class="col-4 show-tablecell fn vm board_title">
	    <h4>총 <span class="board_count"><c:out value="${resultCnt }" /></span>건의 검색 결과가 있습니다.</h4>
    </div>
    <div class="col-8 show-tablecell fn vm tr board_sorting_con">
	   	<form id="frm" name="frm" action ="/edu/bbs/${paramVO.bbsId}/listMy.do?menuNo=${paramVO.menuNo}" method="post" class="form-inline">
			<fieldset>
				<legend></legend>
				<span class="tl select_box">
					<select class="select_style_0" name="option2" id="option2" title="질문분류를 선택해 주세요." onchange="">
						<option value="">전체</option>
						<option value="03" <c:if test="${paramVO.option2 eq '03'}">selected="selected"</c:if>>불편사항 접수</option>
						<option value="02" <c:if test="${paramVO.option2 eq '02'}">selected="selected"</c:if>>참여하기</option>
						<option value="01" <c:if test="${paramVO.option2 eq '01'}">selected="selected"</c:if>>건의하기</option>
					</select>
				</span>
				<span class="tl select_box">
					<select class="select_style_0" name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
						<option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
					</select>
				</span>
				<span class="tl input_search_con">
					<input type="text" name="searchWrd" class="board_search" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd}" />
					<input type="submit" value="" class="search_summit" title="검색"/>
				</span>
			</fieldset>
		</form>
	</div>
</div>
<div class="col-12 sub_board_body">
	<table class="board_type_0">
		<caption>나의문의내역 목록</caption>
		<colgroup>
		<col width="auto" class="count_column">
		<col width="auto" class="name_column">
		<col width="auto">
		<col width="auto" class="write_date_column">
		<col width="auto" class="condition_column">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성일</th>
				<th>진행상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;myAt=Y&${pageQueryString}" />
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>
						<c:choose>
							<c:when test="${result.option2 eq '03'}">불편사항 접수</c:when>
							<c:when test="${result.option2 eq '02'}">참여하기</c:when>
							<c:when test="${result.option2 eq '01'}">건의하기</c:when>
						</c:choose>
					</td>
					<td class="tal">
						<a href="${url}"><c:out value="${result.nttSj}"/></a>
					</td>
					<td class="brn"><c:out value="${result.frstRegisterPnttm}"/></td>
					<td class="<c:out value="${result.replyAt eq 'Y' ? 'complete' : 'incomplete'}"/>"><c:out value="${result.replyAt eq 'Y' ? '답변완료' : '대기'}"/></td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>


<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>

<%-- <div class="board_util_btn_con">
	<a href="/edu/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="btn_style_0 full add">
		글쓰기
	</a>
</div> --%>