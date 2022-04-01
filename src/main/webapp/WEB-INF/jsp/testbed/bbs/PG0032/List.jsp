
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<script>
$(function(){
	// 노출 허용 기업만 출력
	<%
	String useAt = (String)request.getParameter("useAt");
	if(useAt == null || "".equals(useAt) ){ 
		%>
		$("#frm").submit();
		<%
	} else {
		%>
		$("#frm").show();
		<%
	}
	%>
});
</script>
<jsp:useBean id="todayNow" class="java.util.Date"  />
<form id="frm" name="frm" action ="?menuNo=${param.menuNo }" method="post" style="display:none;">
<input type="hidden" name="useAt" value="Y">
<fmt:formatDate value="${todayNow}" var="today" pattern="yyyy-MM-dd" />
	<c:url value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo }" var="searchUrl" />
	<!-- bdList -->

	<!--content-->
<div class="col-12 img_card_wrap coronation">
	<div class="col-12 calc_wrap19">
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
		<c:set var="file" value=""/>
		<c:forEach var="files" items="${fileList }">
			<c:if test="${files.fileFieldName eq 'main_image' }">
				<c:set  var="file" value="${files }"/>
			</c:if>
		</c:forEach>
		<c:url var="url" value="/${paramVO.siteName}/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
		
		<div class="col-6 col-sm-4 tc img_card_list testbed_company_card">
			<a href="<c:out value="${url }" escapeXml="false" />" class="col-12 show fn img_card">
				<div class="col-12 img_box">
					<div class="col-12 img_box_inner">
						<div class="show-tablecell tc vm">
							<%-- <c:set var="file" value="${fileList[0]}"/>
							<img alt="${result.nttSj } 기업 소개 이미지" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${file.atchFileId}" />&amp;fileSn=<c:out value="${file.fileSn}" />" /> --%>
							<c:if test="${not empty file }">
	                            <img class="123" src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nttSj}"/>" />
	                        </c:if>
	                        <c:if test="${empty file }">
	                            <!-- 빈이미지 --><img class="" src="" alt="이미지가 존재하지 않습니다" />
	                        </c:if>
							<!-- <img src="/edu/images/bm/in_company_img_000.jpg"> -->
						</div>
					</div>
				</div>
				<div class="col-12 text_box">
					<h5><c:out value="${result.nttSj }" /></h5>
					<hr class="h_line5">
					<div class="h_desc5"><c:out value="${result.option1}" /></div>
					<div class="h_date5"><c:out value="${result.frstRegisterPnttm}" /></div>
				</div>
			</a>
		</div>
		
		<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
	</div>
</div>
</form>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>
<!-- //paging -->
