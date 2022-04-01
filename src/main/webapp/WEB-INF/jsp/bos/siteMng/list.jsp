<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="*" />
				<col width="30%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">사이트ID</th>
					<th scope="col">사이트명</th>
					<th scope="col">사이트상세</th>
					<th scope="col">사이트URL</th>
					<th scope="col" class="last">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<%-- <c:url var="url" value="/bos/siteMng/forUpdate">
					<c:param name="siteId" value="${result.siteId}" ></c:param>
				</c:url> --%>
				 <c:url var="url" value="/bos/siteMng/forUpdate.do?siteId=${result.siteId}"/>

				<tr>
			    	<td class="output">${result.siteId}</td>
					<td class="output">
						<a href="${url}">${result.siteName}</a>
					</td>
			    	<td class="output">
						<a href="${url}">${result.siteDesc}</a>
					</td>
			    	<td class="output">${result.siteUrl}</td>
					<td class="output">${result.creatDt}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/siteMng/forInsert.do"><span>등록</span></a>
	</div>
<spring:message code="success.common.select"/>
</div>
