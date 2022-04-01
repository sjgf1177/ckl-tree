<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.TimeZone" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%
org.springframework.context.ApplicationContext context = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
request.setAttribute("naverAppKey", propertiesService.getString("Sns.naverAppKey"));
request.setAttribute("naverCallbackUrl", propertiesService.getString("Sns.naverCallbackUrl"));
%>

<!doctype html>
<html lang="ko">
<head>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/jquery.cookies.js"></script>

</head>
<body>
<script type="text/javascript">
//<![CDATA[
var nave_login = new naver_id_login("<c:out value="${naverAppKey}"/>", "<c:out value="${naverCallbackUrl}"/>");
nave_login.get_naver_userprofile("popCallback()");

function popCallback() {
    var id = nave_login.getProfileData('id');
    var nickname = nave_login.getProfileData('nickname');
    var email = nave_login.getProfileData('email');
    var birthday = nave_login.getProfileData('birthday');
    var gender = nave_login.getProfileData('gender');
    if (!window.opener) window.opener = window.open('','mainwin');
    window.opener.fnNaverLoginCallback(id,nickname,email,birthday,gender);
	window.close();
}

//]]>
</script>
</body>
</html>