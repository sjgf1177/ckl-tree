
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<!-- faq -->
<ul class="faq_con">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<li>
		<div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
			<h5><c:out value="${result.nttSj}" /></h5>
			<p>
				<img class="direc_off" src="/edu/images/bm/faq_direc_off.png" alt="faq 화살표 off 이미지">
				<img class="direc_on" src="/edu/images/bm/faq_direc_on.png" alt="faq 화살표 on 이미지">
			</p>
		</div>
		<div class="faq_reply_con">
			<div>
				<div class="answer">
				<c:out value="${result.nttCn }" escapeXml="false"/>
				</div>
			</div>
		</div>
		<c:if test="${fn:length(resultList) == 0}">
			<div class="faq_reply_con">
				<div>
					<p>
					데이터가 없습니다.
					</p>
				</div>
			</div>
		</c:if>
	</li>
	</c:forEach>
</ul>
<!-- //faq -->

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>
<!-- //paging -->
