<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[
      var title = document.title;
      document.title = "인증방식 선택 < " + title;
//]]>
</script>

<iframe name="ssoLoginFrame" id="ssoLoginFrame" style="width:100%;height:700px;" src="<c:out value="${ssoDomain }" />/sso/member/incJoin01.do?service=edu&amp;menuNo=<c:out value="${paramVO.menuNo }" />" title="회원가입 실명인증  frame입니다." frameborder="0" scrolling="no" ></iframe>

