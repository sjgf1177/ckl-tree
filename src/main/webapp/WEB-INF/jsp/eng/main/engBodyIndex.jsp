<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/portalHead.jsp" flush="true" /> --%>

<title>ckl</title>
</head>
<body>
<div id="container">
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
</div>
<script type="text/javascript" src="/js/zclip/jquery.zclip.js"></script>
<div class="souceUrl">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
<div class="check" style="display: none">복사완료</div>
<script type="text/javascript">
	$(document).ready(function(){
	    $(".souceUrl").zclip({
		    path: "/js/zclip/ZeroClipboard.swf",
	        copy:$('.souceUrl').text(),
	        beforeCopy:function(){
	            $('.souceUrl').css('background','yellow');
	            $(this).css('color','orange');
	        },
	        afterCopy:function(){
	            $('.souceUrl').css('background','green');
	            $(this).css('color','purple');
	            $(this).next('.check').show();
	            $(this).width('auto')
	        }
	    });
	});
</script>

</body>
</html>