<%@page contentType="text/html;charset=utf-8" %>

<!-- rsg20170901 -->
<%
//rsg20170901
String showViewNo = (String)request.getParameter("showViewNo") != null && (String)request.getParameter("showViewNo") != "" ? (String)request.getParameter("showViewNo") : "0" ;
%>

<div class="fontsize0 sub_contents_body sub_board_wrap">
	<div class="movie_plan_calendar_wrap"> 
        <div class="movie_plan_calendar_con">
            <div class="movie_plan_view_type_select_con">
                <div class="movie_plan_view_type_select active">
                    일별
                </div>
                <div class="movie_plan_view_type_select">
                    연/월별
                </div>
            </div>
            <div class="calendar_icon_con">
                <div class="movie_calendar_icon">
                    <img src="/edu/images/bm/movie_calendar_icon.png" alt="CALENDAR">
                </div>
                <div class="movie_calendar_icon_text">
                    CALENDAR
                </div>
            </div>
            <hr class="calendar_seperate_line">
            <div class="movie_calendar_year">
                2017년 8월 17일
            </div>
            <div class="movie_calendar_date">
                <span class="movie_calendar_date_color">
                    17
                </span>
                <span class="movie_calendar_date_text">
                    일
                </span>
            </div>
            <div class="view_by_date_calendar_con movie_plan_calendar_datepicker">
                <a href="javascript:void(0)" class="view_by_date_calendar_icon">
                    <img src="/edu/images/bm/view_by_date_calendar_icon.png" alt="시작일 선택">
                </a>
                <!--<div class="view_by_date_hidden_calendar">
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
                                &lt;!&ndash; show() 말고 display:inline-block 해야됨 &ndash;&gt;
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
                </div>-->
                <input type="text" class="view_by_date_calendar_text" value="2017-08-01">
            </div>
        </div>
        
        <!-- display:none; display:block; 컨트롤이 아니라 display:none;, display:table-cell 컨트롤 -->
        <div class="movie_plan_calendar_view_con">
            <div class="mb24 movie_plan_view_select_con">
                <div class="mr10 select_style_2_con testbed_style">
                    <select name="" id="" class="select_style_2" title="연도를 선택해 주세요">
                        <option value="2017">2017년</option>
                        <option value="2016">2016년</option>
                    </select>
                    <!-- <label for=""></label> -->
                </div>
                <div class="mr10 select_style_2_con testbed_style">
                    <select name="" id="" class="select_style_2" title="월을 선택해 주세요">
                        <option value="8">8월</option>
                        <option value="7">7월</option>
                    </select>
                    <!-- <label for=""></label> -->
                </div>
                <div class="movie_plan_view_select_btn">
                    선택
                </div>
            </div>
            <div class="calendar_style_1_wrap">
                <table class="calendar_style_1">
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
        <!-- display:none; display:block; 컨트롤이 아니라 display:none;, display:table-cell 컨트롤 -->
        <div class="movie_plan_calendar_view_con type_2" style="display:none;">
	        <div class="mb-md-57 movie_plan_view_select_con">
	            <div class="mr-md-10 select_style_2_con testbed_style">
	                <select name="" id="" class="select_style_2" title="연도를 선택해 주세요">
	                    <option value="2017">2017년</option>
	                    <option value="2016">2016년</option>
	                </select>
	                <!-- <label for=""></label> -->
	            </div>
	            <div class="select_style_2_con testbed_style">
	                <select name="" id="" class="select_style_2" title="월을 선택해 주세요">
	                    <option value="전체">전체</option>
	                    <option value="1">1월</option>
	                    <option value="2">2월</option>
	                    <option value="3">3월</option>
	                    <option value="4">4월</option>
	                    <option value="5">5월</option>
	                    <option value="6">6월</option>
	                    <option value="7">7월</option>
	                </select>
	                <!-- <label for=""></label> -->
	            </div>
	            <div class="movie_plan_view_select_btn">
	                선택
	            </div>
	        </div>
	        <div class="movie_plan_view_select_type_2_con">
	            <div class="movie_plan_view_select_title">
	                전체
	            </div>
	            <div class="movie_plan_view_month_list_con">
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        1월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        2월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        3월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        4월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        5월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        6월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        7월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        8월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        9월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        10월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month">
	                        11월
	                    </div>
	                </div>
	                <div class="movie_plan_view_month_list">
	                    <div class="movie_plan_view_month active">
	                        12월
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
    </div>
	<div class="col-12 sub_contents_view_calendar">
	    <div class="col-12 calc_wrap25">
	    	<div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v04">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img03.jpg" alt="타이터스">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        타이터스
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.10.18 ~ 10.20(금) / 10.21(토)</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v01">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img00.jpg" alt="데이드림 이미지">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        데이드림 - Day Dream
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.09.05 ~ 2017.09.06</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v02">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img01.jpg" alt="드로잉 로봇 이미지">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        드로잉 로봇 - Drawing Robot
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.09.06 ~ 2017.09.15</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v04">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img02.jpg" alt="Saltation: 도약">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        Saltation: 도약
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.09.05 ~ 2017.09.06</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!-- popup00 -->
	<div class="col-12 popup_wrap" style="display: none;">
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
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            1
	                        </div>
	                        <div class="horizon_tab_text">
	                            관람일선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력내용확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <ul class="mb25 list_style_2">
	                            <li>관람 인원선택</li>
	                        </ul>
	                        <div class="mb48 select_style_2_wrap">
	                            <div class="select_style_2_con testbed_style">
	                                <select name="view_people_select" id="" class="select_style_2"  title="인원을 선택해 주세요">
	                                    <option value="1">1명</option>
	                                    <option value="2">2명</option>
	                                </select>
	                                <!-- <label for=""></label> -->
	                            </div>
	                        </div>
	                        <ul class="mb35 list_style_2">
	                            <li>좌석 선택</li>
	                        </ul>
	                        <div class="movie_seat_select_wrap">
	                            <div class="movie_seat_select_inner">
	                                <div class="movie_screen">
	                                    SCREEN
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
	                                                <div class="seat_item selected" data-sit-id="H07">
	                                                    H07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H08">
	                                                    H08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="H09">
	                                                    H09
	                                                </div>
	                                                <div class="seat_item select" data-sit-id="H10">
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
	                                                <div class="seat_item selected" data-sit-id="I07">
	                                                    I07
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I08">
	                                                    I08
	                                                </div>
	                                                <div class="seat_item" data-sit-id="I09">
	                                                    I09
	                                                </div>
	                                                <div class="seat_item select" data-sit-id="I10">
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
	                                                <div class="seat_item movie_control_room control_room_top">
	                                                    콘트롤부스
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
	                                                <div class="seat_item movie_control_room control_room_bottom">
	                                                    콘트롤룸
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
	                                <div class="movie_seat_info_text">선택가능</div>
	                            </div>
	                            <div class="movie_seat_info_list">
	                                <div class="movie_seat_color_box selected"></div>
	                                <div class="movie_seat_info_text">예매완료</div>
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
	                            <li>좌석입력확인</li>
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
	                    <a href="javascript:void(0)" class="popup_util_btn_style gray">
	                        이전
	                    </a>
	                    <a href="javascript:void(0)" class="popup_util_btn_style">
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
	<div class="col-12 popup_wrap" style="display: none;">
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
	                            관람일선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력내용확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <div class="col-12 col-md-6 article_list_type_0 left">
	                            <ul class="mb25 list_style_2">
	                                <li>관람일선택</li>
	                            </ul>
	                            <div class="calendar_style_1_box_wrap">
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
	                                <div class="calendar_style_1_wrap">
	                                    <table class="calendar_style_1 type_2">
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
	                        </div>
	                        <div class="col-12 col-md-6 article_list_type_0 right">
	                            <ul class="mb25 list_style_2">
	                                <li>시간선택</li>
	                            </ul>
	                            <ul class="mb42 popup_list_style_1">
	                                <li>
	                                    <div class="popup_list_style_1_text">
	                                        10:00am ~ 11:00am
	                                    </div>
	                                    <a href="javascript:void(0)" class="popup_list_style_1_btn">선택</a>
	                                </li>
	                                <li>
	                                    <div class="popup_list_style_1_text">
	                                        17:00pm ~ 18:00am
	                                    </div>
	                                    <a href="javascript:void(0)" class="popup_list_style_1_btn">선택</a>
	                                </li>
	                            </ul>
	                            <ul class="mb25 list_style_2">
	                                <li>입력내용확인</li>
	                            </ul>
	                            <table class="popup_table_style_0">
	                                <caption>입력내용확인</caption>
	                                <colgroup>
	                                    <col width="30%">
	                                    <col width="auto">
	                                </colgroup>
	                                <tbody>
	                                <tr>
	                                    <th>관람일</th>
	                                    <td class="point0">2018.08.17</td>
	                                </tr>
	                                <tr>
	                                    <th>공연시간</th>
	                                    <td>10:00am ~ 11:00am</td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                    </div>
	                </div>
	                <div class="popup_util_btn_con">
	                    <a href="javascript:void(0)" class="popup_util_btn_style gray">
	                        이전
	                    </a>
	                    <a href="javascript:void(0)" class="popup_util_btn_style">
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
	<div class="col-12 popup_wrap" style="display: none;">
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
	                            관람일선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력내용확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 mb35 popup_contents_inner">
	                    <div class="col-12 popup_contents_inner_border">
	                        <div class="col-12 reserve_check_movie_con">
	                            <div class="reserve_check_movie_img_box">
	                                <img src="/edu/images/bm/popup_movie_check_img_000.jpg" alt="드로잉 로봇 Drawing Robot">
	                            </div>
	                            <div class="reserve_check_movie_text_box">
	                                <div class="reserve_check_movie_title">
	                                    드로잉 로봇 - Drawing Robot
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
	                                        <td>2017.08.12(월)</td>
	                                    </tr>
	                                    <tr>
	                                        <th>시간</th>
	                                        <td>10:00am ~ 11:00am</td>
	                                    </tr>
	                                    <tr>
	                                        <th>러닝타임</th>
	                                        <td>1시간</td>
	                                    </tr>
	                                    <tr>
	                                        <th>좌석</th>
	                                        <td>R13, R14</td>
	                                    </tr>
	                                    <tr>
	                                        <th>장소</th>
	                                        <td>콘텐츠문화광장 무대</td>
	                                    </tr>
	                                    </tbody>
	                                </table>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="popup_util_btn_con">
	                    <a href="javascript:void(0)" class="popup_util_btn_style gray">
	                        이전
	                    </a>
	                    <a href="javascript:void(0)" class="popup_util_btn_style">
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
	<div class="col-12 popup_wrap" style="display: block;">
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
	                            관람일선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            2
	                        </div>
	                        <div class="horizon_tab_text">
	                            좌석선택
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            3
	                        </div>
	                        <div class="horizon_tab_text">
	                            입력내용확인
	                        </div>
	                    </div>
	                    <div class="col-3 horizon_tab_style_1_list active">
	                        <div class="horizon_tab_circle">
	                            4
	                        </div>
	                        <div class="horizon_tab_text">
	                            예약완료
	                        </div>
	                    </div>
	                </div>
	                <div class="col-12 popup_contents_inner">
	                    <div class="col-12 reserve_print_popup_header">
	                        <div class="reserve_print_header_title">
	                            드로잉 로봇 - Drawing Robot
	                        </div>
	                        <div class="reserve_print_header_subtitle">
	                            예약이 완료되었습니다.
	                        </div>
	                        <hr class="reserve_print_header_seperate_line">
	                        <div class="reserve_print_header_user_info">
	                            예약하신 아이디는 <span class="point0">kbrain</span> 입니다.
	                        </div>
	                        <div class="reserve_print_header_desc">
	                            예약하신 공연날짜를 꼭 확인해주시고, 아래의 출력버튼을 이용해 티켓을 출력해주세요.
	                        </div>
	                    </div>
	                    <div class="col-12 mb25 reserve_send_type_select">
	                        <div class="popup_check_style_0_wrap">
	                            <span class="popup_check_style_0_con">
	                                <input type="checkbox" id="reserve_send_type_message" class="popup_check_style_0">
	                                <label for="reserve_send_type_message">예약정보를 문자로 수신받겠습니다.</label>
	                            </span>
	                                <span class="popup_check_style_0_con">
	                                <input type="checkbox" id="reserve_send_type_mail" class="popup_check_style_0">
	                                <label for="reserve_send_type_mail">예약정보를 메일로 수신받겠습니다.</label>
	                            </span>
	                        </div>
	                    </div>
	                    <div class="col-12 mb65 popup_util_btn_con">
	                        <a href="/edu/forPrintTicket.jsp" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기" class="popup_util_btn_style black">
	                            출력
	                        </a>
	                        <a href="javascript:void(0)" class="popup_util_btn_style gray">
	                            이전
	                        </a>
	                        <a href="javascript:void(0)" class="popup_util_btn_style">
	                            다음
	                        </a>
	                    </div>
	                    <div class="col-12 reserve_print_contents" id="ticketPrint">
	                        <div class="reserve_print_logo">
	                            <img src="/edu/images/bm/testbed_black_logo.png" alt="콘텐츠문화광장 로고">
	                        </div>
	                        <div class="reserve_printing_time">
	                            2017-08-01 20:00
	                        </div>
	                        <div class="reserve_printing_article first">
	                            <div class="reserve_printing_name">
	                                [총인원 <span class="point2">2</span>명] 예약자 : <span class="point2">홍길동</span>
	                            </div>
	                            <div class="reserve_printing_title">
	                                콘텐츠문화광장 공연 A
	                            </div>
	                            <div class="reserve_printing_date">
	                                2017. 09. 31 (월요일) 10:00am ~ 12:00pm
	                            </div>
	                            <div class="reserve_printing_seat">
	                                콘텐츠문화광장 무대 / <span class="point2">D5, D6</span>
	                            </div>
	                        </div>
	                        <div class="reserve_printing_article">
	                            <div class="reserve_printing_rule">
	                                변경 및 취소 규정
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
	                            <img src="/edu/images/bm/reserve_printing_qrcode.png" alt="공연 예매 QRcode">
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
	
</div>
