<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="footer_set">
	<div id="footer">
		<p class="flogo thidden"><spring:message code='site.engName' text=''/></p>
		<address>
		<p><spring:message code="site.addr1" text=""/> <spring:message code="site.addr2" text=""/>(<spring:message code="site.post" text=""/>)</p>
		<p><strong>대표전화</strong> : <spring:message code="site.tal" text=""/> <strong>대표FAX</strong> : <spring:message code="site.fax" text=""/></p>
		<em><spring:message code="site.copyRight" text=""/></em>
		</address>
	</div>
</div>