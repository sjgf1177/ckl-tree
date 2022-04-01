<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>



<!doctype html>
<html lang="ko">
<head>
<title>간편로그인설정 | 나의정보 | 에듀코카</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />


<link rel="stylesheet" type="text/css" href="/fonts/css/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>

<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/bootstrap.reset.css"/>
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/animate.min.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/common.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/layout.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/sub.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/sub_layout.css" />
<link rel="stylesheet" type="text/css" href="/<c:out value="${paramVO.service }"/>/css/bm/sub_page.css" />


<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script>


<script type="text/javascript" src="/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="/js/sns/kakao.js"></script>
<script src="https://apis.google.com/js/api:client.js"></script>
<script type="text/javascript" src="/js/sns/googlePlus.js"></script>

<!--[if lt IE 9]>
	<link rel="stylesheet" href="/edu/css/ie.css" type="text/css" />
	<script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
<!--[if lte IE 8]><script type="text/javascript"> $('html').attr('id','ie8'); </script><![endif]-->
<!--[if lte IE 7]><script type="text/javascript"> $('html').attr('id','ie7'); </script><![endif]-->

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[
window.name='mainwin';
$(function() {

	// 페이스북 초기화
	$.sFacebook.initialize({
		clickBtn : 'fbLoginBtn',
		appId : '<c:out value="${facebookAppKey}" />',
		fnData : function(id,name,email) {
			fnConnectSns("04",id);
		}
	});

	// 구글 plus 초기화
	$.sGooglePlus.initialize({
		clickBtn : 'googleBtn',
		appId : '<c:out value="${googlePlusAppKey}" />',
		fnData : function(id,name,email) {
			fnConnectSns("02",id);
		}
	});

	// 카카오 초기화
	$.sKakao.initialize({
		clickBtn : 'kakaoLoginBtn',
		appId : '<c:out value="${kakaoAppKey}" />',
		fnData : function(id,name) {
			fnConnectSns("01",id);
		}
	});

	$("#naverLoginBtn").click(function() {
		$("#naver_id_login").find("a").click();
		return false;
	});


	var naver_login = new naver_id_login("<c:out value="${naverAppKey}" />", "<c:out value="${naverCallbackUrl}" />");
	naver_login.setButton("green", 1,0);
	//naver_login.setDomain(".kocca.dev.kr");
	var oDate = new Date();
	var state = oDate.getTime();
	naver_login.setState(state);
	naver_login.setPopup();
	naver_login.init_naver_id_login();


	$(".trmnatBtn").click(function() {
		var authSe = $(this).attr("data-authSe");
		fnTerminationSns(authSe);
		return false;
	});

});

var fnNaverLoginCallback = function(id,name,email) {
	fnConnectSns("03",id);
};

function fnConnectSns(authSe,authKey) {
	var url = "/<c:out value="${param.service}" />/userMember/insertSimpleLogin.json";
	var params = {
		authSe : authSe,
		authKey : authKey
	};
	$.post(url, params, function(data) {
		if (data.resultCode == "success") {
			alert("연결되었습니다.");
			window.location.href = location.href;
		}
		else {
			alert("연결이 실패했습니다.");
		}
	},"json");
}

function fnTerminationSns(authSe) {
	var url = "/<c:out value="${param.service}" />/userMember/deleteSimpleLogin.json";
	var params = {
		authSe : authSe
	};
	$.post(url, params, function(data) {
		if (data.resultCode == "success") {
			alert("해지되었습니다.");
			window.location.href = location.href;
		}
		else {
			alert("해지가 실패했습니다.");
		}
	},"json");
}
//]]>
</script>
</head>
<body style="background:#fff">

<h3 class="mt30">SNS 로그인을 이용하여 간편하게 사이트를 로그인하실 수 있습니다. </h3>
<div class="alert mt30">
	<p class="fs2 pl10">아래의 SNS 중 로그인에 이용하실 SNS를 클릭하시고, 연결해두시면 로그인 시 해당 SNS 을 이용하여 로그인 하실 수 있습니다.</p>
	<ul class="bull">
		<li>단 해당 서비스는 단순 로그인 기능을 SNS로 대체하는 것으로 “연동 해지”를 하셔도 회원정보는 삭제되지 않습니다.</li>
		<li>SNS을 통해서 인증(네이버 또는 페이스북)하신 경우에는 연결 해지 하실 수 없습니다. 연결 해지하시려면 정보수정 페이지에서 SNS 인증 삭제하시면 됩니다. </li>
	</ul>
</div>



<h3>간편 로그인 설정</h3>
<!-- bdList -->
<div>
	<table class="board_type_0">
		<caption>간편 로그인 설정 목록</caption>

		<colgroup>
		<col style="width:15%;" />
		<col  />
		<col style="width:20%;" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">서비스</th>
				<th scope="col">연결하기</th>
				<th scope="col">연결 해지</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="simpleVO" items="${simpleList }" varStatus="status">
			<tr>
				<td>
				<c:choose>
					<c:when test="${simpleVO.code eq '03' }">
						<img src="/edu/images/sub/img_naver.gif" alt="네이버" />
					</c:when>
					<c:when test="${simpleVO.code eq '01' }">
						<img src="/edu/images/sub/img_kakao.gif" alt="카카오톡" />
					</c:when>
					<c:when test="${simpleVO.code eq '04' }">
						<img src="/edu/images/sub/img_facebook.gif" alt="페이스북" />
					</c:when>
					<c:when test="${simpleVO.code eq '02' }">
						<img src="/edu/images/sub/img_google.gif" alt="구굴" />
					</c:when>
				</c:choose>
				</td>
				<td>
					<c:if test="${not empty simpleVO.authKey }">
						${simpleVO.authDt } 연결완료
					</c:if>

					<c:if test="${empty simpleVO.authKey }">
						<c:choose>
						<c:when test="${simpleVO.code eq '03' }">
							<c:set var="btnId" value="naverLoginBtn" />
						</c:when>
						<c:when test="${simpleVO.code eq '01' }">
							<c:set var="btnId" value="kakaoLoginBtn" />
						</c:when>
						<c:when test="${simpleVO.code eq '04' }">
							<c:set var="btnId" value="fbLoginBtn" />
						</c:when>
						<c:when test="${simpleVO.code eq '02' }">
							<c:set var="btnId" value="googleBtn" />
						</c:when>
				</c:choose>
						<div class="board_util_btn_con center">
							<a href="javascript:void(0);" id="${btnId }" class="btn_style_0 full right" title="새창열림">연결하기</a>
						</div>
					</c:if>

				</td>
				<td>
					<c:if test="${not empty simpleVO.authKey }">
						<div class="board_util_btn_con center">
							<a class="btn_style_0 full close_w trmnatBtn" data-userSn="${simpleVO.userSn }" data-authSe="${simpleVO.authSe }" href="#self"><span>해지</span></a>
						</div>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<div id="naver_id_login" style="display:none;"></div>
</div>
</body>
</html>