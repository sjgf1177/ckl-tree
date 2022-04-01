<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<div class="pl10 pr10">
	<h2 class="ml10">${result.nttSj }</h2>
	
	<dl class="inline">
		<dt>작 성 일 : </dt>
		<dd><c:out value="${result.frstRegisterPnttm}" /></dd>
		<dt>조 회 수 : </dt>
		<dd><c:out value="${result.inqireCo}"/></dd>
	</dl>
	<dl class="inline">
		<dt>첨부파일 : </dt>
		<dd>
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
				<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte] <br />
			</a>
		</c:forEach>
		<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>

		</dd>
	</dl>
</div>


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
<!-- //webediter -->

<div class="btnSet tar">
	<c:url var="url" value="/cklmobile/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
	<span><a href="<c:out value='${url}' escapeXml='false'/>" class="btn btn-primary mr10">목록</span></a>
</div>


<div class="dlViewTable">
<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
	<dl>
		<dt class="bdViewPrev"><span class="hidden">이전글</span></dt>
		<dd>
		<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['PREV'].nttSj }" /> </a>
		</dd>
	</dl>
</c:if>
<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
	<dl>
		<dt class="bdViewNext"><span class="hidden">다음글</span></dt>
		<dd>
			<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['NEXT'].nttSj }" /> </a>
		</dd>
	</dl>
</c:if>
</div>