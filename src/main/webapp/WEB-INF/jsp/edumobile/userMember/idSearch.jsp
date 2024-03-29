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


<c:set var="siteNm" value="${paramVO.service}"/>
<%
	String domain = request.getServerName();
	session.setAttribute("ssoDomain2", domain);
	
	String requestUri = request.getRequestURL().toString();
	String host = request.getRemoteHost();

	String menuNo = request.getParameter("menuNo");
	String siteNm = (String)pageContext.getAttribute("siteNm");  

	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.EDUMOBILE_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);
	org.springframework.context.ApplicationContext context =
			org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);
%>
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<c:set var="pathData0" value="${pathData[0]}" />
<c:choose>
	<c:when test="${fn:indexOf(pathData0 , '콘텐츠문화광장') != -1 }">
		<c:set var="pwMenuNo" value="600130"/>
	</c:when>
	<c:otherwise>
		<c:set var="pwMenuNo" value="600144"/>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
//<![CDATA[

$(function(){

	$(".bdList").hide();

	$("#idSearchBtn").click(function(){
		var userNm = $("#userNm").val();
		var email = $("#email1").val()+"@"+$("#email2").val();
		var mbtlnum = $("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val();
		var returnTp = $(':radio[name="returnTp"]:checked').val();



		if (userNm == "") {
			alert("이름을 입력해 주세요.");
			$("#userNm").focus();
			return;
		}
		if (returnTp == "1") {
			if ($("#email1").val() == "" || $("#email2").val() == "") {
				alert("이메일을 입력해 주세요.");
				$("#email1").focus();
				return;
			}
		}
		else if (returnTp == "2") {
			if ($("#mbtlnum1").val() == "" || $("#mbtlnum2").val() == "" || $("#mbtlnum3").val() == "") {
				alert("휴대폰을 입력해 주세요.");
				$("#mbtlnum1").focus();
				return;
			}
		}

		$.post(
			"/edumobile/userMember/idSearchRequest.json",
			{userNm : userNm, email : email, mbtlnum : mbtlnum, returnTp: returnTp, mode : "m"},
			function(data) {
				var html = "";
				if (data.resultCode == "success") {
					$.each(data.idList, function(i, item) {
						html += getIdListHtml(item.rnum, item.userId, item.sbscrbDt);
					});
				}
				else {
					html = '<p class="tc find_user_join_time">해당 정보로 조회된 아이디가 없습니다.</p>';
				}
				$(".bdList").show();
				$("#findId").show();
				$("#idList").html(html);
			},"json"
		);
		return;
	});

	getIdListHtml = function(rnum, userId, sbscrbDt) {
		/* 
		var html =
			'<tr><td>'+rnum+'</td>'+
			'<td>'+userId+'</td>'+
			'<td>'+sbscrbDt+'</td></tr>'; 
		*/
			
		var html = 
			'<hr class="form_seperate_line">'+
			'<p class="tc find_user_id">'+
				'가입하신 아이디는 <span class="user_id_text">'+userId+'</span>입니다.'+
			'</p>'+
			'<p class="tc find_user_join_time">'+
				'가입일시 : '+sbscrbDt+
			'</p>';
		return html;
	};

	$("input[name=returnTp]").click(function() {
		if ($(this).val() == "1") {
			$("#emailDiv").css("display", "inline-block");
			$("#mbtlnumDiv").hide();
		}
		else if ($(this).val() == "2") {
			$("#emailDiv").hide();
			$("#mbtlnumDiv").css("display", "inline-block");
		}
	});

});

function check_txt(value) {
    if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
    else {
    	//return value;
    }
}

//]]>
</script>



<p class="sub_contents_body_title">
    가입 시 입력하신 기본정보를 입력해 주시기 바랍니다.
</p>
<div class="sub_board_body">
    <p class="board_caption">
        <span>
            표시는 필수입력 항목입니다.
        </span>
    </p>
    <div class="search_wrap">
        <form action="#" class="search_pw_form">
            <div class="input_wrap">
                <p class="red_star_text">
                    이름
                </p>
                <div class="input_style_2_con">
                    <input type="text" class="input_style_2" name="userNm" id="userNm" placeholder="이름을 입력해 주세요." />
                    <label for="userNm"></label>
                </div>
            </div>
            
            <div class="input_wrap">
                <p class="red_star_text">
                    휴대폰 또는 이메일
                </p>
                <span class="radio_box_con">
                    <input type="radio" id="returnTp1" name="returnTp" class="radio_style_0" value="1" checked="checked">
                    <label for="returnTp1">이메일</label>
                </span>
                <span class="radio_box_con">
                    <input type="radio" id="returnTp2" name="returnTp" class="radio_style_0" value="2">
                    <label for="returnTp2">휴대폰</label>
                </span>
            </div>
            <div class="input_wrap last">
            	<div id="emailDiv" style="display: inline-block;">
	                <p class="red_star_text">
	                    이메일
	                </p>
	                <div class="input_style_2_con short">
	                    <input type="text" name="email1" id="email1" class="input_style_2" placeholder="abcdefg" title="이메일 아이디" value="">
	                    <label for="email1"></label>
	                </div>
	                <span class="show vm fontsize14">@</span>
	                <div class="input_style_2_con middle">
	                    <input type="text" name="email2" id="email2" class="input_style_2" placeholder="abcdefg" title="이메일 주소" value="">
	                    <label for="email2"></label>
	                </div>
	                <div class="select_style_2_con">
	                    <select name="email_select" id="sr_email_more" class="select_style_2" title="직접입력 선택시 자동활성화&amp;포커스 이동">
	                        <option selected="selected">메일주소선택</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
		                    <option value="hanmail.net">hanmail.net</option>
		                    <option value="daum.net">daum.net</option>
		                    <option value="hotmail.com">hotmail.com</option>
		                    <option value="nate.com">nate.com</option>
		                    <option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="emaildomain_false">직접입력</option>
	                    </select>
	                    <label for="sr_email_more"></label>
	                    <script type="text/javascript">
						//<![CDATA[
						jQuery(function(){
							$('#email2').attr('readonly',true);
							$('select#sr_email_more').change(function() {
								if ($(this).val()=='emaildomain_false') {
									$('#email2').val('');
									$('#email2').attr('readonly',false).focus();
								}
								else {
									$('#email2').val('');
									$('#email2').val($(this).val());
									$('#email2').attr('readonly',true);
								}
							});
						});
						//]]>
						</script>
	                </div>
                </div>
            	<div id="mbtlnumDiv" style="display: none;">
	                <p class="red_star_text">
	                    휴대폰
	                </p>
	                <div class="select_style_2_con">
	                    <select name="mbtlnum1" id="mbtlnum1" title="휴대폰 앞자리" class="select_style_2">
	                        <option value="">선택</option>
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
	                    </select>
	                    <label for="sr_email_more"></label>
	                </div>
	                <span class="search_dash pad_on">
						-
					</span>
					<div class="input_style_2_con short mobile_input">
	                    <input type="text" value="" id="mbtlnum2" name="mbtlnum2" class="input_style_2" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="check_txt(this.value)">
	                    <label for="mbtlnum2"></label>
	                </div>
					<span class="search_dash">
						-
					</span>
					<div class="input_style_2_con middle mobile_input">
	                    <input type="text" value="" id="mbtlnum3" name="mbtlnum3" class="input_style_2" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="check_txt(this.value)">
	                    <label for="mbtlnum3"></label>
	                </div>
					<input type="hidden" name="mbtlnum" id="mbtlnum" />
                </div>
                <span class="btn_style_2_con mobile_btn_style_2_con">
                    <a href="javascript:history.back()" class="btn_style_2 history_back">
                        이전
                    </a>
                    <a href="#self" id="idSearchBtn" class="btn_style_2">
                        확인
                    </a>
                </span>
            </div>
            <div id="findId" style="display: none;">
	           	<div id="idList">
		            <hr class="form_seperate_line">
		            <p class="tc find_user_id">
		                가입하신 아이디는 <span class="user_id_text">Abcdef**</span>입니다.
		            </p>
		            <p class="tc find_user_join_time">
		                가입일시 : <span>2017.06.14 17:30</span>
		            </p>
	            </div>
	            
	            
	            <div class="input_style_1_con submit short">
	            	<a href="/edumobile/userMember/pwdSearch.do?menuNo=${pwMenuNo }" class="input_style_1">비밀번호 찾기</a>
	                <!-- 
	                <input type="submit" class="input_style_1" id="search_pw_submit" name="search_pw_submit">
	                <label for="search_pw_submit">비밀번호 찾기</label>
	                -->
	            </div>
            </div>
        </form>
    </div>
</div>


<%-- 
<h2 class="fs4">가입 시 입력하신 인적사항을 입력해주시기 바랍니다.</h2>
<div>
	<h3>인적사항</h3>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>인적사항 입력</caption>
			<colgroup>
			<col style="width:16%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="userNm"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이름</label></th>
					<td><input type="text" name="userNm" id="userNm" value=""></td>
				</tr>
				<tr>
					<th scope="row">
						<span class="hide_star"><span class="sr-only">(필수입력)</span></span> 휴대폰 또는 이메일
					</th>
					<td>
						<label for="returnTp1"><input type="radio" name="returnTp" value="1" id="returnTp1" checked="checked"> 이메일 </label>
						<label for="returnTp2"><input type="radio" name="returnTp" value="2" id="returnTp2"> 휴대폰 </label>
						<span id="emailDiv">
							<input name="email1" id="email1" class="w20p" type="text" title="이메일 아이디" value="" />
							@
							<input name="email2" id="email2" class="w20p emaildomain_form" type="text" title="이메일 주소" value="" />
							<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
							<select id="sr_email_more" class="input_select select_email_js" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
								<option selected="selected">메일주소선택</option>
								<option value="gmail.com">gmail.com</option>
								<option value="naver.com">naver.com</option>
			                    <option value="hanmail.net">hanmail.net</option>
			                    <option value="daum.net">daum.net</option>
			                    <option value="hotmail.com">hotmail.com</option>
			                    <option value="nate.com">nate.com</option>
			                    <option value="yahoo.co.kr">yahoo.co.kr</option>
								<option value="emaildomain_false">직접입력</option>
							</select>
							<script type="text/javascript">
							//<![CDATA[
							jQuery(function(){
								$('#email2').attr('readonly',true);
								$('select.select_email_js').change(function() {
									if ($(this).val()=='emaildomain_false') {
										$('#email2').val('');
										$('#email2').attr('readonly',false).focus();
									}
									else {
										$('#email2').val('');
										$('#email2').val($(this).val());
										$('#email2').attr('readonly',true);
									}
								});
							});
							//]]>
							</script>
						</span>
						<span id="mbtlnumDiv" style="display:none;">
							<select name="mbtlnum1" id="mbtlnum1" title="휴대폰 앞자리" >
								<option value="">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							-
							<input type="text" value="" id="mbtlnum2" name="mbtlnum2" class="w20p" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="check_txt(this.value)"/>
							-
							<input type="text" value="" id="mbtlnum3" name="mbtlnum3" class="w20p" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="check_txt(this.value)"/>

							<input type="hidden" name="mbtlnum" id="mbtlnum" />
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="btnSet tar">
	<a href="#self" id="idSearchBtn" class="btn btn-info">아이디 찾기</a>
</div>

<div class="bdList" >
<h3>입력하신 정보로 조회된 아이디입니다. </h3>

	<table class="table tac">
		<caption>아이디 목록</caption>
		<colgroup>
		<col style="width:10%;">
		<col>
		<col style="width:20%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">가입일시</th>
			</tr>
		</thead>
		<tbody id="idList"></tbody>
		
			<c:forEach var="val" items="${idList}" varStatus="status">
				<tr>
					<td>1</td>
					<td class="tal"><c:out value="${val.userId}"/></td>
					<td>2015-07-01 14:00</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(idList) == 0}"><tr><td colspan="3">해당 정보로 조회된 아이디가 없습니다.</td></tr></c:if>
		</tbody>
	</table>

<div class="btnSet tar">
	<a href="/edu/userMember/pwdSearch.do?menuNo=500084" class="btn btn-info">비밀번호 찾기</a>
</div>
</div>
 --%>