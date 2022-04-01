


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

<div class="tab_style_1_con">
	<ul class="tab_style_1 three_tab size_24">
		<li><a href="/edu/dream/mainRsltManage/list.do?menuNo=500040"><span>사업소개</span></a></li>
		<li class="active"><a href="/edu/dream/pltfomList/list.do?menuNo=500117" title="현재탭"><span>플랫폼기관</span></a></li>
		<!-- <li><a href="/edu/dream/mentorManage/list.do?menuNo=500119"><span>멘토라인업</span></a></li> -->
		<li><a href="/edu/bbs/B0000041/list.do?menuNo=500211"><span>창의현장</span></a></li>
	</ul>
</div>

<div class="platform_card_wrap">
	<c:forEach items="${resultList }" var="result" varStatus="status">
	<div class="calc_wrap19">
		<c:set var="files" value="${fileMap[result.atchFileId] }"/>
		<c:if test="${fn:length(files) gt 0}">
			<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
				<c:if test="${files[x].fileFieldName eq 'logImage'}">
					<c:set var="file" value="${files[x]}" />
				</c:if>
			</c:forEach>
		</c:if>
		<div class="col-12 col-sm-4 platform_list">
			<div class="platform_card">
				<div class="img_box">
					<c:if test="${not empty file }">
						<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.insttNm }"/>" style="border:none;float:none;" />
					</c:if>
				</div>
				<div class="text_box">
					<div class="title_box">
						<h5><c:out value="${result.mainSvc }" /></h5>
						<p class="h_desc5">
							<c:out value='${fn:replace(result.detailCn, crlf, "<br/>")}' escapeXml='false' />
						</p>
					</div>
					<hr class="h_line5">
					<p class="h_date5">
						<span><span class="blue">멘토</span> : <c:out value="${result.mentoCo }" />명</span><span class="line"></span><span><span class="blue">멘티</span> : <c:out value="${result.mentiCo }" />명</span>
					</p>
				</div>
			</div>
		</div>
	</div>
	</c:forEach>
</div>

<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>


