<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
	
	$('#ssoLoginForm').attr({
		action : '<c:out value="${ssoDomain }" />/sso/member/forLoginSSO.do',
		target : 'ssoLoginFrame'
	}).submit();
	
});
//]]>
</script>

	<c:if test="${not empty param.email}">
		<div class="tac"><img src="/edu/images/member/qarr_01.gif" alt=""></div>
		<h2 class="fs5 tac">본인확인을 위한 <span class="fcGreen">이메일 인증</span>이 완료되었습니다.</h2>

		<div class="tac">
			<p><span class="fs5"><c:out value="${param.email}"/></span>  주소에 인증이 완료되었습니다.</p>
		</div>
		<div class="tac"><img src="/edu/images/member/qarr_01.gif" alt=""></div>
		<div class="tac deepgrayBox mb40 mt30" style="width:100%">
			사이트의 모든 서비스를 자유롭게 이용하실 수 있습니다.
		</div>
		<div class="btnSet tar mt30" style="margin-bottom:80px">
			<a href="/edu/main/main.do" class="btn btn-primary">홈으로 이동</a>
		</div>
		<hr>
	</c:if>
	
<%-- 	<iframe name="ssoLoginFrame" id="ssoLoginFrame" style="width:1100px;height:363px;" src="<c:out value="${ssoDomain }" />/sso/member/forLoginSSO.do?service=edu&amp;menuNo=<c:out value="${paramVO.menuNo }" />&redirectUrl=<c:url value="${param.redirectUrl}"/>" title="로그인 입력 frame입니다." frameborder="0" scrolling="no" ></iframe> --%>
	<iframe name="ssoLoginFrame" id="ssoLoginFrame" style="width:100%;height:500px;" src="" title="로그인 입력 frame입니다." frameborder="0" scrolling="no" ></iframe>
	<form id="ssoLoginForm" name="ssoLoginForm">
		<input type="hidden" name="service" value="${paramVO.siteName}"/>
		<input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />"/>
		<input type="hidden" name="redirectUrl" value="<c:out value="${param.redirectUrl}" />"/>
	</form>
