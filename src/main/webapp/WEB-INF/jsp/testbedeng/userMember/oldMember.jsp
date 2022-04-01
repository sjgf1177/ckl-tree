<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[

    var userIdCnt = "${fn:length(userIdList)}";
    var emailCnt = "${fn:length(emailList)}";
    var mbtlnumCnt = "${fn:length(moblphonList)}";

	$(function(){

		/* if (userIdCnt == 0) {
			$("#liUserId").show();
		}
		else {
			$("#liUserId").hide();
		}

		$("input[name=userIdChk]").click(function(){
			var val = $(this).val();
			if (val == "Y") {
				$("#liUserId").show();
				$("#userId").val("");
			}
			else {
				$("#liUserId").hide();
				$("#userId").val(val);
			}
		}); */

	});

	function checkId(value) {
		checkIdFc();
	    return value;
	}

	function checkIdFc() {
		var flag = true;
		$.ajaxSetup({
			async: true
		});

		if (checkIdVal()) {
			$.ajaxSetup({
				async: false
			});
			var all = "";
			if ($(':radio[name="userIdChk"]:checked').val() == "Y") all = "Y";
			$.post(
				"/testbed/member/checkDupId.json",
				{userId : $("#userId").val(), all : all},
				function(data) {
					if (data.resultCode == "success") {
						if (data.idCnt > 0) {
							flag = false;
						}
						else {
							flag = true;
						}
					}
				},"json"
			);
		}
		else {
			flag = false;
		}

		if (flag == true) {
			$("#id-success").text("사용가능한 아이디입니다.");
			$("#id-danger").text("");
		    return true;
		}
		else {
			$("#id-danger").text("사용 불가능한 아이디입니다.");
			$("#id-success").text("");
		    return false;
		}

	}

	function checkIdVal() {
		var form = $("#frm")[0];
		var v = new MiyaValidator(form);
	    v.add("userId", {
	    	required: true,
	        pattern: "^[a-z0-9]{6,16}$"
	    	//pattern: "^.*(?=.{6,16})(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^*+=-]).*$"
	    });
	    var result = v.validate();
	    if (!result) {
	        v.getErrorElement().focus();
			return false;
	    }
	    return true;
	}

	function checkIdMix(str) {
		var chk_num = str.search(/[0-9]/g);
		var chk_eng = str.search(/[a-z]/ig);
		if (chk_num < 0 || chk_eng < 0) {
	 		return false;
		}
		return true;
	}

	function checkPwd(value) {
		checkPwdFc();
	    return value;
	}

	function checkPwdFc() {
		var flag = true;
		var pwd = $("#password").val();

		if (!checkPwdVal()) {
			flag = false;
		}
		if (!ctnuCheck(pwd)) { //연속성체크
			flag = false;
		}
		if (!qwertyCheck(pwd)) { //키보드상 연속글자 체크
			flag = false;
		};

		if (flag == true) {
			$("#pwd-success").text("사용가능한 비밀번호입니다.");
			$("#pwd-danger").text("");
		    return flag;
		}
		else {
			$("#pwd-danger").text("사용 불가능한 비밀번호입니다.");
			$("#pwd-success").text("");
		    return flag;
		}

	}

	function checkPwdVal() {
		var form = $("#frm")[0];
		var v = new MiyaValidator(form);
	    v.add("password", {
	    	required: true,
	        //pattern: "^([a-zA-Z!@#$%^&*()_+=<>?0-9]{6,16})$",
	    	pattern: "^.*(?=.{6,15})(?=.*[0-9!@#$%^&*()_+=<>?])(?=.*[a-zA-Z]).*$"
	    });
	    var result = v.validate();
	    if (!result) {
	        v.getErrorElement().focus();
			return false;
	    }
	    return true;
	}

	function ctnuCheck(pwdNew) {
	    var SamePass_0 = 0; //동일문자 카운트
	    var SamePass_1 = 0; //연속성(+) 카운트
	    var SamePass_2 = 0; //연속성(-) 카운트

	    var chr_pass_0;
	    var chr_pass_1;
	    var chr_pass_2;

	    for (var i=0; i < pwdNew.length; i++) {
	        chr_pass_0 = pwdNew.charAt(i);
	        chr_pass_1 = pwdNew.charAt(i+1);
	        //동일문자 카운트
	        if (chr_pass_0 == chr_pass_1) {
	            SamePass_0 = SamePass_0 + 1;
	        }
	        chr_pass_2 = pwdNew.charAt(i+2);
	        //연속성(+) 카운드
	        if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
	            SamePass_1 = SamePass_1 + 1;
	        }
	        //연속성(-) 카운드
	        if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
	            SamePass_2 = SamePass_2 + 1;
	        }
	    }
	    if (SamePass_0 > 1) {
	        //alert("동일문자를 3번 이상 사용할 수 없습니다.");
	        return false;
	    }
	    if (SamePass_1 > 1 || SamePass_2 > 1) {
	        //alert("연속된 문자열(111 또는 aaa, 123 또는 abc 등)을\n 3자 이상 사용 할 수 없습니다.");
	        return false;
	    }
	    return true;
	}

	function qwertyCheck(pw) {
		var qwerty = "90-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:ZXCVBNM<>?";
		var start = 4-1; // 연속글자수 - 1
		var seq = "_" + pw.slice(0, start);

		for (i=start; i < pw.length; i++) {
			seq = seq.slice(1) + pw.charAt(i);
			if (qwerty.indexOf(seq) > -1) {
				//alert("키보드상에 나란히 있는 4개의 문자를 연속으로 비밀번호로 사용하실 수 없습니다.");
				return false;
			}
		}
		return true;
	}

	function checkPwd2(value) {
		checkPwd2Fc();
	    return value;
	}

	function checkPwd2Fc() {
		var flag = true;

		if (!checkPwd2Val()) {
			flag = false;
		}

		if (flag == true) {
			$("#pwd2-success").text("비밀번호가 일치합니다.");
			$("#pwd2-danger").text("");
		    return flag;
		}
		else {
			$("#pwd2-danger").text("비밀번호가 일치하지 않습니다.");
			$("#pwd2-success").text("");
		    return flag;
		}

	}

	function checkPwd2Val(){
		var form = $("#frm")[0];
		var v = new MiyaValidator(form);
	    v.add("password2", {
	        match: "password"
	    });
	    var result = v.validate();
	    if (!result) {
	        v.getErrorElement().focus();
			return false;
	    }
	    return true;
	}

	function checkEmailFc() {
		var flag = true;
		$.post(
			"/testbed/member/checkDupEmail.json",
			{email : $(':radio[name="email"]:checked').val()},
			function(data)
			{
				if (data.resultCode == "success") {
					if (data.emailCnt > 0) {
						if (confirm("이미 등록된 이메일입니다. 아이디 찾기 페이지로 이동하시겠습니까?")) {
							location.href = "/testbed/userMember/idSearch.do?menuNo=200057";
						}
						flag = false;
					}
				}
			},"json"
		);
		if (flag == true) {
		    return flag;
		}
		else {
		    return flag;
		}
	}

	function checkMbtlnumFc() {
		var flag = true;
		$.post(
			"/testbed/member/checkDupMbtlnum.json",
			{mbtlnum : $(':radio[name="mbtlnum"]:checked').val()},
			function(data)
			{
				if (data.resultCode == "success") {
					if (data.mbtlnumCnt > 0) {
						if (confirm("이미 등록된 휴대폰번호입니다. 아이디 찾기 페이지로 이동하시겠습니까?")) {
							location.href = "/testbed/userMember/idSearch.do?menuNo=200057";
						}
						flag = false;
					}
				}
			},"json"
		);
		if (flag == true) {
		    return flag;
		}
		else {
		    return flag;
		}
	}

	function checkForm() {
		var form = $("#frm")[0];
		var v = new MiyaValidator(form);

		if ($("#agreAt1:checked").val() != "Y") {
			alert("개인정보 수집 및 이용에 동의해 주세요.");
			$("#agreAt1").focus();
			return;
		}

		if ('${fn:split(userData,'|')[0]}' != "kocca") {
			if (!checkIdFc()) {
				alert("사용 불가능한 아이디입니다.");
				$("#userId").focus();
				return;
			}
		}
		if (!checkPwdFc()) {
			alert("사용 불가능한 비밀번호입니다.");
			$("#password").focus();
			return;
		}
		if (!checkPwd2Fc()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#password2").focus();
			return;
		}

	    v.add("userNm", {
	        required: true
	    });
	    v.add("brthdy", {
	        required: true
	    });
	    v.add("sex", {
	        required: true
	    });
/*
	if ($(':radio[name="email"]:checked').length > 0 ) {
	 	if (!checkEmailFc()) {
			$("#email1").focus();
			return;
		}
	}
	if ($(':radio[name="mbtlnum"]:checked').length > 0 ) {
	 	if (!checkMbtlnumFc()) {
			$("#mbtlnum1").focus();
			return;
		}
	} */

	    v.add("emailAt", {
	        required: true
	    });
	    v.add("smsAt", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm("등록하시겠습니까?")) {
			return;
		}

		form.submit();
	}

//]]>
</script>

	<div>
		<h3 class="mt0">개인정보 수집 및 이용 (필수)</h3>
		<div tabindex="0" class="agreeScr" style="height:170px">
			<ul>
				<li>1. 수집 &middot; 이용 목적 : 에듀코카 회원가입을 위한 사용자 정보 수집 및 이용</li>
				<li>2. 개인정보 수집 항목 :
					<div class="m1 mb0">
						<dl>
							<dd>필수항목 : 아이디, 비밀번호, 이름, 생년월일, 성별, 이메일, 휴대폰, 정보수신 여부</dd>
							<dd>선택항목 : 거주지, 직업</dd>
						</dl>
					</div>
				</li>
				<li>3. 개인정보 보유 및 이용기간 : 회원탈퇴시 까지, 3년 이상 홈페이지에 접속이 없는 경우</li>
				<li>4. 동의 거부 시 불이익에 관한 사항 : 수집 &middot; 이용에 관한 사항의 동의를 거부할 때에는 서비스의 이용이 제한됩니다.   단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.</li>
			</ul>
		</div>
		<div class="agreeScrBtm">
			위 개인정보 수집 및 이용 내용에
				<label for="agreAt1"><input type="radio" name="agreAt" value="Y" id="agreAt1"> 동의합니다. </label>
				<label for="agreAt2"><input type="radio" name="agreAt" value="N" id="agreAt2"> 동의하지 않습니다. </label>
		</div>
	</div>

	<h2 class="mt20 mb0">회원정보 등록</h2>
	<form id="frm" name="frm" method="post" action="/testbed/userMember/insertOldMember.do" >
	<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
	<input type="hidden" name="rm" value='<c:out value="${param.rm}"/>'/>

	<input type="hidden" name="siteSe" value="${data[0]}" />
	<input type="hidden" name="userSn" value="${data[5]}" />
		<fieldset>
			<legend>회원정보 등록</legend>
			<div>
				<h3 class="mt0">로그인 정보</h3>
				<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
				<div class="bdView">
					<table class="table table-bordered">
						<caption>로그인 정보 입력</caption>
						<colgroup>
						<col style="width:17%">
						<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="UID"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 아이디</label></th>
								<td>
									<ul>
										<li id="liUserId">
											<c:if test="${data[0] eq 'kocca'}">
												<input type="text" name="userId" id="userId" value='<c:out value="${data[1]}"/>' readonly="readonly"/>
											</c:if>
											<c:if test="${data[0] ne 'kocca'}">
												<input type="text" name="userId" id="userId" value="" onkeyup="this.value=checkId(this.value)"/>
												<span class="text-success" id="id-success"></span>
												<span class="text-danger" id="id-danger"></span>
												<p class="text-default">※ 6~16자까지 영문자(소문자), 숫자 사용 가능합니다.</p>
											</c:if>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="password"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호</label></th>
								<td>
									<input type="password" name="password" id="password" value="" onkeyup="this.value=checkPwd(this.value)">
									<span class="text-success" id="pwd-success"></span>
									<span class="text-danger" id="pwd-danger"></span>
									<p class="text-default">※ 6~16자까지 영문자(대소문자), 숫자 및 특수문자<!-- (제외 : !, &amp;, #, ?) --> 사용 가능합니다.<br>
										3자리 연속되는 문자는 사용하실 수 없습니다.</p>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="password2"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호 확인</label></th>
								<td>
									<input type="password" name="password2" id="password2" value="" onkeyup="this.value=checkPwd2(this.value)">
									<span class="text-success" id="pwd2-success"></span>
									<span class="text-danger" id="pwd2-danger"></span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div>
				<h3>필수항목</h3>
				<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
				<div class="bdView">
					<table class="table table-bordered">
						<caption>필수항목 입력</caption>
						<colgroup>
						<col style="width:17%">
						<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="userNm"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이름</label></th>
								<td><input type="text" name="userNm" id="userNm" value='<c:out value="${data[2]}"/>'></td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 생년월일
									<span class="hide_star"><span class="sr-only">(필수입력)</span></span> 성별</th>
								<td>
									<div class="calendarzone">
										<div id="startDate-lry" class="calendarSLayer">
											<iframe id="startDate-ifrm" name="startDate-ifrm" class="calendar-frame" src="/testbed/html/incFrCalendar.html" title="시작 날짜입력 프레임" frameborder="0" scrolling="no"></iframe>
										</div>
									</div>
									<input type="text" id="brthdy" name="brthdy" class="sdate" title="생년월일 입력" style="width:130px" value="" readonly="readonly">
									<label for="sex1"><input type="radio" name="sex" value="M" id="sex1" <c:if test="${user.sex eq 'M'}">checked="checked" </c:if>>남자 </label>
									<label for="sex2"><input type="radio" name="sex" value="W" id="sex2" <c:if test="${user.sex eq 'W'}">checked="checked" </c:if>>여자 </label>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 정보수신 여부</th>
								<td>서비스 및 이벤트 소식을<br>

									<label for="emailAt1"><input type="radio" name="emailAt" value="Y" id="emailAt1"> Email로 수신하겠습니다. </label>
									<label for="emailAt2"><input type="radio" name="emailAt" value="N" id="emailAt2" checked="checked"> Email로 수신하지 않겠습니다. </label><br>
									<label for="smsAt1"><input type="radio" name="smsAt" value="Y" id="smsAt1"> SMS로 수신하겠습니다. </label>
									<label for="smsAt2"><input type="radio" name="smsAt" value="N" id="smsAt2" checked="checked"> SMS로 수신하지 않겠습니다. </label><br><br>
									<p class="text-default">※ 수신을 거부하셔도 “가입완료”, “비밀번호 찾기” 등의 메일은 자동 발송됩니다.</p>
								</td>
							</tr>
							<tr>
								<th><label for="EMLID"> 이메일</label></th>
								<td>
									<ul>
										<li>
											<input type="hidden" name="email" value='<c:out value="${data[3]}"/>'/>
											<c:out value="${data[3]}"/>
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row"> 휴대폰</th>
								<td>
									<ul>
										<li>
											<input type="hidden" name="mbtlnum" value='<c:out value="${data[4]}"/>'/>
											<c:out value="${data[4]}"/>
										</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</fieldset>
	</form>

	<div class="btnSet tar">
		<a class="btn btn-primary" href="javascript:checkForm();">저장</a>
		<a href="#" onclick="javascript:history.back(0);return false;" class="btn btn-gray mr10">취소</a>
	</div>

<%--
	<div>
		<h3>선택항목</h3>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>선택항목 입력</caption>
				<colgroup>
				<col style="width:15%">
				<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">거주지</th>
						<td>
							<label for="POSN1_1"><input type="radio" name="POSN1" value="라디오" id="POSN1_1"> 서울시 구로구 구로통 </label>
						</td>
					</tr>
					<tr>
						<th scope="row">직업</th>
						<td>
							<label for="JOBGP1_0"><input type="radio" name="JOBGP1" value="라디오" id="JOBGP1_0"> 대학생 </label>
							<label for="JOBGP1_1"><input type="radio" name="JOBGP1" value="라디오" id="JOBGP1_1"> 무직 </label>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div> --%>
