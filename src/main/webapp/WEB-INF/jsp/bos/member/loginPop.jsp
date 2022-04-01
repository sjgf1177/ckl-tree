<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>관리자 인증서 등록</title>
<link rel="stylesheet" type="text/css" href="/bos/renewal/css/reset.css">
<link rel="stylesheet" type="text/css" href="/bos/css/common.css">
<link rel="stylesheet" type="text/css" href="/bos/renewal/css/layout.css">
<link rel="stylesheet" type="text/css" href="/portal/css/sub.css">
<link rel="stylesheet" type="text/css" href="/portal/css/common.css">
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>

<OBJECT ID="GPKISecureWeb" CLASSID="CLSID:C8223F3A-1420-4245-88F2-D874FC081572">
</OBJECT>
<style type="text/css">
<!--
.gpki_div h1 { font-size:14px; font-weight:bold; background:#0677b7; color:#fff; padding-left:5px; height:38px; line-height:38px; }
.style_type { padding:0 10px; }
-->
</style>
<script type="text/javascript">

	function actionLogin()
	{
		var form = document.GpkiLoginForm;
		var v = new MiyaValidator(form);
	    v.add("id", {
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
			//alert(Login);
			Login(form);
			//form.submit();
			//window.close();
		}
	}

</script>
</head>
<body>
<form name="GpkiLoginForm" action ="/bos/actionCrtfctCert.action" method="post">
<!--
<input type="hidden" name="challenge" value='<c:out value="${challenge}"/>'>
 -->
<input type="hidden" name="challenge" value="${param.challenge}">
<!--
<input type="hidden" name="gpkiCode" value="" />
 -->
<div class="gpki_div">
	<h1>인증서 등록</h1>
	<table class="identy_board mt15 style_type">
		<caption>인증서 등록</caption>
		<colgroup>
				<col width="74" />
				<col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="id">아이디</label></th>
				<td><input type="text" id="id" class="w145" name="id" value=""></td>
			</tr>
			<tr>
				<th scope="row"><label for="pwd">비밀번호</label></th>
				<td><input type="password" id="pwd" class="w145" name="pwd" maxLength="15" value="" autocomplete="off"></td>
			</tr>
		</tbody>
	</table>
	<p class="mt15 mb15 center red">※ 기존 사이버경찰청 관리자 아이디/비번을 입력 해 주세요.</p>
	<p class="tac">
    <!--
    	<a href="javascript:Login(document.GpkiLoginForm);" class="poab03">
     -->
		<a href="javascript:actionLogin();" class="poab03">
		<img alt="확인" src="/portal/images/common/btn_ok.gif"/></a>
		<a href="javascript:close();"><img alt="취소" src="/portal/images/common/btn_cancel.gif"/></a>
	</p>
</div>
</form>

</body>
</html>


