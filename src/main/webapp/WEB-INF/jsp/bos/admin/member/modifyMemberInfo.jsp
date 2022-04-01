<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<!-- 관리자 등록, 수정페이지 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />




<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
	var mode = "${empty result ? 'I' : 'M'}";
	var checkIdCount = 0;
	var lv = "${result.deptDepth}";
	var upperDeptId = "${result.upperDeptId}";
	var deptId = "${result.deptId}";
	if( lv == "1" ){
		upperDeptId = "${result.deptId}";
		deptId = "";
	}
	var teamId = "${result.teamId}";

	$(function(){
		$("#larCd").change(function(){
			var larCd = $("#larCd option:selected").val();
			getMidCodeList(larCd);
		});
		$("#midCd").change(function(){
			var midCd = $("#midCd option:selected").val();
			getSmCodeList(midCd);
		});

		$("#aidBtn").click(function(){
			var userId = $("#userId").val();
			if( !userId ){
				alert("아이디를 입력해 주세요.");
				$("#userId")[0].focus();
				return;
			}
			$.getJSON(
					"/bos/member/checkId.json",
					{userId : userId, programId : "adminMember"},
					function(data)
					{
						if(data.resultCode == "success"){
							if(data.cnt > 0){
								alert("사용하실 수 없는 아이디입니다.");
								$("#userId").val("");
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

		getLarCodeList();
		if( mode != "I" ){
			getMidCodeList(upperDeptId);
			getSmCodeList(deptId);
		}

	});

	function getLarCodeList(){
		$.getJSON(
				"/bos/deptPop/selectDeptList.json",
				{deptDepth : "1"},
				function(data)
				{
		        	$('#larCd').children().remove().end().append('<option value="">--소속국선택</option>') ;
					var jdata = data.resultList;
		            $.each(jdata, function(index, itemData) {
						if( itemData.deptId == upperDeptId )
			            	$("#larCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
						else
			            	$("#larCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
		            });
				}
			);
	}

	function getMidCodeList(larCd){
		if( !larCd ) return;
		$.getJSON(
				"/bos/deptPop/findDeptList.json",
				{upperDeptId : larCd},
				function(data)
				{
		        	$('#midCd').children().remove().end().append('<option value="">--소속과선택</option>') ;
					var jdata = data.resultList;
					if( jdata.length > 0 ){
			            $.each(jdata, function(index, itemData) {
							if( itemData.deptId == deptId )
				            	$("#midCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
							else
				            	$("#midCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
			            });
						$("#midCdTr").show();
					}
					else{
						$("#midCdTr").hide();
						getSmCodeList(larCd);
					}
				}
			);
	}

	function getSmCodeList(midCd){
		if( !midCd ){
			$("#smCdTr").hide();
			return;
		}
		$.getJSON(
				"/bos/deptPop/findTeamList.json",
				{upperDeptId : midCd},
				function(data)
				{
		        	$('#teamId').children().remove().end().append('<option selected="selected" value="">--소속팀선택</option>') ;
					var jdata = data.resultList;
					if( jdata.length > 0 ){
			            $.each(jdata, function(index, itemData) {
							if( itemData.deptId == teamId )
				            	$("#teamId").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
							else
				            	$("#teamId").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
			            });
						$("#smCdTr").show();
					}
					else{
						$("#smCdTr").hide();
					}
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

	    for(var i=0; i < pwdNew.length; i++)
	    {
	        chr_pass_0 = pwdNew.charAt(i);
	        chr_pass_1 = pwdNew.charAt(i+1);

	        //동일문자 카운트
	        if(chr_pass_0 == chr_pass_1)
	        {
	            SamePass_0 = SamePass_0 + 1;
	        }
	        chr_pass_2 = pwdNew.charAt(i+2);

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

	    if(SamePass_1 > 0 || SamePass_2 > 0 )
	    {
	        alert("연속된 문자열(111 또는 aaa, 123 또는 abc 등)을\n 3자 이상 사용 할 수 없습니다.");
	        return false;
	    }
	    return true;

	}

	function qwertyCheck(pw) {
		var qwerty  = "90-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:ZXCVBNM<>?";
		var start   = 4 - 1; // 연속글자수 - 1
		var seq     = "_" + pw.slice(0, start);

		for (i = start; i < pw.length; i++) {
		seq = seq.slice(1) + pw.charAt(i);

			if (qwerty.indexOf(seq) > -1) {
				alert("키보드상에 나란히 있는 4개의 문자를 연속으로 비밀번호로 사용하실 수 없습니다.");
				return false;
			}

		}

		return true;

	}

	function checkForm() {
		var form = document.f_regi;
		var v = new MiyaValidator(form);
		if( mode == "I" ){
			var pwdNew = $('#password');
			var userId = $('#userId');
		    v.add("userId", {
		        required: true
		    });
		    /*
		    v.add("password", {
		    	pattern: /^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-z])(?!=.*[A-Z]).*$/,
		    	message: "비밀번호는 10~15자의 영문 소문자,숫자를 조합으로 입력해야 합니다.",
		        required: true
		    });

		    //연속성체크
		    if(!pwdCheck(pwdNew.val())) {
		    	pwdNew.focus();
		    	return;
		    }

		  	//키보드상 연속글자 체크
		    if(!qwertyCheck(pwdNew.val())){
		    	pwdNew.focus();
		    	return;
		    };
			     */
		    v.add("password", {
		        required: true
		    });
		    v.add("password2", {
		        required: true
		    });
		    v.add("password2", {
		        match: "password",
		        message: "비밀번호가 일치하지 않습니다."
		    });
		    /*
		    //id 패스워드 동일체크
		    if(userId.val().length > 0 && pwdNew.val() == userId.val()){
		    	alert("아이디와 비밀번호를 동일한 문자로 사용하시면 안됩니다.");
		    	pwdNew.focus();
		    	return;
		    }

		    */

		}
	<c:if test="${not empty result and empty param.userId}">
	    v.add("password2", {
	        match: "password",
	        message: "비밀번호가 일치하지 않습니다."
	    });
	</c:if>

	    v.add("userName", {
	        required: true
	    });
	    /*
	    v.add("userEmail1", {
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
	    */
	    v.add("larCd", {
	        required: true
	    });
	    v.add("job", {
	        required: true
	    });
	    v.add("userPhone1", {
	        required: true,
	        span: 3,
	        glue: "-",
	        option: "phone"
	    });
	    v.add("userMobile1", {
	        span: 3,
	        glue: "-",
	        option: "handphone"
	    });
	    v.add("adminRank", {
	        required: true,
	        option: "number"
	    });
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
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


	function openPopup()
	{
		url = "/bos/deptPop/list?lv=2";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=800, height=700");
	}


</script>
</head>
<body>
<c:set var="action" value="/bos/member/insert.do" />
<c:if test="${not empty result}">
	<c:if test="${empty param.userId}">
		<c:set var="action" value="/bos/member/updateMy.do" />
		<c:set var="title" value="내정보수정" />
	</c:if>
	<c:if test="${not empty param.userId}">
		<c:set var="action" value="/bos/member/update.do" />
		<c:set var="title" value="관리자관리" />
	</c:if>
</c:if>
<div id="content">
	<div class="hgroup">
		<h3 >${title}</h3>
	</div>

<form name="f_regi" method="post" enctype="multipart/form-data" action="${action}">
	<input type=hidden name="programId" value='${param.programId}'>
	<input type=hidden name="searchType" value='${param.searchType}'>
	<input type=hidden name="searchTxt" value='${param.searchTxt}'>
	<input type=hidden name="pageIndex" value='${empty param.pageIndex ? '1' : param.pageIndex}'>
	<input type=hidden name="pageQueryString" value='${pageQueryString}'>

<h5 class="bu_t1 h_t_m">관리자페이지 로그인을 위한 정보입니다.</h5>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th width="120" >아이디</th>
					<td width="555" >
						<c:choose>
							<c:when test="${empty result}">
								<input type="text" name="userId" id="userId" value="" maxLength=50 class="input_style02" style="width:100px; heigth:18px;" title="아이디">
								<input type="button" class="btn btn-default" id="aidBtn" name="aidBtn" value="중복검사" />
							</c:when>
							<c:otherwise>${result.userId}<input type="hidden" name="userId" id="userId" value="${result.userId}" /></c:otherwise>
						</c:choose>
					</td>
				</tr>
			<c:if test="${empty param.userId}">
				<tr>
					<th ><label for="password">비밀번호</label></th>
					<td><input type="password" name="password" id="password" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호" autocomplete="off">
					</td>
				</tr>
				<tr>
					<th ><label for="password2">비밀번호확인</label></th>
					<td><input type="password" name="password2" id="password2" value="" maxLength='15' class="input_style02" style="width:160px; heigth:18px;" title="비밀번호확인" autocomplete="off"></td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>

<h5 class="bu_t1 h_t_m">홈페이지를 통해 공개되는 정보입니다.</h5>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th ><img src="/bos/images/common/required.gif" width="15" height="15">이름</th>
					<td >
						<input type="text" name="userName" id="userName" value="${result.userName}" maxLength=50 class="input_style02" style="width:100px; heigth:18px;" title="이름">
					</td>
				</tr>
				<tr>
					<th scope="row">이메일</th>
					<td><c:set var="data" value="${fn:split(result.userEmail,'@')}" />
						<input type="text" style="width:100px; heigth:18px;" class="input_style02" maxlength="48" name="userEmail1" value="${data[0]}">
						@ <input align="middle" type="text" style="width:100px; heigth:18px;" class="input_style02" maxlength="48" name="userEmail2" value="${data[1]}">
				</tr>
				<tr>
					<th scope="row"><img src="/bos/images/common/required.gif" width="15" height="15">소속국</th>
					<td>
					<select id="larCd" name="larCd" title="소속국선택" style="width:150px">
					   <option value=''>--소속국선택</option>
					</select>
					</td>
				</tr>
				<tr id="midCdTr">
					<th scope="row"><img src="/bos/images/common/required.gif" width="15" height="15">소속과</th>
					<td>
					<select id="midCd" name="midCd" title="소속과선택" style="width:150px">
					   <option value=''>--소속과선택</option>
					</select>
					</td>
				</tr>
				<tr id="smCdTr">
					<th scope="row"><img src="/bos/images/common/required.gif" width="15" height="15">소속팀</th>
					<td>
						<select id="teamId" name="teamId" title="소속과선택" style="width:150px">
						   <option value=''>--소속팀선택</option>
						</select>
					</td>
				</tr>

				<tr>
					<th >직위</th>
					<td >
						<input type="text" name="staffOffice" id="staffOffice" value="${result.staffOffice}" maxLength=50 class="input_style02" style="width:200px; heigth:18px;" title="직위">
					</td>
				</tr>
				<tr>
					<th scope="row"><img src="/bos/images/common/required.gif" width="15" height="15">업무</th>
					<td>
					<textarea id="job" name="job" class="textarea" cols="35" rows="7"  style="width:620px;">${result.job}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="userPhone1"><img src="/bos/images/common/required.gif" width="15" height="15">전화번호</label></th>
					<td><c:set var="data" value="${fn:split(result.userPhone,'-')}" />
				<input type="text" id="userPhone1" name="userPhone1" value="${data[0]}" class="tel1" title="대표전화 처음자리" />
				-
				<input type="text" id="userPhone2" name="userPhone2" value="${data[1]}" class="tel" title="대표전화 중간4자리" />
				-
				<input type="text" id="userPhone3" name="userPhone3" value="${data[2]}" class="tel" title="대표전화 끝4자리" />
					</td>
				</tr>
		<c:choose>
			<c:when test="${not empty param.userId or empty result}">
				<tr>
					<th scope="row"><img src="/bos/images/common/required.gif" width="15" height="15">사용여부</th>
					<td>
				<input type="radio" id="delState1" name="delState " value="1" class="input_radio" <c:if test="${empty result.delState or result.delState eq '1'}"> checked="checked"</c:if> /> <label for="delState1">사용</label>
				<input type="radio" id="delState2" name="delState " value="0" class="input_radio" <c:if test="${result.delState eq '0'}"> checked="checked"</c:if> /> <label for="delState2">미사용</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><img src="/bos/images/common/required.gif" width="15" height="15">표시여부</th>
					<td>
				<input type="radio" id="printYn1" name="printYn " value="Y" class="input_radio" <c:if test="${empty result.printYn or result.printYn eq 'Y'}"> checked="checked"</c:if> /> <label for="printYn1">표시</label>
				<input type="radio" id="printYn2" name="printYn " value="N" class="input_radio" <c:if test="${result.printYn eq 'N'}"> checked="checked"</c:if> /> <label for="printYn2">미표시</label>
					</td>
				</tr>
				<tr>
					<th >정렬순서</th>
					<td >
						<input type="text" name="adminRank" id="adminRank" value="${result.adminRank}" maxLength=50 class="input_style02" style="width:200px; heigth:18px;" title="정렬순서">
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="adminRank" value="${empty result.adminRank ? '1' : result.adminRank}" />
				<input type="hidden" name="delState" value="${result.delState}" />
				<input type="hidden" name="printYn" value="${result.printYn}" />
			</c:otherwise>
		</c:choose>
			</tbody>
		</table>
	</div>

<h5 class="bu_t1 h_t_m">관련민원접수시 문자를 통해 알려드립니다.</h5>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="userMobile1">핸드폰번호</label></th>
					<td><c:set var="data" value="${fn:split(result.userMobile,'-')}" />
				<input type="text" id="userMobile1" name="userMobile1" value="${data[0]}" class="tel1" title="대표전화 처음자리" />
				-
				<input type="text" id="userMobile2" name="userMobile2" value="${data[1]}" class="tel" title="대표전화 중간4자리" />
				-
				<input type="text" id="userMobile3" name="userMobile3" value="${data[2]}" class="tel" title="대표전화 끝4자리" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>확인</span></a>
<c:if test="${not empty param.userId or empty result}">
		<c:url var="url" value="/bos/member/delete.do?userId=${result.userId}&amp;${pageQueryString}"/>
	<c:if test="${not empty result}">
		<a class="btn btn-danger"  href="${url}" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
		<c:url var="url" value="/bos/member/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</c:if>
	</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>