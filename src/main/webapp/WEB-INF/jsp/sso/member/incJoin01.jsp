<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="siteNm" value="${paramVO.service}"/>
<%
	String domain = request.getServerName();
	session.setAttribute("ssoDomain2", domain);

	String requestUri = request.getRequestURL().toString();
	String host = request.getRemoteHost();

	String menuNo = request.getParameter("menuNo");
	String siteNm = (String)pageContext.getAttribute("siteNm");  

	response.setHeader("Cache-Control","no-store"); //메모리에 캐쉬되는 것을 막는다. HTTP 1.1
	response.setDateHeader("Expires",0);   //Proxy Server에 캐쉬되는 것 막는다.
%>



<!doctype html>
<html lang="ko">
<head>
<title>회원가입 | 에듀코카</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<META http-equiv="Pragma" content="no-cache"> 
<META http-equiv="Cache-Control" content="no-cache">


<link rel="stylesheet" type="text/css" href="/fonts/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>
<c:set var="paramService" value="${paramVO.service}" />
<c:if test='${paramService eq "testbed"}'>
	<c:set var="paramService" value="edu" />
</c:if>
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService }"/>/css/bootstrap.reset.css"/>
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService }"/>/css/animate.min.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService }"/>/css/common.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService }"/>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramService }"/>/css/sub.css" />


<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script>

<script type="text/javascript" src="/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script>

<!--[if lt IE 9]>
	<link rel="stylesheet" href="/edu/css/ie.css" type="text/css" />
	<script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
<!--[if lte IE 8]><script type="text/javascript"> $('html').attr('id','ie8'); </script><![endif]-->
<!--[if lte IE 7]><script type="text/javascript"> $('html').attr('id','ie7'); </script><![endif]-->

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[
window.name='mainwin';
$(function() {

	// 페이스북 초기화
	$.sFacebook.initialize({
		clickBtn : 'fbLoginBtn',
		appId : '<c:out value="${facebookAppKey}" />',
		fnData : function(id,name,email) {
			$("#authKey").val(id);
			$("#authSe").val("04");
			$("#email").val(email);
			//$("#brthdy").val(birthday);
			//$("#sex").val(sex);
			$("#AuthForm").submit();
			//console.log("fb.user.id : " + id);
			///console.log("fb.user.name : " + name);
			//console.log("fb.user.email : " + email);
		}
	});

	/*
	// 네이버 초기화
	 $.sNaver.initialize({
		clickBtn : 'naverLoginBtn',
		appId : 'Qx0rnOlyQo2e8JYE6DKO',
		secret : '1XrqT1Pbh7',
		//redirect_uri : 'http://edu.kocca.dev.kr/sns/naverCallback.jsp',
		redirect_uri : 'http://edu.kocca.dev.kr/edu/member/forLogin.do?menuNo=500077',

		fnData : function(id,name) {
			console.log("kakao.user.id : " + id);
			console.log("kakao.user.name : " + name);
		}
	});
	*/
	var naver_login = new naver_id_login("${naverAppKey}", "${naverCallbackUrl}");
	naver_login.setButton("green", 1,30);
	//naver_login.setDomain(".kocca.dev.kr");
	var oDate = new Date();
	var state = oDate.getTime();
	naver_login.setState(state);
	naver_login.setPopup();
	naver_login.init_naver_id_login();


	$(".btn-primary").click(function() {
		var authSe = jQuery("input[name=authSe]:radio:checked");

		if (authSe.length == 0) {
			jQuery("input[name=authSe]:radio").focus();
			alert("인증방식을 선택하십시오.");
			return;
		}
		else {
			if (authSe.val() == "01") {
				$("#AuthForm").submit();
			}
			else if (authSe.val() == "03") {
				$("#naver_id_login").find("a").click();
				return false;
			}
			else if (authSe.val() == "04") {
				$("#fbLoginBtn").click();
				return false;
			}
		}
	});

	$('input:radio[name=authSe]').click(function(){
		if($(this).val() == '01'){
			$('.clear.tar.mt50 .btn-primary:eq(0)').show();
			$('.clear.tar.mt50 .btn-primary:eq(1)').hide();
		}else{
			$('.clear.tar.mt50 .btn-primary:eq(0)').hide();
			$('.clear.tar.mt50 .btn-primary:eq(1)').show();
		}
	});
	
});

var fnNaverLoginCallback = function(id,name,email,birthday,gender) {
	$("#authKey").val(id);
	$("#authSe").val("03");
	$("#email").val(email);
	//$("#brthdy").val(birthday);
	$("#sex").val(gender);
	$("#AuthForm").submit();
	//console.log("naver.user.id : " + id);
	//console.log("naver.user.nickname : " + name);
	//console.log("naver.user.email : " + email);
};

//]]>
</script>
</head>
<body style="background:#fff">
	<%
	if( siteNm.indexOf("edu") != -1 || siteNm.indexOf("testbed") != -1 ){ 
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
<div class="memberStep1">

	<div class="signup_step_bar">
		<div class="step_wrap active">
			<p class="step_box">
				<span class="step_title">STEP1</span>
				인증방식선택
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP2</span>
				이용약관동의
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP3</span>
				입력항목작성
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP4</span>
				가입완료
			</p>
		</div>
	</div>

	<h5 class="border">인증방식</h5>

	<div class="authFrom">
	<form name="AuthForm" id="AuthForm" action="<c:out value="${redirectUrl }" />/<c:out value="${paramVO.service }" />/member/vnameOutput.do" target="_top" method="post">
		<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
		<input type="hidden" name="service" id="service" value="edu" />
		<input type="hidden" name="authKey" id="authKey" value="" />
		<input type="hidden" name="email" id="email" value="" />
		<input type="hidden" name="brthdy" id="brthdy" value="" />
		<input type="hidden" name="sex" id="sex" value="" />
		<input type="hidden" name="age" id="age" value="" />
		<div>
			<div class="signup_method_con">
				<div class="signup_method_wrap right">
					<div class="signup_radio_wrap">
						<span>
							<input type="radio" name="authSe" value="01" id="authSe1" alt="휴대폰/이메일 인증으로 가입" title="휴대폰/이메일 인증으로 가입">
							<label class="no_text_iagme pm" for="authSe1"><span class="blind">휴대폰 / 이메일 인증으로 가입</span></label>
						</span>
					</div>
					<h6><span>휴대폰 / 이메일</span> 인증으로 가입</h6>
					<hr class="h_line6">
					<p class="h_desc6">
						본인이 사용하는 휴대폰 또는 이메일 주소에
						인증번호를 발송하여 입력하는 방식입니다.
						(휴대폰이 반드시 본인 소유가 아니라도 가능합니다. )
					</p>
				</div>
				<div class="signup_method_wrap left">
					<div class="signup_radio_wrap">
						<span>
							<input type="radio" name="authSe" value="04" id="fbIdBtn" alt="페이스북 인증으로 가입" title="페이스북 인증으로 가입">
							<label class="no_text_iagme fb" for="fbIdBtn" class="fb"><span class="blind">페이스북 인증으로 가입</span></label>
						</span>
						<span>
							<input type="radio" name="authSe" value="03" id="naverLoginBtn" alt="네이버 인증으로 가입" title="네이버 인증으로 가입">
							<label class="no_text_iagme na" for="naverLoginBtn" class="na"><span class="blind">네이버 인증으로 가입</span></label>
						</span>
						<div id="naver_id_login" style="display:none;"></div>
						<div style="display:none;"><a id="fbLoginBtn"></a></div>
					</div>
					<h6><span>SNS</span> 인증으로 가입</h6>
					<hr class="h_line6">
					<p class="h_desc6">
						SNS을 이용한 인증 방식입니다.
						SNS에서 제공되는 인증방식으로
						인증하신 후 추가 정보를 입력하실 수 있습니다.
					</p>
				</div>
			</div>
		</div>
		<div class="board_util_btn_con">
			<button class="btn_style_0 full right btn-primary" title="다음">다음</button>
<!-- 			<a href="#self" id="btnIcoCheck" class="btn_style_0 full right btn-primary" style="margin-right: 0;">다음</a> -->
<!-- 			<a href="#self" title="새창열림" id="btnIcoCheck" class="btn_style_0 full right btn-primary" style="display:none;">다음</a> -->
		</div>
	</form>
	</div>
</div>
<%
	}else{
%>
<div class="memberStep1">
	<div class="stepInline">
		<ol>
			<li class="on">인증방식 선택<span class="sr-only">(현재단계)</span></li>
			<li>입력항목 작성</li>
			<li>가입완료</li>
		</ol>
	</div>

	<h2>인증방식 선택</h2>

	<div class="authFrom">
	<form name="AuthForm" id="AuthForm" action="<c:out value="${redirectUrl }" />/<c:out value="${paramVO.service }" />/member/vnameOutput.do" target="_top" method="post">
		<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
		<input type="hidden" name="service" id="service" value="${paramVO.service}" />
		<input type="hidden" name="authKey" id="authKey" value="" />
		<input type="hidden" name="email" id="email" value="" />
		<input type="hidden" name="brthdy" id="brthdy" value="" />
		<input type="hidden" name="sex" id="sex" value="" />
		<input type="hidden" name="age" id="age" value="" />
			<div>
				<div class="authPhone">
					<div class="tac mt45">
						<label for="authSe1">
							<h3 class="tac mb0"><span class="snsIcos1 snsico105"><span class="sr-only">휴대폰/이메일 인증</span></span></h3>
							<input type="radio" name="authSe" value="01" id="authSe1">
						</label>
						<p class="tal ml60 mt20">본인이 사용하는 휴대폰 또는 이메일 주소에<br />
							인증번호를 발송하여 입력하는 방식입니다.<br />
							(휴대폰이 반드시 본인 소유가 아니라도 가능합니다. )
						</p>
					</div>
				</div>

				<div class="authSns tac">
					<div class="fl mt45 w100p">
						<div class="fl w50p">
							<label for="fbIdBtn">
							<h3 class="tac mb0"><span class="snsIcos1 snsico102"><span class="sr-only">페이스북으로 가입하기</span></span></h3>
							<input type="radio" name="authSe" value="04" id="fbIdBtn"></label>
							<!-- <div class="snsIcos tac">
								<a href="#self" title="새창열림" class="snsIcoL snsico03" id="fbLoginBtn"><span class="sr-only">페이스북으로 로그인</span></a>
							</div> -->
						</div>
						<div class="fl w50p">
							<label for="naverLoginBtn">
							<h3 class="tac"><span class="snsIcos1 snsico101"><span class="sr-only">네이버</span></span></h3>
							<input type="radio" name="authSe" value="03" id="naverLoginBtn">
							</label>
						</div>
						<div id="naver_id_login" style="display:none;"></div>
						<div style="display:none;"><a id="fbLoginBtn"></a></div>
					</div>
					<div class="fl tal ml60 pt10">SNS을 이용한 인증 방식입니다.<br />
					SNS에서 제공되는 인증방식으로 인증하신 후 추가 정보를 입력하실 수 있습니다.</div>
				</div>
			</div>
		</form>
	</div>

	<div class="clear tar mt50">
		<a href="#self" id="btnIcoCheck" class="btn btn-primary">다음</a>
		<a href="#self" title="새창열림" id="btnIcoCheck" class="btn btn-primary" style="display:none;">다음</a>
	</div>
</div>
<%} %>
</body>
</html>