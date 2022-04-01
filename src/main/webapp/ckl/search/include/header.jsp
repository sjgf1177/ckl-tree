<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="kr.co.ckl.category.CategoryService"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="egovframework.com.cmm.service.Globals" var="Globals"/>
<%
	ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	CategoryService categoryService = (CategoryService)context.getBean("categoryService");
	Map<String, List<ZValue>> categoryMap = categoryService.getMap();
	pageContext.setAttribute("categoryMap", categoryMap);
%>

		<div id="header">
			<h1><a href="/ckl/main.do" class="logo thidden"><spring:message code='site.engName' text=''/> Scoreboard(Korea S&amp;T Innovation Policy Scoreboard</a></h1>
			<div class="global">
				<div class="gnavi">
					<ul>
						<li class="first"><a href="/ckl/main/contents.do?menuNo=200003">ABOUT</a></li>
						<li><a href="/ckl/main/contents.do?menuNo=200079">CONTACT</a></li>
						<li><a href="/ckl/main/contents.do?menuNo=200080">SITEMAP</a></li>
						<li class="kistep"><a href="http://www.kistep.re.kr" class="thidden" target="_blank" title="새 창 열림"><span>KISTEP <spring:message code='site.korName' text=''/></span></a></li>
					</ul>
				</div>
			</div>
			<!-- gnb -->
			<c:set var="topCategories" value="${menuAll2['menu_0']}" />
			<div class="gnb_area">
				<div class="gnbBack gnbBack_depth2"></div>
				<div class="gnb_con">
					<div class="gnb" id="gnb">
					<c:if test="${fn:length(topCategories)>0}">
						<ul class="d1">
						<c:forEach var="x" begin="0" end="6">
							<li class="menu${x+1}"><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank"' : ''}><c:out value="${topCategories[x].menuNm}"/></a>
							<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
							<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
							<c:if test="${fn:length(d02Categories)>0}">
								<ul>
								<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
									<li class="smenu${y+1}"><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"' : ''}><c:out value="${d02Categories[y].menuNm}"/></a>
					<c:choose>
						<c:when test="${d02Categories[y].menuNm eq '지표'}">
							<c:set var="categoryKey" value="CATEGORY_${x}" />
							<c:set var="categoryList" value="${categoryMap[categoryKey]}" />
							<c:if test="${fn:length(categoryList)>0}">
										<ul>
										<c:forEach var="category" items="${categoryList}" varStatus="status">
											<c:if test="${category.categoryId ne 169}">
											<li><a href="/ckl/bbs/B0000002/view.do?gubun=${category.categoryId}&amp;menuNo=${d02Categories[y].menuNo}"><c:out value="${category.categoryName}"/></a></li>
											</c:if>
										</c:forEach>
										</ul>
							</c:if>
						</c:when>
						<c:otherwise>
									<c:set var="d03menuKey" value="menu_${d02Categories[y].menuNo}" />
									<c:set var="d03Categories" value="${menuAll2[d03menuKey]}" />
									<c:if test="${fn:length(d03Categories)>0}">
										<ul>
										<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
											<c:set var="clss2" value="${y eq depth02 && z eq depth03 ? 'class=\"on\"' : ''}" />
											<c:if test="${y eq depth02 && z eq depth03}">
												<c:set var="curD" value="${d03Categories[z]}" />
												<c:set var="curD03" value="${d03Categories[z]}" />
											</c:if>
											<li><a href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank"':''}><c:out value="${d03Categories[z].menuNm}"/></a></li>
										</c:forEach>
										</ul>
									</c:if>
									</li>
						</c:otherwise>
					</c:choose>
								</c:forEach>
								</ul>
							</c:if>
							</li>
						</c:forEach>
						</ul>
					</c:if>
					</div>
				</div>
			</div>

			<!-- //gnb -->
		</div>
		<!-- //gnb -->

		<div class="visual">
			<p class="thidden"><spring:message code='site.engName' text=''/> Scoreboard는 과학기술 공급·수요 지표를 활용하여 <strong>증거(사실)기반의 과학적인 국가과학기술정책 수립을 지원하는 의사결정 시스템입니다.</strong></p>
			<div id="tsh">
				<!--
				<select  name="" class="input_select" title="검색어 구분" >
				  <option value="" selected="selected">통합검색</option>
				  <option value="">구분</option>
				</select> -->
				<form name="formTop" onsubmit="return false;" method="post" action="/ckl/search/search.jsp">
					<input type="hidden" name="searchQuery"  />
					<label for="globalSch">통합검색</label>
					<input type="text"  name="globalSch" id="globalSch" value=""  class="input_txt" title="검색어" />
					<input type="image" src="/ckl/images/common/tsh_btn.gif" alt="검색" class="img_submit" onclick="javascript:goTopSearch();" />
					<!-- <a href="#self" class="help_guide">도움말</a> -->
				</form>
			</div>
		</div>
