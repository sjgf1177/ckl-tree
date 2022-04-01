<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="/WEB-INF/jsp/edu/inc/incMainFn.jsp"%>
<body id="subContainer">
<div class="wrapper sub_layout_main">
    <!-- header -->
    <div class="col-12 print_out">

        <!--GNBhead-->
        <jsp:include page="/WEB-INF/jsp/edu/inc/subMainHead.jsp" flush="true" />
        <!--//GNBhead-->
	</div>
	 <div class="col-12">
        <div class="col-12 col-center visual_inner print_out">
            <div class="col-12 col-center mw-1200">
                <div class="col-12 pr15 pl15">
                    <div class="col-12 tc visual_wrap">
                        <div class="col-12 visual_util_wrap">
                            <div class="fl fontsize0 linemap_wrap">
                                <ul class="col-12 linemap_con">
                                    <li class="white"><a href="/edu/main/main.do"><span style="clip: rect(1px, 1px, 1px, 1px); position:relative;">Home</span></a></li>
                                    <!-- <li class="white"><a href="javascript:void(0)"><span style="color:white">HOME</span></a></li> -->
                                </ul>
                            </div>
                            <div class="tr sharing_util_icon">
                            <li>
                            <a href="javascript:void(0);" class="ico01 white snsToggleOpen"><span class="hidden">SNS 공유하기</span></a>
                            <div class="snsDrop" style="display:none;">
                            <c:url value="https://www.facebook.com/sharer.php" var="fbUrl">
                                <c:param name="t" value="${title}" />
                                <c:param name="u" value="${currMenu.fullMenuLink}" />
                            </c:url>
                            <c:url value="https://twitter.com/share" var="twitterUrl">
                                <c:param name="text" value="${title}" />
                                <c:param name="url" value="${currMenu.fullMenuLink}" />
                            </c:url>
                            <ul>
                            <li><a href="<c:out value='${fbUrl}' escapeXml='true' />" class="icos01" onclick="return facebookOpen();" title="(새창열림)페이스북 링크 공유하기" target="_blank"><span class="hidden">페이스북</span></a></li>
                            <li><a href="<c:out value='${twitterUrl}' escapeXml='true' />" class="icos02" onclick="return twitterOpen();" title="(새창열림)트위터 링크 공유하기" target="_blank"><span class="hidden">트위터</span></a></li>
                            </ul>
                            </div>
                            </li>
                            <li><a href="#self" Class="ico02 white CopyClipOpen"><span Class="hidden">URL 복사하기</span></a>
                            <script type="text/javascript">
                            //<![CDATA[
                            var linkURL = document.URL;
                            var param = "";
                            $(document).ready(function(){
                            $(':hidden').each(function(){
                            if(null != $(this).attr('name') && $(this).val() != ""){
                            if( linkURL.indexOf($(this).attr('name')) < 0){
                            param += "&"+$(this).attr('name')+"="+$(this).val();
                            }
                            }
                            });

                            $(".sharing_util_icon .ico02").click(function(){
                            urlLink();
                            return false;
                            });
                            });

                            //$("#COPYCP").prop("value", linkURL);
                            function urlLink() {
                            var IE = (document.all) ? true : false;
                            if (IE) {
                            window.clipboardData.setData('Text', linkURL + param);
                            alert('주소가 복사되었습니다. 브라우저의 URL 입력창에 Ctrl+V로 붙여 넣기 하세요.');
                            } else {
                            temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", linkURL + param );
                            }
                            return false;
                            }
                            //]]>
                            </script>
                            </li>
                            <li><a href="/edu/forPrint.jsp" class="ico03 white" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기"><span class="hidden">인쇄하기</span></a></li>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- <div class="sub_visual home_img"></div> -->
        <span class="visual_arrow left">
        	<img src="/edu/images/bm/visual_rolling_left_arrow.png" alt="왼쪽 비쥬얼 보기">
        </span>
        <span class="visual_arrow right">
        	<img src="/edu/images/bm/visual_rolling_right_arrow.png" alt="오른쪽 비쥬얼 보기">
        </span>
        
        <div class="" id="eduHomeMainVisual" style="position: absolute; top:0; left:0; width:100%; height:100%; z-index:-1;">
	        <div class="main_visual_000 active">
	        </div>
	        <div class="main_visual_001">
	        </div>
	        <div class="main_visual_002">
	        </div>
	        <div class="main_visual_003">
	        </div>
	        <div class="main_visual_004">
	        </div>
	        <!-- <div class="main_visual_005">
	        </div> -->
	        <!-- <img class="mySlides w3-animate-right" src="/edu/images/bm/main_visual_image_00.jpg" style="width:100%">
	        <img class="mySlides w3-animate-right" src="/edu/images/bm/main_visual_image_01.jpg" style="width:100%"> -->
        </div>
        
        
        
        <div class="col-12 col-center mw-1200" id="content_sub_wrap">
            <div class="col-12 pr15 pl15">
                <div class="col-12 sub_section campus_card_con">
                    <div class="col-12 campus_card first">
                        <div class="col-12 col-md-6 img_box"></div>
                        <div class="col-12 col-md-6 fr-md text_box" style="opacity:0.8">
                            <h3>콘텐츠인재캠퍼스</h3>
                            <hr class="h_line3">
                            <p class="h_desc3">
                                1% 핵심인재 양성을 위한 프로젝트 중심 융복합 교육
                                프로그램을 개발하고, 영상 음향 스튜디오, 창제작시설과
                                융복합 콘텐츠 테스트베드 “콘텐츠문화광장”을 운영합니다.
                            </p>
                            <ul class="list_style_1">
                                <li><a href="/edu/main/contents.do?menuNo=500106">콘텐츠인재캠퍼스 소개</a></li>
                                <li><a href="/edu/main/contents.do?menuNo=500004">시설물안내</a></li>
                                <li><a href="/edu/main/contents.do?menuNo=500227">찾아오시는 길</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-12 campus_card second">
                        <div class="col-12 col-md-6 img_box"></div>
                        <div class="col-12 col-md-6 text_box" style="opacity:0.8">
                            <h3>인사말</h3>
                            <hr class="h_line3">
                            <p class="h_desc3">
                                4차 산업혁명을 주도할 융합형 창의인재 양성의 중심 허브!<br/>
                                	에듀코카는 창조경제의 핵심산업인<br/>
                                콘텐츠산업을 견인하고 있는 한국콘텐츠진흥원의<br/>
                                콘텐츠전문인력양성기관입니다.
                            </p>
                            <p class="tr more_btn_con">
                                <!-- <a href="/edu/main/contents.do?menuNo=500002" class="show more_btn">
                                    상세보기
                                </a> -->
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //header -->

    <!-- contents -->
    <!-- sub_layout -->
    <div class="col-12 sub_contents_wrap">
        <div class="col-12 col-center mw-1200 over-visible">
            <div class="col-12 pr15 pl15">
                <div class="lnb_wrap">
                    <div class="lnb_header">
                        <h3 class="show-tablecell vm tc">
                            인재캠퍼스
                        </h3>
                    </div>
                    <ul class="lnb_con">
                        <li class="lnb_1"><a href="/edu/main/contents.do?menuNo=500001"><span>콘텐츠 인재 캠퍼스</span></a>
                            <!--<ul class="lnb_1_1depth">-->
                            <!--<li><a href="javascript:void(0)"><span>콘텐츠 인재 캠퍼스</span></a>-->
                            <!--</li>-->
                            <!--<li><a href="javascript:void(0)"><span>공지사항</span></a></li>-->
                            <!--<li><a href="javascript:void(0)"><span>문의하기</span></a></li>-->
                            <!--<li><a href="javascript:void(0)"><span>인사말</span></a></li>-->
                            <!--</ul>-->
                        </li>
                        <li class="lnb_2"><a href="/edu/bbs/B0000011/list.do?menuNo=500008"><span>공지사항</span></a></li>
                        <li class="lnb_3"><a href="/edu/bbs/B0000038/list.do?menuNo=500017"><span>문의하기</span></a></li>
                        <li class="lnb_4 active"><a href="/edu/main/contents.do?menuNo=500002"><span>인사말</span></a></li>
                    </ul>
                </div>
                <!-- //sub_layout -->
                <div class="col-12 col-md-0 fn-md over-hidden fontsize0 sub_contents" style="margin-top:30px;">
                    <%--<div class="col-12 sub_section sub_main_contents_section">
                         <div class="col-12">
                            <div class="col-12 col-md-6 recent_board">
                                <h3>공지사항</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/bbs/B0000011/list.do?menuNo=500008" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${B0000011List}" varStatus="status">
                                    <c:set var='content' value='${result.nttCn}'/>
                                    <%
                                    String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                    content = removeTag(content);
                                    if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
                                    %>
                                    <c:if test="${status.index == 0}">
                                    <li><a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008"><c:out value="${result.nttSj}"/></a></li>
                                    <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008" class="show-block recent_notice">
                                        <h4 class="new"><span>${result.nttSj}</span></h4>
                                        <p class="h_desc4"><%=content%></p>
                                        <p class="h_date4">${fn:substring(result.regDate,0,10)}</p>
                                    </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0">
                                <c:forEach var="result" items="${B0000011List}" varStatus="status">
                                    <c:if test="${status.index > 0}">
                                    <li><a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008"><c:out value="${result.nttSj}"/></a></li>
                                    </c:if>
                                </c:forEach>
                                </ul>
                            </div>
                            <div class="col-12 col-md-6 recent_board question">
                                <h3>문의사항</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/bbs/B0000038/list.do?menuNo=500017" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${cnslBoardList}" varStatus="status">
                                    <c:if test="${status.index == 0 }">
                                        <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500017" class="show-block">
                                            <h4 class="aqua_green new"><span>${result.nttSj}</span></h4>
                                        </a>
                                        <c:choose>
                                            <c:when test="${result.replyAt eq 'Y'}"><p class="h_button_con end"></c:when>
                                            <c:otherwise><p class="h_button_con go"></c:otherwise>
                                        </c:choose>
                                            <a href="javascript:void(0)" class="h_btn go">
                                            미완료
                                            </a>
                                            <a href="javascript:void(0)" class="h_btn end">
                                            완료
                                            </a>
                                        </p>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 question">
                                    <c:forEach var="result" items="${cnslBoardList}" varStatus="status">
                                        <c:if test="${status.index > 0 }">
                                        <c:set var='isComplete' value=''/>
                                        <c:set var='isLock' value=''/>
                                        <c:choose>
                                            <c:when test="${result.replyAt eq 'Y'}"></c:when>
                                            <c:otherwise><c:set var='isComplete' value='no_complete'/></c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${result.secret eq 'Y'}"><c:set var='isLock' value='lock'/></c:when>
                                            <c:otherwise></c:otherwise>
                                        </c:choose>
                                        <li class="${isComplete} ${isLock}">
                                            <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500017">
                                            <c:choose>
                                                <c:when test="${result.option1 eq '01'}">[현장교육]</c:when>
                                                <c:when test="${result.option1 eq '02'}">[온라인교육]</c:when>
                                                <c:when test="${result.option1 eq '03'}">[창의인재동반]</c:when>
                                                <c:when test="${result.option1 eq '04'}">[취업정보]</c:when>
                                            </c:choose>
                                            <c:out value="${result.nttSj}"/>
                                            </a>
                                            <span class="list_style_0_end_text">완료</span>
                                            <span class="list_style_0_ing_text">미완료</span>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                                <p class="tr add_btn_con">
                                    <a href="/edu/bbs/B0000038/forInsert.do?searchCnd=&searchWrd=&gubun=&delCode=0&useAt=&replyAt=&menuNo=500017&sdate=&edate=&viewType=&type=&siteId=&option1=&option5=&pageIndex=1" class="show add_btn">등록하기</a>
                                </p>
                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- //contents -->
    


	<div class="print_out">
    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/edu/inc/eduFooter.jsp" flush="true" />
    <!-- //footer -->
    </div>
</div>
</body>