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
			"/ckl/userMember/reAgreRequest.json",
			{userSn : "<c:out value='${user.userIdx}'/>", emailAt : emailAt, smsAt : smsAt, mode : mode},
			function(data) {
				if (data.resultCode == "success") {
					alert("재동의 되었습니다. 다시 로그인해주세요.");
					logoutSSO();
				}
			},"json"
		);
	};

});

//]]>
</script>

<c:choose>
	<c:when test="${param.mode eq 'i'}">
		<p class="fs5 tac">콘텐츠코리아랩 홈페이지와 에듀코카,창의드림 회원이 통합되었습니다.</p>
		<div class="boxGray  mt40 mb40 pt30 pb30">
			<p class="tac">
				콘텐츠코리아랩 홈페이지와 에듀코카 회원, 창의드림 홈페이지 회원의 통합으로 인하여 개인정보처리방침에 대한 재동의를 받고 있습니다.
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
		<p class="fs5 tac">회원님은 <strong class="fcBlack">“<c:out value='${user.agreDt}'/>”</strong>에 개인정보처리방침에 대한 동의를 하셨습니다.</p>
		<div class="boxGray  mt20 mb20 pt10 pb10">
			<p class="tac">
				동의한지 3년이 지난 회원에 대해서 개인정보처리방침에 대한 재동의가 필요합니다.
			 </p>
			<p class="tac">
				아래의 개인정보처리방침을 읽어보시고 <strong class="fs4">“재동의”</strong> 또는 <strong class="fs4">“서비스 탈퇴”</strong>를 해주시기 바랍니다.
			</p>
		</div>
	</c:otherwise>
</c:choose>



<!-- 개인정보 처리방침 -->

<div class="msgBx">
	<div>
		<h3>개인정보처리방침 (2015-12-21 시행)</h3>
		<div tabindex="0" class="agreeScr">




<p class="tac fs5">한국콘텐츠진흥원(콘텐츠코리아랩) 개인정보처리방침 (2015-12-21 시행)</p>
<div class="jf mt10">
<p>한국콘텐츠진흥원(&lsquo;www.ckl,or.kr - 콘텐츠코리아랩, 이하 &lsquo;콘텐츠코리아랩&rsquo; 이라 칭함)은 개인정보보호법에 따라 정보주체의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 정보주체의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.</p>
<h2>개인정보의 처리 목적</h2>
<div class="m1">콘텐츠코리아랩은 수집한 개인정보를 다음의 목적을 위해 활용되며, 이용 목적이 변경될 시에는 사전 동의를 구할 예정입니다.

<ul class="bull">
<li>회원가입<br />
회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별 &middot; 인증, 회원자격 유지 &middot; 관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 각종 고지 &middot; 통지, 고충처리 등을 목적으로 개인정보를 처리합니다.</li>
<li>문의하기 등 민원사무 처리<br />
개인정보 열람, 개인정보 정정 &middot; 삭제, 개인정보 처리정지 요구, 개인정보 유출사고 신고, 개인정보 침해 사실 신고 접수 &middot; 처리 등 민원처리를 목적으로 개인정보를 처리합니다.</li>
<li>서비스 제공<br />
시설예약, 온라인 신청 등과 관련한 목적으로 개인정보를 처리합니다.</li>
<li>마케팅 및 광고에 활용<br />
행사정보 및 홍보목적으로 개인정보를 처리합니다.</li>
</ul></div>
<h2>개인정보 수집항목 및 수집방법</h2>
<div class="m1">콘텐츠코리아랩은 개인정보보호법 제32조에 따라 등록 &middot; 공개하는 개인정보파일의 수집항목은 다음과 같습니다.

<ul class="bull">
<li>개인정보의 수집항목<dl><dt>[홈페이지 회원]</dt><dd>- 필수항목 : 아이디, 비밀번호, 이름, 생년월일, 성별, 이메일, 휴대폰, 정보수신여부</dd><dd>- 선택항목 : 거주지, 직업</dd><dt>[문의하기]</dt><dd>- 필수항목 : 작성자, 이메일, 연락처</dd><dd>- 선택항목 : 없음</dd><dt>[시설예약]</dt><dd>- 필수항목 : 이름, 휴대폰, 이메일, 나이, 직업, 거주지역, 사용인원, 사용목적, 예약정보수신방법</dd><dd>- 선택항목 : 사용목적상세</dd></dl></li>
<li> 개인정보 수집방법

<p>- 콘텐츠코리아랩 홈페이지(회원가입, 문의하기, 시설예약, 온라인 신청)에서 정보주체의 동의를 얻어 수집합니다.<br /></p></li>
</ul>※ 홈페이지 회원은 한국콘텐츠진흥원에서 운영하는 "에듀코카-edu.kocca.kr" 와 통합으로 관리됩니다.</div>
<h2>개인정보의 처리 및 보유기간</h2>
<div class="m1">
<p>정보주체의 개인정보 처리 및 보유 기간은 아래와 같습니다. 단, 개인정보의 처리 및 보유 기간이 경과하거나 수집 및 처리목적이 달성되면 지체 없이 파기합니다.</p>
<ul class="bull">
<li>홈페이지 회원

<ul>
<li>- 회원탈퇴 시</li>
<li>- 3년 이상 홈페이지에 접속이 없는 경우</li>
</ul> </li>
<li>문의하기, 시설예약, 온라인신청

<ul>
<li>- 접수(또는 이용) 후 3년</li>
</ul></li>
</ul></div>
<h2>개인정보의 제3자 공유 및 제공</h2>
<div class="m1">
<p>콘텐츠코리아랩은 정보주체의 동의 없이는 수집ㆍ보유하고 있는 개인정보를 제3자에게 제공하지 않습니다. 다만, 「개인정보보호법」 제17조 제1항 및 제18조 제2항에 해당하는 경우로서 불가피한 경우에는 정보주체의 동의 없이 개인정보를 제3자에게 제공 할 수 있습니다.</p></div>
<h2>개인정보처리의 위탁</h2>
<div class="m1">
<p>콘텐츠코리아랩은 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</p> 
<div class="bdList">
<table class="table mb10">
<caption>개인정보처리의 위탁</caption>
<colgroup>
<col style="width: 25%;" />
<col style="width: 50%;" />
<col style="width: 25%;" />
</colgroup>
<thead>
<tr>
<th scope="col" class="pe_qB">수탁업체</th>
<th scope="col" class="pe_qB">위탁업무내용</th>
<th scope="col" class="brn pe_qB">보유 및 이용기간</th>
</tr>
</thead>
<tbody>
<tr>
<td>
<p>(주)엑스퍼트컨설팅</p></td>
<td>
<p>홈페이지 회원 관리,웹사이트 운영, 불만처리 등 민원처리, 고지사항 전달</p></td>
<td>
<p>위탁계약 종료 시까지</p></td>
</tr>
</tbody>
</table></div>
<ul class="bull">
<li>콘텐츠코리아랩은 위탁계약 체결 시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적ㆍ관리적 보호조치, 재 위탁 제한, 수탁자에 대한 관리ㆍ감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.</li>
<li>위탁업무의 내용이나 수탁자가 변경될 경우에는 지체 없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.</li>
</ul></div>
<h2>개인정보의 파기절차 및 방법</h2>
<div class="m1">콘텐츠코리아랩은 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.

<ul class="bull">
<li>파기절차<br />
정보주체가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.</li>
<li>파기기한<br />
정보주체의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.</li>
<li>파기방법<br />
개인정보가 기록된 출력물은 분쇄하거나 소각합니다. 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.</li>
</ul></div>
<h2>정보주체의 권리, 의무 및 그 행사방법</h2>
<div class="m1">콘텐츠코리아랩의 정보주체는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.

<ul class="bull">
<li>정보주체는 콘텐츠코리아랩에 대해 언제든지 다음 각 호의 개인정보 보호관련 권리를 행사할 수 있습니다.

<ul>
<li>- 개인정보 열람요구</li>
<li>- 오류 등이 있을 경우 정정요구</li>
<li>- 삭제요구</li>
<li>- 처리정지요구</li>
</ul></li>
<li>제1항에 따른 권리 행사는 콘텐츠코리아랩에 대해 개인정보 보호법 시행규칙 별지 제8호 서식에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 콘텐츠코리아랩은 이에 대해 지체 없이 조치하겠습니다.</li>
<li>정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 콘텐츠코리아랩은 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
<li>제1항에 따른 권리 행사는 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 콘텐츠코리아랩은 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
<li>콘텐츠코리아랩이 보유하고 있는 국민 여러분의 개인정보를 관계법령에 따라 적법하고 적정하게 처리하여, 권익이 침해 받지 않도록 노력할 것입니다.</li>
<li>기타('콘텐츠코리아랩&lsquo;)의 개인정보파일 등록사항 공개는 행정안전부 개인정보보호 종합지원 포털(www.privacy.go.kr) &rarr; 개인정보민원 &rarr; 개인정보열람 등 요구 &rarr; 개인정보파일 목록검색 메뉴를 활용 해주시기 바랍니다.</li>
</ul></div>
<h2>정보주체 및 법정대리인의 권리와 그 행사방법</h2>
<div class="m1">▷ 정보주체 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며, 콘텐츠코리아랩의 개인정보의 처리에 동의하지 않는 경우 동의를 거부하거나 가입 &middot; 해지(회원탈퇴)를 요청하실 수 있습니다. 다만, 그러한 경우 서비스의 일부 또는 전부 이용이 어려울 수 있습니다. 

<ul class="bull">
<li>정보주체 혹은 만 14세 미만 아동의 개인정보 조회, 수정을 위해서는 '개인정보변경'(또는 '회원정보수정' 등)을, 가입 &middot; 해지(동의철회)를 위해서는 "회원탈퇴"를 클릭하여 본인 확인 절차를 거치신 후 직접 열람, 정정 또는 탈퇴가 가능합니다.</li>
<li>혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다.</li>
</ul></div>
<h2>개인정보관련 기술적ㆍ관리적ㆍ물리적 대책</h2>
<div class="m1">콘텐츠코리아랩은 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.

<ul class="bull">
<li>개인정보 취급 직원의 최소화<br />
개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.</li>
<li>정기적인 자체 감사 실시<br />
개인정보 취급 관련 안정성 확보를 위해 정기적(연 2회)으로 자체 감사를 실시하고 있습니다.</li>
<li>내부관리계획의 수립 및 시행<br />
개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.</li>
<li>개인정보의 암호화<br />
정보주체의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 
사용하는 등의 별도 보안기능을 사용하고 있습니다.</li>
<li>해킹 등에 대비한 기술적 대책<br />
콘텐츠코리아랩은 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신 &middot; 점검을 하며 외부로부터 접근이 통제된
 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.</li>
<li>개인정보에 대한 접근 제한<br />
개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여, 변경, 말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 
이용하여 외부로부터의 무단 접근을 통제하고 있습니다.</li>
<li>문서보안을 위한 잠금장치 사용<br />
개인정보가 포함된 서류, 보조저장매체 등을 잠금장치가 있는 안전한 장소에 보관하고 있습니다.</li>
<li>비인가자에 대한 출입 통제<br />
개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.</li>
</ul></div>
<h2>개인정보 보호책임자</h2>
<div class="m1">콘텐츠코리아랩은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

<ul class="bull">
<li>콘텐츠코리아랩 개인정보보호책임자 : 산업진흥 부원장 김영철

<ul>
<li>이메일 : <a href="mailto:privacy@kocca.kr" title="담당자에게 메일 보내기(새창열림)" target="_blank">privacy@kocca.kr</a></li>
<li>전화번호 : 061-900-6300</li>
</ul></li>
<li>콘텐츠코리아랩 개인정보보호담당자 : 창의인재양성팀 차장&nbsp;임호수

<ul>
<li>이메일 : <a href="mailto:lakelim@kocca.kr" title="담당자에게 메일 보내기(새창열림)" target="_blank">lakelim@kocca.kr</a> </li>
<li>전화번호 : 02-2161-0063, 팩스 : 02-2161-0078</li>
</ul></li>
</ul>
<p class="text-danger m1">※ 정보주체께서는 콘텐츠코리아랩의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당자로 문의하실 수 있습니다. 콘텐츠코리아랩은 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다. </p>
<p class="text-danger m1">※ 기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다. 개인정보침해신고센터 (www.1336.or.kr/국번없이 118)</p> 
<ul class="bull">
<li>정보보호마크인증위원회 (<a href="http://www.eprivacy.or.kr" title="새창열림" target="_blank">www.eprivacy.or.kr</a>/02-580-0533~4)</li>
<li>대검찰청 인터넷범죄수사센터 (<a href="http://www.spo.go.kr" title="새창열림" target="_blank">www.spo.go.kr</a>/02-3480-3600)</li>
<li>경찰청 사이버테러대응센터 (<a href="http://www.ctrc.go.kr" title="새창열림" target="_blank">www.ctrc.go.kr</a>/02-392-0330)</li>
</ul></div>
<h2>고지의무</h2>
<div class="m1">
<p>본 콘텐츠코리아랩 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다. </p>
<ul class="bull">
<li>공고일자 : 2015년 12월 15일</li>
<li>시행일자 : 2015년 12월 21일</li>
</ul>
<p>이전의 개인정보 처리방침은 아래에서 확인하실 수 있습니다.</p>
<ul class="bull">
<li>2015년 12월 21일 이전 내용&nbsp;<a class="uline btn btn-sm btn-black" title="새창열림" href="/files/ckl_20151221Privacy.pdf" target="_blank">보기</a></li>
<li>2016년 1월 22일 이전 내용&nbsp;<a class="uline btn btn-sm btn-black" title="새창열림" href="/files/ckl_20160115Privacy.pdf" target="_blank">보기</a></li>
</ul></div></div>






		</div>
	</div>
</div>
<!-- //개인정보 처리방침 -->

<div class="msgBx mt5">
	<div>
		<h3>개인정보 수집 및 이용 (필수)</h3>
		<div tabindex="0" class="agreeScr">
			<ul>
				<li>1. 수집 &middot; 이용 목적 : 콘텐츠코리아랩 회원가입을 위한 사용자 정보 수집 및 이용</li>
				<li>2. 개인정보 수집 항목 :
					<div class="m1 mb0">
						<dl>
							<dd>필수항목 : 아이디, 비밀번호, 이름, 생년월일, 성별, 이메일, 휴대폰, 정보수신 여부</dd>
							<dd>선택항목 : 거주지, 직업</dd>
						</dl>
					</div>
				</li>
				<li>3. 개인정보 보유 및 이용기간 : 회원탈퇴시 까지, 3년 이상 홈페이지에 접속이 없는 경우</li>
				<li>4. 동의 거부 시 불이익에 관한 사항 : 수집 &middot; 이용에 관한 사항의 동의를 거부할 때에는 서비스의 이용이 제한됩니다.   단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.</li>
			</ul>
		</div>
	</div>

<c:if test="${param.mode eq 'i'}">
	<h3>정보수신 여부(필수)</h3>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>정보수신 여부</caption>
			<colgroup>
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 정보수신 여부</th>
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
		<a href="/ckl/userMember/secsn.do?menuNo=200060" class="btn btn-danger">서비스 탈퇴</a>
	</div>
</div>

