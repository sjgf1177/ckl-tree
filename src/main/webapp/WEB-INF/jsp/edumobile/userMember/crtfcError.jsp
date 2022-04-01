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
			"/edu/userMember/crtfcSndng.json",
			{authSe : "01", val : "<c:out value='${email}'/>", mode : "i"},
			function(data) {
				if (data.resultCode == "success") {
					alert("발송되었습니다.");
				}
			},"json"
		);
	};

	crtfcPopup = function() { // 휴대폰 인증 팝업창
		var val = "<c:out value='${mbtlnum}'/>";

		window.open("/edu/userMember/crtfcPopup.do?viewType=BODY&authSe=02&val="+val+"&mode=CE&checkIntercepter=edumobile", "crtfcPopup", "top=300, left=600, width=568, height=463, status=yes, resizable=yes, scrollbars=no");
	};

});

//]]>
</script>

<h2 class="fs5 tac">아이디 <c:out value="${userId}"/>에 대한 이메일 또는 휴대폰으로 <span class="fcBlack">인증이 완료되지 않았습니다.</span></h2>

<div class="boxGray  mt40 mb40 pt30 pb30">
	<p class="mt20">
		아래 버튼을 클릭하여 이메일 및 휴대폰 인증을 하셔야 한국콘텐츠아카데미에서 제공하는 서비스를 이용하실 수 있습니다.
	</p>

</div>

<div class="btnSet mt30" style="margin-bottom:80px">
	<a href="javascript:crtfcSndng();" class="btn btn-primary mr10">이메일 발송</a>
	<a href="javascript:crtfcPopup();" class="btn btn-gray">휴대폰 인증</a>
</div>

