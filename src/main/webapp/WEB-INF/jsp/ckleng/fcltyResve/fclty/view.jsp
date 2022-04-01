<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[
$(function(){

	/*
	$(".resveBtn").click(function() {
		var chkTpNum = $(this).attr("data-value");
		if (Number(chkTpNum) >= 2) {
			alert("오늘날짜 기준으로 90일동안 미사용이 2회일 경우, 최종 미사용일로 부터 30일간 예약 불가합니다.");
			return false;
		}
	});
	*/

});
//]]>
</script>
<!-- bdView -->
<h2><c:out value="${result.spceNmEn }" /></h2>
<!-- thumbGallery -->
<div class="visualSysSet">
	<div class="visualCtrl">
		<a href="#self" class="prevVs"><img src="/ckl/images/sub/prevVs.gif" width="60" height="60" alt="prev" /></a>
		<a href="#self" class="nextVs"><img src="/ckl/images/sub/nextVs.gif" width="60" height="60" alt="next" /></a>
	</div>
	<div class="visualSys">
		<div class="thumbs" id="vsThumbs">
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="710" height="468" alt="<c:out value="${fileVo.orignlFileNm }" />( big image ${status.count } )" /></a></div>
			</c:forEach>
		</div>
		<div class="thumbsList" id="thumbsList">
			<ul>
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<li> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="170" height="115"  alt="<c:out value="${fileVo.orignlFileNm }" />( small image  ${status.count })" /></a></li>
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



<div class="revInfo ml40 posr">
	<dl class="mt20">
		<dt>
			<span><span class="icons ico8"></span>Purpose </span>
		</dt>
		<dd class="mt5"><c:out value="${result.prposEn }" /></dd>
	</dl>

	<dl class="dl-horizontal pt20 pb20 mt20">
		<dt>
			<span><span class="icons ico1"></span>Location </span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.lcSeNmEn }" /></dd>
		<dt>
			<span><span class="icons ico2"></span>Area </span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.ar }" />㎡</dd>
		<dt>
			<span><span class="icons ico3"></span>Personnel size </span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.nmpr }" /></dd>
		<dt>
			<span><span class="icons ico13"></span>Equipment </span><span class="dib ml20">: </span>
		</dt>
		<dd>
		<c:forEach var="eqpmnVO" items="${eqpmnList }">
			<c:out value="${eqpmnVO.eqpmnNmEn }" />&nbsp;
			<%--
			<a href="/ckleng/fcltyResve/eqpmn/viewPopup.do?eqpmnSn=<c:out value="${eqpmnVO.eqpmnSn }"/>&amp;viewType=BODY" onclick="window.open(this.href,'eqpmnPop','width=800, height=825, scrollbars=no');return false;" class="text-danger db"><c:out value="${eqpmnVO.eqpmnNmEn }" /></a>
			--%>
		</c:forEach>
		</dd>
	</dl>




	<div class="mt20 tar">
		<%-- <c:if test="${result.resvePosblAt eq 'Y' and result.resveSe ne 'I'}">
				<a href="/ckl/fcltyResve/resveSttus/step0.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-md btn-danger resveBtn"><span class="icons icoChk"></span>예약하기</a>
				</c:if> --%>
		<a href="/ckleng/fcltyResve/fclty/list.do?${pageQueryString }" class="btn btn-md btn-primary pr30">List</a>
	</div>
</div>
<!-- //bdView -->
