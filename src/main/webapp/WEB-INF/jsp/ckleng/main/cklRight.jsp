<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<%-- <script type="text/javascript">
//<![CDATA[
function search3(q){
	$("#q3").val(q);
	document.frmSearch3.submit();
}
//]]>
</script> --%>

<!-- content Side -->
<div class="contentRight">
	<div class="faqRt">
		<h2>FAQ</h2>
		<ul>
		<c:forEach var="result" items="${faqList }" varStatus="status">
			<li><a href="/ckleng/bbs/B0000050/list.do?menuNo=300030"><c:out value="${result.nttSj }" /></a></li>
		</c:forEach>
		<c:if test="${fn:length(faqList) == 0 }"><li>No Data.</li></c:if>
		</ul>
	</div>


	<%-- <div class="tags">
			<h2>통합검색</h2>
			<form name="frmSearch3" method="post" action="/ckl/search/list.do?menuNo=200061" onsubmit="return search3(this.SCHWD.value);">

				<fieldset>
					<legend>통합검색 입력양식</legend>
						<div class="ctRtSchSet">
							<input type="text" name="q" id="q3"  value="" class="ctRtSchIn" title="검색어를 입력해 주세요." />
							<input type="image" class="ctRtSchOk" src="/images/common/schOk.gif" alt="검색확인" />
						</div>
				</fieldset>
			</form>

			<ul>
				<c:forEach var="ps" items="${psList }" varStatus="status">
				<li><a href="javascript:search3('${ps.srchwrd}');">${ps.srchwrd}</a></li>
				</c:forEach>
				<c:if test="${fn:length(faqList) == 0 }"><li></li></c:if>
			</ul>
		</div> --%>

	<div class="rightSrcs">
		<ul class="rv">
			<li><a href="/ckleng/main/contents.do?menuNo=300034"><img src="/ckleng/images/sub/ctsRts_01_off.gif" alt="The Space" /></a></li>
			<li><a href="/ckleng/main/contents.do?menuNo=300029"><img src="/ckleng/images/sub/ctsRts_02_off.gif" alt="Regional center " /></a></li>
			<li><a href="/ckleng/main/contents.do?menuNo=300024"><img src="/ckleng/images/sub/ctsRts_03_off.gif" alt="About CKL" /></a></li>
			<li><a href="/ckleng/main/contents.do?menuNo=300028"><img src="/ckleng/images/sub/ctsRts_04_off.gif" alt="Location" /></a></li>
		</ul>
	</div>

	<div class="telAddress">
		<img src="/ckleng/images/common/contentRts_05.gif" alt="(+82-2) 2161-0000" />
	</div>
</div>
<!-- content Side -->



<!-- content Mini -->
<div class="contentRightMini">
	<ul>
		<li><a href="/ckleng/main/contents.do?menuNo=300034"><img src="/ckleng/images/sub/ctsRtQick_01.gif" alt="The Space" /></a></li>
		<li><a href="/ckleng/main/contents.do?menuNo=300029"><img src="/ckleng/images/sub/ctsRtQick_02.gif" alt="Regional center " /></a></li>
		<li><a href="/ckleng/main/contents.do?menuNo=300024"><img src="/ckleng/images/sub/ctsRtQick_03.gif" alt="About CKL" /></a></li>
		<li><a href="/ckleng/main/contents.do?menuNo=300028"><img src="/ckleng/images/sub/ctsRtQick_04.gif" alt="Location" /></a></li>
	</ul>
</div>
<!-- content Mini -->
