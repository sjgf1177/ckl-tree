<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<ccc:constantsMap className="egovframework.com.cmm.service.Globals" var="Globals"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<title> <spring:message code="site.korName" text=""/> 로그인 </title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/bos/js/jquery.cookie.js"></script>
</head>
<body>
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
		var val = $.cookie('userId');
		if( val ) $("#userId").val(val);

	});

	function saveid(form) {
		$.cookie('userId', form.userId.value, { expires: 300 });
	}

	function actionLogin2()
	{
		var form = document.loginForm;
		var v = new MiyaValidator(form);
	    v.add("userId", {
	        required: true
	    });
	    v.add("pwd", {
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

<form name="loginForm" action ="/bos/member/login.do" method="post">
<input type="hidden" name="loginFlag" value="${param.loginFlag}" />
	<div class="bg_mng_main">
	<ul>
		<li><a href="#"><img src="/bos/images/sub/tab_mng01_off.gif" alt=""></a></li>
		<li><a href="#"><img src="/bos/images/sub/tab_mng02_on.gif" alt=""></a></li>
	</ul>
		<div class="tab2_main on">
            <input type="text" id="userId" name="userId" value="" class="poab01">
            <input type="password" autocomplete="off" name="pwd" value="" onkeydown="javascript:if (event.keyCode == 13) { actionLogin2(); }" class="poab02">
            <a href="javascript:actionLogin2();" class="poab03"><img src="/bos/images/sub/btn_mnglogin.gif" alt=""></a>
            <span class="poab04"><input type="checkbox" name="_spring_security_remember_me" value="true" onclick="javascript:saveid(document.loginForm);"> ID저장</span>
            <!--가상키보드 실행 버튼 생성태그 --><span id="usafeon_passwd" class="poab05"></span><!--//가상키보드 실행 버튼 생성태그 -->
		</div>
</div>
<p>${SPRING_SECURITY_LAST_EXCEPTION.message}</p>
<script>

</script>
</form>
</body>
</html>
