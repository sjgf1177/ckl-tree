<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.mpm.vo.MenuManageVO"%>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
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
	}
%>
<c:set var="userVO" value="${userVO }" scope="request" />


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>콘텐츠문화광장 메인</title>
<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css"/> -->
<link rel="stylesheet" type="text/css" href="/edumobile/css/animate.min.css" />
<link rel="stylesheet" type="text/css" href="/edumobile/css/common.css"  />
<link rel="stylesheet" type="text/css" href="/edumobile/css/layout.css"  />
<link rel="stylesheet" type="text/css" href="/edumobile/css/main.css"  />
<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub.css"  />
<link rel="stylesheet" href="/edu/js/bm/swiper/swiper.min.css"/>
<link rel="stylesheet" type="text/css" href="/edu/css/bm/wevenResponsive.css"  />
<link rel="stylesheet" type="text/css" href="/edu/css/common.css"  />
<link rel="stylesheet" type="text/css" href="/edu/css/bm/common.css"  />
<link rel="stylesheet" type="text/css" href="/edu/css/bm/main.css"  />
<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub_layout.css"  />
<link rel="stylesheet" type="text/css" href="/edu/css/bm/sub_page.css"  />

<!-- 리뉴얼 추가 -->
<link rel="stylesheet" type="text/css" href="/edu/css/new/testbed_footer.css"/>
<!-- 리뉴얼 추가 끝 -->

<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript"  src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
<!-- <script type="text/javascript" src="/edumobile/js/common.js"></script> -->
<script type="text/javascript"> subMenuOpenIng=true; </script>
<!-- <script type="text/javascript" src="/js/bootstrap/bootstrap.min.js"></script> -->

<script type="text/javascript" src="/js/jquery.sticky.js"></script>
<script type="text/javascript" src="/js/jquery.scrollTo.min.js"></script>
<script type="text/javascript" src="/js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="/js/jquery.appear.js"></script>
<script type="text/javascript" src="/js/modernizr.min.js"></script>
<script type="text/javascript" src="/edumobile/js/main.js"></script>
<script type="text/javascript" src="/edumobile/js/common.js"></script>
<script type="text/javascript" src="/edumobile/js/sub.js"></script>
<script type="text/javascript" src="/edumobile/js/bm/bm.js"></script>
<script type="text/javascript" src="/edumobile/js/bm/sub.js"></script>
<script type="text/javascript" src="/edumobile/js/bm/swiper/swiper.min.js"></script>
<script type="text/javascript" src="/edumobile/js/bm/rollingEvent.js"></script>
<script type="text/javascript" src="/edumobile/js/bm/main.js"></script>
</head>

<body>
<div class="wrapper sub_multi_content_testbed_main contents_view_page">
    <!-- header -->
    <div class="col-12 header_wrap">
       	<!--GNBhead-->

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
							<div class="show vm header_language_select_con">
								<label for="header_language_select_mobile">언어선택</label>
	                        	<select class="header_language_select mobile_only" id="header_language_select_mobile">
	                        		<option value="/edumobile/main/main.do?siteName=testbed&menuNo=600125">KOR</option>
	                        		<option value="/testbedeng/main/main.do">ENG</option>
	                        	</select>
	                        	<label for="header_language_select_web">언어선택</label>
	                        	<select class="header_language_select web_only" id="header_language_select_web">
	                        		<option value="/testbed/main/main.do?siteName=testbed">KOR</option>
	                        		<option value="/testbedeng/main/main.do">ENG</option>
	                        	</select>
	                        </div>
	                        <script type="text/javascript">
								$(".header_language_select").on("change", function(){
								    if( this.value == "" ) return;
								    else window.location.href = this.value;
								})
							</script>
	                        <!-- //로그인Util 영역 -->
                        <!-- 로고 -->
                        <!-- <h1 class="logo"><a href="/edu/main/main.do"><span class="hidden">KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)</span></a></h1> -->
                       <!--  <h1 class="show logo_con">
                           	<a href="/edumobile/main/main.do?siteName=testbed" class="show"><img src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA 콘텐츠문화광장 Multi Content Testbed 로고"></a>
                        </h1> -->
                        <h1 class="show logo_con">
								<a href="/edumobile/main/main.do" class="show"><img style="width: 120px;" src="/edu/new_image/w_logo.png" alt="KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
								&nbsp;&nbsp;
								<a href="/edumobile/main/main.do?siteName=testbed" class="show"><img style="width: 100px;" src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
						</h1>
                        <!-- gnb -->
                        <c:set var="topCategories" value="${menuAll5['menu_0']}" />

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
													<li ${d02Categories[y].menuNo eq curD02.menuNo ? 'class="on"' : ''}><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"' : ''} tabindex="4">${d02Categories[y].menuNm}</a>
													<c:set var="d03MenuKey" value="menu_${d02Categories[y].menuNo}" />
													<c:set var="d03Categories" value="${menuAll6[d03MenuKey]}" />
													<c:set var="curD03" value="${curD03Categories[depth03]}" />
													<c:if test="${fn:length(d03Categories)>0}">
													<ul class="gnbD3">
														<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
														<c:if test="${d03Categories[z].menuNo ne '600033' && d03Categories[z].menuNo ne '600034'}">
															<li data-menuNo='${d03Categories[z].menuNo}' data-currMenuNo='${curD03.menuNo}'  ${d03Categories[z].menuNo eq curD03.menuNo ? 'class="on"' : ''}>
																<a href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"' : ''} tabindex="4">${d03Categories[z].menuNm}</a>
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
    </div>
</div>

        <!--//GNBhead-->

        <div class="swiper-container" id="mainVisual">
            <div class="swiper-wrapper">

            <c:forEach var="mainConcertImg" items="${mainConcertImgList}" varStatus="status">
		        <c:set value="${fileMap[mainConcertImg.atchFileId] }" var="fileList" />
				<c:set var="file" value=""/>
				<c:forEach var="files" items="${fileList}">
					<c:if test="${files.fileFieldName eq 'mainImg'}">
						<c:set  var="file" value="${files}"/>
					</c:if>
				</c:forEach>

				<c:if test="${not empty file }">
                    <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        ${mainConcertImg.concertTitle}
                                   </h2>
                                   <p class="h_desc2">${mainConcertImg.concertStartDate} ~ ${mainConcertImg.concertEndDate}</p>
                                   <div class="more_btn_con">
                                        <a href="/${paramVO.siteName}/concert/info/view.do?concertId=${mainConcertImg.concertId}&menuNo=600137&listType=2" class="show more_btn2">상세보기</a>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>
                </c:if>
           </c:forEach>

                <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_003.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                       수시대관 안내
                                    </h2>
                                    <p class="h_desc2">
                                    	최신의 시스템과 전문 스태프들이 창작자와 함께 실험과 도전을 완성하고,<br/>
										관객을 맞이할 수 있도록 최선을 다하고 있습니다.
									</p>
                                    <div class="more_btn_con">
                                        <a href="/${paramVO.siteName}/bbs/B0000061/view.do?nttId=72440&menuNo=700005" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

				<div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_008.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        콘텐츠문화광장
                                   </h2>
                                   <p class="h_desc2">최첨단 시설 구축으로 앞서가는 문화,<br/> 전문적인 문화를선도하는 콘텐츠 문화광장</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

                <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_007.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        시설안내
                                    </h2>
                                    <p class="h_desc2">스테이지66, 박스66, 스튜디오 1&2</p>
                                    <div class="more_btn_con">
                                        <a href="/${paramVO.siteName}/main/contents.do?menuNo=700103" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

            </div>
        </div>

        <!-- <div class="swiper-container" id="mainVisual">
            <div class="swiper-wrapper">

				<div class="main_visual swiper-slide testbed_visual titus_mobile_visual_position" style="background-image: url('/edu/images/bm/testbed_visual_img_006.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        타이터스
                                   </h2>
                                   <p class="h_desc2">2017.10.18 ~ 2017.10.20 / 10.21<br/>
                                    수, 목, 금 8:00pm / 토 3:00pm, 7:00pm</p>
                                    <div class="more_btn_con">
                                        <a href="/edumobile/main/contents.do?menuNo=600120&showViewNo=04" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

				<div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_003.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        콘텐츠문화광장
                                   </h2>
                                   <p class="h_desc2">최첨단 시설 구축으로 앞서가는 문화,<br/> 전문적인 문화를선도하는 콘텐츠 문화광장</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

                <div class="main_visual swiper-slide testbed_visual" style="background-image: url('/edu/images/bm/testbed_visual_img_007.jpg');">
                    <div class="col-12 col-center mw-1200">
                        <div class="col-12 pr15 pl15">
                            <div class="col-12 tc visual_wrap">
                                <div class="col-12 visual_text_wrap">
                                    <h2>
                                        시설안내
                                    </h2>
                                    <p class="h_desc2">스테이지66, 박스66, 연습실 1&2</p>
                                    <div class="more_btn_con">
                                        <a href="/edumobile/main/contents.do?menuNo=600118" class="show more_btn2">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_visual_img"></div>
                </div>

            </div>
        </div> -->
        <div class="col-12 col-center mw-1740 visual_inner">
            <button class="visual_arrow left"><img src="/edu/images/bm/visual_rolling_left_arrow.png" alt="이전 비쥬얼 보기"></button>
            <button class="visual_arrow right"><img src="/edu/images/bm/visual_rolling_right_arrow.png" alt="다음 비쥬얼 보기"></button>
        </div>
        <div class="tc mt30 fontsize0 caroufredusel_rolling_btn_con main_top_rolling_icon">
            <span class="show vm rolling_btn active"></span>
            <span class="show vm rolling_btn"></span>
            <span class="show vm rolling_btn"></span>
        </div>
		<a href="javascript:void(0)" class="rolling_stop_icon">
			<img src="/edu/images/bm/main_rolling_stop_icon.png" alt="정지">
		</a>
		<a href="javascript:void(0)" class="rolling_start_icon">
			<img src="/edu/images/bm/main_rolling_start_icon.png" alt="시작">
		</a>
        <script type="text/javascript">

	        function onAttrChangeTestbed(){
	        	$('#mainVisual .swiper-slide').attr('aria-hidden', 'true');
	        	$('#mainVisual .swiper-slide-active').attr('aria-hidden', 'false');
	        }


            $(function(){
                var swip = new Swiper("#mainVisual", {
                    loop : true
                    ,direction: 'horizontal' // 슬라이드 진행방향은 수평(vertical하면 수직으로 움직임)
                    ,slidesPerView: 1 // 한번에 보이는 슬라이드 갯수
                    ,spaceBetween: 0 // 슬라이드 사이의 간격 px 단위
                    ,mousewheelControl: false // 마우스 휠로 슬라이드 움직임
                    ,paginationHide: true
                    ,autoHeight:true
                    ,speed : 500
                    ,autoplay:3500
                    ,nextButton: '.visual_arrow.right'
                    ,prevButton: '.visual_arrow.left'
                    ,pagination: '.main_top_rolling_icon'
                    ,bulletActiveClass: 'active'
                    ,autoplayDisableOnInteraction: false
                    ,paginationBulletRender: function (swiper, index, className) {
                        return '<span class="show vm rolling_btn '+className+'"></span>';
                    }
	                ,onSlideChangeEnd : function(swiper){
	//        	        var i = geSlideDataIndex(swiper);
	        	    }
	        	    ,onSlideChangeStart : function(swiper){
	        	    	onAttrChangeTestbed();
	        	    }

                });

				$(".contents_view_page .rolling_stop_icon").on('click', function(){
					swip.stopAutoplay();
				});

				$(".contents_view_page .rolling_start_icon").on('click', function(){
					swip.startAutoplay();
				});
            });
        </script>
        <div class="col-12 col-center mw-1200 list_search_wrap">
            <div class="col-12 pr15 pl15">
                <div class="more_btn_wrap">
                    <a class="more_btn" href="/edumobile/concert/info/list.do?menuNo=600137">
                        <span>리스트 더보기</span>
                    </a>
                </div>
                <hr class="list_search_line">
                <div class="list_search_con">
                    <p class="title">
                        공연ㆍ행사 검색
                    </p>
                    <form name="searchForm" id="searchForm" action="/${paramVO.siteName}/concert/info/list.do?menuNo=600137" method="post">
					    <input type="hidden" name="menuNo" value="600137" />
					    <input type="hidden" name="pageIndex"  value="1"/>
					    <input type="hidden" name="listType"  value="2"/>
					    <input type="hidden" name="siteId"  value="edumobile"/>
					    <input type="hidden" name="selectedDate"  value=""/>

	                    <div class="data_list_box">
		                    <!-- <div class="data_list_wrap">
		                    	<div class="data_list_con">
			                        <span class="web_input_image">
				                        <input type="image" class="calender_btn" src="/edu/images/bm/calender_btn.png">
				                        <label for=""></label>
			                        </span>
			                        <span class="mobile_input_image">
				                        <input type="image" class="calender_btn" src="/edu/images/bm/calender_btn_mobile.png">
				                        <label for=""></label>
			                        </span>
			                        <input type="text" class="calender_text">
			                        <label for=""></label>
		                        </div>
		                    </div> -->
		                    <div class="data_list_con year">
	                    		<span class="web_input_image">
			                        <input type="image" class="calender_btn is_bg_on" src="/edu/images/bm/calender_btn_w.png" title="공연행사 프로그램 일정 연/월별 검색 버튼" alt="공연행사 프로그램 일정 연/월별 검색 버튼">
		                        </span>
		                        <span class="mobile_input_image">
			                        <input type="image" class="calender_btn is_bg_on" src="/edu/images/bm/calender_btn_w_mobile.png" title="공연행사 프로그램 일정 연/월별 검색 버튼" alt="공연행사 프로그램 일정 연/월별 검색 버튼">
		                        </span>
		                        <label for="searchConcertYear" class="back_label" aria-hidden="false">공연행사 년도 검색 구분</label>
		                        <select id="searchConcertYear" name="selectedYear" class="main_calendar_select" title="공연행사 년도 검색 구분">
		                        	<option value="2018">
		                        		2018년
		                        	</option>
		                        	<option value="2017">
		                        		2017년
		                        	</option>
		                        </select>
	                        </div>
	                        <%
	                        Calendar gCal = Calendar.getInstance();
	                		gCal.setTime(new Date());
	                		int cur_year = gCal.get(Calendar.YEAR);
	                		int cur_month = gCal.get(Calendar.MONTH)+1;
	                        %>
	                    	<div class="data_list_con">
	                    		<span class="web_input_image">
			                        <input type="image" class="calender_btn is_bg_on" src="/edu/images/bm/calender_btn_w.png" title="공연행사 프로그램 일정 연/월별 검색 버튼" alt="공연행사 프로그램 일정 연/월별 검색 버튼">
		                        </span>
		                        <span class="mobile_input_image">
			                        <input type="image" class="calender_btn is_bg_on" src="/edu/images/bm/calender_btn_w_mobile.png" title="공연행사 프로그램 일정 연/월별 검색 버튼" alt="공연행사 프로그램 일정 연/월별 검색 버튼">
		                        </span>
		                        <label for="searchConcertMonth" class="back_label" aria-hidden="false">공연행사 월 검색 구분</label>
		                        <select id="searchConcertMonth" name="selectedMonth" class="main_calendar_select" title="공연행사 월 검색 구분">
		                        	<option value="">
		                        		전체
		                        	</option>
		                        	<option value="12" <%= cur_month == 12 ? "selected" : "" %>>
		                        		12월
		                        	</option>
		                        	<option value="11" <%= cur_month == 11 ? "selected" : "" %>>
		                        		11월
		                        	</option>
		                        	<option value="10" <%= cur_month == 10 ? "selected" : "" %>>
		                        		10월
		                        	</option>
		                        	<option value="9" <%= cur_month == 9 ? "selected" : "" %>>
		                        		9월
		                        	</option>
		                        	<option value="8" <%= cur_month == 8 ? "selected" : "" %>>
		                        		8월
		                        	</option>
		                        	<option value="7" <%= cur_month == 7 ? "selected" : "" %>>
		                        		7월
		                        	</option>
		                        	<option value="6" <%= cur_month == 6 ? "selected" : "" %>>
		                        		6월
		                        	</option>
		                        	<option value="5" <%= cur_month == 5 ? "selected" : "" %>>
		                        		5월
		                        	</option>
		                        	<option value="4" <%= cur_month == 4 ? "selected" : "" %>>
		                        		4월
		                        	</option>
		                        	<option value="3" <%= cur_month == 3 ? "selected" : "" %>>
		                        		3월
		                        	</option>
		                        	<option value="2" <%= cur_month == 2 ? "selected" : "" %>>
		                        		2월
		                        	</option>
		                        	<option value="1" <%= cur_month == 1 ? "selected" : "" %>>
		                        		1월
		                        	</option>
		                        </select>
	                        </div>
	                    	<div class="data_list_con search">
	                    		<div class="data_search_text_box">
			                        <input type="text" class="search_text" name="searchKeyword" id="searchConcertTitle" placeholder="공연ㆍ행사 정보 검색" title="공연행사 검색어입력" alt="공연행사 검색어입력">
	                    			<label for="searchConcertTitle" class="back_label" aria-hidden="false">공연행사 검색어 입력</label>
			                        <span class="web_input_image">
				                        <input type="image" class="search_btn" src="/edu/images/bm/search_btn.png" value="공연ㆍ행사 정보 검색 버튼" alt="공연ㆍ행사 정보 검색 버튼">
			                        </span>
			                        <span class="mobile_input_image">
				                        <input type="image" class="search_btn" src="/edu/images/bm/search_btn_mobile.png" title="공연행사 프로그램 일정 연/월별 검색 버튼" alt="공연행사 프로그램 일정 연/월별 검색 버튼">
			                        </span>
		                        </div>
	                        </div>
	                    </div>
                    </form>
                    <script type="text/javascript">

                    $(function(){
                    	$("#searchForm").submit( function(e){
//                     		e.preventDefault();

//                     		if( $("#searchConcertMonth").val() == 0 ){

//                     		}
                    	})
                    })
                    </script>
                    <!-- <div class="data_list_box">
	                    <div class="data_list_wrap">
	                    	<div class="data_list_con">
		                        <span class="web_input_image">
			                        <input type="image" class="calender_btn" src="/edu/images/bm/calender_btn.png">
			                        <label for=""></label>
		                        </span>
		                        <span class="mobile_input_image">
			                        <input type="image" class="calender_btn" src="/edu/images/bm/calender_btn_mobile.png">
			                        <label for=""></label>
		                        </span>
		                        <input type="text" class="calender_text">
		                        <label for=""></label>
	                        </div>
	                    </div>
	                    <div class="data_list_wrap">
	                    	<div class="data_list_con">
	                    		<span class="web_input_image">
			                        <input type="image" class="calender_btn is_bg_on" src="/edu/images/bm/calender_btn_w.png">
			                        <label for=""></label>
		                        </span>
		                        <span class="mobile_input_image">
			                        <input type="image" class="calender_btn is_bg_on" src="/edu/images/bm/calender_btn_w_mobile.png">
			                        <label for=""></label>
		                        </span>
		                        <input type="text" class="calender_text">
		                        <label for=""></label>
	                        </div>
	                    </div>
	                    <div class="data_list_wrap search">
	                    	<div class="data_list_con">
	                    		<div class="data_search_text_box">
			                        <input type="text" class="search_text" placeholder="공연ㆍ행사 정보 검색">
			                        <label for=""></label>
			                        <span class="web_input_image">
				                        <input type="image" onclick="javascript:alert('서비스 준비중 입니다.');" class="search_btn" src="/edu/images/bm/search_btn.png">
				                        <label for=""></label>
			                        </span>
			                        <span class="mobile_input_image">
				                        <input type="image" onclick="javascript:alert('서비스 준비중 입니다.');" class="search_btn" src="/edu/images/bm/search_btn_mobile.png">
				                        <label for=""></label>
			                        </span>
		                        </div>
	                        </div>
	                    </div>
                    </div> -->
                </div>
            </div>
        </div>


	</div>
    <!-- //contents -->





	<!-- 공지사항, 자유게시판 -->
    <%-- <div class="col-12 section contents_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15 contents_wrap">
                <div class="col-12 col-md-6 contents_left_box">
                    <div class="col-12 notice_wrap">
                        <div class="col-12 mb15 section_header">
                            <h4 class="fl">공지사항</h4>
                            <a href="/testbed/bbs/B0000061/list.do?menuNo=700112" class="show fr mt7 mr-md-10 more_btn">더보기</a>
                        </div>
                        <div class="col-12 fontsize0 mb16 section_bar">
                            <hr class="h_line4">
                        </div>
                        <div class="col-12 pr-md-per10 contents_body">

                        	<c:choose>
                        		<c:when test='${ B0000061List.size() > 0 }'>
		                        	<c:forEach var="result" items="${B0000061List}" varStatus="status">
							            <c:if test="${status.index == 0}">
							                <p class="col-12 section_title new">
								                <span>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=700112">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </span>
							                </p>
							                <p class="col-12 mb3 section_desc4">
							                	<c:out value="${result.imgDescCn}"/>
							                </p>
							                <p class="col-12 mb11 section_date4">
							                	<c:out value="${fn:substring(result.regDate,0,10)}"/>
							                </p>
							            </c:if>
							        </c:forEach>
		                            <ul class="col-12 list_style_0">
		                            	<c:forEach var="result" items="${B0000061List}" varStatus="status">
								            <c:if test='${status.index > 0}'>
								                <li>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=700005">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </li>
								            </c:if>
								        </c:forEach>
		                            </ul>
                            	</c:when>
                            	<c:otherwise>
                            		<!-- 게시글 없을 때 처리 -->
                            		<ul class="list_style_8">
                            			<li>등록된 게시물이 없습니다.</li>
                            		</ul>
                            	</c:otherwise>
                           	</c:choose>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 contents_right_box">
                    <div class="col-12 notice_wrap">
                        <div class="col-12 mb15 section_header">
                            <h4 class="fl">자유게시판</h4>
                            <a href="/testbed/bbs/B0000062/list.do?menuNo=700113" class="show fr mt7 mr-md-10 more_btn">더보기</a>
                        </div>
                        <div class="col-12 fontsize0 mb16 section_bar">
                            <hr class="h_line4">
                        </div>
                        <div class="col-12 pr-md-per10 contents_body" data-zz="${B0000062List.size() }">
                        	<c:choose>
                        		<c:when test='${ B0000062List.size() > 0 }'>

		                            <c:forEach var="result" items="${B0000062List}" varStatus="status">
							            <c:if test="${status.index == 0}">
							                <p class="col-12 section_title new">
								                <span>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=700113">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </span>
							                </p>
							                <p class="col-12 mb3 section_desc4">
							                	<c:out value="${result.imgDescCn}"/>
							                </p>
							                <p class="col-12 mb11 section_date4">
							                	<c:out value="${fn:substring(result.regDate,0,10)}"/>
							                </p>
							            </c:if>
							        </c:forEach>
		                            <ul class="col-12 list_style_0">
		                            	<c:forEach var="result" items="${B0000062List}" varStatus="status">
								            <c:if test='${status.index > 0}'>
								                <li>
									                <a href="/testbed/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008">
									                	<c:out value="${result.nttSj}"/>
									                </a>
								                </li>
								            </c:if>
								        </c:forEach>
		                            </ul>
                        		</c:when>
                        		<c:otherwise>
                        		<!-- 게시글 없을 때 처리 -->
                            		<ul class="list_style_8">
                            			<li>등록된 게시물이 없습니다.</li>
                            		</ul>
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> --%>
    <!-- //공지사항, 자유게시판 -->
    <!-- 2017 09 26 태경 주석처리(디자인상 제거) -> 기획상 제거인듯 -->

	<!-- 공연장 대관 카드리스트 -->
    <div class="col-12 sub_section performance_hall_card_section">
        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_card_list_wrap is-mobile">
                    <div class="col-xs-12 col-sm-4 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_002.png" alt="">
                        </div>
                        <div class="text_box">
                            <h3>
                                비전 및 미션
                            </h3>
                            <p class="h_desc3">
                                콘텐츠와 기술이 연결되는<br/>
								세계로 열린 무대입니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/edumobile/main/contents.do?menuNo=600116" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
					<!--
                    <div class="col-sm-6 col-3 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_003.png" alt="">
                        </div>
                        <div class="text_box">
                            <h3>
                                입주 프로그램 안내
                            </h3>
                            <p class="h_desc3">
                                문화예술 콘텐츠 기업육성<br/>
								인프라 특화형 입주기업 모집
                            </p>
                        </div>
                         <div class="center board_util_btn_con">
                        	<a href="/edumobile/main/contents.do?menuNo=600123" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                    -->
                    <div class="col-xs-12 col-sm-4 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_000.png" alt="">
                        </div>
                        <div class="text_box">
                            <h3>
                                예약안내
                            </h3>
                            <p class="h_desc3">
                                예약안내사항을 잘 확인후<br/>
								공연ㆍ행사 예약을 진행해주세요
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/edumobile/main/contents.do?menuNo=600121" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-4 performance_hall_card_list">
                        <div class="img_box">
                            <img src="/edu/images/bm/performance_hall_card_list_img_004.png" alt="">
                        </div>
                        <div class="text_box">
                            <h3>
                                오시는 길
                            </h3>
                            <p class="h_desc3">
                                콘텐츠 인재캠퍼스 내부에<br/>
								위치해 있습니다
                            </p>
                        </div>
                        <div class="center board_util_btn_con">
                        	<a href="/edumobile/main/contents.do?menuNo=600119" class="performance_btn_style_0">바로가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--//공연장 대관 카드리스트 -->



    <!-- 공연장 대관 -->
    <div class="col-12 sub_section performance_hall_section">

        <div class="col-12 col-center mw-1200">
            <div class="col-12 pr15 pl15">
                <div class="performance_hall_wrap">
                    <div class="performance_hall_header">
                        <h3>
                            대관 안내
                        </h3>
                    </div>
                    <div class="performance_hall_body">
                        <h4>
                            대관 안내
                        </h4>
                        <p class="h_desc4">
                            <!-- 문화와 예술을 통해 진정한 휴식을 느낄 수 있도록 여러분의<br>
                            편안하고 친근한  문화쉼터가 될 것입니다. -->
                            새로운 미디어와 테크놀로지, 문화예술의 만남은<br/>
                            새로운 미래 콘텐츠의 성장판이 될 것입니다.
                        </p>
                        <p class="h_data4">
                            <span class="list">전화 : 02.6310.0626</span><span class="list">E-MAIL : <a href="mailto:yhsong@kocca.kr">yhsong@kocca.kr</a></span><span class="list">대관문의 : 월 ~ 금 (10:00-18:00)</span>
                        </p>
                        <div class="download_wrap">
                            <a class="download_btn" href="/upload/testbedupload/testbedapply_2019_new.hwp">
                                <span>제출서식 다운로드</span>
                            </a>
                            <a class="download_btn" href="/upload/testbed/testbedpolicy.hwp">
                                <span>대관안내 다운로드</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // 공연장 대관 -->


    <!-- 시설안내 -->
    <div class="col-12 sub_section facilities_information_section">
        <div class="col-12 facilities_information_header">
        	<div class="col-12 col-center mw-1200">
        		<div class="col-12 pr15 pl15">
        			<div class="facilities_guide_con">
		        		<div class="facilities_guide_left_box">
			        		<p class="facilities_guide_title">
			        			FACILITIES GUIDE
			        		</p>
				            <h3>
				                시설 안내
				            </h3>
			        	</div>
			        	<div class="facilities_guide_right_box">
			        		<div class="facilities_guide_desc">
				        		콘텐츠문화광장은 콘텐츠 시연무대 스테이지66, 프로젝트 시연공간 박스66,<br/>
				        		문화예술기업 입주공간, 인프라 공간 등 콘텐츠 산업의 미래를 여는 역할을 하고 있습니다.
							</div>
							<div class="facilities_guide_btn_con">
								<a href="/edumobile/main/contents.do?menuNo=600118" class="facilities_more_btn">
									자세히보기
								</a>
							</div>
			        	</div>
		        	</div>
	        	</div>
        	</div>
        </div>
        <div class="col-12 facilities_information_list_wrap">
            <div class="col-12 col-md-6 facilities_information_list top left">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        콘텐츠문화광장
                    </h4>
                    <p class="h_desc4">
                        규모 : 연면적 2,700㎡ (지하2층, 지상2층, 문화산업진흥시설)<br>
                        주요 시설 : 스테이지66(193석,350㎡(106py)), 문화예술기업 입주공간 외
                    </p>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list top right">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        스테이지66_콘텐츠 시연무대
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list w_263 padding_30">
                            <h5>
                                무대공간
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <!-- <li>극장형태 : 프로시니엄 극장</li>
                                <li>객석을 수납하여 최대 19m 깊이를 가진</li>
                                <li>블랙박스 형식의 공간으로 활용 가능</li> -->
                                <li><span>블랙박스</span></li>
                                <li><span>폭 14m x 깊이 17m x 높이 9m</span></li>
                                <li><span>상부 : 장치봉, 조명봉, 캣워크</span></li>
                                <li><span>하부 : 폭 12m x 깊이 2.5m의 승강무대 2조 (최대 상승 높이 1m)</span></li>
                            </ul>
                        </div>
                        <div class="contents_list w_263">
                            <h5>
                                객석 공간
                            </h5>
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <!-- <li>주무대 : 폭 14m x 깊이 9m x 높이 15m</li>
                                <li>우측무대 : 폭 7m x 깊이 9m x 높이 15m</li> -->
                                <li><span>1층 135석(수납식)</span></li>
                                <li><span>2층 24석</span></li>
                                <li><span>3층 34석(휠체어석 2석 포함)</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom left">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
                    <h4>
                        박스66_프로젝트 시연공간
                    </h4>
                    <div class="contents_list_wrap">
                        <div class="contents_list">
                            <hr class="h_line5">
                            <ul class="list_style_facilities">
                                <li><span>가로 5m x 세로 12m x 높이 4m  유리 박스형 가변형 공간</span></li>
                                <li><span>프로젝트 시연, 기술실험, 전시공간</span></li>
                                <li><span>데모데이, 워크숍, 교육 등 소규모 이벤트가 가능한 멀티공간</span></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 facilities_information_list bottom right">
                <div class="col-12 img_box"></div>
                <div class="col-12 text_box">
					<h4>
						스튜디오 1,2
					</h4>
					<div class="contents_list_wrap">
						<div class="contents_list w_420">
							<hr class="h_line5">
							<ul class="list_style_facilities">
								<li><span>스튜디오1 : 가로 11m x 세로 5m x 높이 3.5m</span></li>
								<li><span>스튜디오2 : 가로 12m x 세로 12m x 높이 8m (최저부 3m)</span></li>
								<li><span>시연, 강연, 상영, 전시, 워크숍, 연습, 소규모 이벤트가 가능한 멀티 공간</span></li>
							</ul>
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>
    <!-- //시설안내 -->

    <!-- footer -->
	<jsp:include page="/WEB-INF/jsp/edumobile/inc/testbedmobileFooter.jsp" flush="true" />
    <!-- //footer -->
</div>

</body>
</html>
