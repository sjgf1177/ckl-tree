
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
	<div class="col-12 contents_impect_edu_course_header">
		<img src="/edu/images/bm/contents_impect_edu_course_00.png"/>
	</div>
	<!-- bdList -->
	<div class="col-12 show-table sub_board_header control_board_header">
		
		<div class="col-5 show-tablecell fn vm board_title">
			<h4>총 <span class="board_count"><c:out value="${resultCnt }" />개</span>의 게시글 등록</h4>
		</div>
		<div class="col-7 show-tablecell fn vm tr board_sorting_con">
			<form action="/<c:out value="${paramVO.siteName }"/>/bbs/${paramVO.bbsId}/list.do" class="form-inline" method="post">
				<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" /> <input type="hidden" name="pageQueryString" value="<c:out value="${pageQueryString }" />" /> <input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />" />
				<fieldset>
					<legend></legend>
					<span class="tl select_box">
						<select class="select_style_0" name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
							<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
							<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
						</select>
						<label for="searchCnd"></label>
					</span>
					<span class="tl input_search_con">
						<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd }" />
						<input type="submit" class="search_summit" id="input2" name="input2" value="" class="btn btn-primary" />
					</span>
					<c:if test="${not empty paramVO.searchWrd }">
						<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
					</c:if>
				</fieldset>
			</form>
		</div>
	</div>

	<div class="col-12 sub_board_body">		
		<table class="board_type_0" summary="리스트형 게시판">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
				<col width="100%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">제목</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td class="tal" style="padding-left:20px;">
							<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
							<a href="<c:out value='${url}' escapeXml='false'/>">
								<c:choose>
									<c:when test="${result.delcode ne SearchVO.NON_DELETION}">
										<span class="del"><c:out value='${result.nttSj}' /></span>
									</c:when>
									<c:otherwise>
										<c:out value='${result.nttSj}' />
									</c:otherwise>
								</c:choose> ${result.newYn=='Y'?'[new]':''}
							</a>
						</td>
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

.contents_impect_edu_course_header > img{
	display:inline-block;
	margin-bottom:30px;
	width:100%;
	height:auto;
	}

@media (max-width: 768px){
	.contents_impect_edu_course_header > img {
		display:none; 
		margin-bottom:0;
	}
}
</style>
