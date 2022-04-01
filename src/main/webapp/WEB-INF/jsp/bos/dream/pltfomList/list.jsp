
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<title>${masterVO.bbsNm}</title>
</head>
<form id="frm" name="frm" action="/bos/dream/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post">
	<input type="hidden" name="pageQueryString" id="pageQueryString" value="<c:out value="${pageQueryString }"/>"> <input type="hidden" name="cnslSn" value="${empty result.cnslSn ? 0 : result.cnslSn }" />
	<div id="content">

		<!-- 게시판 게시물검색 start -->
		<fieldset>
			<legend>플랫폼관리 검색</legend>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>플랫폼관리</caption>
					<colgroup>
						<col width="15%" />
						<col width="25%" />
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="SPNM">년도</label></th>
							<td>
							<select id="year" name="year">
									<option value="">년도 선택</option>
									<c:forEach var="code" items="${COM084CodeList}" varStatus="status">
										<option value="${code.code}" <c:if test="${paramVO.year eq code.code }">selected="selected"</c:if> ><c:out value="${code.codeNm}" />
										</option>
									</c:forEach>
							</select>
							</td>
							<th scope="row"><label for="insttNm">기관명</label></th>
							<td><input type="text"  name="insttNm" value="<c:out value="${paramVO.insttNm }" />" />
							<input type="submit" style="right:" class="btn btn-primary" value="검색" />
							</td>
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
	</div>
</form>
<!-- 게시판 게시물검색 end -->

<!-- board list start -->

<div>
	<table class="table table-bordered table-striped table-hover">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="4%" />
			<col width="4%" />
			<col width="13%" />
			<col width="12%" />
			<col width="*" />
			<col width="4%" />
			<col width="4%" />
			<col width="10%" />
			<col width="4%" />
			<col width="7%" />
			<col width="8%" />

		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">년도</th>
				<th scope="col">기관명</th>
				<th scope="col">플랫폼 대표 서비스</th>
				<th scope="col">상세내용</th>
				<th scope="col">멘토</th>
				<th scope="col">멘티</th>
				<th scope="col">테마색</th>
				<th scope="col">순번</th>
				<th scope="col">사용여부</th>
				<th scope="col">등록일</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="output"><c:out value='${result.yearNm }' /></td>
					<td class="output">
					<c:url var="url" value="/bos/dream/${paramVO.programId}/view.do?insttSn=${result.insttSn}&${pageQueryString}" />
					<a href="${url}">
					<c:out value="${result.insttNm }" /></a></td>
					<td class="output"><c:out value="${result.mainSvc }" /></td>
					<td class="tit">
					  <span><c:out value="${result.detailCn }" /></span>
					 </td>
					<td class="output"><c:out value="${result.mentoCo }" /></td>
					<td class="output"><c:out value="${result.mentiCo }" /></td>
					<td class="output"><c:out value="${result.themaColor }" /> <span style="color:<c:out value="${result.themaColor }" />">■ </span> </td>
					<td class="output"><c:out value="${result.sortOrdr }" /></td>
					<td class="output"><c:out value="${result.useAt eq 'Y'?'사용':'미사용'}" /></td>
					<td class="output">	<fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/> </td>
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


