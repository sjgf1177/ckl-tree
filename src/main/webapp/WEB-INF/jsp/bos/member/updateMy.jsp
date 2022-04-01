<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		var form = document.f_regi;
		var pwdNew = form.pwdNew;
		var v = new MiyaValidator(form);
	    v.add("userNm", {
	        required: true
	    });
	    v.add("userEmail1", {
	        required: true,
			span: 2,
			glue: "@",
			option: "email"
	    });
	    v.add("telNo1", {
	        required: true,
	        span: 3,
	        glue: "-",
	        option: "phone"
	    });
	    v.add("seatNo", {
	        required: true,
	        option: "number"
	    });

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

		if (confirm("수정하시겠습니까?")) {
			form.submit();
		}

	}

</script>

<c:if test="${param.viewType eq 'BODY'}">
	<div class="hgroup">
		<h3>내정보 수정</h3>
	</div>
</c:if>

<form name="f_regi" method="post" action="/bos/member/updateMy.do">
	<input type=hidden name="pageQueryString" value='${pageQueryString}'>
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
					<td>${result.userId}</td>
					<th><label for="userNm"><span class="req">*</span>이름</label></th>
					<td>
						<input type="text" name="userNm" id="userNm" value="${result.userNm}" style="width:200px" />
					</td>
				</tr>
				<tr>
					<th><label for="userEmail1"><span class="req">*</span>이메일</label></th>
					<td colspan="3">
					<c:set var="data" value="${fn:split(result.email,'@')}" />
					<c:choose>
					<c:when test="${fn:length(data) >= 2}">
							<input name="userEmail1" type="text" title="이메일 아이디" value="${data[0]}" style="width:100px" class="board1 email_id"/>
							@
							<input name="userEmail2" type="text" title="이메일 주소" value="${data[1]}" style="width:200px" class="board1 email_addr"/>
					</c:when>
					<c:otherwise>
							<input name="userEmail1" type="text" title="이메일 아이디" value="" style="width:100px" class="board1 email_id"/>
							@
							<input name="userEmail2" type="text" title="이메일 주소" value="" style="width:200px" class="board1 email_addr"/>
					</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<th><label for="telNo1"><span class="req">*</span>휴대폰</label></th>
					<td colspan="3">
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
				<input type="text" id="telNo2" name="telNo2" value="${data[1]}" class="tel" title="대표전화 중간4자리" />
				-
				<input type="text" id="telNo3" name="telNo3" value="${data[2]}" class="tel" title="대표전화 끝4자리" />
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
				<input type="text" value="" id="telNo2" name="telNo2" class="tel" title="대표전화 중간4자리" />
				-
				<input type="text" value="" id="telNo3" name="telNo3" class="tel" title="대표전화 끝4자리" />
			</c:otherwise>
			</c:choose>
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
						<input type="text" name="seatNo" id="seatNo" value="${result.seatNo}" style="width:100px" />
					</td>
				</tr>
				<tr>
					<th><span class="req">*</span><label for="pwdNew">비밀번호</label></th>
					<td colspan="3"><input type="password" name="pwdNew" id="pwdNew" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호" autocomplete="off">
						<span class="font_11px_orange_01"><br/>
						<a>
						※ 비밀번호는 9~15자의 영문 대/소문자, 숫자, 특수문자중 3개 이상의 조합
						<br/>※ 최근 3개월 이내에 사용한 비밀번호는 사용할 수 없음
						<br/>※ 사용자 아이디와 동일한 비밀번호는 사용할 수 없음
						<br/>※ 동일문자, 연속문자는 사용할 수 없음(예: aaa, abc 등)
						</a>
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
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	</div>
