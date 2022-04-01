<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">
//<![CDATA[
      var title = document.title;
      document.title = "가입완료 < " + title;
//]]>
</script>

<div class="memberStep1">

	<div class="signup_step_bar">
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP1</span>
				인증방식선택
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP2</span>
				이용약관동의
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP3</span>
				입력항목작성
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap active">
			<p class="step_box">
				<span class="step_title">STEP4</span>
				가입완료
			</p>
		</div>
	</div>

	<div class="signup_complete_con">
		<p class="signup_complete_title">
			에듀코카 <span>회원가입 신청</span>이<br>
			완료되었습니다.
		</p>
		<hr class="signup_complete_line">
		<p class="signup_complete_text">
			<c:out value="${user.userNm}"/> 회원님, 가입을 축하 드립니다.<br>
			회원님의  입력하신 로그인 정보는
			<span>
				<c:choose>
					<c:when test="${user.mberSe eq '01'}"><c:out value="${user.userId}"/></c:when>
					<c:otherwise>SNS(<c:out value="${user.authAt eq '03' ? '네이버' : '페이스북'}"/> 인증)</c:otherwise>
				</c:choose>
			</span>
			입니다.
		</p>
		<p class="signup_complete_text warning">
			인증수단은 “ <c:out value="${user.authSe eq '01' ? '이메일' : '휴대폰'}"/> ” 인증 입니다. 인증받은 정보가<br>
			변경되는 경우 다시 “재인증” 받으셔야 합니다.
		</p>
	</div>
	<div class="board_util_btn_con center">
		<a href="/testbed/main/main.do" class="btn_style_0 blue radius center">
			홈으로
		</a>
		<a href="javascript:document.getElementById('loginForm').submit();" class="btn_style_0 full radius center">
			로그인
		</a>
		<form class="login_form" name="loginForm" id="loginForm" action="/edu/member/forLogin.do?menuNo=500077" method="post" style="display:none;">
			<input type="hidden" name="redirectUrl" value="/${paramVO.siteName}/main/main.do" />
		</form>
	</div>

</div>
