<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>

<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.member.service.UserMemberService" var="UserMemberService"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원관리</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
$(function(){
	var memberType = "${result.memberType}";
	if( memberType == "${UserMemberService.COMPANY_MEMBER_TYPE}" ){
		$("#companyH5").show();
		$("#companyDiv").show();
		$("#parentH5").hide();
		$("#parentDiv").hide();
	}
	else if( memberType == "${UserMemberService.PARENT_MEMBER_TYPE}" ){
		$("#companyH5").hide();
		$("#companyDiv").hide();
		$("#parentH5").show();
		$("#parentDiv").show();
	}
	else{
		$("#companyH5").hide();
		$("#companyDiv").hide();
		$("#parentH5").hide();
		$("#parentDiv").hide();
	}

	$("#memberType").change(function(){
		var val = this.value;
		if( val == "${UserMemberService.COMPANY_MEMBER_TYPE}" ){
			$("#companyH5").show();
			$("#companyDiv").show();
			$("#parentH5").hide();
			$("#parentDiv").hide();
		}
		else if( val == "${UserMemberService.PARENT_MEMBER_TYPE}" ){
			$("#companyH5").hide();
			$("#companyDiv").hide();
			$("#parentH5").show();
			$("#parentDiv").show();
		}
		else{
			$("#companyH5").hide();
			$("#companyDiv").hide();
			$("#parentH5").hide();
			$("#parentDiv").hide();
		}
	});
});

function checkForm(){
	var form = document.f_regi;
	var v = new MiyaValidator(form);
    v.add("userName", {
        required: true
    });
	v.add("userEmail1", {
		span: 2,
		glue: "@",
		option: "email"
	});
    v.add("postNo1", {
        required: true,
        span: 2,
        glue: "-",
        option: "zip"
    });
    v.add("address1", {
        required: true
    });
    v.add("address2", {
        required: true
    });
    v.add("userPhone1", {
        span: 3,
        glue: "-",
        option: "phone"
    });
    v.add("userMobile1", {
		required: true,
		glue : "-",
		span : 3,
		option: "handphone"
    });
    var result = v.validate();
    if (!result) {
        alert(v.getErrorMessage());
        v.getErrorElement().focus();
		return;
    }

	if( confirm("등록하시겠습니까?") ){
		form.submit();
	}
}

function postSearch(url,event){
	window.open(url, "postfind", "resizable=no, status=no, scrollbars=yes, toolbar=no, menubar=no, width=500, height=700");
	if(event.preventDefault){
	event.preventDefault(); //FF
	} else {
	event.returnValue = false; //IE
	}
	}
</script>

<div id="content">
	<div class="hgroup">
		<h3 >사용자회원관리</h3>
	</div>

<form name="f_regi" method="post" enctype="multipart/form-data" action="/bos/user/member/update.do">
	<input type="hidden" name="programId" value="userMember" />
	<input type="hidden" name="userId" value="${result.userId}" />
	<input type="hidden" name="newsReceive" value="${result.newsReceive}" />
	<input type="hidden" name="smsReceive" value="${result.smsReceive}" />

<h5 class="bu_t1 h_t_m">로그인을 위한 정보입니다.</h5>
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
						${result.userId}
					</td>
				</tr>
				<tr>
					<th ><label for="password">비밀번호 변경열쇠 질문</label></th>
					<td>
						<select id="passQuest" name="passQuest" class="input_select pass_val">
							<option>질문을 선택하세요</option>
							<c:forEach var="code" items="${passQuestCodeList}" varStatus="status">
							<option value="${code.code}" <c:if test="${code.code eq result.passQuest}">selected="selected"</c:if>>${code.codeNm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th ><label for="password2">변경열쇠 답 입력</label></th>
					<td><input type="text" id="passVal" name="passVal" value="${result.passVal}" class="input_txt pass_val" /></td>
				</tr>
			</tbody>
		</table>
	</div>

<h5 class="bu_t1 h_t_m">개인정보</h5>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th width="120" ><label for="userName">사용자이름</label></th>
					<td width="555" >
						<input type="text" id="userName" name="userName" value="${empty result ? user.userName : result.userName}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th width="120" ><label for="memberType">회원구분</label></th>
					<td width="555" >
						<select id="memberType" name="memberType" class="input_select" title="회원구분" >
							<option value="${UserMemberService.BASIC_MEMBER_TYPE}" <c:if test="${UserMemberService.BASIC_MEMBER_TYPE eq resultMemberType}">selected="selected"</c:if>>일반회원</option>
							<option value="${UserMemberService.COMPANY_MEMBER_TYPE}" <c:if test="${UserMemberService.COMPANY_MEMBER_TYPE eq resultMemberType}">selected="selected"</c:if>>기업회원</option>
							<option value="${UserMemberService.PARENT_MEMBER_TYPE}" <c:if test="${UserMemberService.PARENT_MEMBER_TYPE eq resultMemberType}">selected="selected"</c:if>>어린이회원</option>
							<option value="${UserMemberService.FOREIGN_MEMBER_TYPE}" <c:if test="${UserMemberService.FOREIGN_MEMBER_TYPE eq resultMemberType}">selected="selected"</c:if>>외국인회원</option>
						</select>
					</td>
				</tr>
				<tr>
					<th width="120" ><label for="sex1">성별</label></th>
					<td width="555" >
						<input type="radio" id="sex1" name="sex" value="M" class="input_radio" <c:if test="${result.sex eq 'M'}"> checked="checked"</c:if> /> <label for="sex1">남</label>
						<input type="radio" id="sex2" name="sex" value="F" class="input_radio" <c:if test="${result.sex eq 'F'}"> checked="checked"</c:if> /> <label for="sex2">여</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="userBirthday1">생년월일</label></th>
					<td colspan="3">
						<c:set var="birthday" value="${result.userBirthday}" />
						<c:set var="data" value="${fn:split(birthday, '-')}" />
						<select  name="userBirthday1" class="input_select" title="생 년" id="birthday">
						    <option value="">년도선택</option>
						<c:forEach var="x" begin="1901" end="2013">
						    <option value="${x}" ${data[0] eq x ? 'selected="selected"' : ''}>${x}</option>
						</c:forEach>
						</select>
						-
						<select  name="userBirthday2" class="input_select" title="생 월" >
						    <option value="">월선택</option>
						<c:forEach var="x" begin="1" end="12">
							<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
						    <option value="${val}" ${data[1] eq val ? 'selected="selected"' : ''}>${x}</option>
						</c:forEach>
						</select>
						-
						<select  name="userBirthday3" class="input_select" title="생 일" >
						    <option value="">일선택</option>
						<c:forEach var="x" begin="1" end="31">
							<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
						    <option value="${val}" ${data[2] eq val ? 'selected="selected"' : ''}>${x}</option>
						</c:forEach>
						</select></td>
				</tr>
				<tr>
					<th ><label for="userPhone1">자택전화</label></th>
					<td>
				<c:set var="data" value="${fn:split(result.userPhone,'-')}" />
						<select id="userPhone1" name="userPhone1" class="input_select" title="자택전화 지역번호" >
							<option value="">선택</option>
							<option value="02" <c:if test="${data[0] eq '02'}">selected="selected"</c:if>>02</option>
							<option value="051" <c:if test="${data[0] eq '051'}">selected="selected"</c:if>>051</option>
							<option value="053" <c:if test="${data[0] eq '053'}">selected="selected"</c:if>>053</option>
							<option value="032" <c:if test="${data[0] eq '032'}">selected="selected"</c:if>>032</option>
							<option value="062" <c:if test="${data[0] eq '062'}">selected="selected"</c:if>>062</option>
							<option value="042" <c:if test="${data[0] eq '042'}">selected="selected"</c:if>>042</option>
							<option value="052" <c:if test="${data[0] eq '052'}">selected="selected"</c:if>>052</option>
							<option value="044" <c:if test="${data[0] eq '044'}">selected="selected"</c:if>>044</option>
							<option value="031" <c:if test="${data[0] eq '031'}">selected="selected"</c:if>>031</option>
							<option value="033" <c:if test="${data[0] eq '033'}">selected="selected"</c:if>>033</option>
							<option value="043" <c:if test="${data[0] eq '043'}">selected="selected"</c:if>>043</option>
							<option value="041" <c:if test="${data[0] eq '041'}">selected="selected"</c:if>>041</option>
							<option value="063" <c:if test="${data[0] eq '063'}">selected="selected"</c:if>>063</option>
							<option value="061" <c:if test="${data[0] eq '061'}">selected="selected"</c:if>>061</option>
							<option value="054" <c:if test="${data[0] eq '054'}">selected="selected"</c:if>>054</option>
							<option value="055" <c:if test="${data[0] eq '055'}">selected="selected"</c:if>>055</option>
							<option value="064" <c:if test="${data[0] eq '064'}">selected="selected"</c:if>>064</option>
						</select>
						-
						<input type="text" id="userPhone2" name="userPhone2" value="${data[1]}" class="input_txt tel" title="자택전화 중간 4자리" >
						-
						<input type="text" id="userPhone3" name="userPhone3" value="${data[2]}" class="input_txt tel" title="자택전화 끝 4자리" >
					</td>
				</tr>
				<tr>
					<th ><label for="userMobile1">핸드폰번호</label></th>
					<td>
					<c:set var="data" value="${fn:split(result.userMobile,'-')}" />
						<select id="userMobile1" name="userMobile1" class="input_select" title="휴대전화 앞 세자리">
								<option value="">선택</option>
								<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
								<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
								<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
								<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
								<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
								<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
							</select>
							-
							<input type="text" id="userMobile2" name="userMobile2" value="${data[1]}" class="input_txt tel">
							<label for="ntcrMobile2" class="hidden">휴대전화 중간 4자리</label>
							-
							<input type="text" id="userMobile3" name="userMobile3" value="${data[2]}" class="input_txt tel">
							<label for="ntcrMobile3" class="hidden">휴대전화 끝 4자리</label>
					</td>
				</tr>
				<tr>
					<th width="120" ><label for="userName">주소</label></th>
					<td width="555" >
						<c:set var="data" value="${fn:split(result.postNo,'-')}" />

							<a href="/postSearch/road.jsp" onclick="postSearch(this.href,event);" target="_blank" title="새창열림" class="button post"><span>우편번호찾기</span></a>
							<label for="postNo1" class="hidden">우편번호 앞자리</label>
							<input type="text" id="ntcrZipcode1" name="postNo1" value="${data[0]}" class="input_txt w50 post_s">
							-
							<label for="postNo2" class="hidden">우편번호 뒷자리</label>
							<input type="text" id="ntcrZipcode2" name="postNo2" value="${data[1]}" class="input_txt w50 post_e">
						</p>
						<p>
							<label for="address1" class="hidden">기본주소</label>
							<input type="text" id="ntcrAddr1" value="${result.address1}" name="address1" class="input_txt w99per">
						</p>
						<p>
							<label for="address2" class="hidden">주소상세정보</label>
							<input type="text" id="ntcrAddr2" value="${result.address2}" name="address2" class="input_txt w99per">
						</p>
					</td>
				</tr>
				<tr>
					<th width="120" ><label for="userName">이메일</label></th>
					<td width="555" >
					<c:set var="data" value="${fn:split(result.userEmail,'@')}" />
						<input type="text" id="userEmail1" name="userEmail1" value="${data[0]}" class="input_txt w200" title="이메일 아이디" />
						@
						<input type="text" id="userEmail2" name="userEmail2" value="${data[1]}" class="input_txt w200" title="이메일 도메인" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

<h5 id="parentH5" class="bu_t1 h_t_m">보호자 정보</h5>
	<div id="parentDiv" class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th width="120" ><label for="parentName">보호자이름</label></th>
					<td width="555" >
						<input type="text" id="parentName" name="parentName" value="${result.parentName}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="parentCon">보호자와의 관계</label></th>
					<td>
						<input type="text" id="parentCon" name="parentCon" value="${result.parentCon}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="parentPhone1">보호자 전화번호</label></th>
					<td>
					<c:set var="data" value="${fn:split(result.parentPhone,'-')}" />
					<input type="text" id="parentPhone1" name="parentPhone1" value="${data[0]}" class="input_txt tel" title="보호자 전화번호 앞 3자리"  />
					-
					<input type="text" id="parentPhone2" name="parentPhone2" value="${data[1]}" class="input_txt tel" title="보호자 전화번호  중간 4자리" >
					-
					<input type="text" id="parentPhone3" name="parentPhone3" value="${data[2]}" class="input_txt tel" title="보호자 전화번호  끝 4자리" >
					</td>
				</tr>
			</tbody>
		</table>
	</div>

<h5 id="companyH5" class="bu_t1 h_t_m">기업정보</h5>
	<div id="companyDiv" class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th width="120" ><label for="companyName">기업명</label></th>
					<td width="555" >
						<input type="text" id="companyName" name="companyName" value="${result.companyName}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="ceoName">대표자 성명</label></th>
					<td>
						<input type="text" id="ceoName" name="ceoName" value="${result.ceoName}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="companyCode">사업자 등록번호</label></th>
					<td>
						<input type="text" id="companyCode" name="companyCode" value="${result.companyCode}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="companyJob">종/업태</label></th>
					<td>
						<input type="text" id="companyJob" name="companyJob" value="${result.companyJob}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="companyLiaison">담당자 성명</label></th>
					<td>
						<input type="text" id="companyLiaison" name="companyLiaison" value="${result.companyLiaison}" class="input_txt" />
					</td>
				</tr>
				<tr>
					<th ><label for="companyPhone1">대표전화</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.companyPhone,'-')}" />
						<select id="companyPhone1" name="companyPhone1" class="input_select" title="대표전화 지역번호" >
							<option value="">선택</option>
							<option value="02" <c:if test="${data[0] eq '02'}">selected="selected"</c:if>>02</option>
							<option value="051" <c:if test="${data[0] eq '051'}">selected="selected"</c:if>>051</option>
							<option value="053" <c:if test="${data[0] eq '053'}">selected="selected"</c:if>>053</option>
							<option value="032" <c:if test="${data[0] eq '032'}">selected="selected"</c:if>>032</option>
							<option value="062" <c:if test="${data[0] eq '062'}">selected="selected"</c:if>>062</option>
							<option value="042" <c:if test="${data[0] eq '042'}">selected="selected"</c:if>>042</option>
							<option value="052" <c:if test="${data[0] eq '052'}">selected="selected"</c:if>>052</option>
							<option value="044" <c:if test="${data[0] eq '044'}">selected="selected"</c:if>>044</option>
							<option value="031" <c:if test="${data[0] eq '031'}">selected="selected"</c:if>>031</option>
							<option value="033" <c:if test="${data[0] eq '033'}">selected="selected"</c:if>>033</option>
							<option value="043" <c:if test="${data[0] eq '043'}">selected="selected"</c:if>>043</option>
							<option value="041" <c:if test="${data[0] eq '041'}">selected="selected"</c:if>>041</option>
							<option value="063" <c:if test="${data[0] eq '063'}">selected="selected"</c:if>>063</option>
							<option value="061" <c:if test="${data[0] eq '061'}">selected="selected"</c:if>>061</option>
							<option value="054" <c:if test="${data[0] eq '054'}">selected="selected"</c:if>>054</option>
							<option value="055" <c:if test="${data[0] eq '055'}">selected="selected"</c:if>>055</option>
							<option value="064" <c:if test="${data[0] eq '064'}">selected="selected"</c:if>>064</option>
						</select>
						-
						<input type="text" id="companyPhone2" name="companyPhone2" value="${data[1]}" class="input_txt tel" title="대표전화 중간 4자리" >
						-
						<input type="text" id="companyPhone3" name="companyPhone3" value="${data[2]}" class="input_txt tel" title="대표전화 끝 4자리" >
					</td>
				</tr>
				<tr>
					<th ><label for="companyPhone1">휴대전화</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.companyPhone,'-')}" />
						<select id="companyMobile1" name="companyMobile1" class="input_select" title="기업 휴대전화 지역번호" >
							<option value="">선택</option>
							<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
							<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
							<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
							<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
							<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
							<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
						</select>
						-
						<input type="text" id="companyMobile2" name="companyMobile2" value="${data[1]}" class="input_txt tel" title="기업 휴대전화 중간 4자리" >
						-
						<input type="text" id="companyMobile3" name="companyMobile3" value="${data[2]}" class="input_txt tel" title="기업 휴대전화 끝 4자리" >
					</td>
				</tr>
				<tr>
					<th ><label for="companyPostNo1">사업장 소재지</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.companyPostNo,'-')}" />
						<a href="/postSearch/road.jsp?zipcode1=companyPostNo1&zipcode2=companyPostNo2&address1=companyAddress1&address2=companyAddress2" onclick="postSearch(this.href,event);" target="_blank" title="새창열림" class="button post"><span>사업장 소재지 우편번호찾기</span></a>
						<input type="text" id="companyPostNo1" name="companyPostNo1" value="${data[0]}" class="input_txt w50 post_s" title="사업장 소재지 우편번호 앞자리" >
						-
						<input type="text" id="companyPostNo2" name="companyPostNo2" value="${data[1]}" class="input_txt w50 post_e" title="사업장 소재지 우편번호 뒷자리" >
						<p>
							<input type="text" id="companyAddress1" value="${result.companyAddress1}" name="companyAddress1" class="input_txt w99per" title="사업장 소재지 기본주소" >
						</p>
						<p>
							<input type="text" id="companyAddress2" value="${result.companyAddress2}" name="companyAddress2" class="input_txt w99per" title="사업장 소재지 주소상세정보" >
						</p>
					</td>
				</tr>
				<tr>
					<th ><label for="companyEmail1">대표 이메일</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.companyEmail,'@')}" />
						<input type="text" id="companyEmail1" name="companyEmail1" value="${data[0]}" class="input_txt" title="대표 이메일 아이디" />
						@
						<input type="text" id="companyEmail2" name="companyEmail2" value="${data[1]}" class="input_txt" title="대표 이메일 도메인" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>


<h5 class="bu_t1 h_t_m">사용여부</h5>
	<div class="bdView">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사용여부</th>
					<td>
				<input type="radio" id="delState1" name="delState " value="1" class="input_radio" <c:if test="${empty result.delState or result.delState eq '1'}"> checked="checked"</c:if> /> <label for="delState1">사용</label>
				<input type="radio" id="delState2" name="delState " value="0" class="input_radio" <c:if test="${result.delState eq '0'}"> checked="checked"</c:if> /> <label for="delState2">사용하지않음</label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="fr" >
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		<c:url var="url" value="/bos/user/member/list.do?${pageQueryString}" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
</div>

</head>
</html><c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>