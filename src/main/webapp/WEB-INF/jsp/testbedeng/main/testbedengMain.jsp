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

	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll8");
	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);
	/* 
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
     */
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
        <title>Multi Content Testbed</title>
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
        <jsp:include page="/WEB-INF/jsp/testbedeng/inc/link.jsp" flush="true" />
        <script type="text/javascript" src="https://101.livere.co.kr/js/livere8_lib.js" charset="utf-8"></script>
        <!-- 리뉴얼 추가 -->
		<link rel="stylesheet" type="text/css" href="/edu/css/new/testbed_footer.css"/>
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
        <div class="wrapper sub_multi_content_testbed_main contents_view_page eng">
    <!-- header -->
    <div class="col-12 header_wrap pb0">
       	<!--GNBhead-->
        <jsp:include page="/WEB-INF/jsp/testbedeng/inc/mainHead.jsp" flush="true" />
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
                                        <a href="/${paramVO.siteName}/concert/info/view.do?concertId=${mainConcertImg.concertId}&${pageQueryString}&listType=2" class="show more_btn2">상세보기</a>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>
                </c:if>
           </c:forEach>

				<div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_003.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        KOCCA Multi Content Testbed
                                   </h2>
                                   <p class="h_desc2">Multi-use testbed that supports the arts and culture industry <br/> and fosters the distribution and testing of convergence-based content</p>
                                   <div class="more_btn_con">
                                        <a href="/testbedeng/main/contents.do?menuNo=800009" class="show more_btn2">More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>
                
            </div>
        </div>
	</div>
    <!-- //contents -->

	<!-- 공연장 대관 카드리스트 -->
    <!-- <div class="col-12 sub_section performance_hall_card_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_card_list_wrap">
                    <div class="show vt performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_002.png" alt="비전 및 미션">
                        </div>
                        <div class="text_box">
                            <h3>
                                Vision and Mission
                            </h3>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbedeng/main/contents.do?menuNo=800009" class="performance_btn_style_0">More btn</a>
                        </div>
                    </div>
                    <div class="show vt performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_004.png" alt="찾아오시는 길">
                        </div>
                        <div class="text_box">
                            <h3>
                                How to get MCT
                            </h3>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/testbedeng/main/contents.do?menuNo=800013" class="performance_btn_style_0">More btn</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> -->
    <!--//공연장 대관 카드리스트 -->
    <!-- 2017 12 05 주석처리(디자인상 제거) -> 기획상 제거 -->
    
    
    <!-- STAGE66 -->
    <div class="col-12 sub_section performance_hall_section mt80">

        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_wrap">
                    <div class="performance_hall_body">
                        <h4>
                            STAGE66
                        </h4>
                        <p class="h_data4">
                           <span class="list">For information, please contact us at <a href="mailto:testbed@kocca.kr">testbed@kocca.kr</a></span>
                        </p>
		                <div class="circle_contetns_list border_box">
		                    <div class="col-4 col-sm-20 mini_view_circle_list">
		                        <div class="mini_view_circle_wrap">
		                            <div class="mini_view_circle">
		                                Black Box
		                            </div>
		                        </div>
		                        <div class="mini_view_circle_dim right">
		                            <div class="dim_left"></div>
		                            <div class="dim_right"></div>
		                        </div>
		                    </div>
		                    <div class="col-4 col-sm-20 mini_view_circle_list">
		                        <div class="mini_view_circle_wrap">
		                            <div class="mini_view_circle">
		                                W 14m<br/>
		                                D 17m<br/>
		                                H 9m
		                            </div>
		                        </div>
		                        <div class="mini_view_circle_dim">
		                            <div class="dim_left"></div>
		                            <div class="dim_right"></div>
		                        </div>
		                    </div>
		                    <div class="col-4 col-sm-20 mini_view_circle_list">
		                        <div class="mini_view_circle_wrap">
		                            <div class="mini_view_circle">
		                                2 sets of<br/>
		                                Elevated<br/>
		                                Stage
		                            </div>
		                        </div>
		                        <div class="mini_view_circle_dim">
		                            <div class="dim_left"></div>
		                            <div class="dim_right"></div>
		                        </div>
		                    </div>
		                    <div class="col-6 col-sm-20 mini_view_circle_list">
		                        <div class="mini_view_circle_wrap">
		                            <div class="mini_view_circle">
		                                135<br/>
		                                Telescopic<br/>
		                                Seating
		                            </div>
		                        </div>
		                        <div class="mini_view_circle_dim">
		                            <div class="dim_left"></div>
		                            <div class="dim_right"></div>
		                        </div>
		                    </div>
		                    <div class="col-6 col-sm-20 mini_view_circle_list">
		                        <div class="mini_view_circle_wrap">
		                            <div class="mini_view_circle">
		                                191 Seats<br/>
		                                in Total
		                            </div>
		                        </div>
		                        <div class="mini_view_circle_dim left">
		                            <div class="dim_left"></div>
		                            <div class="dim_right"></div>
		                        </div>
		                    </div>
		                </div>
		                <div class="more_btn_con mt50">
                            <a href="/testbedeng/main/contents.do?menuNo=800012" class="show more_btn2">More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // STAGE66 -->
    
    <!-- 입주기업 -->
    <div class="col-12 sub_section performance_hall_section img01 mt80">

        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_wrap">
                    <div class="performance_hall_body">
                        <h4>
                            Arts & Culture Enterprise
                        </h4>
                        <p class="h_desc4">
                        KOCCA Multi Content Testbed supports<br/> 20 Arts & Culture Enterprises and their<br/> activities relevant to multi content and<br/> technology development.
                        </p>
                        <div class="more_btn_con mt50">
                            <a href="/testbedeng/main/contents.do?menuNo=800014" class="show more_btn2">More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // 입주기업 -->


    <!-- 시설안내 -->
    <!-- <div class="col-12 sub_section facilities_information_section">
        <div class="col-12 facilities_information_header">
        	<div class="col-12 col-center mw-1200">
        		<div class="col-12 pr15 pl15">
        			<div class="facilities_guide_con">
		        		<div class="facilities_guide_left_box">
			        		<p class="facilities_guide_title">
			        			FACILITIES GUIDE
			        		</p>
				            <h3>
				                Facilities
				            </h3>
			        	</div>
			        	<div class="facilities_guide_right_box">
			        		<div class="facilities_guide_desc">
				        	Multi Content Testbed will open its doors to help propel the future of the content industry through 
							Stage 66, Box 66, individual enterprise support program and infrastructure support scheme.
							</div>
							<div class="facilities_guide_btn_con">
								<a href="/testbed/main/contents.do?menuNo=700103" class="facilities_more_btn">
									More btn
								</a>
							</div>
			        	</div>
		        	</div>
	        	</div>
        	</div>
        </div>
        <div class="col-12 facilities_information_list_wrap">
            <div class="col-12 col-md-6 facilities_information_list top left">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        Multi Content Testbed
                    </h4>
                    <p class="h_desc4">
                        Area : Total area of 2,700m² (2 overground and 2 underground floors), to operate as a facility to encourage promotion of cultural projects<br/>
						Main Facilities : Testbed stage (Stage66) with 193 seating capacity, separate space for individual enterprises covering 350m²
                    </p>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list top right">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        Stage66
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_263 padding_30">
                            <h5>
								General Stage
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li>극장형태 : 프로시니엄 극장</li>
                                <li>객석을 수납하여 최대 19m 깊이를 가진</li>
                                <li>블랙박스 형식의 공간으로 활용 가능</li>
                                <li><span>Black Box</span></li>
                                <li><span>Width 14m × Depth 17m × Height 9m</span></li>
                                <li><span>Upper stage : equipment & lighting battens, catwalk</span></li>
                                <li><span>Lower stage: two sets of elevated stage with width 12m × depth 2.5m (Maximum elevation height of 1m)</span></li>
                            </ul>
                        </div>
                        <div class="contents_list w_263">
                            <h5>
                                Seating capacity
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li>주무대 : 폭 14m x 깊이 9m x 높이 15m</li>
                                <li>우측무대 : 폭 7m x 깊이 9m x 높이 15m</li>
                                <li><span>135 fixed seats, second-floor gallery with 24 seats, third-floor gallery with 34 seats (including seats reserved for wheelchair users)</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom left">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        Box 66
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list">
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li><span>A glass-encased box-shaped space with width 5m × length 12m × height 4m</span></li>
                                <li><span>A multi space dedicated to various small to medium-sized exhibitions and performances to be used for individual projects</span></li>
                                <li><span>technology experimentation, as exhibition space, workshops, education seminars etc.</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom right">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        Space available for arts and culture enterprises
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_100p">
                            <h5>
                                What are arts and culture enterprises?
                            </h5>
                            <hr class="h_line5">
                            <p class="h_desc5">
                                They are enterprises involved in multi content performances, various event-oriented projects and those in media art business. 
								These include enterprises working in arts and culture content business covering planning, production, engineering, special effects and overall performers management.
                            </p>
                        </div>
                    </div>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_100p">
                            <h5>
                                Support in the following areas
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li><span>Spatial infrastructure (office space, conference room, testbed, rehearsal room)</span></li>
                                <li><span>PR material production, media day launch, meet-up sessions, investment seminars etc.</span></li>
                                <li><span>Support in KOCCA-affiliated business(business consulting, participation in exhibitions etc.)</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> -->
    <!-- //시설안내 -->
     <!-- 2017 12 05 주석처리(디자인상 제거) -> 기획상 제거 -->
	
    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/testbedeng/inc/testbedengFooter.jsp" flush="true" />
    <!-- //footer -->
</div>
</body>
</html>
