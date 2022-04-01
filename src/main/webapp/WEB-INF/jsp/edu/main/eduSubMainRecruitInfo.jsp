<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%@include file="/WEB-INF/jsp/edu/inc/incMainFn.jsp"%>

<body>
<script type="text/javascript" src="/js/slider.js"></script>
<div class="wrapper sub_layout_main">
    <!-- header -->
    <div class="col-12">

        <!--GNBhead-->
        <jsp:include page="/WEB-INF/jsp/edu/inc/subMainHead.jsp" flush="true" />
        <!--//GNBhead-->

        <div class="col-12 col-center visual_inner">
            <div class="col-12 col-center mw-1200">
                <div class="col-12 pr15 pl15">
                    <div class="col-12 tc visual_wrap">
                        <div class="col-12 visual_util_wrap">
                            <div class="fl fontsize0 linemap_wrap">
                                <ul class="col-12 linemap_con">
                                    <li><a href="/edu/main/main.do"><span style="clip: rect(1px, 1px, 1px, 1px); position:relative;">Home</span></a></li>
                                    <li><a href="javascript:void(0)" tabindex="-1"><span>취업정보</span></a></li>
                                </ul>
                            </div>
                            <ul class="tr sharing_util_icon">
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
                            </ul>
                        </div>
                        <div class="col-12 visual_text_wrap">
                            <h2>
                                콘텐츠 전문분야로의 <span class="point1">취업역량 강화를<br/>
                                위한 맞춤형</span> 취업컨설팅
                            </h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sub_visual img_004"></div>
        <%-- 
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="col-12 sub_section offline_edu_section white">
                    <h3>취업정보 핫이슈</h3>
                    <hr class="h_line3">
                    <div class="col-12 sub_main_body" style="background-color:#ffffff; padding:30px 0;">

                    <!--콘텐츠 취창업 지원실-->
                    <div class="section01">
                    <div class="sm1RollingSet">
                    <!-- popupzone -->
                    <div class="popupzone">
                    <div class="ctrl">
                    <button type="button" class="popupzone_play"><span>알림판 재생</span></button>
                    <button type="button" class="popupzone_stop"><span>알림판 정지</span></button>
                    <button type="button" class="popupzone_pre"><span>알림판 이전보기</span></button>
                    <button type="button" class="popupzone_next"><span>알림판 다음보기</span></button>
                    </div>
                    <div class="area">
                    <ul>
                    <c:forEach items="${popupList}" var="result" varStatus="status">
                        <li>
                        <a href="#pop_list_${status.count}" class="num">
                        <span class="r"><span class="t">${status.count}번 팝업 보기</span></span>
                        </a>
                        <a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank"</c:if> class="view" id="pop_list_${status.count}" title="새창열림">
                        <img class="thumbLg" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&amp;fileSn=<c:out value="${result.file1Sn}"/>" title="<c:out value="${result.ntcnNm}"/>" alt="<c:out value="${result.ntcnNm}"/>" />
                        </a>
                        </li>
                    </c:forEach>
                    </ul>
                    </div>
                    <script type="text/javascript">
                    //<![CDATA[
                    jQuery(function(){
                    jQuery(".popupzone").slideCtrl({
                    //photo_list : jQuery('.popupzone>.area li'),
                    photo_list_left : jQuery('.popupzone_pre'),
                    photo_list_right : jQuery('.popupzone_next'),
                    photo_list_play : jQuery(".popupzone_play"),
                    photo_list_stop : jQuery(".popupzone_stop"),
                    FXconfig:true,
                    d_time : 3000
                    });
                    });
                    //]]>
                    </script>
                    </div>
                    <!-- //popupzone -->

                    </div>
                    </div>
                    <!--//콘텐츠 취창업 지원실-->

                    <!--콘텐츠의 미래를 만나다-->
                    <div class="section02">
                    <div class="ingJobSet">
                    <!-- ingJob -->
                    <h2>콘텐츠의 미래를 만나다</h2>
                    <div class="ingJob">
                    <ul>
                    <c:forEach items="${B0000020List}" var="result" varStatus="status">
                        <c:if test="${status.count == 3}"><c:set var="clss" value="class=mr0"/></c:if>
                        <li ${clss}>
                        <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500011" >
                        <c:choose>
                            <c:when test="${not empty result.fileSn}">
                                <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileFieldNm=main_image" alt="" />
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                        <span class="title"><c:out value="${result.nttSj}" escapeXml="flase"/></span>
                        </a>
                        <span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
                        </li>
                    </c:forEach>
                    </ul>
                    <a href="/edu/bbs/B0000020/list.do?menuNo=500011" class="more"><span class="hidden">콘텐츠의 미래를 만나다 더보기</span></a>
                    </div>
                    </div>
                    <div class="ingJob2">
                    <h2>발로뛰는 취 &#8226; 창업지원실</h2>
                    <div class="boxs">
                    <a href="/edu/bbs/<c:out value="${B0000047List[0].bbsId}"/>/view.do?nttId=<c:out value="${B0000047List[0].nttId}"/>&amp;menuNo=500095" >
                    <c:choose>
                        <c:when test="${not empty B0000047List[0].fileSn}">
                            <img src="/cmm/fms/getImage.do?atchFileId=${B0000047List[0].atchFileId}&amp;fileSn=${B0000047List[0].fileSn}" alt="" />
                        </c:when>
                        <c:otherwise>
                        </c:otherwise>
                    </c:choose>
                    <span class="title"><c:out value="${B0000047List[0].nttSj}" /></span>
                    </a>
                    <span class="date"><c:out value="${B0000047List[0].frstRegisterPnttm}"/></span>
                    </div>
                    <a href="/edu/bbs/B0000047/list.do?menuNo=500095" class="more"><span class="hidden">발로뛰는 취 &#8226; 창업지원실더보기</span></a>

                    </div>
                    </div>
                    </div>
                    <!--//콘텐츠의 미래를 만나다-->
                    
                </div>
            </div>
        </div> 
        --%>
    </div>
    <!-- //header -->

    <!-- contents -->
    <!-- sub_layout -->
    <div class="col-12 sub_contents_wrap">
    	<div class="col-12 sub_main_contents_con sub_main_recruit_service_con">
    		<div class="col-12 col-center mw-1200 over-visible">
	            <div class="col-12 pr15 pl15">
	            	<div class="col-12 sub_contents">
                        <div class="col-12 sub_section sub_main_recruit_suppport_service_section">
                            <div class="col-12 sub_main_contents_header">
                                <h3>취업지원 서비스</h3>
                                <hr class="h_line3">
                            </div>
                            <div class="col-12 recruit_support_card_wrap">
                                <div class="col-12 calc_wrap30">
                                    <div class="col-12 col-sm-4 recruit_support_card_list">
                                        <div class="col-12 recruit_support_card">
                                            <div class="col-12 img_box">
                                                <div class="hidden_text_wrap">
                                                    <div class="hidden_text_con">
                                                        <div class="hidden_text">
                                                            <h4>
                                                                1:1 취업컨설팅
                                                            </h4>
                                                            <p class="h_desc4">
                                                                취업상담 부터 이력서클리닉 까지<br>
                                                                성공적인 취업으로 이끌어 드립니다.
                                                            </p>
                                                            <a class="quick_btn" href="/edu/main/contents.do?menuNo=500048">
                                                                바로가기
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <img src="/edu/images/bm/recruit_support_card_img_000.jpg" alt="1:1 취업컨설팅">
                                            </div>
                                            <div class="col-12 text_box">
                                                <h4>1:1 취업컨설팅</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-4 recruit_support_card_list">
                                        <div class="col-12 recruit_support_card">
                                            <div class="col-12 img_box">
                                                <div class="hidden_text_wrap">
                                                    <div class="hidden_text_con">
                                                        <div class="hidden_text">
                                                            <h4>
                                                                온라인 모의면접
                                                            </h4>
                                                            <p class="h_desc4">
                                                                모의면접을 통해  면접 스킬을<br>
                                                                컨설팅 해드립니다.
                                                            </p>
                                                          <!--   <a class="quick_btn" href="/edu/main/contents.do?menuNo=500136">
                                                                바로가기
                                                            </a> -->
                                                        </div>
                                                    </div>
                                                </div>
                                                <img src="/edu/images/bm/recruit_support_card_img_001.jpg" alt="온라인 모의면접">
                                            </div>
                                            <div class="col-12 text_box">
                                                <h4>온라인 모의면접</h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-4 recruit_support_card_list">
                                        <div class="col-12 recruit_support_card">
                                            <div class="col-12 img_box">
                                                <div class="hidden_text_wrap">
                                                    <div class="hidden_text_con">
                                                        <div class="hidden_text">
                                                            <h4>
                                                                콘텐츠미니잡페어
                                                            </h4>
                                                            <p class="h_desc4">
                                                            콘텐츠 산업분야의 우수기업과 <br>
							구직자 간의 만남의 장! <br>
							콘텐츠미니잡페어를<br>
							2017년 총 2회 진행 완료하였습니다. 
							                                                            
                           <!-- 콘텐츠 산업분야의 우수기업과<br>
                                                                취업을 희망하는구직자간의<br>
                                                                만남의 장을  만들어 드립니다. -->
                                                            </p>
                                                            <!-- 
                                                            <a class="quick_btn" href="/edu/main/contents.do?menuNo=500129">
                                                                바로가기
                                                            </a>
                                                             -->
                                                        </div>
                                                    </div>
                                                </div>
                                                <img src="/edu/images/bm/recruit_support_card_img_002.jpg" alt="콘텐츠미니잡페어">
                                            </div>
                                            <div class="col-12 text_box">
                                                <h4>콘텐츠미니잡페어</h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                    </div>
	            	
	            	<!-- 
	                <div class="lnb_wrap">
	                    <div class="lnb_header">
	                        <h3 class="show-tablecell vm tc">
	                            인재캠퍼스
	                        </h3>
	                    </div>
	                    <ul class="lnb_con">
	                        <li class="lnb_1"><a href="javascript:void(0)"><span>콘텐츠인재캠퍼스</span></a>
	                            <ul class="lnb_1_1depth">
	                            <li><a href="javascript:void(0)"><span>콘텐츠인재캠퍼스</span></a>
	                            </li>
	                            <li><a href="javascript:void(0)"><span>공지사항</span></a></li>
	                            <li><a href="javascript:void(0)"><span>문의하기</span></a></li>
	                            <li><a href="javascript:void(0)"><span>인사말</span></a></li>
	                            </ul>
	                        </li>
	                        <li class="lnb_2"><a href="javascript:void(0)"><span>공지사항</span></a></li>
	                        <li class="lnb_3"><a href="javascript:void(0)"><span>문의하기</span></a></li>
	                        <li class="lnb_4 active"><a href="javascript:void(0)"><span>인사말</span></a></li>
	                    </ul>
	                </div>
	                 -->
	                <!-- //sub_layout -->
	            </div>
	        </div>
    	</div>
    	
    	<div class="col-12 sub_reruit_information_wrap">
            <div class="col-12 col-center mw-1200">
                <div class="col-12 pr15 pl15">
                    <div class="col-12 sub_contents">
                        <div class="col-12 sub_section">
                            <div class="col-12 sub_main_contents_header">
                                <h3>채용정보</h3>
                                <hr class="h_line3">
                            </div>
                            <div class="col-12 process_more_btn_con">
                                <a href="/edu/job/empmnPblanc/list.do?menuNo=500054" class="process_more_btn">
                                    더보기
                                </a>
                            </div>
                            <div class="col-12 sub_main_contents_body">
                                <div class="sub_reruit_information_card_list_wrap">
                                    <div class="col-12 calc_wrap18">
                                    
                                    	
                                    	<c:forEach items="${empmnLogoList}" var="result" varStatus="status">
		                                    <a class="col-12 col-sm-6 col-md-3 show-block sub_reruit_information_card_list" 
												href="/edu/job/empmnPblanc/view.do?pblancSn=<c:out value="${result.pblancSn}"/>&amp;menuNo=500054">
	                                            <div class="sub_reruit_information_card_con">
	                                                <div class="col-12 img_box">
	                                                	<div class="img_box_inner">
		                                                    <c:choose>
		                                                    <c:when test="${not empty result.fileSn}">
				                                                <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" alt="<c:out value="${result.ntcnNm}"/>" /></p>
				                                            </c:when>
				                                            <c:otherwise>
				                                                <img src="/edu/images/common/company_noimg.jpg" alt="한국콘텐츠아카데미 CI"></p>
				                                            </c:otherwise>
		                                                    </c:choose>
	                                                    </div>
	                                                </div>
	                                                <div class="text_box">
	                                                    <h4>
	                                                        <c:out value="${result.entrprsNm}"/>
	                                                    </h4>
	                                                    <hr class="h_line4">
	                                                    <p class="h_desc4">
	                                                        <c:out value="${result.pblancNm}" escapeXml="flase"/>
	                                                    </p>
	                                                    <p class="h_data4">
	                                                        채용기간<br>
	                                                        <span><c:out value="${result.beginDt}"/>~<c:out value="${result.rceptComptAt eq 'Y' or empty result.endDt ? ' 채용시' : result.endDt}"/></span>
	                                                    </p>
	                                                </div>
	                                            </div>
	                                        </a>
		                                    
		                                </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
          	
          	
          	
          	
      	<div class="col-12 sub_contents_wrap">
            <div class="col-12 sub_main_contents_con">
                <div class="col-12 sub_section sub_main_contents_banner white">
                    <div class="col-12 col-center mw-1200 h-100">
                        <div class="col-12 show-table h-100 pr15 pl15">
                            <div class="show-tablecell vm tc pt33">
                                <p class="sub_title">
                                    구직자 사전등록을 하세요.<br>
                                    여러분의미래가 달라집니다.
                                </p>
                                <p class="sub_title_desc">
                                    워크넷 채용정보를 보실 수 있습니다
                                </p>
                                <a class="view_btn" href="/edu/job/empmnInfo/list.do?menuNo=500092">VIEW</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
          	
          	
          	<div class="col-12 sub_main_contents_con sum_main_recruit_magazine_con">
            <div class="col-12 col-center mw-1200">
                <div class="col-12 pr15 pl15">
                    <div class="col-12 sub_contents">
                        <div class="col-12 sub_section sub_main_recruit_magazine_section">
                            <div class="col-12 sub_main_contents_header">
                                <h3>취업매거진</h3>
                                <hr class="h_line3">
                            </div>
                            <ul class="col-12 tab_style_2_con">
                                <li class="col-6">
                                    <a href="javascript:void(0)">분야별 전문가 인터뷰</a>
                                    <div class="tab_child no_header">
                                    	<div class="process_more_btn_con">
                                            <a href="/edu/bbs/B0000020/list.do?menuNo=500011" class="process_more_btn">
                                                더보기
                                            </a>
                                        </div>
                                        <div class="col-12 calc_wrap32">
                                            <div class="col-12 process_card_wrap">
	                                            <c:forEach items="${B0000020List}" var="result" varStatus="status">
	                                            <div class="col-12 col-md-4 process_card_con">
		                                            <div class="col-12 process_card_list">
	                                                     <div class="col-12 img_box">
	                                                         <!-- <img src="/edu/images/bm/best_company_img_000.jpg" alt="김보민 담당 인터뷰"> -->
	                                                         <c:choose>
									                            <c:when test="${not empty result.fileSn}">
									                                <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileFieldNm=main_image" alt="" />
									                            </c:when>
									                            <c:otherwise>
									                            </c:otherwise>
									                        </c:choose>
	                                                         
	                                                     </div>
	                                                     <div class="col-12 text_box">
	                                                         <h4><c:out value="${result.nttSj}" escapeXml="flase"/></h4>
	                                                         <hr class="h_line4"/>
	                                                         <p class="h_desc4">
	                                                             <c:set var='content' value='${result.nttCn}'/>
													            <%
																    String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
																    content = removeTag(content);
																    if( content.length() >= 300 ) content = content.substring(0,300);
																%>
	                                                            <%=content%>
	                                                         </p>
	                                                         <div class="h_more_btn_4_con">
	                                                             <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500011" class="h_more_btn_4">자세히보기</a>
	                                                         </div>
	                                                     </div>
	                                                 </div>
                                                 </div>
	                                                 
	                                             </c:forEach>
	                                            
                                            </div>
                                        </div>
                                        
                                        
                                    </div>
                                    
                                </li>
                                <li class="col-6">
                                    <a href="javascript:void(0)" class="active">취업행사 및 교육후기</a>
                                    <div class="tab_child no_header">
                                        <div class="process_more_btn_con">
                                            <a href="/edu/bbs/B0000047/list.do?menuNo=500095" class="process_more_btn">
                                                더보기
                                            </a>
                                        </div>
                                        <div class="col-12 calc_wrap32">
                                            <div class="col-12 process_card_wrap">
                                            
                                            	<c:forEach items="${B0000047List}" var="result" varStatus="status">
	                                            <div class="col-12 col-md-4 process_card_con">
		                                            <div class="col-12 process_card_list">
	                                                     <div class="col-12 img_box">
	                                                         <!-- <img src="/edu/images/bm/best_company_img_000.jpg" alt="김보민 담당 인터뷰"> -->
	                                                         <c:choose>
									                            <c:when test="${not empty result.fileSn}">
									                                <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileFieldNm=main_image" alt="" />
									                            </c:when>
									                            <c:otherwise>
									                            </c:otherwise>
									                        </c:choose>
	                                                         
	                                                     </div>
	                                                     <div class="col-12 text_box">
	                                                         <h4><c:out value="${result.nttSj}" escapeXml="flase"/></h4>
	                                                         <hr class="h_line4"/>
	                                                         <p class="h_desc4">
	                                                         	<c:set var='content' value='${result.nttCn}'/>
													            <%
																    String content = (String)pageContext.getAttribute("content") != null ? (String)pageContext.getAttribute("content") : "" ;
																    content = removeTag(content);
																    if( content.length() >= 300 ) content = content.substring(0,300);
																%>
	                                                            <%=content%>
	                                                         </p>
	                                                         <div class="h_more_btn_4_con">
	                                                             <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500011" class="h_more_btn_4">자세히보기</a>
	                                                         </div>
	                                                     </div>
	                                                 </div>
                                                 </div>
	                                                 <%-- <c:if test="${status.count == 3}"><c:set var="clss" value="class=mr0"/></c:if>
							                         	 <li ${clss}>
							                        <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500011" >
							                        <c:choose>
							                            <c:when test="${not empty result.fileSn}">
							                                <img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileFieldNm=main_image" alt="" />
							                            </c:when>
							                            <c:otherwise>
							                            </c:otherwise>
							                        </c:choose>
							                        <span class="title"><c:out value="${result.nttSj}" escapeXml="flase"/></span>
							                        </a>
							                        <span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
							                        </li> --%>
	                                                 
	                                             </c:forEach>
                                            
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    	
    	
    </div>
    <!-- //contents -->

    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/edu/inc/eduFooter.jsp" flush="true" />
    <!-- //footer -->
</div>
</body>