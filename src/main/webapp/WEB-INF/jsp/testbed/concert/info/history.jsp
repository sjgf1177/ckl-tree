<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.testbed.concert.service.ConcertMngService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>


<script type="text/javascript" src="/edu/js/concert/Dom.js"></script>
<script type="text/javascript" src="/edu/js/concert/ProgressBar.js"></script>
<script type="text/javascript" src="/edu/js/concert/Form.js"></script>
<script type="text/javascript" src="/edu/js/concert/Number.js"></script>
<script type="text/javascript" src="/edu/js/concert/String.js"></script>
<script type="text/javascript" src="/edu/js/concert/Calendar.js"></script>
<script type="text/javascript" src="/edu/js/concert/DatePicker.js"></script>

<script type="text/javascript" src="/edu/js/concert/historyReserv.js"></script>


<c:if test="${userVO.userIdx eq '0' }">
	<form class="login_form" name="loginFormDetail" id="loginFormDetail" action="/edu/member/forLogin.do?menuNo=500077" method="post" style="display:none;">
		<input type="hidden" name="redirectUrl" value="/${paramVO.siteName}/concert/info/history.do?menuNo=${paramVO.menuNo}" />
	</form>
	
	<script>
	
	$(function(){
		
		if ( confirm("로그인 페이지로 이동합니다.") ){
			var $form = $("#loginFormDetail"); 
			$form.submit();
		} else {
			history.back();
		}
		
	});
		
	</script>
</c:if>
<c:if test="${userVO.userIdx ne '0' }">
<script>
$(function(){

	
	$(".paginationSet").find("li>a").each(function(){
		var searchType = '${param.searchType}';
		var periodSelectDate = '${param.periodSelectDate}';
		if( !searchType && !periodSelectDate ){
			searchType = 'periodSearch';
			periodSelectDate = 3;
		}
		
		var url = $(this).attr("href") + "&searchType="+searchType+"&periodSelectDate="+periodSelectDate;
		$(this).attr("href", url );
	})
	
	
	
	$("#view_by_date").on("click", function(){
		$("#periodSearchCon").hide();
		$("#datelySearchCon").show();
	});
	
	$("#view_by_period").on("click", function(){
		$("#periodSearchCon").show();
		$("#datelySearchCon").hide();
	})
	
	
	bm.datepicker.syncDatePicker();
	
});


function datelySearchSubmit(){

	
	var sdateValue = $("[name=sdate]").val();
	sdateValue = sdateValue.replace( /-/gi, '' );
	sdateValue = parseInt( sdateValue );
	if( !sdateValue ){
		alert("검색 시작일을 설정해주세요.");
		return;
	}
	
	var edateValue = $("[name=edate]").val();
	edateValue = edateValue.replace( /-/gi, '' );
	edateValue = parseInt( edateValue );
	if( !edateValue ){
		alert("검색 종료일을 설정해주세요.");
		return;
	}	
	
	if( edateValue < sdateValue ){
		alert( "검색을 원하는 시작일이 종료일보다 미래로 설정되어 있습니다. ");
		return;
	}
	
	$('#pageIndex').val(1); 
	$("#historyFilter").submit();
	
}

//기간별 조회 클릭
function setPeriodDate( obj ) {
	$("[name='periodSelectDate']").val( $(obj).val() );
	
	$("#pageIndex").val(1);
	$("#historyFilter").submit();
}


function moveReviewForInsert(reservMasterCode){
	$("#forInstertMoveForm input[name=reservMasterCode]").val( reservMasterCode );
	var concertTitle = $("[data-reserv-master-code='"+reservMasterCode+"']")[0].innerHTML;
	
	$("#forInstertMoveForm input[name=concertTitle]").val( concertTitle );
	$("#forInstertMoveForm").submit();
}

</script>

<form name="forInstertMoveForm" method="post" id="forInstertMoveForm" action="/${paramVO.siteName}/bbs/B0000070/forInsert.do">
<!-- kjh test 모바일 분기 필요 -->
<input type="hidden" name="menuNo" value="${paramVO.siteName eq 'testbed'? '700129':'' }"/>
<input type="hidden" name="reservMasterCode" value=""/>
<input type="hidden" name="concertTitle" value=""/>
</form>

	<div class="fontsize0 sub_contents_body sub_board_wrap">
		<div class="col-12 mb36 testbed_board_title">
		    <span class="point0">${userVn.userNm}</span> 고객님의 예약정보를 확인 하실 수 있습니다.
		</div>
		<div class="col-12 mb65 board_search_list_wrap">
			<form action="/${paramVO.siteName}/concert/info/history.do?menuNo=${paramVO.menuNo}" method="post" id="historyFilter">
				<%-- <input type="hidden" name="pageQueryString" value='<c:out value="${pageQueryString }" escapeXml="false"/>' > --%>
				<input type="hidden" name="pageIndex" id="pageIndex" value='<c:out value="${paramVO.pageIndex }" escapeXml="false"/>' >
				<input type="hidden" name="periodSelectDate" id="periodSelectDate" value='<c:out value="${paramVO.periodSelectDate }" escapeXml="false"/>' >
				<input type="hidden" name="pageQueryString" value="${pageQueryString}&searchType=${paramVO.searchType}&periodSelectDate=${paramVO.periodSelectDate}">
			    <div class="radio_box_wrap">
			        <div class="radio_box_con">
			            <input type="radio" id="view_by_period" class="radio_style_0" name="searchType" value="periodSearch" <c:if test="${paramVO.searchType ne 'datelySearch'}">checked</c:if>>
			            <label for="view_by_period">기간별 조회</label>
			        </div>
			        <div class="radio_box_con">
			            <input type="radio" id="view_by_date" class="radio_style_0" name="searchType" value="datelySearch" <c:if test="${paramVO.searchType eq 'datelySearch'}">checked</c:if>>
			            <label for="view_by_date">일자별 조회</label>
			        </div>
			    </div>
			    <div class="view_by_period_search_con" id="periodSearchCon" style="display:none; <c:if test="${paramVO.searchType ne 'datelySearch'}">display:block;</c:if>">
			        <div class="view_by_period_item_con">
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 3}">on</c:if>" onclick="setPeriodDate(this); return false;" value="3">3일</button>
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 7}">on</c:if>"  onclick="setPeriodDate(this); return false;" value="7">7일</button>
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 15}">on</c:if>"  onclick="setPeriodDate(this); return false;" value="15">15일</button>
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 30}">on</c:if>"  onclick="setPeriodDate(this); return false;" value="30">1개월</button>
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 90}">on</c:if>"  onclick="setPeriodDate(this); return false;" value="90">3개월</button>
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 180}">on</c:if>" onclick="setPeriodDate(this); return false;" value="180">6개월</button>
			        	<button class="view_by_period_item <c:if test="${paramVO.periodSelectDate eq 365}">on</c:if>"  onclick="setPeriodDate(this); return false;" value="365">1년</button>
			        </div>
			    </div>
				<div class="view_by_period_search_con type_2" id="datelySearchCon" style="display:none; <c:if test="${paramVO.searchType eq 'datelySearch'}">display:block;</c:if>">
					<div class="view_by_period_item_con">
					    <div class="select_style_2_wrap">
					        <div class="select_style_2_con testbed_style">
					            <select name="searchCnd" id="searchCnd" class="select_style_2" title="조회 기준 선택">
					                <option value="regDate" <c:if test="${paramVO.searchCnd ne 'joinDate'}">selected</c:if>>예매일</option>
					                <option value="joinDate" <c:if test="${paramVO.searchCnd eq 'joinDate'}">selected</c:if>>관람일</option>
					            </select>
					            <!-- <label for=""></label> -->
					        </div>
					    </div>
					    <hr class="view_by_date_seperate_line">
					    <div class="show-md">
						    <div class="view_by_date_calendar_con">
						        <a href="javascript:void(0)" class="view_by_date_calendar_icon">
						            <img src="/edu/images/bm/view_by_date_calendar_icon.png" alt="시작일 선택">
						        </a>
						    	<input type="text" class="view_by_date_calendar_text" name="sdate" value="${param.sdate}" data-datepicker>
							</div>
							<div class="view_by_date_calendar_dash">-</div>
							<div class="view_by_date_calendar_con">
							    <a href="javascript:void(0)" class="view_by_date_calendar_icon">
							        <img src="/edu/images/bm/view_by_date_calendar_icon.png" alt="종료일 선택">
							    </a>
					            <input type="text" class="view_by_date_calendar_text" name="edate" value="${param.edate}" data-datepicker>
					        </div>
				        </div>
				        <hr class="view_by_date_seperate_line last_seperate_line">
				    </div>
				    <button class="view_type_select_btn" onclick="datelySearchSubmit(); return false;">
				        <span class="view_type_select_btn_text">
				            검색
				        </span>
				        <span class="view_type_select_btn_icon">
				        	<image src="/edu/images/bm/view_type_select_icon.png" alt="검색 아이콘">
				        </span>
				    </button>
				</div>
			</form>
		</div>
		<div class="col-12 mb25 testbed_board_header">
		    <ul class="fl list_style_2">
		        <li>공연 예약내역</li>
		    </ul>
		    <div class="fr testbed_board_caption">
		        <span class="point0">* 상세/변경/취소 버튼</span>을 통해 예매내역 상세확인 및 취소,변경이 가능합니다.
		    </div>
		    <%-- <div class="col-5 show-tablecell fn vm board_title">
			    <h4>총 <span class="board_count"><c:out value="${resultCnt}" />개</span>의 공연정보</h4>
			</div> --%>
		</div>
		<div class="col-12 sub_board_body">
		${resultCount }${resultCnt }
		    <table class="board_type_0 small color_gray">
		        <caption>(콘텐츠 문화광장) 공연 예매내역 목록</caption>
		        <colgroup>
		            <col width="15%" class="web_table_column">
		            <col width="auto">
		            <col width="12%" class="web_table_column_12">
		            <col width="10%" class="web_table_column">
		            <col width="14%" class="web_table_column">
		            <col width="70px">
		            <col width="70px">
		            <col width="70px">
		        </colgroup>
		        <thead>
		        <tr>
		            <th scope="col" class="web_table_cell">예매일</th>
		            <th scope="col">공연명</th>
		            <th scope="col">관람일시</th>
		            <th scope="col" class="web_table_cell">좌석</th>
		            <th scope="col" class="web_table_cell">장소</th>
		            <th scope="col">상태</th>
		            <th scope="col">관리</th>
		            <th scope="col">리뷰</th>
		        </tr>
		        </thead>
		        <tbody>
		        <c:forEach var="result" items="${resultList}" varStatus="status">
		        <tr>
		            <td class="web_table_cell">${result.regDate}</td>
		            <td class="title_cell" data-reserv-master-code="${result.reservMasterCode}"><c:out value="${result.concertTitle}"/></td>
		            <td>${result.startTimeStr}</td>
		            <td class="web_table_cell"><c:if test="${ result.reservStatus ne 1}">-</c:if><c:if test="${ result.reservStatus ne 0}">${result.sitInfo }</c:if></td>
		            <td class="web_table_cell">${result.concertPlace }</td>
		            <td>
		            	<c:if test="${ result.reservStatus ne 0}">
			            	<c:choose>
				            	<c:when test="${result.canCancel eq 1}">
				            		<a href="javascript:historyReserv.cancelReserv( ${result.reservMasterCode} )" class="movie_delete_on">취소</a>
				            	</c:when>
				            	<c:when test="${result.canCancel ne 1}">
				            		<span class="movie_delete_complete">완료</span>
				            	</c:when>
			            	</c:choose>
		            	</c:if>
		            	<c:if test="${ result.reservStatus eq 0}">
		            		<span class="movie_delete_end_on">취소</span>
	            		</c:if>
		            </td>
		            <td><c:if test="${ result.reservStatus ne 0}">
		                <a href="/${paramVO.siteName}/concert/info/historyview.do?menuNo=${param.menuNo}&reservMasterCode=${result.reservMasterCode}&${pageQueryString}" class="movie_detail_btn">
		                    상세
		                </a>
		                </c:if>
		            </td>
		            <!-- mobile 분기 필요 : 컬럼 삭제 -->
		            <td>
		            	<c:if test="${ result.joinStatus eq 1}">
		            		<a href="javascript:moveReviewForInsert( ${result.reservMasterCode} );" class="movie_detail_btn">
			                    리뷰
			                </a>
	            		</c:if>
		            </td>
		        </tr>
		        </c:forEach>
		        <c:if test="${fn:length(resultList) == 0 }">
		        <tr>
		        	<td colspan="8" class="Concertinfo_historTable_td">
		        		예매내역이 없습니다.
		        	</td>
		        </tr>
		        </c:if>
	<!-- 	        <tr> -->
	<!-- 	            <td class="web_table_cell">2017.08.05</td> -->
	<!-- 	            <td class="title_cell">데이드림 - Day Dream</td> -->
	<!-- 	            <td>2017.08.05</td> -->
	<!-- 	            <td class="web_table_cell">R13, R14</td> -->
	<!-- 	            <td class="web_table_cell">콘텐츠문화광장 66</td> -->
	<!-- 	            <td> -->
	<!-- 	                <a href="javascript:void(0)" class="movie_delete_complete"> -->
	<!-- 	                    [완료] -->
	<!-- 	                </a> -->
	<!-- 	            </td> -->
	<!-- 	            <td> -->
	<!-- 	                <a href="javascript:void(0)" class="movie_detail_btn"> -->
	<!-- 	                    상세 -->
	<!-- 	                </a> -->
	<!-- 	            </td> -->
	<!-- 	            <td> -->
	<!-- 	                <a href="javascript:void(0)" class="movie_detail_btn"> -->
	<!-- 	                    수정 -->
	<!-- 	                </a> -->
	<!-- 	            </td> -->
	<!-- 	        </tr> -->
	<!-- 	        <tr> -->
	<!-- 	            <td class="web_table_cell">2017.08.05</td> -->
	<!-- 	            <td class="title_cell">데이드림 - Day Dream</td> -->
	<!-- 	            <td>2017.08.05</td> -->
	<!-- 	            <td class="web_table_cell">R13, R14</td> -->
	<!-- 	            <td class="web_table_cell">콘텐츠문화광장 66</td> -->
	<!-- 	            <td> -->
	<!-- 	                <a href="javascript:void(0)" class="movie_delete_end_on"> -->
	<!-- 	                    [취소] -->
	<!-- 	                </a> -->
	<!-- 	            </td> -->
	<!-- 	            <td> -->
	<!-- 	                <a href="javascript:void(0)" class="movie_detail_btn"> -->
	<!-- 	                    상세 -->
	<!-- 	                </a> -->
	<!-- 	            </td> -->
	<!-- 	            <td> -->
	<!-- 	                - -->
	<!-- 	            </td> -->
	<!-- 	        </tr> -->
		        </tbody>
		    </table>
		</div>
		<div class="mb70">
			<c:if test="${fn:length(resultList) > 0}">
				<div class="paging" style="font-size:36px; line-height:42px;">
					<div class="paginationSet">
						${pageNav}
					</div>
				</div>
			</c:if>
		</div>
		<ul class="col-12 mb45 list_style_2">
		    <li>예약 변경 안내</li>
		</ul>
		<div class="col-12 mb40 testbed_movie_board_desc">
		    <div class="testbed_num_list">
		        1
		    </div>
		    <div class="testbed_movie_board_desc_text_box">
		        <div class="testbed_movie_board_desc_title">
		            변경, 취소 규정
		        </div>
		        <div class="testbed_movie_board_desc_text">
		            <span class="testbed_movie_board_desc_head">
		                인터넷 변경·취소 :
		            </span>
		             관람일 전일 23시까지 가능 (주말, 공휴일의 경우 그전일 23시까지 가능)
		        </div>
		        <div class="testbed_movie_board_desc_text last">
		            <span class="testbed_movie_board_desc_head">
		                전화 변경·취소 :
		            </span>
		             인터넷 예약이 불가능한 경우 담당자 문의를 통해 변경가능
		        </div>
		        <table class="mt17 contents_insight_view style_2 is_side_border_none">
		            <caption>예매변경 취소 규정</caption>
		            <colgroup>
		                <col width="20%">
		                <col width="auto">
		            </colgroup>
		            <tbody>
		            <tr>
		                <th>티켓매니저</th>
		                <td class="color_gray">02-6310-0735</td>
		            </tr>
		            </tbody>
		        </table>
		    </div>
		</div>
		<div class="col-12 testbed_movie_board_desc last">
		    <div class="testbed_num_list">
		        2
		    </div>
		    <div class="testbed_movie_board_desc_text_box">
		        <div class="testbed_movie_board_desc_title">
		            유의사항
		        </div>
		        <div class="reserve_printing_desc">
		            <p class="reserve_printing_desc_title">
		                1) 예약 유효 시간
		            </p>
		            <ul class="popup_list_style_2">
		                <li>티켓은 공연 1시간 전부터 문화광장 내 박스오피스에 오셔서 배부 받을 수 있습니다. </li>
		                <li>사전예약을 하셨더라도 공연 15분 전까지 미수령 시 예약이 취소되며, 이후에 오시면 현장 대기 순으로 티켓을 배부 받습니다.</li>
		            </ul>
		        </div>
		        <div class="reserve_printing_desc">
		            <p class="reserve_printing_desc_title">
		                2) 티켓 현장 배부
		            </p>
		            <ul class="popup_list_style_2">
		                <li>예약하지 않은 관객은 객석의 여유가 있을 경우, 공연 1시간 전부터 티켓을 배부 받습니다.</li>
		            </ul>
		        </div>
		    </div>
		</div>
	</div>
	
	<iframe name="ssoAuthFrame" id="ssoAuthFrame" style="width:0px;height:0px;border:0;" src="${ssoDomain }/sso/member/checkSSO.do?service=edu&amp;menuNo=<c:out value="${paramVO.menuNo }" />&amp;userTp=<c:out value="${userVO.userIdx }" />" title="SSO 로그인 유무확인 프레임 입니다."></iframe>

</c:if>