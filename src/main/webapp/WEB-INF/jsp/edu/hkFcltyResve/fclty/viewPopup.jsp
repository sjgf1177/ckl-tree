<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">
 <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> 
<link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/common.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/layout.css">
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.visualSysSet{
	width: 500px;
}
.caroufredsel_wrapper a:HOVER{
	border: 1px solid #40abd4;
}
dl{
	font-size: 13px;
}
.dl-horizontal dt{
	float:left;
	overflow: hidden;
	clear: left;
}
.revInfo .dl-horizontal{
	margin: 0px;
}
.revInfo .dl-horizontal dt{
	margin-bottom: 0px;
}
.panelBox{
	margin: 0px;
}
.h2{
	margin: 0px;
}
.panel-danger>.panel-heading{
	background-color: #40abd4;
}
</style>

<!-- layerPopup -->
<div class="reservSysSet">
	<div class="panel panel-danger panelBox">
	  <div class="panel-heading">
			<h3>시설상세 팝업</h3>
	  </div>
	  <div class="panel-body">

			<!-- thumbGallery -->

			<h3 class="h2"><c:out value="${result.spceNm }" /></h3>

			<dl class="dl-vertical">
				<dt><span><span class="icons ico1"></span>위치</span><span class="dib ml20">: </span></dt> <dd><c:out value="${result.lcSeNm }" /></dd>
				<dt><span><span class="icons ico2"></span>면적</span><span class="dib ml20">: </span></dt> <dd><c:out value="${result.ar }" />㎡</dd>
				<dt><span><span class="icons ico3"></span>인원</span><span class="dib ml20">: </span></dt> <dd><c:out value="${result.nmpr }" />명</dd>
			</dl>

			<div class="visualSysSet">
				<div class="visualCtrl">
					<a href="#self" class="prevVs"><img src="/ckl/images/sub/prevVs.gif" width="60" height="60" alt="이전 이미지 보기" /></a>
					<a href="#self" class="nextVs"><img src="/ckl/images/sub/nextVs.gif" width="60" height="60" alt="다음 이미지 보기" /></a>
				</div>
				<div class="visualSys">
					<div class="thumbs" id="vsThumbs">
						<c:forEach var="fileVO" items="${fileList}" varStatus="status">
						<div><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="710" height="468" alt="${result.spceNm } 전경  큰이미지 ${status.count }번" /></div>
						</c:forEach>
					</div>
					<div class="thumbsList" id="thumbsList">
						<ul>
							<c:forEach var="fileVO" items="${fileList}" varStatus="status">
							<li> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="170" height="115"  alt="${result.spceNm } 전경   작은이미지 ${status.count }번" /></a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<script type="text/javascript">
			//<![CDATA[
			 var title = this.document.title;
			 var spceNm = '<c:out value="${result.spceNm }" />';
			 document.title =   spceNm+ " | 시설상세 | " + title;
			$(function() {
				 $('#thumbsList ul').carouFredSel({
				 	width:710,
					items		:{
						visible : <c:out value="${fn:length(fileList)}" />
					},
					direction: 'left',
					scroll      :{
						items		:1,
						pauseOnHover	: true
					},
					auto: {
						play: false,
						duration: 750,
						timeoutDuration: 2000,
						easing: 'quadratic',
						onBefore: function() {
							var index = $(this).triggerHandler( 'currentPosition' );
							if ( index == 0 ) {
								index = $(this).children().length;
							}
							$('#vsThumbs').trigger('slideTo', [ index, {
								fx: 'directscroll'
							}, 'prev' ]);
							 $('#thumbsList ul').find( 'li' ).eq(index).addClass( 'selected' );
						}

					},
					next : ".nextVs",
					prev : ".prevVs"
				 });

				var thumbsList = $('#thumbsList ul li');
				thumbsList.bind("click", function(){
					var index =  thumbsList.index(this);
					$('#vsThumbs').trigger('slideTo', [ index, {
						fx: 'directscroll'
					}, 'prev' ]);
				});

				 $('#vsThumbs').carouFredSel({
					items: 1,
					direction: 'up',
					width:710,
					height:468,
					scroll :{
						items : 1
					},
					auto: {
						play: false,
						duration: 750,
						easing: 'directscroll'
					}
				 });
			});
			//]]>
			</script>
			<!-- //thumbGallery -->

			<div class="fl tac w100p btnSet board_util_btn_con">
				<a href="#self" class="closeBtn btn_style_0 green radius">확인</a>
			</div>

			<div class="panelBoxCloser">
				<a href="#self" class="closeBtn"><span class="sr-only">레이어 창 닫기</span></a>
			</div>
	  </div>
	</div>

	<script type="text/javascript">
	//<![CDATA[
	$(".closeBtn").click(function(){
		//$(".reservSysSet").hide();
		self.close();
	})

	//]]>
	</script>
</div>
<!-- //layerPopup -->