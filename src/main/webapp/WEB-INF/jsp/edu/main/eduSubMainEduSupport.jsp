<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@include file="/WEB-INF/jsp/edu/inc/incMainFn.jsp"%>
<body id="subContainer">
<div class="wrapper sub_layout_main">
    <!-- header -->
    <div class="col-12 print_out">

        <!--GNBhead-->
        <jsp:include page="/WEB-INF/jsp/edu/inc/subMainHead.jsp" flush="true" />
        <!--//GNBhead-->
	</div>
	 <div class="col-12" id="content_sub_wrap">
        <div class="col-12 col-center visual_inner print_out">
            <div class="col-12 col-center mw-1200">
                <div class="col-12 pr15 pl15">
                    <div class="col-12 tc visual_wrap">
                        <div class="col-12 visual_util_wrap">
                            <div class="fl fontsize0 linemap_wrap">
                                <ul class="col-12 linemap_con">
                                    <li><a href="/edu/main/main.do"><span style="clip: rect(1px, 1px, 1px, 1px); position:relative;">Home</span></a></li>
                                    <li><a href="javascript:void(0)" tabindex="-1"><span>교육지원사업</span></a></li>
                                </ul>
                            </div>
                            <div class="tr sharing_util_icon">
                            <li>
                            <a href="javascript:void(0);" class="ico01 snsToggleOpen"><span class="hidden">SNS 공유하기</span></a>
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
                            <li><a href="#self" Class="ico02 CopyClipOpen"><span Class="hidden">URL 복사하기</span></a>
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
                            <li><a href="/edu/forPrint.jsp" class="ico03" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기"><span class="hidden">인쇄하기</span></a></li>
                            </div>
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
                <!-- //sub_layout -->
                <div class="col-12 col-md-0 fn-md over-hidden fontsize0 sub_contents" >
                    <div class="col-12 sub_section sub_main_contents_section"style="padding:0; border:none;">
                        <div class="col-12 mb70">
                            <div class="col-12 col-md-6 recent_board">
                                <h3>교육지원사업 핫이슈</h3>
                                <hr class="h_line3">
                                <div class="col-12 calc_wrap15 kofac_card_wrap">
                                    <c:forEach items="${creList}" var="result" varStatus="status">
                                        <c:set var='content' value='${result.nttCn}'/>
                                        <c:set var='imgDesc' value='${result.imgDesc}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
                                        %>
                                        <div class="col-12 kofac_card_con">
                                            <a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500035" class="col-12 show fn kofac_card_list" style="max-width:100%;">
                                                <div class="img_box" style="text-align:center;">
                                                    <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&fileSn=${result.fileSn}" alt="${result.nttSj}" style="">
                                                </div>
                                                <div class="text_box">
                                                    <h4>[<c:out value="${result.menuName}" />] <c:out value="${result.nttSj}" /></h4>
                                                </div>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 recent_board">
                                <h3>창의인재동반 &gt; 창의현장</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/bbs/B0000041/list.do?menuNo=500035" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach items="${B0000041List}" var="result" varStatus="status">
                                    <c:set var='content' value='${result.nttCn}'/>
                                    <c:set var='imgDesc' value='${result.imgDesc}'/>
                                    <%
                                    String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                    content = removeTag(content);
                                    if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
                                    %>
                                    <c:if test="${status.index == 0}">

                                    <a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500035" class="show-block recent_notice">
                                        <h4 class="new"><span><c:out value="${result.nttSj}" escapeXml="false" /></span></h4>
                                    </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0">
                                    <c:forEach items="${B0000041List}" var="result" varStatus="status">
                                        <c:set var='content' value='${result.nttCn}'/>
                                        <c:set var='imgDesc' value='${result.imgDesc}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
                                        %>
                                        <c:if test="${status.index > 0 }">
                                        <li>
                                            <a href="/edu/bbs/${result.bbsId}/view.do?nttId=${result.nttId}&menuNo=500035">
	                                            <c:out value="${result.nttSj}"/>
	                                            <p class="h_date4" style="margin:0;">${result.regDate}</p>
                                            </a>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>

                        <div class="col-12 sub_main_contents_inner">
                            <div class="col-12 col-md-6 recent_board">
                                <h3>콘텐츠원캠퍼스 &gt; 오픈특강</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=17&menuNo=500187" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach items="${openClassList}" var="result" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                    <c:if test="${status.index == 0}">

	                                    <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=500187&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
	                                        <h4 class="new"><span><c:out value="${result.prgNm}" escapeXml="false" /></span></h4>
	                                    </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0">
                                    <c:forEach items="${openClassList}" var="result" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
	                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
	                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <c:if test="${status.index > 0 }">
                                        <li>
                                            <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=500179&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
	                                            <c:out value="${result.prgNm}"/>
	                                            <p class="h_date4" style="margin:0;">${result.beginDt}</p>
                                            </a>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="col-12 col-md-6 recent_board">
                                <h3>콘텐츠원캠퍼스 &gt; 미디어존</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/bbs/B0000071/list.do?menuNo=500183" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach items="${B0000071List}" var="result" varStatus="status">
                                    <c:set var='content' value='${result.nttCn}'/>
                                    <c:set var='imgDesc' value='${result.imgDesc}'/>
                                    <%
                                    String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                    content = removeTag(content);
                                    if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
                                    %>
                                    <c:if test="${status.index == 0}">

                                    <a href="<c:out value="${result.option12 }"/>" target="_blank" title="새창열림" class="show-block recent_notice">
                                        <h4 class="new"><span><c:out value="${result.nttSj}" escapeXml="false" /></span></h4>
                                        <%-- <p class="h_date4">${result.ntceBgnde}</p> --%>
                                    </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0">
                                    <c:forEach items="${B0000071List}" var="result" varStatus="status">
                                        <c:set var='content' value='${result.nttCn}'/>
                                        <c:set var='imgDesc' value='${result.imgDesc}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";
                                        %>
                                        <c:if test="${status.index > 0 }">
                                        <li>
                                            <a href="<c:out value="${result.option12 }"/>" target="_blank" title="새창열림">
	                                            <c:out value="${result.nttSj}"/>
	                                            <p class="h_date4" style="margin:0;">${result.ntceBgnde}</p>
                                            </a>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
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