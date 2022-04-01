
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

	<div class="tab_style_1_con">
		<ul class="tab_style_1">
			<li class="active"><a href="/edu/bbs/B0000074/list.do?menuNo=500193" title="현재탭"><span>주요성과</span></a></li>
			<li><a href="/edu/bbs/B0000075/list.do?menuNo=500194"><span>현장영상</span></a></li>
		</ul>
	</div>


	<div class="col-12 show-table sub_board_header">
		<form action="/<c:out value="${paramVO.siteName }"/>/bbs/${paramVO.bbsId}/list.do" method="post" class="form-inline">
		<input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }"/>">
		<input type="hidden" name="pageQueryString" value='<c:out value="${pageQueryString}"/>' >
			<div class="col-12 show-tablecell fr vm tr board_sorting_con">
				<span class="tl select_box">
					<select name="searchCnd" id="board_sort" class="select_style_0" title="구분을 선택해 주세요">
						<option value="1" <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if>>제목</option>
					</select>
					<!-- <label for="board_sort"></label> -->
				</span>
				<span class="tl input_search_con">
					<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." placeholder="검색어 입력" value="<c:out value='${paramVO.searchWrd}'/>" />
					<input type="submit" id="input2" name="input2" value="" class="search_summit btn-primary" title="검색" />
				</span>
				<c:if test="${not empty paramVO.searchWrd }">
					<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
				</c:if>
			</div>
		</form>
	</div>

	<div class="col-12 sub_board_body">		
		<table class="board_type_0">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="8%">
				<col width="17%">
				<col width="50%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">매체명</th>
					<th scope="col">제목</th>
					<th scope="col">보도일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
						<td style="color:#828282; text-align:center;"><c:out value="${result.option11}"/></td>
						<td class="tal" style="text-align:left; color:#313131;">
							<a href="${result.option12}" target="_blank" title="새창열림">
								<c:out value="${result.nttSj }" />
							</a>
						</td>
						<td><c:out value="${result.ntceBgnde }" /></td>
					</tr>
					
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
			</tbody>
	
		</table>
	</div>	

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->



<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>