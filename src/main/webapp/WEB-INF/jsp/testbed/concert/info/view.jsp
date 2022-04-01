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


<script type="text/javascript" src="/edu/js/concert/Dom.js"></script>
<script type="text/javascript" src="/edu/js/concert/ProgressBar.js"></script>
<script type="text/javascript" src="/edu/js/concert/Form.js"></script>
<script type="text/javascript" src="/edu/js/concert/Number.js"></script>
<script type="text/javascript" src="/edu/js/concert/String.js"></script>
<script type="text/javascript" src="/edu/js/concert/Calendar.js"></script>

<script type="text/javascript" src="/edu/js/concert/reservation.js"></script>
<script type="text/javascript">

	function del(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/concert/info/delete.do";
			form.submit();
		}
	}

	
	$(function(){
		
		// 1인이 예약 가능한 좌석  
		reservation.setReservLimitCnt( <c:out value="${result.reservLimitCnt}"/> );
		
		// 좌석 픽스/선택가능 여부
		reservation.setSitChoiceMode( <c:out value="${result.reservSitFix}"/> );
		
	})
	
	
	var userName = "${userVO.userNm}";
	
</script>


<%-- 
<%
QRCodeWriter q = new QRCodeWriter();
String text = "한글 테스트";

text = new String(text.getBytes("UTF-8"), "ISO-8859-1");

BitMatrix bitMatrix = q.encode(text, BarcodeFormat.QR_CODE, 100, 100);
out.clear(); // clear buffer
ServletOutputStream outputStream = response.getOutputStream();
MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream);
outputStream.flush();
outputStream.close();
%>
 --%>

<div class="col-12 sub_contents_view_location">

    <div class="sub_contents_view_location_header">
		<c:if test="${not empty fileList}">
		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<c:if test="${fn:indexOf(fileVO.fileFieldName, 'posterImg') != -1 }">
				<c:set var="posterImgFile" value="${fileVO}"/>
				<c:if test="${status.index%2 == 1}">
				</c:if>
				<div class="img_box" style="background-image:url('/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />'); background-size:cover;">
				</div> 
				<!-- 내용이미지 이미지 -->
				<%-- <img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  /> --%>
			</c:if>
		</c:forEach>
		</c:if>
		<c:if test="${empty posterImgFile}">
			<!-- 빈이미지 처리 -->
			<div class="img_box"></div>
			<!-- //빈이미지 처리 -->
		</c:if>
        <div class="table_box">
            <h5>
                <span class="concert_title">[<c:out value="${result.concertType}"/>]</span> <c:out value="${result.concertTitle}"/>
            </h5>
            <table class="table_style_2 type_2">
            	<caption>공연 기본정보 테이블</caption>
                <colgroup>
                    <col width="22%">
                    <col width="auto">
                </colgroup>
                <tbody>
                <tr>
                    <th>장소</th>
                    <td>${result.concertPlace}</td>
                </tr>
                <tr>
                    <th class="middle_cell">기간</th>
                    <td><span>${result.concertStartDate} ~ ${result.concertEndDate}</span></td>
                </tr>
                <tr>
                    <th class="middle_cell">시간</th>
                    <td><p>${fn:replace(result.concertTime , crlf, '<br />' )}</p></td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><c:if test="${result.isFree == 0 }">유료</c:if><c:if test="${result.isFree != 0 }">무료</c:if></td>
                </tr>
                <tr>
                    <th class="long_cell">비고</th>
                    <td>
                    ${fn:replace(result.commentMsg , crlf, '<br />' )}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col-12">
        	<div class="ticketing_btn_wrap">
            	<a class="btn_style_3 list" href="/${paramVO.siteName}/concert/info/list.do?${pageQueryString}&listType=${param.listType}&selectedYear=${param.selectedYear}&selectedMonth=${param.selectedMonth}&selectedDate=${param.selectedDate}">
                	목록가기
            	</a>
            	<c:if test="${result.useReserv eq 1 && canReservTimeCnt ne 0 && result.canReservNow eq 1 }">
	            	<c:choose>
	            	<c:when test="${!empty result.reservUrl}">
						<a class="btn_style_3 ticketing" href="${result.reservUrl}" target="_blank" title="새창열림">예약하기</a>
					</c:when>
	            	<c:when test="${empty userVO.userKey}">
						<a class="btn_style_3 ticketing" href="javascript:reservation.needLogin();">예약하기</a>
						<a class="btn_style_3 ticketing" href="javascript:reservation.open(${result.concertId});">예약하기2</a>
						<c:if test="${paramVO.siteName eq 'testbed' }">
							<c:set var="loginMenuNo" value="700115" />
						</c:if>
						<c:if test="${paramVO.siteName eq 'edumobile' }">
							<c:set var="loginMenuNo" value="600130" />
						</c:if>	
						<form class="login_form" name="detailLoginForm" id="detailLoginForm" action="/edu/member/forLogin.do?menuNo=500077" method="post" style="display:none;">
							<input type="hidden" name="redirectUrl" value="/${paramVO.siteName}/concert/info/list.do?menuNo=700130&listType=2" />
						</form>
					</c:when>
					<c:otherwise>
							<a class="btn_style_3 ticketing" href="javascript:reservation.open(${result.concertId});">예약하기</a>
					</c:otherwise>
	            	</c:choose>
				</c:if>
        	</div>
        </div>
    </div>

    <!-- <div class="tab_style_1_con">
        <ul class="tab_style_1 view_date0">
            <li class="active"><a href="javascript:void(0)"><span>공연ㆍ행사 상세정보</span></a></li>
            <li><a href="javascript:void(0)"><span>예약주의사항</span></a></li>
        </ul>
    </div> -->

    <!-- 공연ㆍ행사상세정보 -->
    <div class="content_detail_con mb50">
        <p class="detail_title">공연 상세정보</p>
        <ul class="fr tr detail_txt">
            <li class="en"><span class="point">Content</span> Details</li>
            <li>작품에 대한 설명과 이미지를 자세히 보실 수 있습니다.</li>
        </ul>
    </div>
    <div class="sub_contents_view_location_body view_date_contents0 line">

        <div class="sub_contents_view_location_body_list">

            <h6>
                작품 설명
            </h6>
            
            <c:if test="${!empty result.concertExplain}">
            <hr class="h_line6">
            <div class="h_desc6">
                <p class="mt20">
                ${fn:replace(result.concertExplain , crlf, '<br />' )}
                </p>
            </div>
            </c:if>
            
            <c:if test="${!empty result.additionalContent1}">
	            <hr class="h_line6 pb27">
	            <div class="h_desc6">
	                <span class="point0" style="font-weight:400;">${result.additionalTitle1}</span>
	                <p class="mt20">
	                ${fn:replace(result.additionalContent1 , crlf, '<br />' )}
	                </p>
	            </div>
            </c:if>
            
            <c:if test="${!empty result.additionalContent2}">
	            <hr class="h_line6 pb27">
	            <div class="h_desc6">
	                <span class="point0" style="font-weight:400;">${result.additionalTitle2}</span>
	                <p class="mt20">
	                ${fn:replace(result.additionalContent2 , crlf, '<br />' )}
	                </p>
	            </div>
            </c:if>
            
            <c:if test="${!empty result.additionalContent3}">
	            <hr class="h_line6 pb27">
	            <div class="h_desc6">
	                <span class="point0" style="font-weight:400;">${result.additionalTitle3}</span>
	                <p class="mt20">
	                ${fn:replace(result.additionalContent3 , crlf, '<br />' )}
	                </p>
	            </div>
            </c:if>
            
        </div>

        <div class="sub_contents_view_location_body_list" id="detailImgCon">
            <h6>
                상세이미지
            </h6>
            <hr class="h_line6">
            <div class="over-hidden calc_wrap22">
            <c:if test="${not empty fileList}">
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<c:if test="${fn:indexOf(fileVO.fileFieldName, 'detailImg1') != -1 }">
						<c:if test="${status.index%2 == 1}">
							<br>
						</c:if> 
	                	<div class="col-12 col-sm-4 sub_contents_view_location_body_card">
		                    <div class="img_box">
									<!-- 내용이미지 이미지 -->
									<img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
		                    </div>
	                	</div>
	                </c:if>
				</c:forEach>
			</c:if>
				<c:if test="${not empty fileList}">
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<c:if test="${fn:indexOf(fileVO.fileFieldName, 'detailImg2') != -1 }">
						<c:if test="${status.index%2 == 1}">
							<br>
						</c:if> 
           				<div class="col-12 col-sm-4 sub_contents_view_location_body_card">
		                   <div class="img_box">
								<!-- 내용이미지 이미지 -->
								<img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
							
		                   </div>
	               		</div>
	               </c:if>
				</c:forEach>
				</c:if>
				
				<c:if test="${not empty fileList}">
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<c:if test="${fn:indexOf(fileVO.fileFieldName, 'detailImg3') != -1 }">
						<c:if test="${status.index%2 == 1}">
							<br>
						</c:if> 
           				<div class="col-12 col-sm-4 sub_contents_view_location_body_card">
		                   <div class="img_box">
								<!-- 내용이미지 이미지 -->
								<img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
		                   </div>
	               		</div>
	               </c:if>
				</c:forEach>
				</c:if>
            </div>
            <hr class="h_line6">
            <div>
            <c:if test="${not empty fileList}">
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
				<c:if test="${fn:indexOf(fileVO.fileFieldName, 'additionalImg') != -1 }">
					<c:if test="${status.index%2 == 1}">
						<br>
					</c:if> 
					<!-- 내용이미지 이미지 -->
					<img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
				</c:if>
			</c:forEach>
			</c:if>
            </div>
        </div>
        <script type="text/javascript">
        
        if( $("#detailImgCon .img_box").length == 0 ) $("#detailImgCon").hide();
        else $("#detailImgCon").show();
        
        </script>
        
        <div class="sub_contents_view_location_body_list" id="movieCon" style="display:none; <c:if test="${!empty result.vimeoUrl }">display:block;</c:if>">
	        <hr class="h_line6">
	        <h6>
	            홍보영상
	        </h6>
	        <div>
	        	<p style="text-align:center; padding:40px 0;"><iframe src="${result.vimeoUrl}" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen title="홍보영상"></iframe></p>
	        </div>
        </div>
        <!--<div class="sub_contents_view_location_body_list">

            <h6>
                취소, 변경 마감시간안내
            </h6>
            <hr class="h_line6">
            <table class="table_style_3">
                <colgroup>
                    <col width="25%">
                    <col width="auto">
                </colgroup>
                <tbody>
                <tr>
                    <th>구분</th>
                    <td>개별공연ㆍ행사</td>
                </tr>
                <tr>
                    <th>취소, 변경 마감시간</th>
                    <td>공연ㆍ행사일 이전 18시까지</td>
                </tr>
                </tbody>
            </table>
        </div>-->
    </div>
    <!-- //공연ㆍ행사상세정보 -->

    <!-- 예약주의사항 -->
    <div class="mt30 content_detail_con mb50">
	        <p class="detail_title">예약 주의사항</p>
	        <ul class="fr tr detail_txt">
	            <li class="en"><span class="point">Booking</span> Details</li>
	            <li>공연예약시 주의해야할 사항을 보실 수 있습니다.</li>
	        </ul>
	    </div>
    <div class="sub_contents_view_location_body view_date_contents0 line">

	<div class="sub_contents_view_location_body_list">
	
	            <h6>
	                공연ㆍ행사 관람안내
	            </h6>
	            <hr class="h_line6">
	            <ul class="list_style_contents_view">
	                <li>
	                    <div class="w-129">
	                        <span class="title">공연ㆍ행사 일자</span>
	                    </div>
	                    <div class="wper-129">
	                        ${result.concertStartDate} ~ ${result.concertEndDate}
	                    </div>
	                </li>
	                <li>
	                    <div class="w-129">
	                        <span class="title">공연ㆍ행사 장소</span>
	                    </div>
	                    <div class="wper-129">
	                        ${result.concertPlace}
	                    </div>
	                </li>
	                <li>
	                    <div class="w-129">
	                        <span class="title">관람료</span>
	                    </div>
	                    <div class="wper-129">
	                    <c:if test="${result.isFree == '1'}">
	                    	무료
	                    </c:if>
	                    <c:if test="${result.isFree == '0'}">
	                    	유료
	                    </c:if>
	                    </div>
	                </li>
	                <li>
	                    <div class="w-129">
	                        <span class="title">공연ㆍ행사 문의</span>
	                    </div>
	                    <div class="wper-129">
	                        ${result.helpCall}
	                    </div>
	                </li>
	            </ul>
	
	        </div>
	
	        <div class="sub_contents_view_location_body_list">
	
	            <h6>
	                예약 변경 안내
	            </h6>
	            <hr class="h_line6">
	            <ul class="list_style_contents_view">
	                <li>
	                    <div class="w-129">
	                        <span class="title">인터넷 변경ㆍ취소</span>
	                    </div>
	                    <div class="wper-129">
	                        공연ㆍ행사 관람일 전일 23시까지 가능<br/>
	                        <span class="desc">(주말, 공휴일의 경우, 그 전일 23시까지 가능)</span>
	                    </div>
	                </li>
	                <li>
	                    <div class="w-129">
	                        <span class="title">전화 변경ㆍ취소</span>
	                    </div>
	                    <div class="wper-129">
	                        인터넷예매가 불가능한 경우 담당자 문의를 통해 변경 가능<br/>
	                        <span class="desc">티켓매니저 02-6310-0735</span>
	                    </div>
	                </li>
	            </ul>
	        </div>
	
	        <div class="sub_contents_view_location_body_list">
	
	            <h6>
	                유의 사항
	            </h6>
	            <hr class="h_line6">
	            <ul class="list_style_contents_view">
	                <li>
	                    <div class="mb5">
	                        <span class="title">1) 예약 유효 시간</span>
	                    </div>
	                    <div class="pad_left">
	                        <ul class="list_style_9 gray_style">
		                        <li>티켓은 공연ㆍ행사 1시간 전부터 문화광장 내 박스오피스에 오셔서 배부 받을 수 있습니다.</li>
		                        <li>사전예약을 하셨더라도 공연ㆍ행사 15분 전까지 미수령 시 예약이 취소되며, 이후에 오시면 현장 대기 순으로 티켓을 배부 받습니다.</li>
	                        </ul>
	                    </div>
	                </li>
	                <li>
	                    <div class="mb5">
	                        <span class="title">2) 티켓 현장 배부</span>
	                    </div>
	                    <div class="pad_left">
	                        <ul class="list_style_9 gray_style">
		                        <li>예약하지 않은 관객은 객석의 여유가 있을 경우, 공연ㆍ행사 1시간 전부터 티켓을 배부 받습니다.</li>
		                        <li>예약이 다 찼을 경우, 먼저 현장에 도착한 순으로 대기번호표를 받고, 공연ㆍ행사 시작 15분전 이후에 사전예약자 미수령분에 한하여 티켓을 교환해드립니다.</li>
	                        </ul>
	                    </div>
	                </li>
	                <li>
	                    <div class="mb5">
	                        <span class="title">3) 취소 수수료</span>
	                    </div>
	                    <div class="pad_left">
	                        <ul class="list_style_9 gray_style">
	                        	<li>무료인 경우 취소 수수료가 없습니다.</li>
	                        	<li>대관 공연ㆍ행사인 경우, 대관단체의 티켓 정책에 따릅니다.</li>
	                       	</ul>
	                    </div>
	                </li>
	                <li>
	                    <div class="mb5">
	                        <span class="title">4) 휠체어석 예약</span>
	                    </div>
	                    <div class="pad_left">
	                        <ul class="list_style_9 gray_style">
	                        	<li>휠체어석 이용을 원하시거나 휠체어석 예약을 진행하신 경우, 운영지원실(02-6310-0735)로 문의해주시기 바랍니다.</li>
	                       	</ul>
	                    </div>
	                </li>
	            </ul>
	        </div>

    </div>
    <!-- //예약주의사항 -->


</div>




	
	<!-- popup00 -->
	<div class="col-12 popup_wrap" style="display: none;" id="reservPopStep0">
	    <div class="col-12 col-md-10 col-center popup_con contents_type_2_popup">
	        <div class="col-12 popup_style_0 type2">
	            <div class="col-12 popup_title_wrap">
	                <div class="popup_title">
	                    콘텐츠문화광장 공연
	                </div>
	                <div class="popup_close_btn_con">
	                    <a href="javascript:void(0)" class="popup_close_btn">
	                        <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
	                    </a>
	                </div>
	            </div>
	            <div class="col-12 popup_contents_wrap">
	                <div class="mb63 horizon_tab_style_1_con">
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            1
	                        </div>
	                        <div class="horizon_tab_text">
	                            관람일 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력 내용 확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약 완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <div class="col-12 col-md-6 article_list_type_0 left">
	                            <ul class="mb25 list_style_2">
	                                <li>관람일 선택</li>
	                            </ul>
	                            <div class="calendar_style_1_box_wrap" id="reservationCalendarContaienr">
	                                <div class="calendar_style_1_month_con">
	                                    <div class="calendar_style_1_month_inner">
	                                        <div class="arrow_box" id="datePickerLeftBtn">
	                                            <img src="/edu/images/bm/calendar_month_left_arrow.png" alt="한달 전">
	                                        </div>
	                                        <div class="calendar_month_text" style="display:inline-block;">
	                                            <span id="bmCalYear"></span>. <span id="bmCalMonth"></span>
	                                        </div>
	                                        <div class="arrow_box" id="datePickerRightBtn">
	                                            <img src="/edu/images/bm/calendar_month_right_arrow.png" alt="한달 후">
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="calendar_style_1_wrap always_on">
	                                    <table class="calendar_style_1 type_2" id="reservationCalendarTable">
	                                        <caption>공연일정 선택 달력</caption>
	                                        <colgroup>
	                                            <col width="14.28%">
	                                            <col width="14.28%">
	                                            <col width="14.28%">
	                                            <col width="14.28%">
	                                            <col width="14.28%">
	                                            <col width="14.28%">
	                                            <col width="14.28%">
	                                        </colgroup>
	                                        <thead>
	                                        <tr>
	                                            <th>Mo</th>
	                                            <th>Tu</th>
	                                            <th>We</th>
	                                            <th>Th</th>
	                                            <th>Fr</th>
	                                            <th>Sa</th>
	                                            <th>Su</th>
	                                        </tr>
	                                        </thead>
	                                        <tbody>
	                                        <tr class="cal_row">
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date"></a>
	                                            </td>
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date"></a>
	                                            </td>
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date">
	                                                </a>
	                                            </td>
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date">
	                                                </a>
	                                            </td>
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date">
	                                                </a>
	                                            </td>
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date">
	                                                </a>
	                                            </td>
	                                            <td>
	                                                <a href="javascript:void(0)" class="calendar_date dp_date">
	                                                </a>
	                                            </td>
	                                        </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-12 col-md-6 article_list_type_0 right">
		                        <div class="concert_time_area">
		                            <ul class="mb25 list_style_2">
		                                <li>시간선택</li>
		                            </ul>
		                            <ul class="mb15 popup_list_style_1" id="reservationTimeListCon">
		                            	날짜를 선택해 주세요.
		                            </ul>
		                            <div class="tc mb15" style="display: none;" id="tempReservBtn">
		                            	<a class="wating_btn" href="javascript:void(0);">예약대기</a>
	                            	</div>
		                        </div>
	                            <ul class="mb25 list_style_2">
	                                <li>입력 내용 확인</li>
	                            </ul>
	                            <div id="pleaseSelectDateAndTimeMessage">관림일과 시간을 선택해주세요.</div>
	                            <table class="popup_table_style_0" id="confirmDateAndTime">
	                                <caption>입력 내용 확인</caption>
	                                <colgroup>
	                                    <col width="30%">
	                                    <col width="auto">
	                                </colgroup>
	                                <tbody>
	                                <tr>
	                                    <th>관람일</th>
	                                    <td class="point0" id="confirmSelectedDate"></td>
	                                </tr>
	                                <tr>
	                                    <th>공연 시간</th>
	                                    <td><span id="confirmSelectedStartTime"></span> ~ <span id="confirmSelectedEndTime"></span></td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </div>
	                <div class="popup_util_btn_con">
	                    <a href="javascript:reservation.showNextStep();" class="popup_util_btn_style">
	                        다음
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-12 popup_dim"></div>
	</div>
	<!-- //popup00 -->
	
	
	



	<!-- popup01 -->
	<div class="col-12 popup_wrap" style="display: none;" id="reservPopStep1">
	    <div class="col-12 col-md-10 col-center popup_con contents_type_2_popup">
	        <div class="col-12 popup_style_0 type2">
	            <div class="col-12 popup_title_wrap">
	                <div class="popup_title">
	                    콘텐츠문화광장 공연
	                </div>
	                <div class="popup_close_btn_con">
	                    <a href="javascript:void(0)" class="popup_close_btn">
	                        <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
	                    </a>
	                </div>
	            </div>
	            <div class="col-12 popup_contents_wrap">
	                <div class="mb63 horizon_tab_style_1_con">
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            1
	                        </div>
	                        <div class="horizon_tab_text">
	                            관람일 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력 내용 확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약 완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <ul class="mb25 list_style_2">
	                            <li>관람인원 선택</li>
	                        </ul>
	                        <div class="mb48 select_style_2_wrap">
	                            <div class="select_style_2_con testbed_style">
	                            	<label for="viewPeopleSelect">관람인원 선택</label>
	                                <select name="view_people_select" id="viewPeopleSelect" class="select_style_2">
	                                    <option value="1">1명</option>
	                                    <option value="2">2명</option>
	                                </select>
	                            </div>
	                        </div>
	                        <ul class="mb35 list_style_2">
	                            <li>좌석 선택</li>
	                        </ul>
	                        <div class="movie_seat_select_wrap">
	                            <div class="movie_seat_select_inner">
	                            	<div id="sit_fix_dim" class="seat_select_dim">
	                            		<div class="seat_dim_text_box_con">
	                            			<div class="seat_dim_text_box">
	                            				<div class="seat_dim_text_inner">
	                            					<div class="seat_dim_text_box_title">
	                            						<span class="img_box">
	                            							<img src="/edu/images/bm/seat_dim_text_dim_alarm.png" alt="알림">
	                            						</span>
	                            						알림
	                            					</div>
	                            					<div class="seat_dim_text_box_desc">
			                            				본 공연의 좌석은 별도로 지정할 수 없습니다.<br>
			                            				현장의 안내에 따라주세요.
	    	                        				</div>
	    	                        			</div>
	                            			</div>
	                            		</div>
	                            	</div>
	                                <div class="movie_screen">
	                                    STAGE
	                                </div>
	                                <div class="movie_seat_list_wrap">

	                                    <!-- movie_seat_top_list 는 콘트롤부스를 제외한 좌석들 -->
	                                    <div class="movie_seat_top_list">
	                                        <div class="side_seat_list_con left">
	
	                                            <!-- vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	                                            <div class="vertical_seat_list third_floor">
	                                                <div class="seat_item" data-sit-id="K01">
	                                                    K01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K02">
	                                                    K02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K03">
	                                                    K03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K04">
	                                                    K04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K05">
	                                                    K05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K06">
	                                                    K06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K07">
	                                                    K07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K08">
	                                                    K08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K09">
	                                                    K09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K10">
	                                                    K10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K11">
	                                                    K11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K12">
	                                                    K12
	                                                </div>
	                                            </div>
	                                            <div class="vertical_seat_list second_floor">
	                                                <div class="seat_item" data-sit-id="J01">
	                                                    J01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J02">
	                                                    J02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J03">
	                                                    J03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J04">
	                                                    J04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J05">
	                                                    J05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J06">
	                                                    J06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J07">
	                                                    J07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J08">
	                                                    J08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J09">
	                                                    J09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J10">
	                                                    J10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J11">
	                                                    J11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J12">
	                                                    J12
	                                                </div>
	                                            </div>
	                                            <!-- //vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	
	                                        </div>
	                                        <div class="center_seat_list_con">
	
	                                            <!-- horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="A01">
	                                                    A01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A02">
	                                                    A02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A03">
	                                                    A03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A04">
	                                                    A04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A05">
	                                                    A05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A06">
	                                                    A06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A07">
	                                                    A07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A08">
	                                                    A08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A09">
	                                                    A09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A10">
	                                                    A10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A11">
	                                                    A11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A12">
	                                                    A12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A13">
	                                                    A13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A14">
	                                                    A14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="A15">
	                                                    A15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="B01">
	                                                    B01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B02">
	                                                    B02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B03">
	                                                    B03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B04">
	                                                    B04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B05">
	                                                    B05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B06">
	                                                    B06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B07">
	                                                    B07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B08">
	                                                    B08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B09">
	                                                    B09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B10">
	                                                    B10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B11">
	                                                    B11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B12">
	                                                    B12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B13">
	                                                    B13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B14">
	                                                    B14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="B15">
	                                                    B15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="C01">
	                                                    C01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C02">
	                                                    C02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C03">
	                                                    C03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C04">
	                                                    C04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C05">
	                                                    C05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C06">
	                                                    C06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C07">
	                                                    C07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C08">
	                                                    C08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C09">
	                                                    C09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C10">
	                                                    C10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C11">
	                                                    C11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C12">
	                                                    C12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C13">
	                                                    C13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C14">
	                                                    C14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="C15">
	                                                    C15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="D01">
	                                                    D01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D02">
	                                                    D02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D03">
	                                                    D03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D04">
	                                                    D04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D05">
	                                                    D05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D06">
	                                                    D06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D07">
	                                                    D07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D08">
	                                                    D08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D09">
	                                                    D09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D10">
	                                                    D10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D11">
	                                                    D11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D12">
	                                                    D12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D13">
	                                                    D13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D14">
	                                                    D14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="D15">
	                                                    D15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="E01">
	                                                    E01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E02">
	                                                    E02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E03">
	                                                    E03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E04">
	                                                    E04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E05">
	                                                    E05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E06">
	                                                    E06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E07">
	                                                    E07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E08">
	                                                    E08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E09">
	                                                    E09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E10">
	                                                    E10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E11">
	                                                    E11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E12">
	                                                    E12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E13">
	                                                    E13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E14">
	                                                    E14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="E15">
	                                                    E15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="F01">
	                                                    F01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F02">
	                                                    F02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F03">
	                                                    F03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F04">
	                                                    F04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F05">
	                                                    F05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F06">
	                                                    F06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F07">
	                                                    F07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F08">
	                                                    F08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F09">
	                                                    F09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F10">
	                                                    F10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F11">
	                                                    F11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F12">
	                                                    F12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F13">
	                                                    F13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F14">
	                                                    F14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="F15">
	                                                    F15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="G01">
	                                                    G01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G02">
	                                                    G02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G03">
	                                                    G03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G04">
	                                                    G04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G05">
	                                                    G05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G06">
	                                                    G06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G07">
	                                                    G07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G08">
	                                                    G08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G09">
	                                                    G09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G10">
	                                                    G10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G11">
	                                                    G11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G12">
	                                                    G12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G13">
	                                                    G13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G14">
	                                                    G14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="G15">
	                                                    G15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="H01">
	                                                    H01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H02">
	                                                    H02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H03">
	                                                    H03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H04">
	                                                    H04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H05">
	                                                    H05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H06">
	                                                    H06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H07">
	                                                    H07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H08">
	                                                    H08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H09">
	                                                    H09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H10">
	                                                    H10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H11">
	                                                    H11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H12">
	                                                    H12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H13">
	                                                    H13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H14">
	                                                    H14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H15">
	                                                    H15
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list">
	                                                <div class="seat_item" data-sit-id="I01">
	                                                    I01
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I02">
	                                                    I02
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I03">
	                                                    I03
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I04">
	                                                    I04
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I05">
	                                                    I05
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I06">
	                                                    I06
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I07">
	                                                    I07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I08">
	                                                    I08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I09">
	                                                    I09
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I10">
	                                                    I10
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I11">
	                                                    I11
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I12">
	                                                    I12
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I13">
	                                                    I13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I14">
	                                                    I14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I15">
	                                                    I15
	                                                </div>
	                                            </div>
	                                            <!-- //horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	
	                                        </div>
	                                        <div class="side_seat_list_con right">
	
	                                            <!-- vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	                                            <div class="vertical_seat_list second_floor">
	                                                <div class="seat_item" data-sit-id="J13">
	                                                    J13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J14">
	                                                    J14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J15">
	                                                    J15
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J16">
	                                                    J16
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J17">
	                                                    J17
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J18">
	                                                    J18
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J19">
	                                                    J19
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J20">
	                                                    J20
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J21">
	                                                    J21
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J22">
	                                                    J22
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J23">
	                                                    J23
	                                                </div>
	                                                <div class="seat_item" data-sit-id="J24">
	                                                    J24
	                                                </div>
	                                            </div>
	                                            <div class="vertical_seat_list third_floor">
	                                                <div class="seat_item" data-sit-id="K21">
	                                                    K21
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K22">
	                                                    K22
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K23">
	                                                    K23
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K24">
	                                                    K24
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K25">
	                                                    K25
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K26">
	                                                    K26
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K27">
	                                                    K27
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K28">
	                                                    K28
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K29">
	                                                    K29
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K30">
	                                                    K30
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K31">
	                                                    K31
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K32">
	                                                    K32
	                                                </div>
	                                            </div>
	                                            <!-- //vertical_seat_list 는 스크린기준 왼쪽과 오른쪽에 위치한 좌석 -->
	
	                                        </div>
	                                    </div>
	                                    <!-- //movie_seat_top_list 는 콘트롤부스를 제외한 좌석들 -->
	
	                                    <!-- movie_seat_bottom_list 는 콘트롤부스 라인 -->
	                                    <div class="movie_seat_bottom_list">
	                                        <div class="side_seat_list_con left">
	                                            <div class="movie_door_icon">
	                                                <img src="/edu/images/bm/movie_enter_icon.png" alt="입구">
	                                            </div>
	                                        </div>
	                                        <div class="center_seat_list_con">
	
	                                            <!-- horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	                                            <div class="horizon_seat_list second_floor">
	                                                <div class="movie_control_room control_room_top">
	                                                    2F 콘트롤부스
	                                                </div>
	                                            </div>
	                                            <div class="horizon_seat_list third_floor">
	                                                <div class="seat_item disabled_seat" data-sit-id="Z01">
	                                                    <img src="/edu/images/bm/disabled_seat_img.png" alt="휠체어석">
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K13">
	                                                    K13
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K14">
	                                                    K14
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K15">
	                                                    K15
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K16">
	                                                    K16
	                                                </div>
	                                                <div class="movie_control_room control_room_bottom">
	                                                   3F 콘트롤룸
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K17">
	                                                    K17
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K18">
	                                                    K18
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K19">
	                                                    K19
	                                                </div>
	                                                <div class="seat_item" data-sit-id="K20">
	                                                    K20
	                                                </div>
	                                                <div class="seat_item disabled_seat" data-sit-id="Z02">
	                                                    <img src="/edu/images/bm/disabled_seat_img.png" alt="휠체어석">
	                                                </div>
	                                            </div>
	                                            <!-- //horizon_seat_list 는 스크린기준 가운데에 위치한 좌석 -->
	
	                                        </div>
	                                        <div class="side_seat_list_con right">
	
	                                            <div class="movie_door_icon">
	                                                <img src="/edu/images/bm/movie_exit_icon.png" alt="입구">
	                                            </div>
	
	                                        </div>
	                                    </div>
	                                    <!-- //movie_seat_bottom_list 는 콘트롤부스 라인 -->
	
	                                </div>
	                            </div>
	                        </div>
	                        <div class="movie_seat_info_con">
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box select"></div>
	                                <div class="movie_seat_info_text">선택</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box"></div>
	                                <div class="movie_seat_info_text">선택 가능</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box selected"></div>
	                                <div class="movie_seat_info_text">예약 완료</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box second_floor"></div>
	                                <div class="movie_seat_info_text">2F</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box third_floor"></div>
	                                <div class="movie_seat_info_text">3F</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box disabled_floor"></div>
	                                <div class="movie_seat_info_text">휠체어석</div>
	                            </div>
	                        </div>
	                        <ul class="mb25 list_style_2">
	                            <li>좌석 입력 확인</li>
	                        </ul>
	                        <div class="my_selected_movie_seat_check">
	                            <div class="selected_movie_seat_item">
	                                R13
	                            </div>
	                            <div class="selected_movie_seat_item_comma">
	                                ,
	                            </div>
	                            <div class="selected_movie_seat_item">
	                                R14
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="popup_util_btn_con">
	                    <a href="javascript:reservation.showPrevStep();" class="popup_util_btn_style gray">
	                        이전
	                    </a>
	                    <a href="javascript:reservation.showNextStep();" class="popup_util_btn_style">
	                        다음
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-12 popup_dim"></div>
	</div>
	<!-- //popup01 -->
	
	
	<!-- popup02 -->
	<div class="col-12 popup_wrap" style="display: none;" id="reservPopStep2">
	    <div class="col-12 col-md-10 col-center popup_con contents_type_2_popup">
	        <div class="col-12 popup_style_0 type2">
	            <div class="col-12 popup_title_wrap">
	                <div class="popup_title">
	                    콘텐츠문화광장 공연
	                </div>
	                <div class="popup_close_btn_con">
	                    <a href="javascript:void(0)" class="popup_close_btn">
	                        <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
	                    </a>
	                </div>
	            </div>
	            <div class="col-12 popup_contents_wrap">
	                <div class="mb63 horizon_tab_style_1_con">
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            1
	                        </div>
	                        <div class="horizon_tab_text">
	                            관람일 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력 내용 확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약 완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <div class="col-12 reserve_check_movie_con">
	                        	<c:if test="${not empty fileList}">
									<c:forEach var="fileVO" items="${fileList}" varStatus="status">
										<c:if test="${fn:indexOf(fileVO.fileFieldName, 'posterImg') != -1 }">
											<c:if test="${status.index%2 == 1}">
					                            <div class="reserve_check_movie_img_box" style="background-image:url('/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />')">
					                            	<%-- <img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  /> --%>
					                            </div>
				                            </c:if> 
										</c:if>
									</c:forEach>
								</c:if>
	                        	<c:if test="${empty posterImgFile}">
		                            <div class="reserve_check_movie_img_box noimg">
		                            </div>
								</c:if>
	                            <%-- <div class="reserve_check_movie_img_box">
	                                <c:if test="${not empty fileList}">
									<c:forEach var="fileVO" items="${fileList}" varStatus="status">
										<c:if test="${fn:indexOf(fileVO.fileFieldName, 'posterImg') != -1 }">
											<c:if test="${status.index%2 == 1}">
												<br>
											</c:if> 
											<!-- 내용이미지 이미지 -->
											<img alt="${result.nttSj }" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fileVO.atchFileId}" />&amp;fileSn=<c:out value="${fileVO.fileSn}" />"  />
										</c:if>
									</c:forEach>
									</c:if>
	                            </div> --%>
	                            <div class="reserve_check_movie_text_box">
	                                <div class="reserve_check_movie_title">
	                                    <c:out value="${result.concertTitle}"/>
	                                </div>
	                                <table class="reserve_check_movie_desc">
	                                    <caption>예매정보 확인</caption>
	                                    <colgroup>
	                                        <col width="84px">
	                                        <col width="auto">
	                                    </colgroup>
	                                    <tbody>
	                                    <tr>
	                                        <th>관람일</th>
	                                        <td id="resevationConfirmDateInfo"></td>
	                                    </tr>
	                                    <tr>
	                                        <th>시간</th>
	                                        <td id="resevationConfirmTimeInfo"></td>
	                                    </tr>
	                                    <tr>
	                                        <th>좌석</th>
	                                        <td id="resevationConfirmSitInfo"></td>
	                                    </tr>
	                                    <tr>
	                                        <th>장소</th>
	                                        <td>${result.concertPlace}</td>
	                                    </tr>
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="popup_util_btn_con">
	                    <a href="javascript:reservation.showPrevStep();" class="popup_util_btn_style gray">
	                        이전
	                    </a>
	                    <a href="javascript:void(0);" class="popup_util_btn_style" id="step3CompleteBtn">
	                        다음
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-12 popup_dim"></div>
	</div>
	<!-- //popup02 -->
	
	
	
	<!-- popup03 -->
	<div class="col-12 popup_wrap" style="display: none;" id="reservPopStep3">
	    <div class="col-12 col-md-10 col-center popup_con contents_type_2_popup">
	        <div class="col-12 popup_style_0 type2">
	            <div class="col-12 popup_title_wrap">
	                <div class="popup_title">
	                    콘텐츠문화광장 공연
	                </div>
	                <div class="popup_close_btn_con">
	                    <a href="javascript:void(0)" class="popup_close_btn">
	                        <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
	                    </a>
	                </div>
	            </div>
	            <div class="col-12 popup_contents_wrap">
	                <div class="mb63 horizon_tab_style_1_con">
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            1
	                        </div>
	                        <div class="horizon_tab_text">
	                            관람일 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석 선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력 내용 확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약 완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 popup_contents_inner">
	                    <div class="col-12 reserve_print_popup_header">
	                        <div class="reserve_print_header_title">
	                            <c:out value="${result.concertTitle}"/>
	                        </div>
	                        <div class="reserve_print_header_subtitle">
	                            예약이 완료되었습니다.
	                        </div>
	                        <hr class="reserve_print_header_seperate_line">
	                        <div class="reserve_print_header_user_info">
	                            예약하신 아이디는 <span class="point0">${userVO.userId}</span> 입니다.
	                        </div>
	                        <div class="reserve_print_header_desc">
	                            예약하신 공연날짜를 꼭 확인해주시고, 아래의 출력버튼을 이용해 티켓을 출력해주세요.
	                        </div>
	                    </div>
	                    <div class="col-12 mb25 reserve_send_type_select">
	                        <div class="popup_check_style_0_wrap">
	                            <!-- <span class="popup_check_style_0_con">
	                                <input type="checkbox" id="reserve_send_type_message" class="popup_check_style_0" value="0" checked>
	                                <label for="reserve_send_type_message">예약정보를 문자로 수신받겠습니다.</label>
	                            </span> -->
	                                <span class="popup_check_style_0_con">
	                                <input type="checkbox" id="reserve_send_type_mail" class="popup_check_style_0" value="1" checked>
	                                <label for="reserve_send_type_mail">예약정보를 메일로 수신받겠습니다.</label>
	                            </span>
	                        </div>
	                    </div>
	                    <div class="col-12 mb65 popup_util_btn_con">
	                        <a href="/edu/forPrintTicket.jsp" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기" class="popup_util_btn_style black">
	                            출력
	                        </a>
	                        <a href="javascript:void(0);" class="popup_util_btn_style" id="step4CompleteBtn">
	                            확인
	                        </a>
	                    </div>
	                    <div class="col-12 reserve_print_contents" id="ticketPrint"> 
	                        <div class="reserve_print_logo">
	                            <img src="/edu/images/bm/testbed_black_logo.png" alt="콘텐츠문화광장 로고">
	                        </div>
	                        <div class="reserve_printing_time">
	                            <span id="reservRegDateTime"></span>
	                        </div>
	                        <div class="reserve_printing_article first">
	                            <div class="reserve_printing_name">
	                                [총인원 <span class="point2" id="selectedMemberCnt"></span>명] 예약자 : <span class="point2">${userVO.userNm}</span>
	                            </div>
	                            <div class="reserve_printing_title">
	                                <c:out value="${result.concertTitle}"/>
	                            </div>
	                            <div class="reserve_printing_date">
	                                <span id="selectedDate"></span> <span id="selectedStartTime"></span> ~ <span id="selectedEndTime"></span>
	                            </div>
	                            <div class="reserve_printing_seat">
	                                ${result.concertPlace} / <span class="point2" id="selectedSitList"></span>
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
	                                    인터넷 변경ㆍ취소
	                                </p>
	                                관람일 전일 23시까지 가능 (주말, 공휴일의 경우 그전일 23시까지 가능) 
	                            </div>
	                            <div class="reserve_printing_desc">
	                                <p class="reserve_printing_desc_title">
	                                    전화 변경ㆍ취소
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
	                            <img id="qrcodeImg" src="/edu/images/bm/reserve_printing_qrcode.png" alt="공연 예매 QRcode">
	                        </div>
	                        <div class="reserve_printing_thanks_too">
	                            저희 콘텐츠문화광장을 이용해 주셔서 감사합니다.
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-12 popup_dim"></div>
	</div>
	<!-- //popup03 -->
	
	<!-- popup alert -->
	<div class="col-12 popup_wrap" style="display: none;">
	    <div class="col-12 col-center popup_con popup_alarm_style">
	    	<div class="popup_alarm_wrap">
	    		<div class="popup_alarm_con">
					<div class="popup_alarm">
						<div class="popup_alarm_title_con">
							<div class="popup_alarm_title">
								<span class="icon_box">
									<img src="/edu/images/bm/popup_alarm_icon.png" alt="알림">
								</span>
								<span class="popup_alarm_title_text">
									알림
								</span>
							</div>
							<div class="popup_alarm_close">
								<img src="/edu/images/bm/popup_alarm_close_btn.png" alt="닫기">
							</div>
						</div>
						<div class="popup_alarm_text_box">
							<div class="popup_alarm_text">
								공연예약에 실패하였습니다.<br/>
								좌석 및 입력내용을 다시한번 확인해주세요
							</div>
							<div class="popup_alarm_btn_con">
								<a href="javascript:void(0)" class="popup_alarm_btn_style_0 gray">
									취소
								</a>
								<a href="javascript:void(0)" class="popup_alarm_btn_style_0">
									확인
								</a>
							</div>
						</div>
					</div>
				</div>
	        </div>
	    </div>
	    <div class="col-12 popup_dim"></div>
	</div>
	<!-- //popup alert -->

