<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>관리자 인증서 등록</title>
<link rel="stylesheet" type="text/css" href="/bos/css/common.css">
<link rel="stylesheet" type="text/css" href="/portal/css/sub.css">
<link rel="stylesheet" type="text/css" href="/portal/css/common.css">
<style type="text/css">
<!--
.gpki_div h1 { font-size:14px; font-weight:bold; background:#0677b7; color:#fff; padding-left:5px; height:38px; line-height:38px; }
.style_type { padding:0 10px; }
-->
</style>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">

	function pwdCheck(pwdNew)
	{
	    var SamePass_0 = 0; //동일문자 카운트
	    var SamePass_1 = 0; //연속성(+) 카운트
	    var SamePass_2 = 0; //연속성(-) 카운트
	
	    var chr_pass_0;
	    var chr_pass_1;
	    var chr_pass_2;
	
	    for(var i=0; i < pwdNew.value.length; i++)
	    {
	        chr_pass_0 = pwdNew.value.charAt(i);
	        chr_pass_1 = pwdNew.value.charAt(i+1);
	        
	        //동일문자 카운트
	        if(chr_pass_0 == chr_pass_1)
	        {
	            SamePass_0 = SamePass_0 + 1;
	        }       
	        chr_pass_2 = pwdNew.value.charAt(i+2);
	
	        //연속성(+) 카운드
	        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1)
	        {
	            SamePass_1 = SamePass_1 + 1;
	        }
	        
	        //연속성(-) 카운드
	        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1)
	        {
	            SamePass_2 = SamePass_2 + 1;
	        }
	    }
	    if(SamePass_0 > 1)
	    {
	        alert("동일문자를 3번 이상 사용할 수 없습니다.");
	        return false;
	    }
	   
	    if(SamePass_1 > 1 || SamePass_2 > 1 )
	    {
	        alert("연속된 문자열(111 또는 aaa, 123 또는 abc 등)을\n 3자 이상 사용 할 수 없습니다.");
	        return false;
	    }
		return true;
	}
	
	function checkForm() {
		var form = document.gpkiform;
		var pwdNew = form.pwdNew;
		var v = new MiyaValidator(form);
	    v.add("adnm", {
	        required: true
	    });
	    v.add("pos", {
	        required: true
	    });
	    v.add("tel1", {
	        span: 3,
	        glue: "-",
	        option: "phone"    
	    });
	    v.add("email1", {
			span: 2,
			glue: "@",
			option: "email"
	    });
	    v.add("pwdNew", {
/* 	    	pattern: /^.*(?=.{9,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[?!@#$%^&*]).*$/,
	    	message: "비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 \n3개 이상의 조합으로 입력해주세요.", */
	        required: true
	    });
	    
	    v.add("pwdNew2", {
	        required: true
	    });
	    
	    v.add("pwdNew", {
	        match: "pwdNew2",
	        message: "비밀번호가 일치하지 않습니다."
	    });
	    
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		
		if(!pwdCheck(pwdNew)){
			return;
		}
		
		if (confirm('등록하시겠습니까?')) {
			form.submit();
		}

	}
	
	function resizeTOpage(){
		window.resizeTo(570,680);	
	}

</script>
</head>
<body onload="resizeTOpage();">
<form name="gpkiform" method="post" action="/bos/gpkiMember/insert.do">
<input type="hidden" name="larCd" value="${result.larCd}">
<input type="hidden" name="midCd" value="${result.midCd}">
<input type="hidden" name="smCd" value="${result.smCd}">
<input type="hidden" name="aidOld" value="${result.aid}">
<input type="hidden" name="gpkiCode" value="${zvl.gpkiCode}">
	<div class="gpki_div">
	<h1>인증서 등록</h1>
	<table class="identy_board mt15 style_type">
		<caption>인증서 등록</caption>
			<colgroup>
				<col width="100" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">아이디</th>
					<td>
					    <input type="hidden" name="aid" value="${zvl.gid}" /> 
					    <b>${zvl.gid}</b>
					    <br/><br/>
						※ ID/PW 로그인시 사용가능한 아이디
					</td>
				</tr>
				<tr>
					<th scope="row">소속청</th>
					<td>
					    <input type="hidden" name="larNm" value="${result.larNm}" /> 
					    ${result.larNm}
					</td>
				</tr>
				<tr>
					<th scope="row">소속서(소속과)</th>
					<td>
					    <input type="hidden" name="midNm" value="${result.midNm}" /> 
					    ${result.midNm}
					</td>
				</tr>
				<tr>
					<th scope="row">소속과</th>
					<td>
					    <input type="hidden" name="smNm" value="${result.smNm}" /> 
					    ${result.smNm}
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="adnm">이름</label></th>
					<td>
					    <input type="text" id="adnm" name="adnm" value="" /> 
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="pos">직위</label></th>
					<td>
					<select id="pos" name="pos" title="직위선택" style="width:150px">
					   <option value=''>--직위선택</option>
						<c:forEach var="code" items="${posCodeList}" varStatus="status">
						<option value="${code.code}" >${code.codeNm}</option>
						</c:forEach>		   
					</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="tel1">전화번호</label></th>
					<td>
				<input type="text" id="tel1" name="tel1" value="${result.tel1}" class="w70" title="대표전화 처음자리" />
				-
				<input type="text" id="tel2" name="tel2" value="${result.tel2}" class="w70" title="대표전화 중간4자리" />
				-
				<input type="text" id="tel3" name="tel3" value="${result.tel3}" class="w70" title="대표전화 끝4자리" />
					</td>	
				</tr>
				<tr>
					<th scope="row"><label for="email1">이메일</label></th>
					<td><c:set var="data" value="${fn:split(result.email,'@')}" />
						<input type="text" id="email1" class="w110" name="email1" value="${data[0]}">
						@ <input type="text" id="email2" class="w110" name="email2" value="${data[1]}">
				</tr>
				
				<tr>
					<th scope="row"><label for="pwdNew">비밀번호</label></th>
					<td><input type="password" name="pwdNew" id="pwdNew" value="" maxLength="15" class="w145 mb5" title="비밀번호" autocomplete="off">
						<span class="font_11px_orange_01"><br/>
						※ 비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 3개 이상의 조합 
						<br/>※ 사용자 아이디와 동일한 비밀번호는 사용할 수 없음 
						<br/>※ 동일문자, 연속문자는 사용할 수 없음(예: aaa, abc 등)
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="pwdNew2">비밀번호확인</label></th>
					<td><input type="password" name="pwdNew2" id="pwdNew2" value="" maxLength="15" class="w145" title="비밀번호확인" autocomplete="off"></td>
				</tr>
			</tbody>
		</table>
	</div>
	
</form>
	
	<p class="fr mt20 mr10">
		<a href="javascript:checkForm();">
		<img alt="확인" src="/portal/images/common/btn_ok.gif"/></a>
		<a href="javascript:close();">
		<img alt="취소" src="/portal/images/common/btn_cancel.gif"/></a>
		
	</p>

</body>
<font color="red">/WEB-INF/jsp/egovframework${empty includePage ? currMenu.contentsPath : includePage}</font>

</html>


