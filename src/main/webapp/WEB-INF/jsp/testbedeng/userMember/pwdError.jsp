<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">
//<![CDATA[

	$(function(){

		crtfcPopup = function(authSe) { // 휴대폰 인증 팝업창
			var val = "<c:out value='${result.mbtlnum}'/>";

			window.open("/testbed/userMember/crtfcPopup.do?viewType=BODY&authSe="+authSe+"&val="+val+"&mode=PE", "crtfcPopup", "top=300, left=600, width=568, height=463, status=yes, resizable=yes, scrollbars=no");
		};

	});

//]]>
</script>

<c:choose>
	<c:when test="${result.authSe eq '01'}">

		<h2 class="fs5 tac">비밀번호 입력이 5회 틀렸습니다. 비밀번호가 입력이 5회 틀린 경우 해당 아이디는 <span class="fcBlack">“잠김상태”</span>로 전환됩니다.</h2>

		<div class="boxGray  mt40 mb40 pt30 pb30">
			<p class="tac">
			회원 가입 시 인증받은 이메일로 <strong class="fs4">“이메일 승인”</strong> 메일을 발송되었으니, 이메일을  확인하시어 <strong class="fs4">“이메일 승인”</strong> 해주시기 바랍니다.
			 </p>
			<p class="mt20">
			<span class="fcRed">※ SNS(페이스북, 네이버)로 인증하신 경우 해당 SNS 서비스 가입 시 입력하신 이메일 주소가 승인된 정보입니다 </span>
			</p>

		</div>

		<div class="btnSet mt30" style="margin-bottom:80px">
			<a href="/testbed/main/main.do" class="btn btn-primary">홈으로 이동</a>
		</div>

	</c:when>

	<c:otherwise>
		<input type="hidden" id="userId" value="<c:out value='${result.userId}'/>" />
		<h2 class="fs5 tac">
			비밀번호 입력이 5회 틀렸습니다. <br>
			비밀번호가 입력이 5회 틀린 경우 해당 아이디는 “잠김상태”로 전환됩니다.
			회원 가입 시 인증받은 <strong>“휴대폰번호”</strong>를 이용하여 다시한번 승인하시기 바랍니다.
		</h2>

		<div class="btnSet tac">
			<a href="javascript:crtfcPopup('02');" class="btn btn-primary">휴대폰인증</a>
		</div>

		<!-- <div class="popBx">
			<span class="popLogo"><span class="sr-only">한국콘텐츠진흥원</span></span>
			<a href="#self" class="popClose"><span class="sr-only">팝업창 닫기</span></a>
			<h2>본인확인</h2>

			<form action="">
				<fieldset>
					<legend>본인확인 입력</legend>

						<label for="PATHM_0"><input type="radio" name="PATHM" value="라디오" id="PATHM_0"> 이메일인증 </label>
						<label for="PATHM_1"><input type="radio" name="PATHM" value="라디오" id="PATHM_1"> 휴대폰인증 </label>
				</fieldset>
				<div class="pathM01">
					본인확인을 <strong><a href="mailto:superart@naver.com" title="새창열림" target="_blank">superart@naver.com</a></strong> 으로 인증메일이 발송되었습니다.<br>
					수신하신 메일에서 인증하기를 클릭하셔야 본인확인이 완료 됩니다.

					<a href="#self" class="btn btn-prmary">확인</a>
				</div>
				<div class="pathM02">
					휴대폰으로 받은 인증번호를 입력하신 후 [확인]을 눌러주세요.

					<div>
						<label for="AUTHNM">인증번호</label>
						<input type="text" name="AUTHNM" id="AUTHNM" value="">
						<a href="#self" class="btn btn-default btn-sm btn-black">인증번호 재발송</a>
					</div>
					<div>
						<h4>인증번호가 도착하지 않을 경우</h4>
						<ul>
							<li>재인증을 시도해 주세요.</li>
							<li>스팸문자함, 메시지 함 용량 초과 여부, 차단설정을 체크해 주세요.</li>
							<li>설정 체크 후에 재 인증 실패 시 통신사에 문의하세요.</li>
						</ul>
					</div>

				</div>
			</form>
			<div class="btnSet">
				<button type="submit" class="btn btn-primary">확인</button>
				<a href="javascript:void(0);" class="btn btn-default">취소</a>
			</div>

		</div> -->

	</c:otherwise>
</c:choose>