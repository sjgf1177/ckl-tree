<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
//rsg20180412 CKL과 EDU 에러 페이지 분리 건 
String curUrl = request.getRequestURL().toString();
String siteName = "edu";
if ( curUrl.indexOf("edu.kocca.ac.kr") != -1 ){
	siteName = "edu";
} else if ( curUrl.indexOf("ckl") != -1  ){
	siteName = "ckl";
}
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title><%-- <spring:message code='site.korName' text=''/> --%>
	<%= (siteName=="edu"?"콘텐츠인재캠퍼스":"") %><%= (siteName=="ckl"?"콘텐츠코리아랩":"") %> 장애안내
</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/ckl/css/sub.css" type="text/css" />
<style type="text/css">
body{font-size: 12px;}
*{padding: 0;margin: 0;}
em{font-style:normal;font-weight: bold;}
.col_blue{color: #0069ab;}
#wrap{width: 740px;margin:0 auto;}
.logo{padding: 20px 0;border:none;}
.s{height: 177px;padding: 33px 0 0 328px;background: url(/bos/images/common/errbg.jpg) no-repeat 0 0;}
.s .t{padding-bottom: 22px;border-bottom: 1px solid #d8d8d8;width: 361px;}
.s .code{padding-top: 18px;}
.s em{color: #eb2c00;font-weight: normal;font-family: verdana;}
.s em span{font-weight: bold;}
.s strong{font-size: 14px;font-weight: bold;}
.footer{text-align: center;padding-top: 30px;color: #3c3c3c;}
.copyright{color: #666666;font-size: 11px;font-family: verdana;}
img{border:none}
</style>
</head>
<body>
<div id="wrap">
	<p class="logo"><a href="/"><img src="/images/common/logo.png" alt="<spring:message code='site.korName' text=''/>" /></a></p>
	<div class="s">
		<p class="t"><img src="/images/common/err_txt.gif" alt="페이지가 없거나 잘못된 경로입니다. 파일 또는 페이지가 없거나 잘못된 경로입니다.경로를 다시 확인하시고 이용해 주시기 바랍니다.이용에 불편을 드려 대단히 죄송합니다." /></p>
		<!--<p class="code">
		</p>-->
		<p style="text-align:center;padding-right:50px;padding-top:10px;width:250px"><a href="/" class="button list " ><span>메인으로 바로가기</span></a></p>
	</div>
	<div class="footer">
		<p class="addr">
			<%-- <spring:message code="site.post" text=""/> <spring:message code="site.addr1" text=""/> <spring:message code="site.addr2" text=""/> <spring:message code='site.korName' text=''/> --%>
			<%= (siteName=="edu"?"[02456] 서울특별시 동대문구 회기로 66 콘텐츠인재캠퍼스":"") %><%= (siteName=="ckl"?"[03082] 서울시 종로구 대학로 57 콘텐츠코리아랩":"") %>
		</p>
		<p class="copyright">
			<spring:message code="site.copyRight" text=""/>
		</p>
	</div>
</div>
</body>
</html>

