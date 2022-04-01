<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- footer -->
<div id="footer">
	<div class="mb20">
		<a href="https://www.ckl.or.kr/ckl/main/main.do?mobileTp=Ysdffd" class="btn btn-default">PC버전</a>
		<a href="#wrap" class="btn btn-default">맨위로</a>
	</div>
	<div class="fset">
		<div class="copy">Copyright Korea Creative Content Agency.<br/>All rights reserved.</div>
	</div>
</div>
<!-- //footer -->


<%
	String ip = request.getRemoteAddr();
	request.setAttribute("myIp", ip);
%>
<c:if test="${'127.0.0.1' eq myIp or '112.220.85.26' eq myIp }">
<div class="souceUrl"  style="color:#fff">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
</c:if>