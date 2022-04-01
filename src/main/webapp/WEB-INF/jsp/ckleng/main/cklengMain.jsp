<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<%@page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@page import="kr.co.unp.banner.vo.Banner"%>
<%@page import="kr.co.unp.banner.service.BannerService"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

	String menuNo = request.getParameter("menuNo");
	if( StringUtils.hasText(menuNo) ) {

		org.springframework.context.ApplicationContext context =
		org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll3");
		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
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
	}
%>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<!-- <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" /> -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Content Korea Lab</title>
	<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/ckleng/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/ckleng/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="/ckleng/css/main.css" />

	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
	<script type="text/javascript" src="/js/modernizr.min.js"></script>
	<script type="text/javascript" src="/js/ssl.js"></script>
	<script type="text/javascript" src="/ckleng/js/main.js"></script>

	<script type="text/javascript">
	//<![CDATA[

	$(function() {

		$(".logoutBtn").click(function() {

			$.get("/ckleng/member/logout.json",function(data) {
				location.href="${ssoDomain}/sso/member/logoutSSO.do?service=ckl";
			},"json");
			return false;
	     });

	});

	function search2(form){
		if(!form.q.value){
			alert("검색어를 입력하세요.");
			$("#q2")[0].focus();
			return false;
		}
		return true;
	}
	//]]>
	</script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="/js/bootstrap/html5shiv.min.js"></script>
  <script src="/js/respond.min.js"></script>
  <script>
  $('html').attr('id','ie');
//  $('#responsive').remove();
  </script>
<![endif]-->

</head>
<body>

<!-- <div class="debug" style="position:absolute;z-index:-100;width:100%;height:1900px;
	background:url(/ckleng/images/tmp/_main.jpg) no-repeat center top; opacity:0.3;filter: invert(1);
	-webkit-filter: invert(1);
	-moz-filter: invert(1);
	-o-filter: invert(1);
	-ms-filter: invert(1);display:block;">
</div> -->

<ul class="skip">
	<li><a href="#container">Go to Contents</a></li>
	<li><a href="#gnb">Go to Menu</a></li>
</ul>

<div id="wrap">
	<div class="globalSet">
		<ul class="globalLink">
			<li><a href="http://eng.kocca.kr/en/main.do" target="_blank" title="New Window">Korea Creative Content Agency<span class="mainIcos icoArr"></span></a></li>
			<li><a href="https://edu.kocca.kr" target="_blank" title="New Window">Korea Contents Academy<span class="mainIcos icoArr"></span></a></li>
		</ul>
		<ul class="globalUtil">
			<li class="mr20"><a href="/ckl/main/main.do">Korean</a></li>
		</ul>
	</div>
	<div class="mainVisualSet">
		<!-- header -->
		<div id="header">
			<div class="logoSet">
				<p class="mCommon orgLogo"><span class="hidden">Small but bright idea develops into global contents ! </span></p>
				<h1 class="mCommon logo"><a href="/ckleng/main/main.do"><span class="hidden">Content korea lab</span></a></h1>
			</div>

			<div id="gnb">
				<c:set var="topCategories" value="${menuAll3['menu_0']}" />
				<ul>
					<c:forEach var="x" begin="0" end="3">
						<li id="smenu${x+1}" ${x eq depth01 ? 'class="on"' : ''}><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
						<%-- <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
						<c:if test="${fn:length(d02Categories)>0}">
						<ul>
							<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
								<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
							</c:forEach>
						</ul>
						</c:if> --%>
					</li>
					</c:forEach>
				</ul>

				<!-- 전체메뉴 열기 -->
				<div class="gnbTotMenu"><a href="#self"><span class="hidden">Open Total Menu</span></a></div>
				<div class="totMenuT">
					<c:forEach var="x" begin="0" end="3">
						<dl class="tms${x+1}">
							<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
								<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
								<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
								<c:if test="${fn:length(d02Categories)>0}">
								<dd>
								<ul>
									<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
										<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
									</c:forEach>
								</ul>
								</dd>
								</c:if>
						</dl>
					</c:forEach>
					<a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">Close Total Menu</span></a>
				</div>
				<!-- 전체메뉴 열기 -->
			</div>
		</div>
		<!-- //header -->

		<!-- visualText -->
		<div class="mainVisuals">
			<div class="hidden">
				<ul>
					<li>Idea integrating factory</li>
					<li>Start-up station</li>
					<li>Contents start-up league</li>
					<li>Korea's imagination camp </li>
					<li>Start-up masters</li>
				</ul>
				<p>Small but bright idea develops into global contents !</p>
			</div>

			<!-- <a href="/ckleng/main/contents.do?menuNo=200006" class="labGo"><span class="hidden">LOCAL LABS</span></a> -->
		</div>
		<!-- //visualText -->
	</div>



	<!-- container -->
	<div id="container">
		<div class="lastestSet">

			<div class="useInfo">
				<h2><a href="#self" style="text-transform:uppercase;">Facility use guideline</a></h2>
				<div class="infoBox">
					<div class="pl20">
						<h3>Public space</h3>
						<p>The use of the area is
							<br />allowed after receiving an
							<br />access card at an
							<br />operation desk.</p>
						<ul>
							<li>2F - Library, lounge</li>
							<li>10F - Park, idea village</li>
						</ul>
					</div>
				</div>

				<div class="infoBox">
					<div>
						<h3>Reserve an area</h3>
						<p>Reserve an area (log-in)
							<br />at our website.
							<br />This needs an approval
							<br />from the administrator.</p>
						<ul>
							<li>2F - Creation facility, meeting room</li>
							<li>14F - Creation facility</li>
						</ul>
					</div>
				</div>
				<div class="posa">
					<a href="/ckleng/fcltyResve/fclty/list.do?menuNo=300032"  style="text-transform:uppercase;"><span class="mainIcos mCal"></span>Facility introduction<span class="mainIcos icoArrB"></span></a>
				</div>
			</div>


			<div class="notice">
				<h2><a href="/ckleng/bbs/B0000050/list.do?menuNo=300030">FAQ</a></h2>
				<ul class="bull mb30">
					<c:forEach var="result" items="${B0000050List}" varStatus="status">
						<li><a href="/ckleng/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=300030"><c:out value="${result.nttSj}"/></a></li>
					</c:forEach>
					<c:if test="${fn:length(B0000050List) == 0}"><li>no Data.</li></c:if>
				</ul>
				<div class="tac">
					<a href="/ckleng/bbs/B0000050/list.do?menuNo=300030" class="more"><span class="hidden">Go to FAQ</span></a>
				</div>
			</div>


			<div class="pdsSet">
				<h2><a href="#self">ARCHIVES</a></h2>
				<ul>
					<li><a href="http://www.kocca.kr/cop/bbs/list/B0000141.do?menuNo=200898" target="_blank" title="New Window" ><span class="psdIco1"></span>Periodicals</a></li>
					<li><a href="http://www.kocca.kr/cop/bbs/list/B0000147.do?menuNo=200904" target="_blank" title="New Window" ><span class="psdIco2"></span>Reports</a></li>
					<li><a href="http://www.kocca.kr/cop/bbs/list/B0000180.do?menuNo=200953" target="_blank" title="New Window" ><span class="psdIco3"></span>Seminar</a></li>
					<li><a href="http://library.kocca.kr/index.jsp" target="_blank" title="New Window" ><span class="psdIco4"></span>Library</a></li>
					<li class="mr0"><a href="http://www.kocca.kr/cop/bbs/list/B0000262.do?menuNo=201731" target="_blank" title="New Window" ><span class="psdIco5"></span>Webzine</a></li>
				</ul>
				<div class="posa">
					<a href="#self" style="text-transform:uppercase;">Korea Creative Content Agency<span class="mainIcos icoArr"></span></a>
				</div>
			</div>
		</div>
	</div>
	<!-- //container -->


	<div class="tailer">
		<div class="totMenuF">
			<c:forEach var="x" begin="0" end="4">
				<dl class="tmenu${x+1}">
					<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
						<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
						<c:if test="${fn:length(d02Categories)>0}">
					<dd>
						<ul>
							<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
								<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
							</c:forEach>
						</ul>
					</dd>
						</c:if>
				</dl>
			</c:forEach>
		</div>


		<!-- footer -->
		<div id="footer">
			<div class="fset">
				<div class="fl fLogoSet">
					<div class="fImages fLogo"><span class="hidden">Korea Creative Content Agency</span></div>
				</div>
				<div class="fContents">
					<div class="copyright">
						<address>
							Headquarters : [58217] Gyoyookgil 35, Najusi, JeollaNamdo, KOCCA | Business registration : 105-82-17272 <br />
							Daehakro office : [03082] Daehakro 57, Jongrogu, Seoul Contents Korea Lab | TEL : (+82-2) 2161-0000
						</address>
					</div>
					<div class="copy">Copyright 2015. Korea Creative Content Agency all rights reserved.</div>
				</div>
			</div>
		</div>
		<!-- //footer -->
	</div>

</div>



<!--[if lte IE 7]>
<script type="text/javascript">
//<![CDATA[
	$('*').each(function(index) {
		if ($(this).css("overflow")=="hidden"){
			$(this).css("zoom",1);
		}
		if ($(this).css("display")=="inline-block"){
			$(this).css("display",'inline');
			$(this).css("zoom",1);
		}
	});
//]]>
</script>
<![endif]-->


</body>
</html>

