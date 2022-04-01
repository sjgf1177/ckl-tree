<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<div class="tar alert formLine1">
	<form id="frm" name="frm" action ="/ckl/bbs/${paramVO.bbsId}/listMy.do?menuNo=${paramVO.menuNo}" method="post" class="form-inline">
		<fieldset>
			<legend></legend>
			<div class="clearfix">
				<select name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
				   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
				</select>
				<input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="${paramVO.searchWrd}" />
				<input type="submit" value="검색" class="btn btn-primary" />
			</div>
		</fieldset>
	</form>
</div>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<div class="bdList">
	<table class="table">
		<caption>나의문의내역목록</caption>
		<colgroup>
		<col style="width:8%;" />
		<col style="width:8%;" />
		<col style="width:8%;" />
		<col  />
		<col style="width:10%;" />
		<col style="width:12%;" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>공개여부</th>
				<th>상태</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:url var="url" value="/ckl/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&myAt=Y&${pageQueryString}" />
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td><c:out value="${result.secret eq 'Y' ? '비공개' : '공개'}"/></td>
					<td><c:out value="${result.replyAt eq 'Y' ? '완료' : '미완료'}"/></td>
					<td class="tal">
						<a href="${url}"><c:out value="${result.nttSj}"/></a>
					</td>
					<td><c:out value="${result.ntcrNm}"/></td>
					<td><c:out value="${result.frstRegisterPnttm}"/></td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>


<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>