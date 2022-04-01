<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/WEB-INF/error/500.jsp"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/bosLayout.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.highlight-4.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/bos/js/common.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script type="text/javascript" src="/js/html5shiv.js"></script><script type="text/javascript" src="js/respond.min.js"></script>
<![endif]-->

</head>
<body>
	<div id="wrap" class="popupWrap">

		<c:choose>
			<c:when test="${not empty cvCon}">
				${cvCon}
			</c:when>
			<c:otherwise>
				<c:set var="_includePage" value="" />
				<c:choose>
					<c:when test="${not empty param.incPage}">
						<c:set var="_includePage" value="${incPage}" />
					</c:when>
					<c:when test="${empty includePage}">
						<c:set var="_includePage" value="${currMenu.contentsPath}" />
					</c:when>
					<c:otherwise>
						<c:set var="_includePage" value="${includePage}" />
					</c:otherwise>
				</c:choose>
				<c:catch var="catchException">
					<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true" />
				</c:catch>
			</c:otherwise>
		</c:choose>

	<%--
	<div id="footer">

		<p><span class="bold">콘텐츠코리아랩</span>&nbsp;&nbsp;&nbsp;
			서울시 영등포구 여의나루로 76(150-010),
			&nbsp;&nbsp;&nbsp; <span class="bold">전화번호</span>: 02)767-7114 </p>
			<em>Copyright ⓒ 2012 CKL Corp. All Rights reserved.</em>
		</div>

		<!--[if lte IE 7]>
		<script type="text/javascript">
		//<![CDATA[
			$('*').each(function(index) {
				if ($(this).css("overflow")=="hidden"){ $(this).css("zoom",1)}
				if ($(this).css("display")=="inline-block"){ $(this).css("display",'inline'); $(this).css("zoom",1)}
			});
		//]]>
		</script>
		<![endif]-->
	</div>
    --%>
<%-- 	<c:catch var="catchException">
		<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
	</c:catch> --%>
</body>
</html>