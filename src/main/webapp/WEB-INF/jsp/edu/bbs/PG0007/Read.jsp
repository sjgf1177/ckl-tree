
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'main_image'}">
			<c:set var="fileVO" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>






<!-- bdView -->
<div class="dlListTable">
	<div class="row">
		<div class="col-md-1">
			<c:if test="${not empty fileVO}">
				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value='${fileVO.atchFileId}'/>&fileSn=<c:out value='${fileVO.fileSn}'/>" alt="${fileVO.fileCn}" style="height: 82px" />
			</c:if>
		</div>
		<div class="col-md-11">
			<dl>
				<dt>성명</dt>
				<dd>
					<c:out value="${result.option1}" />
				</dd>
				<dt>소속분야</dt>
				<dd class="w30p tac">
					<c:out value="${result.option3Nm}" />
				</dd>
			</dl>
			<dl>
				<dt>직업</dt>
				<dd>
					<c:out value="${result.option2}" />
				</dd>
				<dt>소속기관</dt>
				<dd class="w30p tac">
					<c:out value="${result.option4}" />
				</dd>
			</dl>
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

	<div class="btnSet tar">
		<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/list.do?option3=${param.option3 }&${pageQueryString}" />
		<a class="btn btn-primary" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
	</div>


	<!-- <div class="dlListTable">
						<dl>
							<dt>다음글</dt>
							<dd>아프리카 인기 BJ와 함께하는 ‘MCN 크리에이터 커뮤니티’ 개최</dd>
						</dl>
						<dl>
							<dt>이전글</dt>
							<dd>아프리카 인기 BJ와 함께하는 ‘MCN 크리에이터 커뮤니티’ 개최</dd>
						</dl>
					</div> -->
	<!-- //bdView -->
</div>
