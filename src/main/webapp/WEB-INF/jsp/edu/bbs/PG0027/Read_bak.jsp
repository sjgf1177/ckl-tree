
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<c:forEach var="code" items="${psitnCodeList }">
		<c:if test="${result.option1 eq code.insttSn }">
			<c:set var="psitnCode" value="${code }" />
		</c:if>
</c:forEach>
<script type="text/javascript">

</script>

<div class="dlListTable">

	<div style="background-color: <c:out value='${psitnCode.themaColor }'/>" class="hGroup bgcolor4 mt20">
		<h3 class="dib fcWhite mr50">
			<c:out value="${result.nttSj}" />
		</h3>
		<span class="date fs12"><c:out value="${result.frstRegisterPnttm}" /></span>
		<div class="fr pt15 mr30">
			<span class="w50p tar"><span class="icoSm icoStory"></span> 현장스토리</span>
		</div>
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

		<!-- 본문이미지 대체텍스트 -->
		<!-- <div class="hidden">${result.imgDescCn}</div> -->

	</div>
	<!-- //webediter -->
</div>


<div class="btnSet tar">
	<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" escapeXml='false'/>/list.do?<c:out value="${pageQueryString}" escapeXml='false'/>" class="btn btn-primary">목록</a>
</div>

<div class="bdMoreTable">
<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
	<dl>
		<dt>
			<span class="bdMore bgBlack fcWhite">이전글 <span class="icoSm icoNext"></span></span>
		</dt>
		<dd>
					<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['PREV'].nttSj }" /> </a>
		</dd>
	</dl>
</c:if>
<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
	<dl>
		<dt>
			<span class="bdMore bgGray"><span class="icoSm icoPrev"></span> 다음글</span>
		</dt>
		<dd>
			<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml='false'/>"><c:out value="${prevNextMap['NEXT'].nttSj }" /></a>
		</dd>
	</dl>
</c:if>

</div>




