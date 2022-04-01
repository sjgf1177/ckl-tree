
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" /> --%>


<!--content-->

<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
	<input type="hidden" name="p_gubun1" id="p_gubun1" value="<c:out value="${param.p_gubun1 }"/> " />
	<input type="hidden" name="p_gubun2" id="p_gubun2" value="<c:out value="${param.p_gubun2 }"/>" />
	<input type="hidden" name="p_gubun3" id="p_gubun3" value="<c:out value="${param.p_gubun3 }"/>" />
	<input type="hidden" name="p_ordersnm" id="p_ordersnm" value="<c:out value="${param.p_ordersnm }"/>" />
	<input type="hidden" name="p_orders" id="p_orders" value="<c:out value="${param.p_orders }"/>" />
	
	<input type="hidden" name="p_menuTab" id="p_menuTab" value="<c:out value="${param.p_menuTab }" />" />
	
	<input type="hidden" name="p_subj" id="p_subj" value="" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" value="" />
	<input type="hidden" name="p_isonoff" id="p_isonoff" value="" />
	<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="" />
	<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="" />
	<input type="hidden" name="p_year" id="p_year" value="" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" value="" />
	
</form>



<!-- stepInline 영역 s -->
<%-- <jsp:include page="/WEB-INF/jsp/edu/onlineEdu/mylctrum/mylctrumStep.jsp" flush="true" /> --%>
<!-- stepInline 영역 e -->



<div class="row mb5">
	<p><span class="icoDanger"></span>  찜 한 강좌는 최대 30개까지 보관되며 30개 초과시 오래된 순서로 자동 삭제 됩니다.</p>
</div>

<div class="photoGallery2 photoLine1">
	<ul>
	
		<!-- 정규과정 찜목록 s -->
		<c:forEach items="${resultList }" var="item" varStatus="status">
			<li>
<!-- 				<a href="#self"> -->
				<a href="javascript:void(0);" onclick="fnCmdViewPage('${item.subj }', '${item.subjnm }', '${item.isonoff }', '${item.upperclass }', '${item.uclassnm }', '${item.year }', '${item.subjseq }'); return false;">
					<% pageContext.setAttribute("crlf", "\\"); %>
					<span class="img">
					<c:choose>
						<c:when test="${item.introducefilenamenew != null and item.introducefilenamenew != '' }">
							<img alt="${item.subjnm }" src="<c:out value="${fn:replace(item.introducefilenamenew, crlf, '/') }" />" width="150px;" height="100px;" />
						</c:when>
						<c:otherwise>
							<img alt="${item.subjnm }" src="/edu/images/edupro/stepsub-03.png" width="150px;" height="100px;" />
						</c:otherwise>
					</c:choose>
					</span>
					<span class="title point tal"><strong>${item.subjnm }</strong></span>
					<span class="db tal">${item.intro }</span>
				</a>
				<span class="linkers">
					<c:if test="${item.isnew eq 'Y' }">
						<span class="ico1"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_01.gif" alt="인기" /></a></span>
					</c:if>
					
					<c:if test="${item.ishit eq 'Y' }">
						<span class="ico2"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_02.gif" alt="추천" /></a></span>
					</c:if>
					
					<c:if test="${item.mobileUseYn eq 'Y' }">
						<span class="ico3"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_03.gif" alt="모바일" /></a></span>
					</c:if>
				</span>
			</li>
		</c:forEach>
		<!-- 정규과정 찜목록 e -->
	</ul>
</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
</c:if>



<script type="text/javascript">
//<![CDATA[
           
           
	$(document).ready(function(){
					
		
	});

	
	//과정 상세화면
	function fnCmdViewPage(subj, subjnm, isonoff, scupperclass, uclassnm, scyear, subjseq){
		
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_isonoff").val(isonoff);
		$("#p_scupperclass").val(scupperclass);
		$("#p_uclassnm").val(uclassnm);
		$("#p_year").val(scyear);
		$("#p_subjseq").val(subjseq);
		
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/view.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}

//]]>
</script>