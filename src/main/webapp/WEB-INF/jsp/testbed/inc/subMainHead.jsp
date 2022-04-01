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
                <div class="col-12">
                    <!-- Util 영역 -->
                    <div class="col-12 tr fontsize0 header_util_wrap">
                        <div class="show vm header_util_text_con">
                        <span class="show vm fontsize14 header_util_item">
							<a href="#mainVisual" class="ico1" title="본문으로">본문으로</a>
						</span>
						<hr class="show vm header_util_line">
                        <sec:authorize ifAnyGranted="ROLE_USER">
                        	<c:if test="${paramVO.siteName eq 'edu' }">
                        		<c:set var="mypageNm" value="마이페이지" />
                        		<c:set var="mypageUrl" value="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" />
                        	</c:if>
                        	<c:if test="${paramVO.siteName eq 'testbed' }">
                        		<c:set var="mypageNm" value="마이페이지" />
                        		<c:set var="mypageUrl" value="/testbed/userMember/forUpdate.do?menuNo=700118" />
                        	</c:if>
                            <span class="show vm fontsize14 header_util_item"><span class="name_color"><c:out value="${userVO.userNm }"/></span>님 로그인중입니다.</span>
                            <hr class="show vm header_util_line">
                            <span class="show vm fontsize14 header_util_item"><a href="/${paramVO.siteName}/member/logout.do" class="ico4 logoutBtn" title="로그아웃">로그아웃</a></span>
                            <hr class="show vm header_util_line">
                            <span class="show vm fontsize14 header_util_item" style="position:relative;" id="myPageMenu">
                            	<a href="${mypageUrl}" class="ico5" title="${mypageNm}">
                            		<!-- <img src="/edu/images/edupro/icon_mypage.png" alt="마이페이지" title="마이페이지" style="position:absolute;top:0px;" /> -->
                            		<span>${mypageNm}</span>
                           		</a>
                                <!-- 레이어 팝업 -->
                                <div class="mypageSubLayer">
                                    <p style="text-align:left;line-height:24px;"><span style="color:#000;font-weight:600;">[온라인교육]</span><br>학습중인 과정 : <span id="studyCount">0</span>개</p>
                                </div>
                                <!-- //레이어 팝업 -->
                            </span>
                            <hr class="show vm header_util_line">
                            <script type="text/javascript">
                                var selectCount = false;
                                $(document).ready(function(){
                                    $('#myPageMenu').mouseover(function(){
                                        showMypageLayer('IN');
                                    });
                                    $('#myPageMenu').mouseout(function(){
                                        showMypageLayer('OUT');
                                    });
                                    $('.mypageSubLayer').mouseout(function(){
                                        showMypageLayer('OUT');
                                    });

                                    getMyStudyCount();
                                });

                                function showMypageLayer(type){
                                    if(type == "IN"){
                                        if(!selectCount){
                                            selectCount = true;
                                            getMyStudyCount();
                                        }
                                        $('.mypageSubLayer').show();
                                    }else{
                                        $('.mypageSubLayer').hide();
                                    }
                                }

                                function getMyStudyCount(){
                                    $.ajax({
                                        url : '/edu/onlineEdu/mylctrum/selectMyStudyCount.json',
                                        dataType : 'json',
                                        data : null,
                                        success : function(data) {
                                            $('.mypageSubLayer').find('#studyCount').html(data.studyCount);
                                        }
                                    });
                                }
                            </script>

                            <%--
                            인트라넷 미사용으로 주석 2016.04.29
                            <c:if test="${userVO.mentoYn eq 'Y' }">
                            <li><a href="https://dream.kocca.kr/sso_intranet.do?ssotoken=${userVO.ssotoken}" class="ico6" title="인트라넷">인트라넷</a></li>
                            </c:if>
                            --%>
                        </sec:authorize>
                        <sec:authorize ifNotGranted="ROLE_USER">
                            <c:url var="loginUrl" value="/${paramVO.siteName}/member/forLogin.do">
                                <c:param name="menuNo" value="500077" />
                                <c:param name="_targetUrl" value="${_targetUrl}" />
                            </c:url>
                            <c:choose>
                            	<c:when test="${paramVO.siteName eq 'testbed'}">
	                            <span class="show vm fontsize14 header_util_item"><a href="javascript:document.getElementById('loginForm').submit();" class="ico1" title="로그인">로그인</a></span>
	                            <form class="login_form" name="loginForm" id="loginForm" action="/edu/member/forLogin.do?menuNo=500077" method="post" style="display:none;">
									<input type="hidden" name="redirectUrl" value="/${paramVO.siteName}/main/main.do" />
								</form>
	                            <hr class="show vm header_util_line">
	                            <span class="show vm fontsize14 header_util_item"><a href="/${paramVO.siteName}/member/join01.do?menuNo=700121" class="ico2" title="회원가입">회원가입</a></span>
	                            <hr class="show vm header_util_line">
                            	</c:when>
                            	<c:otherwise>
	                            <span class="show vm fontsize14 header_util_item"><a href="/${paramVO.siteName}/member/forLogin.do?menuNo=500077" class="ico1" title="로그인">로그인</a></span>
	                            <hr class="show vm header_util_line">
	                            <span class="show vm fontsize14 header_util_item"><a href="/${paramVO.siteName}/member/join01.do?menuNo=500076" class="ico2" title="회원가입">회원가입</a></span>
	                            <hr class="show vm header_util_line">
                            	</c:otherwise>
                            </c:choose>
                        </sec:authorize>
                            <span class="show vm fontsize14 header_util_item"><a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵</a></span>
                            <!-- <span class="show vm fontsize14 header_util_item"><a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="고객센터">고객센터</a></span> -->
                            <!-- <span class="bgn"><a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵</a></span> -->
                        </div>
                        <div class="show vm header_language_select_con">
                        	<label for="header_language_select_mobile">언어선택</label>
                        	<select class="header_language_select mobile_only" id="header_language_select_mobile">
                        		<option value="/edumobile/main/main.do?siteName=testbed&menuNo=600125">KOR</option>
                        		<option value="/testbedeng/main/main.do">ENG</option>
                        	</select>
                        	<label for="header_language_select_id">언어선택</label>
                        	<select class="header_language_select web_only" id="header_language_select_id">
                        		<option value="/testbed/main/main.do">KOR</option>
                        		<option value="/testbedeng/main/main.do">ENG</option>
                        	</select>
                        	<input title="해당언어 페이지로 이동" type="button" value="이동" class="header_language_select_action"/>
                        </div>
                        <script type="text/javascript">
							$(".header_language_select_action").on("click", function(){
								function checkMobileSize() {
								    var x = $(window).width() + getScrollbarWidth();
								    if (x >= 992) {
								        return false;
								    } else {
								        return true;
								    }
								}
								var isMobileSize = checkMobileSize();
								
								if(isMobileSize){
									if(document.getElementById('header_language_select_mobile').value == "") return;
								    else window.location.href = document.getElementById('header_language_select_mobile').value;
								} else {
									if(document.getElementById('header_language_select_id').value == "" ) return;
								    else window.location.href = document.getElementById('header_language_select_id').value;
								}
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
							    <a href="https://www.youtube.com/channel/UCJ78W_fNjOW7A-lZ6uEClgA" target="_blank" title="새창열림">
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
                      		<a href="/edu/main/main.do" class="show"><img style="width: 120px;" src="/edu/new_image/main/logo.png" alt="KOCCA(Create NeWave) 에듀코카 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                      		&nbsp;&nbsp;
							<a href="/testbed/main/main.do" class="show"><img style="width: 100px;" src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                        </h1>
                        <!-- gnb -->
                        <c:set var="topCategories" value="${menuAll5['menu_0']}" />
                        <div class="over-md-hidden tr gnb_wrap">
                            <ul class="gnb_con tc">
                            <c:forEach var="x" begin="0" end="4">
                                <li>
                                    <c:if test="${x eq depth01}">
                                        <c:set var="1depth_title" value="${topCategories[x].menuNm}"/>
                                    </c:if>
                                    <a href="${topCategories[x].fullMenuLink}" ${x eq depth01 ? 'class="active"' : ''} ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''} >${topCategories[x].menuNm}</a>
                                    <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
                                    <c:set var="d02Categories" value="${menuAll5[d02MenuKey]}" />
                                    <c:if test="${fn:length(d02Categories)>0}">
                                        <c:set var="curD02" value="${curD02Categories[depth02]}" />
                                        <c:set var="curD" value="${curD02Categories[depth02]}" />
                                        <c:if test="${topCategories[x].menuNo == '500108'}">
											<c:set var="curD02Categories" value="${menuAll7[d01menuKey]}" />
                                         	<c:set var="d02MenuKey" value="menu_700000" />
	                                        <c:set var="d02Categories" value="${menuAll7[d02MenuKey]}" />
	                                        <c:set var="curD02" value="${curD02Categories[depth02]}" />
	                                        <c:set var="curD" value="${curD02Categories[depth02]}" />
                                        </c:if>
                                    <ul>
                                        <c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
                                        <li>
                                            <a href="${d02Categories[y].fullMenuLink}" ${y eq depth02 ? 'class="on"' : ''} ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a>
                                            <c:set var="d03menuKey" value="menu_${d02Categories[y].menuNo}" />
                                            <c:choose>
                                            	<c:when test="${topCategories[x].menuNo == '500108'}">
                                            		<c:set var="d03Categories" value="${menuAll7[d03menuKey]}" />
                                            	</c:when>
                                            	<c:otherwise>
                                            		<c:set var="d03Categories" value="${menuAll5[d03menuKey]}" />
                                            	</c:otherwise>
                                            </c:choose>
                                            <c:if test="${fn:length(d03Categories)>0}">
                                            	<c:if test="${d02Categories[y].menuNo eq '700001' || d02Categories[y].menuNo eq '700006' || d02Categories[y].menuNo eq '700005'}">
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
                                            </c:if>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                                </li>
                            </c:forEach>
                            </ul>
                            <div class="fr fontsize0 pt7 gnb_util_con">
                            	<%-- <input id="all_search_label" style="padding:0px;" type="image" alt="통합검색" src="/edu/images/bm/search_icon.png"/> --%>
                                <!-- 검색창 -->
                                <span class="show vm tl input_con">
                                <%--
                                <form name="frmSearch2" method="post" action="/edu/search/list.do?menuNo=500079" onsubmit="return search2(this);">
                                    <input type="text" class="q2" name="q" id="q2" placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">  --%>
                                    <!-- <label for="q2" id="all_search_label"></label> -->
                                    <%-- <input type="image" src="/edu/images/bm/search_icon.png" alt="검색 확인" class="all_search_image"> --%>
                                    <!-- <input type="image" src="/edu/images/common/schGlobalSetOk.gif" alt="검색 확인" class="p0 m0 vt" /> -->
                                <%-- </form> --%>
                                </span>
                                <!-- //검색창 -->
                                <%-- <hr class="show vm seperate_line"> --%>
                                <input class="gnb_menu" style="padding: 0px;" type="image" alt="GNB 메뉴" src="/edu/img/gnb_icon.png">
                                <input class="gnb_close" style="padding: 0px;" type="image" alt="GNB 메뉴 닫기" src="/edu/img/gnb_close.png">
                                <!-- <span class="show vm gnb_icon">
                                    <img class="gnb_menu" src="/edu/img/gnb_icon.png" alt="GNB 메뉴">
                                    <img class="gnb_close" src="/edu/img/gnb_close.png" alt="GNB 메뉴 닫기">
                                </span> -->
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
