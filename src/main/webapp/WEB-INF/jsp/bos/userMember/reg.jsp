<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">

	$(function(){

 		if ($(':radio[name="resdncSe"]:checked').val() == '02') {
			$("#sido").hide();
			$("#gugun").hide();
			$("#resdncOvsea").show();
			$("#resdncOvsea2").show();
		}
		else {
			$("#sido").show();
			$("#gugun").show();
			$("#resdncOvsea").hide();
			$("#resdncOvsea2").hide();
		}

		$("input[name=resdncSe]").click(function(){
			var val = $(this).val();
			if (val=="02") {
				$("#sido").hide();
				$("#gugun").hide();
				$("#resdncOvsea").show();
				$("#resdncOvsea2").show();
			}
			else {
				$("#sido").show();
				$("#gugun").show();
				$("#resdncOvsea").hide();
				$("#resdncOvsea2").hide();
			}
		});

		var sidoVal = "${result.sido}";
		var gugunVal = "${result.gugun}";

		jQuery(function(){
			if (sidoVal != "") getCodeList("gugun", 'COM063', $("#sido").val(), 2, gugunVal);

			$("select[name=sido]").change(function(){
				var val = $(this).val();
				getCodeList("gugun", 'COM063', val, 2);
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
					$("<option>").text("구군 선택").attr("value","").appendTo($obj);
					$.each(data.list, function(key,item) {
						var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
						if (code == item.code) $codeItem.attr("selected",true);
						$codeItem.appendTo($obj);
					});
					if ("gugun" == elemntId && "" == upperCode) {
						$("<option>").text("구군 선택").attr("value","").appendTo($("#gugun").empty());
					}
				}
			},"json");
		}

	});

	var mode = "${empty result ? 'I' : 'M'}";

	function checkForm() {
		var form = document.f_regi;
		var v = new MiyaValidator(form);

		v.add("userNm", {
			required : true
		});
		v.add("brthdy", {
			required : true
		});
		v.add("sex", {
			required : true
		});

		if (mode == "I") {
	 	    v.add("userId", {
	 	    	required: true,
		        pattern: "^[a-z0-9]{6,16}$",
	 	        message: "6자리이상 16자리 이내로 입력가능 합니다."
	 	    });
		}
		//rsg20171108
		if ($("#email1").val() == "" && $("#email2").val() == ""){
			alert("이메일 입력 2칸 모두 공란으로 비워두실 수 없습니다.");return;
		}
/* 
		v.add("email1", {
			required : true,
			span : 2,
			glue : "@",
			option : "email"
		});
		 */
		v.add("mbtlnum1", {
			required : true,
			span : 3,
			glue : "-",
			option : "handphone"
		});

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

    function check_txt(value) {
	    if (isNaN(value)) {
	  	  alert("숫자만 입력가능합니다.");
	    return "";
		}
	    else {
	    	return value;
	    }
	}

</script>

<form name="f_regi" method="post" action="/bos/userMember/${empty result ? 'insert' : 'update'}.do" enctype="multipart/form-data">
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}" />
	<input type="hidden" name="userSn" value="${result.userSn}"/>
	<input type=hidden name="pageQueryString" value='${pageQueryString}'/>
	<h4>인적사항</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>회원정보 필수정보 입력</caption>
			<colgroup>
				<col style="width:15%" />
				<col  />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="userNm">이름</label></th>
					<td><input type="text" name="userNm" id="userNm" value="${result.userNm}" /></td>
				</tr>
				<tr>
					<th><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 생년월일 / <span class="hide_star"><span class="sr-only">(필수입력)</span></span> 성별</th>
					<td><input type="text" id="sdate" name="brthdy"  class="sdate" title="생년월일" style="width:130px" value="<fmt:formatDate value="${result.brthdy }" pattern="yyyy-MM-dd"/>" />
							<label for="sex1"><input type="radio" name="sex" value="M" id="sex1" <c:if test="${result.sex eq 'M'}">checked="checked"</c:if> /> 남자 </label>
							<label for="sex2"><input type="radio" name="sex" value="W" id="sex2" <c:if test="${result.sex eq 'W'}">checked="checked"</c:if> /> 여자 </label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<h4>로그인 정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			<colgroup>
				<col style="width:15%" />
				<col  />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="userId">아이디</label></th>
					<td><div>
						<input type="text" name="userId" id="userId" value="${result.userId}" title="아이디를 입력하세요." />
						<span class="text-primary">● 사용가능한 아이디입니다.</span>
						<span class="text-danger">● 사용 불가능한 아이디입니다.</span>

					</div>
					<div>※ 6~16자까지 영문자(대소문자), 숫자 및 특수문자(제외 : !, &amp;, #, ?) 사용 가능합니다.</div></td>
				</tr>
			</tbody>
		</table>
	</div>

	<h4>회원 정보 추가 입력</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<h5>필수항목</h5>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
				<col style="width:15%" />
				<col  />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이메일</th>
					<td>
						<c:set var="data" value="${fn:split(result.email,'@')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 2}">
								<input name="email1" id="email1" type="text" title="이메일 아이디" value="${data[0]}" />
							@
							<input name="email2" id="email2" type="text" title="이메일 주소" value="${data[1]}" class="emaildomain_form" />
							</c:when>
							<c:otherwise>
								<input name="email1" id="email1" type="text" title="이메일 아이디" value="" />
							@
							<input name="email2" id="email2" type="text" title="이메일 주소" value="" class="emaildomain_form" />
							</c:otherwise>
						</c:choose>
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
						※ 관리자 등록 시 별도 승인 없이 인증됩니다.
					</td>
				</tr>
				<tr>
					<th><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 휴대폰</th>
					<td>
						<c:set var="data" value="${fn:split(result.mbtlnum,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="mbtlnum1" id="mbtlnum1" title="휴대폰 앞자리를 선택해 주세요." >
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
									<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
									<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
									<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
									<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
									<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
								</select>
								-
								<input type="text" id="mbtlnum2" name="mbtlnum2" value="${data[1]}" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
								-
								<input type="text" id="mbtlnum3" name="mbtlnum3" value="${data[2]}" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
							</c:when>
							<c:otherwise>
								<select name="mbtlnum1" id="mbtlnum1" title="휴대폰 국번 앞 3자리" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								-
								<input type="text" value="" id="mbtlnum2" name="mbtlnum2" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
								-
								<input type="text" value="" id="mbtlnum3" name="mbtlnum3" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
							</c:otherwise>
						</c:choose>
					※ 관리자 등록 시 별도 승인 없이 인증됩니다.

					</td>
				</tr>
				<tr>
					<th><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 정보수신 여부</th>
					<td>서비스 및 이벤트 소식을
						<label for="emailAt"><input type="checkbox" name="emailAt" value="Y" id="emailAt" <c:if test="${result.emailAt eq 'Y'}">checked="checked"</c:if>/> Email로 수신하겠습니다.</label>
						<label for="smsAt"><input type="checkbox" name="smsAt" value="Y" id="smsAt" <c:if test="${result.smsAt eq 'Y'}">checked="checked"</c:if>/> SMS로 수신하겠습니다.</label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<h5>선택항목</h5>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
				<col style="width:15%" />
				<col  />
			</colgroup>
			<tbody>
				<tr>
					<th>거주지</th>
					<td>
						<input type="radio" name="resdncSe" id="resdncSe1" value="01" <c:if test="${empty result or result.resdncSe eq '01'}" >checked="checked"</c:if> /><label for="resdncSe1">국내</label>
						<input type="radio" name="resdncSe" id="resdncSe2" value="02" <c:if test="${result.resdncSe eq '02'}" >checked="checked"</c:if> /><label for="resdncSe2">해외</label>
						<select name="sido" id="sido" title="시도를 선택해 주세요.">
							<option value="">시도 선택</option>
							<c:forEach var="code" items="${COM063CodeList}">
								<c:if test="${code.upperCode eq 0}">
									<option value="<c:out value="${code.code}" />" <c:if test="${result.sido eq code.code}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
								</c:if>
							</c:forEach>
						</select>
						<select name="gugun" id="gugun" title="구군을 선택해 주세요.">
							<option value="">구군 선택</option>
						</select>

						<label for="resdncOvsea" id="resdncOvsea2"> 해외</label>
						<input type="text" name="resdncOvsea" id="resdncOvsea" style="width:50%" value="${result.resdncOvsea}" title="해외 주소를 입력하세요." />
					</td>
				</tr>
				<tr>
					<th>직업</th>
					<td>
						<select name="job" id="job" title="직업을 선택해 주세요.">
							<option value="">직업 선택</option>
						<c:forEach var="code" items="${COM056CodeList}" varStatus="status">
							<option value="${code.code}" <c:if test="${result.job eq code.code}">selected="selected"</c:if>><c:out value="${code.codeNm}"/></option>
						 </c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>


<div class="btnSet">
	<a class="btn btn-primary" href="javascript:checkForm();">
		<span>${empty result ? '등록' : '수정'}</span>
	</a>
	<c:url var="url" value="/bos/userMember/list.do">
		<c:param name="menuNo" value="${param.menuNo}"></c:param>
		<c:param name="searchType" value="${param.searchType}"></c:param>
		<c:param name="searchTxt" value="${param.searchTxt}"></c:param>
		<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}"></c:param>
	</c:url>
	<a class="btn btn-primary" href="${url}">
		<span>취소</span>
	</a>
</div>
