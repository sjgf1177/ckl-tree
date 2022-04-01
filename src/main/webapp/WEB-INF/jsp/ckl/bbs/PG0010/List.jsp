
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<script type="text/javascript">
//<![CDATA[
$(function() {
	$(".youtube").click(function() {
		var url = $(this).attr("href");
		console.log(url);
		window.open(url,"YoutubePopup","scrollbars=yes,width=1024, height=700");
		return false;
	})
});

//]]>
</script>



<div class="photoGallery4 photo4"><!-- 4n+4의 간격으로 mr0클래스 필수 -->
	<ul>
	<!-- 반복 -->
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
		<c:forEach var="files" items="${fileList }">
			<c:if test="${files.fileFieldName eq 'main_image' }">
				<c:set  var="file" value="${files }"/>
			</c:if>
		</c:forEach>
		<!-- 내용 -->
		<li>
			<a href="<c:if test="${fn:indexOf(result.option1,'http') eq -1 }">https://</c:if><c:out value="${result.option1 }"/>" class="youtube" target="_blank" title="새창열림">
				<c:if test="${not empty file }">
				<span class="movPlayer"><span class="sr-only">동영상 플레이 하기</span></span>
					<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="${file.fileCn}" style="height:180px;width:434px;" />
				</c:if>
				<span class="db fl w100p">
					<c:out value="${result.nttSj }"/>
				</span>
			</a>
		</li>
	</c:forEach>
	<!-- 반복 -->
	</ul>
</div>




<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
	<!-- paging end //-->
</c:if>
<!-- //paging -->










