<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<body>
<div class="wrapper sub_multi_content_testbed_main">
    <!-- header -->
    <div class="col-12 header_wrap">
       	<!--GNBhead-->
        <jsp:include page="/WEB-INF/jsp/testbed/inc/subMainHead.jsp" flush="true" />
        <!--//GNBhead-->
        
        <div class="swiper-container" id="mainVisual">
            <div class="swiper-wrapper">

                <div class="main_visual_000 swiper-slide">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        콘텐츠 문화광장 공연
                                    </h2>
                                    <p class="h_desc2">2017.08.01 - 2018.08.01<br>
                                        시간 : 매주 월, 수, 금 (13:00 - 15:00)</p>
                                    <div class="more_btn_con">
                                        <a href="./sub_home_00.html" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img_000"></div>
                </div>
                <div class="main_visual_001 swiper-slide">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        창의인재 양성의 요람,<br>콘텐츠인재캠퍼스
                                    </h2>
                                    <p class="h_desc2">콘텐츠인재캠퍼스에서는 여러분의 다양한 꿈과 희망을 응원합니다</p>
                                    <div class="more_btn_con">
                                        <a href="./sub_home_00.html" class="show more_btn2">인재캠퍼스 자세히보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img_001"></div>
                </div>
                <div class="main_visual_002 swiper-slide">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        창의인재 양성의 요람,<br>콘텐츠인재캠퍼스
                                    </h2>
                                    <p class="h_desc2">콘텐츠인재캠퍼스에서는 여러분의 다양한 꿈과 희망을 응원합니다</p>
                                    <div class="more_btn_con">
                                        <a href="./sub_home_00.html" class="show more_btn2">인재캠퍼스 자세히보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img_002"></div>
                </div>

                <div class="main_visual_003 swiper-slide">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        창의인재 양성의 요람,<br>콘텐츠인재캠퍼스
                                    </h2>
                                    <p class="h_desc2">콘텐츠인재캠퍼스에서는 여러분의 다양한 꿈과 희망을 응원합니다</p>
                                    <div class="more_btn_con">
                                        <a href="./sub_home_00.html" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img_003"></div>
                </div>
            </div>
        </div>
        <div class="col-12 col-center mw-1740 visual_inner">
            <span class="visual_arrow left"><img src="/edu/images/bm/visual_rolling_left_arrow.png" alt="왼쪽 비쥬얼 보기"></span>
            <span class="visual_arrow right"><img src="/edu/images/bm/visual_rolling_right_arrow.png" alt="오른쪽 비쥬얼 보기"></span>
        </div>
        <div class="tc mt30 fontsize0 caroufredusel_rolling_btn_con main_top_rolling_icon">
            <span class="show vm rolling_btn active"></span>
            <span class="show vm rolling_btn"></span>
            <span class="show vm rolling_btn"></span>
        </div>
        <script type="text/javascript">
            $(function(){
                var swip = new Swiper("#mainVisual", {
                    loop : true
                    ,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
                    ,slidesPerView: 1 // 한번에 보이는 슬라이드 갯수
                    ,spaceBetween: 0 // 슬라이드 사이의 간격 px 단위
                    ,mousewheelControl: false // 마우스 휠로 슬라이드 움직임
                    ,paginationHide: true
                    ,autoHeight:true
                    ,nextButton: '.visual_arrow.right'
                    ,prevButton: '.visual_arrow.left'
                    ,pagination: '.main_top_rolling_icon'
                    ,bulletActiveClass: 'active'
                    ,paginationBulletRender: function (swiper, index, className) {
                        return '<span class="show vm rolling_btn '+className+'"></span>';
                    }
                });
            });
        </script>
        <div class="col-12 col-center mw-1200 list_search_wrap">
            <div class="col-12 pr15 pl15">
                <div class="more_btn_wrap">
                    <a class="more_btn" href="javascript:void(0)">
                        <span>리스트 더보기</span>
                    </a>
                </div>
                <hr class="list_search_line">
                <div class="list_search_con">
                    <p class="title">
                        공연검색
                    </p>
                    <div class="data_list_wrap">
                        <input type="image" class="calender_btn" src="/edu/images/bm/calender_btn.png">
                        <label for=""></label>
                        <input type="text" class="calender_text">
                        <label for=""></label>
                    </div>
                    <div class="data_list_wrap">
                        <input type="image" class="calender_btn" src="/edu/images/bm/calender_btn.png">
                        <label for=""></label>
                        <input type="text" class="calender_text">
                        <label for=""></label>
                    </div>
                    <div class="data_list_wrap search">
                        <input type="text" class="search_text" placeholder="공연 정보 검색">
                        <label for=""></label>
                        <input type="image" onclick="javascript:alert('서비스 준비중 입니다.');" class="search_btn" src="/edu/images/bm/search_btn.png">
                        <label for=""></label>
                    </div>
                </div>
            </div>
        </div>
        
        
	</div>
    <!-- //contents -->
	
	
	
	
	
	<!-- 공지사항, 자유게시판 -->
    <div class="col-12 section contents_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15 contents_wrap">
                <div class="col-12 col-md-6 contents_left_box">
                    <div class="col-12 notice_wrap">
                        <div class="col-12 mb15 section_header">
                            <h4 class="fl">공지사항</h4>
                            <a href="./sub_home_10_list.html" class="show fr mt7 mr-md-10 more_btn">더보기</a>
                        </div>
                        <div class="col-12 fontsize0 mb16 section_bar">
                            <hr class="h_line4">
                        </div>
                        <div class="col-12 pr-md-per10 contents_body">
                            <p class="col-12 section_title new">
                                <span>[한국콘텐츠진흥원] 콘텐츠테크랩 사업설명회로 초대합니다</span>
                            </p>
                            <p class="col-12 mb3 section_desc4">
                                콘텐츠 테크랩은 콘텐츠 창작자들에게 융복합 기술교육을 실시하여 창작역량을 강화하고 있습니다
                            </p>
                            <p class="col-12 mb15 section_date4">
                                2017.06.29
                            </p>
                            <ul class="col-12 list_style_0">
                                <li>2017년 콘텐츠 창의인재 동반사업 멘티 선정 결과</li>
                                <li>2017년 창의 인재 동반사업 창의 교육생모집</li>
                                <li>2017년 콘텐츠 창의인재 동반사업 멘티 선정 결과</li>
                                <li>2017년 창의 인재 동반사업 창의 교육생모집</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 contents_right_box">
                    <div class="col-12 notice_wrap">
                        <div class="col-12 mb15 section_header">
                            <h4 class="fl">자유게시판</h4>
                            <a href="./sub_home_10_list.html" class="show fr mt7 mr-md-10 more_btn">더보기</a>
                        </div>
                        <div class="col-12 fontsize0 mb16 section_bar">
                            <hr class="h_line4">
                        </div>
                        <div class="col-12 pr-md-per10 contents_body">
                            <p class="col-12 section_title new">
                                <span>[한국콘텐츠진흥원] 콘텐츠테크랩 사업설명회로 초대합니다</span>
                            </p>
                            <p class="col-12 mb3 section_desc4">
                                콘텐츠 테크랩은 콘텐츠 창작자들에게 융복합 기술교육을 실시하여 창작역량을 강화하고 있습니다
                            </p>
                            <p class="col-12 mb15 section_date4">
                                2017.06.29
                            </p>
                            <ul class="col-12 list_style_0">
                                <li>2017년 콘텐츠 창의인재 동반사업 멘티 선정 결과</li>
                                <li>2017년 창의 인재 동반사업 창의 교육생모집</li>
                                <li>2017년 콘텐츠 창의인재 동반사업 멘티 선정 결과</li>
                                <li>2017년 창의 인재 동반사업 창의 교육생모집</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //공지사항, 자유게시판 -->

    <!-- 공연장 대관 -->
    <div class="col-12 sub_section performance_hall_section">

        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_wrap">
                    <div class="performance_hall_header">
                        <h3>
                            콘텐츠문화광장 공연장 대관안내
                        </h3>
                    </div>
                    <div class="performance_hall_body">
                        <h4>
                            공연장 대관
                        </h4>
                        <p class="h_desc4">
                            문화와 예술을 통해 진정한 휴식을 느낄 수 있도록 여러분의<br>
                            편안하고 친근한  문화쉼터가 될 것입니다.
                        </p>
                        <p class="h_data4">
                            <span class="list">전화 : 02.6310.0776</span><span class="list">E-MAIL : ejable@kocca.kr</span><span class="list">대관문의 : 월, 금 (10:00-18:00)</span>
                        </p>
                        <div class="download_wrap">
                            <a class="download_btn" href="javascript:void(0)">
                                <span>제출서식 다운로드</span>
                            </a>
                            <a class="download_btn" href="javascript:void(0)">
                                <span>대관안내 다운로드</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // 공연장 대관 -->


    <!-- 공연장 대관 카드리스트 -->
    <div class="col-12 sub_section performance_hall_card_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_card_list_wrap">
                    <div class="col-12 col-sm-4 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_000.png" alt="비전 및 미션">
                        </div>
                        <div class="text_box">
                            <h3>
                                비전 및 미션
                            </h3>
                            <p class="h_desc3">
                                한국콘텐츠진흥원 콘텐츠문화광장은 문화예술,<br>
                                콘텐츠와 기술이 연결되는 실험장이자<br>
                                세계로 열린 미래 무대입니다.
                            </p>
                        </div>
                    </div>
                    <div class="col-12 col-sm-4 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_001.png" alt="입주프로그램 안내">
                        </div>
                        <div class="text_box">
                            <h3>
                                입주프로그램 안내
                            </h3>
                            <p class="h_desc3">
                                문화예술 콘텐츠 기업육성<br>
                                콘텐츠문화광장 인프라 특화형<br>
                                입주기업모집
                            </p>
                        </div>
                    </div>
                    <div class="col-12 col-sm-4 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_002.png" alt="오시는 길">
                        </div>
                        <div class="text_box">
                            <h3>
                                오시는 길
                            </h3>
                            <p class="h_desc3">
                                콘텐츠 문화광장은<br>
                                콘텐츠인재캠퍼스 내부에<br>
                                위치해 있습니다.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//공연장 대관 카드리스트 -->


    <!-- 시설안내 -->
    <div class="col-12 sub_section facilities_information_section">
        <div class="col-12 facilities_information_header">
            <h3>
                시설안내
            </h3>
        </div>
        <div class="col-12 facilities_information_list_wrap">
            <div class="col-12 col-md-6 facilities_information_list top left">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        콘텐츠문화광장
                    </h4>
                    <p class="h_desc4">
                        규모 : 연면적 2,700㎡ (지하2층, 지상2층, 문화산업진흥시설)<br>
                        주요시설 : 시연무대 (190석, 350㎡(106py)), 문화예술기업 입주공간 외
                    </p>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list top right">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        스테이지66_콘텐츠 시연무대
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_263 padding_30">
                            <h5>
                                무대공간
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li>극장형태 : 프로시니엄 극장</li>
                                <li>객석을 수납하여 최대 19m 깊이를 가진</li>
                                <li>블랙박스 형식의 공간으로 활용 가능</li>
                            </ul>
                        </div>
                        <div class="contents_list w_263">
                            <h5>
                                객석공간
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li>주무대 : 폭 14m x 깊이 9m x 높이 15m</li>
                                <li>우측무대 : 폭 7m x 깊이 9m x 높이 15m</li>
                                <li>상부 : 장치봉, 조명봉, 캣워크</li>
                                <li>하부 : 폭 12m x 깊이 2.5m의 승강무대 2조
                                    (최대 상승 높이 1m)
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom left">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        박스66_프로젝트 시연공간
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list">
                            <h5>
                                공간
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li>가로 5m x 세로 12m x 높이 4m  유리 박스형 가변형 공간</li>
                                <li>프로젝트 시연, 기술실험, 전시공간</li>
                                <li>데모데이, 워크숍, 교육 등 소규모 이벤트가 가능한 멀티공간</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom right">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        문화예술기업 입주공간
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_400 padding_30">
                            <h5>
                                문화예술기업이란?
                            </h5>
                            <hr class="h_line5">
                            <p class="h_desc5">
                                융복합 공연, 이벤트, 전시, 미디어아트 등 관련분야 기획,
                                연출, 엔지니어, 특수효과, 퍼포머 등으로 구성된
                                문화예술콘텐츠 분야 기업
                            </p>
                        </div>
                        <div class="contents_list w_151">
                            <h5>
                                입주기간 (1기)
                            </h5>
                            <hr class="h_line5">
                            <p class="h_desc5">
                                2017.8 ~ 2018.7
                            </p>
                        </div>
                    </div>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_400">
                            <h5>
                                지원사항
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li>공간 인프라 지원 (사무공간, 회의실, 문화광장, 연습실 등을 지원) </li>
                                <li>홍보물 제작, 미디어데이, 밋업 개최, 투자설명회 등 지원 </li>
                                <li>진흥원 사업 연계 지원 (비즈니스 컨설팅, 전시 참가 지원) </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //시설안내 -->
	
    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/edu/inc/eduFooter.jsp" flush="true" />
    <!-- //footer -->
</div>
</body>
