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
			"/edu/userMember/crtfcSndng.json",
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
				"/edu/userMember/crtfcSms.json",
				<c:if test="${empty param.checkIntercepter}">
				{authNum : $("#authNum").val(), userSn : $("#userSn", opener.document).val(), userId : $("#userId", opener.document).val(), siteNm : "edu", mode : mode, authSeVal : authSeVal, mbtlnum : val}
				</c:if>
				<c:if test="${!empty param.checkIntercepter}">
				{authNum : $("#authNum").val(), userSn : $("#userSn", opener.document).val(), userId : $("#userId", opener.document).val(), siteNm : "edumobile", mode : mode, authSeVal : authSeVal, mbtlnum : val}
				</c:if>
				,function(data) {
					if (data.resultCode == "success") {
						alert(data.msg);
						if (mode == "PE" || mode == "CE") {
							<c:if test="${empty param.checkIntercepter}">
							opener.location.href =	"/edu/member/forLogin.do?menuNo=500077";
							</c:if>
							<c:if test="${!empty param.checkIntercepter}">
							opener.location.href =	"/edumobile/member/forLogin.do?menuNo=600130";
							</c:if>
						}
						else if (mode == "FU") {
							opener.location.reload();
						}
						else {
							$("#mbtlnumAuthAt", opener.document).val("Y");
							$("#mbtlnumAuth", opener.document).hide();
							$("#mbtlnumAuthCmt", opener.document).show();
							$("#mbtlnumAuthDel", opener.document).show();
							$("#mbtlnum1", opener.document).attr('disabled', true);
							$("#mbtlnum2", opener.document).attr('disabled', true);
							$("#mbtlnum3", opener.document).attr('disabled', true);
							$("#mbtlnum", opener.document).val(val);
							if ($("#parntsAuthSameBtn", opener.document)) $("#parntsAuthSameBtn", opener.document).hide();
						}
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

			<!-- <fieldset>
				<legend>본인확인 입력</legend>
				<label for="authSe1"><input type="radio" name="authSe" value="01" id="authSe1" checked="checked"> 이메일인증 </label>
				<label for="authSe2"><input type="radio" name="authSe" value="02" id="authSe2"> 휴대폰인증 </label>
			</fieldset> -->

			<!-- 이메일 인증 -->

	<c:choose>
		<c:when test="${param.authSe eq '01'}">
			<div class="pathM02" >
				<div class="pathM01 mt30" >
					본인확인을 <strong><c:out value="${param.val}"/></strong> 으로 인증메일이 발송되었습니다.<br>
					<c:if test="${empty param.mode}"><strong>"회원가입 완료 후"</strong> </c:if>수신하신 메일에서 인증하기를 클릭하셔야 본인확인이 완료 됩니다.
				</div>
			</div>
		</c:when>
		<c:otherwise>

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

		</c:otherwise>
	</c:choose>

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