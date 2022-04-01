<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[

	$(function() {

		pwdNextChange = function() {
			if ("<c:out value='${user.pwdChangeAt}'/>" == "N") {
				alert("관리자 또는 비밀번호 찾기에 의해서 비밀번호가 변경된 경우에는 무조건 변경하셔야 합니다.");
				$("#password0").focus();
				return;
			}
			if (!confirm("'다음에 변경하기'를 선택하시면 재로그인 페이지로 이동됩니다.")) {
				return;
			}
			$.post(
				"/edu/userMember/pwdNextChange.json",
				{userSn : "<c:out value='${user.userIdx}'/>"},
				function(data) {
					if (data.resultCode == "success") {
						alert("변경되었습니다. 다시 로그인해주세요.");
						logoutSSO();
					}
				},"json"
			);
		};

		pwdChangeRequest = function() {
			if (!checkPwd0Fc()) {
				alert("기존 비밀번호가 일치하지 않습니다.");
				$("#password0").focus();
				return;
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
			if (!confirm("변경 하시겠습니까?")) {
				return;
			}

			$.post(
				"/edu/userMember/pwdChangeRequest.json",
				{userSn : "<c:out value='${user.userIdx}'/>", password : $("#password").val()},
				function(data) {
					if (data.resultCode == "success") {
						alert("변경되었습니다. 다시 로그인해주세요.");
						logoutSSO();
					}
				},"json"
			);
		};

	});

	function checkPwd0(value) {
		checkPwd0Fc();
	    return value;
	}

	function checkPwd0Fc() {
		$.ajaxSetup({
			async: false
		});
		var flag = true;

		$.post(
			"/edu/userMember/pwdCheck.json",
			{userSn : "<c:out value='${user.userIdx}'/>", password : $("#password0").val()},
			function(data) {
				if (data.resultCode == "success") {
					flag = true;
				}
				else {
					flag = false;
				}
			},"json"
		);

		if (flag == true) {
			$("#pwd0-success").text("기존 비밀번호가 맞습니다");
			$("#pwd0-danger").text("");
			return true;
		}
		else {
			$("#pwd0-success").text("기존 비밀번호가 맞지 않습니다.");
			$("#pwd0-danger").text("");
			return false;
		}

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

	function checkPwdVal(){
		var form = $("#pwdForm")[0];
		var v = new MiyaValidator(form);
	    v.add("password", {
	    	required: true,
	    	pattern: "^.*(?=.{8,16})(?=.*[0-9!@#$%^&*()_+=<>?])(?=.*[a-zA-Z]).*$"
	        //pattern: "^([a-zA-Z!@#$%^&*()_+=<>?0-9]{6,16})$",
	    });
	    var result = v.validate();
	    if (!result) {
	        v.getErrorElement().focus();
			return false;
	    }
	    if ($("#password0").val() == $("#password").val()) {
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
		var form = $("#pwdForm")[0];
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


//]]>
</script>

<c:if test="${param.mode eq 'i'}">
	<div class="mb20 alert alert-info">
		<p>
			<c:choose>
				<c:when test="${user.pwdChangeAt eq 'N'}">
					관리자 또는 비밀번호 찾기에 의해서 비밀번호가 변경되었습니다. 임시비밀번호는 기억하기 어렵고 다음에 로그인하실 때 기억나지 않을 수 있으니, 다시 비밀번호를 변경해주시기 바랍니다.
				</c:when>
				<c:otherwise>
					"회원님의 소중한 개인정보를 위해 비밀번호를 변경해주세요" <br/>
					에듀코카에서는 회원님의 개인정보보호를 위해 3개월 이상 비밀번호를 변경하지 않은 경우 비밀번호 변경을 안내하고 있습니다. <br/>
					변경 시, 타인이 추측하기 쉬운 비밀번호는 도용위험성이 높으니, 영어/숫자/특수문자를 조합하여 안전하게 설정해주시기 바랍니다. 
				</c:otherwise>
			</c:choose>
		</p>
	</div>
</c:if>

<fieldset>
	<legend>비밀번호 변경 입력</legend>
	<form name="pwdForm" id="pwdForm" action="#" method="post">
		<div>
			<div class="tbrinfo text-danger clear hide_star_con no_margin"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView sub_board_body">
				<table class="table table-bordered contents_insight_view">
					<caption>로그인 정보 입력</caption>
					<colgroup>
					<col style="width:20%">
					<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="password0" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 기존 비밀번호</label></th>
							<td>
								<span class="input_style_1_con">
									<input type="password" name="password0" id="password0" class="input_style_1" value="" style="width:150px" onkeyup="this.value=checkPwd0(this.value)">
									<span class="text-success" id="pwd0-success"></span>
									<span class="text-danger" id="pwd0-danger"></span>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="password" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호</label></th>
							<td>
								<span class="input_style_1_con">
									<input type="password" name="password" id="password" class="input_style_1" value="" style="width:150px" onkeyup="this.value=checkPwd(this.value)">
									<span class="text-success" id="pwd-success"></span>
									<span class="text-danger" id="pwd-danger"></span>
									</span>

								<p class="text-default">※ 8~16자까지 영문자(대/소문자), 숫자 및 특수문자 조합을 사용하여 주십시오<br>
									3자리 연속 또는 같은 문자, 아이디, 생년월일은 사용하실 수 없습니다.<br>
									ID와 동일한 비밀번호 및 동일문자는 설정하실 수 없습니다.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="password2" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호 확인</label></th>
							<td>
								<span class="input_style_1_con">
									<input type="password" name="password2" id="password2" class="input_style_1" value="" style="width:150px" onkeyup="this.value=checkPwd2(this.value)">
									<span class="text-success" id="pwd2-success"></span>
									<span class="text-danger" id="pwd2-danger"></span>
								</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="board_util_btn_con">
			<a href="javascript:pwdChangeRequest();" class="btn_style_0 green edit">변경</a>
		<c:if test="${param.mode eq 'i'}">
			<a href="javascript:pwdNextChange();" class="btn_style_0 full list">다음에 변경</a>
		</c:if>
		</div>
	</form>
</fieldset>
