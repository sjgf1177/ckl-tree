<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>${result.title}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="generator" content="editplus" />
<meta name="author" content="" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<style type="text/css" title="">
 * {padding:0; margin:0; font-family:dotum; font-size:11px; line-height:140%; text-decoration:none; vertical-align:top;}
 .box_close1day {width:100%; height:18px; background:#ababab; position:fixed; left:0; bottom:0; text-align:right; margin-right:10px;}
 .box_close1day input {width:14px; height:14px; background:white;}
 .box_close1day p {padding:5px 10px 0 0;}
</style>

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery-1.4.2.js"></script>
<script type="text/javascript" src="/js/jquery.cookie.js"></script>
<script LANGUAGE="JavaScript">
<!--
	$(function(){
		$("#coupon").click(function(){
			$.cookie('pno_${param.pno}', 'pno_${param.pno}', { expires: 1, path: '/' });
			self.close();
		});
	});

function movePage(link,event) {
	window.opener.top.location.href=link;
	self.close();
	//event.preventDefault();
}
//-->
</script>
</head>
<body>
<div style="position:relative;">

<c:choose>
<c:when test="${result.link eq 'I'}">
	<a href="${result.linkaddress}" target="_blank" title="새창열림" alt="${result.title}">
	<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn }" border="0"/>
	</a>
</c:when>
<c:when test="${result.link eq 'M'}">
	<map name="popMap">${result.map}</map>
	<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn }" border="0" usemap="#popMap"/>
</c:when>
<c:otherwise>
	<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn }" border="0"/>
</c:otherwise>
</c:choose>

<c:if test="${result.closeUseYn eq 'Y'}">
 <div class="box_close1day">
  <p><form><input type="checkbox" id="coupon" name="" value="coupon"> 오늘 창 그만보기<a href="#" onclick="javascript:self.close()">[닫기]</a></form>
 </div>
</c:if>
</div>
</body>
</html>