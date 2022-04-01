<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.mpm.vo.MenuManageVO"%>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<%
UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
pageContext.setAttribute("userVO", user);

String menuNo = request.getParameter("menuNo");
//String debug = request.getParameter("debug");

if( StringUtils.hasText(menuNo) ) {

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll5");
    MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
    pageContext.setAttribute("currMenu", currentVo);

    String position = currentVo.getPosition();
    int depth01 = Integer.parseInt(position.substring(0,2)) -1;
    int depth02 = Integer.parseInt(position.substring(2,4)) -1;
    int depth03 = Integer.parseInt(position.substring(4,6)) -1;
    int depth04 = Integer.parseInt(position.substring(6,8)) -1;
    int depth05 = Integer.parseInt(position.substring(8,10)) -1;
    pageContext.setAttribute("depth01", depth01);
    pageContext.setAttribute("depth02", depth02);
    pageContext.setAttribute("depth03", depth03);
    pageContext.setAttribute("depth04", depth04);
    pageContext.setAttribute("depth05", depth05);
}
%>

<%!
    public String removeTag(String html) throws Exception {
        return html.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("&nbsp;"," ");
    }
%>

        <jsp:useBean id="todayNow" class="java.util.Date"  />
        <fmt:formatDate value="${todayNow}" var="today" pattern="yyyy-MM-dd" />

        <c:set var="userVO" value="${userVO }" scope="request" />

        <!DOCTYPE html>
        <html lang="ko">
        <head>
        <title>콘텐츠문화광장</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
        <meta name="title" content="${fn:replace(title, '"', '˝')}" />
        <meta name="type" content="website" />
        <%--
        <c:if test="${not empty og}">
        <meta property="og:title" content="${fn:replace(og.title, '"', '˝')}" />
        <meta property="og:image" content="${og.image}" />
        <meta property="og:description" content="<c:out value='${og.description}'/>" />
        <meta property="og:type" content="website" />
        </c:if>
        --%>
        <jsp:include page="/WEB-INF/jsp/testbed/inc/testbedSubMainHead.jsp" flush="true" />

        <script type="text/javascript" src="https://101.livere.co.kr/js/livere8_lib.js" charset="utf-8"></script>
        <!-- 리뉴얼 추가 -->
		<link rel="stylesheet" type="text/css" href="/edu/css/new/footer.css"/>
		<!-- 리뉴얼 추가 끝 -->

        </head>
        <body>
        <!-- <div class="ad"><img src="/edu/images/ad1.png" alt="" /></div> -->
        <!-- <a href="javascript:void(0);" class="adClose"><img src="/edu/images/adOpen.png" alt="" /></a> -->
        <script type="text/javascript">
        //<![CDATA[
        $(function() {
	        $("#empmnForm").submit(function() {
		        $("#keyword").val(encodeURIComponent($("#keywordStr").val()));
		        }
	        );
        });
        $('.adClose').click(function(event) {
	        $('.ad').slideToggle()
	        $(this).toggleClass('off');
        }
        );
        //]]>
        </script>
        <div class="wrapper sub_multi_content_testbed_main contents_view_page">
    <!-- header -->
    <div class="col-12 header_wrap">
       	<!--GNBhead-->
        <jsp:include page="/WEB-INF/jsp/testbed/inc/subMainHead.jsp" flush="true" />
        <!--//GNBhead-->

        <div class="swiper-container" id="mainVisual">
            <div class="swiper-wrapper">

            <c:forEach var="mainConcertImg" items="${mainConcertImgList}" varStatus="status">
		        <c:set value="${fileMap[mainConcertImg.atchFileId] }" var="fileList" />
				<c:set var="file" value=""/>
				<c:forEach var="files" items="${fileList}">
					<c:if test="${files.fileFieldName eq 'mainImg'}">
						<c:set  var="file" value="${files}"/>
					</c:if>
				</c:forEach>

				<c:if test="${not empty file }">
                    <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        ${mainConcertImg.concertTitle}
                                   </h2>
                                   <p class="h_desc2">${mainConcertImg.concertStartDate} ~ ${mainConcertImg.concertEndDate}</p>
                                   <div class="more_btn_con">
                                   	<c:if test="${mainConcertImg.concertId == 29}">
                                        <a href="/${paramVO.siteName}/bbs/B0000061/view.do?nttId=72137&menuNo=700005" class="show more_btn2">상세보기</a>
                                    </c:if>
                                   	<c:if test="${mainConcertImg.concertId != 29}">
                                        <a href="/${paramVO.siteName}/concert/info/view.do?concertId=${mainConcertImg.concertId}&menuNo=700130" class="show more_btn2">상세보기</a>
                                    </c:if>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>
                </c:if>
           </c:forEach>

                <%-- <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_008.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                       수시대관 안내
                                    </h2>
                                    <p class="h_desc2">
                                    	최신의 시스템과 전문 스태프들이 창작자와 함께 실험과 도전을 완성하고,<br/>
										관객을 맞이할 수 있도록 최선을 다하고 있습니다.
									</p>
                                    <div class="more_btn_con">
                                        <a href="/${paramVO.siteName}/bbs/B0000061/view.do?nttId=72440&menuNo=700005" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div> --%>

				<div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_008.jpg');" tabindex="0">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                           				콘텐츠문화광장
                                   </h2>
                                   <p class="h_desc2">최첨단 시설 구축으로 앞서가는 문화,<br/> 전문적인 문화를선도하는 콘텐츠 문화광장</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

                <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_007.jpg');" tabindex="0">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                   		시설안내
                                    </h2>
                                    <p class="h_desc2">스테이지66, 박스66, 스튜디오 1&2</p>
                                    <div class="more_btn_con">
                                        <a href="/testbed/main/contents.do?menuNo=700103" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

            </div>
        </div>
        <!-- <div class="col-12 col-center mw-1740 visual_inner">
            <span class="visual_arrow left"><img src="/edu/images/bm/visual_rolling_left_arrow.png" alt="왼쪽 비쥬얼 보기" tabindex="0"></span>
            <span class="visual_arrow right"><img src="/edu/images/bm/visual_rolling_right_arrow.png" alt="오른쪽 비쥬얼 보기" tabindex="0"></span>
        </div>
        <div class="tc mt30 fontsize0 caroufredusel_rolling_btn_con main_top_rolling_icon">
            <span class="show vm rolling_btn active"></span>
            <span class="show vm rolling_btn"></span>
            <span class="show vm rolling_btn"></span>
        </div> -->
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
                    ,speed : 800
                    ,autoplay:4000
                    //,nextButton: '.visual_arrow.right'
                    //,prevButton: '.visual_arrow.left'
                    //,pagination: '.main_top_rolling_icon'
                    ,bulletActiveClass: 'active'
                    ,autoplayDisableOnInteraction: false
                    ,paginationBulletRender: function (swiper, index, className) {
                        return '<span class="show vm rolling_btn '+className+'"></span>';
                    }
                });
                $('#mainVisual').on('focusin',function(){
                	swip.stopAutoplay();
                	$('.swiper-slide-duplicate').remove();
                	swip.slideTo(0);
                });
            });
            
        </script>
        


	</div>
    <!-- //contents -->

	<!-- 공지사항, 자유게시판 -->
    <%-- <div class="col-12 section contents_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15 contents_wrap">
                <div class="col-12 col-md-6 contents_left_box">
                    <div class="col-12 notice_wrap">
                        <div class="col-12 mb15 section_header">
                            <h4 class="fl">공지사항</h4>
                            <a href="/testbed/bbs/B0000061/list.do?menuNo=700112" class="show fr mt7 mr-md-10 more_btn">더보기</a>
                        </div>
                        <div class="col-12 fontsize0 mb16 section_bar">
                            <hr class="h_line4">
                        </div>
                        <div class="col-12 pr-md-per10 contents_body">

                        	<c:choose>
                        		<c:when test='${ B0000061List.size() > 0 }'>
		                        	<c:forEach var="result" items="${B0000061List}" varStatus="status">
							            <c:if test="${status.index == 0}">
							                <p class="col-12 section_title new">
								                <span>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=700112">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </span>
							                </p>
							                <p class="col-12 mb3 section_desc4">
							                	<c:out value="${result.imgDescCn}"/>
							                </p>
							                <p class="col-12 mb11 section_date4">
							                	<c:out value="${fn:substring(result.regDate,0,10)}"/>
							                </p>
							            </c:if>
							        </c:forEach>
		                            <ul class="col-12 list_style_0">
		                            	<c:forEach var="result" items="${B0000061List}" varStatus="status">
								            <c:if test='${status.index > 0}'>
								                <li>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=700005">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </li>
								            </c:if>
								        </c:forEach>
		                            </ul>
                            	</c:when>
                            	<c:otherwise>
                            		<!-- 게시글 없을 때 처리 -->
                            		<ul class="list_style_8">
                            			<li>등록된 게시물이 없습니다.</li>
                            		</ul>
                            	</c:otherwise>
                           	</c:choose>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 contents_right_box">
                    <div class="col-12 notice_wrap">
                        <div class="col-12 mb15 section_header">
                            <h4 class="fl">자유게시판</h4>
                            <a href="/testbed/bbs/B0000062/list.do?menuNo=700113" class="show fr mt7 mr-md-10 more_btn">더보기</a>
                        </div>
                        <div class="col-12 fontsize0 mb16 section_bar">
                            <hr class="h_line4">
                        </div>
                        <div class="col-12 pr-md-per10 contents_body" data-zz="${B0000062List.size() }">
                        	<c:choose>
                        		<c:when test='${ B0000062List.size() > 0 }'>

		                            <c:forEach var="result" items="${B0000062List}" varStatus="status">
							            <c:if test="${status.index == 0}">
							                <p class="col-12 section_title new">
								                <span>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=700113">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </span>
							                </p>
							                <p class="col-12 mb3 section_desc4">
							                	<c:out value="${result.imgDescCn}"/>
							                </p>
							                <p class="col-12 mb11 section_date4">
							                	<c:out value="${fn:substring(result.regDate,0,10)}"/>
							                </p>
							            </c:if>
							        </c:forEach>
		                            <ul class="col-12 list_style_0">
		                            	<c:forEach var="result" items="${B0000062List}" varStatus="status">
								            <c:if test='${status.index > 0}'>
								                <li>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </li>
								            </c:if>
								        </c:forEach>
		                            </ul>
                        		</c:when>
                        		<c:otherwise>
                        		<!-- 게시글 없을 때 처리 -->
                            		<ul class="list_style_8">
                            			<li>등록된 게시물이 없습니다.</li>
                            		</ul>
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> --%>
    <!-- //공지사항, 자유게시판 -->
    <!-- 2017 09 26 태경 주석처리(디자인상 제거) -> 기획상 제거인듯 -->

	<!-- 공연장 대관 카드리스트 -->
    <div class="col-12 sub_section performance_hall_card_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_card_list_wrap">
                    <div class="col-xs-12 col-sm-6 col-md-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_002.png" alt="비전 및 미션 아이콘 이미지">
                        </div>
                        <div class="text_box">
                            <h3>
                           		비전 및 미션
                            </h3>
                            <p class="h_desc3">
                               	콘텐츠와 기술이 연결되는<br/>세계로 열린 무대입니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/main/contents.do?menuNo=700101" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                    <!--
                    <div class="col-6 col-md-20 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_003.png" alt="입주프로그램 안내">
                        </div>
                        <div class="text_box">
                            <h3>
                                입주 프로그램 안내
                            </h3>
                            <p class="h_desc3">
                                문화예술 콘텐츠 기업육성<br/>
								인프라 특화형 입주기업 운영
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/main/contents.do?menuNo=700109" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div> -->

                    <div class="col-xs-12 col-sm-6 col-md-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_006.png" alt="대관안내 아이콘 이미지">
                        </div>
                        <div class="text_box">
                            <h3>
                           		 대관안내
                            </h3>
                            <p class="h_desc3">
                           		대관안내 및 현황을 확인 후<br/>절차에 따라 대관신청해 주세요.
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/main/contents.do?menuNo=700108" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                    <!-- <div class="col-xs-12 col-sm-6 col-md-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_001.png" alt="커뮤니티">
                        </div>
                        <div class="text_box">
                            <h3>
                                커뮤니티
                            </h3>
                            <p class="h_desc3">
                                콘텐츠문화광장 관련정보를<br/>
								공유할 수 있습니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/bbs/B0000061/list.do?menuNo=700112" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div> -->
                    <div class="col-xs-12 col-sm-6 col-md-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_001.png" alt="공지사항 아이콘 이미지">
                        </div>
                        <div class="text_box">
                            <h3>
                       			공지사항
                            </h3>
                            <p class="h_desc3">
                           		대관공고 및 주요 사업을<br/>공지합니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/bbs/B0000061/list.do?menuNo=700112" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_005.png" alt="자료실 아이콘 이미지">
                        </div>
                        <div class="text_box">
                            <h3>
                               	자료실
                            </h3>
                            <p class="h_desc3">
                           		기술정보 및 기타 자료를<br/>제공합니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/bbs/B0000066/list.do?menuNo=700126" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_004.png" alt="찾아오시는 길 아이콘 이미지">
                        </div>
                        <div class="text_box">
                            <h3>
                           		찾아오시는 길
                            </h3>
                            <p class="h_desc3">
                               	 콘텐츠 인재캠퍼스 내부에<br/>위치해 있습니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbed/main/contents.do?menuNo=700104" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//공연장 대관 카드리스트 -->

    <!-- 공연장 대관 -->
    <div class="col-12 sub_section performance_hall_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_wrap">
                    <div class="performance_hall_header">
                        <h3>
                            <!-- 콘텐츠문화광장 공연ㆍ행사장  -->대관 안내
                        </h3>
                    </div>
                    <div class="performance_hall_body">
                        <h4>
                            <!-- 공연ㆍ행사장  -->대관 안내
                        </h4>
                        <p class="h_desc4">
                            <!-- 문화와 예술을 통해 진정한 휴식을 느낄 수 있도록 여러분의<br>편안하고 친근한  문화쉼터가 될 것입니다. -->
                       		새로운 미디어와 테크놀로지, 문화예술의 만남은<br/>새로운 미래 콘텐츠의 성장판이 될 것입니다.
                        </p>
                        <p class="h_data4">
                            <span class="list">전화 : 02.6310.0776</span><span class="list">E-MAIL : <a href="mailto:kocca.testbed@gmail.com">kocca.testbed@gmail.com</a></span><span class="list">대관문의 : 월 ~ 금 (09:00-18:00)</span>
                        </p>
                        <div class="download_wrap">
                            <a class="download_btn" href="/upload/testbedupload/testbedapply_2022.hwp">
                                <span>제출서식 다운로드</span>
                            </a>
                            <a class="download_btn" href="/upload/testbedupload/testbedguide-2022_2.hwp">
                                <span>대관안내 다운로드</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // 공연장 대관 -->

    <!-- 시설안내 -->
    <div class="col-12 sub_section facilities_information_section">
        <div class="col-12 facilities_information_header">
        	<div class="col-12 col-center mw-1200">
        		<div class="col-12 pr15 pl15">
        			<div class="facilities_guide_con">
		        		<div class="facilities_guide_left_box">
			        		<p class="facilities_guide_title">
			        			FACILITIES GUIDE
			        		</p>
				            <h3>
			                	시설 안내
				            </h3>
			        	</div>
			        	<div class="facilities_guide_right_box">
			        		<div class="facilities_guide_desc">
				        		콘텐츠문화광장은 융복합 콘텐츠의 테스트베드(TEST BED)로서<br>
				        		블랙박스 구조의 스테이지66과 스튜디오1, 2, 연습실 등을 갖추고<br>
				        		콘텐츠 산업의 미래를 여는 역할을 하고 있습니다.
							</div>
							<div class="facilities_guide_btn_con">
								<a href="/testbed/main/contents.do?menuNo=700103" class="facilities_more_btn">
									자세히보기
								</a>
							</div>
			        	</div>
		        	</div>
	        	</div>
        	</div>
        </div>
        <div class="col-12 facilities_information_list_wrap" style="padding:0;">
            <div class="col-12 col-md-6 facilities_information_list top left" tabindex="0">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        콘텐츠문화광장
                    </h4>
                    <p class="h_desc4">
                        규모 : 연면적 2,700㎡ (지하2층, 지상2층, 문화산업진흥시설)<br>
                        주요 시설 : 스테이지66 (193석, 350㎡(106py)), 문화예술기업 입주공간 외
                    </p>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list top right" tabindex="0">
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
                                <!-- <li>극장형태 : 프로시니엄 극장</li>
                                <li>객석을 수납하여 최대 19m 깊이를 가진</li>
                                <li>블랙박스 형식의 공간으로 활용 가능</li> -->
                                <li><span>블랙박스</span></li>
                                <li><span>폭 14m x 깊이 17m x 높이 9m</span></li>
                                <li><span>상부 : 장치봉, 조명봉, 캣워크</span></li>
                                <li><span>하부 : 폭 12m x 깊이 2.5m의 승강무대 2조 (최대 상승 높이 1m)</span></li>
                            </ul>
                        </div>
                        <div class="contents_list w_263">
                            <h5>
                                객석 공간
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <!-- <li>주무대 : 폭 14m x 깊이 9m x 높이 15m</li>
                                <li>우측무대 : 폭 7m x 깊이 9m x 높이 15m</li> -->
                                <li><span>1층 135석(수납식)</span></li>
                                <li><span>2층 24석</span></li>
                                <li><span>3층 34석(휠체어석 2석 포함)</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom left" tabindex="0">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                       스튜디오1
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list">
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li><span>기술기반 융합형 프로젝트 시연, 기술 실험, 첨단 전시, 강연</span></li>
                                <li><span>가로 11m x 세로 5.7m x 높이 3.8m</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom right" tabindex="0">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        스튜디오2
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_420">
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li><span>기술기반 융합형 프로젝트 시연, 기술 실험, 첨단 전시, 강연</span></li>
                                <li><span>가로 13.6m x 세로 11.3m x 높이 8m(최저부 3.3m)</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //시설안내 -->

    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/testbed/inc/testbedFooter.jsp" flush="true" />
    <!-- //footer -->
</div>
</body>
</html>
