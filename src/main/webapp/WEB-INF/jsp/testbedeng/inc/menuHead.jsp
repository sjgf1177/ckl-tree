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

		/* testbedeng20171110 */
		String siteName = (String) pageContext.getAttribute("siteName") != null
				? (String) pageContext.getAttribute("siteName")
				: "";
		HashMap<String, List<MenuManageVO>> menuMap  = (HashMap<String, List<MenuManageVO>>) application
				.getAttribute("menuAll8");
		/* //testbedeng20171110 */
		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
		pageContext.setAttribute("currMenu", currentVo);

		String position = currentVo.getPosition();
		int depth01 = Integer.parseInt(position.substring(0, 2)) - 1;
		int depth02 = Integer.parseInt(position.substring(2, 4)) - 1;
		int depth03 = Integer.parseInt(position.substring(4, 6)) - 1;
		int depth04 = Integer.parseInt(position.substring(6, 8)) - 1;
		int depth05 = Integer.parseInt(position.substring(8, 10)) - 1;
		int depth06 = Integer.parseInt(position.substring(10, 12)) - 1;
		pageContext.setAttribute("depth01", depth01);
		pageContext.setAttribute("depth02", depth02);
		pageContext.setAttribute("depth03", depth03);
		pageContext.setAttribute("depth04", depth04);
		pageContext.setAttribute("depth05", depth05);
		pageContext.setAttribute("depth06", depth06);
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
								<span class="show header_util_icon_item"> <a
									href="https://www.facebook.com/edukocca" target="_blank" title="새창열림"> <img
										src="/edu/images/bm/facebook_icon.png" alt="페이스북 바로가기">
								</a>
								</span> <span class="show header_util_icon_item"> <a
									href="https://twitter.com/edukocca" target="_blank" title="새창열림"> <img
										src="/edu/images/bm/twitter_icon.png" alt="트위터 바로가기">
								</a>
								</span> <span class="show header_util_icon_item"> <a
									href="https://blog.naver.com/edukocca" target="_blank" title="새창열림"> <img
										src="/edu/images/bm/blog_icon.png" alt="블로그 바로가기">
								</a>
								</span>
							</div>
						</div>
						<!-- gnb 영역! -->
						<div class="col-12 pt27 pb22 header_section">
							<!-- 로고 -->
							<!-- <h1 class="logo"><a href="/edu/main/main.do"><span class="hidden">KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)</span></a></h1> -->
							<h1 class="show logo_con">
								<!-- <a href="/testbedeng/main/main.do" class="show"><img
									src="/edu/images/bm/multi_content_testbed_logo.png"
									alt="KOCCA(Create NeWave) 한국콘텐츠아카데미 (대한민국 영토, 콘텐츠로 넓힌다!)"></a> -->
									<a href="/edumobile/main/main.do" class="show mobile_only"><img style="width: 120px;" src="/edu/new_image/w_logo.png" alt="KOCCA(Create NeWave) 에듀코카 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
                           			<a href="/edu/main/main.do" class="show web_only"><img style="width: 120px;" src="/edu/new_image/w_logo.png" alt="KOCCA(Create NeWave) 에듀코카 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
									&nbsp;&nbsp;
									<a href="/testbedeng/main/main.do" class="show"><img style="width: 100px;" src="/edu/images/bm/multi_content_testbed_logo.png" alt="KOCCA(Create NeWave) 콘텐츠문화광장 (대한민국 영토, 콘텐츠로 넓힌다!)"></a>
							</h1>
							<!-- gnb -->
							<c:set var="topCategories" value="${menuAll8['menu_0']}" />
							<c:set var="curD" value="${topCategories[depth01]}" />
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
										<form name="frmSearch2" method="post"
											action="/edu/search/list.do?menuNo=500079"
											onsubmit="return search2(this);">
											<input type="text" class="q2" name="q" id="q2"
												placeholder="검색어를 입력해주세요." title="검색어를 입력해주세요."> <label
												for="q2" id="all_search_label"></label> <input type="image"
												src="/edu/images/bm/search_icon.png" alt="검색 확인"
												class="all_search_image"> --%>
											<!-- <input type="image" src="/edu/images/common/schGlobalSetOk.gif" alt="검색 확인" class="p0 m0 vt" /> -->
										<%-- </form> --%>
									</span>
									<!-- //검색창 -->
									<%-- <hr class="show vm seperate_line"> --%>
									<span class="show vm gnb_icon"> <img class="gnb_menu"
										src="/edu/img/gnb_icon.png" alt="GNB 메뉴"> <img
										class="gnb_close" src="/edu/img/gnb_close.png" alt="GNB 메뉴 닫기">
									</span>
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
							</div></li>
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
						<c:when test='${fn:indexOf(pathData[0], "ABOUT") > -1 }'>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">Discover and foster future content based multi content</p>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "FACILITY") > -1 }'>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">Undertake production and test launching of innovative technological convergence content</p>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "A&amp;C ENT") > -1 }'>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">Support prospective Arts & Culture Business</p>
						</c:when>
						<c:when test='${fn:indexOf(pathData[0], "VISIT") > -1 }'>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">How to get to Multi Content Testbed</p>
						</c:when>
						<c:otherwise>
							<h2>${pathData[0]}</h2>
							<p class="h_desc2" style="display: block;">Potential in the field of content and capacity building programs for business people</p>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>
	</div>
	
	<c:choose>
		<c:when test='${fn:indexOf(pathData[0], "ABOUT") > -1 }'>
			<div class="sub_visual img_005"></div>
		</c:when>
		<c:when test='${fn:indexOf(pathData[0], "FACILITY") > -1 }'>
			<div class="sub_visual img_007"></div>
		</c:when>
		<c:when test='${fn:indexOf(pathData[0], "A&amp;C ENT") > -1 }'>
			<div class="sub_visual img_008"></div>
		</c:when>
		<c:when test='${fn:indexOf(pathData[0], "VISIT") > -1 }'>
			<div class="sub_visual img_009"></div>
		</c:when>
		<c:otherwise>
			<div class="sub_visual img_005"></div>
		</c:otherwise>
	</c:choose>
	
</div>
