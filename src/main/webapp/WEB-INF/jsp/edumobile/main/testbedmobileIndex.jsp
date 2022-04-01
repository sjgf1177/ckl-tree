<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.com.cmm.service.Globals"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@ page import="kr.co.unp.banner.vo.Banner"%>
<%@ page import="kr.co.unp.banner.service.BannerService"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var='siteName' value='${paramVO.siteName}'/>
<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);
	
	//메뉴설정 SiteMngService.PORTAL_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.EDUMOBILE_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);
	
	String menuNo = request.getParameter("menuNo");
	if("".equals(menuNo)) throw new Exception("menuNo 값이 없습니다.!");
	
	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
	String realTp = EgovProperties.getProperty("Globals.realMode");
	request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));
	
	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);
	
	String position = currentVo.getPosition();
	int depth01 = Integer.parseInt(position.substring(0,2)) -1;
	int depth02 = Integer.parseInt(position.substring(2,4)) -1;
	int depth03 = Integer.parseInt(position.substring(4,6)) -1;
	int depth04 = Integer.parseInt(position.substring(6,8)) -1;
	int depth05 = Integer.parseInt(position.substring(8,10)) -1;
	pageContext.setAttribute("depth01", depth01);
	pageContext.setAttribute("depth02", depth02);
	pageContext.setAttribute("depth03", depth03);
	pageContext.setAttribute("depth04", depth04);
	pageContext.setAttribute("depth05", depth05);
	/* UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

	String menuNo = request.getParameter("menuNo");
	if( StringUtils.hasText(menuNo) ) {

		org.springframework.context.ApplicationContext context =
		org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll6");
		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
		pageContext.setAttribute("currMenu", currentVo);

		String position = currentVo.getPosition();
		int depth01 = Integer.parseInt(position.substring(0,2)) -1;
		int depth02 = Integer.parseInt(position.substring(2,4)) -1;
		int depth03 = Integer.parseInt(position.substring(4,6)) -1;
		int depth04 = Integer.parseInt(position.substring(6,8)) -1;
		int depth05 = Integer.parseInt(position.substring(8,10)) -1;
		pageContext.setAttribute("depth01", depth01);
		pageContext.setAttribute("depth02", depth02);
		pageContext.setAttribute("depth03", depth03);
		pageContext.setAttribute("depth04", depth04);
		pageContext.setAttribute("depth05", depth05);
	} */
%>
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="<%= Globals.OS_TYPE %>" />
<c:set var="serverName" value="<%= request.getServerName() %>" />
<c:set var="list" value="${fn:contains(includePage, 'list')}" />
<c:set var="read" value="${fn:contains(includePage, 'read')}" />
<c:set var="reg" value="${fn:contains(includePage, 'reg')}" />
<c:set var="view" value="${fn:contains(includePage, 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="topCategories" value="${menuAll6['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="curD01" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll6[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll6[curD03menuKey]}" />
<c:set var="depthMenuNm" value="${pathData[0] }" />
<c:set var="title" value=""/>
<c:forEach var="x" begin="0" end="${fn:length(pathData)-1}">
	<c:choose>
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(목록) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(읽기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(쓰기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(수정) | ${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]}&lt;${title}"/></c:otherwise>
	</c:choose>
</c:forEach>

<!doctype html>
<html lang="ko">
<head>
	<c:set var="title" value="${title} 한국콘텐츠아카데미" />
	<title>${title}</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="title" content="${fn:replace(title, '"', '˝')}" />
	<meta name="type" content="website" />
	<jsp:include page="/WEB-INF/jsp/edumobile/inc/edumobileHead.jsp" flush="true" />
	<!-- 리뉴얼 추가 -->
<link rel="stylesheet" type="text/css" href="/edu/css/new/testbed_footer.css"/>
	<!-- 리뉴얼 추가 끝 -->
</head>
<c:set var="subNum" value="sub0${depth01+1 }" />
<c:if test="${depth01 > 5  }">
	<c:set var="subNum" value="sub01" />
</c:if>
<c:if test="${depth01 == 8  }">
	<c:set var="subNum" value="member" />
</c:if>
<body class="<c:out value="${subNum }" />">

<ul class="skip">
	<li><a href="#content" class="skipContents">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>
<div class="sub01Head wrapper sub_layout_page contents_view_page">

	<!-- //header --> 
		<div class="col-12 header_wrap">

    <!-- 하위스크롤 경우 // headerTopOn -->
    <div class="col-12 col-center mw-1200 over-visible header_inner">
        <div class="col-12 pr15 pl15">
            <div class="col-12 header_con">
                <div class="col-12 col-center mw-1200 over-visible">
                    <div class="col-12 pr15 pl15">

                        <!-- gnb 영역! -->
                        <div class="col-12 pt27 pb22 header_section mobile_header_section">
	                        <!-- 로그인 Util 영역 -->
	                        <div class="fl fontsize0 header_util_wrap">
							  <div class="show vm header_util_text_con">
							    <sec:authorize ifAnyGranted="ROLE_USER">
							      <%-- <c:if test="${paramVO.siteName eq 'edu' }">
							        <c:set var="mypageNm" value="나의강의실" />
							        <c:set var="mypageUrl" value="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" />
							      </c:if>
							      <c:if test="${paramVO.siteName eq 'testbed' }">
							        <c:set var="mypageNm" value="마이페이지" />
							        <c:set var="mypageUrl" value="/testbed/userMember/forUpdate.do?menuNo=700118" />
							      </c:if>
							      <span class="show vm fontsize14 header_util_item">
							        <span class="name_color">
							          <c:out value="${userVO.userNm }"/>
							        </span>님 로그인중입니다.
							      </span>
							      <hr class="show vm header_util_line"> --%>
							      <span class="show vm fontsize14 header_util_item">
							        <a href="/${paramVO.siteName}/member/logout.do?siteName=testbed" class="ico4 logoutBtn" title="로그아웃"><img src="/edu/images/bm/mobile_logout_btn.png" alt="로그아웃" title="로그아웃" />
							        </a>
							      </span>
							      <%-- <hr class="show vm header_util_line">
							      <span class="show vm fontsize14 header_util_item" style="position:relative;" id="myPageMenu">
							        <a href="${mypageUrl}" class="ico5" title="${mypageNm}">
							          <!-- <img src="/edu/images/edupro/icon_mypage.png" alt="마이페이지" title="마이페이지" style="position:absolute;top:0px;" /> -->
							          <span>${mypageNm}
							          </span>
							        </a>
							        <!-- 레이어 팝업 -->
							        <div class="mypageSubLayer">
							          <p style="text-align:left;line-height:24px;">
							            <span style="color:#000;font-weight:600;">[온라인교육]
							            </span>
							            <br>학습중인 과정 : 
							            <span id="studyCount">0
							            </span>개
							          </p>
							        </div>
							        <!-- //레이어 팝업 -->
							      </span>
							      <hr class="show vm header_util_line"> --%>
							      <script type="text/javascript">
							        var selectCount = false;
							        $(document).ready(function(){
							          $('#myPageMenu').mouseover(function(){
							            showMypageLayer('IN');
							          }
							                                    );
							          $('#myPageMenu').mouseout(function(){
							            showMypageLayer('OUT');
							          }
							                                   );
							          $('.mypageSubLayer').mouseout(function(){
							            showMypageLayer('OUT');
							          }
							                                       );
							          getMyStudyCount();
							        }
							                         );
							        function showMypageLayer(type){
							          if(type == "IN"){
							            if(!selectCount){
							              selectCount = true;
							              getMyStudyCount();
							            }
							            $('.mypageSubLayer').show();
							          }
							          else{
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
							          }
							                );
							        }
							      </script>
							      <%--
							           인트라넷 미사용으로 주석 2016.04.29
							           <c:if test="${userVO.mentoYn eq 'Y' }">
							      <li>
							        <a href="https://dream.kocca.kr/sso_intranet.do?ssotoken=${userVO.ssotoken}" class="ico6" title="인트라넷">인트라넷
							        </a>
							      </li>
							      </c:if>
							    --%>
							    </sec:authorize>
							    <sec:authorize ifNotGranted="ROLE_USER">
								    <c:url var="loginUrl" value="/${paramVO.siteName}/member/forLogin.do">
								      <c:param name="menuNo" value="600130" />
								      <c:param name="siteName" value="testbed" />
								      <c:param name="_targetUrl" value="${_targetUrl}" />
								    </c:url>
							    <span class="show vm fontsize14 header_util_item">
							    	<a href="javascript:document.getElementById('loginForm').submit();" class="ico1" title="로그인"><img src="/edu/images/bm/mobile_login_btn.png" alt="로그인" title="로그인" />
							    	</a>
							    </span>
	                            <form class="login_form" name="loginForm" id="loginForm" action="/edumobile/member/forLogin.do?menuNo=600130" method="post" style="display:none;">
								</form>
							    <hr class="show vm header_util_line">
							    <!-- <span class="show vm fontsize14 header_util_item"><a href="/edumobile/member/join01.do?menuNo=600129" class="ico2" title="회원가입">회원가입</a></span>
							<hr class="show vm header_util_line"> -->
							  </sec:authorize>
							  <!-- <span class="show vm fontsize14 header_util_item">
							    <a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵
							    </a>
							  </span>
							  <span class="bgn">
							    <a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵
							    </a>
							  </span> -->
							</div>
							<!-- <div class="show vm header_util_icon_con">
							  <span class="show header_util_icon_item">
							    <a href="https://www.facebook.com/edukocca" target="_blank">
							      <img src="/edu/images/bm/facebook_icon.png" alt="페이스북 바로가기">
							    </a>
							  </span>
							  <span class="show header_util_icon_item">
							    <a href="https://twitter.com/edukocca" target="_blank">
							      <img src="/edu/images/bm/twitter_icon.png" alt="트위터 바로가기">
							    </a>
							  </span>
							  <span class="show header_util_icon_item">
							    <a href="http://blog.naver.com/koccaedu" target="_blank">
							      <img src="/edu/images/bm/blog_icon.png" alt="블로그 바로가기">
							    </a>
							  </span>
							</div> -->
							</div> 
	                        <!-- //로그인Util 영역 -->
                        
                            <!-- 로고 -->
                            <!-- <h1 class="logo"><a href="/edu/main/main.do"><span class="hidden">KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)</span></a></h1> -->
                            <!-- <h1 class="show logo_con">
	                           	<a href="/edumobile/main/main.do?siteName=testbed" class="show"><img src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
	                        </h1> -->
	                         <h1 class="show logo_con">
								<a href="/edumobile/main/main.do" class="show"><img style="width: 120px;" src="/edu/new_image/w_logo.png" alt="KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
								&nbsp;&nbsp;
								<a href="/edumobile/main/main.do?siteName=testbed" class="show"><img style="width: 100px;" src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
							</h1>
                            <!-- gnb -->
                            <div class="over-md-hidden tr gnb_wrap">
	    							<c:set var="topCategories" value="${menuAll6['menu_0']}" />
								    <ul class="fontsize0 gnb_con">
									<c:set var="d02MenuNm" value="${pathData[0] }" />
									<c:forEach var="x" begin="0" end="4"> 
										<c:if test="${topCategories[x].menuNo eq curD01.menuNo}">
											<c:set var="depthMenuNm" value="${topCategories[x].menuNm}" />
										</c:if>
										
										<li class="tms${x+1} ${topCategories[x].menuNo eq curD01.menuNo ? 'on' : ''}"><a href="#">${topCategories[x].menuNm}</a>
											<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
											<c:set var="d02Categories" value="${menuAll6[d02MenuKey]}" />
											<c:set var="curD02" value="${curD02Categories[depth02]}" />
											<c:if test="${fn:length(d02Categories)>0}">
											<ul>
												<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
													<li ${d02Categories[y].menuNo eq curD02.menuNo ? 'class="on"' : ''}><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새 탭으로 열림"' : ''} tabindex="6">${d02Categories[y].menuNm}</a>
													<c:set var="d03MenuKey" value="menu_${d02Categories[y].menuNo}" />
													<c:set var="d03Categories" value="${menuAll6[d03MenuKey]}" />
													<c:set var="curD03" value="${curD03Categories[depth03]}" />
													<c:if test="${fn:length(d03Categories)>0}">
													<ul class="gnbD3">
														<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
														<c:if test="${d03Categories[z].menuNo ne '600033' && d03Categories[z].menuNo ne '600034'}">
															<li data-menuNo='${d03Categories[z].menuNo}' data-currMenuNo='${curD03.menuNo}'  ${d03Categories[z].menuNo eq curD03.menuNo ? 'class="on"' : ''}>
																<a href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"' : ''} tabindex="6">${d03Categories[z].menuNm}</a>
															</li>
														</c:if>
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
    									<hr class="show vm seperate_line">
    									<span class="show vm gnb_icon">
							              <button class="gnb_menu">전체메뉴</button>
							              <button class="gnb_close">전체메뉴 닫기</button>
							            </span>
			    					</div>
			    				</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 gnb_dim"></div>
            <div class="col-12 search_dim"></div>

            <!-- //gnb -->
        </div>
    </div>
    <div class="col-12 col-center mw-1200">
        <div class="col-12 pr15 pl15">
            <div class="col-12 tc visual_wrap">
                <div class="col-12 visual_util_wrap">
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
                <div class="col-12 tl tr-md visual_text_wrap">
                    
                    <c:choose>
				    	<c:when test='${fn:indexOf(pathData[0], "온라인교육") > -1 }'>
                    		<h2>국내 유일의 방송/문화/게임 <span class="point1">콘텐츠 전문 온라인 교육</span></h2>
                    		<style type="text/css">
	                    		.visual_wrap h2{margin-bottom:80px;}
	                    		.visual_text_wrap{text-align:center;}
	                    		.visual_util_wrap{display: none;}
	                    		@media all and (min-width:992px){
	                    			.visual_wrap h2 {margin-bottom:150px;}
	                    		}
                    		</style>
				    	</c:when>
				    	<c:when test='${fn:indexOf(pathData[0], "취업지원") > -1 }'>
                    		<h2>콘텐츠 전문분야로의 <span class="point1">취업역량 강화를<br/> 위한 맞춤형</span> 취업컨설팅</h2>
                    		<style type="text/css">
	                    		.visual_wrap h2{margin-bottom:80px;}
	                    		.visual_text_wrap{text-align:center;}
	                    		.visual_util_wrap{display: none;}
	                    		@media all and (min-width:992px){
	                    			.visual_wrap h2{margin-bottom:150px;}
	                    		}
                    		</style>
				    	</c:when>
				    	<c:when test='${fn:indexOf(pathData[0], "콘텐츠문화광장") > -1 }'>
				    		<h2>${pathData[0]}</h2>
                    		<p class="h_desc2" style="display:block;">최첨단 시설 구축으로 앞서가는 문화, 전문적인 문화를선도하는 콘텐츠 문화광장</p>
                    		<style type="text/css">
                    			.h_desc2{display:none;}
                    		</style>
				    	</c:when>
				    	<c:when test='${fn:indexOf(pathData[0], "HOME") > -1 }'>
				    		<h2>${pathData[0]}</h2>
                    		<p class="h_desc2" style="display:block;">융합형 창의인재 양성의 중심허브, 콘텐츠인재캠퍼스</p>
				    	</c:when>
				    	<c:when test='${fn:indexOf(pathData[0], "교육지원사업") > -1 }'>
				    		<h2>${pathData[0]}</h2>
                    		<p class="h_desc2" style="display:block;">콘텐츠 분야 전문인력 양성을 위한 현장중심 프로그램 지원</p>
				    	</c:when>
				    	<c:otherwise>
				    		<h2>${pathData[0]}</h2>
                    		<p class="h_desc2">콘텐츠 분야 잠재인력과 현업인들을 위한 역량강화 프로그램</p>
				    	</c:otherwise>
				    </c:choose>
                    
                </div>
            </div>
        </div>
    </div>
    <c:choose>
    	<c:when test='${fn:indexOf(pathData[0], "HOME") > -1 }'>
    		<div class="sub_visual"></div>
    	</c:when>
    	<c:when test='${fn:indexOf(pathData[0], "오프라인교육") > -1 }'>
    		<div class="sub_visual img_001"></div>
    	</c:when>
    	<c:when test='${fn:indexOf(pathData[0], "온라인교육") > -1 }'>
    		<div class="sub_visual img_003"></div>
    	</c:when>
    	<c:when test='${fn:indexOf(pathData[0], "교육지원사업") > -1 }'>
    		<div class="sub_visual img_002"></div>
    	</c:when>
    	<c:when test='${fn:indexOf(pathData[0], "취업지원") > -1 }'>
    		<div class="sub_visual img_004"></div>
   		</c:when>
    	<c:when test='${fn:indexOf(pathData[0], "콘텐츠문화광장") > -1 }'>
    		<div class="sub_visual img_005"></div>
    	</c:when>
    	<c:otherwise>
			<div class="sub_visual"></div>    	
    	</c:otherwise>
    </c:choose>
    
</div>
	<!-- //header -->

	<!-- <div class="svisualSet"></div> -->
		<c:set var="h4MenuNm" value="${curD02.menuNm}" />
		<c:if test="${fn:length(curD03Categories)>0}">
			<c:set var="h4MenuNm" value="${curD03.menuNm}" />
		</c:if>
		<!--container-->
		<div class="col-12 sub_contents_wrap">
            <div class="col-12 col-center mw-1200 over-visible">
                <div class="col-12 pr15 pl15">
                    <div class="lnb_wrap <c:if test='${fn:indexOf(pathData[0], "온라인교육") > -1 }'>online</c:if>">
                        <div class="lnb_header">
                        <h3 class="show-tablecell vm tc">${pathData[0]}</h3>
                        </div>
                        <c:if test="${fn:length(curD02Categories)>0}">
                        <c:choose>
                        		<c:when test="${siteName eq 'testbed'}">
									<c:set var="topCategoriesTestbed" value="${menuAll7['menu_0']}" />
									<c:set var="d01Category" value="${topCategoriesTestbed[depth01]}" />
									<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
									<c:set var="curD02Categories" value="${menuAll7[d01menuKey]}" />
									<c:set var="d02MenuKey" value="menu_700000" />
									<c:set var="d02Categories" value="${menuAll7[d02MenuKey]}" />
									<c:set var="curD02" value="${curD02Categories[depth02]}" />
									<c:set var="curD" value="${curD02Categories[depth02]}" />
	                        		<ul class="lnb_con">
			                        <c:forEach var="x" begin="0" end="${fn:length(curD02Categories)-1}">
			                        	<c:set var="clss" value="${x eq depth02 ? 'on' : ''}" />
			                            <c:set var="lnbClss" value="1" />
			                            <c:set var="d03menuKey" value="menu_${curD02Categories[x].menuNo}" />
			                            <c:set var="d03Categories" value="${menuAll7[d03menuKey]}" /> 
			                            <c:if test="${fn:length(d03Categories)>0}">
			                                <c:set var="lnbClss" value="2" />
			                            </c:if>
			                            <li class="lnb_${lnbClss} ${clss}">
			                            	<a href="${curD02Categories[x].fullMenuLink}" ${curD02Categories[x].menuPopupYn eq 'Y'?'target="_blank"  title="새 탭으로 열림"':''}><span>${curD02Categories[x].menuNm}</span></a>
			                            	<c:if test="${fn:length(d03Categories)>0}">
				                                <ul>
				                                <c:forEach var="y" begin="0"	end="${fn:length(d03Categories)-1}">
				                                    <c:set var="clss2" value="${x eq depth02 && y eq depth03 ? 'active' : ''}" />
				                                    <c:if test="${x eq depth02 && y eq depth03}">
				                                        <c:set var="curD" value="${d03Categories[y]}" />
				                                        <c:set var="curD03" value="${d03Categories[y]}" />
				                                    </c:if>
				                                    <c:if test="${d03Categories[y].menuNo ne '500124' && d03Categories[y].menuNo ne '500125' && d03Categories[y].menuNo ne '500126' && d03Categories[y].menuNo ne '500128'}">
				
				                                    <li class="${clss2}">
				                                    <a	href="${d03Categories[y].fullMenuLink}" ${d03Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"':''}><span>${d03Categories[y].menuNm}</span></a>
				                                    </li>
				                                    </c:if>
				                                </c:forEach>
				                                </ul>
				                            </c:if>
			                            </li>
			                        </c:forEach>
		                        	</ul>
                        		</c:when>
                        	<c:otherwise>
	                        	<ul class="lnb_con">
		                        <c:set var="curD02" value="${curD02Categories[depth02]}" />
		                        <c:set var="curD" value="${curD02Categories[depth02]}" />
		                        <c:forEach var="x" begin="0" end="${fn:length(curD02Categories)-1}">
		                            <c:set var="clss" value="${x eq depth02 ? 'on' : ''}" />
		                            <c:set var="lnbClss" value="1" />
		                            <c:set var="d03menuKey" value="menu_${curD02Categories[x].menuNo}" />
		                            <c:set var="d03Categories" value="${menuAll5[d03menuKey]}" />
		                            <c:set var="d02Url" value="${fn:replace(curD02Categories[x].fullMenuLink, '/edu/', '/testbed/')}" />
		                            <c:if test="${fn:length(d03Categories)>0}">
		                                <c:set var="lnbClss" value="2" />
		                            </c:if>
		                            <li class="lnb_${lnbClss} ${clss}">
		                            	<a href="${d02Url}" ${curD02Categories[x].menuPopupYn eq 'Y'?'target="_blank"  title="새 탭으로 열림"':''}><span>${curD02Categories[x].menuNm}</span></a>
		                            <c:if test="${fn:length(d03Categories)>0}">
		                                <ul>
		                                <c:forEach var="y" begin="0"	end="${fn:length(d03Categories)-1}">
		                                    <c:set var="clss2" value="${x eq depth02 && y eq depth03 ? 'active' : ''}" />
		                                    <c:if test="${x eq depth02 && y eq depth03}">
		                                        <c:set var="curD" value="${d03Categories[y]}" />
		                                        <c:set var="curD03" value="${d03Categories[y]}" />
		                                    </c:if>
		                                    <c:if test="${d03Categories[y].menuNo ne '500124' && d03Categories[y].menuNo ne '500125' && d03Categories[y].menuNo ne '500126' && d03Categories[y].menuNo ne '500128'}">
		
		                                    <li class="${clss2}">
		                                    <c:set var="d03Url" value="${fn:replace(d03Categories[y].fullMenuLink, '/edu/', '/testbed/')}" />
		                                    <a	href="${d03Url}" ${d03Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"':''}><span>${d03Categories[y].menuNm}</span></a>
		                                    </li>
		                                    </c:if>
		                                </c:forEach>
		                                </ul>
		                            </c:if>
		                            </li>
		                        </c:forEach>
		                        </ul>
                        	</c:otherwise>
                        </c:choose>
                        </c:if>

                        <!-- snsSet 백업 참조 -->
                        <!-- //snsSet -->

                    </div>

                    <!-- sub 컨텐츠 -->
                    <div id="subContainer" class="col-12 col-md-0 fn-md over-hidden sub_contents printPage">
                        <div class="col-12 sub_section">
                            <div class="over-hidden sub_contents_header">
                                <h4 class="fl">${h4MenuNm}</h4>

                                <div class="fr linemap_wrap">
                                    <ul class="col-12 linemap_con">
                                        <li><a href="/edu/main/main.do"><span></span></a></li>
                                        <c:set var="size" value="${fn:length(pathData)}" />
                                        <c:if test="${size > 0}">
                                            <c:choose>
                                                <c:when test="${param.menuNo eq '500007'}"><li><a href="javascript:void(0);"><span>새소식</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500019'}"><li><a href="javascript:void(0);"><span>현장교육</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500026'}"><li><a href="javascript:void(0);"><span>온라인교육</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500034'}"><li><a href="javascript:void(0);"><span>창의인재동반</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500046'}"><li><a href="javascript:void(0);"><span>취업정보</span></a></li></c:when>
                                                <c:otherwise>
                                                    <c:forEach var="x" begin="0" end="${size-1}" varStatus="status">
                                                        <li><a href="javascript:void(0);"><span><c:out value="${pathData[x]}"/></span></a></li>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                            <!-- 서브 컨텐츠 바디 -->
                            <div class="sub_contents_body">
                                <!--content-->
                                <c:choose>
                                    <c:when test="${not empty cvCon}">
                                        ${cvCon}
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="_includePage" value="" />
                                        <c:choose>
                                            <c:when test="${not empty param.incPage}"><c:set var="_includePage" value="${incPage}" /></c:when>
                                            <c:when test="${empty includePage}"><c:set var="_includePage" value="${currMenu.contentsPath}" /></c:when>
                                            <c:otherwise><c:set var="_includePage" value="${includePage}" /></c:otherwise>
                                        </c:choose>
                                        <c:catch var ="catchException">
                                            <jsp:include page="/WEB-INF/jsp${_includePage}" flush="true">
                                                <jsp:param name="menuNm" value="${currMenu.menuNm }" />
                                            </jsp:include>
                                        </c:catch>
                                    </c:otherwise>
                                </c:choose>
                                <!--//content-->
                            </div>
                            <!-- 서브 컨텐츠 바디 끝-->
                        </div>
                    </div>
                    <!-- sub 컨텐츠 -->

                </div>
            </div>
		</div>
    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/edumobile/inc/testbedmobileFooter.jsp" flush="true" />
    <!-- //footer -->
</div>
<!-- //wrap -->


<!--[if lte IE 7]>
<script type="text/javascript">
//<![CDATA[
	$('*').each(function(index) {
		if ($(this).css("overflow")=="hidden"){
			$(this).css("zoom",1);
		}
		if ($(this).css("display")=="inline-block"){
			$(this).css("display",'inline');
			$(this).css("zoom",1);
		}
	});
//]]>
</script> 
<![endif]-->

</body>
</html> 