<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>페이지인쇄하기 <spring:message code='site.korName' text=''/></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="robots" content="all" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap-theme.css" />

<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
<style>

</style>
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/sub.css" />
	<!-- <script type="text/javascript" src="/js/jquery.js"></script>
	<script type="text/javascript" src="/bos/js/common.js"></script>
	<script type="text/javascript" src="/bos/js/sub.js"></script> -->

<style type="text/css">
	body{background: #fff none 0 0 no-repeat;}
	#wrap{width: auto ;margin: 0 0 0 0;background-image:none;}
	#wraper{background-image: url(none);width: auto;}
	#container,
	#content{float:none;margin: 0;padding: 0;background-image:none;}
	.print_btn_set{text-align: center;}
	.spot_visual{position: relative;top:0;}
	#content {width:770px !important;}
	.hgroup a,
	.hgroup .btn_print {display:none;}
	span.button {display:none;}

</style>
<script type="text/javascript">
//<![CDATA[
window.document.onkeydown=function() {
	return false;
}

window.document.onclick=function() {
	return false;
}

window.document.ondblclick=function() {
	return false;
}


window.document.oncontextmenu=function() {
	return false;
}


window.document.ondragstart=function() {
	return false;
}


window.document.onselectstart=function() {
	return false;
}
//]]>
</script>
</head>
<body>
<!--
<div id="btn_print" style="display:none;width:680px;height:30px;text-align:center;padding-top:10px;"><a href="#btn_print" onclick="window.print();return false;" onkeypress="this.onclick();"><img src="/kab/home/img/common/btn/btn_print.gif" alt="인쇄하기" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#btn_print" onclick="window.close();return false;" onkeypress="this.onclick();"><img src="/kab/home/img/common/btn/close.gif" alt="창닫기" /></a></div>
-->
<div id="btn_print" style="display:none;text-align:center;padding-top:10px;">
	<div class="tar">
		<a class="btn btn-sm btn-warning" href="#btn_print" onclick="window.close();return false;">창닫기</a>
		<a class="btn btn-sm btn-success" href="#" onclick="window.print();return false;" id="print" title="새창" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i><span >인쇄하기</span></a>
	</div>
</div>
<script type="text/javascript">
	//var openerHtml = opener.printBody.innerHTML ;
	var contentObj = opener.document.getElementById("content");

	if(contentObj)
	{
		var openerHtml = contentObj.innerHTML;
	//	var re1 = /<\s*a/gi
	//	var re2 = /<\/\s*a/gi
	//	openerHtml = openerHtml.replace(re1, "<span");
	//	openerHtml = openerHtml.replace(re2, "<\/span");

			var str = "<div id='content'>\n"
					+ openerHtml
					+ "<\/div>";
			document.write(str);
	}

</script>
<noscript>
	<p style="margin-bottom:5px;">자바스크립트가 작동 되지 않는 환경입니다. 현재 창을 닫으시고, 브라우저 메뉴의 인쇄기능을 이용하십시오.</p>
</noscript>
<script type="text/javascript">
	document.getElementById("btn_print").style.display = "";
</script>
<noscript>
	<p style="margin-bottom:5px;">자바스크립트가 작동 되지 않는 환경입니다. 현재 창을 닫으시고, 브라우저 메뉴의 인쇄기능을 이용하십시오.</p>
</noscript>
</body>
</html>