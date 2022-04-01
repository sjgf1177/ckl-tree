<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>



<!doctype html>
<html lang="ko">
<head>
<title>통합로그인 &lt; 콘텐츠코리아랩</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<link rel="stylesheet" type="text/css" href="/fonts/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>

<link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"/>
<link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css" />
<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css" />

<!--[if lt IE 9]>
	<link rel="stylesheet" href="/edu/css/ie.css" type="text/css" />
	<script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
<!--[if lte IE 8]><script type="text/javascript"> $('html').attr('id','ie8'); </script><![endif]-->
<!--[if lte IE 7]><script type="text/javascript"> $('html').attr('id','ie7'); </script><![endif]-->


<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script>

<script type="text/javascript" src="/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/js/sns/kakao.js"></script>
<script src="https://apis.google.com/js/api:client.js"></script>
<script type="text/javascript" src="/js/sns/googlePlus.js"></script>

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[
$(function() {

	$(".ssoFrmBtn").click(function() {
		var url = $(this).attr("href");
		parent.location.href = url;
		return false;
	});

	// 페이스북 초기화
	$.sFacebook.initialize({
		clickBtn : 'fbLoginBtn',
		appId : '<c:out value="${facebookAppKey}" />',
		fnData : function(id,name,email) {
			$("#authKey2").val(id);
			$("#authSe2").val("04");
			$("#username2,#password2").empty();
			fnLoginSSO2();
			//$("#loginFormInc").submit();
			//console.log("fb.user.id : " + id);
			///console.log("fb.user.name : " + name);
			//console.log("fb.user.email : " + email);
		}
	});

	// 구글 plus 초기화
	$.sGooglePlus.initialize({
		clickBtn : 'googleBtn',
		appId : '<c:out value="${googlePlusAppKey}" />',
		fnData : function(id,name,email) {
			$("#authKey2").val(id);
			$("#authSe2").val("02");
			$("#username2,#password2").empty();
			fnLoginSSO2();
			//$("#loginFormInc").submit();
			//console.log("google.user.id : " + id);
			//console.log("google.user.name : " + name);
			//console.log("google.user.email : " + email);
		}
	});

	// 카카오 초기화
	$.sKakao.initialize({
		clickBtn : 'kakaoLoginBtn',
		appId : '<c:out value="${kakaoAppKey}" />',
		fnData : function(id,name) {
			$("#authKey2").val(id);
			$("#authSe2").val("01");
			$("#username2,#password2").empty();
			fnLoginSSO2();
			//$("#loginFormInc").submit();
			//console.log("kakao.user.id : " + id);
			//console.log("kakao.user.name : " + name);
		}
	});

	$("#naverLoginBtn").click(function() {
		$("#naver_id_login").find("a").click();
		return false;
	});


	var naver_login = new naver_id_login("<c:out value="${naverAppKey}" />", "<c:out value="${naverCallbackUrl}" />");
	naver_login.setButton("green", 1,0);
	//naver_login.setDomain(".kocca.dev.kr");
	var oDate = new Date();
	var state = oDate.getTime();
	naver_login.setState(state);
	naver_login.setPopup();
	naver_login.init_naver_id_login();

});

var fnNaverLoginCallback = function(id,name,email) {
	$("#authKey2").val(id);
	$("#authSe2").val("03");
	$("#username2,#password2").empty();
	fnLoginSSO2();
	//console.log("naver.user.id : " + id);
	//console.log("naver.user.nickname : " + name);
	//console.log("naver.user.email : " + email);
};

function actionLogin2()
{
	var form = document.loginFormInc;
	var v = new MiyaValidator(form);
    v.add("username", {
        required: true
    });
    v.add("password", {
        required: true
    });
	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}
	else
	{
		$("#authSe2").empty();
		fnLoginSSO2();

	}
}

function fnLoginSSO2() {
	var url = "/sso/member/toLoginSSO.json";
	var params = $("#loginFormInc").serialize();
	$.post(url,params, function(data) {
		var url = data.redirectUrl
		+ "/ckl/member/toLogin.do?ssoAuthToken="
		+ data.ssoAuthToken + "&saltkey="
		+ data.saltkey
		+ "&menuNo=<c:out value="${paramVO.menuNo}" />";
		//console.log(url);
		parent.location.href = url;
	},"json");
}
//]]>
</script>
</head>
<body style="background:#eaeaea;margin: 0;padding: 0;">

<!-- outLogin -->
<div class="outLoginSet">
	<div class="outLogin pb0">
		<form name="loginFormInc" id="loginFormInc" action="" method="post">
			<input type="hidden" name="loginFlag" value="${paramVO.loginFlag}" />
			<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
			<input type="hidden" name="_targetUrl" value="${_targetUrl}" />
			<input type="hidden" name="authSe" id="authSe2" value="" />
			<input type="hidden" name="authKey" id="authKey2" value="" />
			<input type="hidden" name="service" value="ckl" />
			<fieldset>
				<legend>회원 로그인 양식</legend>
				<input type="text" name="username" id="username2" class="mb3" value="아이디" title="아이디를 입력하세요." />
				<input type="password" name="password" id="password2" class="mb10" value="비밀번호" onkeydown="javascript:if (event.keyCode == 13) { actionLogin(); }" autocomplete="off" title="비밀번호를 입력하세요." />
				<div>
					<button type="submit" class="btn w100p" onclick="actionLogin2();return false;">로그인</button>
				</div>

				<script type="text/javascript">
				//<![CDATA[
					$("#password2").attr("type", "text");
					$("#password2").click(function(e){
						$("#password2").prop("type", "password");
					})
				//]]>
				</script>

				<h2 class="fs12">sns 계정으로 간편 로그인</h2>

				<div class="icoBox">
					<ul class="list-inline">
						<li><a href="javascript:void(0);" title="페이스북으로 로그인" id="fbLoginBtn"><img src="/ckl/images/common/outLogin_01.gif" /></a></li>
						<li><a href="javascript:void(0);" title="네이버로 로그인" id="naverLoginBtn"><img src="/ckl/images/common/outLogin_02.gif" /></a></li>
						<li><a href="javascript:void(0);" title="카카오톡으로 로그인" id="kakaoLoginBtn"><img src="/ckl/images/common/outLogin_03.gif" /></a></li>
						<li class="mr0"><a href="javascript:void(0);" title="구글 플러스로 로그인" id="googleBtn"><img src="/ckl/images/common/outLogin_04.gif" /></a></li>
					</ul>
				</div>
				<div class="mt20">
					<a href="${domain }/ckl/member/join01.do?menuNo=200054" class="btn w100p btn-danger ssoFrmBtn">회원가입</a>
				</div>
			</fieldset>
		</form>
	</div>
</div>
<!-- //outLogin -->

<div id="naver_id_login" style="display:none;"></div>

</body>
</html>