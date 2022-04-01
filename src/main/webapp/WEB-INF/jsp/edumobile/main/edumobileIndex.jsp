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


%>
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="<%= Globals.OS_TYPE %>" />
<c:set var="serverName" value="<%= request.getServerName() %>" />
<c:set var="list" value="${fn:contains(includePage, 'list')}" />
<c:set var="read" value="${fn:contains(includePage, 'read')}" />
<c:set var="reg" value="${fn:contains(includePage, 'reg')}" />
<c:set var="view" value="${fn:contains(includePage, 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<c:set var="pathData0" value="${pathData[0]}" />
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

<c:set var="topCategories" value="${menuAll6['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="curD01" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll6[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll6[curD03menuKey]}" />

<c:set var="depthMenuNm" value="${pathData[0] }" />
<%
String pathData0 = (String)pageContext.getAttribute("pathData0") != null ? (String)pageContext.getAttribute("pathData0") : "" ;

if ( "콘텐츠문화광장".indexOf(pathData0) != -1 ){
	%>
	<jsp:include page="/WEB-INF/jsp/edumobile/main/testbedmobileIndex.jsp" flush="true" />
	<%
} else {
	
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="title" content="${fn:replace(title, '"', '˝')}" />
<meta name="type" content="website" />
<c:set var="title" value="${title} 한국콘텐츠아카데미" />
<title>${title}</title>
<%-- <jsp:include page="/WEB-INF/jsp/edumobile/inc/edumobileHead.jsp" flush="true" /> --%>
<jsp:include page="/WEB-INF/jsp/edu/inc/eduSubMainHead.jsp" flush="true" />
</head>

<body>
<div class="wrapper sub_layout_page">

	<!-- header -->
	<div class="col-12 header_wrap bg_main_blue">
	    <div class="col-12 col-center mw-1200 over-visible header_inner">
	    	<div class="col-12 pr15 pl15">
	    		<div class="col-12 header_con">
	    			<div class="col-12 col-center mw-1200 over-visible">
	    				<div class="col-12 pr15 pl15">
	   						 <div class="col-12 pt27 pb22 header_section">
							    <h1 class="show logo_con">
								    <a href="/edumobile/main/main.do" class="show">
								    	<img src="/edu/new_image/w_logo.png" alt="한국 콘텐츠인재캠퍼스 (한국콘텐츠아카데미) 로고">
								    </a>
							    </h1>
	    						<div class="over-md-hidden tr gnb_wrap">
	    							<c:set var="topCategories" value="${menuAll6['menu_0']}" />
								    <ul class="fontsize0 gnb_con">
									<c:set var="d02MenuNm" value="${pathData[0] }" />
									<c:forEach var="x" begin="0" end="4"> 
										<c:if test="${topCategories[x].menuNo eq curD01.menuNo}">
											<c:set var="depthMenuNm" value="${topCategories[x].menuNm}" />
										</c:if>
										
										<li class="tms${x+1} ${topCategories[x].menuNo eq curD01.menuNo ? 'on' : ''}"><a href="javascript:void(0);" tabindex="3">${topCategories[x].menuNm}</a>
											<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
											<c:set var="d02Categories" value="${menuAll6[d02MenuKey]}" />
											<c:set var="curD02" value="${curD02Categories[depth02]}" />
											<c:if test="${fn:length(d02Categories)>0}">
											<ul>
												<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
													<li ${d02Categories[y].menuNo eq curD02.menuNo ? 'class="on"' : ''}><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"' : ''} tabindex="3">${d02Categories[y].menuNm}</a>
													<c:set var="d03MenuKey" value="menu_${d02Categories[y].menuNo}" />
													<c:set var="d03Categories" value="${menuAll6[d03MenuKey]}" />
													<c:set var="curD03" value="${curD03Categories[depth03]}" />
													<c:if test="${fn:length(d03Categories)>0}">
													<ul class="gnbD3">
														<c:forEach var="z" begin="0" end="${fn:length(d03Categories)-1}">
														<c:if test="${d03Categories[z].menuNo ne '600033' && d03Categories[z].menuNo ne '600034'}">
															<li data-menuNo='${d03Categories[z].menuNo}' data-currMenuNo='${curD03.menuNo}'  ${d03Categories[z].menuNo eq curD03.menuNo ? 'class="on"' : ''}>
																<a href="${d03Categories[z].fullMenuLink}" ${d03Categories[z].menuPopupYn eq 'Y' ? 'target="_blank"  title="새 탭으로 열림"' : ''} tabindex="3">${d03Categories[z].menuNm}</a>
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
			    <!-- <div class="col-12 gnb_dim" style="opacity:1;"></div> -->
			    <div class="col-12 search_dim"></div>
		    </div>
	    </div>
	    <div class="col-12 gnb_menu_dim" ></div>
		<div class="col-12 gnb_all_menu_dim" style="height: 0px;"></div>
	</div>
	<!-- //header -->
	
	<c:set var="h4MenuNm" value="${curD02.menuNm}" />
	<c:if test="${fn:length(curD03Categories)>0}">
		<c:set var="h4MenuNm" value="${curD03.menuNm}" />
	</c:if> 
	
	<!-- content -->
	<div class="col-12 sub_contents_wrap">
		<div class="col-12 col-center mw-1200 over-visible">
			<div class="col-12 pr15 pl15">
<!-- 				<div class="col-12 col-md-0 fn-md over-hidden sub_contents printPage" id=subContainer"> -->
				<div class="col-12 col-md-0 fn-md over-hidden printPage" id=subContainer" style="padding-top:47px; padding-bottom: 100px;">
					<div class="col-12 sub_section">
						<div class="over-hidden sub_contents_header">
							<h4 class="fl">${h4MenuNm}</h4>
						</div>
						<div class="sub_contents_body">
							<!-- contentDB -->
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
							<!-- //contentDB -->
						</div>
					</div>
				
				</div>
			</div>
		</div>
	</div>
	<!-- //content -->

	<!-- footer -->
    <jsp:include page="/WEB-INF/jsp/edumobile/inc/edumobileFooter.jsp" flush="true">
    	<jsp:param name="menuNm" value="${pathData[0]}"></jsp:param>
    </jsp:include> 
    <!-- //footer -->

</div>
</body>
</html>

<%
}
%>