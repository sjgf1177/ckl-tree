<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!--사이트맵-->
<div>
	<table class="sitemap_table">
		<caption>이용안내 사이트맵입니다.</caption>
		<colgroup>
			<col width="170px">
			<col width="auto">
		</colgroup>
		<tbody>
			<c:set var="topCategories" value="${menuAll5['menu_0']}" />
			<c:forEach var="x" begin="0" end="4">
			<tr>
				<th>${topCategories[x].menuNm}</th>
				<td>
					<c:set var="d02menuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll5[d02menuKey]}" />
					<c:if test="${topCategories[x].menuNo == '500108'}">
						<c:set var="d02MenuKey" value="menu_700000" />
						<c:set var="d02Categories" value="${menuAll7[d02MenuKey]}" />
					</c:if>
					<c:if test="${fn:length(d02Categories)>0}">
					<ul class="sitemap_depth1">
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
						<li>
							<a href="${d02Categories[y].fullMenuLink}">${d02Categories[y].menuNm}</a>
							<c:set var="d03menuKey" value="menu_${d02Categories[y].menuNo}" />
							<c:set var="d03Categories" value="${menuAll5[d03menuKey]}" />
							<c:if test="${topCategories[x].menuNo == '500108'}">
								<c:set var="d03Categories" value="${menuAll7[d03menuKey]}" />
							</c:if>
							<c:if test="${fn:length(d03Categories)>0}">
							<ul class="sitemap_depth2">
								<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
								<li><a href="${d03Categories[z].fullMenuLink}">${d03Categories[z].menuNm}</a></li><!--//2depth-->
								</c:forEach>
							</ul>
							</c:if>
						</li><!--//1depth-->
						</c:forEach>
					</ul>
					</c:if>
				</td>
			</tr><!--//0depth - ${x}idx-->
			</c:forEach>
		</tbody>
	</table>
</div>
<!--//사이트맵-->