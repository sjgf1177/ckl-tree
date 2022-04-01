
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<div class="tab_style_1_con">
	<ul class="tab_style_1 two_tab">
		<li><a href="/edu/main/contents.do?menuNo=500213"><span>소개</span></a></li>
		<li class="active"><a href="/edu/bbs/B0000073/list.do?menuNo=500214" title="현재탭"><span>교육과정</span></a></li>
	</ul>
</div>
	<div class="col-12 contents_impect_edu_course_header">
		<img src="/edu/images/edupro/500191_banner.jpg" alt="콘텐츠임팩트 배너이미지1"/>
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
						<!-- <label for="searchCnd"></label> -->
					</span>
					<span class="tl input_search_con">
						<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd }" />
						<input type="submit" class="search_summit btn btn-primary" id="input2" name="input2" value="" title="검색" />
					</span>
					<c:if test="${not empty paramVO.searchWrd }">
						<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
					</c:if>
				</fieldset>
			</form>
		</div>
	</div>

	<div class="col-12 contents_card_list">
		<div class="over-hidden calc_wrap19">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<div class="col-12 col-md-6 contents_card_con">
					<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
					<a href="<c:out value='${url}' escapeXml='false'/>" class="contents_crad_wrap">
						<div style="display: inline-block; vertical-align:middle; margin-right:10px; width:90px; height:120px; line-height:120px;">
							<img src='/edu/images/edupro/500187_thumb.png' style="width: 100%;height: auto;"  alt="<c:out value="${result.nttSj }"/>"  />
						</div>
						<div class="contents_text_wrap" style="">
							<h6>
								<c:out value='${result.nttSj}' />
							</h6>
							<ul>
								<li><c:out value="${result.frstRegisterPnttm }" /></li>
							</ul>
						</div>
					</a>
				</div>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<div class="col-12 col-sm-12 tc fieldstory_list">
					<a href="/<c:out value='${paramVO.siteName }' />/bbs/<c:out value='${paramVO.bbsId}' />/view.do?nttId=<c:out value='${result.nttId}'/>&amp;<c:out value='${pageQueryString}'  escapeXml='false'/> " class="col-12 show fn fieldstory_card">
						<div class="text_box">
							<h5>
								데이터가 없습니다.
							</h5>
						</div>
					</a>
				</div>
			</c:if>
		</div>
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
