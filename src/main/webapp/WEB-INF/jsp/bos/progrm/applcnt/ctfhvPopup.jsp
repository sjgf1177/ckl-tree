<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<head>
	<title>수료증 | 한국콘텐츠진흥원</title>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="/edu/css/common.css" />

<style type="text/css">
	
	@font-face {
    font-family: 'KBIZHanmaumMyungjo';
    src: url('/fonts/fonts/KBIZHanmaumMyungjo.ttf') format('truetype');
    
	}
	
	.bodyBg{position: absolute;right: 0; top:0;}
	.popup{position: relative;font-size: 14px;width: 100%; height:100vh; overflow-y:auto;overflow-x:hidden;}
	.popup.font_myungjo{font-size:18px; color:#080300;}
	.popup>div{border:0px solid #a4a4a4;padding:60px 12px 18px 12px;margin:0px 30px 57px 30px;/*height:565px;*/  background: url() no-repeat 50% 64%;}
	.certifiNum{position: relative;width: 100%;height: 55px;}
	.certifiNum>div{width: 50%;float: left;}
	.certifiNum p{font-size:16px;letter-spacing:-0.5px;}
	.rtLogo{position: absolute;right: -60px;top:-17px;width: 200px !important;height: 43px;}
	.h1Title{display: block;line-height:50px;text-align: center; font-size:48px; letter-spacing:-0.5px;}
	.h1Title img{height:50px;}
	.h1Title span{display:inline-block;padding:0 13px;}
	/*.contents{margin:0 20px 35px 20px;float: left;clear:both;}*/
	.contents{margin:0 0px 35px 0px;clear:both;}
	.certiInfo{font-size: 18px; line-height:35px; letter-spacing:-0.75px;}
	.certiInfo ul{text-align:right;}
	.certiInfo li:first-child{letter-spacing:-0.5px;}
	.steps{display: inline-block;/*letter-spacing: 2px*/}
	.name{display: inline-block; letter-spacing: 4px;}
	.print_btn_box{position: absolute;left:50%;bottom:20px;transform:translateX(-50%);}
	.desc{position: relative;z-index:10;font-size: 20px;font-weight: 600;margin: 55px 0 100px 0; line-height:50px; letter-spacing:-0.25px;}
	.bgBoxLogo{position: absolute;z-index:1;left:50%;top:60%;margin-left: -120px;margin-top:-120px;}
	
	.orgInfo{float: right;margin:0 5px;}
	.ftMark{float: right;width:100%;height:70px}
	.printBtn{display: inline-block;background: url(/images/certificate/certificate_07.gif) no-repeat;width: 100px;height: 33px;}
	.okBtn{display: inline-block;background: url(/images/certificate/certificate_08.gif) no-repeat;width: 100px;height: 33px;}
	.orgInfo.tar{position: relative;}
	.orgInfo.tar p{margin-right:40px;font-size:24px;}
	.orgInfo.tar p img{height:35px;}
	.sign_img_box{position: absolute;top: 25px; width: 90px; height: 88px; right: 0px; object-fit:cover; display:block; z-index:-10;}
	.today{text-align:center; font-size:24px;letter-spacing:1px;}
	.padding{padding: 0 8px;}
	.font_myungjo{font-family: KBIZHanmaumMyungjo;}
	.font_myungjo h1{font-family: KBIZHanmaumMyungjo;}
	
</style>
<!--[if lt IE 9]>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
<!--[if lte IE 8]><script type="text/javascript"> $('html').attr('id','ie8'); </script><![endif]-->
<!--[if lte IE 7]><script type="text/javascript"> $('html').attr('id','ie7'); </script><![endif]-->

</head>
<body onload="window.print();">

<!-- windowSize : 650 x 775 -->
<div class="popup font_myungjo">
	<div class="">
		<!-- popupContents -->
		<div class="certifiNum">
			<!--  <div><span class="dib vt"><img src="/images/certificate/certificate_02.gif" alt=""></span>-->
			<p>제 ${yearMonth}-PG<c:out value="${masterResult.prgSe}"/>-<c:out value="${masterResult.prgCl}"/>-<c:out value="${result.resveNo}"/>호</p></div>
			<!--  
			<div class="rtLogo">
				<img src="/images/certificate/certificate_01.jpg" alt="Create NeWave KOCCA!">
			</div>
			-->
		</div>

		<h1 class="h1Title tac"><img src="/images/certificate/title01.png" alt="수료증"><!-- 수<span></span>료<span></span>증 --></h1>


		<div class="contents">
			<div class="certiInfo">
				<ul>
					<li> 
						<span class="name"><c:out value="${result.nm}"/></li>
					<li><!-- <img src="/images/certificate/certificate_04.gif" alt=""> -->
						<span class="steps">교육과정명 <span class="padding">:</span>  <c:out value="${masterResult.prgNm}"/></li>
					<!--  
					<li> <img src="/images/certificate/certificate_04.gif" alt="">
						<span class="day"><span>교</span><span>육</span><span>기</span><span>간</span></span> <span class="padding">:</span>  <c:out value="${masterResult.prgBgnde}"/> ~ <c:out value="${masterResult.prgEndde}"/></li>
					<li> <img src="/images/certificate/certificate_04.gif" alt=""> 
						<span class="name"><span>이</span><span>름</span></span> <span class="padding">:</span>  <c:out value="${result.nm}"/></li>
					-->
				</ul>

				<div class="desc tal">
					　위 사람은 문화체육관광부가 주최하고 한국콘텐츠진흥원이 주관한 『<c:out value="${masterResult.prgNm}"/>』 상기 교육과정을 수료하였기에 이 증서를 수여합니다.
				</div>
				<p class="today"><c:out value="${today}"/></p>
			</div>
		</div>
		<div class="orgInfo tar">
			<img class="sign_img_box" src="/edu/images/onlineEdu/polity/kbistamp.gif" alt=""></img>
			<!--  <p><c:out value="${today}"/></p> -->
			<p><img src="/images/certificate/sign02.png" alt="한국콘텐츠진흥원장 조 현 래"><!-- <strong>한국콘텐츠진흥원장 조 현 래</strong>--></p>
		</div>

		<!-- 
		<div class="ftMark tar">
			<img src="/images/certificate/certificate_06.jpg" alt="에듀코카">
		</div>
		 -->
		<!-- //popupContents -->
		<div class="bgBoxLogo">
			<%-- <img src="/images/certificate/certificate_05.png" alt="">--%>
		</div>
		 
	</div>
</div>
<!-- //popupBox -->

<div class="bodyBg"></div>

<!--[if lte IE 7]>
<script type="text/javascript">
//<![CDATA[
	$('*').each(function(index) {
		if ($(this).css("overflow")=="hidden"){
			$(this).css("zoom",1);
		}
		if ($(this).css("display")=="inline-block"){
			$(this).css("display",'inline');
			$(this).css("zoom",1);
		}
	});
//]]>
</script>
<![endif]-->

</body>
</html>