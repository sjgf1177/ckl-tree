<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<%-- ${occpCateList } --%>

<script type="text/javascript">
//<![CDATA[
$(function() {

	$(".step .closer").click(function(){
		$('.box').slideUp("fast");
		$(this).parent().parent().find("a").focus();
		return false;
	});
})
//]]>
</script>

<div class="cel pb20 mb10">
	<h3><c:out value="${codeNm }" /></h3>
	<c:if test="${fn:length(resultList) > 0 }">
	<ul class="bull">
	<c:forEach items="${resultList }" var="result"> <!-- 서브 제목 출력 -->
		<c:url var="url" value="/edu/job/dicary/view.do?&dicarySn=${result.dicarySn }&cnSn=${result.dicarySn }&menuNo=${paramVO.menuNo }&ctgrySe1=${param.ctgrySe1 }&ctgrySe2${param.ctgrySe2 }"/>
		<li><a href="<c:out value = "${url }"/>"><c:out value="${result.dicarySj }"/> </a></li>
	</c:forEach>

	</ul>
	</c:if>
</div>
<span><a href="#self" class="closer"><span class="sr-only">하위메뉴 닫기</span></a></span>
