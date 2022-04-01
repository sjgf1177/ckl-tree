<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<link href="/edu/css/new/videojs/video-js.css" rel="stylesheet">
<script src="/edu/js/new/videojs/videojs-ie8.js"></script>
<script src="/edu/js/new/videojs/video.js"></script>
<div class="tab_style_1_con"> 
	<ul class="tab_style_1 two_tab">
		<li>
			<a href="/edu/bbs/B0000048/list.do?menuNo=500205">
				<span>이벤트</span>
			</a>
		</li>
		<li class="active">
			<a href="/edu/bbs/B0000023/list.do?menuNo=500206" title="현재탭">
				<span>콘텐츠이야기 </span>
			</a>
		</li>
	</ul>
</div>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

	<c:url value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo }" var="searchUrl" />
	<!-- bdList -->

	<%--
	<div class="tar alert formLine1">
		<form action="${searchUrl }" class="form-inline">
		<input type="hidden" name="menuNo" value="${param.menuNo }">
			<fieldset>
				<legend></legend>
				<div class="clearfix">
					<select name="searchCnd" id="searchCnd" title="구분을 선택해 주세요.">
						<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if>>제목</option>
						<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>내용</option>
					</select> <input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="<c:out value="${paramVO.searchWrd}" />" /> <a href="#self" class="btn btn-primary">검색</a>
				</div>
			</fieldset>
		</form>
	</div>
 --%>
	<div class="col-12 img_card_wrap">
		<div class="col-12 calc_wrap19">
			<div class='col-6 col-sm-4 tc img_card_list'>
				<div class="col-12 show fn img_card">
					<div class="col-12 img_box openPopup_thumbnail thumbnail_01" style="height:auto;" tabindex="0">
						<img src="/edu/new_image/thumbnail_01.jpg" alt="홍보영상1" style="cursor: pointer;">
					</div>
				</div>
			</div>
			<div class='col-6 col-sm-4 tc img_card_list'>
				<div class="col-12 show fn img_card">
					<div class="col-12 img_box openPopup_thumbnail thumbnail_02" style="height:auto;" tabindex="0">
						<img src="/edu/new_image/thumbnail_02.jpg" alt="홍보영상2" style="cursor: pointer;">
					</div>
				</div>
			</div>
			<div class='col-6 col-sm-4 tc img_card_list mr0'>
				<div class="col-12 show fn img_card">
					<div class="col-12 img_box openPopup_thumbnail brochure_thumbnail" style="height:auto;" tabindex="0">
						<img src="/edu/new_image/brochure_thumbnail.jpg" alt="다운로드" style="cursor: pointer;">
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-12 img_card_wrap">
		<div class="col-12 calc_wrap19">

		<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
		<c:forEach var="files" items="${fileList }">
			<c:if test="${files.fileFieldName eq 'main_image' }">
				<c:set  var="file" value="${files }"/>
			</c:if>
		</c:forEach>
			<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
			<div class='col-6 col-sm-4 tc img_card_list <c:if test="${status.index%3 eq 2 }">mr0</c:if>'>
				<a href="${url }" class="col-12 show fn img_card">
                    <div class="col-12 img_box">
                        <c:if test="${not empty file }">
                            <img class="123" src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nttSj}"/>" />
                        </c:if>
                        <c:if test="${empty file }">
                            <img class="" src="/edu/images/common/noimg_312x200.jpg" alt="이미지가 존재하지 않습니다" />
                        </c:if>
                    </div>
				    <div class="col-12 text_box">
				        <h5><c:out value="${result.nttSj }"  /></h5>
				        <hr class="h_line5"/>
				        <p class="h_date5"><c:out value="${result.frstRegisterPnttm }" /></p>
				    </div>
				</a>
			</div>
			<!-- roop -->
			<c:remove var="file"/>
			</c:forEach>

		</div>
	</div>



	<!-- board list end //-->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //bdList -->