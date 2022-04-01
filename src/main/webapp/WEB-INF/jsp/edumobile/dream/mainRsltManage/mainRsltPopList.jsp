<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<div>
	<h2>2014년 주요성과</h2>
	<div class="photoGallery2 photo_01 mb30">
		<ul>
			<c:forEach items="${resultList }" var="result" >
				<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<%--본문 이미지  --%>
				<c:forEach var="fileList" items="${files }">
					<c:if test="${fileList.fileFieldName eq 'bdtExpsrImage' }">
						<c:set var="bdtExpsrImage" value="${fileList }" />
					</c:if>
				</c:forEach>

				<%--메인이미지 이미지  --%>
				<c:forEach var="fileList" items="${files }">
					<c:if test="${fileList.fileFieldName eq 'mainExpsrImage' }">
						<c:set var="mainExpsrImage" value="${fileList }" />
					</c:if>
				</c:forEach>

				<li>
					<dl class="fl">
						<dt class="fs1"> <span class="img"> <img alt="<c:out value="${result.rsltSeNm }" src="/cmm/fms/getImage.do?atchFileId=${bdtExpsrImage.atchFileId}&amp;fileSn=${bdtExpsrImage.fileSn}" /> </span> <c:out value="${result.rsltSeNm }" /> <span class="point">[<c:out value="${result.prdctNm }" />]</span><span class="authorInfo">멘티 : <c:out value="${result.mentiNm }" /> / 멘토 :<c:out value="${result.mentoNm }"/></span> </dt>
						<dd>
							<c:out value="${result.detailCn }" escapeXml="false"/>
						</dd>
					</dl>
				</li>
				<c:remove var="bdtExpsrImage"  />
				<c:remove var="mainExpsrImage"  />
			</c:forEach>
		</ul>
	</div>
</div>
<!-- //webediter -->
		<c:url var="url" value="/${paramVO.siteName }/dream/mainRsltManage/list.do?menuNo=600036" />
		<div class="btnSet tar"> <a class="btn btn-primary" href="${url }"><span>목록</span></a> </div>

<!-- //bdList -->
