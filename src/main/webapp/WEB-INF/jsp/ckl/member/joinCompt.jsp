<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">
//<![CDATA[
      var title = document.title;
      document.title = "가입완료 | " + title;
//]]>
</script>

<div class="memberStep1">
	<div class="stepInline">
		<ol>
			<li>인증방식 선택</li>
			<li>입력항목 작성</li>
			<li class="on">가입완료<span class="sr-only">(현재단계)</span></li>
		</ol>
	</div>

	<div class="tac"><img src="/edu/images/member/qarr_01.gif" alt=""></div>
	<p class="fs5 tac">콘텐츠코리아랩 <span class="fcGreen">회원가입 신청</span>이 완료되었습니다. </p>

	<div class="tac">
		<p>
			입력하신 로그인 정보는
			<span class="fs5">
				<c:choose>
					<c:when test="${user.mberSe eq '01'}"><c:out value="${user.userId}"/></c:when>
					<c:otherwise>SNS(<c:out value="${user.authAt eq '03' ? '네이버' : '페이스북'}"/> 인증)</c:otherwise>
				</c:choose>
			</span>
			입니다.
		</p>
	</div>
	<div class="tac"><img src="/edu/images/member/qarr_01.gif" alt=""></div>

	<c:if test="${user.mberSe eq '01'}">
		<div class="tac deepgrayBox mb40" style="width:100%">
			인증 수단은 “<c:out value="${user.authSe eq '01' ? '이메일' : '휴대폰'}"/>” 인증 입니다.
			인증받은 정보가 변경되는 경우 다시 “재인증” 받으셔야 합니다.
		</div>
	</c:if>


	<div class="btnSet tar">
		<a href="/ckl/main/main.do" class="btn btn-primary">홈으로 이동</a>
	</div>
</div>
