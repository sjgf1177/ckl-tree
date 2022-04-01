<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.testbed.concert.service.ConcertMngService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>


<h4>■ 예약대기 리스트</h4>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width: 40px;">
		<col width="auto">
		<col width="auto">
		<col width="auto">
		<col width="auto">
		<col>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>등록일시</th>
				<th>아이디</th>
				<th>이름</th>
				<th>연락처</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="tac">${status.count}</td>
					<td class="tac">${result.regDateStr}</td> 
					<td class="tac">${result.userId}</td> 
					<td class="tac">${result.memberName}</td> 
					<td class="tac">${result.memberTel}</td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet">
	<a class="btn btn-primary" href="/bos/concert/reserv/list.do?menuNo=${param.menuNo}&concertTimeId=${param.concertTimeId}&concertId=${param.concertId}&${pageQueryString}"><span>목록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paginationSet">
			${pageNav}
		</div>
	</div>
</c:if>





