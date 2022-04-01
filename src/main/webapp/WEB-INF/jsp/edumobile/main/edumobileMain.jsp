﻿<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page import="kr.co.unp.mpm.vo.MenuManageVO"%>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<% 
String requestUri = request.getRequestURL().toString();
if (requestUri.indexOf("testbed") != -1 || "testbed".equals(request.getParameter("siteName")) ){
	%>
	<jsp:include page="/WEB-INF/jsp/edumobile/main/testbedmobileMain.jsp" flush="true" />
	<%
}else{
%>

<c:set var='siteName' value='${paramVO.siteName}'/>
<%
UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
pageContext.setAttribute("userVO", user);

String menuNo = request.getParameter("menuNo");
String debug = request.getParameter("debug");

//if( "1".equals(debug) ){
	
if( StringUtils.hasText(menuNo) ) {

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

//HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll6");
/* testbed20170830 */
	String siteName = (String)pageContext.getAttribute("siteName") != null ? (String)pageContext.getAttribute("siteName") : "" ;
	HashMap<String, List<MenuManageVO>> menuMap = new HashMap<String, List<MenuManageVO>>();
	HashMap<String, List<MenuManageVO>> eduMenuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll6");
	/* HashMap<String, List<MenuManageVO>> testbedMenuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll7");
	menuMap.putAll(eduMenuMap);
	if ( "testbed".equals( siteName ) )	
		menuMap.putAll( testbedMenuMap ); */
/* //testbed20170830 */

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
    
<%@include file="/WEB-INF/jsp/edu/inc/incMainFn.jsp"%>

<jsp:useBean id="todayNow" class="java.util.Date"  />
<fmt:formatDate value="${todayNow}" var="today" pattern="yyyy-MM-dd" />

<c:set var="userVO" value="${userVO }" scope="request" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>한국콘텐츠아카데미 korea creative content agency</title>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
    <link rel="apple-touch-icon" sizes="57x57" href="/favicon/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="/favicon/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="/favicon/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="/favicon/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="/favicon/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="/favicon/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="/favicon/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="/favicon/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192"  href="/favicon/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/favicon/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/favicon/favicon-16x16.png">
	<link rel="manifest" href="/favicon/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="/favicon/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">
	
    <link rel="stylesheet" type="text/css" href="/edu/css/base.css"  />
    <link rel="stylesheet" type="text/css" href="/edu/css/animate.min.css" />
    <link rel="stylesheet" type="text/css" href="/edu/css/common.css"  />
    <link rel="stylesheet" type="text/css" href="/edu/css/layout.css"  />
    <link rel="stylesheet" type="text/css" href="/edu/css/main.css"  />
    <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript"  src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
    <script type="text/javascript" src="/edu/js/common.js"></script>
    <script type="text/javascript"> subMenuOpenIng=true; </script>
    <!-- Script Begins -->
    <!-- <script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script> -->
    <!-- Slider -->
    <script type="text/javascript" src="/js/jquery.sticky.js"></script>
    <script type="text/javascript" src="/js/jquery.scrollTo.min.js"></script>
    <script type="text/javascript" src="/js/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="/js/jquery.appear.js"></script>
    <script type="text/javascript" src="/js/modernizr.min.js"></script>
    <script type="text/javascript" src="/js/ssl.js"></script>
    <script type="text/javascript" src="/edu/js/bm/bm.js"></script>
<script type="text/javascript" src="/edumobile/js/common.js"></script>
    <script type="text/javascript" src="/edumobile/js/bm/bm.js"></script>
    <!-- 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.3.1/js/swiper.jquery.min.js"></script> 
    -->
    <link rel="stylesheet" href="/edu/js/bm/swiper/swiper.min.css"/>
    <script type="text/javascript" src="/edu/js/bm/swiper/swiper.min.js"></script>
    <script type="text/javascript" src="/edu/js/bm/rollingEvent.js"></script>
<!--     <script type="text/javascript" src="/edu/js/bm/main.js"></script> -->
    <link rel="stylesheet" href="/edu/css/bm/animate.min.css"/>
    <link rel="stylesheet" href="/edu/css/bm/base.css"/>
    <link rel="stylesheet" href="/edu/css/bm/bootstrap.reset.css"/>
    <link rel="stylesheet" href="/edu/css/bm/common_prev.css"/>
    <link rel="stylesheet" href="/edu/css/bm/contents.css"/>
    <link rel="stylesheet" href="/edu/css/bm/flaticon.css"/>
    <link rel="stylesheet" href="/edu/css/bm/ie.css"/>
    <link rel="stylesheet" href="/edu/css/bm/layout.css"/>
    <link rel="stylesheet" href="/edu/css/bm/main_prev.css"/>
    <link rel="stylesheet" href="/edu/css/bm/member.css"/>
    <link rel="stylesheet" href="/edu/css/bm/portfolio.css"/>
    <link rel="stylesheet" href="/edu/css/bm/search.css"/>
    <link rel="stylesheet" href="/edu/css/bm/sub.css"/>
    <link rel="stylesheet" href="/edu/css/bm/submain.css"/>
    <link rel="stylesheet" href="/edu/css/bm/common.css">
    <link rel="stylesheet" href="/edu/css/bm/wevenResponsive.css"/>
    <link rel="stylesheet" href="/edu/css/bm/main.css"/>
    
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="/edu/css/ie.css" type="text/css" />
    <script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
    <script type="text/javascript" src="/js/respond.min.js"></script>
    <script type="text/javascript"> $('html').attr('id','ie');</script>
    <![endif]-->
    
    
    <!-- Bootstrap JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="/edu/js/new/jquery-ui/jquery-1.11.2.min.js"></script>
	<script src="/edu/js/new/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.js"></script>
	<script src="/edu/js/new/popper.min.js"></script>
	<script src="/edu/js/new/bootstrap/bootstrap.min.js"></script>

	<link rel="stylesheet" type="text/css" href="/edu/css/new/header.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/new/css.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/new/footer.css"/>
	<script type="text/javascript" src="/edu/js/new/js.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
</head>

<body>
	<!-- <div class="ad"><img src="/edu/images/ad1.png" alt="" /></div> -->
	<!-- <a href="javascript:void(0);" class="adClose"><img src="/edu/images/adOpen.png" alt="" /></a> -->
	<script type="text/javascript">
		//<![CDATA[
		$(function() {
			$("#empmnForm").submit(function() {
				$("#keyword").val(encodeURIComponent($("#keywordStr").val()));
			});
		});
		$('.adClose').click(function(event) {
			$('.ad').slideToggle()
			$(this).toggleClass('off');
		});
        
		function logoutSSO() {
        	$.get("/${paramVO.siteName}/member/logout.json",function(data) {
        		var retUrl = "${ssoDomain}/sso/member/logoutSSO.do?service=${paramVO.siteName}";
        		//alert(retUrl);
        		location.href= retUrl;
        	},"json");
        	return false;
        }

        $(function() {
        	$(".logoutBtn").click(function() {
        		logoutSSO();
        		return false;
             });
        });
        
        //]]>
	</script>
	
    <div id="wrap" class="over-hidden">
        <!-- header -->
	        <div class="col-12 header_wrap bg_main_blue" style="height:auto;">
			    <div class="container">
			    	<div class="row col-center over-visible header_inner">
				        <div class="col-12 header_con">
				            <div class="col-12 col-center over-visible">
				                <div class="col-12">
				                    <!-- Util 영역 -->
				                    <div class="col-12 tr fontsize0 header_util_wrap">
				                        <div class="show vm header_util_text_con">
					                        <sec:authorize ifAnyGranted="ROLE_USER">
									            <span class="show vm fontsize14 header_util_item">
					                            	<span class="name_color"><c:out value="${userVO.userNm }"/></span>님 로그인중입니다.
					                            </span>
									            <hr class="show vm header_util_line">
									            <span class="show vm fontsize14 header_util_item">
									            	<a href="/edu/member/logout.do" class="ico4 logoutBtn" title="로그아웃">로그아웃</a>
									            </span>
									            <hr class="show vm header_util_line">
									            <span class="show vm fontsize14 header_util_item" style="position:relative;" id="myPageMenu">
										            <a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" class="ico5" title="마이페이지">
										            	<span>마이페이지</span>
										            </a>
										            <!-- 레이어 팝업 -->
										            <div class="mypageSubLayer">
										            	<p style="text-align:left;line-height:24px;"><span style="color:#000;font-weight:600;">[온라인교육]</span><br>학습중인 과정 : <span id="studyCount">0</span>개</p>
										            </div>
										            <!-- //레이어 팝업 -->
									            </span>
									            <hr class="show vm header_util_line">
									            <script type="text/javascript">
										            var selectCount = false;
										            $(document).ready(function(){
										            	$('#myPageMenu').mouseover(function(){
										            		showMypageLayer('IN');
										            	});
											            $('#myPageMenu').mouseout(function(){
											            	showMypageLayer('OUT');
											            });
											            $('.mypageSubLayer').mouseout(function(){
											            	showMypageLayer('OUT');
											            });
											
											            getMyStudyCount();
										            });
										
										            function showMypageLayer(type){
										           		if(type == "IN"){
										            		if(!selectCount){
										            			selectCount = true;
										            			getMyStudyCount();
										            		}
										            		$('.mypageSubLayer').show();
										            	}else{
										            		$('.mypageSubLayer').hide();
										            	}
										            }
										
										            function getMyStudyCount(){
										            	$.ajax({
										            		url : '/edu/onlineEdu/mylctrum/selectMyStudyCount.json',
										            		dataType : 'json',
										            		data : null,
										            		success : function(data) {
										            			$('.mypageSubLayer').find('#studyCount').html(data.studyCount);
										            		}
										            	});
										            }
									            </script>
									        </sec:authorize>
									        <sec:authorize ifNotGranted="ROLE_USER">
									            <c:url var="loginUrl" value="/edu/member/forLogin.do">
									                <c:param name="menuNo" value="500077" />
									                <c:param name="_targetUrl" value="${_targetUrl}" />
									            </c:url>
									            <span class="show vm fontsize14 header_util_item">
				                            		<a href="/edu/member/forLogin.do?menuNo=500077" class="ico1" title="로그인">로그인</a>
				                            	</span>
									            <hr class="show vm header_util_line">
									            <span class="show vm fontsize14 header_util_item">
									            	<a href="/edu/member/join01.do?menuNo=500076" class="ico2" title="회원가입">회원가입</a>
									            </span>
									            <hr class="show vm header_util_line">
									        </sec:authorize>
			        						<span class="show vm fontsize14 header_util_item">
			        							<a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵</a>
			        						</span>
		        						</div>
								        <div class="show vm header_util_icon_con">
									        <span class="show header_util_icon_item">
										        <a href="https://www.facebook.com/edukocca" target="_blank" title="새창열림">
										        	<img src="/edu/images/bm/facebook_icon.png" alt="페이스북 바로가기">
										        </a>
									        </span>
									        <span class="show header_util_icon_item">
										        <a href="https://twitter.com/edukocca" target="_blank" title="새창열림">
										        	<img src="/edu/images/bm/twitter_icon.png" alt="트위터 바로가기">
										        </a>
									        </span>
									        <span class="show header_util_icon_item">
										        <a href="https://blog.naver.com/edukocca" target="_blank" title="새창열림">
										        	<img src="/edu/images/bm/blog_icon.png" alt="블로그 바로가기">
										        </a>
									        </span>
									        <span class="show header_util_icon_item">
										        <a href="https://www.youtube.com/channel/UCJ78W_fNjOW7A-lZ6uEClgA" target="_blank" title="새창열림">
										        	<img src="/edu/new_image/youtube_icon.png" alt="유튜브 바로가기">
										        </a>
									        </span>
									        <span class="show header_util_icon_item">
										        <a href="https://www.instagram.com/edu.kocca/" target="_blank" title="새창열림">
										        	<img src="/edu/new_image/instargram_icon.png" alt="인스타그램 바로가기">
										        </a>
									        </span>
								        </div>
		        					</div>
							        <div class="col-12 header_section pt22 pb22">
								        <h1 class="show logo_con">
									        <a href="/edumobile/main/main.do" class="show" title="콘텐츠인재캠퍼스 한국콘텐츠아카데미 로고 - 콘텐츠인재캠퍼스 메인으로 이동">
									        	<img src="/edu/new_image/w_logo.png" alt="한국콘텐츠아카데미 콘텐츠인재캠퍼스">
									        </a>
								        </h1>
								        <div class="over-md-hidden tr gnb_wrap">
								        	<c:set var="topCategories" value="${menuAll6['menu_0']}" />
									        <ul class="fontsize0 gnb_con tc">
									        	<c:forEach var="x" begin="0" end="4">
									            	<li>
											            <c:if test="${x eq depth01}">
											                <c:set var="1depth_title" value="${topCategories[x].menuNm}"/>
											            </c:if>
									            		<a href="javascript:void(0);" ${x eq depth01 ? 'class="active"' : ''} ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''} >
									            			${topCategories[x].menuNm}
									            		</a>
											            <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
											            <c:set var="d02Categories" value="${menuAll6[d02MenuKey]}" />
											            <c:if test="${fn:length(d02Categories)>0}">
											                <c:set var="curD02" value="${curD02Categories[depth02]}" />
											                <c:set var="curD" value="${curD02Categories[depth02]}" />
															<c:if test="${topCategories[x].menuNo == '500108'}">
																<c:set var="curD02Categories" value="${menuAll7[d01menuKey]}" />
																<c:set var="d02MenuKey" value="menu_700000" />
																<c:set var="d02Categories" value="${menuAll7[d02MenuKey]}" />
																<c:set var="curD02" value="${curD02Categories[depth02]}" />
																<c:set var="curD" value="${curD02Categories[depth02]}" />
															</c:if>
									                		<ul>
									                			<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
									                    			<li>
													                    <a href="${d02Categories[y].fullMenuLink}" ${y eq depth02 ? 'class="on"' : ''} ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>
													                    	${d02Categories[y].menuNm}
													                    </a>
													                    <c:set var="d03menuKey" value="menu_${d02Categories[y].menuNo}" />
													                    <c:set var="d03Categories" value="${menuAll6[d03menuKey]}" />
													                    <c:if test="${fn:length(d03Categories)>0}">
									                       					<ul>
														                        <c:forEach var="z" begin="0"	end="${fn:length(d03Categories)-1}">
														                            <c:set var="clss2" value="${y eq depth02 && z eq depth03 ? 'on' : ''}" />
														                            <c:if test="${y eq depth02 && z eq depth03}">
														                                <c:set var="curD" value="${d03Categories[z]}" />
														                                <c:set var="curD03" value="${d03Categories[z]}" />
														                            </c:if>
									                            					<li class="${clss2}">
									                            						<a	href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>
									                            							${d03Categories[z].menuNm}
									                            						</a>
									                            					</li>
									                        					</c:forEach>
									                        				</ul>
									                    				</c:if>
									                    			</li>
									                			</c:forEach>
									                		</ul>
									           			</c:if>
									            	</li>
									        	</c:forEach>
									        </ul>
									        <div class="fr fontsize0 pt7 gnb_util_con">
									        	<!-- 검색창 -->
										        <span class="show vm tl input_con">
<%-- 											        <form name="frmSearch2" method="post" action="/edu/search/list.do?menuNo=500079" onsubmit="return search2(this);">
												        <input type="text" class="q2" name="q" id="q2" placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">
												        <label for="q2" id="all_search_label"></label>
												        <input type="image" src="/edu/images/bm/search_icon.png" alt="검색 확인" class="all_search_image">
											        </form> --%>
										        </span>
									        	<!-- //검색창 -->
									        	<%-- <hr class="show vm seperate_line"> --%>
										        <span class="show vm gnb_icon">
											        <img class="gnb_menu" src="/edu/img/gnb_icon.png" alt="GNB 메뉴">
											        <img class="gnb_close" src="/edu/img/gnb_close.png" alt="GNB 메뉴 닫기">
										        </span>
									        </div>
								        </div>
							        </div>
		        				</div>
		        			</div>
		        		</div>
		        	</div>
		        </div>
		        <div class="col-12 gnb_menu_dim"></div>
				<div class="col-12 gnb_all_menu_dim"></div>
		    </div>
        	<!-- //header -->
        	
        	
        	<div class="col-12 section contents_section" style="padding-bottom:20px;padding-top: 20px;">
		    	<div class="container">
		    		<!-- 온라인교육 -->
					<div class="col-12 section" style="padding-bottom:20px;padding-top: 20px;">
						<div class="tc over-hidden mobile_content">
							<div class="col-12 pr15 pl15">
								<h3>온라인 교육</h3>
								<div class="tab_style_1_con mobile_tab">
									<ul class="tab_style_1">
										<li class="tab_parent_first active">
											<a href="javascript:void(0)" title="선택됨">
												<span>
													모바일페이지
												</span>
											</a>
										</li>
										<li class="tab_parent_second">
											<a href="javascript:void(0)">
												<span>
													앱다운로드
												</span>
											</a>
										</li>
									</ul>
								</div>
								<div class="tab_contents main_mobile_tab_contents mobile_page_1 active">
									<div class="online_edu_mobile_device_img_box">
										<img src="/edu/images/bm/online_edu_mobile_device.png" alt="한국콘텐츠아카데미 모바일 디바이스"/>
									</div>
									<div class="mobile_main_desc">
										콘텐츠인재캠퍼스 온라인교육 전용<br/><span class="point1">모바일 페이지</span>로 이동합니다.
									</div>
									<div class="main_mobile_btn_con">
										<a href="http://m.edu.kocca.kr" target="_blank" title="새창열림" class="main_mobile_btn">온라인교육 바로가기</a>
									</div>
								</div>
								<div class="tab_contents main_mobile_tab_contents mobile_page_2">
									<div class="online_edu_mobile_device_img_box">
										<img src="/edu/images/bm/online_edu_mobile_device.png" alt="한국콘텐츠아카데미 모바일 디바이스"/>
									</div>
									<div class="mobile_main_desc">
										콘텐츠인재캠퍼스 <span class="point1">모바일앱을 다운</span><br/>받으시면 더 <span class="point1">편리하게 이용가능</span>합니다.
									</div>
									<div class="main_mobile_btn_con">
										<a href="/edumobile/main/contents.do?menuNo=600083" class="main_mobile_btn">모바일앱 다운받기</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- //온라인교육 -->
			   		<div class="col-12 col-center over-visible">
			            <div class="col-12 pr15 pl15">
			            	<!-- 공지사항( 노란색"[공지]"텍스트 추가 필요 ) -->
			            	<div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 contentBox">
			            		<div class="box_ct">
			                        <span class="ct_title">공지사항</span>
			                        <span class="btn_more float-right"><a href="/edumobile/bbs/B0000011/list.do?menuNo=600073">더보기</a></span>
			                        
			                        <div class="list_box">
			                            <ul>
			                            	<c:forEach var="result" items="${B0000011List}" end="5" varStatus="status">
				                                <li>
				                                    <a href="/edumobile/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=600073">
				                                        <span class="abbreviation"><span class="point_orange">[공지]</span><c:out value="${result.nttSj}"/></span>
				                                        <span><c:out value="${fn:substring(result.regDate,0,10)}"/></span>
				                                    </a> 
				                                </li>
											</c:forEach>
			                            </ul>
			                        </div>
				            	</div>
				            </div>
			            	<!-- //공지사항 -->
			            	
			            	<!-- 배너 슬라이드 -->
			            	<div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 swiper-container contentBox" id="full_banner_slide">
			            		<div class="swiper-wrapper">
			            			<!-- 반복 -->
			            			<c:forEach var="result" items="${mainPopupList }" varStatus="status">
			            			<div class="swiper-slide">
			            				<a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank" title="새창열림"</c:if>>
		            						<span style="display: none;">배너입니다.</span>
		                                   	<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&fileSn=<c:out value="${result.fileSn}"/>" title="<c:out value="${result.ntcnNm}"/>" alt="<c:out value="${result.ntcnNm}"/>">
		                               	</a>
			            			</div>
			            			</c:forEach>
			            			<!-- //반복 -->
				            	</div>
				            	<div class="swiperControlBox">
					            	<div class="col-12 swiper-pagination"></div>
					            	<button class="swiper-button-prev" aria-label="이전 슬라이드 보기" title="이전 슬라이드 보기" role="button"><i class="fas fa-chevron-left"></i></button>
	 								<button class="swiper-button-next" aria-label="다음 슬라이드 보기" title="다음 슬라이드 보기" role="button"><i class="fas fa-chevron-right"></i></button>
	 								<button class="swiper-autoplay-stop" aria-label="슬라이드 정지" title="슬라이드 정지" role="button"><i class="fas fa-pause"></i></button>
								</div>
				            </div>
			            	<!-- //배너 슬라이드 -->
			            	
			            	<!-- 오프라인교육 -->
			            	<div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 contentBox">
			            		<div class="box_ct">
			                        <span class="ct_title">오프라인교육</span>
<!-- 			                        <span class="btn_more float-right"><a href="/edu/offline/offlineMain/main.do?menuNo=500019">더보기</a></span> -->
			                        <div class="list_box list_box_type2">
			                            <ul>
			                            	<!-- 반복 -->
			                            	<c:forEach var="result" items="${offlineEduList}" varStatus="status">
			                            	<c:choose>
												    <c:when test="${result.prgCl eq '10'}">
												        <c:set var="subMenuNum" value="600081" />
												    </c:when>
												    <c:when test="${result.prgCl eq '12'}">
												       <c:set var="subMenuNum" value="600080" />
												    </c:when>
												    <c:when test="${result.prgCl eq '13'}">
												       <c:set var="subMenuNum" value="600079" />
												    </c:when>
												    <c:when test="${result.prgCl eq '14'}">
												       <c:set var="subMenuNum" value="600082" />
												    </c:when>
												    <c:otherwise> <!-- result.prgCl eq '15' -->
												       <c:set var="subMenuNum" value="600147" />
												    </c:otherwise>
												</c:choose>
			                            	
			                                <li>
			                                   <a href="/edumobile/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=${subMenuNum}&prgSe=01&prgCl=${result.prgCl}&siteSe=edu&pageIndex=1">
			                                       <span class="abbreviation" style="width: calc(100% - 80px) !important">${result.prgNm}</span>
			                                       <span>${fn:substring(result.prgBgnde,0,10)}</span>
			                                   </a> 
			                                </li>
			                                </c:forEach>
			                                <!-- //반복 -->
			                            </ul>
			                        </div>
				            	</div>
				            </div>
			            	<!-- //오프라인교육 -->
			            	
			            	<!-- 지원사업 -->
			            	<div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 contentBox">
			            		<div class="box_ct">
			                        <span class="ct_title">지원사업</span>
<!-- 			                        <span class="btn_more float-right"><a href="/edu/dream/dreamMain/main.do?menuNo=500034">더보기</a></span> -->
			                        <div class="horizontal_box">
			                            <ul>
			                            	<!-- 반복 -->
			                            	<c:forEach var="result" items="${eduSuportList}" varStatus="status">
			                                <li>
			                                	<c:choose>
												    <c:when test="${result.bbsId eq 'B0000040'}">
												        <c:set var="subMenuNum" value="600089" />
												    </c:when>
												    <c:when test="${result.bbsId eq 'B0000058'}">
												       <c:set var="subMenuNum" value="600108" />
												    </c:when>
												    <c:otherwise>
												       <c:set var="subMenuNum" value="600088" />
												    </c:otherwise>
												</c:choose>
												
			                                    <a href="/edumobile/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&delCode=0&menuNo=${subMenuNum}&pageIndex=1">
			                                        <div class="img_box">
			                                            <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&fileSn=1" alt="${result.nttSj}">
			                                        </div>
			                                        <div class="edu_info">
			                                            <span class="point_blue edu_title abbreviation2">${result.nttSj}</span>
			                                            <span>${result.frstRegistPnttm}</span>
			                                        </div>
			                                    </a>
			                                </li>
			                                </c:forEach>
			                                
			                                <!-- //반복 -->
			                            </ul>
			                        </div>
				            	</div>
				            </div>
			            	<!-- //지원사업 -->
			            	
			            	<!-- 바로가기 -->
			            	<!-- 
			            	<div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 contentBox">
			            		<div class="box_ct type3_banner">
			                        <ul>
			                            <li>
			                                <div class="banner_box" data-image="/edu/new_image/background/sub_greeting_visual_img_modify.jpg">
			                                    <span style="font-size:13px;">콘텐츠인재캠퍼스 시설/장비 예약</span>
			                                    <a class="btn_go" href="/edu/hkFcltyResve/fclty/list.do?menuNo=500160">바로가기</a>
			                                </div>
			                            </li>
			                            <li>
			                                <div class="banner_box" data-image="/edu/new_image/background/contents_visual_img_000.jpg">
			                                    <span>콘텐츠문화광장 시설/장비 예약</span>
			                                    <a class="btn_go" href="/testbed/main/contents.do?menuNo=700108">바로가기</a>
			                                </div>
			                            </li>
			                            <li>
			                                <div class="banner_box" data-image="/edu/images/bm/sub_main_visual_img_008.jpg">
			                                    <span>&nbsp;</span>
			                                    <a class="btn_go" href="http://conjobhub.co.kr" target="_blank">바로가기</a>
			                                </div>
			                            </li>
			                        </ul>
			                    </div>
				            </div>
				             -->
			            	<!-- //바로가기 -->
				        </div>
				    </div>
				</div>
        	</div>
	        <!-- footer -->
	        <div id="menu5" class="menu5">
	        	<jsp:include page="/WEB-INF/jsp/edumobile/inc/edumobileFooter.jsp" flush="true" />
	        </div>
	        <!-- //footer -->
  	  </div>
</body>
</html>

<%
}
%>

<%--        
<% }else{ %>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>kocca</title>
</head>
<body style="margin:0;">
	<p style="margin: 0;"><img src="/edu/images/bm/edu_04.jpg" alt="공사중" style="margin:0; width: 100%;" /></p>
</body>
</html>

<% } %>
--%>