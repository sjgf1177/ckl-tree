
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<script type="text/javascript">

</script>
<title>${masterVO.bbsNm}</title>
</head>
<form id="frm" name="frm" action="/bos/dream/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post">
	<input type="hidden" name="pageQueryString" id="pageQueryString" value="<c:out value="${pageQueryString }" escapeXml="false"  />">
	<div id="content">

		<!-- 게시판 게시물검색 start -->
		<fieldset>
			<legend>멘토관리 검색</legend>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>멘토관리</caption>
					<colgroup>
						<col width="15%" />
						<col width="25%" />
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="SPNM">소속</label></th>
							<td>
							<select name="insttSn">
									<option value="">소속 선택</option>
									<c:forEach var="code" items="${psitnCodeList }">
										<option value="${code.insttSn}" <c:if test="${paramVO.insttSn eq code.insttSn }">selected="selected"</c:if>>
											<c:out value="${code.yearNm }" />년 	<c:out value="${code.insttNm}" />
										</option>
									</c:forEach>
							</select>
							</td>
							<th scope="row"><label for="nm">멘토명</label></th>
							<td><input type="text" id="nm" name="nm" value="<c:out value="${paramVO.nm }" />" > <input type="submit" style="right:" class="btn btn-primary" value="검색" /></td>
						</tr>
					</tbody>
				</table>

			</div>

		</fieldset>
	</div>
	<div class="row mt10 mb5">
		<div class="col-md-6">
			총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /></strong> Page
		</div>
		<div class="col-md-6 tar"></div>
	</div>

<!-- 게시판 게시물검색 end -->

<!-- board list start -->
<div>
	<table class="table table-bordered table-striped table-hover">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="4%" />
			<col width="10%" />
			<col width="10%" />
			<col width="6%" />
			<col width="10%" />
			<col width="*" />
			<col width="13%" />
			<col width="4%" />
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
				<th scope="col">멘토링 분야</th>
				<th scope="col">멘티</th>
				<th scope="col">순번</th>
				<th scope="col">사용여부</th>
				<th scope="col">관리</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:set var="files" value="${fileMap[result.atchFileId] }" />
				<c:if test="${fn:length(files) gt 0}">
					<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
						<c:if test="${files[x].fileFieldName eq 'photo'}">
							<c:set var="fileVO" value="${files[x]}" />
						</c:if>
					</c:forEach>
				</c:if>
				<tr>
					<td class="output">${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="output">
					<c:forEach var="code" items="${psitnCodeList }">
						 <c:if test="${result.insttSn eq code.insttSn }"> <c:out value="${code.insttNm}" /></c:if>
					</c:forEach>

					</td>
					<td class="output"><c:if test="${not empty fileVO }">
							<img src='/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}' style="width: 100%;" alt="${fileVO.orignlFileNm}" />
						</c:if> <c:set var="fileVO" value="" /></td>
					<td class="output">
					<c:url var="url" value="/bos/dream/${paramVO.programId}/view.do?mentoSn=${result.mentoSn}&${pageQueryString}" /> <a href="${url}">
					<c:out value="${result.nm }" /></a></td>
					<td class="tit"> <span><c:out value='${result.psitn }' /></span></td>
					<td class="output"><c:out value="${result.histCn }" /></td>
					<td class="output"><c:out value="${result.mentoNm }" /></td>
					<td class="output"><c:out value="${result.sortOrdr }" /></td>
					<td class="output"><c:out value="${result.useAt eq 'Y'?'사용':'미사용'}" /></td>
					<td class="output">
					<a href="/bos/dream/mentorManage/forUpdate.do?mentoSn=<c:out value="${result.mentoSn }" /><c:out value="${pageQueryString }" escapeXml="false"  />" >수정</a> |
					<a href="/bos/dream/mentorManage/delete.do?mentoSn=<c:out value="${result.mentoSn }"/><c:out value="${pageQueryString }" escapeXml="false"  />" onclick="return confirm('정말로 삭제하시겠습니까?');" >삭제</a>
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
</div>
</form>
<!-- 	<div class="fl"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div> -->
<div class="btn_set">
	<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
		<%--    <sec:authorize ifAnyGranted="ROLE_SUPER"> --%>
		<%-- 		<a class="btn btn-primary" href="/bos/dream/${paramVO.programId}/list.do?delcode=1"><span>삭제글보기</span></a> --%>
		<%--    </sec:authorize> --%>
		<a class="btn btn-primary" href="/bos/dream/${paramVO.programId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
		<%-- 		<a class="btn btn-info" href="/bos/dream/${paramVO.programId}/downloadExcelEmpymnCnsl.xls?${pageQueryString}"><span>Excel</span></a> --%>
	</c:if>
	<c:if test="${paramVO.delcode eq '1'}">
		<a class="btn btn-primary" href="/bos/dream/${paramVO.programId}/list.do?delcode=0"><span>돌아가기</span></a>
	</c:if>
</div>

<!-- board list end //-->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>


</div>


