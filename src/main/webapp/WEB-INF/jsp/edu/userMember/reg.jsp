<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${result.brthdy }" var="brthdy" pattern="yyyy-MM-dd"/>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">

	var mberSe = "<c:out value='${result.mberSe}'/>";
	var authSeVal = "<c:out value='${result.authSe}'/>";
	var codeIdVal = "<c:out value='${codeId0}'/>";
	var sidoVal = "<c:out value='${result.sido}'/>";
	var gugunVal = "<c:out value='${result.gugun}'/>";
	var authEmailAt = "<c:out value='${result.authEmailAt}'/>";

	$(function(){

		if (sidoVal != "") getCodeList("gugun", 'COM063', $("#sido").val(), 2, gugunVal);

		$("select[name=sido]").change(function(){
			var val = $(this).val();
			getCodeList("gugun", 'COM063', val, 2);
		});

		if ($(':radio[name="resdncSe"]:checked').val() == "02") {
			$("#sido").hide();
			$("#gugun").hide();
			$("#resdncOvsea").show();
		}
		else {
			$("#sido").show();
			$("#gugun").show();
			$("#resdncOvsea").hide();
		}

		$("input[name=resdncSe]").click(function(){
			var val = $(this).val();
			if (val == "02") {
				$("#sido").hide();
				$("#gugun").hide();
				$("#resdncOvsea").show();
			}
			else {
				$("#sido").show();
				$("#gugun").show();
				$("#resdncOvsea").hide();
			}
		});

		crtfcPopup = function(authSe) { // 이메일/휴대폰 인증 팝업창
			var val = "";
			var email = $("#email1").val()+"@"+$("#email2").val();
			var mbtlnum = $("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val();
			var height = "343";

			if (authSe == "01") {
			 	if (!checkEmailFc()) {
					$("#email1").focus();
					return;
				}
				val = email;
				//location.reload();
			}
			else {
			 	if (!checkMbtlnumFc()) {
					$("#mbtlnum1").focus();
					return;
				}
				val = mbtlnum;
				height = "463";
			}

			window.open("/edu/userMember/crtfcPopup.do?viewType=BODY&authSe="+authSe+"&val="+val+"&mode=FU&authSeVal="+authSeVal, "crtfcPopup", "top=300, left=600, width=568, height="+height+", status=yes, resizable=yes, scrollbars=no");
		};

		$("#emailAuthDel").click(function(){
			if (!confirm("이메일인증을 삭제하시겠습니까?")) {
				return;
			}
			if (authSeVal == "03") {
				authSeVal = "02";
			}
			else {
				authSeVal = "";
			}
			$.post(
				"/edu/userMember/authSeChange.json",
				{authSe : authSeVal, userSn : "<c:out value='${result.userSn}'/>", authEmailAt : 'N'},
				function(data)
				{
					if (data.resultCode == "success") {
						alert("삭제되었습니다.");
						location.reload();
					}
				},"json"
			);
		});

		$("#mbtlnumAuthDel").click(function(){
			if (!confirm("휴대폰인증을 삭제하시겠습니까?")) {
				return;
			}
			if (authSeVal == "03") {
				authSe = "01";
			}
			else {
				authSe = "";
			}
			$.post(
				"/edu/userMember/authSeChange.json",
				{authSe : authSe, userSn : "<c:out value='${result.userSn}'/>"},
				function(data)
				{
					if (data.resultCode == "success") {
						alert("삭제되었습니다.");
						location.reload();
					}
				},"json"
			);
		});

		if (authSeVal == "02" || authSeVal == "03") {
			if (authSeVal == "03") {
				if (authEmailAt == "N") {
					$("#mbtlnum1").attr('disabled', false);
					$("#mbtlnum2").attr('disabled', false);
					$("#mbtlnum3").attr('disabled', false);
				}
			}
			else {
				$("#mbtlnum1").attr('disabled', true);
				$("#mbtlnum2").attr('disabled', true);
				$("#mbtlnum3").attr('disabled', true);
				$("#mbtlnum").val("<c:out value='${result.mbtlnum}'/>");
			}
		}
		else {
			$("#mbtlnum1").attr('disabled', false);
			$("#mbtlnum2").attr('disabled', false);
			$("#mbtlnum3").attr('disabled', false);
		}

		authDel = function() { // 휴대폰 인증 삭제
			$("#mbtlnumAuthAt").val("");
			$("#mbtlnumAuth").show();
			$("#mbtlnumAuthCmt").hide();
			$("#mbtlnumAuthDel").hide();
			$("#mbtlnum1").attr('disabled', false);
			$("#mbtlnum2").attr('disabled', false);
			$("#mbtlnum3").attr('disabled', false);
			$("#mbtlnum").val("");
			if ($("#emailAuthAt").val() == "Y") { // 이메일인증 확인
				$("#authSe").val("01");
			}
			else {
				$("#authSe").val("");
			}
		};

		/* 14세 이상 회원 전환 */
		$("#chgMemTpBtn").click(function() {

			if (confirm("14세 이상 회원으로 전환하시겠습니까?")) {
				var url = "/edu/userMember/updateParntsAgreChange.json";
				var params = {};
				$.post(url, params, function(data) {
					if (data.resultCode == "success") {
						alert("14세 이상 회원으로 전환되었습니다.");
						$("#parntsAgreDiv").remove();
					}
					else {
						alert("14세 이상 회원으로 전환이 실패했습니다.");
					}
				},"json");
			}
			return false;
		});

	});

	//공통 코드목록 화면처리
	function getCodeList(elemntId, codeId, upperCode, depth, code) {
		var $obj = $("#"+ elemntId);
		var url = "/cmmn/cmmncode/codeListJson.do";
		var params = {
			codeId : codeId,
			upperCode : upperCode
		};
		$.get(url, params, function(data) {
			if (data) {
				$obj.empty();
				$("<option>").text("분류 선택").attr("value","").appendTo($obj);
				$.each(data.list, function(key,item) {
					var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
					if (code == item.code) $codeItem.attr("selected",true);
					$codeItem.appendTo($obj);
				});
				if ("gugun" == elemntId && "" == upperCode) {
					$("<option>").text("분류 선택").attr("value","").appendTo($("#gugun").empty());
				}
			}
		},"json");
	}

	function checkEmailFc() {
		$.ajaxSetup({
			async: true
		});
		if (checkEmail()) {
			var flag = true;

			$.ajaxSetup({
				async: false
			});
			$.post(
				"/edu/member/checkDupEmail.json",
				{email : $("#email1").val()+"@"+$("#email2").val(), userSn : "<c:out value='${result.userSn}'/>"},
				function(data)
				{
					if (data.resultCode == "success") {
						if (data.emailCnt > 0) {
							alert("사용 불가능한 이메일입니다.");
							$("#email1").val("");
							$("#email2").val("");
							flag = false;
						}
					}
				},"json"
			);
		}
		else {
			flag = false;
		}

		if (flag == true) {
		    return flag;
		}
		else {
		    return flag;
		}
	}

	function checkEmail() {
		var form = $("#agreeForm")[0];
		var v = new MiyaValidator(form);

		v.add("email1", {
	        required: true,
			span: 2,
	       	glue: "@",
	       	option: "email"
	    });

	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
			return false;
	    }
		return true;
	}

	function checkMbtlnumFc() {
		$.ajaxSetup({
			async: true
		});
		if (checkMbtlnum()) {
			var flag = true;

			$.ajaxSetup({
				async: false
			});
			$.post(
				"/edu/member/checkDupMbtlnum.json",
				{mbtlnum : $("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val(), userSn : "<c:out value='${result.userSn}'/>"},
				function(data)
				{
					if (data.resultCode == "success") {
						if (data.mbtlnumCnt > 0) {
							alert("사용 불가능한 핸드폰번호입니다.");
							$("#mbtlnum1").val("");
							$("#mbtlnum2").val("");
							$("#mbtlnum3").val("");
							flag = false;
						}
					}
				},"json"
			);
		}
		else {
			flag = false;
		}

		if (flag == true) {
		    return flag;
		}
		else {
		    return flag;
		}
	}

	function checkMbtlnum() {
		var form = $("#agreeForm")[0];
		var v = new MiyaValidator(form);

	if (authSeVal == "01") {
		v.add("mbtlnum1", {
			required : true,
			span : 3,
			glue : "-",
			option : "handphone"
		});
	}

	    var result = v.validate();
	    if (!result) {
	        alert(v.getErrorMessage());
	        v.getErrorElement().focus();
			return false;
	    }
		return true;
	}

	function checkForm() {
		var form = $("#agreeForm")[0];
		var v = new MiyaValidator(form);

	 	if (!checkEmailFc()) {
			$("#email1").focus();
			return;
		}

	 	if (!checkMbtlnumFc()) {
			$("#mbtlnum1").focus();
			return;
		}

		if (authSeVal == "") {
			alert("이메일, 휴대폰 1개이상 인증해야 합니다.");
			return;
		}

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm("수정하시겠습니까?")) {
			return;
		}

		form.submit();
	}

	function check_txt(value) {
	    if (isNaN(value)) {
			alert("숫자로만 입력하셔야 합니다.");
			return "";
		}
	    else {
	    	return value;
	    }
	}

</script>

<fieldset>
	<legend>회원정보 수정 입력</legend>
	<form method="post" name="agreeForm" id="agreeForm" action="/edu/userMember/update.do" >
	<input type="hidden" name="userSn" id="userSn" value="<c:out value='${result.userSn}'/>"/>
	<input type="hidden" name="userId" id="userId" value="${result.userId}"/>
	<input type="hidden" name="userNm" value="<c:out value='${result.userNm}'/>"/>
	<input type="hidden" name="brthdy" value="<c:out value='${brthdy}'/>"/>
	<input type="hidden" name="sex" value="<c:out value='${result.sex}'/>"/>
	<input type="hidden" name="menuNo" value="<c:out value='${paramVO.menuNo}'/>"/>
		<div>
			<p class="sub_board_title">인적사항</p>
			<div class="bdView sub_board_body">
				<table class="contents_insight_view">
					<caption>인적사항</caption>
					<colgroup>
					<col style="width:20%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">이름</th>
							<td><c:out value="${result.userNm}"/></td>
						</tr>
						<tr>
							<th scope="row">생년월일 / 성별</th>
							<td><c:out value="${brthdy}"/> / <c:out value="${result.sex eq 'M' ? '남자' : '여자'}"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<c:if test="${result.parntsAgreAt eq 'Y' }">
		<div id="parntsAgreDiv">
			<h3>14세미만 회원에 대한 보호자 정보</h3>
			<div class="bdView sub_board_body">
				<table class="contents_insight_view">
					<caption>14세미만 회원에 대한 보호자 정보</caption>
					<colgroup>
					<col style="width:20%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">보호자 이름</th>
							<td><c:out value="${result.parntsNm}" /></td>
						</tr>
						<tr>
							<th scope="row">보호자 휴대폰 번호</th>
							<td><span class="db fs2"><c:out value="${result.parntsMbtlnum}" /></span>
								<ul class="bull">
									<li>14세 이상이 되신 경우에는 “14세이상 회원으로 전환” 버튼을 클릭하시면 14세 이상 회원으로 변경되고, 보호자 정보는 삭제합니다.</li>
									<li>전환 하시게 되면 개인정보처리방침에 대한 재동의를 오늘 날짜 기준으로 재설정됩니다</li>
								</ul>
								<a href="javascript:void(0);" id="chgMemTpBtn" class="btn btn-sm btn-default">14세 이상회원으로 전환</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		</c:if>

		<div>
			<p class="sub_board_title">로그인 정보</p>
			<div class="bdView sub_board_body">
				<table class="contents_insight_view">
					<caption>로그인 정보</caption>

					<colgroup>
					<col style="width:20%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">아이디</th>
							<td><c:out value="${result.userId}"/></td>
						</tr>
						<%-- <tr>
							<th scope="row">SNS 인증</th>
							<td>
								<c:out value="${result.authSeNm}"/> <c:out value="${result.authDt}"/> 인증
								<a href="javascript:snsAuthDel();" onclick="return confirm('인증삭제를 하시겠습니까?');" class="btn btn-danger btn-sm" >인증삭제</a>
							</td>
						</tr> --%>
					</tbody>
				</table>
			</div>
		</div>

		<div>
			<p class="sub_board_title">회원 정보 추가 입력</p>
			<p class="sub_board_subtitle">필수항목</p>
			<div class="tbrinfo text-danger clear hide_star_con"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView sub_board_body">
				<table class="contents_insight_view type_1">
					<caption>회원 정보 추가 입력</caption>
					<colgroup>
					<col style="width:20%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="email1" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이메일</label></th>
							<td>
								<c:set var="data" value="${fn:split(result.email,'@')}" />
									<span class="input_style_1_con">
										<input name="email1" id="email1" type="text" title="이메일 아이디" value="${data[0]}" class="input_style_1"/>
									</span>
									@
									<span class="input_style_1_con">
										<input name="email2" id="email2" type="text" title="이메일 주소" value="${data[1]}" readonly="readonly" class="emaildomain_form input_style_1"/>
									</span>
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
										$('select.select_email_js').change(function() {
											if ($(this).val()=='emaildomain_false') {
												$('.emaildomain_form:text[name=email2]').val('');
												$('.emaildomain_form').attr('readonly',false).focus();
											}else{
												$('.emaildomain_form:text[name=email2]').val('');
												$('.emaildomain_form:text[name=email2]').val($(this).val());
												$('.emaildomain_form').attr('readonly',true);
											}
										});
									});
									//]]>
									</script>
									<c:choose>
										<c:when test="${result.authEmailAt eq 'Y'}">
										<div class="show board_util_btn_con">
											<a href="#self" class="btn_style_0 small blue" id="emailAuthCmt" style="margin-right:5px;">인증완료</a>
											<a href="#self" class="btn_style_0 small gray" id="emailAuthDel">인증삭제</a>
										</div>
										</c:when>
										<c:otherwise>
										<div class="show board_util_btn_con">
											<a href="javascript:crtfcPopup('01');" class="btn_style_0 small blue">인증하기</a>
										</di>
										</c:otherwise>
									</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="red_star_text"><span class="sr-only" style="display:none;">(필수입력)</span></span> 휴대폰</th>
							<td>
								<c:set var="data" value="${fn:split(result.mbtlnum,'-')}" />
								<select name="mbtlnum1" id="mbtlnum1" title="(필수입력) 휴대폰번호" class="input_select" >
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
									<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
									<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
									<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
									<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
									<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
								</select>
								-
								<span class="input_style_1_con" style="display:inline">
									<input type="text" id="mbtlnum2" name="mbtlnum2" value="${data[1]}" class="input_style_1" title="휴대폰 중간자리" maxlength="4" onkeyup="this.value=check_txt(this.value)" style="width:25%; min-width:80px;"/>
								</span>
								-
								<span class="input_style_1_con" style="display:inline">
									<input type="text" id="mbtlnum3" name="mbtlnum3" value="${data[2]}" class="input_style_1" title="휴대폰 끝자리" maxlength="4" onkeyup="this.value=check_txt(this.value)" style="width:25%; min-width:80px"/>
								</span>

								<c:choose>
									<c:when test="${result.authSe eq '02' or result.authSe eq '03' }">
										<input type="hidden" name="mbtlnum" id="mbtlnum" value="<c:out value="${result.mbtlnum}"/>"/>
										<div class="show board_util_btn_con">
											<a href="#self" class="btn_style_0 small blue" id="mbtlnumAuthCmt" style="margin-right:5px;">인증완료</a> 
											<a href="#self" class="btn_style_0 small gray" id="mbtlnumAuthDel">인증삭제</a>
										</div>
									</c:when>
									<c:otherwise>
										<div class="show board_util_btn_con">
											<a href="javascript:crtfcPopup('02');" class="btn_style_0 small blue" id="mbtlnumAuth">인증하기</a>
										</div>
									</c:otherwise>
								</c:choose>

							</td>
						</tr>
						<tr>
							<th scope="row"><span class="red_star_text"><span class="sr-only" style="display:none;">(필수입력)</span></span> <b>인재캠퍼스</b> 정보수신 여부</th>
							<td>서비스 및 이벤트 소식을<br>
								<span class="radio_box_con">
									<input type="radio" name="emailAt" value="Y" id="emailAt1" class="radio_style_0" <c:if test="${result.emailAt eq 'Y' }">checked="checked"</c:if>>
									<label for="emailAt1">Email로 수신하겠습니다.</label>
								</span>
								<span class="radio_box_con">
									<input type="radio" name="emailAt" value="N" id="emailAt2" class="radio_style_0" <c:if test="${result.emailAt eq 'N' }">checked="checked"</c:if>>
									<label for="emailAt2">Email로 수신하지 않겠습니다.</label><br>
								</span>
								<span class="radio_box_con">
									<input type="radio" name="smsAt" value="Y" id="smsAt1" class="radio_style_0" <c:if test="${result.smsAt eq 'Y' }">checked="checked"</c:if>>
									<label for="smsAt1">SMS로 수신하겠습니다.</label>
								</span>
								<span class="radio_box_con">
									<input type="radio" name="smsAt" value="N" id="smsAt2" class="radio_style_0" <c:if test="${result.smsAt eq 'N' }">checked="checked"</c:if>>
									<label for="smsAt2">SMS로 수신하지 않겠습니다.</label>
								</span>
								<p class="table_text text-default">※ 수신을 거부하셔도 “비밀번호 찾기” 등의 메일은 자동 발송됩니다.</p>
							</td>
						</tr>
						<tr><!-- 콘텐츠문화광장 -->
							<th scope="row"><span class="red_star_text"><span class="sr-only" style="display:none;">(필수입력)</span></span> <b>콘텐츠문화광장</b> 정보수신 여부</th>
							<td>서비스 및 이벤트 소식을<br>
								<span class="radio_box_con">
									<input type="radio" name="concertEmailAt" value="Y" id="concertEmailAt1" class="radio_style_0" <c:if test="${resultTestbed.concertEmailAt eq 'Y' }">checked="checked"</c:if>>
									<label for="concertEmailAt1">Email로 수신하겠습니다.</label>
								</span>
								<span class="radio_box_con">                                                                                    
									<input type="radio" name="concertEmailAt" value="N" id="concertEmailAt2" class="radio_style_0" <c:if test="${resultTestbed.concertEmailAt ne 'Y' }">checked="checked"</c:if>>
									<label for="concertEmailAt2">Email로 수신하지 않겠습니다.</label><br>
								</span>
								<span class="radio_box_con">
									<input type="radio" name="concertSmsAt" value="Y" id="concertSmsAt1" class="radio_style_0" <c:if test="${resultTestbed.concertSmsAt eq 'Y' }">checked="checked"</c:if>>
									<label for="concertSmsAt1">SMS로 수신하겠습니다.</label>
								</span>
								<span class="radio_box_con">
									<input type="radio" name="concertSmsAt" value="N" id="concertSmsAt2" class="radio_style_0" <c:if test="${resultTestbed.concertSmsAt ne 'Y' }">checked="checked"</c:if>>
									<label for="concertSmsAt2">SMS로 수신하지 않겠습니다.</label>
								</span>
								<p class="table_text text-default">※ 수신을 거부하셔도 “비밀번호 찾기” 등의 메일은 자동 발송됩니다.</p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div>
			<p class="sub_board_subtitle">선택항목</p>
			<div class="bdView">
				<table class="contents_insight_view">
					<caption>선택항목 입력</caption>
					<colgroup>
					<col style="width:20%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">거주지</th>
							<td>
								<span class="radio_box_con">
									<input type="radio" name="resdncSe" value="01" id="resdncSe1" class="radio_style_0" <c:if test="${result.resdncSe eq '01'}">checked="checked"</c:if>><label for="resdncSe1"> 국내 </label>
								</span>
								<span class="radio_box_con">
									<input type="radio" name="resdncSe" value="02" id="resdncSe2" class="radio_style_0" <c:if test="${result.resdncSe eq '02'}">checked="checked"</c:if>><label for="resdncSe2"> 해외 </label>
								</span>
								<select name="sido" id="sido" title="시도를 선택해 주세요.">
									<option value="">시도 선택</option>
									<c:forEach var="item" items="${COM063CodeList}">
										<option value="<c:out value="${item.code}" />" <c:if test="${result.sido eq item.code}">selected="selected"</c:if>><c:out value="${item.codeNm}" /></option>
									</c:forEach>
								</select>
								<select name="gugun" id="gugun" title="구군을 선택해 주세요.">
									<option value="">구군 선택</option>
								</select>
								<input type="text" class="input_style_3" name="resdncOvsea" id="resdncOvsea" value="<c:out value="${result.resdncOvsea}"/>" title="해외인 경우 입력해주세요.">
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="job">직업</label></th>
							<td>
								<select name="job" id="job" title="직업을 선택해 주세요.">
									<option value="">선택</option>
									<c:forEach var="code" items="${COM056CodeList}" varStatus="status">
										<option value="${code.code}" <c:if test="${result.job eq code.code}">selected="selected"</c:if>><c:out value="${code.codeNm}"/></option>
									 </c:forEach>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

			<!-- <div class="col-md-6">
				<a href="javascript:void(0);" class="fl btn btn-gray btnIcPrev">이전</a>
			</div> -->
		<div class="board_util_btn_con">
			<a class="btn_style_0 full check" href="javascript:checkForm();">저장</a>
		</div>



	</form>
</fieldset>
