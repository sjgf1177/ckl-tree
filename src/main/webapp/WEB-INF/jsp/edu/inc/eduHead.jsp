<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

	<link rel="apple-touch-icon" sizes="57x57" href="/favicon/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="/favicon/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="/favicon/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="/favicon/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="/favicon/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="/favicon/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="/favicon/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="/favicon/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192"  href="/favicon/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/favicon/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/favicon/favicon-16x16.png">
	<link rel="manifest" href="/favicon/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="/favicon/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">

	<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
	<link rel="stylesheet" type="text/css" href="/edu/css/new/bootstrap/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/animate.min.css" />
	<link rel="stylesheet" type="text/css" href="/edu/css/common.css">
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/layout.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/js/bm/swiper/swiper.min.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/animate.min.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/bootstrap.reset.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/common_prev.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/flaticon.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/ie.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/portfolio.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/search.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/submain.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/common.css">
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/wevenResponsive.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/main.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub_layout.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub_page.css"/>
	

	<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css" />
	<c:if test="${param.menuNo  eq '500034' || param.menuNo  eq '500046'}">
		<link rel="stylesheet" type="text/css" href="/edu/css/submain.css" />
	</c:if>
	<c:if test="${param.menuNo  eq '500079'}">
		<link rel="stylesheet" href="/js/jquery-ui/ui-1.10.3/themes-smoothness-jquery-ui.css" />
	</c:if>
	
	<!-- 리뉴얼 추가 -->
	<link rel="stylesheet" type="text/css" href="/edu/css/new/header.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/new/css.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/new/footer.css"/>
	<!-- 리뉴얼 추가 끝 -->

	<!-- 라이브리 프로퍼티설정-->
	<!-- SNS에 포스팅될설명-->
	<meta property="og:description" content="에듀코카"/>
	<!-- SNS에 포스팅될사이트URL -->
	<meta property="og:site" content="https://edu.kocca.kr"/>
	<!-- SNS에 포스팅될썸네일이미지-->
	<meta property="og:image" content="https://edu.kocca.kr/upload/about/koccaesc_logo.jpg"/>
	<!-- SNS 포스팅될타이틀값-->
	<!-- <meta property="og:title" content="한국콘텐츠아카데미"/> -->
	<!-- 프로퍼티설정끝 -->
	
	
	<!-- <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script> -->
	<script type="text/javascript" src="/edu/js/new/jquery-ui/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
	<script type="text/javascript" src="/js/nwmatcher.js"></script>
	<script type="text/javascript" src="/js/selectivizr-min.js"></script>
	<script type="text/javascript" src="/js/jquery.cookies.js"></script>
	
	<script type="text/javascript" src="/js/jquery.sticky.js"></script>
	<script type="text/javascript" src="/js/jquery.scrollTo.min.js"></script>
	<script type="text/javascript" src="/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="/js/jquery.appear.js"></script>
	<script type="text/javascript" src="/js/modernizr.min.js"></script>
	<script type="text/javascript" src="/js/mousewheel.js"></script>
	<script type="text/javascript" src="/js/base64.js"></script>
	<script type="text/javascript" src="/js/ssl.js"></script>
	<script type="text/javascript" src="/js/miya_validator.js"></script>
	<script type="text/javascript" src="/js/jquery.maskedinput.min.js"></script>
	<script type="text/javascript" src="/edu/js/sub.js"></script>
	<script type="text/javascript" src="/edu/js/bm/bm.js"></script>
	<script type="text/javascript" src="/edu/js/bm/sub.js"></script>
	
	<script type="text/javascript" src="/edu/js/new/popper.min.js"></script>
	<script type="text/javascript" src="/edu/js/new/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="/edu/js/new/subjs.js"></script>
	
	<script type="text/javascript" src="/edu/js/new/mainHeader.js"></script>
	
<!-- 끝 -->


	<sec:authorize ifAnyGranted="ROLE_USER">
	<script type="text/javascript">
	//<![CDATA[
        var url = location.href;
        if (url.indexOf("/edu/userMember/reAgre.do") == -1 && url.indexOf("/edu/userMember/secsn.do") == -1 && url.indexOf("/edu/userMember/secsnRequest.do") == -1) {
			var reAgreDt = "<fmt:formatDate pattern="yyyyMMdd" value="${userVO.otherDt}" />";
			var nowDt = new Date();
			var yyyy = nowDt.getFullYear().toString();
		  	var mm = (nowDt.getMonth()+1).toString(); // getMonth() is zero-based
			var dd  = nowDt.getDate().toString();
			var today = yyyy + (mm[1]?mm:"0"+mm[0]) + (dd[1]?dd:"0"+dd[0]); // padding
			if (Number(reAgreDt) <= Number(today)) {
				alert("개인정보처리방침 재동의 후 사용하실 수 있습니다.");
				location.href = "/edu/userMember/reAgre.do?menuNo=500077${empty mode ? '' : '&mode=i'}";
			}
	    }
	//]]>
	</script>
	</sec:authorize>