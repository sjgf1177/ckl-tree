<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[
$(function() {

	var authSe = "<c:out value='${param.authSe}'/>";
	var authSeVal = "<c:out value='${param.authSeVal}'/>";
	var mode = "<c:out value='${param.mode}'/>";

	crtfcSndng = function() {
		if (!confirm("재발송하시겠습니까?")) {
			return;
		}
		$.post(
			"/testbed/userMember/crtfcSndng.json",
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

		if (authSe == "02") {

			if ($("#authNum").val() == "") {
				alert("인증번호를 입력하세요.");
				$("#authNum").focus();
				return;
			}
			$.post(
				"/testbed/userMember/crtfcSms.json",
				{authNum : $("#authNum").val(), userSn : $("#userSn", opener.document).val(), userId : $("#userId", opener.document).val(), siteNm : "edu", mode : mode, authSeVal : authSeVal},
				function(data) {
					if (data.resultCode == "success") {
						alert(data.msg);

						$("#parntsMbtlnumAuthAt", opener.document).val("Y");
						$("#parntsMbtlnumAuth", opener.document).hide();
						$("#parntsMbtlnumAuthCmt", opener.document).show();
						$("#parntsMbtlnumAuthDel", opener.document).show();
						var val = $("#parntsMbtlnum1", opener.document).val()+ "-"+$("#parntsMbtlnum2", opener.document).val()+ "-"+$("#parntsMbtlnum3", opener.document).val();
						$("#parntsMbtlnum", opener.document).val(val);
						$("#parntsMbtlnum1", opener.document).attr('disabled', true);
						$("#parntsMbtlnum2", opener.document).attr('disabled', true);
						$("#parntsMbtlnum3", opener.document).attr('disabled', true);
						$("#parntsAuthSameBtn", opener.document).show();


						self.close();
					}
					else {
						$("#authNum").val("");
						alert(data.msg);
						return;
					}
				},"json"
			);

		}
		else {
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


			<!-- SMS 인증 -->
			<div class="pathM02" >
				휴대폰으로 받은 인증번호를 입력하신 후 [확인]을 눌러주세요.
				<div class="boxGray" >
					<label for="authNum">인증번호</label>
					<input type="text" name="authNum" id="authNum" value="" maxlength="6" onkeyup="this.value=check_txt(this.value)">
					<a href="javascript:crtfcSndng();" class="btn btn-default btn-sm">인증번호 재발송</a>
				</div>
				<div class="ml30 mt20">
					<h4>※ 인증번호가 도착하지 않을 경우</h4>
					<ul class="bullSm ml20">
						<li>재인증을 시도해 주세요.</li>
						<li>스팸문자함, 메시지 함 용량 초과 여부, 차단설정을 체크해 주세요.</li>
						<li>설정 체크 후에 재 인증 실패 시 통신사에 문의하세요.</li>
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