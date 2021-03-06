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
<h2><c:out value="${result.spceNm }" /></h2>
<!-- thumbGallery -->
<div class="visualSysSet">
	<div class="visualCtrl">
		<a href="#self" class="prevVs"><img src="/ckl/images/sub/prevVs.gif" width="60" height="60" alt="이전 이미지 보기" /></a>
		<a href="#self" class="nextVs"><img src="/ckl/images/sub/nextVs.gif" width="60" height="60" alt="다음 이미지 보기" /></a>
	</div>
	<div class="visualSys">
		<div class="thumbs" id="vsThumbs">
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="710" height="468" alt="<c:out value="${result.spceNm }" /> 전경 (큰  이미지  ${status.count }번)" /></a></div>
			</c:forEach>
		</div>
		<div class="thumbsList" id="thumbsList">
			<ul>
				<c:forEach var="fileVO" items="${fileList}" varStatus="status">
					<li> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="170" height="115"  alt="<c:out value="${result.spceNm }" /> 전경( 작은 이미지  ${status.count }번)" /></a></li>
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
			<span><span class="icons ico8"></span>용도</span>
		</dt>
		<dd class="mt5"><c:out value="${result.prpos }" /></dd>
	</dl>

	<dl class="dl-horizontal pt20 pb20 mt20">
		<dt>
			<span><span class="icons ico1"></span>위치</span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.lcSeNm }" /></dd>
		<dt>
			<span><span class="icons ico2"></span>면적</span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.ar }" />㎡</dd>
		<dt>
			<span><span class="icons ico3"></span>인원</span><span class="dib ml20">:
			</span>
		</dt>
		<dd><c:out value="${result.nmpr }" />명</dd>
		<dt>
			<span><span class="icons ico13"></span>장비</span><span class="dib ml20">: </span>
		</dt>
		<dd>
		<c:forEach var="eqpmnVO" items="${eqpmnList }">
			<a href="/ckl/fcltyResve/eqpmn/viewPopup.do?eqpmnSn=<c:out value="${eqpmnVO.eqpmnSn }"/>&amp;viewType=BODY" onclick="window.open(this.href,'eqpmnPop','width=800, height=825, scrollbars=no');return false;" class="text-danger db"><c:out value="${eqpmnVO.eqpmnNm }" /></a>
		</c:forEach>
		</dd>
		
		<c:if test="${result.fcltySe eq '010202' || result.fcltySe eq '010203'}">
			<dt>
				<span><span>Q  </span>문의</span><span class="dib ml20">:
				</span>
			</dt>
			<dt>
				<dd>02-2161-0002
				lab.ckl.kocca@gmail.com</dd>
				<dd><font color="red">위 번호로 일정을 확인한 후에 신청서를 작성하여 메일을 보내주시기 바랍니다.</font></dd>
			</dt>
		</c:if>
	</dl>
		
		

	<c:if test="${not empty result.resveImprtyResn }">
	<dl>
		<dt class="text-danger pt20">
			<span class="icons icoAlert"></span><c:out value="${result.resvePosblAt eq 'I' ? '예약코멘트' : '예약불가사유' }" />
		</dt>
		<dd><c:out value="${result.resveImprtyResn }" /></dd>
	</dl>
	</c:if>


	<div class="mt20 tar">
		<%-- 원본 <c:if test="${result.resvePosblAt eq 'Y' and result.resveSe ne 'I'}">
		<a href="/ckl/fcltyResve/resveSttus/step0.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-md btn-danger resveBtn"><span class="icons icoChk"></span>예약하기</a>
		</c:if>
		<c:if test="${result.resvePosblAt eq 'I' and result.resveSe ne 'I'}">
		<a href="/ckl/fcltyResve/resveSttus/step0.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-md btn-success resveBtn"><span class="icons icoChk"></span>개별예약</a>
		</c:if> 원본 --%>
		
		<c:if test="${result.lcSe ne '0102'}">
			<c:if test="${result.resvePosblAt eq 'Y' and result.resveSe ne 'I'}">
			<a href="/ckl/fcltyResve/resveSttus/step0.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-md btn-danger resveBtn"><span class="icons icoChk"></span>예약하기</a>
			</c:if>
			<c:if test="${result.resvePosblAt eq 'I' and result.resveSe ne 'I'}">
			<a href="/ckl/fcltyResve/resveSttus/step0.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-md btn-success resveBtn"><span class="icons icoChk"></span>개별예약</a>
			</c:if>
		</c:if>
		
		<c:if test="${result.lcSe eq '0102'}">
			<a href="http://www.ckl.or.kr/download/daegwan.hwp" class="btn btn-md btn-danger resveBtn"><span class="icons icoChk"></span>대관신청서</a>
		</c:if>
		
		<a href="/ckl/fcltyResve/fclty/list.do?${pageQueryString }" class="btn btn-md btn-primary pr30">목록</a>
	</div>
</div>
<!-- //bdView -->
