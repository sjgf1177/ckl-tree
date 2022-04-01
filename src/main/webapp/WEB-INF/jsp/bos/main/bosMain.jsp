<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/WEB-INF/error/500.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />
<!DOCTYPE html>
<html lang="en">
<head>

<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/bosLayout.css" />
<script type="text/javascript" src="/js/ssl.js"></script>

<script type="text/javascript">
function openPopup()
{
	url = "/bos/member/forUpdateMy.do?viewType=BODY";
	window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1000, height=700");
}
</script>
	<meta charset="UTF-8" />
	<title>안내(2번)</title>
<style>
*{padding: 0;margin: 0;}
.inforSet{border: 1px solid #f2f2f2;width: 901px;margin: 73px auto;}
.inforSet .logo{background-color: #f2f2f2;padding:5px 0 0 25px ;height: 67px;}
.inforSet p{padding: 90px;line-height: 30px;font-weight: bold;}
.inforSet em{color: #0180d0;font-style:normal;}
.inforSet em.col{color: #0e5fe6;}
</style>
</head>
<body>
		<div id="header_wrap">
			<div class="header">
				<h1><a href="/bos/main/main.do"><img src="/images/common/logo.png" alt="<spring:message code="site.slogan" text=""/>" /></a></h1>
				<p class="user bold"><span class="color1">[${adminUser.deptNm}]${adminUser.userNm}</span>님 로그인 접속IP:${userIp}</p>
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />

				<div class="util btn-group">
					<c:if test="${fn:length(topCategories)>0}">
						<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
							<c:choose>
							<c:when test="${x==0}"><c:set var="iconClass" value="fa-cogs" /></c:when>
							<c:when test="${x==1}"><c:set var="iconClass" value="fa-search" /></c:when>
							</c:choose>
			 			<c:if test="${topCategories[x].menuPopupYn=='Y'}">
							<a href="${topCategories[x].menuLink}" target="_blank" title="새창열림" class="btn btn-primary"><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
			 			<c:if test="${topCategories[x].menuPopupYn!='Y'}">
							<a href="${topCategories[x].menuLink}${fn:indexOf(topCategories[x].menuLink,'?') > -1 ? '&' : '?' }menuNo=${topCategories[x].menuNo}" class="btn btn-primary"><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
						</c:forEach>
						<a href="javascript:openPopup();"class="btn btn-success"><i class="fa fa-power-off"></i>내정보수정</a>
						<a href="/bos/member/logout.do" class="btn btn-info"><i class="fa fa-power-off"></i> 로그아웃</a>
				 	</c:if>
				</div>
			</div>


			<div id="gnb">
			<c:if test="${fn:length(d02Categories)>0}">
				<ul class="gnb_width">
		 	<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth02}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(d02Categories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${d02Categories[y].menuPopupYn=='Y'}">
						<a href="${d02Categories[y].menuLink}" target="_blank" title="새창열림">${d02Categories[y].menuNm}</a>
		 			</c:if>
		 			<c:if test="${d02Categories[y].menuPopupYn!='Y'}">
						<a href="${d02Categories[y].menuLink}${fn:indexOf(d02Categories[y].menuLink,'?') > -1 ? '&' : '?' }menuNo=${d02Categories[y].menuNo}" >${d02Categories[y].menuNm}</a>
		 			</c:if>
		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			</div>

			<%--
			<div id="gnb">
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />
			<c:if test="${fn:length(topCategories)>0}">
				<ul class="gnb_width">
		 	<c:forEach var="y" begin="0" end="${fn:length(topCategories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth01}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(topCategories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${topCategories[y].menuPopupYn=='Y'}">
						<a href="${topCategories[y].menuLink}" target="_blank">${topCategories[y].menuNm}</a>
		 			</c:if>
		 			<c:if test="${topCategories[y].menuPopupYn!='Y'}">
						<a href="${topCategories[y].fullMenuLink}" >${topCategories[y].menuNm}</a>
		 			</c:if>
		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			</div>
			--%>
		</div>


<div class="inforSet">
	<div class="logo"><img src="/images/common/logo.png" alt="ckl" />	</div>
	<p>
		안녕하세요 <em>${adminUser.userNm}</em> 님.  통합 관리자 사이트에 접속하셨습니다. <br />
		관리자 사이트 문의사항은 <em class="col">[OOO팀] OOO OO (전화번호 : OOOO)</em>에게 문의하여 주시기 바랍니다
	</p>
</div>
</body>
</html>
