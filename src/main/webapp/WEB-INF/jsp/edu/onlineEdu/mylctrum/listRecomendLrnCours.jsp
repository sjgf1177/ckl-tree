
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
	<input type="hidden" name="p_seq" id="p_seq" value="" />
	
	<input type="hidden" name="p_menuTab" id="p_menuTab" value="<c:out value="${param.p_menuTab }" />" />


</form>

<!-- stepInline 영역 s -->
<%-- <jsp:include page="/WEB-INF/jsp/edu/onlineEdu/mylctrum/mylctrumStep.jsp" flush="true" /> --%>
<!-- stepInline 영역 e -->


<div class="photoGallery2">
	<div class="cel mt30 pb20 mb10">
		
		<!-- 1.경로 영역 s -->
		<%-- 
		<c:forEach items="${edcSystmList }" var="item" varStatus="status">
			<dl class="desc clearfix <c:if test="${status.index > 0 }"> mt30 </c:if>">
				<dt class="point"><c:out value="${item.upperchartname }" /> &#62; <c:out value="${item.middlechartname }" /> &#62; <c:out value="${item.lowchartname }" /></dt>
				<dd>
					<p class="posr tac">${item.chartname } <a href="javascript:void(0);" onclick="fnCmdOutScrap('${item.seq}', 'cancel'); return false;" class="btn btn-black btn-sm db posa" style="top:0;right:0;">삭제</a></p>
					<ol class="seqBox clearfix mt20">
					
					
						<!-- 2.학습 영역 s -->
						<c:forEach items="${brdcstEdcSystmCList }" var="item2" varStatus="status2">
							<c:if test="${item.chartcode eq item2.upperchartcode }">
								<li><span class="boxGray tac"><c:out value="${item2.chartname }" /></span>
									<c:if test="${item2.lastyn eq 'N' }"> <span class="arr"></span></c:if>
								</li>
							</c:if>
						</c:forEach>
						<!-- 2.학습 영역 e -->
					</ol>
				</dd>
			</dl>
		</c:forEach>
		 --%>
		 
		<c:forEach items="${edcSystmList }" var="item" varStatus="status">
			<!-- 추천 학습 경로에서의 해당 단계 -->
			<div class="m1">
				<h3 class="trmTit"><c:out value="${item.upperchartname }" /> &#62; <c:out value="${item.middlechartname }" /> &#62; <c:out value="${item.lowchartname }" /> ▼</h3>
				<div class="alert trmStep">
					<dl>
						<dt><c:out value="${item.chartname }" /></dt>
						<dd>
							<ol class="stepList">
								<!-- 2.학습 영역 s -->
								<c:forEach items="${brdcstEdcSystmCList }" var="item2" varStatus="status2">
									<c:if test="${item.chartcode eq item2.upperchartcode }">
										<li><span><c:out value="${item2.chartname }" /></span></li>
									</c:if>
								</c:forEach>
								<!-- 2.학습 영역 e -->
							</ol>
							<button type="button" onclick="fnCmdOutScrap('${item.seq}', 'cancel'); return false;" class="btn btn-primary btn-scrap"><span class="ico-scrap"></span>삭제</button>
						</dd>
					</dl>
				</div>
			</div>
		</c:forEach>
		<!-- 1.경로 영역 e -->
		
	
	</div>

</div>






<script type="text/javascript">
//<![CDATA[
           
           
	$(document).ready(function(){
					
		
	});

	
	//스크랩 삭제
	function fnCmdOutScrap(seq){
		
		$("#p_seq").val(seq);
		$("#frm").attr({
					action:"/edu/onlineEdu/edcsystm/eduSystmScrapDelete.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}

//]]>
</script>