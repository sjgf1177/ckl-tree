<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>


<%--이미지 탐색 main_image 처리 --%>
<%-- 					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName eq 'main_image'}">
								<c:set var="mainImage" value="${fileList[x]}"/>
							</c:if>
						</c:forEach>
					</c:if> --%>
<%--이미지 탐색 main_image 끝 --%>






		<!-- //thumbGallery -->

<%-- <c:out value="${fileList }" /> --%>


	<!-- bdView -->
	<div class="dlListTable">
		<dl>
			<dt>제목</dt>
			<dd><c:out  value="${result.nttSj }" escapeXml="false"/></dd>
			<dt>작성일</dt>
			<dd class="w15p tac"><c:out value="${result.frstRegisterPnttm}" escapeXml="false" /></dd>
		</dl>

	<c:if test="${(fn:length(fileList)-1) gt 0 }">
		<!-- thumbGallery -->
		<div class="visualSet">
			<div class="visual">
				<div class="thumbs" id="vsThumbs">
					<c:forEach var="fileVO" items="${fileList}" varStatus="status">
						<c:if test="${fileVO.fileFieldName ne 'main_image' }">
						<div> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="682" alt="<c:out value="${fileVO.orignlFileNm }" />" /></a></div>
						</c:if>
					</c:forEach>
				</div>
				<div class="thumbsList" id="thumbsList">
					<ul>
					<%--서브 이미지 탐색  --%>
					<c:if test="${fn:length(fileList) gt 0}">
						<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
							<c:if test="${fileList[x].fileFieldName ne 'main_image' }">
							<li><a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileList[x].atchFileId}&amp;fileSn=${fileList[x].fileSn}" alt="<c:out value="${fileList[x].orignlFileNm }" />" /></a></li>
							</c:if>
						</c:forEach>
					</c:if>
					</ul>
				</div>
			</div>
		</div>
	</c:if>

		<!-- webediter -->
		<div class="editDB">
			 <c:choose>
				<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
				<c:otherwise>
					<% pageContext.setAttribute("crlf", "\n"); %>
					${fn:replace(result.nttCn, crlf, "<br/>")}
				</c:otherwise>
			</c:choose>

			<!-- 본문이미지 대체텍스트 -->
			<!-- <div class="hidden">${result.imgDescCn}</div> -->
		</div>
		<!-- //webediter -->

		<div class="btnSet tar">
			<c:url var="url" value="/edumobile/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
			<a class="btn btn-primary" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
		</div>


		<div class="dlListTable">
			<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
				<dl>
					<dt>이전글</dt>
					<dd>
						<a title="이전 게시물 보기" href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> 
							<%-- ${prevNextMap['PREV'].nttSj } --%>
						</a>
					</dd>
				</dl>
			</c:if>
			<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
				<dl>
					<dt>다음글</dt>
					<dd>
						<a title="다음 게시물 보기" href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">
							<%-- ${prevNextMap['NEXT'].nttSj } --%>
						</a>
					</dd>
				</dl>
			</c:if>


		</div>


	</div>

<script type="text/javascript" src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>

<script type="text/javascript">
	//<![CDATA[
	$(function() {
		var lstSize = <c:out value='${fn:length(fileList)}' />;
		if (lstSize > 0) lstSize = lstSize -1;

		$('#thumbsList ul').carouFredSel({
			items : {
				visible : lstSize
			},
			direction : 'up',
			scroll : {
				items : 4,
				pauseOnHover : true
			},
			auto : {
				play : false,
				duration : 750,
				timeoutDuration : 2000,
				easing : 'quadratic',
				onBefore : function() {
					var index = $(this).triggerHandler('currentPosition');
					if (index == 0) {
						index = $(this).children().length;
					}
					$('#vsThumbs').trigger('slideTo', [ index, {
						fx : 'directscroll'
					}, 'prev' ]);
					$('#thumbsList ul').find('li').eq(index).addClass('selected');
				}

			},
			next : ".nextVs"
		});

		var thumbsList = $('#thumbsList ul li');
		thumbsList.bind("click", function() {
			var index = thumbsList.index(this);
			$('#vsThumbs').trigger('slideTo', [ index, {
				fx : 'directscroll'
			}, 'prev' ]);
		});

		$('#vsThumbs').carouFredSel({
			items : 1,
			direction : 'left',
			width : 790,
			height : 400,
			scroll : {
				items : 1
			},
			auto : {
				play : false,
				duration : 750,
				easing : 'directscroll'
			}
		});
	});
	//]]>
</script>





<%-- <h2 class="mb10">${result.nttSj }</h2>

<dl class="inline">
	<dt>작 성 일 : </dt>
	<dd><c:out value="${result.frstRegisterPnttm}" /></dd>
	<dt>조 회 수 : </dt>
	<dd><c:out value="${result.inqireCo}"/></dd>
</dl>

<dl class="inline">
	<dt>첨부파일 : </dt>
	<dd>
	<c:forEach var="fileVO" items="${fileList}" varStatus="status">
		<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
			<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte] <br />
		</a>
	</c:forEach>
	<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>

	</dd>
</dl>

<!-- webediter -->
<div class="editDB">
	<c:choose>
		<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
		<c:otherwise>
			<% pageContext.setAttribute("crlf", "\n"); %>
			${fn:replace(result.nttCn, crlf, "<br/>")}
		</c:otherwise>
	</c:choose>
	<div class="hidden"><c:out value="${result.imgDescCn}"/></div>
</div>
<!-- //webediter -->

<div class="btnSet tar">
	<c:url var="url" value="/edumobile/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
	<span><a href="<c:out value='${url}' escapeXml='false'/>" class="btn btn-primary">목록</span></a>
</div>


<div class="dlViewTable">
<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
	<dl>
		<dt class="bdViewPrev"><span class="hidden">이전글</span></dt>
		<dd>
		<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['PREV'].nttSj }" /> </a>
		</dd>
	</dl>
</c:if>
<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
	<dl>
		<dt class="bdViewNext"><span class="hidden">다음글</span></dt>
		<dd>
			<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />"> <c:out value="${prevNextMap['NEXT'].nttSj }" /> </a>
		</dd>
	</dl>
</c:if>
</div> --%>