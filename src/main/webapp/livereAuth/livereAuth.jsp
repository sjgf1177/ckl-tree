<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	if (session.getAttribute("SPRING_SECURITY_CONTEXT") != null) {
		org.springframework.security.core.context.SecurityContext securityContext = (org.springframework.security.core.context.SecurityContext)session.getAttribute("SPRING_SECURITY_CONTEXT");
		org.springframework.security.core.Authentication auth = securityContext.getAuthentication();
		auth.getDetails();
		kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetails details = (kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetails) auth.getPrincipal();
		UsersVO user =details.getUsersVO();
		request.setAttribute("userVO", user);
	}
%>
<c:choose>
<c:when test="${not empty userVO }">
var additionalResult = new Object(); 
additionalResult.user_id = "${userVO.userKey }"; 
additionalResult.user_name = "${userVO.userNm }";
</c:when>
<c:otherwise>
var additionalResult = "";
</c:otherwise>
</c:choose>