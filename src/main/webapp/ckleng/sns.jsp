<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.TimeZone" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%
org.springframework.context.ApplicationContext context = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));
request.setAttribute("kakaoJavascriptKey", propertiesService.getString("Sns.kakaoJavascriptKey"));
request.setAttribute("linkedInAppKey", propertiesService.getString("Sns.linkedInAppKey"));

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'");

Date s = (Date)dateFormat.parse("20150403T000000Z");
Date e = (Date)dateFormat.parse("20151230T230000Z");
dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
String sDate = dateFormat.format(s);
String eDate = dateFormat.format(e);

pageContext.setAttribute("sDate", sDate);
pageContext.setAttribute("eDate", eDate);
%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/jquery.cookies.js"></script>
<script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<!-- <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script> -->
<script type="text/javascript" src="/js/sns/facebook.js"></script>
<script type="text/javascript" src="/js/sns/kakao.min.js"></script>
<script type="text/javascript" src="/js/sns/kakao.js"></script>
<script src="https://apis.google.com/js/plus.js"></script>
<script type="text/javascript" src="/js/sns/linkedIn.js"></script>
<script type="text/javascript" src="http://platform.linkedin.com/in.js">
	api_key:   <c:out value="${linkedInAppKey}" />
	authorize: true
    //onLoad: onLinkedInLoad
</script>



<script type="text/javascript">
//<![CDATA[
var kakaoAuthResponse = false;

$(function() {

	// 페이스북 초기화
	 $.sFacebook.initialize({
		appId : '<c:out value="${facebookAppKey}" />', // 페이스북 App Id 입력.
		me_photo_target : '#profile_photo',
		me_name_target : '#profile_name',
		me_id_target : '#fbSnsId',
		me_image_url : '#image',
		me_fb_login_target : '#fbLoginImg',
		me_sns_name : '#snsName'
	});


	// 링크드인 초기화
	 $.sLinkedIn.initialize({
		me_photo_target : '#profile_photo',
		me_name_target : '#profile_name',
		me_id_target : '#linkedInSnsId',
		me_image_url : '#image',
		me_linkedIn_login_target : '#linkedInLoginImg',
		me_sns_name : '#snsName'
	});


	// 카카오 초기화
	$.sKakao.initialize({
		me_photo_target : '#profile_photo',
		me_name_target : '#profile_name',
		me_id_target : '#kakaoSnsId',
		me_image_url : '#image',
		me_kakao_login_target : '#kakaoLoginImg',
		me_sns_name : '#snsName'
	});


	// facebook 로그인
	$("#fbLoginBtn").click(function() {

		$.sFacebook.login();

		return false;
	});


	// linkedIn 로그인
	$("#linkedInLoginBtn").click(function() {

		$.sLinkedIn.login();

		return false;
	});



	//댓글 글씨기
	$("#submitBtn").click(function(){

		// 페이스북로그인 여부
		var fbLoginTp = false;
		if ($("#fbSnsId").val() != "")  {
			fbLoginTp = true;
		}

		// 카카오 여부
		var kakaoLoginTp = false;
		if ($("#kakaoSnsId").val() != "")  {
			kakaoLoginTp = true;
		}


		// 링크드인 로그인 여부
		var linkedInLoginTp = false;
		if ($("#linkedInSnsId").val() != "")  {
			linkedInLoginTp = true;
		}


		if (fbLoginTp || kakaoLoginTp || linkedInLoginTp)  {
			if ($("#ctContent").val() == '') {
				window.alert('내용을 입력해 주세요.');
				$("#ctContent")[0].focus();
			    return false;
			}

			var dataToBeSent = $("#cmmnt").serialize();

			var shortUrl = $("#cmmShortUrl").val();

			/* var action = "/ckl/cargos/commentInsert.do";
			$.post(
				action,
				dataToBeSent,
				function(data)
				{
					var resultCode = data.resultCode;
					var resultMsg = data.msg;
					var shortUrl = $("#cmmShortUrl").val();

					if( resultCode == 'success' ){

						if (twtLoginTp) {
							jQuery.sTwitter.post_feed('#ctContent',shortUrl);
						}


						$("#ctContent").val("");
						$("#ctSeqno").val("0");


					}
				}
			); */

			// 페이스북 글쓰기
			if (fbLoginTp) {
				jQuery.sFacebook.post_feed('#ctContent',shortUrl);
			}

			// 카카오 글쓰기
			if (kakaoLoginTp) {
				jQuery.sKakao.post_feed('#ctContent',shortUrl);
			}

			// 링크드인 글쓰기
			if (linkedInLoginTp) {
				jQuery.sLinkedIn.post_feed('#ctContent',shortUrl);
			}


			$("#ctContent").val("");
			$("#ctSeqno").val("0");


		}
		else {
			alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
		}
		return false;
	});


	//글 수정
	$("#updateBtn").click(function(){

		// 페이스북로그인 여부
		var fbLoginTp = false;
		if ($("#fbSnsId").val() != "")  {
			fbLoginTp = true;
		}

		// 카카오 여부
		var kakaoLoginTp = false;
		if ($("#kakaoSnsId").val() != "")  {
			kakaoLoginTp = true;
		}

		// 링크드인 로그인 여부
		var linkedInLoginTp = false;
		if ($("#linkedInSnsId").val() != "")  {
			linkedInLoginTp = true;
		}

		if (fbLoginTp || kakaoLoginTp || linkedInLoginTp)  {

			// 페이스북 글수정
			if (fbLoginTp) {
				jQuery.sFacebook.update_feed('#ctContent',shortUrl);
			}


		}
		else {
			alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
		}
		return false;
	});
	//글 삭제
	$("#deleteBtn").click(function(){

		// 페이스북로그인 여부
		var fbLoginTp = false;
		if ($("#fbSnsId").val() != "")  {
			fbLoginTp = true;
		}

		// 카카오 여부
		var kakaoLoginTp = false;
		if ($("#kakaoSnsId").val() != "")  {
			kakaoLoginTp = true;
		}


		// 링크드인 로그인 여부
		var linkedInLoginTp = false;
		if ($("#linkedInSnsId").val() != "")  {
			linkedInLoginTp = true;
		}


		if (fbLoginTp || kakaoLoginTp || linkedInLoginTp)  {


			// 페이스북 글수정
			if (fbLoginTp) {
				jQuery.sFacebook.delete_feed();
			}

			// 카카오스토리 글삭제
			if (kakaoLoginTp) {
				jQuery.sKakao.delete_feed();
			}


		}
		else {
			alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
		}
		return false;
	});

	//로그아웃
	$("#logOutBtn").click(function(){

		// 페이스북로그인 여부
		var fbLoginTp = false;
		if ($("#fbSnsId").val() != "")  {
			fbLoginTp = true;
		}

		// 카카오 여부
		var kakaoLoginTp = false;
		if ($("#kakaoSnsId").val() != "")  {
			kakaoLoginTp = true;
		}

		// 링크드인 로그인 여부
		var linkedInLoginTp = false;
		if ($("#linkedInSnsId").val() != "")  {
			linkedInLoginTp = true;
		}


		if (fbLoginTp || kakaoLoginTp || linkedInLoginTp)  {

			// 페이스북 로그아웃
			if (fbLoginTp) {
				jQuery.sFacebook.logout();
			}

			// 카카오스토리 로그아웃
			if (kakaoLoginTp) {
				jQuery.sKakao.logout();
			}

			// 링크드인 로그아웃
			if (linkedInLoginTp) {
				jQuery.sLinkedIn.logout();
			}

		}
		else {
			alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
		}
		return false;
	});

	//글조회
	$("#searchSnsBtn").click(function(){

		// 페이스북로그인 여부
		var fbLoginTp = false;
		if ($("#fbSnsId").val() != "")  {
			fbLoginTp = true;
		}

		// 카카오 여부
		var kakaoLoginTp = false;
		if ($("#kakaoSnsId").val() != "")  {
			kakaoLoginTp = true;
		}

		if (fbLoginTp || kakaoLoginTp)  {

			// 페이스북 글조회
			if (fbLoginTp) {
				window.open('/facebookListPop.jsp', 'snsListPop', 'width=1000, height=600, scrollbars=yes');
				//jQuery.sFacebook.getPersonalFeed();
			}

			// 카카오스토리 글조회
			if (kakaoLoginTp) {

				window.open('/kakaoListPop.jsp', 'snsListPop', 'width=1000, height=600, scrollbars=yes');
				//jQuery.sKakao.getPersonalFeed();
			}
		}
		else {
			alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
		}
		return false;
	});

});

	// 사용할 앱의 Javascript 키를 설정해 주세요.
    Kakao.init('<c:out value="${kakaoJavascriptKey}" />');
    function loginWithKakao() {

    	$.sKakao.login();

    };

//]]>
</script>


<script type="text/javascript">

		$(function() {

			$("#googleCalenderBtn").click(function() {


				var text = "test";
				var dates = $("#sDate").val()+"/"+$("#eDate").val();
				var location = "우리집";
				var details = $("#ctContent").val();

				var googleCalenderURL = "https://www.google.com/calendar/render?action=TEMPLATE&text="+encodeURI(text)+"&dates="+dates+"&location="+encodeURI(location)+"&sprop=name:FINTECH&details="+encodeURI(details)+"&sf=true&output=xml";


				window.open(googleCalenderURL, "googleCalenderPop");

				return false;
			});
		});


	    </script>


<div id="fb-root"></div>
<script>$(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.3";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
<div class="fb-like" data-href="https://www.ftic.co.kr:9999" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
<!--
<div class="fb-like" data-href="https://pms.ccbrain.co.kr:9999" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
 -->
<!-- <div class="fb-like" data-href="https://pms.ccbrain.co.kr:9999" data-layout="standard" data-action="like" data-show-faces="true" data-share="false"></div> -->
<!-- <div class="fb-like" data-href="https://pms.ccbrain.co.kr:9999" data-layout="box_count" data-action="like" data-show-faces="true" data-share="false"></div> -->


</head>
<br />
<a href="#" id="fbLoginBtn"><img id="fbLoginImg" src="/ckl/images/facebook.png" alt="Facebook Login" width="45px" height="45px"/></a>
<a href="#" id="linkedInLoginBtn"><img  id="linkedInLoginImg" src="/ckl/images/linkedIn.png" alt="LinkedIn Login" width="45px" height="45px" /></a>
<a href="#" onclick="loginWithKakao();" id="kakaoLoginBtn"><img  id="kakaoLoginImg" src="/ckl/images/kakao_story.png" alt="Kakao Login" width="45px" height="45px"/></a>


<input type="hidden" name="sDate" id="sDate" value="${sDate}" />
<input type="hidden" name="eDate" id="eDate" value="${eDate}" />


<a href="#" id="googleCalenderBtn"><img  id="googleCalenderImg" src="/ckl/images/google_calender.png" alt="googleCalender" width="45px" height="45px" /></a>

<img id="profile_photo" style="width:79px;height:80px;" src="http://www.kaia.re.kr/ckl/images/common/img_reply_none.gif" alt="" />
<textarea cols="10" rows="0" id="ctContent" name="ctContent" class="snsContent" style="width:719px; height:72px;" title="덧글내용입력" ></textarea>
<input type="button" alt="등록" id="submitBtn" class="snsSubmitBtn" value="등록"/>
<input type="button" alt="수정" id="updateBtn" class="updateBtn" value="수정"/>
<input type="button" alt="삭제" id="deleteBtn" class="deleteBtn" value="삭제"/>
<input type="button" alt="로그아웃" id="logOutBtn" class="logOutBtn" value="로그아웃"/>
<input type="button" alt="글조회" id="searchSnsBtn" class="searchSnsBtn" value="글조회"/>

<br />
<input type="hidden" name="shortUrl" id="shortUrl" value="" /><br />
<input type="hidden" id="cmmShortUrl" name="cmmShortUrl" value="" /><br />
<input type="hidden" name="fbSnsId" id="fbSnsId" value="" /><br />
<input type="hidden" name="kakaoSnsId" id="kakaoSnsId" value="" /><br />
<input type="hidden" name="linkedInSnsId" id="linkedInSnsId" value="" /><br />
<input type="hidden" name="snsName" id="snsName" value="" /><br />
<input type="hidden" name="image" id="image" value="" /><br />
<input type="hidden" name="gubun" id="gubun" value="" /><br />

<body>
</body>
</html>