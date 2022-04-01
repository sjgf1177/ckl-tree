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

<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);
	String menuNo = request.getParameter("menuNo");
	if( StringUtils.hasText(menuNo) ) {

		org.springframework.context.ApplicationContext context =
		org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
		MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");

		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute("menuAll3");
		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
		pageContext.setAttribute("currMenu", currentVo);

		String position = currentVo.getPosition();
		int depth01 = Integer.parseInt(position.substring(0,2)) -1;
		int depth02 = Integer.parseInt(position.substring(2,4)) -1;
		int depth03 = Integer.parseInt(position.substring(4,6)) -1;
		int depth04 = Integer.parseInt(position.substring(6,8)) -1;
		int depth05 = Integer.parseInt(position.substring(8,10)) -1;
		int depth06 = Integer.parseInt(position.substring(10,12)) -1;
		pageContext.setAttribute("depth01", depth01);
		pageContext.setAttribute("depth02", depth02);
		pageContext.setAttribute("depth03", depth03);
		pageContext.setAttribute("depth04", depth04);
		pageContext.setAttribute("depth05", depth05);
		pageContext.setAttribute("depth06", depth06);
	}
%>
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

$(function() {
	<sec:authorize ifAnyGranted="ROLE_USER">
	$('.loginIng').show();
	</sec:authorize>


	$(".logoutBtn").click(function() {

		$.get("/ckl/member/logout.json",function(data) {
			location.href="${ssoDomain}/sso/member/logoutSSO.do?service=ckl";
		},"json");
		return false;
     });

});
//]]>
</script>

	<form name="logoutForm" id="logoutForm" method="post" target="ssoAuthFrame"></form>
	<div id="header">
		<div class="gnbSet">
			<div class="logo"><a href="/ckleng/main/main.do"> <img src="/ckl/images/main/logo.gif" alt="콘텐츠코리아랩 CI"> </a></div>
			<div id="gnb">
				<div id="gnbbg"></div>
				<c:set var="topCategories" value="${menuAll3['menu_0']}" />
				<ul>
					<c:forEach var="x" begin="0" end="6">
						<li id="gnb${x+1}" ${x eq depth01 ? 'class="on"' : ''}><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
						<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
						<c:if test="${fn:length(d02Categories)>0}">
						<ul>
							<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
							</c:forEach>
						</ul>
						</c:if>
					</li>
					</c:forEach>
				</ul>
			</div>

			<div class="globalSet">


				<c:import url="/ckl/fcltyResve/fclty/listForLayout.do">
					<c:param name="viewType" value="CONTBODY" />
				</c:import>

				<a href="#self" class="closePopup"> <img src="/ckl/images/main/closePopup_on.gif" width="62" height="60" alt="닫기"> </a>
				<a href="#self" class="closePopupOpen"> <img src="/ckl/images/main/closePopup_off.gif" width="62" height="60" alt="닫기"> </a>

				<!-- search -->
				<a href="javascript:void(0);" class="OpenSch"> <img src="/ckl/images/main/OpenSch.png" width="61" height="60" alt="검색창 열기"> </a>
				<a href="javascript:void(0);" class="closeSch"> <img src="/ckl/images/main/closeSch.gif" width="61" height="60" alt="검색창 닫기"> </a>
				<div class="shSet">
					<form name="frmSearch2" method="post" action="/ckl/search/list.do?menuNo=200061" onsubmit="return search2(this);">
						<fieldset>
							<legend>검색창 입력양식</legend>
							<input type="text" class="schWd" name="q" id="q2" value="" title="검색어를 입력하세요." />
							<input type="image" class="schGo" src="/ckl/images/common/schGo.png" alt="검색 확인" title="검색 확인"  />
						</fieldset>
					</form>
				</div>
				<!-- //search -->

				<a href="#self" onclick="alert('준비중입니다.')" class=""> <img src="/ckl/images/main/gEng.png" width="61" height="60" alt="eng"> </a>


				<!-- login -->


				<sec:authorize ifNotGranted="ROLE_USER">

				<!-- outLogin -->
				<a href="#self" class="openLogin"> <img src="/ckl/images/main/openLogin.png" width="100" height="60" alt="회원로그인 열기"> </a>
				<iframe src="<c:out value="${ssoDomain }" />/sso/member/incForLoginSSO.do?service=ckl" class="loginS outLoginSet" title="본 프레임은 회원가입 로그인 정보를 제공합니다." style="border:none;height:330px;width:200px"></iframe>


				<a href="#self" class="closeLogin"> <img src="/ckl/images/main/closeLogin.png" width="100" height="60" alt="회원로그인 닫기"> </a>
				</sec:authorize>


				<sec:authorize ifAnyGranted="ROLE_USER">
				<!-- loginInfo -->
				<a href="#self" class="loginIng"> <img src="/ckl/images/main/loginIng.png" width="100" height="60" alt="로그인 중"> </a>
				<!-- outLogin -->
				<div class="loginS login3">
					<div class="outLogin">
						<p class="fs13"><strong class="text-danger"><c:out value="${userVO.userNm }"/></strong>님<br />로그인중입니다.</p>

						<div class="tar mt10 mb10">
							<a href="/ckl/userMember/forUpdate.do?menuNo=200033" class="uline btn-xs fs12 bbLine"><span class="ico icoBtns icoEdu"></span> 내 정보 수정</a>
						</div>

						<div class="icoBox w100p">
							<a href="/ckl/member/logout.do" class="btn w100p btn-danger logoutBtn">로그아웃</a>
						</div>
						<div class="mt20">
							<a href="/ckl/fcltyResve/resveSttus/listMypage.do?menuNo=200037" class="btn w100p mb3">예약신청현황</a>
							<a href="/ckl/progrm/applcnt/listMypage.do?menuNo=200042" class="btn w100p">프로그램 신청/접수</a>
						</div>
					</div>
				</div>
				<!-- //outLogin -->
				<a href="#self" class="login3Close"> <img src="/ckl/images/main/closeLogin.png" width="100" height="60" alt="닫기"> </a>
				<!-- //login -->

				</sec:authorize>



				<!--
				<sec:authorize ifAnyGranted="ROLE_USER">
					<li><a href="/ckl/member/logout.do">로그아웃</a></li>
				</sec:authorize>
				<sec:authorize ifNotGranted="ROLE_USER">
					<li><a href="/portal/member/join02.do?menuNo=200028">회원가입</a></li>
				</sec:authorize>
				 -->

			</div>
		</div>
	</div>
