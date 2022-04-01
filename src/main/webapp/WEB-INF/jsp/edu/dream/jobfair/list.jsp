


<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%
	pageContext.setAttribute("crlf", "\n");
%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<div class="photoGallery4 photo4"><!-- 4n+4의 간격으로 mr0클래스 필수 -->
	<ul>
	<c:forEach items="${resultList }" var="result" varStatus="status">
		<c:set var="files" value="${fileMap[result.atchFileId] }"/>
		<c:if test="${fn:length(files) gt 0}">
			<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
				<c:if test="${files[x].fileFieldName eq 'logImage'}">
					<c:set var="file" value="${files[x]}" />
				</c:if>
			</c:forEach>
		</c:if>
		<li class="mrs<c:out value='${status.index%4 eq 0 ? "0" : status.index%4  }' />">
			<div>
				<div class="fl tac" style="border:1px solid #cfcfcf;width:100%;"><c:if test="${not empty file }">
				<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.insttNm }"/>" style="border:none;float:none;" />
				</c:if></div>

				<span class="db fl" style="background-color:<c:out value="${result.themaColor }" />;">
				<span class="title mb5 bdbn"><c:out value="${result.mainSvc }" /></span>
				<span class="desc tal fs13"><c:out value='${fn:replace(result.detailCn, crlf, "<br/>")}' escapeXml='false' /></span>
				<span class="w100p">
					<span class="w50p fl">
						<span class="db bdb1">멘토</span>
						<span class="icoMd icoMento"><span class="count fs5 fb"><c:out value="${result.mentoCo }" /></span></span>
					</span>

					<span class="w50p tar">
						<span class="db bdb1">멘티</span>
						<span class="icoMd icoMenti"><span class="count fs5 fb"><c:out value="${result.mentiCo }" /></span></span>
					</span>
				</span>
			</span>
			</div>
		</li>
		<c:set var="file" value="" />
		</c:forEach>
	</ul>
</div>



