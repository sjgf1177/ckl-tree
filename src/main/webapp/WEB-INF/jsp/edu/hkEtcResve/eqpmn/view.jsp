<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">-->
<!--  <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> --> 
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/common.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/layout.css"> -->
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.visualSysSet{
	z-index: 5!important;
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
.caroufredsel_wrapper ul{
	width: 500px!important;
	left: -5px!important;
}
.thumbsList .caroufredsel_wrapper{
	height: 300px!important;
	width: 375px!important;
}
.visualSysSet .thumbsList li{
	margin-right: 30px;
	margin-bottom: 10px;
}
.visualSysSet .thumbsList ul{
	padding: 0 0 0 10px;
}
.revInfo{
	width: 370px;
}


@media (min-width: 1180px) {
	.visualSysSet{
		width: 100%;
		max-width: 400px;
	}
	.caroufredsel_wrapper{
		width: 100%!important;
	}
	.revInfo{
		width: 48%;
	}
	.ml40{
		margin-left: 20px!important;
	}
}
@media (max-width: 1180px) {
	.visualSysSet{
		width: 100%;
	}
	.caroufredsel_wrapper{
		width: 100%!important;
	}
	.revInfo{
		width: 100%;
	}
	.ml40{
		margin-left: 3px!important;
	}
}
.thumbs{
		width: 100%!important;
	}
.thumbs img{
		width: 100%;
	}
	.visualSysSet .thumbs>div{
		width: 100%;
	}
	.visualSysSet a{
		width: 100%;
	}
</style>

<h2>[ <c:out value="${result.eqpmnNm }" /> ]</h2>
<!-- thumbGallery -->
<div class="visualSysSet">
	<div class="visualCtrl">
		<a href="#self" class="prevVs"><img src="/ckl/images/sub/prevVs.gif" width="60" height="60" alt="이전 이미지 보기" /></a>
		<a href="#self" class="nextVs"><img src="/ckl/images/sub/nextVs.gif" width="60" height="60" alt="다음 이미지 보기" /></a>
	</div>
	<div class="visualSys">
		<div class="thumbs" id="vsThumbs"> 
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div> <a href="#self"><img style="margin-top: 85px;z-index: 8;" src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="370" height="300" alt="<c:out value="${result.eqpmnNm }" /> 장비 큰이미지  ${status.count }번" /></a></div>
			</c:forEach>
		</div>
		<div class="thumbsList" id="thumbsList">
			<ul>
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<li> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="170" height="115"  alt="<c:out value="${result.eqpmnNm }" /> 장비 작은이미지  ${status.count }번" /></a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
//<![CDATA[
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
		width:500,
		height:300,
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



<div class="revInfo ml40 posr">
	<dl class="mt20">
		<dt>
			<span><span class="icons icoDetail"></span>세부내역 : </span>
		</dt>
		<dd class="mt5">
			<% pageContext.setAttribute("crlf", "\n"); %>
			${fn:replace(result.dtlsInfo, crlf, "<br/>")}
		</dd>
	</dl>

	<dl class="dl-horizontal pt20 pb20 mt20">
		<dt>
			<span><span class="icons ico6"></span>수량</span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.eqpmnQy }" />EA</dd>
	</dl>
	<c:if test="${not empty result.resveImprtyResn }">
	<dl>
		<dt class="text-danger pt20">
			<span class="icons icoAlert"></span><c:out value="${result.resvePosblAt eq 'I' ? '예약코멘트' : '예약불가사유' }" />
		</dt>
		<dd><c:out value="${result.resveImprtyResn }" /></dd>
	</dl>
	</c:if>
 
	<div class="mt20 tar board_util_btn_con">
		<a href="/edu/hkEtcResve/eqpmn/list.do?${pageQueryString }" class="btn_style_0 green radius">목록</a>
	</div>
</div>

