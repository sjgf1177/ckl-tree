<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
function checkForm(form) {

	var v= new MiyaValidator(form);

	v.add("agreeYN1", {
        required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}
}

</script>

<c:url value="/edu/job/empymnCnsl/recruit01.do" var="agreeForm">
<c:param name="menuNo" value="${param.menuNo }"/>
</c:url>


<form name="agreeForm" action="<c:out value="${agreeForm }" />" method="post" onsubmit="return checkForm(this);"  >
<input type="hidden" name="menuNo" value="${param.menuNo }" >
	<div>
		<h3>개인정보 수집 및 이용</h3>
		<div tabindex="0" class="agreeScr">

<p class="fs1">개인정보 수집ㆍ이용에 대한 안내</p>

<ol>
	<li>1. 개인정보의 수집 · 이용 목적
		<ul class="bull">
			<li>취.창업 관련 서비스 이용에 대한 상담 진행을 위한 기본적인 대상자 정보 및 정보 전달을 위한 원활한 의사소통 경로의 확보</li>
		</ul>
	</li>
	<li>2. 수집하는 개인정보의 항목
		<ul class="bull">
			<li>필수항목 :  성명, 생년월일, 성별,  이메일, 연락처, 거주지</li>
			<li>선택항목 :  학교/학과/학년, 희망직무, 상담신청내용, 이력서</li>
		</ul>
	</li>
	<li>3. 개인정보의 보유 및 이용기간
	<ul class="bull">
		<li>원칙적으로 개인정보의 수집 또는 제공받은 목적 달성 시 자체없이 파기합니다.</li>
		<li>단, 수집목적 및 제공 받은 목적이 달성된 경우에도 법률의 규정에 따라 보존할 필요가 있는 법률의 규정에 따라 고객의 개인 정보를 보유할 수 있습니다.
			<ul class="bull">
				<li>계약 또는 청약철회 등에 관한 기록 : 5년</li>
				<li>대금결제 및 재화 등의 공급에 관한 기록 :  5년</li>
				<li>소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 등</li>
			</ul>
		</li>
	</ul>
	<li>4. 동의 거부 시 불이익에 관한 사항 : 수집 &middot; 이용에 관한 사항의 동의를 거부할 때에는 예약 서비스의 이용이 제한됩니다.   단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.</li>
</ol>
		</div>
		<div class="agreeScrBtm">
	<input type="checkbox" name="agreeYN1" id="agreeYN1" value="Y">
			<label for="agreeYN1">
				위 개인정보 수집 및 이용 내용에 동의합니다.</label>
		</div>
	</div>
	<div class="board_util_btn_con">
		<a href="javascript:void(0);" class="btn_style_0 close">취소</a>
		<button type="submit" class="btn_style_0 full check">동의</button>
	</div>
</form>