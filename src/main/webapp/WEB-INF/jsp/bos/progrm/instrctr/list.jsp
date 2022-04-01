<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
</script>

<form id="frm" name="frm" method="post" action="/bos/progrm/instrctr/list.do?menuNo=${param.menuNo}" class="form-inline">
	<fieldset>
			<legend>강사(전문가)관리 검색 화면</legend>
			<div class="bdView mb0">
				<table class="table table-bordered">
					<caption></caption>
					<colgroup>
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" ><label for="realm1">분야</label></th>
							<td>
								<select name="realm" id="realm" title="검색 분야 선택">
									<option value="">분야선택</option>
									<c:forEach var="code" items="${COM076CodeList}" varStatus="status">
										<option value="${code.code}" <c:if test="${paramVO.realm eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
									 </c:forEach>
								</select>
							</td>
							<th scope="row" ><label for="userNm">이름</label></th>
							<td>
								<input type="text" name="userNm" id="userNm" value="" />
								<input type="submit" class="btn btn-primary" value="검색" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
	</fieldset>
</form>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col  span="3" />
		<col  />
		<col  />
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">분야</th>
				<th scope="row">이름</th>
				<th scope="row">현소속</th>
				<th scope="row">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:url var="viewUrl" value="/bos/progrm/instrctr/view.do">
				<c:param name="menuNo" value="${param.menuNo}" ></c:param>
				<c:param name="tchSn" value="${result.tchSn}" ></c:param>
				<c:param name="searchType" value="${param.searchType}" ></c:param>
				<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
				<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
			</c:url>
			<tr>
				<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
				<td>${result.realmNm}</td>
				<td><a href="${viewUrl}">${result.tchNm}</a></td>
				<td>${result.psitn}</td>
				<td>${result.regDate}</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btn_set">
	<a class="btn btn-primary" href="/bos/progrm/instrctr/forInsert.do?${pageQueryString}"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>