<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%-- <%@page import="kr.co.unp.main.service.impl.MainServiceImpl"%> --%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<%@page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
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

<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/portalHead.jsp" flush="true" /> --%>

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0, maximum-scale=3, minimum-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css"/>
<link rel="stylesheet" href="/portal/css/common.css" type="text/css" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/portal/js/common.js"></script>
 -->

<script src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
<script src="/js/jquery.touchSwipe.min.1.6.4.js"></script>
<script src="/portal/js/main.js"></script>
<title>CKL FinTech Incubating Center</title>

<!-- <link rel="stylesheet" type="text/css" href="http://www.owlcarousel.owlgraphic.com/assets/owlcarousel/assets/owl.carousel.min.css"> -->
<link rel="stylesheet" href="/portal/css/main.css" type="text/css" />

</head>
<body>

<ul class="skip">
<li><a href="#content">본문내용 바로가기</a></li>
<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>
<div id="gnbSubMenuBg" class="gnbBack"></div>
<div id="bg_gnb"></div>
<div id="wrap">
<div id="wrap_con">
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">

function checkForm(form) {
	var v = new MiyaValidator(form);

	  v.add("ntcrEmail", {
	        required: true,
			glue: "@",
			option: "email"
	    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}

	if (!confirm('등록하시겠습니까?')) {
		return false;
	}
	return true;
}
</script>
	<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/head.jsp" flush="true" /> --%>

	<div id="mainSpot">
		<div class="slogan">
			<p class="t1"><span class="col1">증권ㆍ금융계IT 인프라를</span> 책임지고 있는 <br /> 자본시장 IT 솔루션 리더 <span class="col2">CKL</span></p>
			<p class="t2">CKL FinTech Incubating Center 소개 </p>
			<p class="t3">코스콤 인큐베이팅 센터는 스타트업의 성장단계에 따른 차별화지원프로그램을 운영합니다.</p>
		</div>
		<div class="facebookVoit">
			<div id="fb-root"></div>
			<script>(function(d, s, id) {
			  var js, fjs = d.getElementsByTagName(s)[0];
			  if (d.getElementById(id)) return;
			  js = d.createElement(s); js.id = id;
			  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.3&appId=368128086548953";
			  fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));


			</script>
			<div class="fb-like" data-href="https://pms.ccbrain.co.kr:9999" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
			<div class="t"><span class="i">ckl FTIC</span>를 좋아합니다.</div>
		</div>
	</div>





	<!--container-->
	<div id="containerSet">
		<div class="mainSet clearfix">

			<div id="event">
				<div class="hgroup">
					<h1>EVENT</h1>
					<a href="/portal/event/master/list.do?menuNo=200005" class="more">more</a>
				</div>
				<div class="evnetCtrl">
					<button type="button" class="eventleft"><span class="sr-only">이전 이벤트 보기</span></button>
					<button type="button" class="eventright"><span class="sr-only">다음 이벤트 보기</span></button>
				</div>
				<div class="area">
					<ul>
					<c:forEach var="result" items="${eventList}" varStatus="status">
						<li>
							<a href="/portal/event/master/view.do?eventNo=${result.eventNo}&amp;menuNo=200005">
								<span class="img">
									<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn}" />
									<span class="type"><c:out value="${result.eventSeNm }"/></span>
								</span>
								<span class="tit"> <c:out value="${result.nttSj }"/></span>
								<span class="linkInforSet">
									<span class="name"> <c:out value="${result.orgNm }"/> </span>
									<span class="date"> <c:out value="${result.frstRegistPnttm }"/> </span>
								</span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div><script>
				$(function(){
					$("#event .area ul").carouFredSel({
						 	//responsive: true,
							auto		:false,
							// width		: 480, //전체 너비
							// height	: 330, //전체 높이
							items		: {
								visible : 2 //보여질 갯수
								// ,width 	:100
								},
							swipe: {
					            onTouch: false
							}
							,scroll      : {
								items		:2, //스크롤링할 갯수
								duration        : 500, //시간
								pauseOnHover	: true //마우스오버시 일시정지기능 마우스 아웃시 자동재생됨
								}
							,direction	: "left"
							,prev:{
								button : '.eventleft',
								wipe : true, //로테이션 허용(리스트 처음에서 클릭시 마지막요소로 이동)
								pauseOnHover:false
							}
							,next: {
								button :'.eventright',
								wipe : true,
								pauseOnHover:false
							}
					});
						// Trigger elsewhere the swipe event , so this can work with links on carousel !
			        $("#event .area ul").swipe({
			            excludedElements: "button, input, select, textarea, .noSwipe",
			            swipeLeft: function() {
			                $('#event .area ul').trigger('next', true);
			                // console.log('left')
			                return false;
			            },
			            swipeRight: function() {
			                $('#event .area ul').trigger('prev', true);
			                // console.log('rrr');
			                return false;
			            },
			            tap: function(event, target) {
			                // in case of an image wrapped by a link click on image will fire parent link
			                $(target).parent().trigger('click');
			                // console.log('tap1',$(target).attr('href'))
			                if ($(target).attr('href')!=undefined) {
				                document.location.href = $(target).attr('href')
			                };
			            }
			        });

				})

				</script>
			</div><!-- event -->

			<div id="news">
				<div class="hgroup">
					<h1>NEWS</h1>
					<a href="/portal/bbs/B0000002/list.do?menuNo=200006" class="more">more</a>
				</div>
				<div class="set">
				<c:forEach var="result" items="${B0000002List}" begin="0" end="0">
						<c:url var="url" value="/portal/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&amp;menuNo=200006" />
					<div class="pic">
						<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.nttSj}"  />
					</div>
					<div class="rSet">
						<div class="dbTxt">
							<a href="${url}">
								<span class="cate"><c:out value="${result.option1Nm}"/> </span>
								<span class="subject"><c:out value="${result.nttSj }"/></span>
							</a>
							<span class="txt">
								<c:out value="${result.nttCn }"/>
							</span>
						</div>
						<span class="linkInforSet">
							<span class="name"> <c:out value="${result.deptNmKor}"/> </span>
							<span class="date"> <c:out value="${result.frstRegisterPnttm}"/> </span>
						</span>
					</div>
					</c:forEach>
				</div>
			</div><!-- news -->
			<div id="startup">
				<div class="hgroup">
					<h1>STARTUP</h1>
					<a href="/portal/entprs/list.do?entType=1&amp;menuNo=200001" class="more">more</a>
				</div>
				<div class="area">
					<ul>
					<c:forEach var="result" items="${startupList}"  begin="0" end="1">
						<c:url var="url" value="/portal/entprs/view.do?entrprsNo=${result.entrprsNo }&amp;entType=${result.entType}&amp;menuNo=200001" />
						<li>
							<span class="logo"><img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn}" width="79" height="80" /></span><!-- 203*55 -->
							<span class="companyName"><c:out value="${result.bsnm}"/></span>
							<div>
								<p>
									<util:replaceAll string="${result.cmpnyIntrcn}" pattern="<(/)?(\\w*)?(\\s\\w*=[^>]*)?(\\s)*(/)?>" replacement="" />
								</p>
							</div>
							<a href="${url}">자세히 보기</a>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div><!-- startup -->


			<div id="network">
				<div class="hgroup">
					<h1>NETWORK</h1>
					<a href="/portal/main/contents.do?menuNo=200007" class="more">more</a>
				</div>
				<div class="set">
					<div class="tabCtrl">
						<button type="button" class="view-connectionList on">관련기관</button>
						<button type="button" class="view-mentoMainList">멘토</button>
					</div>
					<div class="connectionList">
						<h2 class="sr-only">관련기관</h2>
						<div class="connectionCtrl control">
							<button type="button" class="left connectionleft">관련기관 이전보기</button>
							<button type="button" class="right connectionright">관련기관 다음보기</button>
							<button type="button" class="stop connectionstop">관련기관 정지</button>
							<button type="button" class="play connectionplay">관련기관 재생</button>
						</div>

						<div class="set">
							<ul>
							<c:forEach var="result" items="${entbsList}" varStatus="status">
								<li>
									<a href="#" >
										<span class="img"><img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn}" width="79" height="80" /></span>
										<span class="s">
											<span class="cate">${result.entrprsCate1Nm}</span>
											<span class="name">${result.bsnm}</span>
										</span>
									</a>
								</li>
							</c:forEach>
							</ul>
						</div>
					</div>

					<div class="mentoMainList">

						<h2 class="sr-only">멘토</h2>
						<div class="mentoCtrl control">
							<button type="button" class="left mentoMainListleft">멘토 이전보기</button>
							<button type="button" class="right mentoMainListright">멘토 다음보기</button>
							<button type="button" class="stop mentoMainListstop">멘토 정지</button>
							<button type="button" class="play mentoMainListplay">멘토 재생</button>
						</div>
						<div class="set">
							<!-- <div> <a href=""> <span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> <span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> <span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> <span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> <span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> </div> <div> <a href=""> 2<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 2<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 2<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 2<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 2<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> </div> <div> <a href=""> 3<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 3<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 3<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 3<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> <a href=""> 3<span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> </div> -->
							<ul>
							<c:forEach var="result" items="${mentorList}" varStatus="status">
								<li>
									<a href="">
										<span class="img"><img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="${result.fileCn}" width="79" height="80" /></span>
										<span class="s">
											<span class="cate"><c:out value="${result.userNm}"/></span>
											<span class="name"><c:out value="${result.bsnm}"/></span>
										</span>
									</a>
								</li>
							</c:forEach>
							</ul>
							<!-- <a href=""> <span class="img"><img src="/portal/images/@ad.png" alt="" /></span> <span class="cate">[기관]</span> <span class="name">D.CAMP</span> </a> -->
						</div>
					</div>
				</div>
			</div><!-- network -->
		<form id="frm" name="frm" action="/portal/bbs/B0000004/annmsInsert.do?menuNo=100019" method="post" onsubmit="return checkForm(this);">
			<div id="newsletter">
				<div class="hgroup">
					<h1>NEWSLETTER</h1>
				</div>
				<div class="set">
					<p>이메일을 등록하시면, 회원가입 없이 코스콤 핀테크 정보를 받아 보실 수 있습니다.</p>
					<div>
						<input class="inp" type="text" title="이메일 주소" name="ntcrEmail"  placeholer="Email Address" />
						<input type="submit" value="등록" class="sub"/>
					</div>
				</div>
			</div><!-- newsletter -->
		</form>

			<div id="about">
				<div class="hgroup">
					<h1>ABOUT</h1>
				</div>
				<div class="set">
					<a href="/portal/main/contents.do?menuNo=200021"><img src="/portal/images/main/ablutLink1.png" alt="FinTech Incubating Center 소개" /></a>
					<a href="/portal/main/contents.do?menuNo=200022"><img src="/portal/images/main/ablutLink2.png" alt="FinTech Incubating Center 입주방법" /></a>
				</div>
			</div><!-- about -->



		</div>
	</div>
	<hr />
</div>
	<!--footer_wrap-->
</div>

<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/portalFooter.jsp" flush="true" /> --%>