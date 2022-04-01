<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="ko">
<head>

	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<link rel="stylesheet" type="text/css" href="/fonts/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"/>
	<link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css" />
	<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css" />
	<link rel="stylesheet" href="/js/jquery-ui/ui-1.10.3/themes-smoothness-jquery-ui.css" />

	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/selectivizr-min.js"></script>
	<script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
	<script type="text/javascript" src="/js/jquery.sticky.js"></script>
	<script type="text/javascript" src="/js/modernizr.min.js"></script>
	<script type="text/javascript" src="/js/mousewheel.js"></script>
	<script type="text/javascript" src="/js/TweenMax.min.js"></script>
	<script type="text/javascript" src="/js/tablesummary.js"></script>
	<script type="text/javascript" src="/ckl/js/common.js"></script>
	<script type="text/javascript" src="/ckl/js/sub.js"></script>
	<script type="text/javascript" src="/js/base64.js"></script>
	<script type="text/javascript" src="/js/ssl.js"></script>
	<script type="text/javascript" src="/js/miya_validator.js"></script>
	<script type="text/javascript" src="/js/jquery.maskedinput.min.js"></script>


<!--[if lt IE 9]>
	<link rel="stylesheet" href="/ckl/css/ie.css" type="text/css" />
	<script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
	<sec:authorize ifAnyGranted="ROLE_USER">
	<script type="text/javascript">
	//<![CDATA[
	    var url = location.href;
	    if (url.indexOf("/ckl/userMember/reAgre.do") == -1 && url.indexOf("/ckl/userMember/secsn.do") == -1 && url.indexOf("/ckl/userMember/secsnRequest.do") == -1) {
			var reAgreDt = "<fmt:formatDate pattern="yyyyMMdd" value="${userVO.otherDt}" />";
			var nowDt = new Date();
			var yyyy = nowDt.getFullYear().toString();
		  	var mm = (nowDt.getMonth()+1).toString(); // getMonth() is zero-based
			var dd  = nowDt.getDate().toString();
			var today = yyyy + (mm[1]?mm:"0"+mm[0]) + (dd[1]?dd:"0"+dd[0]); // padding
			if (Number(reAgreDt) <= Number(today)) {
				alert("개인정보처리방침 재동의 후 사용하실 수 있습니다.");
				location.href = "/ckl/userMember/reAgre.do?menuNo=200055${empty mode ? '' : '&mode=i'}";
			}
	    }
	//]]>
	</script>
	</sec:authorize>
