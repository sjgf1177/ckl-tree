<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
	var mode = "${empty result ? 'I' : 'M'}";
	var checkIdCount = 0;
	$(function(){

		$("#chkIdBtn").click(function(){
			var userId = $("#userId").val();
			if( !userId ){
				alert("아이디를 입력해 주세요.");
				$("#userId")[0].focus();
				return;
			}
			$.getJSON(
					"/bos/member/checkId.json",
					{userId : userId},
					function(data)
					{
						if(data.cnt > 0){
							alert("사용하실 수 없는 아이디입니다.");
							$("#userId").val("");
							checkIdCount = 0;
							return;
						}
						else{
							alert("사용가능한 아이디입니다.");
							checkIdCount++;
							return;
						}
					}
				);
		});
	});

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
		    v.add("userId", {
		        required: true
		    });
		}
	    v.add("userNm", {
	        required: true
	    });
	    v.add("deptId", {
	        required: true
	    });
	    v.add("seatNo", {
	        required: true,
	        option: "number"
	    });
	    v.add("telNo1", {
	        required: true,
	        span: 3,
	        glue: "-",
	        option: "phone"
	    });
	    v.add("authorCode", {
	        required: true
	    });
	    v.add("userEmail1", {
	        required: true,
			span: 2,
			glue: "@",
			option: "email"
	    });
	    v.add("status", {
	        required: true
	    });
		if( mode == "I" ){
		    v.add("pwdNew", {
		        required: true
		    });
		}

		if( form.pwdNew.value ){
			/*
		    v.add("pwdNew", {
		    	pattern: /^.*(?=.{9,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[?!@#$%^&*]).*$/,
		    	message: "비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 \n3개 이상의 조합으로 입력해주세요.",
		        required: true
		    });
		     */
		    v.add("pwdNew2", {
		        required: true
		    });
		    v.add("pwdNew", {
		        match: "pwdNew2",
		        message: "비밀번호가 일치하지 않습니다."
		    });
		}
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			form.submit();
		}

	}

	function checkFormDel(){
		var form = document.f_regi;
		if (confirm('삭제 하시겠습니까?')) {
			form.action="/bos/member/delete.do";
			form.submit();
		}
	}

</script>

<form name="f_regi" method="post" action="/bos/member/${empty result ? 'insert' : 'update'}.do">
	<input type=hidden name="pageQueryString" value='${pageQueryString}'>
	<input type=hidden name="userIdx" value='${result.userIdx}'>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td>
					<c:choose>
						<c:when test="${not empty result}">
						${result.userId}<input type="hidden" name="userId" id="userId" value="${result.userId}" />
						</c:when>
						<c:otherwise>
						<input type="text" name="userId" id="userId" value="${result.userId}" class="col-md-8" />
						<input type="button" id="chkIdBtn" name="chkIdBtn" value="중복확인" class="col-md-4 btn btn-inverse" />
						</c:otherwise>
					</c:choose>
					</td>

					<th><label for="userNm"><span class="req">*</span>이름</label></th>
					<td>
						<input type="text" name="userNm" id="userNm" value="${result.userNm}" class="span12" />
					</td>
				</tr>
				<tr>
					<th><label for="deptId"><span class="req">*</span>사업부명</label></th>
					<td>
						<select id="deptId" name="deptId">
						    <option value="">--사업부명선택</option>
						<c:forEach var="dept" items="${deptList}" varStatus="status">
							<option value="${dept.deptId}" <c:if test="${result.deptId eq dept.deptId}">selected="selected"</c:if>>${dept.deptNmKor}[${dept.deptNmEng}]</option>
						</c:forEach>
						</select>
					</td>

					<th><label for="seatNo"><span class="req">*</span>자리번호</label></th>
					<td>
						<input type="text" name="seatNo" id="seatNo" value="${result.seatNo}" style="width:100px" maxlength="11"/>
					</td>
				</tr>
				<tr>
					<th><label for="telNo1"><span class="req">*</span>휴대폰</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.telNo,'-')}" />
						<c:choose>
						<c:when test="${fn:length(data) >= 3}">
							<select name="telNo1" id="telNo1" title="지역 국번 앞 3자리"  class="input_select" >
								<option value="">선택</option>
								<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
								<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
								<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
								<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
								<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
								<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
							</select>
							-
							<input type="text" id="telNo2" name="telNo2" value="${data[1]}" class="tel" title="대표전화 중간4자리" maxlength="4" />
							-
							<input type="text" id="telNo3" name="telNo3" value="${data[2]}" class="tel" title="대표전화 끝4자리" maxlength="4" />
						</c:when>
						<c:otherwise>
							<select name="telNo1" id="telNo1" title="지역 국번 앞 3자리" class="input_select" >
								<option value="">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							-
							<input type="text" value="" id="telNo2" name="telNo2" class="tel" title="대표전화 중간4자리" maxlength="4"/>
							-
							<input type="text" value="" id="telNo3" name="telNo3" class="tel" title="대표전화 끝4자리" maxlength="4"/>
						</c:otherwise>
						</c:choose>
					</td>

					<th><label for="authorCode"><span class="req">*</span>권한</label></th>
					<td>
						<select id="authorCode" name="authorCode">
						    <option value="">--권한선택</option>
							<c:forEach var="author" items="${authorList}" varStatus="status">
							<option value="${author.authorCode}" <c:if test="${author.authorCode eq result.authorCode}">selected="selected"</c:if>>${author.authorNm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><label for="userEmail1"><span class="req">*</span>이메일</label></th>
					<td>
					<c:set var="data" value="${fn:split(result.email,'@')}" />
					<c:choose>
					<c:when test="${fn:length(data) >= 2}">
							<input name="userEmail1" type="text" title="이메일 아이디" value="${data[0]}" class="board1 email_id"/>
							@
							<input name="userEmail2" type="text" title="이메일 주소" value="${data[1]}" class="board1 email_addr"/>
					</c:when>
					<c:otherwise>
							<input name="userEmail1" type="text" title="이메일 아이디" value="" class="board1 email_id"/>
							@
							<input name="userEmail2" type="text" title="이메일 주소" value="" class="board1 email_addr"/>
					</c:otherwise>
					</c:choose>
					</td>
					<th><label for="status"><span class="req">*</span>상태</label></th>
					<td>
						<select id="status" name="status">
						    <option value="">--상태선택</option>
							<option value="N" <c:if test="${result.status eq 'N'}">selected="selected"</c:if>>정상</option>
							<option value="H" <c:if test="${result.status eq 'H'}">selected="selected"</c:if>>중지</option>
						</select>
					</td>

					<%-- <th><label for="userIp1"><span class="req">*</span>접속아이피</label></th>
					<td>
					<c:set var="data" value="${fn:split(result.userIp,'.')}" />
					<c:choose>
					<c:when test="${fn:length(data) >= 4}">
						<input type="text" name="userIp1" id="userIp1" value="${data[0]}" style="width:30px" maxlength="3" />.
						<input type="text" name="userIp2" id="userIp2" value="${data[1]}" style="width:30px" maxlength="3"/>.
						<input type="text" name="userIp3" id="userIp3" value="${data[2]}" style="width:30px" maxlength="3"/>.
						<input type="text" name="userIp4" id="userIp4" value="${data[3]}" style="width:30px" maxlength="3"/>
					</c:when>
					<c:otherwise>
						<input type="text" name="userIp1" id="userIp1" value="" style="width:30px" maxlength="3" />.
						<input type="text" name="userIp2" id="userIp2" value="" style="width:30px" maxlength="3"/>.
						<input type="text" name="userIp3" id="userIp3" value="" style="width:30px" maxlength="3"/>.
						<input type="text" name="userIp4" id="userIp4" value="" style="width:30px" maxlength="3"/>
					</c:otherwise>
					</c:choose>
					</td> --%>
				</tr>
				<tr>
					<th><span class="req">*</span><label for="pwdNew">비밀번호</label></th>
					<td colspan="3"><input type="password" name="pwdNew" id="pwdNew" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호" autocomplete="off">
						<span class="font_11px_orange_01"><br/>

						※ 비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 3개 이상의 조합
						<br/>※ 최근 3개월 이내에 사용한 비밀번호는 사용할 수 없음
						<br/>※ 사용자 아이디와 동일한 비밀번호는 사용할 수 없음
						<br/>※ 동일문자, 연속문자는 사용할 수 없음(예: aaa, abc 등)

						</span>
					</td>
				</tr>
				<tr>
					<th><span class="req">*</span><label for="pwdNew2">비밀번호확인</label></th>
					<td colspan="3"><input type="password" name="pwdNew2" id="pwdNew2" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호확인" autocomplete="off"></td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>${empty result ? '등록' : '수정'}</span></a>
		<c:if test="${not empty result}">
		<a class="btn btn-primary" href="javascript:checkFormDel();"><span>삭제</span></a>
		</c:if>
		<a class="btn btn-primary" onclick="history.back(-2);"><span>취소</span></a>
	</div>
