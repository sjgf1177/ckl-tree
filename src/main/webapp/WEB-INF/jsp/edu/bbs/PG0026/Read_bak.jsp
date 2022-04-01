
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<sec:authentication var="user" property="principal"/>
<c:set value="${user != 'anonymousUser' ? user.username : '' }" var="userVrify" />
<c:set value="${userVrify }" var="idCeck" />
<c:if test="${idCeck eq result.frstRegisterId }">
<script type="text/javascript">
function del(){
	var form = $("#board")[0];
	form.action = "/edu/bbs/${paramVO.bbsId}/delete.do?menuNo=<c:out value="${param.menuNo }"/>";
	form.submit();
}
</script>
</c:if>

	<!-- bdView -->

	<div class="dlListTable">
		<dl>
			<dt>제목</dt>
			<dd>
				<c:out value="${result.nttSj}" />
			</dd>
			<dt>작성일</dt>
			<dd class="w15p tac">
				<c:out value="${result.frstRegisterPnttm}" />
			</dd>
		</dl>
		<dl>
			<dt>첨부파일</dt>
			<dd>
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
				<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
					<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte] <br />
				</a>
			</c:forEach>
			<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>
			</dd>
			<dt>조회수</dt>
			<dd class="w15p tac">
				<c:out value="${result.inqireCo}"></c:out>
			</dd>
		</dl>


		<!-- webediter -->
		<div class="outputEditor" id="dbdata">
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
			<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
			<a class="btn btn-primary" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
		</div>

		<div class="dlListTable">
			<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
				<dl>
					<dt>이전글</dt>
					<dd>
						<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> ${prevNextMap['PREV'].nttSj } </a>
					</dd>
				</dl>
			</c:if>
			<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
				<dl>
					<dt>다음글</dt>
					<dd>
						<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> ${prevNextMap['NEXT'].nttSj } </a>
					</dd>
				</dl>
			</c:if>


		</div>
		<!-- //bdView -->
	</div>
<c:if test="${idCeck eq result.frstRegisterId  }">
	<div class="fr" >
		<a class="btn btn-primary" href="/edu/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</div>
</c:if>
