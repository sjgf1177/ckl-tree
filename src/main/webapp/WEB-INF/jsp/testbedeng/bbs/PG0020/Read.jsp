
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

	<!-- bdView -->
<table class="board_type_0 detail notice" summary="notice board view">
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
					<p>이벤트 기간 : <span><c:out value="${result.ntceBgnde}" />~<c:out value="${result.ntceEndde}" /></span></p>
					<c:if test="${not empty result.option1 and result.option1 ne '' }">
						<a href="<c:out value="http://${result.option1 }" />"  <c:if test="${result.option2 eq 'Y' }"> title="새창열기" target="_blank" </c:if> >[이벤트 페이지 바로가기]</a></dd>
					</c:if>
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
		</td>
	</tr>
	</tbody>
</table>
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
