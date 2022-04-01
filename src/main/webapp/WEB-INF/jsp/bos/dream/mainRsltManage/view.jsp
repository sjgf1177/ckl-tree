
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%
	int year = egovframework.com.utl.DateUtil.getYear();
	pageContext.setAttribute("year", year);
%>

<%-- bdtExpsrImage 처리 --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'bdtExpsrImage'}">
			<c:set var="bdtExpsrImage" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>

<%-- mainExpsrImage 처리 --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'mainExpsrImage'}">
			<c:set var="mainExpsrImage" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>




<c:if test="${empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
	function del() {
		var form = $("#board")[0];
		form.action = "/bos/dream/${paramVO.programId}/delete.do";
		form.submit();
	}
</script>
<title><c:out value='${masterVO.bbsNm}' /> - 게시글읽기</title>
</head>
<div id="content">
	<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
		<input type="hidden" name="rsltSn" value="${result.rsltSn }" />
		<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
		<input type="hidden" id="cnsltReqSe" name="cnsltReqSe" />
		<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
		<input type="hidden" name="frstRegisterId" id="frstRegisterId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" name="LastUpdusrId" id="LastUpdusrId" value="<c:out value="${result.userId }" />" />
		<h4>■ 주요성과 보기</h4>
				<div class="bdView">
			<table>
				<caption>주요성과 보기</caption>
				<colgroup>
					<col style="width: 15%" />
					<col style="width: 35%" />
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">년도</th>
						<td colspan="3">
						<c:out value="${result.yearNm }"/>
						</td>
					</tr>
					<tr>
						<th scope="row">구분</th>
						<td colspan="3"><c:out value="${result.rsltSeNm }"/></td>
					</tr>
					<tr>
						<th scope="row">작품명</th>
						<td colspan="3"><c:out value="${result.prdctNm }"/></td>
					</tr>
					<tr>
						<th scope="row">멘티</th>
						<td colspan="3"><c:out value="${result.mentiNm }"/></td>
					</tr>
					<tr>
						<th scope="row">멘토</th>
						<td colspan="3"><c:out value="${result.mentoNm }"/></td>
					</tr>
					<tr>
						<th scope="row">본문노출 <br /> 포스터</th>
						<td colspan="3">
						<c:if test="${not empty bdtExpsrImage }">
							<img src='/cmm/fms/getImage.do?atchFileId=${bdtExpsrImage.atchFileId}&fileSn=${bdtExpsrImage.fileSn}' style=" height: 60px;" alt="${bdtExpsrFile.fileCn}" />
						</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">상세내용</th>
						<td colspan="3">
						<div class="row" id="dbdata">
							<c:out value="${result.detailCn }" escapeXml="false"/>
						</div>

						</td>
					</tr>
					<tr>
						<th scope="row">메인노출</th>
						<td> <c:out value="${result.mainExpsrAt eq 'Y' ? '노출' : '노출안함'}"/>
						</td>
						<th scope="row">순번</th>
						<td>
						<c:out value="${result.sortOrdr }" />
					</tr>
					<tr>
						<th scope="row">메인노출 <br />이미지
						</th>
						<td colspan="3">
							<c:if test="${not empty mainExpsrImage}">
									<img src='/cmm/fms/getImage.do?atchFileId=${mainExpsrImage.atchFileId}&fileSn=${mainExpsrImage.fileSn}' style=" height: 60px;" alt="${mainExpsrImage.fileCn}" />
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>


	</form>
	<c:if test="${result.delcode eq '1'}">
		<div class="fl">
			<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		</div>
	</c:if>

	<div class="btnSet">
		<div class="fl">
			<c:if test="${not empty result}">
				<!-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> -->
			</c:if>

			<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
				<a class="btn btn-default" href="/bos/dream/${paramVO.programId}/view.do?rsltSn=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
			</c:if>
			<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
				<a class="btn btn-default" href="/bos/dream/${paramVO.programId}/view.do?${prevNextMap['NEXT'].nextNttId}.do&${pageQueryString}"><span>다음글</span></a>
			</c:if>
		</div>
		<div class="fr">
			<a class="btn btn-primary" href="/bos/dream/${paramVO.programId}/forUpdate.do?rsltSn=${result.rsltSn}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
			<c:if test="${not empty result}">
				<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
			</c:if>
			<c:if test="${result.delcode eq '1' }">
				<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
			</c:if>
			<c:url var="url" value="/bos/dream/${paramVO.programId}/list.do?${pageQueryString}" />
			<a class="btn btn-primary" href="${url}"><span>목록</span></a>
		</div>
	</div>