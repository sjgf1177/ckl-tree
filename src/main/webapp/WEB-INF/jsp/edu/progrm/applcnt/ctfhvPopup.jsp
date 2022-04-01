<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="ko">
<head>
	<title>수료증 | 한국콘텐츠진흥원</title>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="/edu/css/common.css" />
	<script type="text/javascript" src="/js/jquery.js"></script>

<style type="text/css">
	.bodyBg{position: absolute;right: 0; top:0;}
	.popup{position: relative;font-size: 13px;width: 100%}
	.popup>div{box-sizing: border-box;border:3px solid #a4a4a4;padding:18px 12px;margin:65px 65px 30px 65px;height:24cm;  background: url() no-repeat 50% 64%;}
	//.popup>div{border:3px solid #a4a4a4;padding:18px 12px;margin:65px 65px 37px 65px;height:565px;  background: url() no-repeat 50% 64%;}
	.certifiNum{position: relative;width: 100%;height: 55px;}
	.certifiNum>div{width: 50%;float: left;}
	.rtLogo{position: absolute;right: -12px;top:-17px;width: 200px !important;height: 43px;}
	.h1Title{display: block;height: 120px;text-align: center;}
	.contents{margin:0 20px 35px 20px;padding-bottom: 220px;float: left;clear:both; width:100%;}
	/* .contents{margin:0 20px 35px 20px;float: left;clear:both;} */
	.certiInfo{font-size: 13px;}
	.steps{display: inline-block;letter-spacing: 2px}
	.name{display: inline-block;letter-spacing: 9px}

	.desc{position: relative;z-index:10;font-size: 12px;font-weight: 600;margin: 55px 0 50px 0;}
	.bgBoxLogo{position: absolute;z-index:1;left:50%;top:60%;margin-left: -120px;margin-top:-120px;}

	.orgInfo{float: right;margin:0 5px;}
	.ftMark{float: right;width:100%;height:70px}
	.printBtn{display: inline-block;background: url(/images/certificate/certificate_07.gif) no-repeat;width: 100px;height: 33px;}
	.okBtn{display: inline-block;background: url(/images/certificate/certificate_08.gif) no-repeat;width: 100px;height: 33px;}


</style>
<!--[if lt IE 9]>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->
<!--[if lte IE 8]><script type="text/javascript"> $('html').attr('id','ie8'); </script><![endif]-->
<!--[if lte IE 7]><script type="text/javascript"> $('html').attr('id','ie7'); </script><![endif]-->

</head>
<body>

<!-- windowSize : 650 x 775 -->
<div class="popup">
	<div>
		<!-- popupContents -->
		<div class="certifiNum">
			<div><span class="dib vt"><img src="/images/certificate/certificate_02.gif" alt=""></span>
			<strong>제 ${yearMonth}-PG<c:out value="${masterResult.prgSe}"/>-<c:out value="${masterResult.prgCl}"/>-<c:out value="${result.resveNo}"/>호</strong></div>
			<div class="rtLogo"><!-- <img src="/images/certificate/certificate_01.gif" alt="Create NeWave KOCCA!"> --></div>
		</div>

		<h1 class="h1Title tac"><img src="/images/certificate/certificate_03.gif" alt="수 료 증" /></h1>


		<div class="contents">
			<div class="certiInfo">
				<ul>
					<li><img src="/images/certificate/certificate_04.gif" alt="">
						<span class="steps">과 정 명</span> :  <c:out value="${masterResult.prgNm}"/></li>
					<li><img src="/images/certificate/certificate_04.gif" alt="">
						<span class="day">교육 기간</span> :  <fmt:formatDate value="${masterResult.prgBgnde}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${masterResult.prgEndde}" pattern="yyyy-MM-dd"/></li>
					<li><img src="/images/certificate/certificate_04.gif" alt="">
						<span class="name">이 름</span> :  <c:out value="${result.nm}"/></li>
				</ul>

				<div class="desc tal" style="">
					위 사람은 한국콘텐츠진흥원에 진행한<br />
					 ‘<c:out value="${masterResult.prgNm}"/>’<br />
					 에 참여하여 	상기 교육과정을 이수하였으므로 이 증서를 수여합니다.
				</div>
			</div>
		</div>
		
		<div class="orgInfo tar">
			<p><c:out value="${today}"/></p>
			<p><strong>한국콘텐츠진흥원</strong></p>
		</div>

		<div class="ftMark tar"><img src="/images/certificate/certificate_06.gif" alt="에듀코카"></div>
		<!-- //popupContents -->
		<div class="bgBoxLogo"><img src="/images/certificate/certificate_05.gif" alt="한국콘텐츠진흥원 CI 마크"></div>
	</div>
</div>
	<div class="tac">
		<a href="#btn_print" onclick="printCerti()" onkeypress="this.onclick();" class="aPrintBtn" ><span class="printBtn"></span></a>
		<a href="javascript:window.close();" ><span class="okBtn"></span></a>
	</div>
<!-- //popupBox -->

<div class="bodyBg"><img src="/images/certificate/certificate_bg.gif" alt=""></div>

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

<script>
function printCerti(){
	$(".aPrintBtn").hide();
	window.print();
	$(".aPrintBtn").show();
	return false;
}
</script>