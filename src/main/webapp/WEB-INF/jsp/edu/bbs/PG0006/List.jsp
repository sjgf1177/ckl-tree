
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>


<c:if test="${not empty COM066CodeList }">
<c:set value="${COM066CodeList }"  var="codeList" />
</c:if>

<%-- <c:if test="${not empty COM067CodeList }">
<c:set value="${COM067CodeList }"  var="codeList" />
</c:if>

<c:if test="${not empty COM068CodeList }">
<c:set value="${COM068CodeList }"  var="codeList" />
</c:if> --%>

<c:if test="${not empty COM069CodeList }">
<c:set value="${COM069CodeList }"  var="codeList" />
</c:if>


<!--content-->

	<div class="stepInline mb30">
		<ul>
			<c:url value="list.do?option5=${code.code }&menuNo=${param.menuNo }" var="url" />
			<li <c:if test="${empty paramVO.option5 }">class="on"</c:if>><a href="<c:out value='${url }'  />">전체</a></li>
			<c:url value=""  var="url"/>
			<c:if test="${not empty codeList }">
				<c:forEach var="code" items="${codeList}" varStatus="status">
					<c:url value="list.do?option5=${code.code }&menuNo=${paramVO.menuNo }" var="url" />
					<li <c:if test="${paramVO.option5 eq code.code }">class="on"</c:if>><a href="<c:out value='${url }' />"><c:out value="${code.codeNm}" /></a></li>
					<c:url value=""  var="url"/>
				</c:forEach>

			</c:if>
		</ul>
	</div>
	<!-- 임시  <div class="tabs mb30">
		<ul class="nav nav-pills navSm">
			<li class="active"><a href="#self">전체</a></li>
			<li><a href="#self">국문이력가이드</a></li>
			<li><a href="#self">영문이력서 가이드</a></li>
		</ul>
	</div> -->

	<div class="row mt10 mb5">
		<div class="col-md-12">
			총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /></strong> Page
		</div>
	</div>



	<div class="bdList">
		<table class="table">
			<caption>취업가이드 목록</caption>
			<colgroup>
				<col style="width: 8%;" />
				<col />
				<col style="width: 10%;" />
				<col style="width: 8%;" />
			</colgroup>
			<thead>

					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}" /></td>
						<td class="tal">
						<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}"  />
							<a href="<c:out value='${url}' escapeXml='false'/>">
							<c:out value='${result.nttSj}' />
						</a>
						</td>
						<td><c:out value="${result.frstRegisterPnttm}" /></td>
						<td class="brn"><c:out value="${result.inqireCo}" /></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>


	<!-- <div class="btnSet"><a class="btn btn-primary" href="#self"><span>등록</span></a> <a class="btn btn-default" href="#self"><span>비밀번호 초기화</span></a> <a class="btn btn-danger" href="#self"><span>삭제</span></a> <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a></div> -->


	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
	</c:if>
	<!-- //paging -->

