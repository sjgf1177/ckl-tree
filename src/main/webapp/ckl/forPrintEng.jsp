<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>Print for page</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="robots" content="all" />
<link rel="stylesheet" type="text/css" href="/fonts/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"/>
<link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css" />
<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css" />
<style type="text/css">
	body{background-image: url(none);}
	#wrap{width: auto ;margin: 0 0 0 0;background-image:none;min-width:1080px;overflow:hidden;}
	#wraper{background-image: url(none);width: auto;}
	#container,
	#content{float:none;margin: 0;padding: 0;background-image:none;margin: 0 auto;zoom:1; }
	#content{}
	.print .content{margin:0 15px !important;}
	.print .quick, .print .snsSet{display: none !important;}
	.print h1{font-size:1.5em;color:#3e3a39; line-height:2em;margin-top:0;}
	.print_btn_set{text-align: center;  }
	.spot_visual{position: relative;top:0;}
	.sns_print
	{visibility:hidden;}
	.open_soce,
	.contents_adm
	{display:none;margin: 0;}
	.paging li * {overflow:hidden;}
	@media print{
		.print_tit,
		.print_set,
		#btn_print{display:none;}

	}
.well{margin:10px 20px;}
.print_tit{padding:0;}
.print_set{margin-left: 5px;width:1000px;overflow:hidden;}
.print_set .fl{width: 422px;}
.print_set .fr{width: 335px;}
.print_set .fr p{font-weight: bold;padding: 16px 0 10px 0;}
.print_set .fr h2{margin: 5px 0 4px 0;}
.print_set .fr ol{}
.print_set .fr ol li{padding-left: 35px;line-height: 14px;margin-bottom: 10px;min-height: 23px}
.print_set .fr ol li em{color: #f54009;}
.contentRightMini{display: none;}
</style>
<script type="text/javascript">
//<![CDATA[
window.document.onkeydown=function()	{return false}
window.document.onclick=function()		{return false}
window.document.ondblclick=function()	{return false}
window.document.oncontextmenu=function(){return false}
window.document.ondragstart=function()	{return false}
window.document.onselectstart=function(){return false}

window.onload = function() {
	window.print();
}
//]]>
</script>
</head>
<body class="print">
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
			var str =
					 "<div>\n"
					+ openerHtml
					+ "<\/div>";
			document.write(str);
	}
</script>
<noscript>
	<p style="margin-bottom:5px;">This is the environment that Javascript is not operating. Please close the current window, please use the print function of the browser menu.</p>
</noscript>
<script type="text/javascript">
	document.getElementById("btn_print").style.display = "";
</script>
</body>
</html>