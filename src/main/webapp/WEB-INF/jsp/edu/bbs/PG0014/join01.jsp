
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<script type="text/javascript">
$(function() {
	$("#nextBtn").click(function() {
		if($(":input:radio[name=agreeYN2]:checked").val() != 'Y'){
				alert("온라인 콘텐츠 사용에 관한 이용에 동의해 주시기 바랍니다.");
				$('input:radio[name=agreeYN2]').first().focus();
				return false;
		}

		if($(":input:radio[name=agreeYN1]:checked").val() != 'Y'){
			alert("개인정보 수집 및 이용 동의사항에 동의해 주시기 바랍니다.");
			$('input:radio[name=agreeYN1]').first().focus();
			return false;
		}

		if (confirm("다음 단계로 이동하시겠습니까?")) {
				window.location.href = "/${paramVO.siteName}/bbs/B0000036/join02.do?menuNo=<c:out value="${param.menuNo}" />";
		}
		return false;
	});

	$("#cancelBtn").click(function() {
		if (confirm("‘단체수강신청을 취소하시겠습니까?")) {
			window.history.back();
		}
		return false;
	});


});




</script>
    <!-- Step1 Agree -->

						<div class="signup_step_bar">
							<div class="step_wrap active">
								<p class="step_box">
									<span class="step_title">
										STEP1
									</span>
									개인정보 동의
								</p>
							</div>
							<div class="step_line_wrap">
								<div class="step_right_arrow"></div>
							</div>
							<div class="step_wrap">
								<p class="step_box">
									<span class="step_title">
										STEP2
									</span>
									신청 정보 입력
								</p>
							</div>
							<div class="step_line_wrap">
								<div class="step_right_arrow"></div>
							</div>
							<div class="step_wrap">
								<p class="step_box">
									<span class="step_title">
										STEP3
									</span>
									입력내용 확인
								</p>
							</div>
							<div class="step_line_wrap">
								<div class="step_right_arrow"></div>
							</div>
							<div class="step_wrap">
								<p class="step_box">
									<span class="step_title">
										STEP4
									</span>
									신청완료
								</p>
							</div>
						</div>

						<form name="agreeForm" id="agreeForm" action="/${paramVO.siteName}/bbs/B0000036/join02.do" method="post" onsubmit="return checkForm(this);">
						<input type="hidden" value="${paramVO.menuNo }" name="menuNo">
							<div class="mb25">
								<h3>온라인 콘텐츠 사용에 관한 이용 약관</h3>
								<div tabindex="0" class="agreeScr">

<h3>제 1조 (목적)</h3>
<p class="m1">이 약관은 온라인 교육용 콘텐츠(이하"콘텐츠")를 제공받기 위한 업무협조, 온라인교육 서비스, 사이버연수원 운영에 관한 제반사항과 양 당사자의 권리와 의무를 명확히 규정함을 목적으로 합니다.</p>

<h3>제 2조 (공동사업인식)</h3>
<ul class="m1">
  <li>①  "위탁기관"과 "수탁기관"은 본 약관에 의하여 제공되는 온라인 교육 서비스가 공동사업임을 인식하고 신뢰와 성실로써 상호 협조합니다.</li>
  <li>②  약관의 적용 및 기타사항에 관하여"위탁기관"과"수탁기관"은 각자 업무영역의 고유성과 특수성을 상호 존중하기로 합니다.</li>
</ul>

<h3>제 3조 (용어의 정의)</h3>
<ul class="m1">
  <li>① "이용약관" 이라 함은 "수탁기관"이 "위탁기관"에게 제공하는 "콘텐츠"의 사용 및 운영에 관한 전반적인 사항을  말합니다.</li>
  <li>② "수탁기관"이라 함은 교육운영 서비스를 제공하는 기관을 말합니다.</li>
  <li>③ "위탁기관"이라 함은 임직원의 교육을 수탁기관에 위탁하는 기관을 말합니다.</li>
  <li>④ "학습자"라 함은 "콘텐츠"를 수강하는 자를 말합니다.</li>
  <li>⑤ "온라인 교육서비스"라 함은(이하 "교육서비스") "위탁기관"에게 제공된 "수탁기관"의 사이버 교육운영 시스템을 통하여 운영되는 모든 서비스를 말합니다.</li>
  <li>⑥ "사이버연수원"이라 함은(이하 "연수원") "수탁기관"이 "위탁기관"에게 제공하는 온라인교육 전용연수원을 말합니다.</li>
</ul>

<h3>제 4조 (지적재산권)</h3>
<ul class="m1">
  <li>①  "수탁기관"이"위탁기관"에게 제공한"콘텐츠"의 저작권은 "수탁기관"에게 있으며, "위탁기관"은 이용기간 동안"콘텐츠"에 대한 사용권을 가집니다.</li>
  <li>②  "수탁기관"은 "위탁기관"에게 제공하는 "콘텐츠"가 제 3자의 지적재산권을 침해하지 않음을 보증하여야 합니다.</li>
  <li>③  "위탁기관"에게 본 서비스의 "콘텐츠"로 인해 지적재산권 분쟁이 발생하였을 때에는 "수탁기관"은 자신의 책임과 비용부담으로 그 분쟁을 해결하여야 합니다.</li>
</ul>

<h3>제 5조 (사이버연수원 제공)</h3>
<ul class="m1">
  <li>①   "수탁기관"은 "위탁기관"에게 콘텐츠를 제공하고 학습을 원활하게 진행하게 하기 위해서 별도의 "사이버연수원"을"위탁기관"에게 제공합니다.</li>
  <li>②   "위탁기관"은 제공받은 "연수원"의 원활한 사용을 위하여 월 최소 기본 교육인원을 모집하여야 합니다.</li>
</ul>

<h3>제 6조 ("교육서비스"개시 및 종료)</h3>
<ul class="m1">
  <li>①  "교육서비스"의 개시는 수강신청 접수를 받은 날로 하고"교육서비스"의 종료는 "학습자"에 대한 평가 및 수료 처리가 완료된 날로 합니다.</li>
</ul>

<h3>제 7조 (수집하는 개인정보의 항목)</h3>
<ul class="m1">
  <li>① "수탁기관"은 원활한 고객 상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 개인정보를 수집하고 있습니다.
    <ul class="m1">
      <li>- 성명, 아이디, 비밀번호, 연락처(전화번호, 휴대폰번호 중 택일), 이메일, 성별, 생년월일</li>
    </ul>
  </li>
</ul>

<h3>제 8조(개인정보의 수집 · 이용목적)</h3>
① "수탁기관"은"위탁기관"의 회원에게 교육진행 안내 및 고지사항 전달이 목적이며, 회원의 서비스 이용 행동에 관한 분석과 수강이력에 대한 통계를 위하여 개인정보를 이용합니다.

<h3>제 9조(개인정보의 보유 · 이용기간)</h3>
<ul class="m1">
  <li>① "수탁기관"은 정보주체로부터 수집 시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다. 개인정보 처리 및 보유 기간은 다음과 같습니다.
     <ul class="m1">
         <li>1. "위탁기관"의 회원 정보 탈퇴 요청 시까지 또는 "위탁기관"과의 교육 서비스 해지 시<br />
              다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시까지
             <ul class="m1">
               <li>- 관계 법령 위반에 따른 수사·조사 등이 진행 중인 경우에는 해당 수사·조사 종료 시까지</li>
               <li>- 홈페이지 이용에 따른 채권·채무관계 잔존 시에는 해당 채권·채무관계 정산 시까지</li>
             </ul>
         </li>
      </ul>
    </li>
</ul>

<h3>제 10조(개인정보의 파기)</h3>
<ul class="m1">
  <li>① "수탁기관"은 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요 하 게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.</li>
  <li>② "위탁기관"으로부터 받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보(또는 개인정보파일)을 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다. 개인정보 파기의 절차 및 방법은 다음과 같습니다.
  <ul class="m1">
    <li>1. 파기절차
      <ul class="m1">
        <li>- 정보주체가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.</li>
      </ul>
    </li>
    <li>2. 파기기한
      <ul class="m1">
        <li>- 정보주체의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 15일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 서비스의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 30일 이내에 그 개인정보를 파기합니다.</li>
      </ul>
    </li>
    <li>3. 파기방법
      <ul class="m1">
        <li>- 개인정보가 기록된 출력물은 분쇄하거나 소각합니다. 전자적 파일 형태로 저장 된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.</li>
      </ul>
    </li>
  </ul>
  </li>
</ul>

<h3>제 11조 (서비스해지)</h3>
<ul class="m1">
  <li>① "수탁기관"과 "위탁기관"은 어느 일방에 의해 서명해지 통보가 없는 한 서비스가 지속되며, 다음 각 호의 사유가 발생한 경우에는 서비스 기간 중이라도 서면으로 본 서비스를 해지할 수 있습니다.(단, 최종 교육 종료일이 현재 기준으로 1년 이상 경과된 경우 서면 통보 후 서비스 해지 가능)
    <ul class="m1">
      <li>1. 본 약관의 협조 내지 준수사항, 의무이행 등을 현저히 태만하거나 지연하여 상대방의 업무활동에 지장을 초래한 경우</li>
      <li>2. "수탁기관" 또는 "위탁기관"의 주요재산에 강제집행이 개시되거나 부도처리, 화의·회사정리·파산 등의 개시 신청으로 더 이상의 서비스 유지가 곤란 할 경우</li>
      <li>3. 일방의 고의 또는 과실로 인하여 상대방에게 본 서비스를 유지하기 어려운 손해가 발생한 경우</li>
      <li>4. 일방이 본 약관을 위반하고 그 시정을 요구하는 상대방의 통지를 받은 날로부터 1주일 이내에 해당 위반사항을 시정하지 않는 경우</li>
      <li>5. 기타 본 서비스를 수행하기 어려운 중대한 사유가 발생한 경우</li>
    </ul>
  </li>
  <li>② 본 조 제1항의 해지사유로 인해 해지 당사자에게 손해가 발생한 경우에는 해지의 상대방은 발생한 모든 손해액을 배상할 책임이 있습니다.</li>
  <li>③ 서비스 해지 시 "위탁기관"은"수탁기관"과의 합의 없이 "수탁기관"의"콘텐츠"를 어떠한 목적으로도 사용할 수 없습니다.</li>
  <li>④ "위탁기관"의 회원정보는"수탁기관"의 제 9조 항목에 의해 개인정보를 파기합니다.</li>
  <li>⑤ 제 5조 ②항의 내용에도 불구하고 최소 기본 교육인원이 미달될 경우 "수탁기관"과 "위탁기관"간의 협의를 통해서 "연수원"의 운영에 대해서 서비스 해지를 협의할 수 있습니다.</li>
</ul>

<h3>제 12조 (의무)</h3>
<ul class="m1">
  <li>①   "위탁기관"과 "수탁기관"은 타인의 명예나 권리, 사회윤리 및 공공의 안녕과 질서를 침해하는 내용의 정보를 제공해서는 아니 되며, 이 경우 책임 소재에 따라 귀책 사유가 있는 측이 발생되는 분쟁 및 문제해결에 대해 전적인 책임을 집니다.</li>
  <li>② "수탁기관"의 의무는 다음과 같습니다.
  <ul class="m1">
    <li>- 교육운영시스템 및 네트워크 등 원격교육서비스 환경 구축</li>
    <li>- 과정운영 및 고객 불만 접수/처리</li>
  </ul>
  </li>
  <li>③ "위탁기관"의 의무는 다음과 같습니다.
  <ul class="m1">
    <li>- 매월 수강자 모집 및 관리</li>
    <li>- "연수원" 유지를 위한 최소 운영인원 관리</li>
    <li>- "위탁기관"의 귀책 사유로 발생하는 학습 장애요소에 대한 신속한 조치</li>
  </ul>
  </li>
</ul>

<h3>제 13조 (비밀유지)</h3>
<ul class="m1">
  <li>①   "위탁기관"과"수탁기관"은 본 서비스의 체결과 이행 과정에서 알게 된 상대방 및 상대방의 임직원과 고객에 관한 일체의 정보에 대하여 제3자에게 누설하거나 유출하여서는 아니 되며, 이를 위반하여 발생하는 모든 손해는 그 위반 당사자가 민·형사상의 책임을 집니다.</li>
  <li>②   본 조는 서비스 만료 또는 해지된 경우에도 계속하여 유효합니다.</li>
</ul>

<h3>제 14조 (손해배상)</h3>
<p class="m1">"위탁기관"과"수탁기관"은 본 서비스의 이행 중 자신의 귀책사유에 의하여 상대방에게 손해를 입힌 경우 그 손해 일체(변호사비용 기타 일체의 부대비용위탁기관 포함한다)를 배상하여야 합니다.</p>

<h3>제 15조 (신의성실)</h3>
<p class="m1">"위탁기관"과 "수탁기관"은 본 약관 내용을 신의성실의 원칙에 입각하여 수행함으로써 상호간의 신용과 명예를 실추시키는 일이 없도록 해야 합니다.</p>

<h3>제 16조 (관할법원)</h3>
<p class="m1">본 약관과 관련하여 법적 분쟁해결 절차를 밝고자 하는 경우 "수탁기관"의 본점소재지를 관할하는 법원을 합의관할법원으로 합니다.</p>


								</div>
								<div class="agreeScrBtm">
									위 온라인 콘텐츠 사용에 관한 이용 약관 내용에 동의합니다.
									<span class="show">
										<span class="radio_box_con short">
											<input type="radio" name="agreeYN2" id="agreeYN2_1" value="Y" class="radio_style_0">
											<label for="agreeYN2_1">예</label>
										</span>
										<span class="radio_box_con short">
											<input type="radio" name="agreeYN2" id="agreeYN2_2" value="N" class="radio_style_0">
											<label for="agreeYN2_2">아니오</label>
										</span>
									</span>
								</div>
							</div>





							<div>
								<h3>개인정보 수집 및 이용 동의 사항</h3>
								<div tabindex="0" class="agreeScr">
<ol>
	<li>1. 개인정보의 수집 · 이용 목적
		<ul class="bull">
			<li>단체 수강을 위한 이용자 정보 수집</li>
		</ul>
	</li>
	<li>2. 수집하는 개인정보의 항목
		<ul class="bull">
			<li>필수항목 : 단체명, 주소, 담당자(성명, 유선전화, 휴대폰번호, 이메일, 부서/직급)</li>
			<li>선택항목 : 없음</li>
		</ul>
	</li>
	<li>3. 개인정보의 보유 및 이용기간
	<ul class="bull">
		<li><strong style="text-decoration:underline; color: rgb(60, 48, 156); font-size: 130%;">수집 후 3년간 정보를 보관</strong></li>
	</ul>
	<li>4.  동의 거부 시 불이익에 관한 사항 : 수집ㆍ이용에 관한 사항의 동의를 거부할 때에는 서비스의 이용이 제한됩니다.   단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.</li>
</ol>


								</div>
								<div class="agreeScrBtm">
									위 개인정보 수집 및 이용 동의 사항 내용에 동의합니다.
									<span class="show">
										<span class="radio_box_con short">
											<input type="radio" name="agreeYN1" id="agreeYN1_1" value="Y" class="radio_style_0">
											<label for="agreeYN1_1">예</label>
										</span>
										<span class="radio_box_con short">
											<input type="radio" name="agreeYN1" id="agreeYN1_2" value="N" class="radio_style_0">
											<label for="agreeYN1_2">아니오</label>
										</span>
									</span>
								</div>
							</div>
						<div class="mt25 board_util_btn_con">
							<button type="button" id="nextBtn"  class="btn_style_0 right full">다음</button>
							<a href="javascript:void(0);" id="cancelBtn" class="btn_style_0 close">취소</a>
						</div>

						</form>


					<!-- //Step1 Agree -->
