<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
//<![CDATA[
      var title = document.title;
      document.title = "본인확인 | 에듀코카";
//]]>
</script>


<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[
$(function() {

	var authSe = "<c:out value='${param.authSe}'/>";
	var authSeVal = "<c:out value='${param.authSeVal}'/>";
	var val = "<c:out value='${param.val}'/>";
	var mode = "<c:out value='${param.mode}'/>";

	crtfcSndng = function() {
		if (!confirm("재발송하시겠습니까?")) {
			return;
		}
		$.post(
			"/edu/userMember/crtfcEmailSndng.json",
			{authSe : authSe, val : val, mode : "i"},
			function(data) {
				if (data.resultCode == "success") {
					$("#authNum").val("");
					alert("재발송되었습니다.");
				}
			},"json"
		);
	};

	fnCheck = function() {

		if (authSe == "01") {

			if ($("#authNum").val() == "") {
				alert("인증번호를 입력하세요.");
				$("#authNum").focus();
				return;
			}
			$.post(
				"/edu/userMember/crtfcEmailChk.json",
				{authNum : $("#authNum").val(), userSn : $("#userSn", opener.document).val(), siteNm : "edu", mode : mode, authSeVal : authSeVal, mbtlnum : val}
				,function(data) {
					if (data.resultCode == "success") {
						alert(data.msg);
						$("#emailAuthAt", opener.document).val("Y");
						$("#emailAuth", opener.document).hide();
						$("#emailAuthCmt", opener.document).show();
						$("#emailAuthDel", opener.document).show();
						$("#email1", opener.document).attr('disabled', true);
						$("#email2", opener.document).attr('disabled', true);
						$(".input_select.select_email_js", opener.document).attr('disabled', true);
						$("#email", opener.document).val(val);
						
						self.close();
					}else{
						$("#authNum").val("");
						alert(data.msg);
						return;
					}
				},"json"
			);

		}else{
			self.close();
		}
	};

});

function check_txt(value) {
    if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
    else {
    	return value;
    }
}

//]]>
</script>

<div class="popBx">
	<div class="popBoxIn">
		<span class="popLogo"><span class="sr-only">한국콘텐츠진흥원</span></span>
		<a href="javascript:window.close();" class="popClose"><span class="sr-only">팝업창 닫기</span></a>
		<h2>본인확인</h2>
		
		<!-- 이메일 인증 -->
		<div class="pathM02" >
			<strong><c:out value="${param.val}"/></strong> 으로 인증메일이 발송되었습니다.<br>
			인증번호를 입력하신 후 [확인]을 눌러주세요.
			<div class="boxGray" >
				<label for="authNum">인증번호</label>
				<input type="text" name="authNum" id="authNum" value="" maxlength="6" onkeyup="this.value=check_txt(this.value)">
				<a href="javascript:crtfcSndng();" class="btn btn-default btn-sm">인증번호 재발송</a>
			</div>
			<div class="ml30 mt20">
				<h4>※ 인증번호가 도착하지 않을 경우</h4>
				<ul class="bullSm ml20">
					<li>재인증을 시도해 주세요.</li>
					<li>스팸메일함, 메일함 용량 초과 여부, 차단설정을 체크해 주세요.</li>
				</ul>
			</div>
		</div>

		<div class="btnSet">
			<a href="javascript:fnCheck();" class="btn btn-primary btnBlack icoCheck">확인</a>
		</div>

	</div>

	<div class="popFooterSet">
		<span class="popLfBx"></span>
		<p class="tac mt20">Copyright 2015. Korea Creative Content Agency all rights reserved.</p>
		<span class="popRtBx"></span>
	</div>
</div>