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
<jsp:scriptlet>
    pageContext.setAttribute("cr", "\r");
    pageContext.setAttribute("lf", "\n");
    pageContext.setAttribute("crlf", "\r\n");
</jsp:scriptlet>

<div class="col-12 sub_contents_view_location" style="max-width: 616px; margin: auto; float: none;">
	<div class="col-12 reserve_print_contents" id="ticketPrint"> 
	    <div class="reserve_print_logo">
	        <img src="/edu/images/bm/testbed_black_logo.png" alt="콘텐츠문화광장 로고">
	    </div>
	    <div class="reserve_printing_time">
	        <span id="reservRegDateTime">${result.regDateToChar }</span>
	    </div>
	    <div class="reserve_printing_article first">
	        <div class="reserve_printing_name">
	            [총인원 <span class="point2" id="selectedMemberCnt">${result.sitCount }</span>명] 예약자 : <span class="point2">${userVO.userNm}</span>
	        </div>
	        <div class="reserve_printing_title">
	            <c:out value="${result.concertTitle}"/>
	        </div>
	        <div class="reserve_printing_date">
	            <span id="selectedDate">${result.startDate} (${result.startDay})</span> <span id="selectedStartTime">${result.startTime}</span> ~ <span id="selectedEndTime">${result.endTime}</span>
	        </div>
	        <div class="reserve_printing_seat">
	            ${result.concertPlace} / <span class="point2" id="selectedSitList">${result.sitInfo}</span>
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
	        <img id="qrcodeImg" src="/testbed/concert/info/createQrCode.do?content=${result.reservMasterCode}" alt="공연 예매 QRcode">
	    </div>
	    <div class="reserve_printing_thanks_too">
	        저희 콘텐츠문화광장을 이용해 주셔서 감사합니다.
	    </div>
	</div>
	<div class="col-12 mb65 popup_util_btn_con pt30">
	    <a href="/edu/forPrintTicket.jsp" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기" class="popup_util_btn_style black">
	        출력
	    </a>
	    <a href="javascript:history.back();" class="popup_util_btn_style" id="step4CompleteBtn">
	        확인
	    </a>
	</div>
</div>
	
	
	
<iframe name="ssoAuthFrame" id="ssoAuthFrame" style="width:0px;height:0px;border:0;" src="${ssoDomain }/sso/member/checkSSO.do?service=edu&amp;menuNo=<c:out value="${paramVO.menuNo }" />&amp;userTp=<c:out value="${userVO.userIdx }" />" title="SSO 로그인 유무확인 프레임 입니다."></iframe>

