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
<div class="pl10 pr10">
	<h2><c:out value="${result.spceNm }" /></h2>
	<!-- thumbGallery -->




	<div class="revInfo">
		<dl>
			<dt>
				<span><span class="icons ico8"></span>용도</span>
			</dt>
			<dd class="mt5"><c:out value="${result.prpos }" /></dd>
		</dl>

		<dl class="dl-horizontal">
			<dt>
				<span><span class="icons ico1"></span>위치</span><span class="dib ml5">:
				</span>
			</dt>
			<dd><c:out value="${result.lcSeNm }" /></dd>
			<dt>
				<span><span class="icons ico2"></span>면적</span><span class="dib ml5">:
				</span>
			</dt>
			<dd><c:out value="${result.ar }" />㎡</dd>
			<dt>
				<span><span class="icons ico3"></span>인원</span><span class="dib ml5">:
				</span>
			</dt>
			<dd><c:out value="${result.nmpr }" />명</dd>
			<dt>
				<span><span class="icons ico13"></span>장비</span><span class="dib ml5">: </span>
			</dt>
			<dd>
			<c:forEach var="eqpmnVO" items="${eqpmnList }">
				<c:out value="${eqpmnVO.eqpmnNm }" /><br/>
			</c:forEach>
			</dd>
		</dl>

		<%--
		<c:if test="${not empty result.resveImprtyResn }">
		<dl>
			<dt class="text-danger pt20">
				<span class="icons icoAlert"></span>예약불가사유
			</dt>
			<dd><c:out value="${result.resveImprtyResn }" /></dd>
		</dl>
		</c:if>
		--%>
	</div>

	<div class="visualSysSet">
		<div class="thumbs" id="vsThumbs">
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div> <a href="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" rel="prettyPhoto" title="<c:out value="${fileVo.orignlFileNm }" />(큰  ${status.count }번 이미지)"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="710" height="468" alt="<c:out value="${fileVo.orignlFileNm }" />(큰  ${status.count }번 이미지)" class="prettyPhotos" /></a></div>
			</c:forEach>
		</div>
	</div>

	<div class="box text-danger"><span class="icons icoAlert"></span> 시설 예약은 PC 버전에서 가능합니다.</div>

	<script type="text/javascript">
	//<![CDATA[
       $(document).ready(function(){
         $("a[rel^='prettyPhoto']").prettyPhoto({
         	social_tools:'',
         	theme: 'dark_rounded'
         });
       });
	//]]>
	</script>
	<!-- //thumbGallery -->

	<div class="mt20 tar">
	<a href="/cklmobile/fcltyResve/fclty/list.do?${pageQueryString }" class="btn btn-sm btn-trans"><span class="btnIc btnList"></span> 목록보기</a>
	</div>
</div>
<!-- //bdView -->
