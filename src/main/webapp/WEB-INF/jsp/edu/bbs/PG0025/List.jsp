
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<div class="tab_style_1_con">
	<ul class="tab_style_1 three_tab size_24">
		<li><a href="/edu/dream/mainRsltManage/list.do?menuNo=500040"><span>사업소개</span></a></li>
		<li><a href="/edu/dream/pltfomList/list.do?menuNo=500117"><span>플랫폼기관</span></a></li>
		<!-- <li><a href="/edu/dream/mentorManage/list.do?menuNo=500119"><span>멘토라인업</span></a></li> -->
		<li class="active"><a href="/edu/bbs/B0000041/list.do?menuNo=500211" title="현재탭"><span>창의현장</span></a></li>
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

	<div class="col-12 fieldstory_card_wrap">
		<div class="col-12 calc_wrap19">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:choose>
					<c:when test="${status.index%11 eq 0 }">
						<c:set var="colorCode" value="#EB9856"/>
					</c:when>
					<c:when test="${status.index%11 eq 1 }">
						<c:set var="colorCode" value="#34546B"/>
					</c:when>
					<c:when test="${status.index%11 eq 2 }">
						<c:set var="colorCode" value="#87B304"/>
					</c:when>
					<c:when test="${status.index%11 eq 3 }">
						<c:set var="colorCode" value="#648DAB"/>
					</c:when>
					<c:when test="${status.index%11 eq 4 }">
						<c:set var="colorCode" value="#7B8836"/>
					</c:when>
					<c:when test="${status.index%11 eq 5 }">
						<c:set var="colorCode" value="#E8AC2A"/>
					</c:when>
					<c:when test="${status.index%11 eq 6 }">
						<c:set var="colorCode" value="#B99B5D"/>
					</c:when>
					<c:when test="${status.index%11 eq 7 }">
						<c:set var="colorCode" value="#888888"/>
					</c:when>
					<c:when test="${status.index%11 eq 8 }">
						<c:set var="colorCode" value="#7D6857"/>
					</c:when>
					<c:when test="${status.index%11 eq 9 }">
						<c:set var="colorCode" value="#575556"/>
					</c:when>
					<c:when test="${status.index%11 eq 10 }">
						<c:set var="colorCode" value="#EA7F85"/>
					</c:when>
				</c:choose>
				<c:forEach var="code" items="${psitnCodeList }">
					<c:if test="${result.option1 eq code.insttSn }">
						<c:set var="psitnCode" value="${code }" />
					</c:if>
				</c:forEach>
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
			<c:forEach var="fileList" items="${files }">
				<c:if test="${fileList.fileFieldName eq 'main_image' }">
					<c:set var="file" value="${fileList }" />
				</c:if>
			</c:forEach>
			<div class="col-12 col-sm-4 tc fieldstory_list">
				<a href="/<c:out value='${paramVO.siteName }' />/bbs/<c:out value='${paramVO.bbsId}' />/view.do?nttId=<c:out value='${result.nttId}'/><c:out value='${pageQueryString}'  escapeXml='false'/> " class="col-12 show fn fieldstory_card">
					<div class="img_box">
						<c:if test="${not empty file}">
							<img src='/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}'  alt="<c:out value="${result.nttSj }"/>"  />
						</c:if>
					</div>
					<div class="text_box">
						<h5>
							<c:out value="${empty psitnCode.insttNm ? '기획' : psitnCode.insttNm }"/>
						</h5>
						<hr class="h_line5">
						<p class="h_desc5">
							<c:out value="${result.nttSj }" />
						</p>
						<p class="h_date5">
							<c:out value="${result.frstRegisterPnttm }" />
							<c:if test="${not empty result.option2Nm}">
								<span class="fr fs13 tar"><span class="icoSm icoStory"></span> <c:out value="${result.option2Nm }"  escapeXml="false" /></span>
							</c:if>
						</p>
					</div>
				</a>
			</div>
			<c:remove var="file" scope="page" />
			<c:remove var="psitnCode" scope="page"/>
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
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>