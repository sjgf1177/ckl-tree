<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="footer">
<!--
	<p><span class="bold"><spring:message code='site.korName' text=''/></span>&nbsp;&nbsp;&nbsp;
	<spring:message code="site.addr1" text=""/> <spring:message code="site.addr2" text=""/>(<spring:message code="site.post" text=""/>),
	&nbsp;&nbsp;&nbsp;  <span class="bold">전화번호</span>: <spring:message code="site.tal" text=""/> </p>
	<em><spring:message code="site.copyRight" text=""/></em>
 -->
 	<p><span class="bold">한국콘텐츠진흥원 본원</span>&nbsp;&nbsp;&nbsp;
	전라남도 나주시 교육길 35 ( 58217 ),
	&nbsp;&nbsp;&nbsp;</p>
	<p><span class="bold">콘텐츠코리아랩 대학로 분원</span>&nbsp;&nbsp;&nbsp;
	서울시 종로구 대학로 57 ( 03082 ),
	&nbsp;&nbsp;&nbsp;</p>
	<em>Copyright 2015. Korea Creative Content Agency all rights reserved</em>
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