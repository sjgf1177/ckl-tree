<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<ccc:constantsMap className="egovframework.com.cmm.service.Globals" var="Globals"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title> <spring:message code="site.korName" text=""/> 관리자페이지 로그인(#번) </title>


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<style  type="text/css">
body{background:#f5f5f5}
.idsave{clear: both;display: block !important;margin-left: 80px;}
.idsave input{position: relative !important;vertical-align: middle;margin: 0;}
.bg_mng_main{background:#fff;-webkit-box-shadow: 3px 3px 5px 0px rgba(50, 50, 50, 0.16);-moz-box-shadow:3px 3px 5px 0px rgba(50, 50, 50, 0.16);box-shadow:3px 3px 5px 0px rgba(50, 50, 50, 0.16);}

</style>

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/bos/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/ssl.js"></script>
</head>
<body class="login">
	<script type="text/javascript">
  	$(function(){
		var linkgo=$(".bg_mng_main li a");
		linkgo.each(function(){
		$(this).bind('click' , function(){

			var imgo = $('.bg_mng_main li').find('a');
			var imgo2 = $('.bg_mng_main').find('div');
			imgOff(imgo);
			imgOn($(this));
			var linkgo2 = $(this).parent().index();
			$(imgo2).removeClass("on");
			$(imgo2[linkgo2]).addClass("on");
			return false;
			});
		});
		var val = $.cookie('username');
		if( val ) $("#username").val(val);

	});

	function saveid(form) {
		$.cookie('username', form.username.value, { expires: 300 });
	}

	function actionLogin2()
	{
		var form = document.loginForm;
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
			form.submit();
		}
	}
  </script>

<form name="loginForm" action ="/bos/member/toLogin.do" method="post">
<input type="hidden" name="siteName" value="bos" />
<input type="hidden" name="loginFlag" value="${param.loginFlag}" />
	<div class="bg_mng_main">
		<p class="logo" style="top:-60px"><img src="/images/common/logo.png" alt="" /></p>
		<h1 class="titles">ID/PW 로그인</h1>
		<div class="tab2_main on">
            <label for="username"><i class="fa fa-user"><span class="hidden">아이디</span></i></label> <input id="username" name="username" type="text" value="" class="poab01">
            <br />
           	<label for="password"><i class="fa fa-unlock-alt"><span class="hidden">비밀번호</span></i></label> <input autocomplete="off" name="password" type="password" value="" onkeydown="javascript:if (event.keyCode == 13) { actionLogin2(); }" class="poab02">
            <a href="javascript:actionLogin2();" class="poab03"><img src="/bos/images/sub/btn_mnglogin.gif" alt=""></a>
           	<div class="idsave">
           		<label for="_spring_security_remember_me"><input type="checkbox" id="_spring_security_remember_me" name="_spring_security_remember_me" value="true" onclick="javascript:saveid(document.loginForm);"> ID저장</label>
           	</div>
            <!--가상키보드 실행 버튼 생성태그 --><span id="usafeon_passwd" class="poab05"></span><!--//가상키보드 실행 버튼 생성태그 -->
		</div>
	</div>
<p>${SPRING_SECURITY_LAST_EXCEPTION.message}</p>
</form>
</body>
</html>
