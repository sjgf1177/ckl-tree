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

		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll4");
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
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>콘텐츠코리아랩</title>
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/cklmobile/css/common.css" />
<link rel="stylesheet" type="text/css" href="/cklmobile/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/cklmobile/css/main.css" />
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
<script type="text/javascript" src="/js/modernizr.min.js"></script>
<script type="text/javascript" src="/js/ssl.js"></script>
<script type="text/javascript" src="/cklmobile/js/mainProgrm.js"></script>
<script type="text/javascript" src="/cklmobile/js/common.js"></script>
<script type="text/javascript" src="/cklmobile/js/main.js"></script>


</head>
<body>

<!-- <div class="debug" style="position:absolute;z-index:-100;width:100%;height:1900px;
	background:url(/cklmobile/images/tmp/_main.jpg) no-repeat center top; opacity:0.3;filter: invert(1);
	-webkit-filter: invert(1);
	-moz-filter: invert(1);
	-o-filter: invert(1);
	-ms-filter: invert(1);display:block;">
</div> -->


<ul class="skip">
	<li><a href="#content">본문내용 바로가기</a></li>
	<li><a href="#container">주메뉴 바로가기</a></li>
</ul>
<div id="wrap">
	<!-- header -->
	<div id="header">
		<div class="logoSet">
			<h1 class="logo"><a href="/cklmobile/main/main.do"><img src="/cklmobile/images/common/logo.png" alt="콘텐츠코리아랩(Content korea lab)" /></a></h1>
		</div>
		<div class="gnbOpenSet">
			<!-- 전체메뉴 열기 -->
			<div class="gnbOpen">
				<a href="#self"><img src="/cklmobile/images/common/gnbOpen.png" alt="전체 메뉴 열기" /></a>
			</div>
			<!-- 전체메뉴 열기 -->
		</div>
	</div>

	<!-- gnb -->
	<div class="gnbSet">
		<div class="gnbLink">
			<a href="/cklmobile/main/main.do" class="gnbHome"><img src="/cklmobile/images/common/gnbHome.png" alt="홈페이지로 이동" /></a>
			<sec:authorize ifNotGranted="ROLE_USER">
				<a href="/cklmobile/member/forLogin.do?menuNo=400029" class="btn btn-sm btn-default">로그인</a>
			</sec:authorize>
			<sec:authorize ifAnyGranted="ROLE_USER">
				<a href="/cklmobile/member/logout.do" class="btn btn-sm btn-default">로그아웃</a>
			</sec:authorize>
		</div>
		<div class="gnb" id="gnb">
			<ul>
			<c:set var="topCategories" value="${menuAll4['menu_0']}" />
			<c:forEach var="x" begin="0" end="5">
					<li class="tms${x+1} ${topCategories[x].menuNo eq curD01.menuNo ? 'on' : ''}"><a href="javascript:void(0); return flase;" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
						<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll4[d02MenuKey]}" />
						<c:if test="${fn:length(d02Categories)>0}">

						<ul>
							<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
								<li ${d02Categories[y].menuNo eq curD02.menuNo ? 'class="on"' : ''}"><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
							</c:forEach>
						</ul>
						</c:if>
					</li>
			</c:forEach>
			</ul>

			<div class="snsGoSet">
				<ul>
					<li><a href="https://www.facebook.com/ContentKoreaLab" target="_blank" title="콘텐츠코리아랩 페이스북 바로가기(새창열림)"><span class="snsLinkSet snsLink1"></span>
					페이스북</a></li>
					<li><a href="http://blog.naver.com/icp_ckl" target="_blank" title="콘텐츠코리아랩 네이버 바로가기(새창열림)"><span class="snsLinkSet snsLink2"></span>
					네이버</a></li>
					<li><a href="https://www.youtube.com/channel/UCfoovETPwMFH8dbW6NWMAnw" target="_blank" title="콘텐츠코리아랩 유튜브 바로가기(새창열림)"><span class="snsLinkSet snsLink3"></span>
					유튜브</a></li>
				</ul>
			</div>
			<a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">전체메뉴 닫기</span></a>
		</div>
	</div>
	<!-- //gnb -->



	<!-- container -->
	<div id="container">
		<div class="lastestSet">


			<!-- popupZone -->
			<div class="popupZone">
				<h2 class="hidden">팝업존</h2>
				<div class="popupCtrlSet">
					<p class="total"> 2 / 5</p>
					<ul class="popupCtrl">
						<li><button type="button" class="prevPop" id="prevPop" style="display: block;"><span class="hidden">이전팝업보기</span></button></li>
						<li><button type="button" class="stopPop" id="stopPop"><span class="hidden">팝업정지</span></button></li>
						<li><button type="button" class="playPop" id="playPop"><span class="hidden">팝업재생</span></button></li>
						<li><button type="button" class="nextPop" id="nextPop" style="display: block;"><span class="hidden">다음팝업보기</span></button></li>
					</ul>
				</div>
				<div class="popupList">
					<ul>
						<c:forEach items="${mainPopupList}" var="result" varStatus="status">
							<li>
								<a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank" title="새창열림"</c:if>>
								<span class="img"><img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&amp;fileSn=<c:out value="${result.file1Sn}"/>" alt="<c:out value="${result.ntcnNm}"/>" /></span>
								<span class="hidden"><c:out value="${result.ntcnNm}"/></span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- popupZone -->



			<div class="notice">
				<h2><a href="#self">공지사항</a></h2>
				<ul class="bull">
					<c:forEach var="result" items="${B0000017List}" varStatus="status">
						<li><a href="/cklmobile/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=400009"><c:out value="${result.nttSj}"/></a></li>
					</c:forEach>
					<c:if test="${fn:length(B0000017List) == 0}"><li>데이터가 없습니다.</li></c:if>
				</ul>
				<div class="tac">
					<a href="/cklmobile/bbs/B0000017/list.do?menuNo=400009" class="more"><span class="hidden">공지사항 더보기</span></a>
				</div>
			</div>

			<div class="useInfo">
				<h2><a href="#self">시설이용 안내</a></h2>
				<div class="infoBox">
					<div>
						<h3>열린공간</h3>
						<p>콘텐츠 창작자를 위한 공용공간 운영데스크에서 출입증 발급 후 자유이용</p>
						<ul>
							<li>2F - 라이브러리, 라운지</li>
							<li>10F - 파크, 아이디어빌리지</li>
						</ul>
					</div>
				</div>
				<div class="infoBox">
					<div>
						<h3>예약공간</h3>
						<p>홈페이지에서 예약(회원가입) 후 관리자 승인 필요</p>
						<ul>
							<li>2F - 창작시설, 회의시설</li>
							<li>14F - 창작시설</li>
						</ul>
					</div>
				</div>
				<div class="posa"> <a href="/cklmobile/fcltyResve/fclty/list.do?menuNo=400013"><span class="mainIcos mCal"></span>시설소개 바로가기<span class="mainIcos icoArrB"></span></a> </div>
			</div>


		</div>

		<!-- 일정표(/ckl/js/mainProgrm.js) -->
		<div class="proSchejule" id="mainProgrm">
		</div>
		<!-- //일정표 -->
	</div>
	<!-- //container -->


	<div class="tailer">
	<jsp:include page="/WEB-INF/jsp/cklmobile/inc/cklmobileFooter.jsp" flush="true" />
	</div>

</div>
</body>
</html>

