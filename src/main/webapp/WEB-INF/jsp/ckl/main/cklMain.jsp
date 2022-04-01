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
	String debug = request.getParameter("debug");
	
	//if( "1".equals(debug) ){

	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);


	String menuNo = request.getParameter("menuNo");
	if( StringUtils.hasText(menuNo) ) {

		org.springframework.context.ApplicationContext context =
		org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll2");
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
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>콘텐츠코리아랩</title>

	<c:if test="${param.mobileTp ne 'Y' }">
	<script type="text/javascript">
	//<![CDATA[
	var mbFlag = /(iphone|ipod|ipad|android|blackberry|windows ce|palm|symbian)/i.test(navigator.userAgent);
	if (mbFlag) {
		location.href="https://m.ckl.or.kr/cklmobile/main/main.do";
	}
	//]]>
	</script>
	</c:if>

	<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="/ckl/css/main.css" />

	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
	<script type="text/javascript" src="/js/modernizr.min.js"></script>
	<script type="text/javascript" src="/js/ssl.js"></script>
	<script type="text/javascript" src="/ckl/js/mainProgrm.js"></script>
	<script type="text/javascript" src="/ckl/js/main.js"></script>
<!--[if lt IE 9]>
	<link rel="stylesheet" href="/ckl/css/ie.css" type="text/css" />
	<script type="text/javascript" src="/js/bootstrap/html5shiv.min.js"></script>
	<script type="text/javascript" src="/js/respond.min.js"></script>
	<script type="text/javascript"> $('html').attr('id','ie');</script>
<![endif]-->

	<script type="text/javascript">
	//<![CDATA[
	function logoutSSO() {
		$.get("/ckl/member/logout.json",function(data) {
			var retUrl = "${ssoDomain}/sso/member/logoutSSO.do?service=ckl";
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


</head>
<body>
<ul class="skip">
	<li><a href="#content">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>

<div id="wrap">
	<div class="globalSet">
		<ul class="globalLink">
			<li><a href="https://www.kocca.kr" target="_blank" title="새창열림">한국콘텐츠진흥원<span class="mainIcos icoArr"></span></a></li>
			<li><a href="https://edu.kocca.kr" target="_blank" title="새창열림">에듀코카<span class="mainIcos icoArr"></span></a></li>
		</ul>
		<ul class="globalUtil">
			<sec:authorize ifNotGranted="ROLE_USER">
			<li class="bar"><a href="/ckl/member/forLogin.do?menuNo=200055">로그인</a></li>
			<li class="bar"><a href="/ckl/member/join01.do?menuNo=200054">회원가입</a></li>
			</sec:authorize>
			<sec:authorize ifAnyGranted="ROLE_USER">
			<li class="bar"><strong class="text-danger"><c:out value="${userVO.userNm }"/></strong>님 로그인중입니다.</li>
			<li class="bar"><a href="/ckl/member/logout.do" class="ico4 logoutBtn" >로그아웃</a></li>
			<li class="bar"><a href="/ckl/userMember/forUpdate.do?menuNo=200033" class="myInfo">나의정보</a></li>
			</sec:authorize>
			<li class="mr20"><a href="/ckleng/main/main.do"">English</a></li>
			<li class="schIcos">
				<!-- search -->
				<div class="shSet">
					<form name="frmSearch2" method="post" action="/ckl/search/list.do?menuNo=200061" onsubmit="return search2(this);">
						<fieldset>
							<legend>검색창 입력양식</legend>
							<input type="text" class="schWd" name="q" id="SCHWD" value="" title="검색어를 입력하세요." />
							<input type="image" class="schGo" src="/ckl/images/common/schGo.png" name="SCHGO" id="SCHGO" alt="검색 확인" title="검색 확인"  />
						</fieldset>
					</form>
				</div>
				<!-- //search -->
			</li>
		</ul>
	</div>
	<div class="mainVisualSet">
		<!-- header -->
		<div id="header">
			<div class="logoSet">
				<p class="mCommon orgLogo"><span class="hidden">대한민국 영토 콘텐츠로 넓힌다!  KOCCA 한국콘텐츠진흥원</span></p>
				<h1 class="mCommon logo"><a href="/ckl/main/main.do"><span class="hidden">콘텐츠코리아랩(Content korea lab)</span></a></h1>
			</div>

			<div id="gnb">
				<c:set var="topCategories" value="${menuAll2['menu_0']}" />
				<ul>
					<c:forEach var="x" begin="0" end="4">
						<li id="smenu${x+1}" ${x eq depth01 ? 'class="on"' : ''}><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
						<%-- <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
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
				<div class="gnbTotMenu"><a href="javascript:void(0);"><span class="hidden">전체메뉴 열기</span></a></div>
				<div class="totMenuT">
					<c:forEach var="x" begin="0" end="5">
						<dl class="tms${x+1}">
							<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
								<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
								<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
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
					<a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">전체메뉴 닫기</span></a>
				</div>
				<!-- 전체메뉴 열기 -->
			</div>
		</div>
		<!-- //header -->

		<!-- visualText -->
		<div class="mainVisuals">
			<div class="hidden">
				<ul>
					<li>아이디어융합팩토리</li>
					<li>창업발전소</li>
					<li>콘텐츠스타트업리그</li>
					<li>대한민국상상캠프</li>
					<li>창업마스터즈</li>
				</ul>
				<p>빛나는 작은 아이디어 하나가 클로벌콘텐츠가 되는 그날까지</p>
			</div>

			<!-- <a href="/ckl/main/contents.do?menuNo=200006" class="labGo"><span class="hidden">지역랩소개 바로가기</span></a> -->
		</div>
		<!-- //visualText -->
	</div>



	<!-- container -->
	<div id="container">
		<div class="lastestSet" id="content">


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
								<a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank" title="새창열림"</c:if> title="새창열림">
								<span class="img"><img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&amp;fileSn=<c:out value="${result.file1Sn}"/>" alt="<c:out value="${result.ntcnNm}"/>" /></span>
								<span class="hidden"><c:out value="${result.ntcnNm}"/></span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- popupZone -->
<script type="text/javascript">
//<![CDATA[
$(function(){
	$(".popupList ul").carouFredSel({
		align		: "left",
		width		: 460,
		height		: 250,
		items		:{
		visible : 1
	},
		scroll      :{
		items		:1,
		duration        : 390,
		timeoutDuration: 5000,
		pauseOnHover	: false
	},
		next: '.nextPop',
		prev: '.prevPop',
		direction	: "left"
	});


	$('.popupList ul').bind('updatePageStatus.cfs', function() {
		var _psTotal = $(this).children().length;
		var _psCurrent = $(this).triggerHandler( 'currentPosition' ) + 1;
		$('.popupZone .total').text(_psCurrent +' / '+ _psTotal);
	}).trigger( 'updatePageStatus.cfs' );


	$(".playPop").hide();
	$(".stopPop").click(function() {
		$(this).hide();
		$(".playPop").show();
		$(".popupList ul").trigger("pause");
	});
	$(".playPop").click(function() {
		$(this).hide();
		$(".stopPop").show();
		$(".popupList ul").trigger("play");
	});
	$('.popupList a').each(function(index) {
		$(this).bind('focus', function() {
			$(".popupList ul").trigger("pause");
		});
	});
});
//]]>
</script>


			<div class="notice">
				<h2>공지사항</h2>
				<ul class="bull">
					<c:forEach var="result" items="${B0000017List}" varStatus="status">
						<li><a href="/ckl/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=200013"><c:out value="${result.nttSj}"/></a></li>
					</c:forEach>
					<c:if test="${fn:length(B0000017List) == 0}"><li>데이터가 없습니다.</li></c:if>
				</ul>
				<div class="tac">
					<a href="/ckl/bbs/B0000017/list.do?menuNo=200013" class="more"><span class="hidden">공지사항 더보기</span></a>
				</div>
			</div>

			<div class="useInfo">
				<h2>시설이용 안내</h2>
				<div class="infoBox">
					<div class="pl10">
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
				<div class="posa">
					<a href="/ckl/fcltyResve/fclty/list.do?menuNo=200019"><span class="mainIcos mCal"></span>시설예약 바로가기<span class="mainIcos icoArrB"></span></a>
				</div>
			</div>

			<div class="pdsSet">
				<h2>자료실</h2>
				<ul>
					<li><a href="http://www.kocca.kr/cop/bbs/list/B0000141.do?menuNo=200898" target="_blank" title="새창열림" ><span class="psdIco1"></span>정기<br />간행물</a></li>
					<li><a href="http://www.kocca.kr/cop/bbs/list/B0000147.do?menuNo=200904" target="_blank" title="새창열림" ><span class="psdIco2"></span>연구<br />보고서</a></li>
					<li><a href="http://www.kocca.kr/cop/bbs/list/B0000180.do?menuNo=200953" target="_blank" title="새창열림" ><span class="psdIco3"></span>세미나<br />자료</a></li>
					<li><a href="http://library.kocca.kr/index.jsp" target="_blank" title="새창열림" ><span class="psdIco4"></span>콘텐츠<br />도서관</a></li>
					<li class="mr0"><a href="http://www.kocca.kr/cop/bbs/list/B0000262.do?menuNo=201731" target="_blank" title="새창열림" ><span class="psdIco5"></span>kocca<br />웹진</a></li>
				</ul>
				<div class="posa">
					<a href="#self">한국콘텐츠진흥원 바로가기<span class="mainIcos icoArr"></span></a>
				</div>
			</div>
		</div>

		<!-- 일정표(/ckl/js/mainProgrm.js) -->
		<div class="proSchejule" id="mainProgrm">
		</div>
		<!-- //일정표 -->
	</div>
	<!-- //container -->


	<div class="tailer">
		<div class="totMenuF">
			<c:forEach var="x" begin="0" end="5">
				<dl class="tmenu${x+1}">
					<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
						<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
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
					<div class="fImages fLogo"><span class="hidden">한국콘텐츠진흥원(하단로고)</span></div>
				</div>
				<div class="fContents">
					<div class="fLinks"> <a href="/ckl/main/contents.do?menuNo=200047" class="ml0" title="새창열림"><strong>개인정보처리방침</strong></a> <a href="/ckl/main/contents.do?menuNo=200050">이용약관</a> <a href="/ckl/bbs/B0000037/list.do?menuNo=200016">문의하기</a> <a href="/ckl/main/contents.do?menuNo=200052">사이트맵</a> </div>
					<div class="footerRt">
						<a href="https://www.facebook.com/ContentKoreaLab" target="_blank" title="새창열림" class="fIcon faceBk mr5"><span class="hidden">콘텐츠코리아랩 페이스북 바로가기</span></a>
						<a href="https://www.youtube.com/channel/UCfoovETPwMFH8dbW6NWMAnw" target="_blank" title="새창열림" class=" fIcon fUtube mr5"><span class="hidden">콘텐츠코리아랩 유튜브 바로가기</span></a>
						<div class="selBox dib">
							<form name="siteForm1" action="none" method="post" class="dib" target="_blank" onsubmit="if(document.siteForm1.ftSiteUrl.value == '') {alert('Family Site를 선택해 주세요.');document.siteForm1.ftSiteUrl.focus();return false;} window.open(document.siteForm1.ftSiteUrl.value,'sitePop');return false;">
								<div class="selectBox dib">
									<label for="ftSiteUrl" class="hidden">Family Site</label>
									<select id="ftSiteUrl" name="ftSiteUrl" class="vm replaceSel" title="Family Site를 선택해 주세요.(새창열림)">
										<option value="">Family Site</option>
										<option value="http://www.kocca.kr/">한국콘텐츠진흥원</option>
										<option value="http://portal.kocca.kr/portal/main.do">콘텐츠종합정보포털</option>
										<option value="http://edu.kocca.or.kr">에듀코카</option>
										<option value="http://www.culturecontent.com/">문화콘텐츠닷컴</option>
										<option value="http://www.kcdrc.kr">콘텐츠분쟁조정위원회</option>
										<option value="http://www.culturing.kr/main.do">컬처링</option>
										<option value="https://ctrd.kocca.or.kr/ext/main/main.jsp">연구개발정보관리시스템</option>
									</select>
								</div>
								<input type="image" src="/ckl/images/common/go.gif" alt="Family Site 이동(새창열림)" class="vm">
							</form>
							<form name="siteForm2" action="none" method="get" class="dib" target="_blank" onsubmit="if(document.siteForm2.ftLinksUrl.value == '') {alert('관련사이트를 선택해 주세요.');document.siteForm2.ftLinksUrl.focus();return false;} window.open(document.siteForm2.ftLinksUrl.value,'sitePop');return false;">
								<div class="selectBox dib">
									<label for="ftLinksUrl" class="hidden">관련사이트</label>
									<select name="ftLinksUrl" id="ftLinksUrl" class="vm replaceSel" title="관련사이트를 선택해 주세요.(새창열림)">
										<option value="">관련사이트</option>
										<option value="http://www.grb.or.kr ">게임물등급위원회</option>
										<option value="http://www.cfnmk.or.kr">국립박물관문화재단</option>
										<option value="http://www.gugakfm.co.kr">국악방송</option>
										<option value="http://www.kf.or.kr/">국제방송교류재단</option>
										<option value="http://www.kmrb.or.kr ">영상물등급위원회</option>
										<option value="http://www.kofic.or.kr ">영화진흥위원회</option>
										<option value="http://www.gokams.or.kr">예술경영지원센터</option>
										<option value="http://www.hanpac.or.kr">한국공연예술센터</option>
										<option value="http://www.visitkorea.or.kr">한국관광공사</option>
										<option value="http://www.klti.or.kr">한국문학번역원</option>
										<option value="http://www.kcti.re.kr">한국문화관광연구원</option>
										<option value="http://www.kofice.or.kr">한국문화산업교류재단</option>
										<option value="http://www.arko.or.kr">한국문화예술위원회</option>
										<option value="http://www.kpf.or.kr ">한국언론진흥재단</option>
										<option value="http://www.koreafilm.or.kr">한국영상자료원</option>
										<option value="http://www.copyright.or.kr">한국저작권위원회</option>
										<option value="http://www.kpipa.or.kr">한국출판문화산업진흥원</option>
										<option value="http://www.mcst.go.kr">문화체육관광부</option>
										<option value="http://www.kcc.go.kr">방송통신위원회</option>
										<option value="http://www.president.go.kr ">청와대</option>
									</select>
								</div>
								<input type="image" src="/ckl/images/common/go.gif" alt="관련사이트 이동(새창열림)" class="vm">
							</form>
						</div>
						<div class="logoGroup">
							<div>
								<img src="/ckl/images/common/footer_06.png" alt="웹 접근성 우수사이트 인증마크(WA인증마크)" class="mr5">
								<img src="/ckl/images/common/footer_07.png" alt="행복한 대한민국을 여는 정부 3.0 마크">
							</div>
						</div>
					</div>
					<div class="copyright">
						<p class="fs12">본 페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 이를 위반시 정보통신법에 의해 처벌됨을 유념하시기 바랍니다.</p>
						<address>
						본원 : [58217] 전라남도 나주시 교육길 35 한국콘텐츠진흥원 | 사업자번호 : 105-82-17272<br>
						대학로분원 : [03082] 서울시 종로구 대학로 57 콘텐츠코리아랩 | 대표전화 : 02-2161-0000
						</address>
					</div>
					<div class="copy">Copyright 2015. Korea Creative Content Agency all rights reserved.</div>
				</div>
			</div>
		</div>
		<!-- //footer -->
	</div>

<iframe name="ssoAuthFrame" id="ssoAuthFrame" style="width:0px;height:0px;border:0;" src="${ssoDomain }/sso/member/checkSSO.do?service=ckl&amp;menuNo=<c:out value="${paramVO.menuNo }" />&amp;userTp=<c:out value="${userVO.userIdx }" />" title="SSO 로그인 유무확인 프레임 입니다."></iframe>
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
<%--
<% } else { %>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>kocca</title>
</head>
<body style="margin:0;">
	<p style="margin: 0;"><img src="/edu/images/bm/ckl_04.jpg" alt="공사중" style="margin:0; width: 100%;" /></p>
</body>
</html>
<% }
--%>
