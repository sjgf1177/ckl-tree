<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />




<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
	var mode = "${empty result ? 'I' : 'M'}";
	var checkIdCount = 0;
	$(function(){
		$("#larCd").change(function(){
			getMidCodeList();
		});
		$("#midCd").change(function(){
			getSmCodeList();
		});

		$("#aidBtn").click(function(){
			var aid = $("#aid").val();
			if( !aid ){
				alert("아이디를 입력해 주세요.");
				$("#aid")[0].focus();
				return;
			}
			$.getJSON(
					"/bos/member/checkId.do",
					{aid : aid, viewType : "JSON"},
					function(data)
					{
						if(data.resultCode == 1){
							if(data.TARGET_OBJ > 0){
								alert("사용하실 수 없는 아이디입니다.");
								$("#aid").val("");
								return;
							}
							else{
								alert("사용가능한 아이디입니다.");
								checkIdCount++;
								return;
							}
						}
						else{
							alert(data.msg);
						}
					}
				);
		});
	});

	function getMidCodeList(){
		var larCd = $("#larCd option:selected").val();
		$.getJSON(
				"/portal/member/getOrgCodeList.do",
				{larCd : larCd, viewType : "JSON"},
				function(data)
				{
		        	$('#midCd').children().remove().end().append('<option selected="selected" value="">--소속서선택</option>') ;
					var jdata = data.orgCdList;
		            $.each(jdata, function(index, itemData) {
		            	$("#midCd").append("<option value='"+itemData.midCd+"'>"+itemData.midNm+"</option>");
		            });
				}
			);
	}

	function getSmCodeList(){
		var larCd = $("#larCd option:selected").val();
		var midCd = $("#midCd option:selected").val();
		$.getJSON(
				"/portal/member/getOrgCodeList.do",
				{larCd : larCd, midCd : midCd, viewType : "JSON"},
				function(data)
				{
		        	$('#smCd').children().remove().end().append('<option selected="selected" value="">--소속과선택</option>') ;
					var jdata = data.orgCdList;
		            $.each(jdata, function(index, itemData) {
		            	$("#smCd").append("<option value='"+itemData.smCd+"'>"+itemData.smNm+"</option>");
		            });
				}
			);
	}

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
		var form = document.f_regi;
		var pwdNew = form.pwdNew;
		var v = new MiyaValidator(form);
		if( mode == "I" ){
		    v.add("aid", {
		        required: true
		    });
		    v.add("adnm", {
		        required: true
		    });
		}
	    v.add("pwdNew", {
	    	pattern: /^.*(?=.{9,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[?!@#$%^&*]).*$/,
	    	message: "비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 \n3개 이상의 조합으로 입력해주세요.",
	        required: true
	    });

	    v.add("pwdNew2", {
	        required: true
	    });
	    v.add("pwdNew", {
	        match: "pwdNew2",
	        message: "비밀번호가 일치하지 않습니다."
	    });
	    v.add("email1", {
			span: 2,
			glue: "@",
			option: "email"
	    });
	    v.add("pos", {
	        required: true
	    });
	    v.add("larCd", {
	        required: true
	    });
	    v.add("midCd", {
	        required: true
	    });
	    v.add("smCd", {
	        required: true
	    });
	    v.add("tel1", {
	        span: 3,
	        glue: "-",
	        option: "phone"
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

		if( mode == "I" && checkIdCount == 0 ){
			alert("아이디중복체크 하셔야합니다.");
			return;
		}

		if (confirm('등록하시겠습니까?')) {
			form.submit();
		}

	}

</script>
</head>
<body>
<div id="content">
	<div class="hgroup">
		<h3 >개인정보수정</h3>
	</div>

<form name="f_regi" method="post" action="/bos/member/updateMy.do">
	<input type=hidden name="searchType" value='${param.searchType}'>
	<input type=hidden name="searchTxt" value='${param.searchTxt}'>
	<input type=hidden name="pageIndex" value='${empty param.pageIndex ? '1' : param.pageIndex}'>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th width="120" tabindex="0">아이디</th>
					<td width="555" tabindex="0">
					${result.aid}<input type="hidden" name="aid" id="aid" value="${result.aid}" />
					</td>
				</tr>
				<tr>
					<th tabindex="0">이름</th>
					<td tabindex="0">
					<input type="text" name="adnm" id="adnm" value="${result.adnm}" />
					</td>
				</tr>
				<tr>
					<th tabindex="0"><label for="pwdNew">비밀번호</label></th>
					<td><input type="password" name="pwdNew" id="pwdNew" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호" autocomplete="off">
						<span class="font_11px_orange_01"><br/>
						<a tabindex="0">
						※ 비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 3개 이상의 조합
						<br/>※ 최근 3개월 이내에 사용한 비밀번호는 사용할 수 없음
						<br/>※ 사용자 아이디와 동일한 비밀번호는 사용할 수 없음
						<br/>※ 동일문자, 연속문자는 사용할 수 없음(예: aaa, abc 등)
						</a>
						</span>
					</td>
				</tr>
				<tr>
					<th tabindex="0"><label for="pwdNew2">비밀번호확인</label></th>
					<td><input type="password" name="pwdNew2" id="pwdNew2" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호확인" autocomplete="off"></td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td><c:set var="data" value="${fn:split(result.email,'@')}" />
						<input type="text" class="input_style02 email_id" maxlength="48" name="email1" value="${data[0]}">
						@ <input align="absmiddle" type="text" class="input_style02 email_addr" maxlength="48" name="email2" value="${data[1]}">
				</tr>
				<tr>
					<th scope="row">직위</th>
					<td>
					<select id="pos" name="pos" title="직위선택" style="width:150px">
					   <option value=''>--직위선택</option>
						<c:forEach var="code" items="${posCodeList}" varStatus="status">
						<option value="${code.code}" <c:if test="${code.code eq result.pos}">selected="selected"</c:if>>${code.codeNm}</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<th scope="row">소속청</th>
					<td>
					<select id="larCd" name="larCd" title="소속청선택" style="width:150px">
					   <option value=''>--소속청선택</option>
						<c:forEach var="data" items="${larCdList}" varStatus="status">
						<option value="${data.larCd}" <c:if test="${data.larCd eq result.larCd}">selected="selected"</c:if>>${data.larNm}</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<th scope="row">소속서</th>
					<td>
					<select id="midCd" name="midCd" title="소속서선택" style="width:150px">
					   <option value=''>--소속서선택</option>
						<c:forEach var="data" items="${midCdList}" varStatus="status">
						<option value="${data.midCd}" <c:if test="${data.midCd eq result.midCd}">selected="selected"</c:if>>${data.midNm}</option>
						</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<th scope="row">소속과</th>
					<td>
					<select id="smCd" name="smCd" title="소속과선택" style="width:150px">
					   <option value=''>--소속과선택</option>
						<c:forEach var="sm" items="${smCdList}" varStatus="status">
						<option value="${sm.smCd}" <c:if test="${sm.smCd eq result.smCd}">selected="selected"</c:if>>${sm.smNm}</option>
						</c:forEach>
					</select>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="tel1">전화번호</label></th>
					<td>
				<input type="text" id="tel1" name="tel1" value="${result.tel1}" class="board1" title="대표전화 처음자리" />
				-
				<input type="text" id="tel2" name="tel2" value="${result.tel2}" class="board1" title="대표전화 중간4자리" />
				-
				<input type="text" id="tel3" name="tel3" value="${result.tel3}" class="board1" title="대표전화 끝4자리" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>