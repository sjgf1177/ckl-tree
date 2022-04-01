<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="java.util.*"%>
<%@ page import="kr.co.unp.member.vo.*"%>
<%@ page
	import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper"%>
<%@ page import="kr.co.unp.mpm.vo.MenuManageVO"%>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<c:set var='siteName' value='${paramVO.siteName}' />
<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);
	String menuNo = request.getParameter("menuNo");
	if (StringUtils.hasText(menuNo)) {

		org.springframework.context.ApplicationContext context = org.springframework.web.context.support.WebApplicationContextUtils
				.getWebApplicationContext(getServletContext());
		MasterMenuManager masterMenuManagerService = (MasterMenuManager) context
				.getBean("masterMenuManagerService");

		/* testbed20170830 */
		String siteName = (String) pageContext.getAttribute("siteName") != null
				? (String) pageContext.getAttribute("siteName")
				: "";
		HashMap<String, List<MenuManageVO>> menuMap = new HashMap<String, List<MenuManageVO>>();
		HashMap<String, List<MenuManageVO>> eduMenuMap = (HashMap<String, List<MenuManageVO>>) application
				.getAttribute("menuAll5");
		HashMap<String, List<MenuManageVO>> testbedMenuMap = (HashMap<String, List<MenuManageVO>>) application
				.getAttribute("menuAll7");
		menuMap.putAll(eduMenuMap);
		if ("testbed".equals(siteName))
			menuMap.putAll(testbedMenuMap);
		/* //testbed20170830 */
		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
		pageContext.setAttribute("currMenu", currentVo);

		if(currentVo != null){
			String position = currentVo.getPosition();
			int depth01 = Integer.parseInt(position.substring(0, 2)) - 1;
			int depth02 = Integer.parseInt(position.substring(2, 4)) - 1;
			int depth03 = Integer.parseInt(position.substring(4, 6)) - 1;
			int depth04 = Integer.parseInt(position.substring(6, 8)) - 1;
			int depth05 = Integer.parseInt(position.substring(8, 10)) - 1;
			int depth06 = Integer.parseInt(position.substring(10, 12)) - 1;
			if ("testbed".equals(siteName))//testbed20170830
				depth01 = 5;
			pageContext.setAttribute("depth01", depth01);
			pageContext.setAttribute("depth02", depth02);
			pageContext.setAttribute("depth03", depth03);
			pageContext.setAttribute("depth04", depth04);
			pageContext.setAttribute("depth05", depth05);
			pageContext.setAttribute("depth06", depth06);
		}
	}
%>
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<script type="text/javascript">
	//<![CDATA[

	function search2(form) {
		if (!form.q.value) {
			alert("검색어를 입력하세요.");
			$("#q2")[0].focus();
			return false;
		}
		return true;
	}

	function logoutSSO() {
		$
				.get(
						"/${paramVO.siteName}/member/logout.json",
						function(data) {
							var retUrl = "${ssoDomain}/sso/member/logoutSSO.do?service=${paramVO.siteName}";
							//alert(retUrl);
							location.href = retUrl;
						}, "json");
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

<div class="col-12 header_wrap">

	<!-- 하위스크롤 경우 // headerTopOn -->
	<div class="col-12 col-center mw-1200 over-visible header_inner">
		<div class="col-12 pr15 pl15">
			<div class="col-12 header_con">
				<div class="col-12 col-center mw-1200 over-visible">
					<div class="col-12 pr15 pl15">
						<!-- Util 영역 -->
						<div class="col-12 tr fontsize0 header_util_wrap">
							<div class="show vm header_util_text_con">
								<span class="show vm fontsize14 header_util_item">
									<a href="#subContainer" class="ico1" title="본문으로">본문으로</a>
								</span>
								<hr class="show vm header_util_line">
								<sec:authorize ifAnyGranted="ROLE_USER">
									<c:if test="${paramVO.siteName eq 'edu' }">
										<c:set var="mypageNm" value="마이페이지" />
										<c:set var="mypageUrl"
											value="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" />
									</c:if>
									<c:if test="${paramVO.siteName eq 'testbed' }">
										<c:set var="mypageNm" value="마이페이지" />
										<c:set var="mypageUrl"
											value="/testbed/userMember/forUpdate.do?menuNo=700118" />
									</c:if>
									<span class="show vm fontsize14 header_util_item"><span
										class="name_color"><c:out value="${userVO.userNm }" /></span>님
										로그인중입니다.</span>
									<hr class="show vm header_util_line">
									<span class="show vm fontsize14 header_util_item"><a
										href="/${paramVO.siteName}/member/logout.do"
										class="ico4 logoutBtn" title="로그아웃">로그아웃</a></span>
									<hr class="show vm header_util_line">
									<span class="show vm fontsize14 header_util_item"
										style="position: relative;" id="myPageMenu"> <a
										href="${mypageUrl}" class="ico5" title="${mypageNm}"> <!-- <img src="/edu/images/edupro/icon_mypage.png" alt="마이페이지" title="마이페이지" style="position:absolute;top:0px;" /> -->
											<span>${mypageNm}</span>
									</a> <!-- 레이어 팝업 -->
										<div class="mypageSubLayer">
											<p style="text-align: left; line-height: 24px;">
												<span style="color: #000; font-weight: 600;">[온라인교육]</span><br>학습중인
												과정 : <span id="studyCount">0</span>개
											</p>
										</div> <!-- //레이어 팝업 -->
									</span>
									<hr class="show vm header_util_line">
									<script type="text/javascript">
										var selectCount = false;
										$(document)
												.ready(
														function() {
															$('#myPageMenu')
																	.mouseover(
																			function() {
																				showMypageLayer('IN');
																			});
															$('#myPageMenu')
																	.mouseout(
																			function() {
																				showMypageLayer('OUT');
																			});
															$('.mypageSubLayer')
																	.mouseout(
																			function() {
																				showMypageLayer('OUT');
																			});

															getMyStudyCount();
														});

										function showMypageLayer(type) {
											if (type == "IN") {
												if (!selectCount) {
													selectCount = true;
													getMyStudyCount();
												}
												$('.mypageSubLayer').show();
											} else {
												$('.mypageSubLayer').hide();
											}
										}

										function getMyStudyCount() {
											$
													.ajax({
														url : '/edu/onlineEdu/mylctrum/selectMyStudyCount.json',
														dataType : 'json',
														data : null,
														success : function(data) {
															$('.mypageSubLayer')
																	.find(
																			'#studyCount')
																	.html(
																			data.studyCount);
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
									<c:url var="loginUrl"
										value="/${paramVO.siteName}/member/forLogin.do">
										<c:param name="menuNo" value="500077" />
										<c:param name="_targetUrl" value="${_targetUrl}" />
									</c:url>
									<c:choose>
										<c:when test="${paramVO.siteName eq 'testbed'}">
											<span class="show vm fontsize14 header_util_item"><a
												href="javascript:document.getElementById('loginForm').submit();"
												class="ico1" title="로그인">로그인</a></span>
											<form class="login_form" name="loginForm" id="loginForm"
												action="/edu/member/forLogin.do?menuNo=500077"
												method="post" style="display: none;">
												<input type="hidden" name="redirectUrl"
													value="/${paramVO.siteName}/main/main.do" />
											</form>
											<hr class="show vm header_util_line">
											<span class="show vm fontsize14 header_util_item"><a
												href="/testbed/member/join01.do?menuNo=700121" class="ico2"
												title="회원가입">회원가입</a></span>
											<hr class="show vm header_util_line">
										</c:when>
										<c:otherwise>
											<span class="show vm fontsize14 header_util_item"><a
												href="/edu/member/forLogin.do?menuNo=500077" class="ico1"
												title="로그인">로그인</a></span>
											<hr class="show vm header_util_line">
											<span class="show vm fontsize14 header_util_item"><a
												href="/edu/member/join01.do?menuNo=500076" class="ico2"
												title="회원가입">회원가입</a></span>
											<hr class="show vm header_util_line">
										</c:otherwise>
									</c:choose>
								</sec:authorize>
								<span class="show vm fontsize14 header_util_item"><a
									href="/edu/main/contents.do?menuNo=500074" class="ico3"
									title="사이트맵">사이트맵</a></span>
								<!-- <span class="bgn"><a href="/edu/main/contents.do?menuNo=500074" class="ico3" title="사이트맵">사이트맵</a></span> -->
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
						<!-- gnb 영역! -->
						<div class="col-12 pt27 pb22 header_section">
							<!-- 로고 -->
							<h1 class="show logo_con">
								<a href="/edu/main/main.do" class="show"><img style="width: 120px;" src="/edu/new_image/main/logo.png" alt="KOCCA(Create NeWave) 에듀코카 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
								&nbsp;&nbsp;
								<a href="/testbed/main/main.do" class="show"><img style="width: 100px;" src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
							</h1>
							<!-- gnb -->
							<c:set var="topCategories" value="${menuAll5['menu_0']}" />
							<c:set var="curD" value="${topCategories[depth01]}" />
							<div class="over-md-hidden tr gnb_wrap">
								<ul class="gnb_con tc">
									<c:forEach var="x" begin="0" end="4">
										<li>
											<c:if test="${x eq depth01}">
												<c:set var="1depth_title" value="${topCategories[x].menuNm}" />
											</c:if> 
											<a href="${topCategories[x].fullMenuLink}" ${depth01 eq x ? 'class="active"' : ''} ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
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
																<ul>
																	<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
																		<c:set var="clss2" value="${y eq depth02 && z eq depth03 ? 'on' : ''}" />
																		<c:if test="${y eq depth02 && z eq depth03}">
																			<c:set var="curD" value="${d03Categories[z]}" />
																			<c:set var="curD03" value="${d03Categories[z]}" />
																		</c:if>
																		<%-- 다나 오픈세미나 3뎁스, 우수크리에이터 3뎁스 제거 --%>
																		<%-- <c:if test="${d03Categories[z].menuNo ne '500124' && d03Categories[z].menuNo ne '500125' && d03Categories[z].menuNo ne '500126' && d03Categories[z].menuNo ne '500128'}"> --%>
																		<c:if test="${d02Categories[y].menuNo eq '700001' || d02Categories[y].menuNo eq '700006' || d02Categories[y].menuNo eq '700005'}">
																			<li class="${clss2}"><a
																				href="${d03Categories[z].fullMenuLink}"
																				${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>${d03Categories[z].menuNm}</a>
																			</li>
																		</c:if>
																	</c:forEach>
																</ul>
															</c:if></li>
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
											<input type="text" class="q2" name="q" id="q2"
												placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요.">  --%>
											<!-- <label for="q2" id="all_search_label"></label>  -->
											<%-- <input type="image" src="/edu/images/bm/search_icon.png" alt="검색 확인" class="all_search_image"> --%>
											<!-- <input type="image" src="/edu/images/common/schGlobalSetOk.gif" alt="검색 확인" class="p0 m0 vt" /> -->
										<%--</form>  --%>
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

			<%--
            <div id="global">
                <!-- 검색창 -->
                <div class="globalSchSet">
                    <form name="frmSearch2" method="post" action="/edu/search/list.do?menuNo=500079" onsubmit="return search2(this);">
                        <input type="text" name="q" id="q2" class="schWordInput vt" value="" title="검색어를 입력하세요." />
                        <input type="image" src="/edu/images/common/schGlobalSetOk.gif" alt="검색 확인" class="p0 m0 vt" />
                    </form>
                </div>
                <!-- //검색창 -->
            </div>
            <!-- gnb -->
            <div class="gnbSet">
                <div class="gnbTotMenu"><a href="javascript:void(0);"><span class="hidden">전체메뉴 열기</span></a></div>
                <div class="totMenuT">
                    <c:forEach var="x" begin="0" end="5">
                        <dl class="tms${x+1}">
                            <dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank"' : ''}>${topCategories[x].menuNm}</a></dt>
                            <dd>
                                <c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
                                <c:set var="d02Categories" value="${menuAll5[d02MenuKey]}" />
                                <c:if test="${fn:length(d02Categories)>0}">
                                    <ul>
                                        <c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
                                            <li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </dd>
                        </dl>
                    </c:forEach>
                    <a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">전체메뉴 닫기</span></a>
                </div>
            </div>
            <!-- //gnb -->
            --%>
		</div>
	</div>
	<div class="col-12 col-center mw-1200">
		<div class="col-12 pr15 pl15">
			<div class="col-12 tc visual_wrap">
				<div class="col-12 visual_util_wrap">
					<div class="tr sharing_util_icon">
						<li><a href="javascript:void(0);" class="ico01 snsToggleOpen"><span
								class="hidden">SNS 공유하기</span></a>
							<div class="snsDrop" style="display: none;">
								<c:url value="https://www.facebook.com/sharer.php" var="fbUrl">
									<c:param name="t" value="${title}" />
									<c:param name="u" value="${currMenu.fullMenuLink}" />
								</c:url>
								<c:url value="https://twitter.com/share" var="twitterUrl">
									<c:param name="text" value="${title}" />
									<c:param name="url" value="${currMenu.fullMenuLink}" />
								</c:url>
								<ul>
									<li><a href="<c:out value='${fbUrl}' escapeXml='true' />"
										class="icos01" onclick="return facebookOpen();"
										title="(새창열림)페이스북 링크 공유하기" target="_blank"><span
											class="hidden">페이스북</span></a></li>
									<li><a
										href="<c:out value='${twitterUrl}' escapeXml='true' />"
										class="icos02" onclick="return twitterOpen();"
										title="(새창열림)트위터 링크 공유하기" target="_blank"><span
											class="hidden">트위터</span></a></li>
								</ul>
							</div>
						</li>
						<li><a href="#self" Class="ico02 CopyClipOpen"><span
								Class="hidden">URL 복사하기</span></a> <script type="text/javascript">
									//<![CDATA[
									var linkURL = document.URL;
									var param = "";
									$(document)
											.ready(
													function() {
														$(':hidden')
																.each(
																		function() {
																			if (null != $(
																					this)
																					.attr(
																							'name')
																					&& $(
																							this)
																							.val() != "") {
																				if (linkURL
																						.indexOf($(
																								this)
																								.attr(
																										'name')) < 0) {
																					param += "&"
																							+ $(
																									this)
																									.attr(
																											'name')
																							+ "="
																							+ $(
																									this)
																									.val();
																				}
																			}
																		});

														$(
																".sharing_util_icon .ico02")
																.click(
																		function() {
																			urlLink();
																			return false;
																		});
													});

									//$("#COPYCP").prop("value", linkURL);
									function urlLink() {
										var IE = (document.all) ? true : false;
										if (IE) {
											window.clipboardData.setData(
													'Text', linkURL + param);
											alert('주소가 복사되었습니다. 브라우저의 URL 입력창에 Ctrl+V로 붙여 넣기 하세요.');
										} else {
											temp = prompt(
													"이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요",
													linkURL + param);
										}
										return false;
									}
									//]]>
								</script></li>
						<li><a href="/edu/forPrint.jsp" class="ico03"
							onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;"
							target="_blank" title="(새창열림)내용인쇄하기"><span class="hidden">인쇄하기</span></a></li>
					</div>
				</div>
				<div class="col-12 tl tr-md visual_text_wrap">


					<c:choose>
						<c:when test='${fn:indexOf(pathData[0], "온라인교육") > -1 }'>
							<h2>
								국내 유일의 방송/문화/게임 <span class="point1">콘텐츠 전문 온라인 교육</span>
							</h2>
							<style type="text/css">
.visual_wrap h2 {
	margin-bottom: 80px;
}

.visual_text_wrap {
	text-align: center;
}

.visual_util_wrap {
	display: none;
}

@media all and (min-width:992px) {
	.visual_wrap h2 {
		margin-bottom: 150px;
	}
}
</style>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "취업지원") > -1 }'>
							<h2>
								콘텐츠 전문분야로의 <span class="point1">취업역량 강화를<br /> 위한 맞춤형
								</span> 취업컨설팅
							</h2>
							<style type="text/css">
.visual_wrap h2 {
	margin-bottom: 80px;
}

.visual_text_wrap {
	text-align: center;
}

.visual_util_wrap {
	display: none;
}

@media all and (min-width:992px) {
	.visual_wrap h2 {
		margin-bottom: 150px;
	}
}
</style>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "콘텐츠문화광장") > -1 }'>
							<h2>${pathData[1]}</h2>
							<c:choose>
							    <c:when test="${fn:indexOf(pathData[1], '프로그램') > -1 }">
							        <p class="h_desc2" style="display: block;">혁신기술 융합 콘텐츠의 제작 및 시연</p>
							    </c:when>
							    <c:when test="${fn:indexOf(pathData[1], '대관 서비스') > -1 }">
							       <p class="h_desc2" style="display: block;">공연장 및 연습실 대관, 보유 장비 사용 및 하우스 운영 무상 지원</p>
							    </c:when>
							    <c:when test="${fn:indexOf(pathData[1], '문화예술기업') > -1 }">
							        <p class="h_desc2" style="display: block;">융복합 콘텐츠 및 관련 기술 영역 개척 기업에 활동 지원</p>
							    </c:when>
							    <c:when test="${fn:indexOf(pathData[1], '커뮤니티') > -1 }">
							        <p class="h_desc2" style="display: block;">한 걸음 더 가까이 소통하는 콘텐츠 문화광장</p>
							    </c:when>
							    <c:otherwise>
							        <p class="h_desc2" style="display: block;">세계로 열린 콘텐츠 실험무대</p>
							    </c:otherwise>
							</c:choose>
							<style type="text/css">
							.h_desc2 {
								display: none;
							}
							</style>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "HOME") > -1 }'>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">융합형 창의인재 양성의 중심허브,
								콘텐츠인재캠퍼스</p>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "교육지원사업") > -1 }'>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">콘텐츠 분야 전문인력 양성을 위한
								현장중심 프로그램 지원</p>
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
	 		<c:choose>
			    <c:when test="${fn:indexOf(pathData[1], '프로그램') > -1 }">
			        <div class="sub_visual img_006"></div>
			    </c:when>
			    <c:when test="${fn:indexOf(pathData[1], '대관 서비스') > -1 }">
			        <div class="sub_visual img_007"></div>
			    </c:when>
			    <c:when test="${fn:indexOf(pathData[1], '문화예술기업') > -1 }">
			        <div class="sub_visual img_008"></div>
			    </c:when>
			    <c:when test="${fn:indexOf(pathData[1], '커뮤니티') > -1 }">
			        <div class="sub_visual img_009"></div>
			    </c:when>
			    <c:when test="${fn:indexOf(pathData[1], '콘텐츠인재캠퍼스') > -1 }">
			        <div class="sub_visual img_010"></div>
			    </c:when>
			    <c:otherwise>
			        <div class="sub_visual img_005"></div>
			    </c:otherwise>
			</c:choose>
		 		<%-- <c:if test="${fn:indexOf(pathData[1], '프로그램') > -1 }">
	 			<div class="sub_visual img_006"></div>
			</c:if> --%>
		</c:when>
		<c:otherwise>
			<div class="sub_visual"></div>
		</c:otherwise>
	</c:choose>

</div>
