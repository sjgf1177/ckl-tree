<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<div class="photoGallery3 culturePhoto">
		<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
		<c:forEach var="files" items="${fileList }">
			<c:if test="${files.fileFieldName eq 'main_image' }">
				<c:set  var="file" value="${files }"/>
			</c:if>
		</c:forEach>
		<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
			<li class=""> <a href="<c:out value="${url }" escapeXml="false" />" class="db">
				<c:if test="${not empty file }">
					<img class="db" src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nttSj}"/>">
				</c:if>
				<c:if test="${empty file }">
					<img class="db" src="/edu/images/common/noimg_312x200.jpg" alt="이미지가 존재하지 않습니다" />
				</c:if>
				<span class="db title"><c:out value="${result.nttSj }" escapeXml="false" /></span> </a>
				<span class="date"><c:out value="${result.frstRegisterPnttm }" /></span>
				<span class="count"><c:out value="${result.inqireCo }" /></span>
			</li>
		</c:forEach>
		</ul>
	</div>

	<!-- board list end //-->

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
	</c:if>
