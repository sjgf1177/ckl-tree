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

	Kakao.init('<c:out value="${kakaoJavascriptKey}" />');

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


	// 카카오 로그인
	$("#kakaoLoginBtn").click(function() {



		$.sKakao.login();

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
				window.open('/facebookListPop.jsp?type=option1', 'snsListPop', 'width=1000, height=600, scrollbars=yes');
				//jQuery.sFacebook.getPersonalFeed();
			}

			// 카카오스토리 글조회
			if (kakaoLoginTp) {

				window.open('/kakaoListPop.jsp?type=option1', 'snsListPop', 'width=1000, height=600, scrollbars=yes');
				//jQuery.sKakao.getPersonalFeed();
			}
		}
		else {
			alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
		}
		return false;
	});

});


//댓글 글씨기
function goPostSns(URL, returnURL){

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
		if ($("#nttCn").val() == '') {
			window.alert('내용을 입력해 주세요.');
			$("#nttCn")[0].focus();
		    return false;
		}

		var dataToBeSent = $("#cmmnt").serialize();

		var shortUrl = $("#cmmShortUrl").val();

		/* var action = "/portal/cargos/commentInsert.do";
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
						jQuery.sTwitter.post_feed('#option1',shortUrl);
					}


					$("#option1").val("");
					$("#ctSeqno").val("0");


				}
			}
		); */

		// 페이스북 글쓰기
		if (fbLoginTp) {
			jQuery.sFacebook.post_feed('#nttSj', '#nttCn', URL, shortUrl);
		}

		// 카카오 글쓰기
		if (kakaoLoginTp) {
			jQuery.sKakao.post_feed('#nttSj','#nttCn',URL, shortUrl);
		}

		// 링크드인 글쓰기
		if (linkedInLoginTp) {
			jQuery.sLinkedIn.post_feed('#nttSj','#nttCn',URL, shortUrl);
		}

		alert("등록 되었습니다.");
		location.href =  returnURL;


	}
	else {
		alert("KAIA계정 혹은 SNS계정 로그인 후 이용해 주시기 바랍니다.");
	}
	return false;
}

//]]>
</script>


<script type="text/javascript">

		$(function() {

			$("#googleCalenderBtn").click(function() {


				var text = $("#nttSj").val();
				var dates = $("#sDate").val()+"/"+$("#eDate").val();
				var location = "우리집";
				var details = $("#nttCn").val();

				var googleCalenderURL = "https://www.google.com/calendar/render?action=TEMPLATE&text="+encodeURI(text)+"&dates="+dates+"&location="+encodeURI(location)+"&sprop=name:FINTECH&details="+encodeURI(details)+"&sf=true&output=xml";


				window.open(googleCalenderURL, "googleCalenderPop");

				return false;
			});
		});




	    </script>



<img id="profile_photo" style="width:45px;height:45px;" src="http://www.kaia.re.kr/portal/images/common/img_reply_none.gif" alt="" />
<a href="javascript:void(0);" id="fbLoginBtn"><img id="fbLoginImg" src="/portal/images/facebook.png" alt="Facebook Login" width="45px" height="45px"/></a>
<a href="javascript:void(0);" id="linkedInLoginBtn"><img  id="linkedInLoginImg" src="/portal/images/linkedIn.png" alt="LinkedIn Login" width="45px" height="45px" /></a>
<a href="javascript:void(0);" id="kakaoLoginBtn"><img  id="kakaoLoginImg" src="/portal/images/kakao_story.png" alt="Kakao Login" width="45px" height="45px"/></a>


<input type="hidden" name="sDate" id="sDate" value="${sDate}" />
<input type="hidden" name="eDate" id="eDate" value="${eDate}" />

<a href="javascript:void(0);" id="googleCalenderBtn"><img  id="googleCalenderImg" src="/portal/images/google_calender.png" alt="googleCalender" width="45px" height="45px" /></a>
<input type="button" alt="로그아웃" id="logOutBtn" class="logOutBtn" value="전체 로그아웃"/>
<!-- <input type="button" alt="등록" id="submitBtn" class="snsSubmitBtn" value="등록"/> -->
<!-- <input type="button" alt="수정" id="updateBtn" class="updateBtn" value="수정"/>
<input type="button" alt="삭제" id="deleteBtn" class="deleteBtn" value="삭제"/> -->

<br />
<input type="hidden" name="shortUrl" id="shortUrl" value="" /><br />
<input type="hidden" id="cmmShortUrl" name="cmmShortUrl" value="" /><br />
<input type="hidden" name="fbSnsId" id="fbSnsId" value="" /><br />
<input type="hidden" name="kakaoSnsId" id="kakaoSnsId" value="" /><br />
<input type="hidden" name="linkedInSnsId" id="linkedInSnsId" value="" /><br />
<input type="hidden" name="snsName" id="snsName" value="" /><br />
<input type="hidden" name="image" id="image" value="" /><br />
<input type="hidden" name="gubun" id="gubun" value="" /><br />

