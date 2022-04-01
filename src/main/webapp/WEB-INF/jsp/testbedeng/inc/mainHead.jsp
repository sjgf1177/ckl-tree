<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.mpm.vo.MenuManageVO"%>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[

function search2(form){
	if(!form.q.value){
		alert("검색어를 입력하세요.");
		$("#q2")[0].focus();
		return false;
	}
	return true;
}

function logoutSSO() {
	$.get("/${paramVO.siteName}/member/logout.json",function(data) {
		var retUrl = "${ssoDomain}/sso/member/logoutSSO.do?service=${paramVO.siteName}";
		//alert(retUrl);
		location.href= retUrl;
	},"json");
	return false;
}

$(function() {

	$(".logoutBtn").click(function() {
		logoutSSO();
		return false;
     });

});
//]]>
</script>

    <!-- 하위스크롤 경우 // headerTopOn -->
<div class="col-12 col-center mw-1200 over-visible header_inner">
    <div class="col-12 pr15 pl15">
        <div class="col-12 header_con">
            <div class="col-12 col-center mw-1200 over-visible">
                <div class="col-12 pr15 pl15">
                    <!-- Util 영역 -->
                    <div class="col-12 tr-md fontsize0 header_util_wrap">
                        <div class="show vm header_language_select_con">
                        	<label for="header_language_select_mobile">언어선택</label>
                        	<select class="header_language_select mobile_only" id="header_language_select_mobile">
                        		<option value="/testbedeng/main/main.do">ENG</option>
                       			<option value="/edumobile/main/main.do?siteName=testbed&menuNo=600125">KOR</option>
                        	</select>
                        	<label for="header_language_select_web">언어선택</label>
                        	<select class="header_language_select web_only" id="header_language_select_web">
                        		<option value="/testbedeng/main/main.do">ENG</option>
                       			<option value="/testbed/main/main.do?siteName=testbed">KOR</option>
                        	</select>
                        </div>
                        <script type="text/javascript">
							$(".header_language_select").on("change", function(){
							    if( this.value == "" ) return;
							    else window.location.href = this.value;
							})
						</script>
                        <div class="show vm header_util_icon_con">
                            <span class="show header_util_icon_item">
                                <a href="https://www.facebook.com/edukocca" target="_blank" title="새창열림">
                                    <img src="/edu/img/facebook_icon.png" alt="페이스북 바로가기">
                                </a>
                            </span>
                            <span class="show header_util_icon_item">
                                <a href="https://twitter.com/edukocca" target="_blank" title="새창열림">
                                    <img src="/edu/img/twitter_icon.png" alt="트위터 바로가기">
                                </a>
                            </span>
                            <span class="show header_util_icon_item">
                                <a href="https://blog.naver.com/edukocca" target="_blank" title="새창열림">
                                    <img src="/edu/img/blog_icon.png" alt="블로그 바로가기">
                                </a>
                            </span>
                            <span class="show header_util_icon_item">
							    <a href="http://www.youtube.com/user/KoreanContent " target="_blank" title="새창열림">
							       	<img src="/edu/new_image/youtube_icon.png" alt="유튜브 바로가기">
							    </a>
							</span>
							<span class="show header_util_icon_item">
							    <a href="https://www.instagram.com/edu.kocca/" target="_blank" title="새창열림">
							       	<img src="/edu/new_image/instargram_icon.png" alt="인스타그램 바로가기">
							    </a>
							</span>
                        </div>
                    </div>
                    <!-- gnb 영역! -->
                    <div class="col-12 pt27 pb22 header_section">
                        <!-- 로고 -->
                        <!-- <h1 class="logo"><a href="/edu/main/main.do"><span class="hidden">KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)</span></a></h1> -->
                        <h1 class="show logo_con">
                        	<%
                        	String requestUri = request.getRequestURL().toString();
                        	if(requestUri.indexOf("edumobile") != -1)
                        		pageContext.setAttribute("siteName", (requestUri.indexOf("testbed")!=-1?"testbed":"edu") ) ;
                        	%> 
                            <%-- <c:choose>
                            	<c:when test="${paramVO.siteName eq 'testbed' || siteName eq 'testbed' || paramVO.siteName eq 'testbedeng' || siteName eq 'testbedeng' }">
                                	<a href="/testbedeng/main/main.do" class="show"><img src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                                </c:when>
                           		<c:otherwise>
                                	<a href="/edu/main/main.do" class="show"><img src="/edu/images/bm/logo.png" alt="KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                           		</c:otherwise>
                           	</c:choose> --%>
                           	<a href="/edumobile/main/main.do" class="show mobile_only"><img style="width: 120px;" src="/edu/new_image/w_logo.png" alt="KOCCA(Create NeWave) 에듀코카 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                           	<a href="/edu/main/main.do" class="show web_only"><img style="width: 120px;" src="/edu/new_image/w_logo.png" alt="KOCCA(Create NeWave) 에듀코카 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
							&nbsp;&nbsp;
							<a href="/testbedeng/main/main.do" class="show"><img style="width: 100px;" src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                        </h1>
                        <!-- gnb -->
                        <c:set var="topCategories" value="${menuAll8['menu_0']}" />
                        <div class="over-md-hidden tr gnb_wrap">
                            <ul class="gnb_con">
                            <c:forEach var="x" begin="0" end="3">
                                <li>
                                    <c:if test="${x eq depth01}">
                                        <c:set var="1depth_title" value="${topCategories[x].menuNm}"/>
                                    </c:if>
                                    <a href="${topCategories[x].fullMenuLink}" ${x eq depth01 ? 'class="active"' : ''} ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''} >${topCategories[x].menuNm}</a>
                                    <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
                                    <c:set var="d02Categories" value="${menuAll8[d02MenuKey]}" />
                                    <c:if test="${fn:length(d02Categories)>0}">
                                        <c:set var="curD02" value="${curD02Categories[depth02]}" />
                                        <c:set var="curD" value="${curD02Categories[depth02]}" />
                                    <ul>
                                        <c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
                                        <li>
                                            <a href="${d02Categories[y].fullMenuLink}" ${y eq depth02 ? 'class="on"' : ''} ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a>


                                            <c:set var="d03menuKey" value="menu_${d02Categories[y].menuNo}" />
                                            <c:set var="d03Categories" value="${menuAll8[d03menuKey]}" />
                                            <c:if test="${fn:length(d03Categories)>0}">
                                            <ul>
                                            <c:forEach var="z" begin="0"	end="${fn:length(d03Categories)-1}">
                                                <c:set var="clss2" value="${y eq depth02 && z eq depth03 ? 'on' : ''}" />
                                                <c:if test="${y eq depth02 && z eq depth03}">
                                                    <c:set var="curD" value="${d03Categories[z]}" />
                                                    <c:set var="curD03" value="${d03Categories[z]}" />
                                                </c:if>
                                                <li class="${clss2}">
                                                    <a	href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>${d03Categories[z].menuNm}</a>
                                                </li>
                                            </c:forEach>
                                            </ul>
                                            </c:if>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                                </li>
                            </c:forEach>
                            </ul>
                            <div class="fr fontsize0 pt7 gnb_util_con">
                                <!-- 검색창 -->
                                <span class="show vm tl input_con">
                                <%-- 
                                <form name="frmSearch2" method="post" action="/edu/search/list.do?menuNo=500079" onsubmit="return search2(this);">
                                    <input type="text" class="q2" name="q" id="q2" placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">
                                    <label for="q2" id="all_search_label"></label>
                                    <input type="image" src="/edu/images/bm/search_icon.png" alt="검색 확인" class="all_search_image"> --%>
                                    <!-- <input type="image" src="/edu/images/common/schGlobalSetOk.gif" alt="검색 확인" class="p0 m0 vt" /> -->
                                <%-- </form> --%>
                                </span>
                                <!-- //검색창 -->
                                <%-- <hr class="show vm seperate_line"> --%>
                                <span class="show vm gnb_icon">
                                    <img class="gnb_menu" src="/edu/img/gnb_icon.png" alt="GNB 메뉴">
                                    <img class="gnb_close" src="/edu/img/gnb_close.png" alt="GNB 메뉴 닫기">
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 gnb_dim"></div>
        <div class="col-12 search_dim"></div>
    </div>
</div>