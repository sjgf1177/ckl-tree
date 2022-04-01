<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/WEB-INF/error/500.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper"%>
<%@ page import="kr.co.unp.member.vo.UsersVO"%>
<%@ page import="kr.co.unp.util.WebFactory"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.util.ZValue"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
ZValue zvl = WebFactory.getAttributes(request);
org.springframework.context.ApplicationContext context =
org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

HashMap<String, List<MenuManageVO>> adminMenuMap = (HashMap<String, List<MenuManageVO>>)session.getAttribute("adminMenuMap");
MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(adminMenuMap, zvl.getInt("menuNo", 0));
currentVo = masterMenuManagerService.getCurrentMenuCategory(adminMenuMap, currentVo.getPosition());
pageContext.setAttribute("currMenu", currentVo);

String position = currentVo.getPosition();
int depth01 = Integer.parseInt(position.substring(0,2)) -1;
int depth02 = Integer.parseInt(position.substring(2,4)) -1;
int depth03 = Integer.parseInt(position.substring(4,6)) -1;
int depth04 = Integer.parseInt(position.substring(6,8)) -1;
int depth05 = Integer.parseInt(position.substring(8,10)) -1;
int depth06 = Integer.parseInt(position.substring(10,12)) -1;
pageContext.setAttribute("depth01", depth01);
pageContext.setAttribute("depth02", depth02);
pageContext.setAttribute("depth03", depth03);
pageContext.setAttribute("depth04", depth04);
pageContext.setAttribute("depth05", depth05);
pageContext.setAttribute("depth06", depth06);

UsersVO adminUser = UnpUserDetailsHelper.getAuthenticatedUser();
pageContext.setAttribute("adminUser", adminUser);
%>
<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />
<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자(#번서버)</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap-theme.css" />
<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/bosLayout.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/newrepair.css" />
<style>
body{background-image: none;background-color: #fff;}
#container{padding: 0;max-width:none;border: none;}
.cateSet{position: static;text-align: right;}
.cateSet:after{content: '';display: block;clear: both;height: 10px;}
.eventList{clear: both;margin-top: 10px;}
</style>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/bootstrap/respond.min.js"></script>



<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.highlight-4.js"></script>
<script type="text/javascript" src="/js/jquery.maskedinput.min.js"></script>
<script type="text/javascript" src="/js/base64.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/bos/js/common.js"></script>
<script type="text/javascript" src="/js/ssl.js"></script>
<script type="text/javascript" src="/bos/js/newrepairJS.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script type="text/javascript" src="/js/selectivizr-min.js"></script>
<script type="text/javascript" src="/js/html5shiv.js"></script><script type="text/javascript" src="js/respond.min.js"></script>
<![endif]-->

<script type="text/javascript">
	$(function(){
		$("#search").click(function(){
			search();
		});
		$("#searchTxt").bind("keyup", function(event){
			search();
		});

		$(".gnbParentMenu").click(function() {
			if ($(this).closest("li").find("li").size() > 0) {
				location.href = $(this).closest("li").find("li").children("a").attr("href");
				return false;
			}
		});

		$(".lnbParentMenu").click(function() {
			if ($(this).closest("li").find("li").size() > 0) {
				location.href = $(this).closest("li").find("li").children("a").attr("href");
				return false;
			}
		});
	});
	function search(){
		var searchTxt = $("#searchTxt").val();
		if(searchTxt)
		{
			$("#lnb ul li").each(function(){
				var text = $(this).text();
				var showMenu = (text.indexOf(searchTxt) != -1) || (cho_hangul(text).indexOf(searchTxt) != -1);
				if( showMenu ){
					$(this).show();
				} else {
					if($(this).parent())
						$(this).hide();
				}
			});
		} else {
			$("#lnb ul li").show();
		}
	}

	function cho_hangul(str) {
	  cho = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"];
	  result = "";
	  for(i=0;i<str.length;i++) {
	    code = str.charCodeAt(i)-44032;
	    if(code>-1 && code<11172) result += cho[Math.floor(code/588)];
	  }
	  return result;
	}

	function pagePrint(Obj) {
		alert(Obj);
	    var W = Obj.offsetWidth;        //screen.availWidth;
	    var H = Obj.offsetHeight;        //screen.availHeight;
	    var features
	= "menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=" + W
	+ ",height=" + H + ",left=0,top=0";
	    var PrintPage = window.open("about:blank",Obj.id,features);
	    PrintPage.document.open();
	    PrintPage.document.write("\n\n" + Obj.innerHTML + "\n");
	    PrintPage.document.close();
	    PrintPage.document.title = document.domain;
	    PrintPage.print(PrintPage.location.reload());
	}

	//pagePrint(document.getElementById('content'));
	 function print_area()
	 {
		  var W=document.documentElement.clientWidth; if(!W){W=document.body.clientWidth;}
		  var H=document.documentElement.clientHeight; if(!H){H=document.body.clientHeight;}
		  var features = "menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=" + W + ",height=" + H + ",left=0,top=0";
		  var PrintPage = window.open("about:blank","tmp_print",features);
		  PrintPage.document.open();
		  PrintPage.document.write("<html><head><title></title></head><body>" + document.getElementById('content').innerHTML + "</body></html>");
		  PrintPage.document.close();
		  PrintPage.print();
		  PrintPage.close();
	 }

	 function printf(){
		 document.frames['contentFrame'].focus();
		 document.frames['contentFrame'].print();
		 //document.frames['contentFrame'].contentWindow.location.href="/bos/forprint.jsp";
	 }

	 function println(){
		 window.open('/bos/forprint.jsp', 'popwin', 'left=20,top=20,width=616,height=700');
		 document.frames['contentFrame'].focus();
		 //document.frames['contentFrame'].print();
	 }

	function openPopup()
	{
		url = "/bos/member/forUpdateMy.do?viewType=BODY";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=1000, height=700");
	}
</script>
</head>
<body>
	<div id="wrap">

		<div id="header_wrap">
			<div class="header">
				<h1><a href="/bos/main/main.do"><img src="/images/common/logo.png" alt="<spring:message code="site.slogan" text=""/>" /></a></h1>
				<p class="user bold"><span class="color1">[${adminUser.deptNm}]${adminUser.userNm}(${adminUser.userId})</span>님 로그인 접속IP:${userIp}</p>
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />

				<div class="util btn-group">
					<c:if test="${fn:length(topCategories)>0}">
						<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
							<c:choose>
							<c:when test="${x==0}"><c:set var="iconClass" value="fa-cogs" /></c:when>
							<c:when test="${x==1}"><c:set var="iconClass" value="fa-search" /></c:when>
							</c:choose>
			 			<c:if test="${topCategories[x].menuPopupYn=='Y'}">
							<a href="${topCategories[x].menuLink}" target="_blank" title="새창열림" class="btn btn-primary"><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
			 			<c:if test="${topCategories[x].menuPopupYn!='Y'}">
							<a href="${topCategories[x].menuLink}${fn:indexOf(topCategories[x].menuLink,'?') > -1 ? '&' : '?' }menuNo=${topCategories[x].menuNo}" class="btn btn-primary"><i class="fa ${iconClass}"></i> ${topCategories[x].menuNm}</a>
			 			</c:if>
						</c:forEach>
						<a href="javascript:openPopup();"class="btn btn-success"><i class="fa fa-power-off"></i>내정보수정</a>
						<a href="/bos/member/logout.do" class="btn btn-info"><i class="fa fa-power-off"></i> 로그아웃</a>
					</c:if>
				</div>
			</div>

			<div id="gnb">
			<c:if test="${fn:length(d02Categories)>0}">
				<ul class="gnb_width">
		 	<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth02}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(d02Categories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${d02Categories[y].menuPopupYn=='Y'}">
						<a href="${d02Categories[y].menuLink}" target="_blank" title="새창열림">${d02Categories[y].menuNm}</a>
		 			</c:if>
		 			<c:if test="${d02Categories[y].menuPopupYn!='Y'}">
						<a href="${d02Categories[y].menuLink}${fn:indexOf(d02Categories[y].menuLink,'?') > -1 ? '&' : '?' }menuNo=${d02Categories[y].menuNo}" >${d02Categories[y].menuNm}</a>
		 			</c:if>

		 			<c:set var="d02MenuKey" value="menu_${d02Categories[y].menuNo}" />
					<c:set var="d03Categories" value="${adminMenuMap[d02MenuKey]}" />
		 			<ul style="display:none;">
		 				<li></li>
		 			</ul>

		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			</div>

			<%--
			<div id="gnb">
				<c:set var="topCategories" value="${adminMenuMap['menu_0']}" />
				<c:set var="menuKey" value="menu_${topCategories[depth01].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuMap[menuKey]}" />
				<c:set var="d02Category" value="${d02Categories[depth02]}" />
				<c:set var="topCategory" value="${topCategories[depth01]}" />
			<c:if test="${fn:length(topCategories)>0}">
				<ul class="gnb_width">
		 	<c:forEach var="y" begin="0" end="${fn:length(topCategories)-1}">
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${y==depth01}"><c:set var="clss" value="class='on'" /></c:when>
	 			<c:when test="${y==fn:length(topCategories)-1}"><c:set var="clss" value="class='pr0'" /></c:when>
	 			</c:choose>
	 			<li ${clss}>
		 			<c:if test="${topCategories[y].menuPopupYn=='Y'}">
						<a href="${topCategories[y].menuLink}" target="_blank">${topCategories[y].menuNm}</a>
		 			</c:if>
		 			<c:if test="${topCategories[y].menuPopupYn!='Y'}">
						<a href="${topCategories[y].fullMenuLink}" >${topCategories[y].menuNm}</a>
		 			</c:if>
		 		</li>
			</c:forEach>
				</ul>
			</c:if>
			</div>
			--%>
		</div>

		<div id="container" class="clearfix" >
			<div id="lnb">

				<h2>${d02Category.menuNm}</h2>
				<!-- <p><input type="text" name="searchTxt" id="searchTxt" value="" /> <label for="search"><a id="search" href="#search">조회</a></label></p> -->

		<c:set var="d02MenuKey" value="menu_${d02Category.menuNo}" />
		<c:set var="d03Categories" value="${adminMenuMap[d02MenuKey]}" />
		<c:if test="${fn:length(d03Categories)>0}">
				<ul>
		 	<c:forEach var="x" begin="0" end="${fn:length(d03Categories)-1}">
				<c:set var="popupYn" value="${d03Categories[x].menuPopupYn}"/>
				<c:set var="clss" value=""/>
	 			<c:choose>
	 			<c:when test="${x==depth03}"><c:set var="clss" value="class='on'" /></c:when>
	 			</c:choose>
				<li>
		 			<c:if test="${popupYn=='Y'}">
						<a href="${d03Categories[x].menuLink}" title="${d03Categories[x].menuLink}" target="_blank" title="새창열림">${d03Categories[x].menuNm}</a>
		 			</c:if>
		 			<c:if test="${popupYn!='Y'}">
						<a href="${d03Categories[x].menuLink}${fn:indexOf(d03Categories[x].menuLink,'?') > -1 ? '&' : '?' }menuNo=${d03Categories[x].menuNo}" title="${d03Categories[x].menuLink}" >${d03Categories[x].menuNm}</a>
		 			</c:if>
				<c:set var="d03MenuKey" value="menu_${d03Categories[x].menuNo}" />
				<c:set var="d04Categories" value="${adminMenuMap[d03MenuKey]}" />
				<c:if test="${fn:length(d04Categories)>0}">
						<ol>
		 		<c:forEach var="y" begin="0" end="${fn:length(d04Categories)-1}">
				<c:set var="popupYn" value="${d04Categories[y].menuPopupYn}"/>
						<c:set var="clss2" value=""/>
			 			<c:choose>
			 			<c:when test="${x==depth03&&y==depth04}"><c:set var="clss2" value="class='on'" /></c:when>
			 			</c:choose>
							<li>
				 			<c:if test="${popupYn=='Y'}">
								<a href="${d04Categories[y].menuLink}" title="${d04Categories[y].menuLink}" target="_blank" title="새창열림">${d04Categories[y].menuNm}</a>
				 			</c:if>
				 			<c:if test="${popupYn!='Y'}">
								<a href="${d04Categories[y].menuLink}${fn:indexOf(d04Categories[y].menuLink,'?') > -1 ? '&' : '?' }menuNo=${d04Categories[y].menuNo}" title="${d04Categories[y].menuLink}" >${d04Categories[y].menuNm}</a>
				 			</c:if>
							<c:set var="d04MenuKey" value="menu_${d04Categories[y].menuNo}" />
							<c:set var="d05Categories" value="${adminMenuMap[d04MenuKey]}" />
							<c:if test="${fn:length(d05Categories)>0}">
								<ol>
				 			<c:forEach var="z" begin="0" end="${fn:length(d05Categories)-1}">
								<c:set var="popupYn" value="${d05Categories[z].menuPopupYn}"/>
								<c:set var="clss3" value=""/>
					 			<c:choose>
					 			<c:when test="${x==depth03&&y==depth04&&z==depth05}"><c:set var="clss3" value="class='on'" /></c:when>
					 			</c:choose>
									<li><a href="${d05Categories[z].menuLink}${fn:indexOf(d05Categories[z].menuLink,'?') > -1 ? '&' : '?' }menuNo=${d05Categories[z].menuNo}" title="${d05Categories[z].menuNo}">${d05Categories[z].menuNm}</a></li>
							</c:forEach>
								</ol>
							</c:if>
							</li>
					</c:forEach>
						</ol>
				</c:if>
					</li>
				</c:forEach>
				</ul>
		</c:if>

			</div>
			<div id="content">

				<div class="hgroup clearfix">
					<h3 class="fl">${currMenu.menuNm}</h3>
					<div class="fr">
						<a class="btn btn-sm btn-success" href="/bos/forprint.jsp" id="print" title="새창" onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i><span >인쇄하기</span></a>
					</div>
				</div>

				<c:choose>
				<c:when test="${not empty cvCon}">
					${cvCon}
				</c:when>
				<c:otherwise>
					<c:set var="_includePage" value="" />
					<c:choose>
						<c:when test="${not empty param.incPage}"><c:set var="_includePage" value="${incPage}" /></c:when>
						<c:when test="${empty includePage}"><c:set var="_includePage" value="${currMenu.contentsPath}" /></c:when>
						<c:otherwise><c:set var="_includePage" value="${includePage}" /></c:otherwise>
					</c:choose>
					<c:catch var ="catchException">
						<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true" />
					</c:catch>
				</c:otherwise>
				</c:choose>

			</div>
		</div>
		<!-- quick -->
		<!-- <div id="quick">
			<div class="btn-group-vertical" role="group">
			<a href="/bos/wordDicary/list.do" class="btn btn-default" target="contentFrame"><span class="text-info"><i class="fa fa-book fs25"></i><br />행정용어사전</span></a>
			<a href="/bos/metaDataSearch/list.do" class="btn btn-default" target="contentFrame"><span class="text-info"><i class="fa fa-search-plus fs25 text-info"></i><br />메타데이터검색</span></a>
			<a href="/bos/guide/index.html" class="btn btn-default" target="_blank"><span class="text-info"><i class="fa fa-link fs25 text-info"></i><br />GUIDE</span></a>
			</div>
		</div>
		<script type="text/javascript">
		//퀵메뉴 스크롤링
		function quick(){
			var quick_menu = jQuery('#quick');
			var quick_top = 230;

			quick_menu.css('top', jQuery(window).height);
			quick_menu.animate({"top": jQuery(document).scrollTop() + quick_top + "px"}, 500);

			$(window).scroll(function(){
				quick_menu.stop();
				quick_menu.animate({"top" : jQuery(document).scrollTop() + quick_top + "px"}, 1000);
			});
		}
		quick();
		</script> -->
		<!-- //quick -->

	</div>


	<jsp:include page="./bosBottom.jsp" flush="true" />

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>