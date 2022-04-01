<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize ifAnyGranted="ROLE_USER">
	<script type="text/javascript">
	location.href = "/cklmobile/fcltyResve/resveSttus/listMypage.do?menuNo=400016";
	</script>
</sec:authorize>

<%
	String domain = request.getServerName();
	session.setAttribute("ssoDomain", domain);
%>


<script type="text/javascript">
//<![CDATA[
$(function() {

	$("#username").focus();

});


function actionLogin()
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

	form.submit();
}


//]]>
</script>
</head>
<body style="background:#fff">

<div class="loadingBox" style="display:none;">
	<div class="loading">
		<img src="/images/common/loading.gif" alt="문서가 로딩중입니다." width="100" height="100">
	</div>
</div>


<div class="member clear">
	<div class="memberLogin">
		<div class="idLogin pl10 pr10">
			<h2>회원정보<span class="fn">로 로그인 해주세요.</span></h2>
			<p class="text-danger fs12">회원가입, 아이디/비밀번호 찾기 등의 회원기능은 PC버전에서 가능합니다.</p>

			<form name="loginForm" id="loginForm" action="/cklmobile/member/toLogin.do" method="post">
				<input type="hidden" name="loginFlag" value="${paramVO.loginFlag}" />
				<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
				<fieldset>
					<legend>회원정보 로그인 입력</legend>
					<div class="idArea">
						<label for="username" class="idIcos"><span class="hidden">아이디</span></label>
						<input type="text" name="username" id="username" value="" title="아이디를 입력해 주세요." />
					</div>
					<div class="pwArea">
						<label for="password" class="pwIcos"><span class="hidden">비밀번호</span></label>
						<input type="password" name="password" id="password" value="" autocomplete="off" title="비밀번호를 입력해 주세요." />
					</div>
					<button type="submit" onclick="actionLogin();return false;" class="btn btn-primary">로그인</button>
				</fieldset>
			</form>
			<script type="text/javascript">
			//<![CDATA[
				$("#username").bind("click", function(){
					$(this).parent().addClass("on");
					$(".pwArea").removeClass("on");
				});
				$("#password").bind("click", function(){
					$(this).parent().addClass("on");
					$(".idArea").removeClass("on");
				})
			//]]>
			</script>


		</div>


	</div>
</div>
</body>
</html>