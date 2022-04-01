<%@page contentType="text/html;charset=utf-8" %>

<!-- rsg20170901 -->
<%
//rsg20170901
String showViewNo = (String)request.getParameter("showViewNo") != null && (String)request.getParameter("showViewNo") != "" ? (String)request.getParameter("showViewNo") : "0" ;
%>

<div class="fontsize0 sub_contents_body sub_board_wrap">
	<div class="col-12 mb36 testbed_board_title">
	    <span class="point0">홍길동</span> 고객님의 예약정보를 확인 하실 수 있습니다.
	</div>
	<div class="col-12 mb65 board_search_list_wrap">
	    <div class="radio_box_wrap">
	        <div class="radio_box_con">
	            <input type="radio" id="view_by_period" class="radio_style_0" name="view_type_select">
	            <label for="view_by_period">기간별 조회</label>
	        </div>
	        <div class="radio_box_con">
	            <input type="radio" id="view_by_date" class="radio_style_0" name="view_type_select" checked>
	            <label for="view_by_date">일자별 조회</label>
	        </div>
	    </div>
	    <!-- 기간별 조회 클릭 시 view_by_period_search_con.type_1 display:block; type_2는 display:none; -->
	    <!-- 일자별 조회 클릭 시 view_by_period_search_con.type_2 display:block; type_1는 display:none; -->
	    <div class="view_by_period_search_con" style="display:none;">
	        <div class="view_by_period_item_con">
	            <div class="view_by_period_item">
	                3일
	            </div>
	            <div class="view_by_period_item">
	                7일
	            </div>
	            <div class="view_by_period_item">
	                15일
	            </div>
	            <div class="view_by_period_item">
	                1개월
	            </div>
	            <div class="view_by_period_item">
	                3개월
	            </div>
	            <div class="view_by_period_item">
	                6개월
	            </div>
	            <div class="view_by_period_item">
	                1년
	            </div>
	        </div>
	        <!-- <div class="view_type_select_btn">
	            <span class="view_type_select_btn_text">
	                검색
	            </span>
	            <span class="view_type_select_btn_icon">
	                <img src="/edu/images/bm/view_type_select_icon.png" alt="검색 아이콘">
	            </span>
	        </div> -->
	    </div>
		<div class="view_by_period_search_con type_2">
			<div class="view_by_period_item_con">
			    <div class="select_style_2_wrap">
			        <div class="select_style_2_con testbed_style">
			            <select name="view_by_date_search" id="" class="select_style_2">
			                <option value="">예약일</option>
			                <option value="111">111</option>
			            </select>
			            <label for=""></label>
			        </div>
			    </div>
			    <hr class="view_by_date_seperate_line">
			    <div class="view_by_date_calendar_con">
			        <a href="javascript:void(0)" class="view_by_date_calendar_icon">
			            <img src="/edu/images/bm/view_by_date_calendar_icon.png" alt="시작일 선택">
			        </a>
			        <div class="view_by_date_hidden_calendar" style="display:block;">
			<div class="calendar_style_1_wrap">
			    <div class="calendar_style_1_month_con">
			        <div class="calendar_style_1_month_inner">
			            <div class="arrow_box">
			                <img src="/edu/images/bm/calendar_month_left_arrow.png" alt="한달 전">
			            </div>
			            <div class="calendar_month_text">
			                January 2018
			            </div>
			            <div class="calendar_month_text">
			                February 2018
			            </div>
			            <div class="calendar_month_text">
			                March 2018
			            </div>
			            <div class="calendar_month_text">
			                April 2018
			            </div>
			            <div class="calendar_month_text">
			                May 2018
			            </div>
			            <div class="calendar_month_text">
			                June 2018
			            </div>
			            <div class="calendar_month_text">
			                July 2018
			            </div>
			            <div class="calendar_month_text">
			                August 2018
			            </div>
			            <div class="calendar_month_text" style="display:inline-block;">
			             September 2018
			         </div>
			         <!-- show() 말고 display:inline-block 해야됨 -->
			                    <div class="calendar_month_text">
			                        October 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        November 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        December 2018
			                    </div>
			                    <div class="arrow_box">
			                        <img src="/edu/images/bm/calendar_month_right_arrow.png" alt="한달 후">
			                    </div>
			                </div>
			            </div>
			            <table class="calendar_style_1">
			                <caption>(콘텐츠문화광장) 공연일정 선택</caption>
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
			                <tr>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date"></a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date"></a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date active">
			                            1
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            2
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            3
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            4
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            5
			                        </a>
			                    </td>
			                </tr>
			                <tr>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            6
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            7
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            8
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            9
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            10
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            11
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            12
			                        </a>
			                    </td>
			                </tr>
			                <tr>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            6
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            7
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            8
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            9
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            10
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            11
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            12
			                        </a>
			                    </td>
			                </tr>
			                <tr>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            6
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            7
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            8
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            9
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            10
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            11
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            12
			                        </a>
			                    </td>
			                </tr>
			                <tr>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            6
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            7
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            8
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            9
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            10
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            11
			                        </a>
			                    </td>
			                    <td>
			                        <a href="javascript:void(0)" class="calendar_date">
			                            12
			                        </a>
			                    </td>
			                </tr>
			                </tbody>
			            </table>
			        </div>
			    </div>
			    <input type="text" class="view_by_date_calendar_text" value="2017-08-01">
			</div>
			<div class="view_by_date_calendar_dash">-</div>
			<div class="view_by_date_calendar_con">
			    <a href="javascript:void(0)" class="view_by_date_calendar_icon">
			        <img src="/edu/images/bm/view_by_date_calendar_icon.png" alt="시작일 선택">
			    </a>
			    <div class="view_by_date_hidden_calendar">
			        <div class="calendar_style_1_wrap">
			            <div class="calendar_style_1_month_con">
			                <div class="calendar_style_1_month_inner">
			                    <div class="arrow_box">
			                        <img src="/edu/images/bm/calendar_month_left_arrow.png" alt="한달 전">
			                    </div>
			                    <div class="calendar_month_text">
			                        January 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        February 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        March 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        April 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        May 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        June 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        July 2018
			                    </div>
			                    <div class="calendar_month_text">
			                        August 2018
			                    </div>
			                    <div class="calendar_month_text" style="display:inline-block;">
			             September 2018
			         </div>
			         <!-- show() 말고 display:inline-block 해야됨 -->
			                            <div class="calendar_month_text">
			                                October 2018
			                            </div>
			                            <div class="calendar_month_text">
			                                November 2018
			                            </div>
			                            <div class="calendar_month_text">
			                                December 2018
			                            </div>
			                            <div class="arrow_box">
			                                <img src="/edu/images/bm/calendar_month_right_arrow.png" alt="한달 후">
			                            </div>
			                        </div>
			                    </div>
			                    <table class="calendar_style_1">
			                        <caption>(콘텐츠문화광장) 공연일정 선택</caption>
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
			                        <tr>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date"></a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date"></a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date active">
			                                    1
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    2
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    3
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    4
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    5
			                                </a>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    6
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    7
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    8
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    9
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    10
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    11
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    12
			                                </a>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    6
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    7
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    8
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    9
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    10
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    11
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    12
			                                </a>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    6
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    7
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    8
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    9
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    10
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    11
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    12
			                                </a>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    6
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    7
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    8
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    9
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    10
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    11
			                                </a>
			                            </td>
			                            <td>
			                                <a href="javascript:void(0)" class="calendar_date">
			                                    12
			                                </a>
			                            </td>
			                        </tr>
			                        </tbody>
			                    </table>
			                </div>
			            </div>
			            <input type="text" class="view_by_date_calendar_text" value="2017-08-30">
			        </div>
			        <hr class="view_by_date_seperate_line last_seperate_line">
			    </div>
			    <div class="view_type_select_btn">
			        <span class="view_type_select_btn_text">
			            검색
			        </span>
			        <span class="view_type_select_btn_icon">
			            <img src="/edu/images/bm/view_type_select_icon.png" alt="검색 아이콘">
			        </span>
			    </div>
			</div>
	</div>
	<div class="col-12 mb25 testbed_board_header">
	    <ul class="fl list_style_2">
	        <li>공연 예매내역</li>
	    </ul>
	    <div class="fr testbed_board_caption">
	        <span class="point0">* 상세/변경/취소 버튼</span>을 통해 예매내역 상세확인 및 취소,변경이 가능합니다.
	    </div>
	</div>
	<div class="col-12 sub_board_body">
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
	        </tr>
	        </thead>
	        <tbody>
	        <tr>
	            <td class="web_table_cell">2017.08.05</td>
	            <td class="title_cell">데이드림 - Day Dream</td>
	            <td>2017.08.05</td>
	            <td class="web_table_cell">R13, R14</td>
	            <td class="web_table_cell">콘텐츠문화광장 66</td>
	            <td>
	                <a href="javascript:void(0)" class="movie_delete_on">
	                    취소
	                </a>
	            </td>
	            <td>
	                <a href="javascript:void(0)" class="movie_detail_btn">
	                    상세
	                </a>
	            </td>
	        </tr>
	        <tr>
	            <td class="web_table_cell">2017.08.05</td>
	            <td class="title_cell">데이드림 - Day Dream</td>
	            <td>2017.08.05</td>
	            <td class="web_table_cell">R13, R14</td>
	            <td class="web_table_cell">콘텐츠문화광장 66</td>
	            <td>
	                <a href="javascript:void(0)" class="movie_delete_complete">
	                    [완료]
	                </a>
	            </td>
	            <td>
	                <a href="javascript:void(0)" class="movie_detail_btn">
	                    상세
	                </a>
	            </td>
	        </tr>
	        <tr>
	            <td class="web_table_cell">2017.08.05</td>
	            <td class="title_cell">데이드림 - Day Dream</td>
	            <td>2017.08.05</td>
	            <td class="web_table_cell">R13, R14</td>
	            <td class="web_table_cell">콘텐츠문화광장 66</td>
	            <td>
	                <a href="javascript:void(0)" class="movie_delete_end_on">
	                    [취소]
	                </a>
	            </td>
	            <td>
	                <a href="javascript:void(0)" class="movie_detail_btn">
	                    상세
	                </a>
	            </td>
	        </tr>
	        </tbody>
	    </table>
	</div>
	<div class="mb70">
		<!-- paging 추가 -->
		<div class="paging" style="font-size:36px; line-height:42px;">
			페이징 영역
		</div>
		<!-- //paging 추가 -->
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
	             공연관람일 전일 23시까지 가능 (주말, 공휴일의 경우 그전일 23시까지 가능)
	        </div>
	        <div class="testbed_movie_board_desc_text last">
	            <span class="testbed_movie_board_desc_head">
	                전화변경·취소 :
	            </span>
	             인터넷 예매가 불가능한 경우 담당자 문의를통해 변경가능
	        </div>
	        <table class="mt17 contents_insight_view style_2 is_side_border_none">
	            <caption>(콘텐츠문화광장) 예매변경 취소 규정</caption>
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
	                <li>예약하지 않은 관객은 객석의 여유가 있을 경우, 공연 1시간 전부터 티켓을 배부 받습니다.</li>
	            </ul>
	        </div>
	    </div>
	</div>
</div>
