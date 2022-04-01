<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<div class="dlListTable">
		<h2 class="mt10"><c:out  value="${result.nttSj }" escapeXml="false"/></h2>
		<p class="tar"><c:out value="${result.frstRegisterPnttm}" escapeXml="false" /></p>

		<!-- thumbGallery -->
		<c:if test="${(fn:length(fileList)-1) gt 0 }">
		<div class="thumbs" id="vsThumbs">
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
				<c:if test="${fileVO.fileFieldName ne 'main_image' }">
				<div> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="682" alt="<c:out value="${result.nttSj }의 ${status.count }번째 이미지" />" /></a></div>
				</c:if>
			</c:forEach>
		</div>
		</c:if>
		<!-- webediter -->
		<div class="editDB">
			<c:choose>
					<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
					<c:otherwise>
						<% pageContext.setAttribute("crlf", "\n"); %>
						${fn:replace(result.nttCn, crlf, "<br/>")}
					</c:otherwise>
			</c:choose>
			<%-- <div class="hidden"><c:out value="${result.imgDescCn}"/></div> --%>
		</div>
		<!-- //webedi
		</div>

		<!-- //webediter -->
		<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
		<div class="btnSet tar"> <a class="btn btn-primary" href="${url }"><span>목록</span></a> </div>

	</div>

<div class="dlViewTable">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
			<dl>
				<dt class="bdViewPrev"><span class="hidden">이전글</span></dt>
				<dd>
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['PREV'].nttSj }" escapeXml="false" /> </a>
				</dd>
			</dl>
		</c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
			<dl>
				<dt class="bdViewNext"><span class="hidden">다음글</span></dt>
				<dd>
					<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['NEXT'].nttSj }" escapeXml="false" /> </a>
				</dd>
			</dl>
		</c:if>
</div>
