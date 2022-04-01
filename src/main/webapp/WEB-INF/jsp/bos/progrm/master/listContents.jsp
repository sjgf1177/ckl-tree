<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div class="bdList">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col>
			<col style="width: 40%;">
			<col style="width: 45%;">
			<col style="width: 10%;">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>구분</th>
					<th>분류</th>
					<th>콘텐츠 수정</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<c:set var="data" value="${fn:split(result.relateMenuNmList,'|')}" />
					<c:set var="prgSeNm" value="${data[0]}" />
					<c:if test="${data[0] eq '취업정보'}"><c:set var="prgSeNm" value="취업프로그램" /></c:if>
					<tr>
						<td>${result.rnum}</td>
						<td>${prgSeNm}</td>
						<td>
							<c:choose>
								<c:when test="${param.prgSe eq '01'}">${data[1]}</c:when>
								<c:otherwise>
									<c:if test="${param.prgSe eq '03'}">${data[1]}</c:if>${data[2]}
								</c:otherwise>
							</c:choose>
						</td>
						<td>
			  				<a href="/bos/mpm/commonContents/forUpdate.do?siteId=${result.siteId}&sMenuNo=${result.menuNo}&menuNo=${param.menuNo}&gubun=Y&viewType=BODY" target="_blank" title="새창열림" onclick="window.open(this.href,'contentPop','width=970,height=700');return false;" class="btn btn-primary btn-sm" >수정</a>
			  			</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="4">데이터가 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
