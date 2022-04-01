
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>



<!--content-->

	<!-- bdList -->
	<div class="tar alert formLine1">
		<form action="/<c:out value="${paramVO.siteName }"/>/bbs/${paramVO.bbsId}/list.do" class="form-inline" method="post">
			<input type="hidden" name="menuNo" value="${param.menuNo }" >
			<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
			<input type="hidden" name="pageQueryString" value="<c:out value='${pageQueryString}'  escapeXml='false'/>" />
				<div class="clearfix">
					<select name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
					</select> <input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd }" /> <input type="submit" id="input2" name="input2" value="검색" class="btn btn-primary" />
							<c:if test="${not empty paramVO.searchWrd }">
									<a href="/edu/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
							</c:if>
				</div>
		</form>
	</div>



	<div class="row mt10 mb5">
		<div class="col-md-12">
			총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${paginationInfo.totalPageCount }" /> </strong> Page
		</div>
	</div>

	<div class="bdList">
		<table class="table">
			<caption><c:out value="${masterVO.bbsNm}" /> 목록</caption>
			<colgroup>
				<col style="width: 8%;" />
				<col />
				<col style="width: 10%;" />
				<col style="width: 8%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1))}" /></td>
						<td class="tal"><c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
									<a href="<c:out value='${url}' escapeXml='false'/>">
										<span class="del"><c:out value='${result.nttSj}' /></span>
						</a></td>
						<td>${result.frstRegisterPnttm}</td>
						<td class="brn">${result.inqireCo}</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
			</tbody>

		</table>
	</div>
	<sec:authorize ifAnyGranted="ROLE_USER">
	<c:if test="${userVO.mentoYn eq 'Y' }">
		<div class="btnSet tac pb20">
			<a href="/edu/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}" class="fr btn btn-primary">글쓰기</a>
		</div>
	</c:if>
	</sec:authorize>
	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->


	<table class="board_type_0">
		<caption>창의클럽커뮤니티 게시판 입니다.</caption>
		<colgroup>
			<col width="auto" class="count_column">
			<col width="auto">
			<col width="auto" class="write_date_column">
			<col width="90px">
		</colgroup>
		<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>7</td>
			<td>
			<a href="./sub_edu_03_view.html">
			2017년 콘텐츠 창의인재 동반사업 멘티 선정 최종결과 안내
			</a>
			</td>
		<td>2017.08.05</td>
		<td>5211</td>
		</tr>
		<tr>
		<td>6</td>
		<td>
		<a href="./sub_edu_03_view.html">
		2017년 창의인재동반사업 창의교육생(멘티) 모집
		</a>
		</td>
		<td>2017.08.05</td>
		<td>2811</td>
		</tr>
		<tr>
		<td>5</td>
		<td>
		<a href="./sub_edu_03_view.html">
		콘텐츠산업 진흥 연속기획 세미나 <4차 산업혁명 시대, 콘텐츠산업 정책의 새로운 과제>
		</a>
		</td>
		<td>2017.08.05</td>
		<td>3437</td>
		</tr>
		<tr>
		<td>4</td>
		<td>
		<a href="./sub_edu_03_view.html">
		에듀코카 2017년도 1분기 우수튜터
		</a>
		</td>
		<td>2017.08.05</td>
		<td>2791</td>
		</tr>
		<tr>
		<td>3</td>
		<td>
		<a href="./sub_edu_03_view.html">
		취창업성공 축하 이벤트 당첨자
		</a>
		</td>
		<td>2017.08.05</td>
		<td>2548</td>
		</tr>
		<tr>
		<td>2</td>
		<td>
		<a href="./sub_edu_03_view.html">
		신규 열린강좌 EVENT 당첨자 발표!
		</a>
		</td>
		<td>2017.08.05</td>
		<td>2636</td>
		</tr>
		<tr>
		<td>1</td>
		<td>
		<a href="./sub_edu_03_view.html">
		취업 및 창업 성공 축하 이벤트!!
		</a>
		</td>
		<td>2017.08.05</td>
		<td>5430</td>
		</tr>
		</tbody>
	</table>

