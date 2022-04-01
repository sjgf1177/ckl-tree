<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[
$(function() {

	$("#nextBtn").click(function() {
		if (!$("#agreeTp1Y").is(":checked")) {
			alert("개인정보 수집 및 이용에 동의해 주시기 바랍니다.");
			return false;
		}
		if (confirm("다음 단계로 이동하시겠습니까?")) {
			window.location.href = "/<c:out value="${paramVO.siteName}" />/fcltyResve/resveSttus/step2.do?menuNo=<c:out value="${param.menuNo}" />&fcltySn=<c:out value="${param.fcltySn}" />";
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
		<li>공간 및 일자/시간 선택</li>
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
	<li>1. 수집 &middot; 이용 목적 : 콘텐츠코리아랩의 시설과 장비에 대한 예약을 위한 사용자 정보 수집 및 이용</li>
	<li>2. 개인정보 수집 항목 :
		<div class="m1">
			<dl>
				<dt>[시설예약]</dt>
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
				<span class="dib fl">	위 개인정보 수집 및 이용 내용에 </span>
				<label for="agreeTp1Y"><input type="radio" name="agreeTp1" value="Y" id="agreeTp1Y" /> 동의합니다. </label>
				<label for="agreeTp1N"><input type="radio" name="agreeTp1" value="N" id="agreeTp1N" /> 동의하지 않습니다. </label>
			</div>
		</div>
	</form>
</fieldset>


<div class="btnSet tar">
<a href="#self" class="btn btn-primary" id="nextBtn">다음</a>
	<a href="#self" class="btn btn-gray" id="cancelBtn">취소</a>
</div>
