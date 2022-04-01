
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


<%-- 사진이미지  --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'photo'}">
			<c:set var="fileVO" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>
<c:if test="${empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/insert.do?menuNo=${param.menuNo }" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/dream/${paramVO.programId}/update.do?menuNo=${param.menuNo }" />
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
		<input type="hidden" name="pageQueryString" value="${pageQueryString}"  />
		<input type="hidden" name="frstRegisterId" id="frstRegisterId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" name="LastUpdusrId" id="LastUpdusrId" value="<c:out value="${result.userId }" />" />
		<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
		<input type="hidden" name="mentoSn" value="<c:out value='${result.mentoSn }' />">
		<h4>■ 멘토 조회</h4>
		<div class="bdView">
			<table>
				<caption>멘토 조회</caption>
				<colgroup>
					<col style="width: 15%" />
					<col style="width: 35%" />
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">소속</th>
						<td colspan="3" name="mentoSn">
						<c:forEach var="code" items="${psitnCodeList }">
									 <c:if test="${result.insttSn eq code.insttSn }"> <c:out value="${code.insttNm}" /></c:if>
						</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="photo">사진</label></th>
						<td colspan="3"><c:if test="${not empty fileVO }">
								<img src='/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}' style=" height: 100px;" alt="${fileVO.fileCn}" />
							</c:if></td>
					</tr>
					<tr>
						<th scope="row">성명</th>
						<td colspan="3"><c:out value="${result.nm}" /></td>
					</tr>
					<tr>
						<th scope="row">소속</th>
						<td colspan="3"><c:out value='${result.psitn }' /></td>
					</tr>
					<tr>
						<th scope="row">멘토링 분야</th>
						<td colspan="3"><c:out value="${result.histCn }" /></td>
					</tr>
					<tr>
						<th scope="row" for="mentoNm">멘티</th>
						<td colspan="3"><c:out value='${result.mentoNm }' /></td>
					</tr>
					<tr>
						<th scope="row" for="sortOrdr">순번</th>
						<td colspan="3">${result.sortOrdr}</td>
					</tr>
					<tr>
						<th scope="row" for="sortOrdr">사용여부</th>
						<td colspan="3"><c:out value="${result.useAt eq 'Y'?'사용':'미사용' }" /></td>
					</tr>

				</tbody>
			</table>
		</div>


	</form>
	<c:if test="${not empty result}">
		<%-- <div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>--%>
	</c:if>
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
			<a class="btn btn-default" href="/bos/dream/${paramVO.programId}/view.do?mentoSn=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
		</c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
			<a class="btn btn-default" href="/bos/dream/${paramVO.programId}/view.do?${prevNextMap['NEXT'].nextNttId}.do&${pageQueryString}"><span>다음글</span></a>
		</c:if>
	</div>
	<div class="fr">
		<a class="btn btn-primary" href="/bos/dream/${paramVO.programId}/forUpdate.do?mentoSn=${result.mentoSn}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
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