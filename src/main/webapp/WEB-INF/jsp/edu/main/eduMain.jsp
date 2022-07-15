<%@page import="java.net.URLEncoder"%>
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

//HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll5");
/* testbed20170830 */
	String siteName = (String)pageContext.getAttribute("siteName") != null ? (String)pageContext.getAttribute("siteName") : "" ;
	HashMap<String, List<MenuManageVO>> menuMap = new HashMap<String, List<MenuManageVO>>();
	HashMap<String, List<MenuManageVO>> eduMenuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll5");
	HashMap<String, List<MenuManageVO>> testbedMenuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll7");
	menuMap.putAll(eduMenuMap);
	if ( "testbed".equals( siteName ) )	
		menuMap.putAll( testbedMenuMap );
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
    <title>에듀코카 korea creative content agency</title>
    <%-- <c:if test="${param.mobileTp ne 'Y' }">
		<script type="text/javascript">
	        if (/(iphone|ipod|ipad|android|blackberry|windows ce|palm|symbian)/i.test(navigator.userAgent)) {
	        	location.href="https://medu.kocca.kr/edumobile/main/main.do";
	        }
		</script>
    </c:if>
    <c:if test="${param.mobileTp eq 'Y' }">
    	<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
    </c:if> --%>
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
	
	<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/innks/NanumSquareRound/master/nanumsquareround.min.css">
	<link rel="stylesheet" type="text/css" href="/edu/css/new/bootstrap/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/edu/css/animate.min.css" />
    <link rel="stylesheet" type="text/css" href="/edu/css/common.css"  />
    <link rel="stylesheet" type="text/css" href="/edu/css/layout.css"  />
    <!-- <link rel="stylesheet" type="text/css" href="/edu/css/main.css"  /> -->
    <link rel="stylesheet" href="/edu/js/bm/swiper/swiper.min.css"/>
    <link rel="stylesheet" href="/edu/css/bm/animate.min.css"/>
    <link rel="stylesheet" href="/edu/css/bm/bootstrap.reset.css"/>
    <link rel="stylesheet" href="/edu/css/bm/common_prev.css"/>
    <link rel="stylesheet" href="/edu/css/bm/flaticon.css"/>
    <link rel="stylesheet" href="/edu/css/bm/ie.css"/>
    <link rel="stylesheet" href="/edu/css/bm/layout.css"/>
    <!-- <link rel="stylesheet" href="/edu/css/bm/main_prev.css"/> -->
    <link rel="stylesheet" href="/edu/css/bm/portfolio.css"/>
    <link rel="stylesheet" href="/edu/css/bm/search.css"/>
    <link rel="stylesheet" href="/edu/css/bm/sub.css"/>
    <link rel="stylesheet" href="/edu/css/bm/submain.css"/>
    <link rel="stylesheet" href="/edu/css/bm/common.css">
    <link rel="stylesheet" href="/edu/css/bm/wevenResponsive.css"/>
    <link rel="stylesheet" href="/edu/css/bm/main.css"/>
    <link rel="stylesheet" type="text/css" href="/edu/css/new/header.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/new/css.css"/>
	<link rel="stylesheet" type="text/css" href="/edu/css/new/footer.css"/>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    
    
    
    <script type="text/javascript" src="/edu/js/new/jquery-ui/jquery-1.12.4.min.js"></script>
    <script type="text/javascript"  src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
    <script type="text/javascript" src="/edu/js/common.js"></script>
    <script type="text/javascript"> subMenuOpenIng=true; </script>
    <!-- Slider -->
    <script type="text/javascript" src="/js/jquery.sticky.js"></script>
    <script type="text/javascript" src="/js/jquery.scrollTo.min.js"></script>
    <script type="text/javascript" src="/js/jquery.easing.1.3.js"></script>
    <script type="text/javascript" src="/js/jquery.appear.js"></script>
    <script type="text/javascript" src="/js/modernizr.min.js"></script>
    <script type="text/javascript" src="/js/ssl.js"></script>
    
    <script type="text/javascript" src="/edu/js/bm/swiper/swiper.min.js"></script>
    
    <script type="text/javascript" src="/edu/js/bm/rollingEvent.js"></script>
    
    <!-- Bootstrap JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="/edu/js/new/jquery-ui/jquery-ui-1.11.4/jquery-ui.min.js"></script>
	<script src="/edu/js/new/popper.min.js"></script>
	<script src="/edu/js/new/bootstrap/bootstrap.min.js"></script>

	<!-- 현재 메인 스크립트 -->
	<script type="text/javascript" src="/edu/js/new/mainHeader.js"></script>
	<script type="text/javascript" src="/edu/js/new/js.js"></script>
</head>

<body>
	<script type="text/javascript">
		//<![CDATA[
		function search2(form){
			if(!form.q.value){
				alert("검색어를 입력하세요.");
				$("#q2")[0].focus();
				return false;
			}
			return true;
		}	
			
		$(function() {
			$("#empmnForm").submit(function() {
				$("#keyword").val(encodeURIComponent($("#keywordStr").val()));
			});
			
			$("#headerPopupContainer").bind("click", function(evt){
				if(evt.target == $("#headerPopupContainer")[0]){
					location.href="https://edu.kocca.kr/micro/micMain.do";
				}
			});
			
			if(getCookie("divpop1") =="Y"){
				$("#headerPopupContainer").remove();
			}
			
		});
		$('.adClose').click(function(event) {
			$('.ad').slideToggle()
			$(this).toggleClass('off');
		});
		
		function closeTopPopup(key){
			if($("#todaycloseyn").prop("checked")){
	            setCookie('divpop'+key, 'Y' , 1 );
	        }
			$("#headerPopupContainer").remove();
		}
		
		function setCookie( name, value, expiredays ){
		    var todayDate = new Date();
		    todayDate.setDate( todayDate.getDate() + expiredays );
		    document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
	    }
		
		function getCookie(name) { 
	        var obj = name + "="; 
	        var x = 0; 
	        while ( x <= document.cookie.length ) { 
	            var y = (x+obj.length); 
	            if ( document.cookie.substring( x, y ) == obj ) { 
	                if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
	                    endOfCookie = document.cookie.length;
		                return unescape( document.cookie.substring( y, endOfCookie ) ); 
		        } 
		        x = document.cookie.indexOf( " ", x ) + 1; 
		        if ( x == 0 ) break; 
			} 
		        return ""; 
		}
		
        
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
        
		function fnCmdSearchList(gubun1, gubun2, gubun3, ordersnm, orders){
			$.post()
			$("#pGubun1").val(gubun1);
			$("#pGubun2").val(gubun2);
			$("#pGubun3").val(gubun3);
			$("#p_ordersnm").val(ordersnm);
			$("#p_orders").val(orders);
			
			$("#pageIndex").val("1");
			$("#frm").attr({
				action:"/edu/onlineEdu/realm/list.do?menuNo=500027",
				method:"post",
				target:"_self"
			});
			$("#frm").submit();
		}
		
		function fnManualDownLoad(){
			if(confirm("이용자 매뉴얼을 다운로드하시겠습니까?")) {
				window.open("https://edu.kocca.kr/upload/homepage/eduKocca_manual.pdf");
			}
		}
        
        //]]>
	</script>
	<!-- <div class="mainLayerPopup" style="position:absolute; top:5%; left:5%; z-index:9999; background:white; max-width:90%; text-align:right;">
		<a href="javascript:void(0);" onclick="$('.mainLayerPopup').css({'display':'none'})" style="display:inline-block; padding:8px 15px">
			<img src="/edu/images/bm/popup_alarm_close_btn.png">
		</a>
		<a href="https://edu.kocca.kr/edu/bbs/B0000011/view.do?nttId=74323&menuNo=500008" style="display:block;">
			<img src="/edu/new_image/main/mainLayerPopup.png">
		</a>
	</div> -->
	<!-- <div id="headerPopupContainer">
		<div class="container">
			<span>
				<input type='checkbox' name='todaycloseyn' id='todaycloseyn' value='Y'><label for="todaycloseyn">오늘 하루 그만보기</label>
				<button onclick='javascript:closeTopPopup(1);'>
					<img src="/edu/images/bm/btn_style_0_close.png" alt="오늘하루 그만보기 버튼">
				</button>
			</span>
		</div>
	</div> -->
	<div class="pop_newopen" style="width: 100%; height: 100%; position: fixed; background-color: rgb(0,0,0,0.5); z-index: 9999;">
		<div style="width: 500px; height: 500px; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
			<img src="/edu/images/main/poup_open.png" alt="홈페이지 공사중입니다">
			<button onclick="$('.pop_newopen').css({'display':'none'})" style="width:100%; height:60px; font-size:18px; font-weight: 600;">닫기</button>
		</div>
	</div>

	<style>
		@media screen and (max-width:1200px) {
			.pop_newopen img{width:100% !important; padding: 0 20px;}
		}
	</style>
	<div class="quick_menu">
		<ul>
			<li><a href="http://www.edukocca-vr.kr" target="_blank">성과<br/>전시관</a></li>
			<li><a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500159">나의<br/>강의실</a></li>
			<li><a href="/edu/onlineEdu/realm/list.do?p_ordersnm=ldate&p_orders=desc&menuNo=500027">온라인<br/>교육</a></li>
			<li><a href="/edu/bbs/B0000076/list.do?menuNo=500221">함께 : 톡톡</a></li>
			<li><a href="javascript:void(0)" onclick="fnManualDownLoad();">이용자<br/>매뉴얼</a></li>
			<li><a href="/edu/main/contents.do?menuNo=500090">원격<br/>지원</a></li>
		</ul>
	</div>
	
    <div id="wrap" class="over-hidden">
    	<header>
    		<div class="container h-100">
    			<div class="header_util_wrap">
    				<div class="show vm header_util_text_con">
    					<span class="show vm fontsize14 header_util_item">
							<a href="#visual_searchBox" class="ico3" title="본문으로" tabindex="1">본문으로</a>
						</span>
                        <sec:authorize ifAnyGranted="ROLE_USER">
				            <span class="show vm fontsize14 header_util_item header-name-tag">
                            	<span class="name_color"><c:out value="${userVO.userNm }"/></span>님 로그인중입니다.
                            </span>
				            <span class="show vm fontsize14 header_util_item">
				            	<a href="/edu/member/logout.do" class="ico4 logoutBtn" title="로그아웃">로그아웃</a>
				            </span>
				            <span class="show vm fontsize14 header_util_item" style="position:relative;" id="myPageMenu">
					            <a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" class="ico5" title="마이페이지">
					            	마이페이지
					            </a>
				            </span>
				        </sec:authorize>
				        <sec:authorize ifNotGranted="ROLE_USER">
				            <c:url var="loginUrl" value="/edu/member/forLogin.do">
				                <c:param name="menuNo" value="500077" />
				                <c:param name="_targetUrl" value="${_targetUrl}" />
				            </c:url>
				            <span class="show vm fontsize14 header_util_item">
                           		<a href="/edu/member/forLogin.do?menuNo=500077" class="ico1" title="로그인">로그인</a>
                           	</span>
				            <span class="show vm fontsize14 header_util_item">
				            	<a href="/edu/member/join01.do?menuNo=500076" class="ico2" title="회원가입">회원가입</a>
				            </span>
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
    			
    			<nav class="navbar navbar-expand-xl">
    				<a href="/" class="navbar-brand" title="콘텐츠인재캠퍼스 에듀코카 로고 - 콘텐츠인재캠퍼스 메인으로 이동">
			        	<img src="/edu/new_image/main/logo.png" alt="콘텐츠인재캠퍼스 에듀코카 로고 - 콘텐츠인재캠퍼스 메인으로 이동">
			        </a>
			        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main_nav" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
			        
			        <div class="collapse navbar-collapse" id="main_nav">
			        	<c:set var="topCategories" value="${menuAll5['menu_0']}" />
			        	<ul class="navbar-nav">
							<c:forEach var="x" begin="0" end="4">
				            	<li>
						            <c:if test="${x eq depth01}">
						                <c:set var="1depth_title" value="${topCategories[x].menuNm}"/>
						            </c:if>
				            		<a href="${topCategories[x].fullMenuLink}" ${x eq depth01 ? 'class="active"' : ''} ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''} >
				            			${topCategories[x].menuNm}
				            		</a>
						            <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						            <c:set var="d02Categories" value="${menuAll5[d02MenuKey]}" />
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
		                                            <c:choose>
		                                            	<c:when test="${topCategories[x].menuNo == '500108'}">
		                                            		<c:set var="d03Categories" value="${menuAll7[d03menuKey]}" />
		                                            	</c:when>
		                                            	<c:otherwise>
		                                            		<c:set var="d03Categories" value="${menuAll5[d03menuKey]}" />
		                                            	</c:otherwise>
		                                            </c:choose>									                    
								                    <c:if test="${fn:length(d03Categories)>0}">
				                       					<ul>
									                        <c:forEach var="z" begin="0"	end="${fn:length(d03Categories)-1}">
									                            <c:set var="clss2" value="${y eq depth02 && z eq depth03 ? 'on' : ''}" />
									                            <c:if test="${y eq depth02 && z eq depth03}">
									                                <c:set var="curD" value="${d03Categories[z]}" />
									                                <c:set var="curD03" value="${d03Categories[z]}" />
									                            </c:if>
									                            <c:if test="${d02Categories[y].menuNo eq '700001' || d02Categories[y].menuNo eq '700006' || d02Categories[y].menuNo eq '700005'}">
					                            					<li class="${clss2}">
					                            						<a	href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>
					                            							${d03Categories[z].menuNm}
					                            						</a>
					                            					</li>
					                            				</c:if>
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
			        </div>
			        <div class="ml-auto searchCon" style="height:29px;">
						<%-- <input type="image" src="/edu/images/bm/search_icon.png" id="all_search_label" style="padding:0;" alt="통합검색"> --%>
			        	<!-- 검색창 -->
				        <span class="show vm tl input_con">
<%-- 					        <form name="frmSearch2" method="post" action="/edu/search/list.do?menuNo=500079" onsubmit="return search2(this);">
						        <input type="text" class="q2" name="q" id="q2" placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">
						        <input type="image" src="/edu/images/bm/search_icon.png" alt="검색 확인" class="all_search_image">
					        </form> --%>
				        </span>
			        	<!-- //검색창 -->
			        	<input type="image" src="/edu/img/gnb_icon.png" class="gnb_menu" alt="GNB 메뉴" style="padding:0;">
			        	<input type="image" src="/edu/img/gnb_close.png" class="gnb_close" alt="GNB 메뉴 닫기" style="padding:0;">
					</div>
    			</nav>
    		</div>
    	</header>
        <!-- //header -->
        <div class="contents_section">
        	<div class="main_visual_contents">
                <div class="swiper-container" id="main_visual_slide" draggable="true">
                    <div class="swiper-wrapper">		
                        <div class="swiper-slide" style="background-image:url('/edu/new_image/background/new_visual_Image1.png'); background-size:cover; background-position:center;"></div>
                        <div class="swiper-slide" style="background-image:url('/edu/new_image/background/new_visual_Image2.png'); background-size:cover; background-position:center;"></div>
                        <div class="swiper-slide" style="background-image:url('/edu/new_image/background/new_visual_Image3.png'); background-size:cover; background-position:center;"></div>
                        <!-- //반복 -->
                    </div>
                </div>
                <div class="container">
                    <div class="visual_searchBox" id="visual_searchBox">
                    	<span>에듀코카</span>
                        <span>미래 콘텐츠 산업을 주도할<br/>융합형 창의 인재양성의 허브</span>
                        
                        <!-- <form>
                            <input type="text" id="all_search_keyword">
                            <label for="all_search_keyword">과정명을 입력하세요 <span>(태그검색)</span></label>
                            <a href="javascript:void(0);" class="all_search_btn"></a>
                        </form> -->
                    </div>
					<!-- 대메뉴 카드배너 -->
                    <div class="main_slide_banner">
        				<div class="swiper-container">
	        				<div class="swiper-wrapper">
		            			<!-- 반복 -->
		            			<c:forEach var="result" items="${mainPopupList }" varStatus="status">
			            			<div class="swiper-slide">
			            				<div>
				            				<span><c:out value="${result.nttCn}"/></span>
				            				<span class="abbreviation3">
				            					<c:set var="bannerText1" value="${result.ntcnNm}"/>
				            					<c:out escapeXml="false" value="${fn:replace(bannerText1, '　', '<br>')}"/>
				            				</span>
				            				<a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank" title="새창열림"</c:if>">바로가기</a>
										</div>
			            			</div>
		            			</c:forEach>
		            			<!-- //반복 -->
			            	</div>
			            </div>
			            <div class="main-slide-banner-button-contents">
				            <div class=" swiper-pagination"></div>
				            <button class="swiper-button-play"><img src="/edu/new_image/icon/play_icon.png" alt="배너 재생"></button>
		   					<button class="swiper-button-pause"><img src="/edu/new_image/icon/pause_icon.png" alt="배너 정지"></button>
    					</div>
        			</div>
                    
                    <div class="visual_menu_icon">
                    	<ul>
                    		<li>
                    			<a href="/edu/onlineEdu/realm/list.do?p_ordersnm=ldate&p_orders=desc&menuNo=500027">
                    				<img src="/edu/new_image/icon/mainIcon01.png" alt="정규과정 아이콘">
                    				<span>정규과정</span>
                    			</a>
                    		</li>
                    		<li>
                    			<a href="/edu/onlineEdu/openLecture/list.do?sortOrder=newOrdr&menuNo=500085">
                    				<img src="/edu/new_image/icon/mainIcon02.png" alt="열린강좌 아이콘">
                    				<span>열린강좌</span>
                    			</a>
                    		</li>
                    		<li>
                    			<a href="/edu/onlineEdu/edcsystm/list.do?menuNo=500207">
                    				<img src="/edu/new_image/icon/mainIcon04.png" alt="교육체계도 아이콘">
                    				<span>교육체계도</span>
                    			</a>
                    		</li>
                    		<li>
                    			<a href="/edu/bbs/B0000048/list.do?menuNo=500205">
                    				<img src="/edu/new_image/icon/mainIcon05.png" alt="이벤트 아이콘">
                    				<span>이벤트</span>
                    			</a>
                    		</li>
                    		<li>
                    			<a href="/edu/main/contents.do?menuNo=500033">
                    				<img src="/edu/new_image/icon/mainIcon07.png"  alt="학습지원 아이콘">
                    				<span>학습지원</span>
                    			</a>
                    		</li>
                    		<li>
                    			<a href="/edu/main/contents.do?menuNo=500005">
                    				<img src="/edu/new_image/icon/mainIcon08.png" alt="기업맞춤교육지원 아이콘">
                    				<span>기업맞춤교육지원</span>
                    			</a>
                    		</li>
                    	</ul>
                    </div>
                    
                </div>
            </div>
        	<div class="main_online_contents">
        		<div class="container">
        			<span class="main_title">온라인 교육</span>
        			<form id="frm" name="frm" action="/edu/onlineEdu/realm/list.do?menuNo=50027" method="post" class="main_online_category">
        				<input type="hidden" name="pGubun1" id="pGubun1" value="">
        				<input type="hidden" name="pGubun2" id="pGubun2" value="">
        				<input type="hidden" name="pGubun3" id="pGubun3" value="">
        				<input type="hidden" name="p_ordersnm" id="p_ordersnm" value="ldate">
        				<input type="hidden" name="p_orders" id="p_orders" value="desc">
        				<input type="hidden" name="pageIndex" id="pageIndex" value="">
	       				<div>
	       					<div>
		       					<span class="title_large">온라인 교육</span>
		       					<span class="title_small">ONLINE EDUCATION</span>
		       					<span></span>
	       					</div>
	       					<img src="/edu/new_image/main/onlineCategory01.jpg" alt="온라인교육">
	       				</div>
	       				<div>
	       					<div>
		       					<span class="title_small">BROADCAST VIDEO</span>
		       					<span class="title_large">방송영상</span>
		       					<a href="javascript:void(0);" onclick="fnCmdSearchList('B0', '', '', '', ''); return falst;">
		       						바로가기
		       					</a>
	       					</div>
	       					<img src="/edu/new_image/main/onlineCategory02.jpg" alt="방송영상">
	       				</div>
	       				<div>
	       					<div>
		       					<span class="title_small">GAME PRODUCTION</span>
		       					<span class="title_large">게임</span>
		       					<a href="javascript:void(0);" onclick="fnCmdSearchList('G0', '', '', '', ''); return false;">
		       						바로가기
		       					</a>
	       					</div>
	       					<img src="/edu/new_image/main/onlineCategory03.jpg" alt="게임">
	       				</div>
	       				<div>
	       					<div>
		       					<span class="title_small">CARTOON & CHARACTER</span>
		       					<span class="title_large">만화/애니/캐릭터</span>
		       					<a href="javascript:void(0);" onclick="fnCmdSearchList('K0', '', '', '', ''); return false;">
		       						바로가기
		       					</a>
	       					</div>
	       					<img src="/edu/new_image/main/onlineCategory04.jpg" alt="만화/애니/캐릭터">
	       				</div>
	       				<div>
	       					<div>
		       					<span class="title_small">CULTURE</span>
		       					<span class="title_large">문화일반</span>
		       					<a href="javascript:void(0);" onclick="fnCmdSearchList('O0', '', '', '', ''); return false;">
		       						바로가기
		       					</a>
	       					</div>
	       					<img src="/edu/new_image/main/onlineCategory05.jpg" alt="문화일반">
	       				</div>
	       				<div>
	       					<div>
		       					<span class="title_small">HUMANITIES MANAGEMENT LIBERAL ARTS</span>
		       					<span class="title_large">인문/경영/교양</span>
		       					<a href="javascript:void(0);" onclick="fnCmdSearchList('S0', '', '', '', ''); return false;">
		       						바로가기
		       					</a>
		       				</div>
		       				<img src="/edu/new_image/main/onlineCategory06.jpg" alt="인문/경영/교육">
	       				</div>
        			</form>
        		</div>
        	</div>
        	
        	<div class="main_news_contents">
        		<div class="container">
        			<span class="main_title">소식</span>
        			
        			<div class="news_slide_banner">
        				<div class="swiper-container">
	        				<div class="swiper-wrapper">
		            			<!-- 반복 -->
		            			<c:forEach var="result" items="${mainPopupList }" varStatus="status">
			            			<div class="swiper-slide">
			            				<a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank" title="새창열림"</c:if>">
			            					<!--  <span style="display: none;">배너입니다.</span> -->
		                                    <img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&fileSn=<c:out value="${result.fileSn}"/>"  alt="<c:out value="${result.ntcnNm}"/>">
		                                </a>
			            			</div>
		            			</c:forEach>
		            			<!-- //반복 -->
			            	</div>
			            </div>
			            <div class="wrap-autoplay-control">
						    <button class="start" aria-pressed="true" aria-label="자동 재생 시작" title="자동 재생 시작"></button>
						    <button class="stop" aria-pressed="false" aria-label="자동 재생 일시 정지" title="자동 재생 일시 정지"></button>
						</div>
			            <div class=" swiper-pagination"></div>
        			</div>
        			<div class="news_notice_list">
        				<span class="title">공지사항</span>
        				<div class="list_box">
                            <ul>
                            	<c:forEach var="result" items="${B0000011List}" end="3" varStatus="status">
	                                <li>
	                                    <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008">
	                                        <span class="abbreviation<c:if test="${status.first}">2</c:if>"><c:out value="${result.nttSj}"/></span>
	                                        <span>
	                                        	<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd" value="${fn:substring(result.regDate,0,10)}"/>
	                                        	<fmt:formatDate var="dateTempParse" pattern="yyyy.MM.dd" value="${dateFmt}"/>
	                                        	<c:out value="${dateTempParse}"/>
	                                        </span>
	                                    </a> 
	                                </li>
								</c:forEach>
                            </ul>
                        </div>
                        <a href="/edu/bbs/B0000011/list.do?menuNo=500008">더보기</a>
        			</div>
        			<div class="news_archive_list" style="padding: 0;">
        				<div class="list_box" style="margin: 0;">
            				<a href="/edu/bbs/B0000011/view.do?nttId=75072&delCode=0&menuNo=500008&pageIndex=1" style="width: 100%;">
                                <img src="/archive/images/mainArchiveBanner.png" alt="에듀코카(eduKOCCA) 수어자막 서비스 OPEN" style="width: 100%; height: 312px;">
                            </a>
			            </div>
			            <a href="/edu/onlineEdu/realm/list.do?p_ordersnm=ldate&p_orders=desc&menuNo=500027">더보기</a>
        			</div>
        		</div>
        	</div>
        	<div class="main_offline_contents">
                <div class="container">
                    <ul>
                        <li>
                            <span>오프라인교육</span>
                            <div>
                            	<ul>
	                            	<c:forEach var="result" items="${offlineEduList}" varStatus="status" end="2">
		                            	<c:choose>
										    <c:when test="${result.prgCl eq '12'}">
										       <c:set var="subMenuNum" value="500216" />
										    </c:when>
										    <c:when test="${result.prgCl eq '13'}">
										       <c:set var="subMenuNum" value="500215" />
										    </c:when>
										    <c:when test="${result.prgCl eq '16'}">
										       <c:set var="subMenuNum" value="500224" />
										    </c:when>
										    <c:when test="${result.prgCl eq '14'}">
										       <c:set var="subMenuNum" value="500219" />
										    </c:when>
										</c:choose>		
		                                <li>
		                                   <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=${subMenuNum}&prgSe=01&prgCl=${result.prgCl}&siteSe=edu&pageIndex=1">
		                                       <span class="abbreviation"><c:out value="${result.prgNm}" /></span>
		                                       <span>${fn:substring(result.prgBgnde,0,10)}</span>
		                                   </a> 
		                                </li>
	                                </c:forEach>
	                            </ul>
                            </div>
                        </li>
                        <li>
                            <span>교육지원사업</span>
                            <div>
                            	<ul>
	                            	<c:forEach var="result" items="${eduSuportList}" varStatus="status" end="2">
		                            	<c:choose>
										    <c:when test="${result.bbsId eq 'B0000041'}">
		                        				<c:set var="subMenuNum" value="500211" />
										    </c:when>
										    <c:when test="${result.bbsId eq 'B0000072'}">
										       <c:set var="subMenuNum" value="500212" />
										    </c:when>
										</c:choose>			
                        				<li>
	                        				<a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&delCode=0&menuNo=${subMenuNum}&pageIndex=1" style="width:100%;">
	                                            <span class="abbreviation">${result.nttSj}</span>
	                                            <span>${result.frstRegistPnttm}</span>
		                                    </a>
                        				</li>
	                        		</c:forEach>
                            	</ul>
                            </div>
                        </li>
                        <li>
                            <span>콘텐츠인재캠퍼스 시설 안내</span>
                            <div></div>
                            <a href="/testbed/main/contents.do?menuNo=700135">바로가기</a>
                        </li>
                        <li>
                            <span>콘텐츠문화광장 시설 안내</span>
                            <div></div>
                            <a href="/testbed/main/contents.do?menuNo=700108">바로가기</a>
                        </li>
                    </ul>
                </div>
            </div>
        	
        </div>
        <!-- footer -->
        <div id="menu5" class="menu5">
        	<jsp:include page="/WEB-INF/jsp/edu/inc/eduFooter.jsp" flush="true" />
        </div>
        <!-- //footer -->
    </div>
</body>
</html>