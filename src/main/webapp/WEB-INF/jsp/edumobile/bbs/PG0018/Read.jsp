
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>


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
	<table class="board_type_0 detail notice">
	    <caption>(콘텐츠아카데미) 발로뛰는 취창업지원실 뷰</caption>
	    <colgroup>
	        <col width="100%">
	    </colgroup>
	    <thead>
	    <tr>
	        <th>
	            <span><c:out  value="${result.nttSj }"/></span>
	            <span class="writer_info">
                    <span>Hit.
                        <c:out value="${result.inqireCo }" />
                    </span>
	                <span>
	                    <c:out value="${result.frstRegisterPnttm}" />
	                </span>
	            </span>
	    </tr>
	    </thead>
        <tbody>
        <tr>
            <td>
                <c:if test="${(fn:length(fileList)-1) gt 0 }">
                <!-- thumbGallery -->
                    <%--
                    <div class="visualSet">
                        <div class="visual">
                    --%>
                            <div class="thumbs" id="vsThumbs">
                                <c:forEach var="fileVO" items="${fileList}" varStatus="status">
                                    <c:if test="${fileVO.fileFieldName ne 'main_image' }">
                                    <div> <a href="#self"><img src="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}" width="682" alt="${result.imgDescCn }" /></a></div>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <%--
                            <div class="thumbsList" id="thumbsList">
                                <ul>
                                <!--서브 이미지 탐색  -->
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
                    --%>
                </c:if>

                <!-- webediter -->
                <div class="contents_view_area">
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
            </td>
        </tr>
        <tr>
            <td class="padding_none">
                <div id="livereContainer">
                    <script type="text/javascript">
                    // 	jQuery.noConflict();

                        var consumer_seq = "1077";
                        var livere_seq = "24725";
                        var smartlogin_seq = "1509";
                        var title = "<c:out value="${view.subjnm }" escapeXml="false" />";
                        var viewUrl = window.location.hostname + window.location.pathname;
                        var refer= viewUrl + "?" + "p_subj=<c:out value="${param.p_subj}" />&p_year=<c:out value="${param.p_year}" />&p_subjseq=<c:out value="${param.p_subjseq}" />&menuNo=<c:out value="${param.menuNo}" />";
                        var vote_image = true;
                        refer = refer.replace("http://","");
                        livereReply = new Livere( livere_seq , refer , title );
                        livereLib.start();
                    </script>
                </div>
            </td>
        </tr>
        </tbody>


	</table>

	<!-- 이전글, 다음글 -->
	<div class="paging view_paging">
	    <ul class="pagination">
	        <c:if test="${prevNextMap['PREV'].prevNttId > 0}">
	        	<li class="btn_singlePage prev">
		            <a title="이전 게시물 보기" href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">
		            	<%-- ${prevNextMap['PREV'].nttSj } --%>
		            </a>
	            </li>
            </c:if>
            <c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
            	<li class="btn_singlePage next">
	                <a title="다음 게시물 보기" href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">
	                	<%-- ${prevNextMap['NEXT'].nttSj } --%>
	                </a>
                </li>
            </c:if>
	    </ul>
    </div>

    <!-- 버튼 --> 
    <div class="board_util_btn_con">
        <c:url var="url" value="/edumobile/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
        <a class="btn_style_0 full list" href="<c:out value='${url}' escapeXml='false'/>"><span>목록</span></a>
    </div>

<%-- 임시 주석처리
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
 --%>