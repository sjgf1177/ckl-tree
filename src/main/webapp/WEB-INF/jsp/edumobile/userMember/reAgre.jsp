<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="mode" value="${param.mode }" scope="session" />
<script type="text/javascript">
//<![CDATA[

$(function() {
	var mode = "<c:out value='${param.mode}'/>";

	reAgre = function() {
		var emailAt = $(':radio[name="emailAt"]:checked').val();
		var smsAt = $(':radio[name="smsAt"]:checked').val();

	if (mode == "i") {
		if (!emailAt) {
			alert("Email 수신여부를 선택해 주세요.");
			$("#emailAt1").focus();
			return;
		}
		if (!smsAt) {
			alert("SMS 수신여부를 선택해 주세요.");
			$("#smsAt1").focus();
			return;
		}
	}

		if (!confirm("재동의 하시겠습니까?")) {
			return;
		}
		$.post(
			"/edumobile/userMember/reAgreRequest.json",
			{userSn : "<c:out value='${user.userIdx}'/>", emailAt : emailAt, smsAt : smsAt, mode : mode},
			function(data) {
				if (data.resultCode == "success") {
					alert("재동의 되었습니다. 다시 로그인해주세요.");
					//location.href = "/edu/main/main.do";
					logoutSSO();
				}
			},"json"
		);
	};

});

//]]>
</script>

<c:choose>
	<c:when test="${user.agreAt eq 'N'}">
		<h2 class="fs5 tac">한국콘텐츠아카데미의 개인정보 취급방침이 개정되었습니다.</h2>
		<div class="boxGray  mt20 mb20 pt10 pb10">
			<p class="tac">
				한국콘텐츠아카데미의 개인정보 취급방침 개정으로 인하여 개인정보처리방침에 대한 재동의를 받고 있습니다.
			 </p>
			<p class="tac">
				아래의 개인정보처리방침을 읽어보시고 <strong class="fs4">“재동의”</strong> 또는 <strong class="fs4">“서비스 탈퇴”</strong>를 해주시기 바랍니다.
			</p>
			<p class="tac">
				<strong class="fs4">“정보수신 여부”</strong> 에 대한 추가 동의를 받고 있습니다. 아래의 정보수신 여부에 대해서 동의해 주시기 바랍니다.
			</p>
		</div>
	</c:when>
	<c:otherwise>
		<h2 class="fs5 tac">회원님은 <strong class="fcBlack">“<c:out value='${user.agreDt}'/>”</strong>에 개인정보처리방침에 대한 동의를 하셨습니다.</h2>
		<div class="boxGray  mt40 mb40 pt30 pb30">
			<p class="tac">
				동의한지 3년이 지난 회원에 대해서 개인정보처리방침에 대한 재동의가 필요합니다.
			 </p>
			<p class="tac">
				아래의 개인정보처리방침을 읽어보시고 <strong class="fs4">“재동의”</strong> 또는 <strong class="fs4">“서비스 탈퇴”</strong>를 해주시기 바랍니다.
			</p>
		</div>
	</c:otherwise>
</c:choose>


<div class="msgBx">

	<div>
		<h3><strong>개인정보처리방침</strong></h3>
		<div tabindex="0" class="agreeScr">


<div class="jf">
	<h5>한국콘텐츠진흥원(한국콘텐츠아카데미) 개인정보처리방침 (2018-10-01 시행)</h5>
	<p class="h_desc5">
		한국콘텐츠진흥원 한국콘텐츠아카데미(<a href="https://edu.kocca.kr">'한국콘텐츠아카데미'</a> 라 칭함)은 개인정보보호법에 따라
		정보주체의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 정보주체의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.
	</p>
	<br>
	<ul class="list_style_3">
		<li>1) 개인정보의 처리 목적</li>
	</ul>
	<p class="list_style_3_desc">
	한국콘텐츠아카데미는 수집한 개인정보를 다음의 목적을 위해 활용되며, 이용 목적이 변경될 시에는 사전 동의를 구할 예정입니다.
	</p>
	<ul class="list_style_4">
		<li>
			회원가입
			<div class="list_style_4_desc">
				회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별 · 인증, 회원자격 유지 · 관리, 제한적 본인확인제 시행에 따른 본인확인,
				서비스 부정이용 방지, 각종 고지 · 통지, 고충처리 등을 목적으로 개인정보를 처리합니다.
			</div>
		</li>
		<li>
			문의하기 등 민원사무 처리
			<div class="list_style_4_desc">
				개인정보 열람, 개인정보 정정 · 삭제, 개인정보 처리정지 요구, 개인정보 유출사고 신고, 개인정보 침해 사실 신고 접수 ·
				처리 등 민원처리를 목적으로 개인정보를 처리합니다.
			</div>
		</li>
		<li>
			서비스 제공
			<div class="list_style_4_desc">
				시설예약, 온라인 신청 등과 관련한 목적으로 개인정보를 처리합니다.
			</div>
		</li>
		<li>
			마케팅 및 광고에 활용
			<div class="list_style_4_desc">
				행사정보 및 홍보목적으로 개인정보를 처리합니다.
			</div>
		</li>
	</ul>
	<ul class="list_style_3">
		<li>2) 개인정보 수집항목 및 수집방법, 개인정보 보유 및 이용기간</li>
	</ul>
	<p class="list_style_3_desc">
	한국콘텐츠아카데미는 개인정보보호법 제32조에 따라 등록 · 공개하는 개인정보파일의 수집항목은 다음과 같습니다. 
	</p>
	<table class="table_style_1" summary="personal data referral">
		<caption>개인정보 수집항목 및 보유기간</caption>
		<colgroup>
			<col width="20%">
			<col width="auto">
			<col width="17%">
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>수집항목</th>
				<th>보유기간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>개인 회원명부</td>
				<td style="text-align:left; padding-left:10px;">· 필수항목 : 이름, 생년월일, 성별, 아이디, 비밀번호, 이메일, 휴대폰, <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					인재캠퍼스 정보수신 여부,	콘텐츠문화광장 정보수신 여부, 직업, <br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					거주지역-국내·해외, 거주지역-시도·군구, 소속,<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					14세 미만인 경우 보호자의 이름, 휴대폰 번호<br>
					· 선택항목 : 거주지</td>
				<td>3년</td>
			</tr>
			<tr>
				<td>기업 회원명부</td>
				<td style="text-align:left; padding-left:10px;">
					· 필수항목 : 성명(한글), 생년월일, 성별, 아이디, 비밀번호, 전화번호, 휴대폰, 이메일
					<br>
					· 선택항목 : 소속부서, 정보수신 여부
				</td>
				<td>3년</td>
			</tr>
			<tr>
				<td>온라인교육<br>수강정보</td>
				<td style="text-align:left; padding-left:10px;">
					· 필수항목 : 아이디, 성명, 휴대폰, 이메일, 수강과목정보
					<br>
					· 선택항목 : 없음
				</td>
				<td>3년</td>
			</tr>
			<tr>
				<td>문의하기</td>
				<td style="text-align:left; padding-left:10px;">
					· 필수항목 : 아이디, 성명, 휴대폰, 이메일
					<br>
					· 선택항목 : 없음
				</td>
				<td>3년</td>
			</tr>
			<tr>
				<td>오프라인교육<br>신청</td>
				<td style="text-align:left; padding-left:10px;">
					· 필수항목 : 아이디, 이름, 생년월일, 성별, 이메일, 자택 전화번호, 휴대폰번호, 회사 전화번호, 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					주소, 거주지역, 직업, 소속
					<br>
					· 선택항목 : 전문분야, 직위, 경력, 학력 등 교육프로그램에 따라 다르며 정보주체로부터
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 별도의 동의를 얻어 수집 및 처리
				</td>
				<td>3년</td>
			</tr>
			<tr>
				<td>시설예약<br>신청</td>
				<td style="text-align:left; padding-left:10px;">
					· 필수항목 : 이름, 휴대폰, 이메일, 사용인원, 사용목적, 예약정보수신방법
					<br>
					· 선택항목 : 시설예약신청에 따라 다르며 정보주체로부터 별도의 동의를 얻어 수집 및 처리
				</td>
				<td>3년</td>
			</tr>
		</tbody>
	</table>
	<ul class="list_style_4">
			<li>
				개인정보 수집방법
				<div class="list_style_4_desc">
					<ul class="list_style_5">
						<li>한국콘텐츠아카데미 홈페이지(회원가입, 문의하기, 시설예약, 온라인 신청)에서 정보주체의 동의를 얻어 수집합니다.</li>
						<li>강사, 튜터, 멘토, 멘티 등과 같은 경우 별도 오프라인으로 정보주제의 동의를 얻어 수집합니다.</li>
					</ul>
				</div>
				<div class="list_style_4_caption">
				홈페이지 회원은 한국콘텐츠진흥원에서 운영하는 "<a href="http://www.ckl.or.kr" target="_blank" title="새창열림">콘텐츠코리아랩-www.ckl.or.kr</a>" 와 통합으로 관리됩니다.
				</div>
			</li>
			<li>
				인터넷 서비스 이용과정에서 이용자의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'가 자동으로 생성되어 수집될 수 있습니다.
				<div class="list_style_4_desc">
					<ul class="list_style_5">
						<li>회사의 쿠키 사용 목적 : 이용자가 방문한 사이트의 방문기록, 이용형태, 규모 등을 파악하여 최적화된 서비스를 제공하고자 <br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						사용합니다. </li>
						<li>쿠키(cookie) 자동수집 거부 : 이용자는 쿠키 수집에 대해 선택할 수 있으며, 웹브라우저의 옵션을 설정함으로써 간단히 거부할<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						수 있습니다. </li>
						<ul style="font-size:12px;margin-top:10px;padding-left:10px;">
							<li>쿠키 수집 지정방법</li>
							<ul style="padding-left:10px;">
								<li>1) [도구] 메뉴에서 [인터넷 옵션]을 선택합니다.</li>
								<li>2) [개인정보 탭]을 클릭합니다.</li>
								<li>3) [개인정보취급 수준]을 설정하시면 됩니다.</li>
							</ul>
						</ul>
					</ul>
				</div>
			</li>
		</ul>

<ul class="list_style_3">
		<li>3) 개인정보의 처리</li>
	</ul>
	<p class="list_style_3_desc">
		정보주체의 개인정보의 처리 및 보유 기간이 경과하거나 수집 및 처리목적이 달성되면 지체 없이 파기합니다.
	</p>
	<ul class="list_style_3">
		<li>4) 개인정보의 제3자 공유 및 제공</li>
	</ul>
	<p class="list_style_3_desc">
		한국콘텐츠아카데미는 정보주체의 동의 없이는 수집ㆍ보유하고 있는 개인정보를 제3자에게 제공하지 않습니다. <br>
		다만, 「개인정보보호법」 제17조 제1항 및 제18조 제2항에 해당하는 경우로서 불가피한 경우에는 정보주체의 동의 없이 개인정보를 제3자에게 제공 할 수 있습니다. 
	</p>	
	<ul class="list_style_3">
		<li>5) 개인정보처리의 위탁</li>
	</ul>
	<p class="list_style_3_desc">
	한국콘텐츠아카데미는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.
	</p>
	<table class="table_style_1" summary="personal data referral">
		<caption>개인정보처리의 위탁</caption>
		<colgroup>
			<col width="20%">
			<col width="auto">
			<col width="17%">
		</colgroup>
		<thead>
			<tr>
				<th>수탁업체</th>
				<th>위탁업무내용</th>
				<th>보유 및 이용기간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>(주) 케이브레인컴퍼니</td>
				<td>홈페이지 회원 및 튜터, 강사관리, 웹사이트 운영, 불만처리 등 민원처리, 고지사항 전달</td>
				<td>위탁계약 종료 시까지</td>
			</tr>
		</tbody>
	</table>
	<ul class="list_style_3">
		<li>6) 개인정보의 파기절차 및 방법</li>
	</ul>
	<p class="list_style_3_desc">
		한국콘텐츠아카데미는 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다.
		파기의 절차, 기한 및 방법은 다음과 같습니다.
	</p>
	<ul class="list_style_4">
		<li>
			파기절차
			<div class="list_style_4_desc">
				정보주체가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.
			</div>
		</li>
		<li>
			파기기한
			<div class="list_style_4_desc">
				정보주체의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성,
				해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터
				5일 이내에 그 개인정보를 파기합니다.
			</div>
		</li>
		<li>
			파기방법
			<div class="list_style_4_desc">
				개인정보가 기록된 출력물은 분쇄하거나 소각합니다. 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.
			</div>
		</li>
	</ul>
<ul class="list_style_3">
		<li>7) 정보주체의 권리, 의무 및 그 행사방법</li>
	</ul>
	<p class="list_style_3_desc">
		한국콘텐츠아카데미의 정보주체는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.
	</p>
	<ul class="list_style_4 color_gray">
		<li>
			정보주체는 한국콘텐츠아카데미에 대해 언제든지 다음 각 호의 개인정보 보호관련 권리를 행사할 수 있습니다.
			<div class="list_style_4_desc">
				<ul class="list_style_5">
					<li>개인정보 열람요구</li>
					<li>오류 등이 있을 경우 정정요구</li>
					<li>삭제요구</li>
					<li>처리정지요구</li>
				</ul>
			</div>
		</li>
		<li>
			제1항에 따른 권리 행사는 한국콘텐츠아카데미에 대해 개인정보 보호법 시행규칙 별지 제8호 서식에 따라 서면,
			전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 한국콘텐츠아카데미는 이에 대해 지체 없이 조치하겠습니다.
		</li>
		<li>
			정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 한국콘텐츠아카데미는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.
		</li>
		<li>
			제1항에 따른 권리 행사는 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 한국콘텐츠아카데미는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.
		</li>
		<li>
			기타('한국콘텐츠아카데미‘)의 개인정보파일 등록사항 공개는 행정안전부 개인정보보호 종합지원 포털(<a href="http://www.privacy.go.kr" target="_blank" title="새창열림">www.privacy.go.kr</a>)
			<span class="list_style_4_arrow"></span>
			개인정보민원
			<span class="list_style_4_arrow"></span>
			개인정보열람 등 요구
			<span class="list_style_4_arrow"></span>
			개인정보파일 목록검색 메뉴를 활용 해주시기 바랍니다.
		</li>
	</ul>
	<ul class="list_style_3">
		<li>8) 정보주체 및 법정대리인의 권리와 그 행사방법</li>
	</ul>
	<p class="list_style_3_desc">
		정보주체 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며, 
		한국콘텐츠아카데미의 개인정보의 처리에 동의하지 않는 경우 동의를 거부하거나 가입 · 해지(회원탈퇴)를 요청하실 수 있습니다. 
		다만, 그러한 경우 서비스의 일부 또는 전부 이용이 어려울 수 있습니다. 
	</p>
	<ul class="list_style_4 color_gray">
		<li>
			정보주체 혹은 만 14세 미만 아동의 개인정보 조회, 수정을 위해서는 '개인정보변경'(또는 '회원정보수정' 등)을, 
			가입 · 해지(동의철회)를 위해서는 "회원탈퇴"를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다
		</li>
		<li>
			혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다. 
		</li>
	</ul>
	<ul class="list_style_3">
		<li>9) 개인정보관련 기술적ㆍ관리적ㆍ물리적 대책</li>
	</ul>
	<p class="list_style_3_desc">
		한국콘텐츠아카데미는 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.
	</p>
	<ul class="list_style_4">
		<li>
			개인정보 취급 직원의 최소화
			<div class="list_style_4_desc">
				개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.
			</div>
		</li>
		<li>
			정기적인 자체 감사 실시
			<div class="list_style_4_desc">
				개인정보 취급 관련 안정성 확보를 위해 정기적(연 2회)으로 자체 감사를 실시하고 있습니다.
			</div>
		</li>
		<li>
			내부관리계획의 수립 및 시행
			<div class="list_style_4_desc">
				개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.
			</div>
		</li>
		<li>
			개인정보의 암호화
			<div class="list_style_4_desc">
			정보주체의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는
			파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.
			</div>
		</li>
		<li>
			해킹 등에 대비한 기술적 대책
			<div class="list_style_4_desc">
			한국콘텐츠아카데미는 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인
			갱신 · 점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.
			</div>
		</li>
		<li>
			개인정보에 대한 접근 제한
			<div class="list_style_4_desc">
			개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위하여
			필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
			</div>
			</li>
		<li>
			문서보안을 위한 잠금장치 사용
			<div class="list_style_4_desc">
			개인정보가 포함된 서류, 보조저장매체 등을 잠금장치가 있는 안전한 장소에 보관하고 있습니다.
			</div>
			</li>
		<li>
			비인가자에 대한 출입 통제
			<div class="list_style_4_desc">
			개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.
			</div>
		</li>
	</ul>
	<ul class="list_style_3">
		<li>10) 개인정보 보호책임자 및 권익침해 구제방법</li>
	</ul>
	<p class="list_style_3_desc">
		한국콘텐츠아카데미는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 
		개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 
		아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
	</p>
	<ul class="list_style_4">
		<li>개인정보 보호</li>
		<table class="table_style_1" summary="personal data referral">
			<caption>개인정보보호 책임자</caption>
			<thead>
				<tr>
					<th>구분</th>
					<th>소속</th>
					<th>성명</th>
					<th>연락처</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>개인정보보호책임자</td>
					<td>산업부원장</td>
					<td>김영덕</td>
					<td>061-900-6300<br>privacy@kocca.kr</td>
				</tr>
				<tr>
					<td>기관 개인정보보호 담당자</td>
					<td>정보화사업팀</td>
					<td>김은우</td>
					<td>061-900-9123<br>sans@kocca.kr</td>
				</tr>
			</tbody>
		</table>
		<li>
			권익침해 구제방법
			<div class="list_style_4_desc">
				정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을 문의하실 수 있습니다.
				(아래의 기관은 진흥원과는 별개의 기관으로서, 진흥원의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다)
				<ul class="list_style_5">
					<li>개인정보 분쟁조정위원회 : (국번없이)118 (privacy.kisa.or.kr)</li>
					<li>개인정보 침해신고센터 : (국번없이)118 (privacy.kisa.or.kr)</li>
					<li>대검찰청 사이버범죄수사단 : 02-3480-3571 (cybercid@spo.go.kr)</li>
					<li>경찰청 사이버안전국 : (국번없이)182 (cyberbureau.police.go.kr)</li>
				</ul>
			</div>
		</li>
	</ul>
	<ul class="list_style_3">
		<li>11) 사업 담당자 안내</li>
	</ul>
	<ul class="list_style_4">
		<table class="table_style_1" summary="personal data referral">
			<caption>사업 담당자</caption>
			<thead>
				<tr>
					<th>구분</th>
					<th>소속</th>
					<th>성명</th>
					<th>연락처</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>홈페이지 운영·온라인교육 등</td>
					<td>인재양성팀</td>
					<td>이종순</td>
					<td>02-6310-0623</td>
				</tr>
				<tr>
					<td>콘텐츠인사이트·스탭업</td>
					<td>인재양성팀</td>
					<td>신영경</td>
					<td>02-6310-0663</td>
				</tr>
				<tr>
					<td>콘텐츠벨류업·창의체험스쿨</td>
					<td>인재양성팀</td>
					<td>안정권</td>
					<td>02-6310-0664</td>
				</tr>
				<tr>
					<td>게임리터러시</td>
					<td>게임문화팀</td>
					<td>구연진</td>
					<td>061-900-6321</td>
				</tr>
				<tr>
					<td>창의인재양성사업</td>
					<td>인재양성팀</td>
					<td>유윤옥</td>
					<td>02-6310-0661</td>
				</tr>
				<tr>
					<td>우수크리에이터양성사업</td>
					<td>인재양성팀</td>
					<td>박은정</td>
					<td>02-6310-0628</td>
				</tr>
				<tr>
					<td>콘텐츠인재캠퍼스</td>
					<td>인재양성팀</td>
					<td>하동열</td>
					<td>02-6310-0627</td>
				</tr>
				<tr>
					<td>콘텐츠문화광장</td>
					<td>인재양성팀</td>
					<td>송영훈</td>
					<td>02-6310-0626</td>
				</tr>
				<tr>
					<td>취업지원</td>
					<td>기업육성팀</td>
					<td>박병호</td>
					<td>02-6441-3032</td>
				</tr>
			</tbody>
		</table>
	</ul>
	<ul class="list_style_3">
		<li>12) 고지의무</li>
	</ul>
	<p class="list_style_3_desc">
		본 한국콘텐츠아카데미 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가,
		삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.
	</p>
	<ul class="list_style_5 line_long">
		<li>공고일자 : <span class="color_black">2018년 9월 21일</span></li>
		<li>
			시행일자 : <span class="color_black">2018년 10월 01일</span>
			<div class="list_style_5_caption">
				이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다.
			</div>
		</li>
		<li>
			2014년 5월 20일 이전 내용<a href="/files/EDUprivacy20140527pre.pdf" title="새창열림" target="_blank" class="prev_privacy_law_btn">보기</a>
		</li>
		<li>
			2016년 1월 22일 이전 내용<a href="/files/edu_20151221Privacy.pdf" title="새창열림" target="_blank" class="prev_privacy_law_btn">보기</a>
		</li>
		<li>
			2016년 4월 26일 이전 내용<a href="/files/edu_20160115Privacy.pdf" title="새창열림" target="_blank" class="prev_privacy_law_btn">보기</a>
		</li>
		<li>
			2018년 10월 1일 이전 내용<a href="/files/edu_20160426Privacy.pdf" title="새창열림" target="_blank" class="prev_privacy_law_btn">보기</a>
		</li>
	</ul></div> 



		</div>
	</div>



	<div style="margin-top: 30px;">
		<h3><strong>개인정보 수집 및 이용동의</strong></h3>
		<div tabindex="0" class="agreeScr" style="font-size: 1.2rem; line-height: 2.05rem;">
	                    
	                	한국 콘텐츠아카데미는 회원가입, 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 필수 정보와 선택정보를 수집합니다.
						<br><br>
						<strong style="color:#3C309C">개인정보보호를 위한 이용자 동의사항</strong>
						<br>
						1. 수집&middot;이용 목적 : 회원제 서비스 제공 및 고객 맞춤형 서비스 목적<br>
						<br>
						2. 개인정보 수집 항목<br>
						&nbsp;&nbsp;<strong style="color:#3C309C">[개인회원]</strong><br>
						&nbsp;&nbsp;&nbsp;&nbsp;필수항목 : 이름, 생년월일, 성별, 아이디, 비밀번호, 이메일, 휴대폰, 인재캠퍼스 정보수신 여부, 콘텐츠문화광장 정보수신 여부, 직업,<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;거주지역, 소속, 14세 미만인 경우 보호자의 이름, 휴대폰 번호<br>
						&nbsp;&nbsp;&nbsp;&nbsp;선택항목 : 거주지<br>
						&nbsp;&nbsp;<strong style="color:#3C309C">[기업회원]</strong><br>
						&nbsp;&nbsp;&nbsp;&nbsp;필수항목 : 성명, 생년월일, 성별, 아이디, 비밀번호, 전화번호, 휴대폰, 이메일, 정보수신 여부<br>
						&nbsp;&nbsp;&nbsp;&nbsp;선택항목 : 소속부서<br>
						&nbsp;&nbsp;<strong style="color:#3C309C">[온라인교육 수강정보]</strong><br>
						&nbsp;&nbsp;&nbsp;&nbsp;필수항목 : 아이디, 성명, 휴대폰, 이메일, 수강과목정보<br>
						&nbsp;&nbsp;<strong style="color:#3C309C">[문의하기]</strong><br>
						&nbsp;&nbsp;&nbsp;nbsp;필수항목 : 아이디, 성명, 휴대폰, 이메일<br>
						&nbsp;&nbsp;<strong style="color:#3C309C">[오프라인교육 신청]</strong><br>
						&nbsp;&nbsp;&nbsp;&nbsp;필수항목 : 아이디, 이름, 생년월일, 성별, 이메일, 자택 전화번호, 휴대폰번호, 회사 전화번호, 주소, 거주지역, 직업, 소속<br>
						&nbsp;&nbsp;&nbsp;&nbsp;선택항목 : 전문분야, 직위, 경력, 학력 등 교육프로그램에 따라 다르며 정보주체로부터 별도의 동의를 얻어 수집 및 처리합니다.<br>
						&nbsp;&nbsp;<strong style="color:#3C309C">[시설예약 신청]</strong><br>
						&nbsp;&nbsp;&nbsp;&nbsp;필수항목 : 이름, 휴대폰, 이메일, 사용인원, 사용목적, 예약정보수신방법<br>
						&nbsp;&nbsp;&nbsp;&nbsp;선택항목 : 시설예약신청에 따라 다르며 정보주체로부터 별도의 동의를 얻어 수집 및 처리합니다.<br>
						<br>
						<strong style="color:#3C309C; font-size:130%">3. 개인정보 보유 및 이용기간 : 3년 혹은 회원 탈퇴 후 즉시 삭제</strong><br>
						<br>
						4. 자동 수집 정보 : 인터넷 서비스 이용과정에서 아래의 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등
	                    <br><br>
	                    5. 동의 거부 시 불이익에 관한 사항 : 수집 &middot;이용에 관한 사항의 동의를 거부할 때에는  서비스의 이용이 제한됩니다. 단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.	
	                </div>
	</div>

<c:if test="${param.mode eq 'i'}">
	<br><br>
	<h3>정보수신 여부</h3>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>정보수신 여부</caption>
			<colgroup>
			<col style="width:20%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <strong>정보수신 여부</strong></th>
					<td>서비스 및 이벤트 소식을<br>
						<label for="emailAt1"><input type="radio" name="emailAt" value="Y" id="emailAt1" checked="checked"> Email로 수신하겠습니다. </label>
						<label for="emailAt2"><input type="radio" name="emailAt" value="N" id="emailAt2"> Email로 수신하지 않겠습니다. </label><br>
						<label for="smsAt1"><input type="radio" name="smsAt" value="Y" id="smsAt1" checked="checked"> SMS로 수신하겠습니다. </label>
						<label for="smsAt2"><input type="radio" name="smsAt" value="N" id="smsAt2"> SMS로 수신하지 않겠습니다. </label><br><br>
						<p class="text-default">※ 수신을 거부하셔도 “비밀번호 찾기” 등의 메일은 자동 발송됩니다.</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>

	<div class="btnSet">
		<a href="javascript:reAgre();" class="btn btn-primary">재동의</a>
		<!-- <a href="/edu/userMember/secsn.do?menuNo=500082" class="btn btn-danger">서비스 탈퇴</a> -->
	</div>
</div>

