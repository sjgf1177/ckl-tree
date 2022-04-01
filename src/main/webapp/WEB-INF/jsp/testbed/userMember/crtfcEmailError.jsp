<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
//<![CDATA[
$(function() {

	crtfcSndng = function() { // 이메일 재발송
		if (!confirm("재발송하시겠습니까?")) {
			return;
		}
		$.post(
			"/testbed/userMember/crtfcSndng.json",
			{authSe : "01", userSn : "<c:out value='${userSn}'/>", val : "<c:out value='${email}'/>", mode : "i"},
			function(data) {
				if (data.resultCode == "success") {
					alert("재발송되었습니다.");
					//location.href = "/testbed/member/forLogin.do?menuNo=700115";
				}
			},"json"
		);
	};

	crtfcPopup = function() { // 휴대폰 인증 팝업창
		var val = "<c:out value='${mbtlnum}'/>";

		window.open("/testbed/userMember/crtfcPopup.do?viewType=BODY&authSe=02&val="+val+"&mode=CE", "crtfcPopup", "top=300, left=600, width=568, height=463, status=yes, resizable=yes, scrollbars=no");
	};

});

//]]>
</script>

<h2 class="fs5 tac">회원가입 시 이메일 인증에 대한 인증이 완료되지 않았습니다.</h2>

<div class="boxGray  mt40 mb40 pt30 pb30">
	<p class="tac">
	<strong class="fs4"><c:out value="${email}"/></strong>  으로 발송된 <strong class="fs4">“이메일 승인”</strong> 이메일을  확인하시어 <strong class="fs4">“이메일 승인”</strong> 해주시기 바랍니다.
	 </p>
	<p class="mt20">
	<span class="fcRed">※ 이메일을 받지 못하신 경우 <strong class="fs4">“이메일 재발송”</strong> 또는 <strong class="fs4">“휴대폰인증으로 변경”</strong>을 클릭해주시기 바랍니다. </span>
	</p>
</div>

<div class="btnSet mt30" style="margin-bottom:80px">
	<a href="javascript:crtfcSndng();" class="btn btn-primary mr10">이메일 재발송</a>
	<a href="javascript:crtfcPopup();" class="btn btn-gray">휴대폰인증으로 변경</a>
</div>
