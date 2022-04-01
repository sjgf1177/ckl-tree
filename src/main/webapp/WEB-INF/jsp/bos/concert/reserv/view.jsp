<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>

<link rel="stylesheet" type="text/css" href="/edu/css/testbed_print_ticket.css"/>
<script type="text/javascript">


// 기본 인쇄 버튼 제거.
$(".hgroup.clearfix").find("#print").hide();


	function del(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/concert/reserv/delete.do";
			form.submit();
		}
	}
	// 참여여부변경
	function updateReservStatus(){
		if (confirm("참여 여부를 변경하시겠습니까?")) 
			$.get("/bos/concert/reserv/changeReservStatus.json"
					, { "statusType" : "join", "status" : "${result.joinStatus eq 1 ? 0:1}", "reservMasterCode": "${param.reservMasterCode}" }
					, function(data) {
						if (data.resultCode == 'success') {
							alert("정상적으로 수정되었습니다.");
							location.reload();
						} else {
							alert(data.msg);
						}
					},"json");
	}
	// 예약 취소
	function updateStatus(){
		if (confirm("정말로 취소하시겠습니까?")) 
			$.get("/bos/concert/reserv/changeReservStatus.json"
					, { "statusType" : "reserv", "status" : 0, "reservMasterCode": "${param.reservMasterCode}", "concertId" : "${param.concertId}", "concertTimeId" : "${param.concertTimeId}", "menuNo" : "${param.menuNo}" }
					, function(data) {
						if (data.resultCode == 'success') {
							alert("정상적으로 취소되었습니다.");
							location.href = "/bos/concert/reserv/list.do?concertId=${param.concertId}&concertTimeId=${param.concertTimeId}&menuNo=${param.menuNo}";
						} else {
							alert(data.msg);
						}
					},"json");
	}
	// 예약 내역 출력
	function printReserv(){
		
	}

</script>

<a class="btn btn-sm btn-success" href="/edu/forPrintTicket.jsp" id="printTicket" title="새창" style="float:right;" 
onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i><span>출력하기</span>
</a>

<form name="f_regi" method="post" action="#" enctype="multipart/form-data">
	<input type="hidden" name="prgSn" value="${result.prgSn}">
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'>

	<h4>예약정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>예약정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>예약구분</th>
					<td colspan="3">${result.mainDisplay ne '1' ? '온라인' : '현장'}</td>
				</tr>
				<tr>
					<th>신청,접수일</th>
					<td>${result.concertTitle}</td>
					<th>취소일</th>
					<td>${result.cancelDate}</td>
				</tr>
				<tr>
					<th>참여여부</th>
					<td colspan="3">
						${result.joinStatus eq '1' ? '참석' : '미참석'}
						&nbsp;&nbsp;
						<a class="btn btn-default btn-sm" href="javascript:updateReservStatus()" id="updtReservStatusBtn">
							<span>
								참여여부변경
							</span>
						</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>개인정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>신청정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td colspan="3">
						${result.userId}
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td colspan="3">
						${result.memberName}
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td colspan="3">
						${result.birthday}
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td colspan="3">
						${result.sex}
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="3">
						${result.email}
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td colspan="3">
						${result.memberTel}
					</td>
				</tr>
				<tr>
					<th>거주지역</th>
					<td colspan="3">
						${result.homeArea}
					</td>
				</tr>
				<tr>
					<th>직업</th>
					<td colspan="3">
						${result.job}
					</td>
				</tr>
				<tr>
					<th>소속</th>
					<td colspan="3">
						${result.dept}
					</td>
				</tr>
				<%-- 
				<tr>
					<th>신청기간</th>
					<td>${result.beginDt} ~ ${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}</td>
					<th>진행상태</th>
					<td>
						<c:choose>
							<c:when test="${progrsSttus eq WAITING}">대기</c:when>
							<c:when test="${progrsSttus eq PROGRESS}">진행</c:when>
							<c:when test="${progrsSttus eq FINISH_PSNCPA}">진행</c:when>
							<c:when test="${progrsSttus eq FINISH}">마감</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>신청방식</th>
					<td>${result.reqstMthdNm}</td>
					<th>정원</th>
					<td>${result.reqstMthd eq '01' ? result.psncpa : ''} ${result.reqstMthd eq '01' ? '명' : '-'}</td>
				</tr>
				<tr>
					<th>대기신청여부</th>
					<td colspan="3">대기신청
						<c:choose>
							<c:when test="${result.waitReqstAt eq 'Y'}">가능 ( ${result.waitReqstNmpr}명 )</c:when>
							<c:otherwise>불가</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>접수번호표시</th>
					<td>${result.rceptNoIndictAt eq 'N' ? '숨김' : '표시'}</td>
					<th>승인단계사용</th>
					<td>${result.confmStepAt eq 'N' ? '미사용' : '사용'}</td>
				</tr>
				<tr>
					<th>수료증발급</th>
					<td>${result.ctfhvIssuUseAt eq 'N' ? '미사용' : '사용'}</td>
					<th>위탁제공사용</th>
					<td>${result.indvdlinfoAgreAt eq 'N' ? '미사용' : '사용'}</td>
				</tr>
				<tr>
					<th>개인정보 제3자<br/>위탁제공 코멘트</th>
					<td colspan="3">${result.indvdlinfoAgreAt eq 'Y' ? result.indvdlinfoAgreCn : '미사용'}</td>
				</tr>
				 --%>
			</tbody>
		</table>
	</div>

	<h4>신청부가정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>신청정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>이메일 수신</th>
					<td>${result.concertEmailAt eq 'Y' ? '승인' : '미승인'}</td>
					<th>SMS 수신</th>
					<td>${result.concertSmsAt eq 'Y' ? '승인' : '미승인'}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="row clear mt20">
<!-- 		<div class="col-md-1"><a href="javascript:printReserv();" class="btn btn-primary">예약내역출력</a></div> -->
		<div class="col-md-10 tac">
		<a href="/bos/concert/reserv/forUpdate.do?reservMasterCode=${result.reservMasterCode}&concertId=${ param.concertId}&concertTimeId=${param.concertTimeId }&${pageQueryString}" class="btn btn-primary">수정</a>
		<a href="javascript:updateStatus(0);" class="btn btn-danger">예약취소</a>
		</div>
		<div class="col-md-1"><a href="/bos/concert/reserv/list.do?concertTimeId=${param.concertTimeId}&concertId=${param.concertId}&${pageQueryString}" class="btn btn-primary">목록</a></div>
	</div>

</form>





<!-- 프린트를 위한 영역 -->
<div class="col-12 sub_contents_view_location" style="max-width: 616px; margin: auto; float: none; display: none;">
	<div class="col-12 reserve_print_contents" id="ticketPrint"> 
	    <div class="reserve_print_logo">
	        <img src="/edu/images/bm/testbed_black_logo.png" alt="콘텐츠문화광장 로고">
	    </div>
	    <div class="reserve_printing_time">
	        <span id="reservRegDateTime">${reservMasterInfo.regDateToChar }</span>
	    </div>
	    <div class="reserve_printing_article first">
	        <div class="reserve_printing_name">
	            [총인원 <span class="point2" id="selectedMemberCnt">${reservMasterInfo.sitCount }</span>명] 예약자 : <span class="point2">${reservMasterInfo.memberName}</span>
	        </div>
	        <div class="reserve_printing_title">
	            ${reservMasterInfo.concertTitle}
	        </div>
	        <div class="reserve_printing_date">
	            <span id="selectedDate">${reservMasterInfo.startDate} (${reservMasterInfo.startDay})</span> <span id="selectedStartTime">${reservMasterInfo.startTime}</span> ~ <span id="selectedEndTime">${reservMasterInfo.endTime}</span>
	        </div>
	        <div class="reserve_printing_seat">
	            ${reservMasterInfo.concertPlace} / <span class="point2" id="selectedSitList">${reservMasterInfo.sitInfo}</span>
	        </div>
	    </div>
	    <div class="reserve_printing_article">
	        <div class="reserve_printing_rule">
	            변경 및 취소 규정
	        </div>
	        <div>
		        <p class="reserve_printing_desc_emphasis">
		            [변경의 경우 예약 취소 후 다시 예약을 진행하셔야 합니다.]
	            </p>
	        </div>
	        <div class="reserve_printing_desc">
	            <p class="reserve_printing_desc_title">
	                인터넷변경ㆍ취소
	            </p>
	            공연관람일 전일 23시까지 가능 (주말, 공휴일의 경우 그전일 23시까지 가능)
	        </div>
	        <div class="reserve_printing_desc">
	            <p class="reserve_printing_desc_title">
	                전화변경ㆍ취소
	            </p>
	            인터넷 예약이 불가능한 경우 담당자 문의를 통해 변경가능
	        </div>
	        <div class="reserve_printing_desc last">
	            <p class="reserve_printing_desc_title">
	                티켓매니저
	            </p>
	            CALL : 02-6310-0735
	        </div>
	    </div>
	    <div class="reserve_printing_article last">
	        <div class="reserve_printing_rule">
	            유의사항
	        </div>
	        <div class="reserve_printing_desc">
	            <p class="reserve_printing_desc_title">
	                1) 예약 유효 시간
	            </p>
	            <ul class="popup_list_style_2">
	                <li>티켓은 공연 1시간 전부터 문화광장 내 박스오피스에 오셔서  배부 받을 수 있습니다.</li>
	                <li>사전예약을 하셨더라도 공연 15분 전까지 미수령 시 예약이 취소되며,<br/>
	                    이후에 오시면 현장 대기 순으로 티켓을 배부 받습니다.</li>
	            </ul>
	        </div>
	        <div class="reserve_printing_desc">
	            <p class="reserve_printing_desc_title">
	                2) 티켓 현장 배부
	            </p>
	            <ul class="popup_list_style_2">
	                <li>예약하지 않은 관객은 객석의 여유가 있을 경우, 공연 1시간 전부터 티켓을 배부 받습니다.</li>
	                <li>예약이 다 찼을 경우, 먼저 현장에 도착한 순으로 대기번호표를 받고,<br/>
	                    공연 시작 15분전 이후에 사전예약자 미수령분에 한하여 티켓을 교환해드립니다.</li>
	            </ul>
	        </div>
	    </div>
	    <div class="reserve_printing_qrcode">
	        <img id="qrcodeImg" src="/testbed/concert/info/createQrCode.do?content=${reservMasterInfo.reservMasterCode}" alt="공연 예매 QRcode">
	    </div>
	    <div class="reserve_printing_thanks_too">
	        저희 콘텐츠문화광장을 이용해 주셔서 감사합니다.
	    </div>
	</div>
<!-- 	<div class="col-12 mb65 popup_util_btn_con pt30"> -->
<!-- 	    <a href="/edu/forPrintTicket.jsp" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기" class="popup_util_btn_style black"> -->
<!-- 	        출력 -->
<!-- 	    </a> -->
<!-- 	</div> -->
</div>