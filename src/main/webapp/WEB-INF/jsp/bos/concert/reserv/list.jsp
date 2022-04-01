<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.testbed.concert.service.ConcertMngService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<%-- <c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/> --%>

<script type="text/javascript">


var printTemplate;
$(function() {
	
	printTemplate = $("[data-wv-template]")[0].outerHTML;
	$("[data-wv-template]").remove();
	
	//rsg20180328
	var urlGetParam = "&concertId=<c:out value="${param.concertId}"/>&concertTimeId=<c:out value="${param.concertTimeId}"/>";
	$(".paging .pagination li a").each(function(){
		var href = $(this).attr("href")+urlGetParam;
		$(this).attr( "href", href );
	});
	
});

//선택 참석여부 변경
function changeSelectedStatus(){
	var reservCodeList = $(".chckboxReserv:checked").map(function() { return this.value; }).get().join(',');

	if ( $(".chckboxReserv:checked").length == 0 ){
		alert("참석여부를 변경할 예약을 선택해주세요.");
		return;
	}
	
	if ( confirm("선택된 예약을 모두 참석으로 바꾸시겠습니까?") ){
		
		var submitParam = { "statusType" : "join", "status" : 1, "reservCodeList": reservCodeList, "concertId" : $("#concertId").val(), "concertTimeId" : $("#concertTimeId").val() }; 
		$.get("/bos/concert/reserv/changeSelectedStatus.json" , submitParam , function(result) {
			if (result.resultCode == "success") {
				location.reload();
			}
		},"json");
	}
		
}

	
//예약내역출력
function printReservTicketList(){
	
	
	var checkMasterCodeList = [];
	$("[name=etc]").each(function(){
		if( $(this).is(":checked") ){
			checkMasterCodeList.push( $(this).val() );
		}
	})
	
	if( checkMasterCodeList.length == 0 ){
		alert( "출력을 원하시는 예약 항목을 선택해주세요." );
		return;
	}
	

	var url = "/bos/concert/reserv/getMasterInfoList.json";
	var params = {
		"checkMasterCodeList[]" : checkMasterCodeList
	};
	
	
	$.get(url, params, function(data) {
		if (data && data.resultList ) {
			$( "#ticketPrint" ).empty();
			
			
			var len = data.resultList.length;
			var reservMasterInfo;
			var printEl;
			for( var i=0; i<len; i++ ){
				reservMasterInfo = data.resultList[i];
				printEl = $(printTemplate).appendTo( $("#ticketPrint")[0] );
				
				$(printEl).find(".reservRegDateTime").text( reservMasterInfo.regDateToChar );
				$(printEl).find(".sitCountInfo").text( reservMasterInfo.sitCount );
				$(printEl).find(".memberNameInfo").text( reservMasterInfo.memberName );
				$(printEl).find(".concertTitle").text( reservMasterInfo.concertTitle );
				
				$(printEl).find(".startDate").text( reservMasterInfo.startDate );
				$(printEl).find(".startDay").text( reservMasterInfo.startDay );
				$(printEl).find(".startTime").text( reservMasterInfo.startTime );
				$(printEl).find(".endTime").text( reservMasterInfo.endTime );

				$(printEl).find(".concertPlace").text( reservMasterInfo.concertPlace );
				$(printEl).find(".sitInfo").text( reservMasterInfo.sitInfo );
				
				$(printEl).find(".qrcodeImg").attr("src","/testbed/concert/info/createQrCode.do?content="+ reservMasterInfo.reservMasterCode );
			}
		}
	},"json");
	
	window.open( "/edu/forPrintTicketList.jsp", "printPage', 'width=800,height=550,scrollbars,toolbar,status");
}

//공통 코드목록 화면처리
function getCodeList(elemntId, codeId, upperCode, depth, code) {
	var $obj = $("#"+ elemntId);
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};
	$.get(url, params, function(data) {
		if (data) {
			$obj.empty();
			$("<option>").text("분류 선택").attr("value","").appendTo($obj);
			$.each(data.list, function(key,item) {
				var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
				if (code == item.code) $codeItem.attr("selected",true);
				$codeItem.appendTo($obj);
			});
			if ("prgCl" == elemntId && "" == upperCode) {
				$("<option>").text("분류 선택").attr("value","").appendTo($("#prgCl").empty());
			}
		}
	},"json");
}

</script>

<h4>■ 예약현황</h4>
<style type="text/css">
.bdView table th{min-width:auto;}
</style>
<div class="bdView">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col span="3">
		<col>
		<col>
		<col>
		<col span="10">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2">총좌석</th>
				<th scope="col" rowspan="2">온라인예약</th>
				<th scope="col" rowspan="2">전화예약</th>
				<th scope="col" rowspan="2">현장예약　</th>
				<th scope="col" rowspan="2">남은좌석　</th>
				<th scope="col" rowspan="2">예매율　</th>
				<th scope="col" colspan="2">성별</th>
				<th scope="col" colspan="6">나이</th>
			</tr>
			<tr>
				<th scope="col">남</th>
				<th scope="col">여</th>
				<th scope="col">10대</th>
				<th scope="col">20대</th>
				<th scope="col">30대</th>
				<th scope="col">40대</th>
				<th scope="col">50대</th>
				<th scope="col">60대이상</th>
			<!-- 
			<tr>
				<th scope="col" colspan="2"></th>
				<th scope="col" colspan="4">나이</th>
			</tr>
			<tr>
				<th scope="col">남</th>
				<th scope="col">여</th>
				<th scope="col">20대</th>
				<th scope="col">30대</th>
				<th scope="col">40대</th>
				<th scope="col">50대</th>
			</tr>
			 -->
		</thead>
		<tbody>
			
				<tr>
					<td>${concertReservStatus.reservOnlineSitNum}</td>
					<td>${concertReservStatus.onlineValue}</td>
					<td>${concertReservStatus.telValue}</td>
					<td>${concertReservStatus.offlineValue}</td>
					<td>${concertReservStatus.remainSitNum}</td>
					<td><fmt:formatNumber value="${concertReservStatus.reservRate}" pattern="0.00"/> %</td>
					<td>${concertReservStatus.men}</td>
					<td>${concertReservStatus.women}</td>
					<td>${concertReservStatus.age10}</td>
					<td>${concertReservStatus.age20}</td>
					<td>${concertReservStatus.age30}</td>
					<td>${concertReservStatus.age40}</td>
					<td>${concertReservStatus.age50}</td>
					<td>${concertReservStatus.age60}</td>
				</tr>
		</tbody>
	</table>
</div>



<h4>■ 검색</h4>

<form id="frm" name="frm" method="post" action="/bos/concert/reserv/list.do?menuNo=${param.menuNo}" class="form-inline">
	<input type="hidden" name="siteSe" value="${param.siteSe}" >
	<input type="hidden" name="concertId" id="concertId" value="${param.concertId}" >
	<input type="hidden" name="concertTimeId" id="concertTimeId" value="${param.concertTimeId}" >
	<fieldset>
		<legend></legend>
			<div class="bdView mb0">
				<table class="table table-bordered">
					<caption>
					</caption>
					<colgroup>
					<col span="3">
					<col>
					</colgroup>
					<tbody>
						<tr>
							<th>
								<select id="searchType" name="searchType" title="">
									<option value="userId">아이디</option>
									<option value="memberName">이름</option>
								</select>
							</th>
							<td>
								<input type="text" name="searchTxt" value="${param.searchTxt}">
							</td>
							<th><label for="mbtlnum">연락처</label></th>
							<td><input type="text" name="mbtlnum" id="mbtlnum" value="${param.mbtlnum}"></td>
							<%-- 
							 --%>
						</tr>
						<tr>
							<th>예약구분</th>
							<td colspan="3">
								<label for="reservPath1"> <input type="radio" name="reservPath" value="0" ${param.reservPath == 0 ? "checked='checked'" : ""} id="reservPath1">온라인</label>
								<label for="reservPath3"> <input type="radio" name="reservPath" value="1" ${param.reservPath == 1 ? "checked='checked'" : ""} id="reservPath3">현장</label>
								<label for="reservPath2"> <input type="radio" name="reservPath" value="2" ${param.reservPath == 2 ? "checked='checked'" : ""} id="reservPath2">전화</label>
							</td>
						</tr>
					</tbody>  
				</table>
			</div>
			<div class="btnSet">
				<input type="submit" class="btn btn-primary" value="검색" />
				<%-- 
				<a class="btn btn-primary" href="/bos/concert/reserv/forInsert.do?${pageQueryString}"><span>공연 등록</span></a>
				 --%>
			</div>
	</fieldset>
</form>



<h4>■ 예약리스트</h4>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width: 40px;">
		<col>
		<col style="width: 80px;">
		<col style="width: 66px;">
		<col style="width: 131px;">
		<col style="width: 131px;">
		<col style="width: 66px;">
		<col style="width: 80px;">
		<col>
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>예약넘버</th>
				<th>아이디</th>
				<th>이름</th>
				<th>연락처</th>
				<th>좌석</th>
				<th>예약구분</th> 
				<th>참석</th> 
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="tac">
						<input type="checkbox" name="etc" id="authCheck${status.index}" class="chckboxReserv" value="${result.reservMasterCode}" />
						<%-- ${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))} --%>
					</td>
					<td><a href="/bos/concert/reserv/view.do?reservMasterCode=${result.reservMasterCode}&concertTimeId=${param.concertTimeId}&concertId=${param.concertId}&${pageQueryString}">
						${result.reservMasterCode}</a></td>
					<td><a href="/bos/concert/reserv/view.do?reservMasterCode=${result.reservMasterCode}&concertTimeId=${param.concertTimeId}&concertId=${param.concertId}&${pageQueryString}" >
						${(not empty result.userId ? result.userId : '없음')}</a></td>
					<td class="tac"><a href="/bos/concert/reserv/view.do?reservMasterCode=${result.reservMasterCode}&concertTimeId=${param.concertTimeId}&concertId=${param.concertId}&${pageQueryString}">
						${result.memberName}</a></td> 
					<td>${result.memberTel}</td>
					<td>${result.sitIdList}</td>
					<td>
						<c:choose>
							<c:when test="${result.reservPath eq '0' }">온라인</c:when>
							<c:when test="${result.reservPath eq '1' }">현장</c:when>
							<c:when test="${result.reservPath eq '2' }">전화</c:when>
						</c:choose>
					</td>
					<td class="tdJoinStatus">
						<c:choose>
							<c:when test="${result.joinStatus eq '0' }">X</c:when>
							<c:when test="${result.joinStatus eq '1' }">O</c:when>
						</c:choose>
					</td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="11">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="fl">
	<a class="btn btn-primary" id="" href="javascript:changeSelectedStatus();"><span>선택 참석 변경</span></a>
	<a class="btn btn-primary" id="" href="javascript:printReservTicketList();" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><span>예약내역출력</span></a>
	<a class="btn btn-primary" href="/bos/concert/reserv/viewTempReservMember.do?menuNo=${param.menuNo}&concertId=${param.concertId}&concertTimeId=${param.concertTimeId}&${pageQueryString}" alt="예약대기명단 보기"><span>예약대기명단</span></a>
	<a class="btn btn-primary" href="/bos/concert/reserv/reservExcelDownload.xls?concertId=${param.concertId}&concertTimeId=${param.concertTimeId}&${pageQueryString}" alt="예약명단엑셀다운"><span>예약명단엑셀다운</span></a>
</div>

<div class="btnSet">
	<a class="btn btn-primary" href="/bos/concert/reserv/forInsert.do?concertId=${param.concertId}&concertTimeId=${param.concertTimeId}&${result.concertTimeId}${pageQueryString}"><span>등록하기</span></a>
	<a class="btn btn-primary" href="/bos/concert/time/list.do?concertId=${param.concertId}&${pageQueryString}"><span>목록</span></a>
	<%-- 
	<a class="btn btn-primary" href="/bos/concert/time/forInsert.do?${pageQueryString}"><span>공연일정 등록</span></a>
	 --%>
</div>

<%-- 
<div class="btn_set">
	<a class="btn btn-success" href="/bos/concert/info/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
</div> 
 --%>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paginationSet">
			${pageNav}
		</div>
	</div>
</c:if>






<!-- 프린트를 위한 영역 -->
<div class="col-12 sub_contents_view_location" style="max-width: 616px; margin: auto; float:none; display:none; ">

	<div id="ticketPrint">
		<div class="col-12 reserve_print_contents mt30" data-wv-template> 
		    <div class="reserve_print_logo">
		        <img src="/edu/images/bm/testbed_black_logo.png" alt="콘텐츠문화광장 로고">
		    </div>
		    <div class="reserve_printing_time">
		        <span class="reservRegDateTime"></span>
		    </div>
		    <div class="reserve_printing_article first">
		        <div class="reserve_printing_name">
		            [총인원 <span class="point2 sitCountInfo"></span>명] 예약자 : <span class="point2 memberNameInfo"></span>
		        </div>
		        <div class="reserve_printing_title concertTitle">
		            
		        </div>
		        <div class="reserve_printing_date">
		            <span class="selectedDate startDate"> </span> (<span class="startDay"></span>) <span class="selectedStartTime startTime"></span> ~ <span class="selectedEndTime endTime"></span>
		        </div>
		        <div class="reserve_printing_seat">
		            <span class="concertPlace"></span> / <span class="point2 sitInfo"></span>
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
		        <img class="qrcodeImg" alt="공연 예매 QRcode">
		    </div>
		    <div class="reserve_printing_thanks_too">
		        저희 콘텐츠문화광장을 이용해 주셔서 감사합니다.
		    </div>
		</div>
	</div>
	
</div>

