<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);
%>
<c:set var="userVO" value="${userVO }" scope="request" />
	<jsp:include page="/WEB-INF/jsp/ckl/inc/cklHead.jsp" flush="true" />
	<c:set var="title" value="CKL 기획센터" />

	<link rel="stylesheet" type="text/css" href="/ckl/css/popup.css" />
	<title>${title}</title>

</head>
<body>
<!-- Window Popup -->
<div class="popWin">
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

	<div class="panelBoxCloser">
		<a href="javascript:window.close();return false;"><span class="sr-only">레이어 창 닫기</span></a>
	</div>

</div>
<!-- //Window Popup -->

<div class="popFooterSet">
	<p class="tac mt20">Copyright 2015. Korea Creative Content Agency all rights reserved.</p>
</div>

<!--[if lte IE 7]>
<script type="text/javascript">
//<![CDATA[
	$('*').each(function(index) {
		if ($(this).css("overflow")=="hidden"){
			$(this).css("zoom",1);
		}
		if ($(this).css("display")=="inline-block"){
			$(this).css("display",'inline');
			$(this).css("zoom",1);
		}
	});
//]]>
</script>
<![endif]-->






<%--
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
</script> --%>




<!--[if lte IE 7]>
<script type="text/javascript">
//<![CDATA[
	$('*').each(function(index) {
		if ($(this).css("overflow")=="hidden"){
			$(this).css("zoom",1);
		}
		if ($(this).css("display")=="inline-block"){
			$(this).css("display",'inline');
			$(this).css("zoom",1);
		}
	});
//]]>
</script>
<![endif]-->
</body>
</html>