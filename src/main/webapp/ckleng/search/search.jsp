<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="conf/searchHost.jsp" %>
<%@include file="include/cmd_KeywordQuery.jsp" %>
<%@include file="include/cmd_Query.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title><spring:message code='site.engName' text=''/> Scoreboard</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta name="author" content="<spring:message code='site.engName' text=''/> Scoreboard" />
<meta name="keywords" content="<spring:message code='site.engName' text=''/> Scoreboard" />
<meta name="description" content="About <spring:message code='site.engName' text=''/>, HRST 과학기술인력, RSTI 지역과학기술산업, RDPS 국가연구개발성과, ICST 과학기술국제협력, BIS 민간기술혁신, AIM 아시아 혁신" />
<link rel="stylesheet" href="/ckl/css/common.css" type="text/css" />
<link rel="stylesheet" href="/ckl/css/layout.css" type="text/css" />
<link rel="stylesheet" href="/ckl/css/sub.css" type="text/css" />
<link rel="stylesheet" href="/ckl/css/gnb.css" type="text/css" />
<!--[if lte IE 8]><link rel="stylesheet" href="<%=ImgUrl%>/ckl/css/ie.css" type="text/css" /> <![endif]-->

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/ckl/js/common.js"></script>

<script type="text/javascript" src="/ckl/search/js/search.js"></script>
</head>
<body>
<ul class="skip">
	<li><a href="#content">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>
<div class="wrap_con">
	<div id="wrap">
		<!-- header -->
		<%@include file="include/header.jsp" %>
		<!-- //header -->

		<!-- Container -->
		<div id="container" class="clearfix">
			<div class="lnb">
				<h2>통합검색</h2>
				<ul>
					<li <%if(searchCategory.equals("total")){%> class="on" <%}%> ><a href="javascript:goCategory('total');">통합검색</a></li>
					<li <%if(searchCategory.equals("hrst")){%> class="on" <%}%> ><a href="javascript:goCategory('hrst');">HRST</a></li>
					<li <%if(searchCategory.equals("rsti")){%> class="on" <%}%> ><a href="javascript:goCategory('rsti');">RSTI</a></li>
					<li <%if(searchCategory.equals("rdps")){%> class="on" <%}%> ><a href="javascript:goCategory('rdps');">RDPS</a></li>
					<li <%if(searchCategory.equals("icst")){%> class="on" <%}%> ><a href="javascript:goCategory('icst');">ICST</a></li>
					<li <%if(searchCategory.equals("bis")){%> class="on" <%}%> ><a href="javascript:goCategory('bis');">BIS</a></li>
					<li <%if(searchCategory.equals("aim")){%> class="on" <%}%> ><a href="javascript:goCategory('aim');">AIM</a></li>
					<li <%if(searchCategory.equals("orgin")){%> class="on" <%}%> ><a href="javascript:goCategory('orgin');">출처기관</a></li>
					<li <%if(searchCategory.equals("bbs")){%> class="on" <%}%> ><a href="javascript:goCategory('bbs');">게시물</a></li>
					<li <%if(searchCategory.equals("attfile")){%> class="on" <%}%> ><a href="javascript:goCategory('attfile');">첨부파일</a></li>
				</ul>

				<!-- 인기 검색어 -->
				<%@include file="include/searchKeyword.jsp" %>
				<!-- //인기 검색어 -->
			</div>
			<div id="content">
				<div class="hgroup_ro">
					<!-- page navigation -->
					<ol>
						<li class="home">홈</li>
						<li>통합검색</li>

					</ol>
					<!-- //page navigation -->
					<div class="page_info"> <a href="#sns_set" class="thidden share">공유하기</a>
						<div id="sns_set">
							<dl>
								<dt>SNS 공유하기</dt>
								<dd> <a href="http://www.facebook.com/sharer.php??t=&amp;u=" onclick="facebookOpen('전체 &lt;생물자원&lt;자원정보&lt;');return false;" target="_blank" title="(새창열림)페이스북 바로가기"><img src="<%=ImgUrl%>/ckl/images/common/sns_ico01.gif" alt="페이스북에 공유하기" /> </a> </dd>
								<dd> <a href="http://twitter.com/share?text=&amp;url=" onclick="twitterOpen('전체 &lt;생물자원&lt;자원정보&lt;');return false;" target="_blank" title="(새창열림)트위터바로가기"><img src="<%=ImgUrl%>/ckl/images/common/sns_ico02.gif" alt="트위터에 공유하기" /> </a> </dd>
							</dl>
							<span class="arrow"> </span> </div>
						<a href="/common/forPrint.jsp" class="thidden print" onclick="window.open(this.href, 'printPage', 'width=850,height=550,menubar=1,scrollbars=yes');return false;" target="_blank" title="새창열림"> 인쇄하기 </a> </div>
				</div>

				<div class="hgroup">
					<h3>검색결과</h3>
				</div>

				<!-- contents Start -->


				<div class="totalsearch">
					<fieldset class="bbs_bxSearch totalSch">
						<legend>통합 검색</legend>
						<form name="formSearch" id="ts_1_Form" method="post">
							<input type="hidden" name="searchCategory"  />
							<input type="hidden" name="allsearchQuery" value="<%=allsearchQuery%>" />
							<div class="select"> <span class="ctrl"><span class="arrow"></span></span>
								<div class="myValue"></div>
								<ul class="iList">
									<li>
										<input name="section" id="section0" class="option" type="radio" value="total" <%if(searchCategory.equals("total")){%> checked="checked" <%}%> onclick="javascript:setCateGory('total');" />
										<label for="section0">통합검색</label>
									</li>
									<li>
										<input name="section" id="section1" class="option" type="radio" value="hrst" <%if(searchCategory.equals("hrst")){%> checked="checked" <%}%>  onclick="javascript:setCateGory('hrst');" />
										<label for="section1">HRST</label>
									</li>
									<li>
										<input name="section" id="section2" class="option" type="radio" value="rsti" <%if(searchCategory.equals("rsti")){%> checked="checked" <%}%> onclick="javascript:setCateGory('rsti');" />
										<label for="section2">RSTI</label>
									</li>
									<li>
										<input name="section" id="section3" class="option" type="radio" value="rdps" <%if(searchCategory.equals("rdps")){%> checked="checked" <%}%> onclick="javascript:setCateGory('rdps');" />
										<label for="section3">RDPS</label>
									</li>
									<li>
										<input name="section" id="section4" class="option" type="radio" value="icst" <%if(searchCategory.equals("icst")){%> checked="checked" <%}%> onclick="javascript:setCateGory('icst');" />
										<label for="section4">ICST</label>
									</li>
									<li>
										<input name="section" id="section5" class="option" type="radio" value="bis" <%if(searchCategory.equals("bis")){%> checked="checked" <%}%>  onclick="javascript:setCateGory('bis');" />
										<label for="section5">BIS</label>
									</li>
									<li>
										<input name="section" id="section6" class="option" type="radio" value="aim" <%if(searchCategory.equals("aim")){%> checked="checked" <%}%> onclick="javascript:setCateGory('aim');" />
										<label for="section6">AIM</label>
									</li>
									<li>
										<input name="section" id="section7" class="option" type="radio" value="orgin" <%if(searchCategory.equals("orgin")){%> checked="checked" <%}%> onclick="javascript:setCateGory('orgin');" />
										<label for="section7">출처기관</label>
									</li>
									<li>
										<input name="section" id="section8" class="option" type="radio" value="bbs" <%if(searchCategory.equals("bbs")){%> checked="checked" <%}%> onclick="javascript:setCateGory('bbs');" />
										<label for="section8">게시물</label>
									</li>
									<li>
										<input name="section" id="section9" class="option" type="radio" value="attfile" <%if(searchCategory.equals("attfile")){%> checked="checked" <%}%> onclick="javascript:setCateGory('attfile');" />
										<label for="section9">첨부파일</label>
									</li>
								</ul>
							</div>
							<label for="q" class="hid">검색어</label>
							<input type="text" style="width:330px" title="검색어 입력" name="searchQuery" id="q" value="" onkeydown="if(event.keyCode == 13) { goSearch(); };" />
							<span class="btnW"><a href="javascript:goSearch();"  class="button re"><span>검색</span></a></span> <span class="btnW blue" id="detail"><a href="#self"  class="button re" onclick="return false;"><span>상세검색</span></a></span>

							<div class="clear mt10"></div>
							<label for="sch_insch" class="tar" style="display:inline-block;width:194px;">결과 내 재검색</label>
							<input type="text" style="width:330px" title="검색어 입력" name="researchQuery" id="sch_insch" value="" onkeydown="if(event.keyCode == 13) { goReSearch(); };" />
							<span class="btnW"><a href="javascript:goReSearch();"  class="button re" ><span>재검색</span></a></span>

						</form>
					</fieldset>

					<!-- 상세 검색 -->
					<%@include file="include/searchDetail.jsp" %>
					<!-- //상세 검색 -->

					<h4 class=" bu2 fs18"> 검색어 &quot;<span class="fc_red"><%=allsearchQuery.replaceAll("\\$\\|", ", ")%></span>&quot;에 대한 전체 &quot;<span class="fc_red"><%=formatter.format(Long.parseLong(Integer.toString(kistep_TotalSize))) %></span>&quot;개의 검색 결과를 찾았습니다.</h4>

					<%if(searchCategory.equals("total") || searchCategory.equals("hrst")){%>
						<!-- HRST -->
						<%@include file="include/searchHrst.jsp" %>
						<!-- //HRST -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("rsti")){%>
						<!-- RSTI -->
						<%@include file="include/searchRsti.jsp" %>
						<!-- //RSTI -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("rdps")){%>
						<!-- RDPS -->
						<%@include file="include/searchRdps.jsp" %>
						<!-- //RDPS -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("icst")){%>
						<!-- ICST -->
						<%@include file="include/searchIcst.jsp" %>
						<!-- //ICST -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("bis")){%>
						<!-- BIS -->
						<%@include file="include/searchBis.jsp" %>
						<!-- //BIS -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("aim")){%>
						<!-- AIM -->
						<%@include file="include/searchAim.jsp" %>
						<!-- //AIM -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("orgin")){%>
						<!-- 출처기관 -->
						<%@include file="include/searchOrgin.jsp" %>
						<!-- //출처기관 -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("bbs")){%>
						<!-- 게시물 -->
						<%@include file="include/searchBbs.jsp" %>
						<!-- //게시물 -->
					<%}%>
					<%if(searchCategory.equals("total") || searchCategory.equals("attfile")){%>
						<!-- 첨부파일 -->
						<%@include file="include/searchAttfile.jsp" %>
						<!-- //첨부파일 -->
					<%}%>
				</div>

				<!-- //contents Start -->
			</div>

			<!-- quick div -->
			<script type="text/javascript">
//<![CDATA[
jQuery(function(){
	var quick_menu = jQuery('#quick');
	var quick_top = 440;

	/* quick menu initialization */
	quick_menu.css('top', jQuery(window).height() );
	jQuery(document).ready(function(){
		quick_menu.animate( { "top": jQuery(document).scrollTop() + quick_top +"px" }, 300 );
		jQuery(window).scroll(function(){
			if(jQuery(document).scrollTop() > 270){
				quick_top = 80;
			}else{
				quick_top = 440;
			}
			quick_menu.stop();
			quick_menu.animate( { "top": jQuery(document).scrollTop() + quick_top + "px" }, 300 );
		});
	});

	jQuery(".gotop").click(function(){
		jQuery('html').animate({scrollTop:0}, 300)
		jQuery("html, body").animate({scrollTop:0}, 300);
		return false;
	});
});

//]]>
</script>
			<div class="quick" id="quick"> <a href="javascript:void(0)" class="gotop thidden">맨처음으로 이동</a> </div>
			<!-- //quick div -->

		</div>
		<!-- //Container -->

	<!-- 이용자의견 -->
	<div class="re_rbox">
		<div class="w80p fl">
			<span class="fc_red fs16">이용자의견</span>
			<span>본 정보에 대한 의견을 남겨주시면 불편 및 오류 내용을 개선하도록 하겠습니다.</span>
		</div>
		<span class="fr">※ 최대 2000글자 이내</span>
		<div class="clearfix"></div>
			<div class="form mt10 mb10">
				<form name="satisfactionFrm" method="post" onSubmit="return checkSatisfactionForm(this);" action="/ckl/satisfaction/save.do">
					<input type="hidden" id="menuNo" name="menuNo" value="${currMenu.menuNo}" />
					<fieldset>
						<legend>이용자의견 쓰기</legend>
							<input type="text" name="opinion" id="opinion" class="w90p input_txt" title="텍스트를 입력하여 주세요." value="텍스트를 입력하여 주세요." onfocus="if(this.value=='텍스트를 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='텍스트를 입력하여 주세요.')this.value='';">
							<input type="submit" value="등록" class="btn btn-primary" />
					</fieldset>
				</form>
			</div>
		<div class="clearfix"></div>
	</div>
	<!-- //이용자의견 -->

	</div>
</div>

<form name="formMove" onsubmit="return false;" method="post">
	<input type="hidden" name="searchCategory" value="<%=searchCategory%>" />
	<input type="hidden" name="searchQuery" value="<%=searchQuery%>" />
	<input type="hidden" name="researchQuery" value="<%=researchQuery%>" />
	<input type="hidden" name="allsearchQuery" value="<%=allsearchQuery%>" />
	<input type="hidden" name="searchArea" value="<%=searchArea%>" />
	<input type="hidden" name="searchPeriod" value="<%=searchPeriod%>" />
	<input type="hidden" name="searchStartDate" value="<%=searchStartDate%>" />
	<input type="hidden" name="searchEndDate" value="<%=searchEndDate%>" />
	<input type="hidden" name="searchSort" value="<%=searchSort%>" />
	<input type="hidden" name="PageNumber" value="<%=PageNumber%>" />
	<input type="hidden" name="detailDisplay" value="<%=detailDisplay%>" />
	<input type="hidden" name="kistepwhereSetStr" value="<%=kistepwhereSetStr%>" />
	<input type="hidden" name="orginwhereSetStr" value="<%=orginwhereSetStr%>" />
	<input type="hidden" name="attfilewhereSetStr" value="<%=attfilewhereSetStr%>" />
</form>

<!-- footer -->
<%@include file="include/footer.jsp" %>
<!-- //footer -->

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

