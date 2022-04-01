
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

<%-- LOG_IMAGE 처리 --%>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'logImage'}">
			<c:set var="fileVO" value="${fileList[x]}" />
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
		<input type="hidden" name="insttSn" value="<c:out value='${result.insttSn }' />">
		<h4>■ 플랫폼 기관 조회</h4>
		<div class="bdView">
			<table>
				<caption>플랫폼 기관 조회</caption>
				<colgroup>
					<col style="width: 15%" />
					<col style="width: 35%" />
					<col style="width: 15%" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="logImage">로고</label></th>
						<td colspan="3">
						<c:if test="${not empty fileVO }">
						<img src='/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}'  alt="${fileVO.fileCn}" />
						</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="year">년도</label></th>
						<td><c:out value="${result.yearNm }" /></td>
						<th scope="row">사용여부</th>
						<td><c:out value="${result.useAt eq 'Y'?'사용':'미사용' }" /></td>
					</tr>
					<tr>
						<th scope="row">기관명</th>
						<td colspan="3"><c:out value="${result.insttNm}" /></td>
					</tr>
					<tr>
						<th scope="row">대표서비스</th>
						<td colspan="3"><c:out value="${result.mainSvc}" /></td>
					</tr>
					<tr>
						<th scope="row">상세내용</th>
						<td colspan="3">
						<div class="row" id="dbdata">
							<% pageContext.setAttribute("crlf","\r\n"); %>
							${fn:replace(fn:replace(fn:escapeXml(result.detailCn), crlf, '<br/>') , ' ', '&nbsp;')}
						</div>

						</td>
					</tr>
					<tr>
						<th scope="row" for="themaColor">테마색</th>
						<td><c:out value="${result.themaColor }" /> <span style="color:<c:out value="${result.themaColor }" />"> ■ </span> </td>
						<th scope="row">순번</th>
						<td><c:out value="${result.sortOrdr }" /></td>
					</tr>
					<tr>
						<th scope="row" for="">멘토</th>
						<td><c:out value="${result.mentoCo }" /> 명</td>
						<th scope="row">멘티</th>
						<td><c:out value="${result.mentiCo }" /> 명</td>
					</tr>

				</tbody>
			</table>
		</div>

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
				<a class="btn btn-default" href="/bos/dream/${paramVO.programId}/view.do?insttSn=${prevNextMap['PREV'].prevNttId}&${pageQueryString}"><span>이전글</span></a>
			</c:if>
			<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
				<a class="btn btn-default" href="/bos/dream/${paramVO.programId}/view.do?${prevNextMap['NEXT'].nextNttId}.do&${pageQueryString}"><span>다음글</span></a>
			</c:if>
		</div>
		<div class="fr">
			<a class="btn btn-primary" href="/bos/dream/${paramVO.programId}/forUpdate.do?insttSn=${result.insttSn}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
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



	<br /><br />
	<br />
	<br />
	<br />


	<h4>■ 멘토정보</h4>
	<!-- board list start -->
<div>
	<table class="table table-bordered table-striped table-hover">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="5%" />
			<col width="10%" />
			<col width="10%" />
			<col width="15%" />
			<col width="*" />
			<col width="*" />
			<col width="13%" />
			<col width="8%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">소속</th>
				<th scope="col">사진</th>
				<th scope="col">성명</th>
				<th scope="col">소속</th>
				<th scope="col">대표작/약력</th>
				<th scope="col">멘티</th>
				<th scope="col">순번</th>
				<th scope="col">관리</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach var="memtorResult" items="${resultList}" varStatus="status">
				<c:set var="files" value="${fileMap[memtorResult.atchFileId] }" />
				<c:if test="${fn:length(files) gt 0}">
					<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
						<c:if test="${files[x].fileFieldName eq 'photo'}">
							<c:set var="mentorImage" value="${files[x]}" />
						</c:if>
					</c:forEach>
				</c:if>
				<tr>
					<td class="output">${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="output">
					<c:out value="${result.insttNm}" />
					</td>
					<td class="output"><c:if test="${not empty mentorImage }">
							<img src='/cmm/fms/getImage.do?atchFileId=${mentorImage.atchFileId}&fileSn=${mentorImage.fileSn}' style="width: 120px;" alt="${mentorImage.fileCn}" />
						</c:if> <c:set var="fileVO" value="" /></td>
					<td class="output"><c:out value="${memtorResult.nm }" /></td>
					<td class="tit"> <span><c:out value='${memtorResult.psitn }' /></span></td>
					<td class="output"><c:out value="${memtorResult.histCn }" /></td>
					<td class="output"><c:out value="${memtorResult.mentoNm }" /></td>
					<td class="output"><c:out value="${memtorResult.sortOrdr }" /></td>
					<td class="output">
					<a href="/bos/dream/mentorManage/forUpdate.do?mentoSn=<c:out value="${memtorResult.mentoSn }" /><c:out value='${pageQueryString}' escapeXml="false" />" >수정</a> |
					<a href="/bos/dream/pltfomList/mentoDelete.do?mentoSn=<c:out value="${memtorResult.mentoSn }"/>&insttSn=<c:out value="${result.insttSn }" />&menuNo=<c:out value="${paramVO.menuNo }" />" onclick="return confirm('정말로 삭제하시겠습니까?');" >삭제</a>
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="10">데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<%-- <c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if> --%>
</div>

	</form>
