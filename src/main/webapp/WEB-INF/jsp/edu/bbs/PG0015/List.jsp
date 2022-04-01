<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="kocca" uri="http://edu.kocca.kr/fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<!-- bdList -->
<div class="col-12 show-table sub_board_header control_board_header">
	<div class="col-4 show-tablecell fn vm board_title">
		<h4>총 <span class="board_count"><c:out value="${resultCnt }" />개</span>의 게시글 등록</h4>
	</div>
	<div class="col-8 show-tablecell fn vm tr board_sorting_con">
		<form id="frm" name="frm" action ="/edu/bbs/${paramVO.bbsId}/list.do?menuNo=${paramVO.menuNo}" method="post" class="form-inline">
		<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" /> <input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" />" /> 
			<fieldset>
			<legend></legend>
				<span class="tl select_box">
					<select class="select_style_0" name="option1" id="option1" title="질문분류를 선택해 주세요." onchange="">
						<option value="">전체</option>
						<option value="01" <c:if test="${paramVO.option1 eq '01'}">selected="selected"</c:if>>오프라인교육</option>
						<option value="02" <c:if test="${paramVO.option1 eq '02'}">selected="selected"</c:if>>온라인교육</option>
						<option value="03" <c:if test="${paramVO.option1 eq '03'}">selected="selected"</c:if>>교육지원사업</option>
						<%-- <option value="04" <c:if test="${paramVO.option1 eq '04'}">selected="selected"</c:if>>취업정보</option> --%>
						<option value="05" <c:if test="${paramVO.option1 eq '05'}">selected="selected"</c:if>>시설/장비</option>
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
					<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd}" />
					<input type="submit" class="search_summit" title="검색"/>
				</span>
				<c:if test="${not empty paramVO.searchWrd }">
					<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
				</c:if>
			</fieldset>
		</form>
	</div>
</div>

<div class="col-12 sub_board_body">
	<table class="board_type_0">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="auto" class="count_column">
			<col width="auto">
			<col width="auto" class="name_column">
			<col width="auto" class="condition_column">
			<col width="auto" class="write_date_column">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>상태</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
		<tr>
			<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
			<td class="<c:out value="${result.secret eq 'Y' ? 'lock' : ''}"/>">
			<a href="${url}">
				<span>
				<c:choose>
					<c:when test="${result.option1 eq '01'}">현장교육</c:when>
					<c:when test="${result.option1 eq '02'}">온라인교육</c:when>
					<c:when test="${result.option1 eq '03'}">창의인재동반</c:when>
					<c:when test="${result.option1 eq '04'}">취업정보</c:when>
				</c:choose>
				</span>
				${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}
			</a>
			</td>
			<td>${kocca:maskingTag(result.ntcrNm)}</td>
			<td class="<c:out value="${result.replyAt eq 'Y' ? 'complete' : 'incomplete'}"/>"><c:out value="${result.replyAt eq 'Y' ? '완료' : '미완료'}"/></td>
			<td><c:out value="${result.frstRegisterPnttm}"/></td>
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

<div class="board_util_btn_con">
	<a href="/edu/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="btn_style_0 full add">
		글쓰기
	</a>
</div>
<script type="text/javascript">
	/* $(document).ready(function(){
		$('#option1').change(changeOption);
	});

	function changeOption(){
		$('#frm').attr({
			target : '_self'
		}).submit();
	} */
</script>
