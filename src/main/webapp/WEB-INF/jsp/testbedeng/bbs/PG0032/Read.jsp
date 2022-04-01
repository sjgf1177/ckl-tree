
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<table class="contents_insight_view" summary="notice board view">
	<caption>오프라인 콘텐츠 뷰 페이지</caption>
	<colgroup>
		<col width="20%">
		<col width="auto">
		<col width="20%">
		<col width="auto">
	</colgroup>
	<tbody>
		<tr>
			<th>업체명</th>
			<td colspan="3"><c:out  value="${result.nttSj }" escapeXml="false"/></td>
		</tr>
	<tr>
		<th>콘텐츠분류</th>
		<td colspan="3"><c:out value="${result.option1}" /></td>
	</tr>
	<tr>
		<th>대표자</th>
		<td><c:out value="${result.option2}" /></td>
		<th>설립일</th>
		<td><c:out value="${result.ntceBgnde}" /></td>
	</tr>
	<tr>
		<th>사업내용</th>
		<td colspan="3">
			<c:choose>
				<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
				<c:otherwise>
					<% pageContext.setAttribute("crlf", "\n"); %>
					${fn:replace(result.nttCn, crlf, "<br/>")}
				</c:otherwise>
			</c:choose>

			<!-- 본문이미지 대체텍스트 -->
			<!-- <div class="hidden">${result.imgDescCn}</div> -->
		</td>
	</tr>
	</tbody>
</table>
<!--내용-->
<div class="insight_view_contents">
	<h5>관련 이미지</h5>
	<c:if test="${not empty fileList}">
	<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<c:if test="${fn:indexOf(fileVO.fileFieldName, 'sub_image') != -1 }">
			<c:if test="${status.index%2 == 1}">
				<br>
			</c:if> 
			<!-- 내용이미지 이미지 -->
			<img alt="${result.nttSj } 기업 소개 이미지" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
		</c:if>
	</c:forEach>
	</c:if>
</div>
<hr class="contents_insight_line">
<!--//내용-->
	<!-- bdView -->
<%-- <table class="board_type_0 detail notice" summary="notice board view">
	<caption>이벤트 게시판 뷰 페이지</caption>
	<colgroup>
		<col width="100%">
	</colgroup>
	<thead>
	<tr>
		<th>
			<span>
				<c:out  value="${result.nttSj }" escapeXml="false"/>
			</span>
			<span class="writer_info">
				<span>
					Hit.<c:out value="${result.inqireCo}"></c:out>
				</span>
				<span>
					<c:out value="${result.frstRegisterPnttm}" escapeXml="false" />
				</span>
			</span>
		</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>
			<div class="table_info_header">
				<div class="view_info">
					<p>설립일 : <span><c:out value="${result.ntceBgnde}" /></span></p>
					<p>콘텐츠분류 : <span><c:out value="${result.option1}" /></span></p>
					<p>대표자 : <span><c:out value="${result.option2}" /></span></p>
				</div>
			</div>
			<div class="contents_view_area">
				<c:choose>
					<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
					<c:otherwise>
						<% pageContext.setAttribute("crlf", "\n"); %>
						${fn:replace(result.nttCn, crlf, "<br/>")}
					</c:otherwise>
				</c:choose>

				<!-- 본문이미지 대체텍스트 -->
				<!-- <div class="hidden">${result.imgDescCn}</div> -->
			</div>
			<div>
				<h5>관련 이미지</h5>
				<c:if test="${not empty fileList}">
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<c:if test="${status.index%2 == 1}">
						<br>
					</c:if>
					<img alt="${result.nttSj } 기업 소개 이미지" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
				</c:forEach>
				</c:if>
			</div>
		</td>
	</tr>
	</tbody>
</table> --%>
<div class="paging view_paging">
	<ul class="pagination">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
			<li class="btn_singlePage prev">
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['PREV'].nttSj }" />
					${prevNextMap['PREV'].nttSj }
				</a>
			</li>
		</c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
			<li class="btn_singlePage next">
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['NEXT'].nttSj }" />
					${prevNextMap['NEXT'].nttSj }
				</a>
			</li>
		</c:if>
	</ul>
</div>
<div class="board_util_btn_con">
	<c:url var="url" value="/${paramVO.siteName}/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
	<a class="btn_style_0 full list" href="<c:out value='${url}' escapeXml='false'/>">
		목록
	</a>
</div>
