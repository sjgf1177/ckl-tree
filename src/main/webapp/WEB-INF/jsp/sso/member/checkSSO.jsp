<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html lang="ko">
<head>
<title>통합 로그인</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<c:if test="${not empty ssoAuthToken and paramVO.userTp eq '0'}">
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
//<![CDATA[
fnCheckSSO();
function fnCheckSSO() {
	var url = "/sso/member/checkSSO.json";
	var params = {
		menuNo : '<c:out value="${paramVO.menuNo}" />',
		service : '<c:out value="${paramVO.service}" />',
		jsonTp : 'Y'
	};
	$.post(url,params, function(data) {
		var authurl = data.domain
		+ "/<c:out value="${paramVO.service}" />/member/toLogin.do?ssoAuthToken="
		+ data.ssoAuthToken + "&saltkey="
		+ data.saltkey
		+ "&menuNo=<c:out value="${paramVO.menuNo}" />";
		//console.log(authurl);
		parent.location.href = authurl;
	},"json");
}
//]]>
</script>
</c:if>
</head>
<body></body>
</html>