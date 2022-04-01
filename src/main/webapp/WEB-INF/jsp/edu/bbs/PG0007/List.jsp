
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<script type="text/javascript">
$('window').ready(function() {
	$(".pagination li a").attr("href", function() {
		var $url  =this.href.replace ('option1=', 'option3=<c:out value='${param.option3}' />');
		return $url;
	});
});

</script>
<!--content-->

<%--
<div class="bdLastest">
	<div class="lastestUl">
		<ul>
			<li>
				<dl>
					<dt>
						<div class="imageBg" style="background: url(/edu/images/sub/bdLastest01.jpg) no-repeat;">
							<!-- db Background Image -->
							<img src="/edu/images/sub/bdLastest01.png" alt="" />
						</div>
						문화컨텐츠 산업 현장의 멘토 인터뷰입니다.
						<!-- //title -->
					</dt>
					<dd>문화콘텐츠 산업의 장르 및 직업 분류 체계에 따라 직업의 직무내용, 자격요건, 직업전망 등의 상세한 정보를 제공합니다.</dd>
				</dl>
			</li>
		</ul>
	</div>
</div>
 --%>

<div class="stepInline stepInlineSm mt30">
	<ol>
		<li <c:if test="${empty paramVO.option3 }" >class="on"</c:if>><a href="/edu/bbs/B0000027/list.do?menuNo=<c:out value="${paramVO.menuNo}" />">전체</a></li>
		<c:forEach var="x" begin="0" end="${fn:length(COM091CodeList)-2}"  varStatus="status" >
		<li <c:if test="${COM091CodeList[x].code eq paramVO.option3}" >class="on"</c:if>><a href="/edu/bbs/B0000027/list.do?menuNo=<c:out value="${paramVO.menuNo}" />&amp;option3=<c:out value="${COM091CodeList[x].code }" />"><c:out value="${COM091CodeList[x].codeNm }" /></a></li>
		</c:forEach>
	</ol>
</div>

<div class="photoGallery4 mb50">
	<!-- 5n+5의 간격으로 mr0클래스 필수 -->
	<ul style="width:100%">

		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
			<c:forEach var="fileList" items="${files }">
				<c:if test="${fileList.fileFieldName eq 'main_image' }">
					<c:set var="fileVO" value="${fileList }" />
				</c:if>
			</c:forEach>
			<%-- ${fileVO } --%>
			<li style="width:33.333%" <c:if test="${status.count%4 eq 0 }">class="mr0"</c:if> >
					<a class="uline fl" style="width:105px" href="#self">
						<c:if test="${not empty fileVO}">
							<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&option3=${param.option3 }${pageQueryString}" />
							<a class="uline fl" style="width:105px" href="<c:out value="${url }" escapeXml='false' />">
							<img alt="<c:out value='${fileVO.orignlFileNm}' />" src="/cmm/fms/getImage.do?atchFileId=<c:out value='${fileVO.atchFileId}'/>&amp;fileSn=<c:out value='${fileVO.fileSn}'/>"  />
							</a>
						</c:if>
						 <c:set var="fileVO" value="" />
					</a>
				<dl style="width:200px">
					<dt class="fs1 fcPurple"><strong>성명</strong></dt>
					<dd class="fs1 fcPurple"><c:out value="${result.option1}" /></dd>
					<dt class="fs1"><strong>분야</strong></dt>
					<dd class="fs1"><c:out value="${result.option3Nm}" /></dd>
					<dt><strong>직업</strong></dt>
					<dd><util:noTagStr length="8"  value="${result.option2}" brTp="true"  /></dd>
					<dt><strong>기관</strong></dt>
					<dd><util:noTagStr length="8"  value="${result.option4}" brTp="true"  /></dd>
				</dl>
			</li>
		</c:forEach>
		<c:if test="${fn:length(resultList) <= 0}" >
		<li <c:if test="${status.count%5 le 0 }">class="mr0"</c:if> >
				<dl>
					<strong>데이터가 존재하지않습니다</strong>
				</dl>
			</li>
		 </c:if>

	</ul>
</div>

<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
<!-- //paging -->
