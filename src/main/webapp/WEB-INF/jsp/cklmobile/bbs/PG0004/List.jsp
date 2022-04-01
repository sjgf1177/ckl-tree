<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<!-- bdList -->
<div>
	<!-- faq -->
	<dl class="faq">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<dt> <a href="#_self"><span class="icos btn-black"><i class="fa fa-question-circle"></i> 질문</span> <c:out value="${result.nttSj}" /></a> </dt>
		<dd style="display: none;"> <span class="icos btn-success"><i class="fa fa-comment"></i> 답변</span>
			<div>
				<p><c:out value="${result.nttCn }" escapeXml="false"/></p>
			</div>
		</dd>
	</c:forEach>
	</dl>
	<!-- //faq -->

<script type="text/javascript">
//<![CDATA[
$(window).ready(function() {
    $("dl.faq dd").hide();

    $("dl.faq dt").click(function(){
    	$("dl.faq dd").hide();
        $(this).next("dd").show();
    });
});
//]]>
</script>


<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>
<!-- //paging -->
