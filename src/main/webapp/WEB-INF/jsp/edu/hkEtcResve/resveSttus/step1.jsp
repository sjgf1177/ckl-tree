<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">-->
 <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> 
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/common.css"> -->
<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.child4 li{
	width: 22%;
}
.noLink li.on{
	border: 1px solid #40abd4;
	border-bottom-color: transparent;
	color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
	text-decoration: unset;
}
.noLink li{
	border-bottom-color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
}
.agreeScrBtm{
	font-size: 14px;
	background-color: #eee;
}
.scrollY{
	font-size: 1.6rem;
	height: 200px;
}
@media (min-width: 800px) {
	.tabs{
		min-width: 750px;
	}
}

@media (max-width: 800px) {
.tabs{
		min-width: none;
}
 .tabs ol li{
 	display: none;
 }
 .tabs ol li.on{
 	display:block;
 	width: 100%;
 }
}
#relation_site{
background-image:url('/edu/new_image/relation_site_arrow.png')!important;
background-repeat:no-repeat!important;
border:none!important;
border-bottom:2px solid white!important;
background-position:right 7px!important;
background-size:8px!important;
line-height:2.0rem!important;
}
</style>

<script type="text/javascript">
//<![CDATA[
$(function() {

	$("#nextBtn").click(function() {
		if (!$("#agreeTp1Y").is(":checked")) {
			alert("개인정보 수집 및 이용에 동의해 주시기 바랍니다.");
			return false;
		}
		if (confirm("다음 단계로 이동하시겠습니까?")) {
			window.location.href = "/<c:out value="${paramVO.siteName}" />/hkEtcResve/resveSttus/step2.do?menuNo=<c:out value="${param.menuNo}" />&fcltySn=<c:out value="${param.fcltySn}" />";
		}
		return false;
	});

	$("#cancelBtn").click(function() {
		if (confirm("‘예약을 취소하시겠습니까?")) {
			window.history.back();
		}
		return false;
	});

});
//]]>
</script>

<div class="tabs child4 noLink">
	<ol>
		<li class="on">개인정보 동의<span class="sr-only">(현재단계)</span></li>
		<li>장비 및 일자/시간 선택</li>
		<li>예약자 정보 입력</li>
		<li>예약완료</li>
	</ol>
</div>



<fieldset>
	<legend>개인정보 수집 및 이용 (필수) 입력양식</legend>
	<form name="agreeForm" action="/cop/member/join02.do" method="post">
		<div>
			<h2>개인정보 수집 및 이용 (필수)</h2>
			<div tabindex="0" class="scrollY">


<br />
<ul>
	<li>1. 수집 &middot; 이용 목적 : 에듀코카의 시설과 장비에 대한 예약을 위한 사용자 정보 수집 및 이용</li>
	<li>2. 개인정보 수집 항목 :
		<div class="m1">
			<dl>
				<dt>[장비예약]</dt>
				<dd>필수항목 : 이름, 휴대폰, 이메일, 나이, 직업, 거주지역, 사용인원, 사용목적, 예약정보수신방법</dd>
				<dd>선택항목 : 사용목적상세</dd>
			</dl>
		</div>
	</li>
	<li>3. 개인정보 보유 및 이용기간 : 시설 이용 후 3년간 정보를 보관</li>
	<li>4. 동의 거부 시 불이익에 관한 사항 : 수집 &middot; 이용에 관한 사항의 동의를 거부할 때에는 예약 서비스의 이용이 제한됩니다.   단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.</li>
</ul>


			</div>
			<div class="agreeScrBtm tar">
				<!-- <span class="dib fl">	위 개인정보 수집 및 이용 내용에 </span> -->
				<label for="agreeTp1Y"><input type="radio" name="agreeTp1" value="Y" id="agreeTp1Y" /> 동의합니다. </label>
				<label for="agreeTp1N"><input type="radio" name="agreeTp1" value="N" id="agreeTp1N" /> 동의하지 않습니다. </label>
			</div>
		</div>
	</form>
</fieldset>


<div class="btnSet tar board_util_btn_con">
<a href="#self" class="btn_style_0 green radius" id="nextBtn">다음</a>
	<a href="#self" class="btn_style_0 blue radius" id="cancelBtn">취소</a>
</div>
