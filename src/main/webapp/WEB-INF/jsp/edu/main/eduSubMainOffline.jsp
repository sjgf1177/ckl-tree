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
	 <div class="col-12">
        <div class="col-12 col-center visual_inner print_out">
            <div class="col-12 col-center mw-1200">
                <div class="col-12 pr15 pl15">
                    <div class="col-12 tc visual_wrap">
                        <div class="col-12 visual_util_wrap">
                            <div class="fl fontsize0 linemap_wrap">
                                <ul class="col-12 linemap_con">
                                    <li><a href="/edu/main/main.do"><span style="clip: rect(1px, 1px, 1px, 1px); position:relative;">Home</span></a></li>
                                    <li>
                                    	<a href="javascript:void(0)" tabindex="-1">
                                    		<span>오프라인교육</span>
                                    	</a>
                                    </li>
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
                            	<li>
                            	<a href="#self" Class="ico02 CopyClipOpen"><span Class="hidden">URL 복사하기</span></a>
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
                           		<li>
                            		<a href="/edu/forPrint.jsp" class="ico03" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기"><span class="hidden">인쇄하기</span></a>
                            	</li>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%-- <div class="col-12 col-center mw-1200 print_view">
            <div class="col-12 pr15 pl15">
                <div class="col-12 sub_section offline_edu_section white">
                    <h3>오프라인교육 핫이슈</h3>
                    <hr class="h_line3">
                    <div class="col-12 sub_main_body">
                    <c:forEach var="result" items="${issueList}" varStatus="status">
                    	<c:set var="result" value="${issueList[0]}"/>
                        <c:set var='content' value='${result.content}'/>
                        <c:set var='imgDesc' value='${result.imgDesc}'/>
                        <c:set var='prgCl' value='${result.prgCl}'/>
                        <c:set var='pathImg' value='/cmm/fms/getImage.do?${result.pathImg}'/>
                        <c:if test="${result.pathImg eq 'default'}">
                            <c:set var='pathImg' value='/edu/images/bm/campus_card_img_000.jpg'/>
                        </c:if>
                            <%
                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                            content = removeTag(content);
                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                            %>
                            <!-- ${result.title} -->
                        <c:if test="${status.index == 0}">
                        <div class="col-12 col-md-6 tc fontsize0 focus_card_con">
                            <div class="show fn tl focus_card_list">
                                <div class="col-12 focus_card_img_box">
                                    <img src="${pathImg}" alt="${result.title}">
                                </div>
                                <div class="col-12 focus_text_box">
                                <h4>[${result.prgClNm}]</h4>

                                <p class="h_subtitle4">
                                    <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%=menuNo%>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                        ${result.title}
                                    </a>
                                </p>
                                <p class="h_desc4">
                                    <%=content%>
                                </p>
                                <p class="h_date4">
                                    ${result.registDate}
                                </p>
                                <p class="more_btn_con">
                                    <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%=menuNo%>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show more_btn">
                                        상세보기
                                    </a>
                                </p>
                            </div>
                            </div>
                        </div>
                        </c:if>
                        </c:forEach>
                        <div class="col-12 col-md-6 focus_prev_list_con">
                            <c:forEach var="result" items="${issueList}" varStatus="status" begin="1" end="3">
                                <c:set var='content' value='${result.content}'/>
                                <c:set var='imgDesc' value='${result.imgDesc}'/>
                                <c:set var='prgCl' value='${result.prgCl}'/>
                                <c:set var='pathImg' value='/cmm/fms/getImage.do?${result.pathImg}'/>
                                <c:if test="${result.pathImg eq 'default'}">
                                    <c:set var='pathImg' value='/edu/images/bm/campus_card_img_000.jpg'/>
                                </c:if>
                                    <%
                                    String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                    content = removeTag(content);
                                    if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                    int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                    %>
                            <div class="col-12 focus_prev_list">
                                <div class="img_box first">
                                    <img src="${pathImg}" alt="${result.nttSj}">
                                </div>
                                <div class="text_box">
                                    <p class="h_subtitle4">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%=menuNo%>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                            [ ${result.prgClNm} ] ${result.title}
                                        </a>
                                    </p>
                                    <p class="h_desc4">
                                        <%=content%>
                                    </p>
                                    <p class="h_date4">
                                        ${result.registDate}
                                    </p>
                                    <p class="more_btn_con">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%=menuNo%>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show more_btn">
                                            상세보기
                                        </a>
                                    </p>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div> --%>
    
    <!-- //header -->

    <!-- contents -->
    <!-- sub_layout -->
    <div id="content_sub_wrap" class="col-12 sub_contents_wrap">
        <div class="col-12 col-center mw-1200 over-visible">
            <div class="col-12 pr15 pl15">
                <!-- <div class="lnb_wrap">
                    <div class="lnb_header">
                        <h3 class="show-tablecell vm tc">
                            인재캠퍼스
                        </h3>
                    </div>
                    <ul class="lnb_con">
                        <li class="lnb_1"><a href="javascript:void(0)"><span>콘텐츠인재캠퍼스</span></a></li>
                        <li class="lnb_2"><a href="javascript:void(0)"><span>공지사항</span></a></li>
                        <li class="lnb_3"><a href="javascript:void(0)"><span>문의하기</span></a></li>
                        <li class="lnb_4 active"><a href="javascript:void(0)"><span>인사말</span></a></li>
                    </ul>
                </div> -->
                <!-- //sub_layout -->
                <div class="col-12 col-md-0 fn-md over-hidden fontsize0 sub_contents">
                    <div class="col-12 sub_section sub_main_contents_section" style="padding-top:10px; padding-bottom:10px; border:none;">
                        <div class="col-12 sub_main_contents_inner">
                            <div class="col-12 col-md-6 recent_board">
                                <h3>콘텐츠 인사이트</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=13&menuNo=500025" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${insightList}" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                        int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                        %>
                                    <c:if test="${status.index == 0}">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
                                            <h4><span><c:out value="${result.prgNm}" /></span></h4>
                                            <c:choose>
                                                <c:when test="${result.progrsSttus == 'W'}"><p class="h_button_con wait"></c:when>
                                                <c:when test="${result.progrsSttus == 'P'}"><p class="h_button_con go"></c:when>
                                                <c:when test="${result.progrsSttus == 'FP'}"><p class="h_button_con go"></c:when>
                                                <c:when test="${result.progrsSttus == 'F'}"><p class="h_button_con end"></c:when>
                                            </c:choose>
                                                <a href="javascript:void(0)" class="h_btn go">진행중</a>
                                                <a href="javascript:void(0)" class="h_btn end">마감</a>
                                            </p>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 black">
                                    <c:forEach var="result" items="${insightList}" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
                                        <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                        <c:set var='prgCl' value='${result.prgCl}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                            %>
                                        <c:if test="${status.index > 0}">
                                        <c:choose>
                                            <c:when test="${result.progrsSttus == 'W'}"><li class="list_style_0_wait"></c:when>
                                            <c:when test="${result.progrsSttus == 'P'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'FP'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'F'}"><li class="list_style_0_end"></c:when>
                                        </c:choose>
                                            <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                                <c:out value="${result.prgNm}" />
                                                <p class="list_style_0_date">[신청기간] ${result.beginDt} ~ ${result.endDt}</p>
                                            </a>
                                            <span class="list_style_0_end_text">마감</span>
                                            <span class="list_style_0_ing_text">진행중</span>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                    <%--
                                    <li>
                                        <a href="./sub_offline_10_view.html">
                                            2016 콘텐츠 인사이트(Content Insight) 1차
                                            <p class="list_style_0_date">신청기간 : 2017.06.01 18:00 ~ 2017.06.01 18:00</p>
                                        </a>
                                    </li>
                                    <li class="list_style_0_end">
                                        <a href="./sub_offline_10_view.html">
                                            2015 콘텐츠 인사이트 (해외편)
                                            <p class="list_style_0_date">신청기간 : 2017.06.01 18:00 ~ 2017.06.01 18:00</p>
                                        </a>
                                    </li>
                                    --%>
                                </ul>
                            </div>
                            <div class="col-12 col-md-6 recent_board">
                                <h3>콘텐츠 스텝업</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=12&menuNo=500216" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${stepList}" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                        int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                        %>
                                    <c:if test="${status.index == 0}">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
                                            <h4><span><c:out value="${result.prgNm}" /></span></h4>
                                                <c:choose>
                                                    <c:when test="${result.progrsSttus == 'W'}"><p class="h_button_con wait"></c:when>
                                                    <c:when test="${result.progrsSttus == 'P'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'FP'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'F'}"><p class="h_button_con end"></c:when>
                                                </c:choose>
                                                <a href="javascript:void(0)" class="h_btn go">진행중</a>
                                                <a href="javascript:void(0)" class="h_btn end">마감</a>
                                            </p>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 black">
                                    <c:forEach var="result" items="${stepList}" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
                                        <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                        <c:set var='prgCl' value='${result.prgCl}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                            %>
                                        <c:if test="${status.index > 0}">
                                        <c:choose>
                                            <c:when test="${result.progrsSttus == 'W'}"><li class="list_style_0_wait"></c:when>
                                            <c:when test="${result.progrsSttus == 'P'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'FP'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'F'}"><li class="list_style_0_end"></c:when>
                                        </c:choose>
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                            <c:out value="${result.prgNm}" />
                                            <p class="list_style_0_date">[신청기간] ${result.beginDt} ~ ${result.endDt}</p>
                                        </a>
                                        <span class="list_style_0_end_text">마감</span>
                                        <span class="list_style_0_ing_text">진행중</span>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
					<div class="col-12 sub_section sub_main_contents_section" style="padding-top:10px; padding-bottom:10px; border:none;">
                        <div class="col-12 sub_main_contents_inner">
                            <div class="col-12 col-md-6 recent_board">
                                <h3>콘텐츠 플러스</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=10&menuNo=500217" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${plusList}" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                        int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                        %>
                                    <c:if test="${status.index == 0}">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
                                            <h4><span><c:out value="${result.prgNm}" /></span></h4>
                                                <c:choose>
                                                    <c:when test="${result.progrsSttus == 'W'}"><p class="h_button_con wait"></c:when>
                                                    <c:when test="${result.progrsSttus == 'P'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'FP'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'F'}"><p class="h_button_con end"></c:when>
                                                </c:choose>
                                                <a href="javascript:void(0)" class="h_btn go">진행중</a>
                                                <a href="javascript:void(0)" class="h_btn end">마감</a>
                                            </p>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 black">
                                    <c:forEach var="result" items="${plusList}" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
                                        <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                        <c:set var='prgCl' value='${result.prgCl}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                            %>
                                        <c:if test="${status.index > 0}">
                                        <c:choose>
                                            <c:when test="${result.progrsSttus == 'W'}"><li class="list_style_0_wait"></c:when>
                                            <c:when test="${result.progrsSttus == 'P'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'FP'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'F'}"><li class="list_style_0_end"></c:when>
                                        </c:choose>
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                            <c:out value="${result.prgNm}" />
                                            <p class="list_style_0_date">[신청기간] ${result.beginDt} ~ ${result.endDt}</p>
                                        </a>
                                        <span class="list_style_0_end_text">마감</span>
                                        <span class="list_style_0_ing_text">진행중</span>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                            <%-- <div class="col-12 col-md-6 recent_board">
                                <h3>콘텐츠 밸류업</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=15&menuNo=500105" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${valueUpList}" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                        int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                        %>
                                    <c:if test="${status.index == 0}">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
                                            <h4><span><c:out value="${result.prgNm}" /></span></h4>
                                                <c:choose>
                                                    <c:when test="${result.progrsSttus == 'W'}"><p class="h_button_con wait"></c:when>
                                                    <c:when test="${result.progrsSttus == 'P'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'FP'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'F'}"><p class="h_button_con end"></c:when>
                                                </c:choose>
                                                <a href="javascript:void(0)" class="h_btn go">진행중</a>
                                                <a href="javascript:void(0)" class="h_btn end">마감</a>
                                            </p>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 black">
                                    <c:forEach var="result" items="${valueUpList}" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
                                        <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                        <c:set var='prgCl' value='${result.prgCl}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                            %>
                                        <c:if test="${status.index > 0}">
                                        <c:choose>
                                            <c:when test="${result.progrsSttus == 'W'}"><li class="list_style_0_wait"></c:when>
                                            <c:when test="${result.progrsSttus == 'P'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'FP'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'F'}"><li class="list_style_0_end"></c:when>
                                        </c:choose>
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                            <c:out value="${result.prgNm}" />
                                            <p class="list_style_0_date">[신청기간] ${result.beginDt} ~ ${result.endDt}</p>
                                        </a>
                                        <span class="list_style_0_end_text">마감</span>
                                        <span class="list_style_0_ing_text">진행중</span>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div> --%>
                        </div>
                    </div>
                    <div class="col-12 sub_section sub_main_contents_section" style="padding-top:10px; padding-bottom:10px; border:none;">
                        <div class="col-12 sub_main_contents_inner">
                            <div class="col-12 col-md-6 recent_board">
                                <h3>게임인재원</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=16&menuNo=500218" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${gameSchoolList}" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                        int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                        %>
                                    <c:if test="${status.index == 0}">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
                                            <h4><span><c:out value="${result.prgNm}" /></span></h4>
                                                <c:choose>
                                                    <c:when test="${result.progrsSttus == 'W'}"><p class="h_button_con wait"></c:when>
                                                    <c:when test="${result.progrsSttus == 'P'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'FP'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'F'}"><p class="h_button_con end"></c:when>
                                                </c:choose>
                                                <a href="javascript:void(0)" class="h_btn go">진행중</a>
                                                <a href="javascript:void(0)" class="h_btn end">마감</a>
                                            </p>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 black">
                                    <c:forEach var="result" items="${gameSchoolList}" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
                                        <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                        <c:set var='prgCl' value='${result.prgCl}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                            %>
                                        <c:if test="${status.index > 0}">
                                        <c:choose>
                                            <c:when test="${result.progrsSttus == 'W'}"><li class="list_style_0_wait"></c:when>
                                            <c:when test="${result.progrsSttus == 'P'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'FP'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'F'}"><li class="list_style_0_end"></c:when>
                                        </c:choose>
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                            <c:out value="${result.prgNm}" />
                                            <p class="list_style_0_date">[신청기간] ${result.beginDt} ~ ${result.endDt}</p>
                                        </a>
                                        <span class="list_style_0_end_text">마감</span>
                                        <span class="list_style_0_ing_text">진행중</span>
                                        </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="col-12 col-md-6 recent_board">
                                <h3>게임 리터러시(이해) 교육</h3>
                                <p class="tr more_btn_con">
                                    <a href="/edu/progrm/master/list.do?prgSe=01&prgCl=14&menuNo=500219" class="show more_btn">더보기</a>
                                </p>
                                <hr class="h_line3">
                                <c:forEach var="result" items="${gameLiteracyList}" varStatus="status">
                                    <c:set var='content' value='${result.prgNm}'/>
                                    <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                    <c:set var='prgCl' value='${result.prgCl}'/>
                                        <%
                                        String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                        content = removeTag(content);
                                        if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                        int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                        %>
                                    <c:if test="${status.index == 0}">
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}" class="show-block recent_notice">
                                            <h4><span><c:out value="${result.prgNm}" /></span></h4>
                                                <c:choose>
                                                    <c:when test="${result.progrsSttus == 'W'}"><p class="h_button_con wait"></c:when>
                                                    <c:when test="${result.progrsSttus == 'P'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'FP'}"><p class="h_button_con go"></c:when>
                                                    <c:when test="${result.progrsSttus == 'F'}"><p class="h_button_con end"></c:when>
                                                </c:choose>
                                                <a href="javascript:void(0)" class="h_btn go">진행중</a>
                                                <a href="javascript:void(0)" class="h_btn end">마감</a>
                                            </p>
                                        </a>
                                    </c:if>
                                </c:forEach>
                                <ul class="list_style_0 black">
                                    <c:forEach var="result" items="${gameLiteracyList}" varStatus="status">
                                        <c:set var='content' value='${result.prgNm}'/>
                                        <c:set var='imgDesc' value='${result.imgDescCn}'/>
                                        <c:set var='prgCl' value='${result.prgCl}'/>
                                            <%
                                            String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
                                            content = removeTag(content);
                                            if ( content.length() <= 5 ) content += (String)pageContext.getAttribute("imgDesc") != null ? (String)pageContext.getAttribute("imgDesc") : "";

                                            int menuNo = menuNoPrg( Integer.parseInt((String)pageContext.getAttribute("prgCl")) );
                                            %>
                                        <c:if test="${status.index > 0}">
                                        <c:choose>
                                            <c:when test="${result.progrsSttus == 'W'}"><li class="list_style_0_wait"></c:when>
                                            <c:when test="${result.progrsSttus == 'P'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'FP'}"><li class=""></c:when>
                                            <c:when test="${result.progrsSttus == 'F'}"><li class="list_style_0_end"></c:when>
                                        </c:choose>
                                        <a href="/edu/progrm/master/view.do?prgSn=${result.prgSn}&menuNo=<%= menuNo %>&prgSe=${result.prgSe}&prgCl=${result.prgCl}">
                                            <c:out value="${result.prgNm}" />
                                            <p class="list_style_0_date">[신청기간] ${result.beginDt} ~ ${result.endDt}</p>
                                        </a>
                                        <span class="list_style_0_end_text">마감</span>
                                        <span class="list_style_0_ing_text">진행중</span>
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
    </div>

    <!-- //contents -->
	
	<div class="print_out">
    <!--footer-->
    <jsp:include page="/WEB-INF/jsp/edu/inc/eduFooter.jsp" flush="true" />
    <!-- //footer -->
    </div>
</div>
</body>