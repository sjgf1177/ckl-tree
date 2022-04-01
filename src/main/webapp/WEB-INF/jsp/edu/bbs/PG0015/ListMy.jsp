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
					<select name="searchCnd" class="select_style_0" id="searchCnd" title="구분을 선택해 주세요.">
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
		<col style="width:8%;" />
		<col style="width:10%;" />
		<col style="width:8%;" />
		<col style="width:8%;" />
		<col  />
		<col style="width:10%;" />
		<col style="width:12%;" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>질문분류</th>
				<th>공개여부</th>
				<th>상태</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;myAt=Y&${pageQueryString}" />
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>
						<c:choose>
							<c:when test="${result.option1 eq '01'}">현장교육</c:when>
							<c:when test="${result.option1 eq '02'}">온라인교육</c:when>
							<c:when test="${result.option1 eq '03'}">창의인재동반</c:when>
							<c:when test="${result.option1 eq '04'}">취업정보</c:when>
						</c:choose>
					</td>
					<td><c:out value="${result.secret eq 'Y' ? '비공개' : '공개'}"/></td>
					<td><c:out value="${result.replyAt eq 'Y' ? '완료' : '미완료'}"/></td>
					<td class="tal">
						<a href="${url}"><c:out value="${result.nttSj}"/></a>
					</td>
					<td><c:out value="${result.ntcrNm}"/></td>
					<td class="brn"><c:out value="${result.frstRegisterPnttm}"/></td>
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