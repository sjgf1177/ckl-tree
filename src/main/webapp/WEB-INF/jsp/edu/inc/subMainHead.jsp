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
<header>
	<div class="container h-100">
		<div class="header_util_wrap">
			<div class="show vm header_util_text_con">
				<span class="show vm fontsize14 header_util_item">
					<a href="#content_sub_wrap" class="ico3" title="본문으로">본문으로</a>
				</span>
            	<sec:authorize ifAnyGranted="ROLE_USER">
            		<c:if test="${paramVO.siteName eq 'edu' }">
            			<c:set var="mypageNm" value="마이페이지" />
            			<c:set var="mypageUrl" value="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" />
            		</c:if>
                    <c:if test="${paramVO.siteName eq 'testbed' }">
                    	<c:set var="mypageNm" value="마이페이지" />
                     	<c:set var="mypageUrl" value="/testbed/userMember/forUpdate.do?menuNo=700118" />
                    </c:if>
					<span class="show vm fontsize14 header_util_item">
	                	<span class="name_color"><c:out value="${userVO.userNm }"/></span>님 로그인중입니다.
	                </span>
                    <span class="show vm fontsize14 header_util_item">
                    	<a href="/${paramVO.siteName}/member/logout.do" class="ico4 logoutBtn" title="로그아웃">로그아웃</a>
                    </span>
                    <span class="show vm fontsize14 header_util_item" style="position:relative;" id="myPageMenu">
                    	<a href="${mypageUrl}" class="ico5" title="${mypageNm}">
                    		${mypageNm}
                   		</a>
                    </span>                
				</sec:authorize>
				<sec:authorize ifNotGranted="ROLE_USER">
	                <c:url var="loginUrl" value="/${paramVO.siteName}/member/forLogin.do">
	                    <c:param name="menuNo" value="500077" />
	                    <c:param name="_targetUrl" value="${_targetUrl}" />
	                </c:url>
                    <c:choose>
                    	<c:when test="${paramVO.siteName eq 'testbed'}">
                      		<span class="show vm fontsize14 header_util_item">
                      			<a href="javascript:document.getElementById('loginForm').submit();" class="ico1" title="로그인">로그인</a>
                      		</span>
                      		<form class="login_form" name="loginForm" id="loginForm" action="/edu/member/forLogin.do?menuNo=500077" method="post" style="display:none;">
								<input type="hidden" name="redirectUrl" value="/${paramVO.siteName}/main/main.do" />
							</form>
                      		<span class="show vm fontsize14 header_util_item">
                      			<a href="/${paramVO.siteName}/member/join01.do?menuNo=700121" class="ico2" title="회원가입">회원가입</a>
                      		</span>
                    	</c:when>
						<c:otherwise>
	                      	<span class="show vm fontsize14 header_util_item">
	                      		<a href="/${paramVO.siteName}/member/forLogin.do?menuNo=500077" class="ico1" title="로그인">로그인</a>
	                      	</span>
	                      	<span class="show vm fontsize14 header_util_item">
	                      		<a href="/${paramVO.siteName}/member/join01.do?menuNo=500076" class="ico2" title="회원가입">회원가입</a>
	                      	</span>
	                    </c:otherwise>
					</c:choose>
				</sec:authorize>
                <span class="show vm fontsize14 header_util_item">
                	<a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵</a>
                </span>
			</div>
			<div class="show vm header_util_icon_con">
            	<span class="show header_util_icon_item">
                	<a href="https://www.facebook.com/edukocca" target="_blank" title="새창열림">
                    	<img src="/edu/images/bm/facebook_icon.png" alt="페이스북 바로가기">
					</a>
				</span>
				<span class="show header_util_icon_item">
					<a href="https://twitter.com/edukocca" target="_blank" title="새창열림">
                    	<img src="/edu/images/bm/twitter_icon.png" alt="트위터 바로가기">
					</a>
				</span>
				<span class="show header_util_icon_item">
                	<a href="https://blog.naver.com/edukocca" target="_blank" title="새창열림">
						<img src="/edu/images/bm/blog_icon.png" alt="블로그 바로가기">
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
		<nav class="navbar navbar-expand-xl">
			<%
				String requestUri = request.getRequestURL().toString();
                if(requestUri.indexOf("edumobile") != -1)
                	pageContext.setAttribute("siteName", (requestUri.indexOf("testbed")!=-1?"testbed":"edu") ) ;
			%> 
            <c:choose>
            	<c:when test="${paramVO.siteName eq 'testbed' || siteName eq 'testbed'}">
                	<a class="navbar-brand" href="/testbed/main/main.do">
                    	<img src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)">
					</a>
				</c:when>
                <c:otherwise>
                	<a class="navbar-brand" href="/edu/main/main.do">
                    	<img src="/edu/new_image/main/logo.png" alt="콘텐츠인재캠퍼스 에듀코카 로고 - 콘텐츠인재캠퍼스 메인으로 이동">
					</a>
				</c:otherwise>
			</c:choose>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main_nav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="main_nav">
            	<c:set var="topCategories" value="${menuAll5['menu_0']}" />
				<ul class="navbar-nav">
		        	<c:forEach var="x" begin="0" end="4">
						<li>
                        	<c:if test="${x eq depth01}">
                            	<c:set var="1depth_title" value="${topCategories[x].menuNm}"/>
							</c:if>
                            <a href="${topCategories[x].fullMenuLink}" ${x eq depth01 ? 'class="active"' : ''} ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''} >
                            	${topCategories[x].menuNm}
							</a>
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
	                                    	<a href="${d02Categories[y].fullMenuLink}" ${y eq depth02 ? 'class="on"' : ''} ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>
	                                        	${d02Categories[y].menuNm}
											</a>
			                                <c:set var="d03menuKey" value="menu_${d02Categories[y].menuNo}" />
			                                <c:set var="d03Categories" value="${menuAll5[d03menuKey]}" />
	                                        <c:if test="${fn:length(d03Categories)>0}">
	                                        	<ul>
	                                            	<c:forEach var="z" begin="0"	end="${fn:length(d03Categories)-1}">
	                                                	<c:set var="clss2" value="${y eq depth02 && z eq depth03 ? 'on' : ''}" />
	                                                	<c:if test="${y eq depth02 && z eq depth03}">
	                                                    	<c:set var="curD" value="${d03Categories[z]}" />
	                                                    	<c:set var="curD03" value="${d03Categories[z]}" />
	                                                	</c:if>
	                                                	<li class="${clss2}">
	                                                    	<a href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>${d03Categories[z].menuNm}</a>
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
			</div>
			<div class="ml-auto searchCon" style="height:50px;">
				<%-- <input type="image" src="/edu/images/bm/search_icon.png" id="all_search_label" style="padding:0;" alt="통합검색"> --%>
				<!-- 검색창 -->
				<span class="show vm tl input_con">
<%-- 					<form name="frmSearch2" method="post" action="/edu/search/list.do?menuNo=500079" onsubmit="return search2(this);">
						<input type="text" class="q2" name="q" id="q2" placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">
						<input type="image" src="/edu/images/bm/search_icon.png" alt="검색 확인" class="all_search_image">
					</form> --%>
				</span>
				<!-- //검색창 -->
				<input type="image" src="/edu/img/gnb_icon.png" class="gnb_menu" alt="GNB 메뉴" style="padding:0;">
				<input type="image" src="/edu/img/gnb_close.png" class="gnb_close" alt="GNB 메뉴 닫기" style="padding:0;">
	        </div>
		</nav>
	</div>
</header>