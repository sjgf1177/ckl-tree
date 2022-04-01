<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/WEB-INF/error/500.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="userIp" value="<%= request.getRemoteAddr()%>" />
<!DOCTYPE html>
<html lang="en">
<head>

<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/bosLayout.css" />
<script type="text/javascript" src="/js/ssl.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript"  src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
//<![CDATA[
	function pwdNextChange () {
		if (!confirm("'다음에 변경하기'를 선택하시면 재로그인 페이지로 이동됩니다.")) {
			return;
		}
		$.post(
			"/bos/member/adminPwdNextChange.json",
			{userIdx : "<c:out value='${adminUser.userIdx}'/>"},
			function(data) {
				if (data.resultCode == "success") {
					alert("변경되었습니다. 다시 로그인해주세요.");
					location.href="/bos/member/logout.do";
				}
			},"json"
		);
	};

	function pwdChangeRequest () {
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
			"/bos/member/adminPwdChangeRequest.json",
			{userIdx : "<c:out value='${adminUser.userIdx}'/>", password : $("#password").val()},
			function(data) {
				if (data.resultCode == "success") {
					alert("변경되었습니다. 다시 로그인해주세요.");
					location.href="/bos/member/logout.do";
				}
			},"json"
		);
	};


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
			"/bos/member/adminPwdCheck.json",
			{username : "<c:out value='${adminUser.userId}'/>", password : $("#password0").val()},
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
			$("#pwd0-success").text("");
			$("#pwd0-danger").text("기존 비밀번호가 맞지 않습니다.");
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
<meta charset="UTF-8" />
<title>안내(2번)</title>
<style>
*{padding: 0;margin: 0;}
.inforSet{border: 1px solid #f2f2f2;width: 901px;margin: 73px auto;}
.inforSet .logo{background-color: #f2f2f2;padding:5px 0 0 25px ;height: 67px;}
.inforSet p{padding: 20px 0px 20px 90px;line-height: 30px;font-weight: bold;}
.inforSet em{color: #0180d0;font-style:normal;}
.inforSet em.col{color: #0e5fe6;}
.board_util_btn_con{text-align: center;}
form{padding:10px;}
</style>
</head>
<body>
	<div id="header_wrap">
		<div class="header">
			<h1><a href="/bos/main/main.do"><img src="/images/common/logo.png" alt="<spring:message code="site.slogan" text=""/>" /></a></h1>
			<p class="user bold"><span class="color1">[${adminUser.deptNm}]${adminUser.userNm}</span>님 로그인 접속IP:${userIp}</p>
			<div class="util btn-group">
				<a href="/bos/member/logout.do" class="btn btn-info"><i class="fa fa-power-off"></i> 로그아웃</a>
			</div>
		</div>

		<div id="gnb"></div>
	</div>

	<div class="inforSet">
		<div class="logo"><img src="/images/common/logo.png" alt="ckl" />	</div>
		<p>
			안녕하세요 <em>${adminUser.userNm}</em> 님.  통합 관리자 사이트에 접속하셨습니다. <br />
			<em>회원님의 소중한 개인정보를 위해 비밀번호를 변경해주세요</em><br/>
			에듀코카에서는 회원님의 개인정보보호를 위해 3개월 이상 비밀번호를 변경하지 않은 경우 비밀번호 변경을 안내하고 있습니다. <br/>
			변경 시, 타인이 추측하기 쉬운 비밀번호는 도용위험성이 높으니, 영어/숫자/특수문자를 조합하여 안전하게 설정해주시기 바랍니다. <br/>
		</p>
		<form name="pwdForm" id="pwdForm" action="#" method="post">
			<div>
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
										<input type="password" name="password0" id="password0" class="input_style_1" value="" style="width:250px" onkeyup="this.value=checkPwd0(this.value)">
										<span class="text-success" id="pwd0-success"></span>
										<span class="text-danger" id="pwd0-danger"></span>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="password" class="red_star_text"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비밀번호</label></th>
								<td>
									<span class="input_style_1_con">
										<input type="password" name="password" id="password" class="input_style_1" value="" style="width:250px" onkeyup="this.value=checkPwd(this.value)">
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
										<input type="password" name="password2" id="password2" class="input_style_1" value="" style="width:250px" onkeyup="this.value=checkPwd2(this.value)">
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
				<a href="javascript:pwdChangeRequest();" class="btn btn-info">변경</a>
				<a href="javascript:pwdNextChange();" class="btn btn-info">다음에 변경</a>
			</div>
		</form>
	</div>
</body>
</html>
