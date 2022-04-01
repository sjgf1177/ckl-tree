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
request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));
request.setAttribute("kakaoJavascriptKey", propertiesService.getString("Sns.kakaoJavascriptKey"));
request.setAttribute("linkedInAppKey", propertiesService.getString("Sns.linkedInAppKey"));

%>

<!doctype html>
<html lang="ko">
<head>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/jquery.cookies.js"></script>
<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script>
<script type="text/javascript" src="http://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/js/sns/kakao.js"></script>
<script src="https://apis.google.com/js/api:client.js"></script>
<script type="text/javascript" src="/js/sns/googlePlus.js"></script>



<script type="text/javascript">
//<![CDATA[
$(function() {

	// 페이스북 초기화
	$.sFacebook.initialize({
		clickBtn : 'fbLoginBtn',
		appId : '1713800738843219',
		fnData : function(id,name,email) {
			console.log("fb.user.id : " + id);
			console.log("fb.user.name : " + name);
			console.log("fb.user.email : " + email);
		}
	});

	// 구글 plus 초기화
	$.sGooglePlus.initialize({
		clickBtn : 'googleBtn',
		appId : '157755769959-cbsk82je6lvjderp3svor834o25q4ggf.apps.googleusercontent.com',
		fnData : function(id,name,email) {
			console.log("google.user.id : " + id);
			console.log("google.user.name : " + name);
			console.log("google.user.email : " + email);
		}
	});

	// 카카오 초기화
	$.sKakao.initialize({
		clickBtn : 'kakaoLoginBtn',
		appId : '1cfc0d4e029cf8bf4a39b6fcbf5cb2a3',
		fnData : function(id,name) {
			console.log("kakao.user.id : " + id);
			console.log("kakao.user.name : " + name);
		}
	});


	/*
	// 네이버 초기화
	 $.sNaver.initialize({
		clickBtn : 'naverLoginBtn',
		appId : 'Qx0rnOlyQo2e8JYE6DKO',
		secret : '1XrqT1Pbh7',
		redirect_uri : 'http://edu.kocca.dev.kr/sns/naverCallback.jsp'
	});
	*/
	var naver_login = new naver_id_login("Qx0rnOlyQo2e8JYE6DKO", "http://edu.kocca.dev.kr/sns/naverCallback.jsp");
	naver_login.setButton("green", 1,30);
	naver_login.setDomain(".kocca.dev.kr");
	var oDate = new Date();
	var state = oDate.getTime();
	naver_login.setState(state);
	naver_login.setPopup();
	naver_login.init_naver_id_login();


});

var fnNaverLoginCallback = function(id,name,email) {
	console.log("naver.user.id : " + id);
	console.log("naver.user.nickname : " + name);
	console.log("naver.user.email : " + email);
};

//]]>
</script>

</head>
<body>
<span style="margin-right:20px;"><a href="#" id="fbLoginBtn">[페이스북로그인]</a></span>
<span style="margin-right:20px;" id="naver_id_login"></span>
<span style="margin-right:20px;"><a href="#" id="kakaoLoginBtn">[카카오로그인]</a></span>
<span style="margin-right:20px;"><a href="#" id="googleBtn" onclick="return false;">[구글로그인]</a></span>

<div id="naver_id_login"></div>

</body>
</html>