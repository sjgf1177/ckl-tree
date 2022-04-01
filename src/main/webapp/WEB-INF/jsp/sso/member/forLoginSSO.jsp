<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.com.cmm.service.Globals"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@ page import="kr.co.unp.banner.vo.Banner"%>
<%@ page import="kr.co.unp.banner.service.BannerService"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<c:set var="siteNm" value="${paramVO.service}"/>
<%
	String domain = request.getServerName();
/* 	session.setAttribute("ssoDomain2", domain);
	
	String requestUri = request.getRequestURL().toString();
	String host = request.getRemoteHost();

	String menuNo = request.getParameter("menuNo");
	String siteNm = (String)pageContext.getAttribute("siteNm");  

	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.EDUMOBILE_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);
	org.springframework.context.ApplicationContext context =
			org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo); */
%>
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<c:set var="pathData0" value="${pathData[0]}" />
<c:choose>
	<c:when test="${fn:indexOf(pathData0 , '콘텐츠문화광장') != -1 }">
		<c:set var="joinMenuNo" value="600129"/>
		<c:set var="idMenuNo" value="600132"/>
		<c:set var="pwMenuNo" value="600133"/>
	</c:when>
	<c:otherwise>
		<c:set var="joinMenuNo" value="600140"/>
		<c:set var="idMenuNo" value="600143"/>
		<c:set var="pwMenuNo" value="600144"/>
	</c:otherwise>
</c:choose>

<!doctype html>
<html lang="ko">
<head>
<title>로그인 | 에듀코카</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<link rel="stylesheet" type="text/css" href="/fonts/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css" />

<c:set var="paramService" value="${paramVO.service}" />
<c:if test='${paramService eq "testbed"}'>
	<c:set var="paramService" value="edu" />
</c:if>

<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService}"/>/css/bootstrap.reset.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService}"/>/css/animate.min.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService}"/>/css/common.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService}"/>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService}"/>/css/sub.css" />

<script type="text/javascript" src="/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/base64.js"></script>

<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/js/sns/kakao.js"></script>
<script src="https://apis.google.com/js/api:client.js"></script>
<script type="text/javascript" src="/js/sns/googlePlus.js"></script>

<script type="text/javascript" src="/js/miya_validator.js"></script>


<!--[if lt IE 9]>
<link rel="stylesheet" href="/edu/css/ie.css" type="text/css" />
<script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
<script type="text/javascript" src="/js/respond.min.js"></script>
<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
<!--[if lte IE 8]><script type="text/javascript"> $('html').attr('id','ie8'); </script><![endif]-->
<!--[if lte IE 7]><script type="text/javascript"> $('html').attr('id','ie7'); </script><![endif]-->

<script type="text/javascript">
	//<![CDATA[
	window.name = 'mainwin';
	$(function() {

		$("#username").focus();

		$(".ssoFrmBtn").click(function() {
			var url = $(this).attr("href");
			parent.location.href = url;
			return false;
		});

		// 페이스북 초기화
		$.sFacebook.initialize({
			clickBtn : 'fbLoginBtn',
			appId : '<c:out value="${facebookAppKey}" />',
			fnData : function(id, name, email) {
				$("#authKey").val(id);
				$("#authSe").val("04");
				$("#username,#password").empty();
				fnLoginSSO();
				//$("#loginForm").submit();
				//console.log("fb.user.id : " + id);
				///console.log("fb.user.name : " + name);
				//console.log("fb.user.email : " + email);
			}
		});

		// 구글 plus 초기화
		$.sGooglePlus.initialize({
			clickBtn : 'googleBtn',
			appId : '<c:out value="${googlePlusAppKey}" />',
			fnData : function(id, name, email) {
				$("#authKey").val(id);
				$("#authSe").val("02");
				$("#username,#password").empty();
				fnLoginSSO();
				//$("#loginForm").submit();
				//console.log("google.user.id : " + id);
				//console.log("google.user.name : " + name);
				//console.log("google.user.email : " + email);
			}
		});

		// 카카오 초기화
		$.sKakao.initialize({
			clickBtn : 'kakaoLoginBtn',
			appId : '<c:out value="${kakaoAppKey}" />',
			fnData : function(id, name) {
				$("#authKey").val(id);
				$("#authSe").val("01");
				$("#username,#password").empty();
				fnLoginSSO();
				//$("#loginForm").submit();
				//console.log("kakao.user.id : " + id);
				//console.log("kakao.user.name : " + name);
			}
		});

		$("#naverLoginBtn").click(function() {
			$("#naver_id_login").find("a").click();
			return false;
		});

		var naver_login = new naver_id_login(
				"<c:out value="${naverAppKey}" />",
				"<c:out value="${naverCallbackUrl}" />");
		naver_login.setButton("green", 1, 0);
		//naver_login.setDomain(".ckl.dev.kr");
		var oDate = new Date();
		var state = oDate.getTime();
		naver_login.setState(state);
		naver_login.setPopup();
		naver_login.init_naver_id_login();

	});

	var fnNaverLoginCallback = function(id, name, email) {
		$("#authKey").val(id);
		$("#authSe").val("03");
		$("#username,#password").empty();
		fnLoginSSO();
		//console.log("naver.user.id : " + id);
		//console.log("naver.user.nickname : " + name);
		//console.log("naver.user.email : " + email);
	};

	function actionLogin() {
		$.ajaxSetup({
			async : true
		});

		var form = document.loginForm;
		var v = new MiyaValidator(form);
		v.add("username", {
			required : true
		});
		v.add("password", {
			required : true
		});
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		} else {
			$("#authSe").empty();
			fnLoginSSO();

		}
	}

	function fnLoginSSO() {
		$(".loadingBox").show();
		var url = "/sso/member/toLoginSSO.json";
		//alert(url);

		//$("#username").val(Base64.encode($("#username").val()));
		//$("#password").val(Base64.encode($("#password").val()));

		var params = $("#loginForm").serialize();
		$
				.post(
						url,
						params,
						function(data) {
							//alert("post result");
							//alert(data.ssoAuthToken);
							var returl = data.redirectUrl
									+ "/<c:out value="${paramVO.service}" />/member/toLogin.do?ssoAuthToken="
									+ data.ssoAuthToken
									+ "&saltkey="
									+ data.saltkey
									+ "&menuNo=<c:out value="${paramVO.menuNo}" />"
									+ "&redirectUrl=<c:url value="${param.redirectUrl}" />";
							//console.log(url);
							//alert(returl);
							//$("#loginFormSSO").attr("action",returl);
							//$("#loginFormSSO").submit();
							window.parent.location.href = returl;
							return false;
						}, "json");
	}
	//]]>
</script>
</head>
<body style="background: #fff">

	<form name="loginFormSSO" id="loginFormSSO" action="#" target="_top" method="post"></form>

	<div class="loadingBox" style="display: none;">
		<div class="loading">
			<img src="/images/common/loading.gif" alt="문서가 로딩중입니다." width="100" height="100">
		</div>
	</div>
	
	<%
	if( siteNm.indexOf("edu") != -1 || siteNm.indexOf("testbed") != -1 || siteNm.indexOf("edumobile") != -1 ){ 
	%>


	<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/animate.min.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/base.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/bootstrap.reset.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/common_prev.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/contents.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/flaticon.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/ie.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/layout.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/main_prev.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/member.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/portfolio.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/search.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/submain.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/common.css">
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/wevenResponsive.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/main.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub_layout.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub_page.css"/>

	<div class="login_wrap">
	    <form class="login_form" name="loginForm" id="loginForm" action="#" method="post">
			<input type="hidden" name="loginFlag" value="${paramVO.loginFlag}" />
			<input type="hidden" name="menuNo" value="${paramVO.menuNo}" /> 
			<input type="hidden" name="_targetUrl" value="${_targetUrl}" /> 
			<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
			<input type="hidden" name="authSe" id="authSe" value="" /> 
			<input type="hidden" name="authKey" id="authKey" value="" /> 
			<input type="hidden" name="service" id="service" value="${paramVO.service}" />
	        <div class="login_box">
	            <div class="input_style_1_con">
	                <input type="text" class="input_style_1" name="username" id="username" placeholder="아이디입력" title="아이디 입력">
	                <label for="username" class="back_label">아이디 입력</label>
	            </div>
	            <div class="input_style_1_con">
	                <input type="password" class="input_style_1" name="password" id="password" autocomplete="off" placeholder="비밀번호입력" title="비밀번호 입력">
	                <label for="password" class="back_label">비밀번호 입력</label>
	            </div>
	            <div class="input_style_1_con submit">
	                <input type="submit" onclick="actionLogin();return false;" class="input_style_1" name="usersubmit" id="usersubmit">
	                <label for="usersubmit">로그인</label>
	            </div>
	        </div>
	        <ul class="login_util_list" data-service='${paramVO.service}'>
	        	<c:choose>
					<c:when test="${paramVO.service eq 'edu'}">
					<li><a href="${domain }/edu/member/join01.do?menuNo=500076" class="ssoFrmBtn">회원가입</a></li>
		            <li><a href="${domain }/edu/userMember/idSearch.do?menuNo=500083" class="ssoFrmBtn">아이디 찾기</a></li>
		            <li><a href="${domain }/edu/userMember/pwdSearch.do?menuNo=500084" class="ssoFrmBtn">비밀번호 찾기</a></li>
					</c:when>
					<c:when test="${paramVO.service eq 'edumobile'}">
		            <li><a href="${domain }/edumobile/userMember/idSearch.do?menuNo=${idMenuNo}" class="ssoFrmBtn">아이디 찾기</a></li>
		            <li><a href="${domain }/edumobile/userMember/pwdSearch.do?menuNo=${pwMenuNo}" class="ssoFrmBtn">비밀번호 찾기</a></li>
					</c:when>
					<c:when test="${paramVO.service eq 'testbed'}">
					<li><a href="${domain }/testbed/member/join01.do?menuNo=700121" class="ssoFrmBtn">회원가입</a></li>
		            <li><a href="${domain }/testbed/userMember/idSearch.do?menuNo=700123" class="ssoFrmBtn">아이디 찾기</a></li>
		            <li><a href="${domain }/testbed/userMember/pwdSearch.do?menuNo=700124" class="ssoFrmBtn">비밀번호 찾기</a></li>
					</c:when>
					<c:otherwise>
					<li><a href="${domain }/ckl/member/join01.do?menuNo=200054" class="ssoFrmBtn">회원가입</a></li>
		            <li><a href="${domain }/ckl/userMember/idSearch.do?menuNo=200056" class="ssoFrmBtn">아이디 찾기</a></li>
		            <li><a href="${domain }/ckl/userMember/pwdSearch.do?menuNo=200058" class="ssoFrmBtn">비밀번호 찾기</a></li>
					</c:otherwise>
				</c:choose>
	        </ul>
	    </form>
	    <div class="sns_login_con">
	        <p class="sns_login_caption">
	            아래의 SNS 계정으로 로그인이 가능합니다.
	        </p>
	        <div class="sns_type_select_con">
	            <div class="sns_login_type naver">
	                <a href="#self" title="네이버 로그인 새창열림" class="icon_box" id="naverLoginBtn"></a>
	                <p class="text_box">네이버</p>
	            </div>
	            <div class="sns_login_type facebook">
	                <a href="#self" title="페이스북 로그인 새창열림" class="icon_box" id="fbLoginBtn"></a>
	                <p class="text_box">페이스북</p>
	            </div>
	            <div class="sns_login_type kakaotalk">
	                <a href="#self" title="카카오톡 로그인 새창열림" class="icon_box" id="kakaoLoginBtn"></a>
	                <p class="text_box">카카오톡</p>
	            </div>
	            <div class="sns_login_type google">
	                <a href="#self" title="구글 로그인 새창열림" class="icon_box" id="googleBtn"></a>
	                <p class="text_box">구글</p>
	            </div>
	        </div>
	        <div id="naver_id_login" style="display: none;"></div>
	    </div>
	</div>
	
	<%
	}else{
	%>


	<div class="member mb50 clear" style="width: 1000px; margin: 0 auto">
		<div class="row memberLogin">
			<div class="col-md-6 idLogin">
				<h2 class="pt10">회원정보로 로그인</h2>
				<form name="loginForm" id="loginForm" action="#" method="post">
					<input type="hidden" name="loginFlag" value="${paramVO.loginFlag}" />
					<input type="hidden" name="menuNo" value="${paramVO.menuNo}" /> 
					<input type="hidden" name="_targetUrl" value="${_targetUrl}" /> 
					<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
					<input type="hidden" name="authSe" id="authSe" value="" /> 
					<input type="hidden" name="authKey" id="authKey" value="" /> 
					<input type="hidden" name="service" id="service" value="${paramVO.service}" />
					<fieldset>
						<legend>회원정보 로그인 입력</legend>
						<label for="username">아이디</label> 
						<input type="text" name="username" id="username" value="" /> 
						<label for="password">비밀번호</label>
						<input type="password" name="password" id="password" value="" autocomplete="off" />
						<%--
						<script type="text/javascript">
						//<![CDATA[
							$("#password").attr("type", "text");
							$("#password").bind("click focus",function(e){
								$("#password").prop("type", "password");
							})
						//]]>
						</script>
						--%>
						<button type="submit" onclick="actionLogin();return false;" class="btn btn-primary">로그인</button>

					</fieldset>
				</form>

				<div class="tac mb30">
					<div class="loginLinks">
						<c:choose>
							<c:when test="${paramVO.service eq 'edu'}">
								<a href="${domain }/edu/member/join01.do?menuNo=500076" class="ssoFrmBtn">회원가입</a> |
								<a href="${domain }/edu/userMember/idSearch.do?menuNo=500083" class="ssoFrmBtn">아이디 찾기</a> | 
								<a href="${domain }/edu/userMember/pwdSearch.do?menuNo=500084" class="ssoFrmBtn">비밀번호 찾기</a>
							</c:when>
							<c:otherwise>
								<a href="${domain }/ckl/member/join01.do?menuNo=200054" class="ssoFrmBtn">회원가입</a> |
								<a href="${domain }/ckl/userMember/idSearch.do?menuNo=200056" class="ssoFrmBtn">아이디 찾기</a> |
								<a href="${domain }/ckl/userMember/pwdSearch.do?menuNo=200058" class="ssoFrmBtn">비밀번호 찾기</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="idLogin">
					<h2 class="pt10">SNS 계정으로 로그인</h2>

					<div class="snsIcos tac">
						<a href="#self" title="새창열림" class="snsIcoL snsico01" id="naverLoginBtn"><span class="sr-only">네이버로 로그인</span></a> 
						<a href="#self" title="새창열림" class="snsIcoL snsico02" id="kakaoLoginBtn"><span class="sr-only">카카오톡으로 로그인</span></a> 
						<a href="#self" title="새창열림" class="snsIcoL snsico03" id="fbLoginBtn"><span class="sr-only">페이스북으로 로그인</span></a> 
						<a href="#self" title="새창열림" class="snsIcoL snsico04" id="googleBtn"><span class="sr-only">구글로 로그인</span></a>
						<!--
						<a href="#self" title="새창열림" class="snsIcoL snsico05"><span class="sr-only">트위터로 로그인</span></a>
						-->
					</div>
					<div class="loginLinks">
						<p class="tac">※ 간편로그인 설정 또는 SNS로 인증한 계정으로 로그인해주시기 바랍니다.</p>
					</div>
				</div>
			</div>
			<div id="naver_id_login" style="display: none;"></div>
		</div>
	</div>
	
	<%} %>
</body>
</html>