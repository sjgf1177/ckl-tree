
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<ul class="list_style_2 requst_list">
	<li>
		<p class="sub_title">오프라인교육</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠인사이트/스텝업/밸류업</span></p>
		<p class="sub_text">02.6310.0624</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠플러스</span></p>
		<p class="sub_text">02.6310.0770</p>
		<p class="sub_text"><span class="sub_text_title">게임인재원</span></p>
		<p class="sub_text">031.759.9307</p>
		<p class="sub_text"><span class="sub_text_title">게임리터러시</span></p>
		<p class="sub_text">061.900.6321</p>
	</li>
	<li>
		<p class="sub_title">온라인교육</p>
		<p class="sub_text">02.6310.0770</p>
	</li>
	<li>
		<p class="sub_title">교육지원사업</p>
		<p class="sub_text"><span class="sub_text_title">창의인재동반</span></p>
		<p class="sub_text">02.6310.0661</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠원캠퍼스</span></p>
		<p class="sub_text">02.6310.0628</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠임팩트</span></p>
		<p class="sub_text">02.6310.0621</p>
	</li>
	<li>
		<p class="sub_title">시설/장비</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠인재캠퍼스</span></p>
		<p class="sub_text">02.6310.0630</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠문화광장</span></p>
		<p class="sub_text">02.6310.0665</p>
	</li>
	<!-- <li>
		<p class="sub_title">콘텐츠문화광장</p>
		<p class="sub_text">02.6310.0776</p>
	</li>
	
	<li>
		<p class="sub_title">취업지원</p>
		<p class="sub_text"><span class="sub_text_title">콘텐츠일자리센터</span></p>
		<p class="sub_text">02.3486.9033</p>
		<p class="sub_text">02.3486.9039</p>
	</li> -->
</ul>

<!-- faq -->
<ul class="faq_con">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<li>
		<button class="faq_tit_con">
			<h5>
				<img src="/edu/images/bm/faq_q.png" alt="질문마크 이미지"/>
				<c:out value="${result.nttSj}" />
			</h5>
			<p>
				<img class="direc_off" src="/edu/images/bm/faq_direc_off.png" alt="faq 화살표 off 이미지">
				<img class="direc_on" src="/edu/images/bm/faq_direc_on.png" alt="faq 화살표 on 이미지">
			</p>
		</button>
		<div class="faq_reply_con">
			<div>
				<div class="answer">
				<img src="/edu/images/bm/faq_a.png" alt="답변마크 이미지"/>
				<p><c:out value="${result.nttCn }" escapeXml="false"/></p>
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
