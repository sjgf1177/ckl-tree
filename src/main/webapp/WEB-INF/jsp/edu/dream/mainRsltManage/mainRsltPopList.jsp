
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<script>
	$('title').html('<c:out value="${years[0] }" />년 주요성과 - 에듀코카');
</script>
<div class="popBx winPop">
	<div class="popBoxIn">
		<span class="popLogo"></span>
		<a href="javascript:window.close();" class="popClose"><span class="sr-only">팝업창 닫기</span></a>

		<h2><c:out value="${years[0] }" />년 주요성과</h2>
		<div class="photoGallery2 photo_01 mb30">
		<ul>
		<c:forEach items="${resultList }" var="result">

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
					<dt class="fs1">
					<span class="img">
					<c:if test="${not empty bdtExpsrImage }">
					<img alt="<c:out value="${result.rsltSeNm }" /><c:out value="[${result.prdctNm }]" />" src="/cmm/fms/getImage.do?atchFileId=${bdtExpsrImage.atchFileId}&amp;fileSn=${bdtExpsrImage.fileSn}" style="width: 150px;height: 140px;" />
					</c:if>
					</span>
					<c:out value="${result.rsltSeNm }" /> <span class="point">[<c:out value="${result.prdctNm }" />]</span><span class="authorInfo fs13 dib ml30">멘티 : <c:out value="${result.mentiNm }" /> / 멘토 :<c:out value="${result.mentoNm }"/></span>
					</dt>
					<dd>
						<div class="fl ml0">
							<c:out value="${result.detailCn }" escapeXml="false"/>
						</div>
					</dd>
				</dl>
			</li>
			<c:remove var="bdtExpsrImage"  />
			<c:remove var="mainExpsrImage"  />
		</c:forEach>
		</ul>
		</div>
		<div class="board_util_btn_con center">
		<a href="javascript:window.close();" class="btn_style_0 close_w full">팝업창 닫기</a>
		</div>






	</div>

	<div class="popFooterSet">
		<span class="popLfBx"></span>
		<p class="tac mt20">Copyright 2015. Korea Creative Content Agency all rights reserved.</p>
		<span class="popRtBx"></span>
	</div>
</div>