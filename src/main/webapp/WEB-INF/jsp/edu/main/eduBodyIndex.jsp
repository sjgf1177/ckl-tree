<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);
%>
<c:set var="userVO" value="${userVO }" scope="request" />
<!doctype html>
<html lang="ko">
<head>
	<c:set var="title" value="에듀코카" />
	<title>${title}</title>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<jsp:include page="/WEB-INF/jsp/edu/inc/eduHead.jsp" flush="true" />

<title>에듀코카</title>
</head>
<body>
<div class="popup">
	<c:choose>
		<c:when test="${not empty cvCon}">
			${cvCon}
		</c:when>
		<c:otherwise>
			<c:set var="_includePage" value="" />
			<c:choose>
				<c:when test="${not empty param.incPage}"><c:set var="_includePage" value="${incPage}" /></c:when>
				<c:when test="${empty includePage}"><c:set var="_includePage" value="${currMenu.contentsPath}" /></c:when>
				<c:otherwise><c:set var="_includePage" value="${includePage}" /></c:otherwise>
			</c:choose>
			<c:catch var ="catchException">
				<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true">
					<jsp:param name="menuNm" value="${currMenu.menuNm }" />
				</jsp:include>
			</c:catch>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>