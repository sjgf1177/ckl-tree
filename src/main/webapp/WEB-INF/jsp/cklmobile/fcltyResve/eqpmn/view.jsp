<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- bdView -->
<div class="pl10 pr10">
	<h2><c:out value="${result.eqpmnNm }" /></h2>
	<!-- thumbGallery -->

	<div class="revInfo">
		<dl>
			<dt>
				<span><span class="icons icoDetail"></span>세부내역 : </span>
			</dt>
			<dd>
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
	</div>


	<div class="visualSysSet">
		<div class="thumbs" id="vsThumbs">
			<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div> <a href="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" rel="prettyPhoto" title="<c:out value="${fileVo.orignlFileNm }" />(큰  ${status.count }번 이미지)"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}" width="710" height="468" alt="<c:out value="${fileVo.orignlFileNm }" />(큰  ${status.count }번 이미지)" class="prettyPhotos" /></a></div>
			</c:forEach>
		</div>
	</div>

	<div class="box text-danger"><span class="icons icoAlert"></span> 장비 예약은 PC 버전에서 가능합니다.</div>

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
	<a href="/cklmobile/fcltyResve/eqpmn/list.do?${pageQueryString }" class="btn btn-sm btn-trans"><span class="btnIc btnList"></span> 목록보기</a>
	</div>
</div>
<!-- //bdView -->

