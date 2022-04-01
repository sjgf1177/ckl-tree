<%@ page language="java" contentType="application/javascript; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 $(function(){
		<c:forEach var="popup" items="${popupList}" varStatus="status">
		if( !$.cookie('pno_${popup.pno}') ){
		window.open("/ckl/popupMng/popup.do?pno=${popup.pno}&siteId=${popup.siteId}","popup_${popup.pno}",  "top=${popup.top}, left=${popup.left}, toolbar=0, status=0, scrollbars=${popup.scroll}, location=0, menubar=0, width=${popup.width}, height=${popup.height}");
		}
 		</c:forEach>
	});


<%-- 		<c:set var="_width" value="0" />
	$(function(){
		<c:forEach var="popup" items="${popupList}" varStatus="status">
		if( !$.cookie('pno_${popup.pno}') ){
		window.open("/ckl/popupMng/popup.do?pno=${popup.pno}&siteId=${popup.siteId}","popup_${popup.pno}",  "top=0, left=${_width}, toolbar=0, status=0, scrollbars=no, location=0, menubar=0, width=${popup.width}, height=${popup.height}");
		}
			<c:set var="_width" value="${popup.width + _width}" />
		</c:forEach>
	}); --%>


