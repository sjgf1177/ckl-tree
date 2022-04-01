<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<script type="text/javascript">
//<![CDATA[
$(function() {
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

<!-- 시설예약 -->
<a href="javascript:void(0);" class="btnSisul"> <img src="/ckl/images/main/btnSisul.gif" width="90" height="60" alt=""> </a>
<div class="sisulBox">
	<div class="sisulBoxSet">
		<h2 class="fs30">시설예약</h2>
		<div class="tabSisul">

			<c:forEach items="${codeList }" var="codeVO" varStatus="status">
			<h3><a href="#tabSSL0${status.count }"><c:out value="${codeVO.codeNm }" /></a></h3>
			<div class="sisulCts" id="tabSSL0${status.count }">
				<c:if test="${fn:length(fcltyList) > 0 }">
				<ul>
					<c:forEach items="${fcltyList }" var="fcltyVO" varStatus="status2">
					<c:if test="${fcltyVO.lcSe eq codeVO.code }">
					<li>
						<dl>
							<dt><span class="imgLt"><img style="width:320px;height:180px;" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${fcltyVO.atchFileId }" />&amp;fileFieldNm=mainImg" alt="<c:out value="${fcltyVO.spceNm }" />이미지"></span>
							<strong class="title"><c:out value="${fcltyVO.spceNm }" /></strong></dt>
							<dd><util:head length="120" value="${fcltyVO.prpos }" /></dd>
							<dd><a href="/edu/hkFcltyResve/resveSttus/step0.do?menuNo=200020&amp;fcltySn=<c:out value="${fcltyVO.fcltySn }" />" class="btn btnCircle btnMd resveBtn"><span class="ico icoCal"></span> 예약 바로가기</a></dd>
						</dl>
					</li>
					</c:if>
					</c:forEach>

				</ul>
				</c:if>
			</div>
			</c:forEach>

		</div>
		<div class="sisulClose">
			<a href="javascript:void(0);"><img src="/ckl/images/common/closer.png" alt="시설예약 닫기"></a>
		</div>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[
	// 캐시에 담을 요소들
	var selectTab = $('.tabSisul>h3>a');
	var sections = $('.sisulCts');
	$(sections).attr('tabindex', '0');
	$(sections).first().addClass('on').fadeIn();
	$(selectTab).first().addClass('on').fadeIn();
	$(selectTab).on('click', function () {
	    var self = $(this);
	    if (self.hasClass('on')) {
	        return false;
	    }
	    $(selectTab).removeClass('on');
	    self.addClass('on');

	    sections.fadeOut();
	    self.parent().next().fadeIn();
	    return false;
	});
//]]>
</script>
<!-- //시설예약 -->