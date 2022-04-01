<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'file_1'}">
			<c:set var="fileVO" value="${fileList[x]}" />
		</c:if>
	</c:forEach>
</c:if>
<c:choose>
<c:when test="${not empty result }">
<c:url value="/edu/job/empymnCnsl/update.do" var="urlForm">
<c:param name="menuNo" value="${param.menuNo }"/>
</c:url>
</c:when>

<c:when test="${empty result }">
<c:url value="/edu/job/empymnCnsl/insert.do" var="urlForm">
<c:param name="menuNo" value="${param.menuNo }"/>
</c:url>
</c:when>
</c:choose>
<c:if test="${fn:length(fileList) gt 0}">
	<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
		<c:if test="${fileList[x].fileFieldName eq 'file_1'}">
			<c:set var="fileVO" value="${fileList[x]}"/>
		</c:if>
	</c:forEach>
</c:if>



<script type="text/javascript">
//<![CDATA[
/* 시도 관련 코드  */
var sidoval = "<c:out value='${result.sido}'  />";
var gugunVal = "<c:out value='${result.gugun}' />";
var codeIdVal = "<c:out value='${codeId0}'/>";
/* ##시도 관련 코드##  */

	$(window).ready(function() {
		email_change();
		email_emptyChk();
		$('#sido').val("<c:out value='${result.sido }'/>").attr("selected","selected");
	});



	$(function() {

		$("input[name=memSelectTp]").click(function() {
			if ($(this).val() == "0") {
				$("#userNm").attr("readonly",false);
				$("#userSn").val("");
			}
			else {
				$("#userNm").attr("readonly",true);
			}
		});

		/* 시도 구분  */
		if (sidoval != "") {
			getCodeList("gugun",codeIdVal,$("#sido").val(),2,gugunVal);
		}

		$("select[name=sido]").change(function() {
			var val = $(this).val();
			getCodeList("gugun", codeIdVal, val, 2);
		});

		$("input[name=resdncSe]").click(function() {
			var val = $(this).val();
			if(val == "02"){
				$("#sido").hide();
				$("#gugun").hide();
				$("#sido").val("");
				$("#gugun").val("");
				$("#resdncOvsea").show();
			}else {
				$("#sido").show();
				$("#gugun").show();
				$("#resdncOvsea").hide();
				$("#resdncOvsea").val("");
			}
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
				$("<option>").text("분류 선택").attr("value","").appendTo($obj);
				$.each(data.list, function(key,item) {
					var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
					if (code == item.code) $codeItem.attr("selected",true);
					$codeItem.appendTo($obj);
				});
				if ("gugun" == elemntId && "" == upperCode) {
					$("<option>").text("분류 선택").attr("value","").appendTo($("#gugun").empty());
				}
			}
		},"json");
	}


	function checkForm(form) {

		var v= new MiyaValidator(form);

 		v.add("userNm", {
	        required: true
	    });

 		v.add("brthdy", {
	        required: true
	    });

 		v.add("sex", {
	        required: true
	    },"성별");

 		v.add("emlid", {
	        required: true
	    });

 		v.add("emailAddr", {
	        required: true
	    });

 		v.add("mbtlnum1", {
	        required: true
	    });

 		v.add("mbtlnum2", {
	        required: true
	    });

 		v.add("mbtlnum3", {
	        required: true
	    });

 		v.add("resdncSe", {
	        required: true
	    },"거주지");
 		if($("#resdncSe1").is(":checked"))
		{
 	 		/* 시도 */
 		v.add("sido", {
	        required: true
	    });

 		v.add("gugun", {
	        required: true
	    });

		}

 		if($("#resdncSe2").is(":checked"))
		{
		/* 외국인 */
 		v.add("resdncOvsea", {
	        required: true
	    });
		}



		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}


		if (!confirm('등록하시겠습니까?')) {
			return false;
		}

		var cnsltReqCnSe = "";
		$(":input[name^=cnsltReqCnSeData]:checked").each(function(){
			cnsltReqCnSe += $(this).val() + ",";
		});
		cnsltReqCnSe = cnsltReqCnSe.substring(0,cnsltReqCnSe.length-1);
		$("#cnsltReqCnSe").val(cnsltReqCnSe);


	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delete.do";
		form.submit();
	}

	function openPopup()
	{
		url = "/bos/deptPop/list.do?board=Y";
		window.open(url, "deptName", "resizable=no, status=no, scrollbars=no, toolbar=no, menubar=no, width=800, height=700");
	}

	function email_emptyChk(){
		var emilchk = $("#sr_email_more option:selected").text();
		if($.trim(emilchk) == ""){
			$('#sr_email_more').val("emaildomain_false").attr("selected","selected");
		}else{
			$('.email_addr').attr("readonly",true);
		}

	}
	function email_change(){
		$('select.email_addr').change(function() {
			if ($(this).val()=='emaildomain_false') {
				$('.email_addr:text[name=emailAddr]').val('');
				$('.email_addr').attr('readonly',false).focus();
			}else{
				$('.email_addr:text[name=emailAddr]').val('');
				$('.email_addr:text[name=emailAddr]').val($(this).val());
				$('.email_addr').attr('readonly',true);
			}
		});
	}


	function delFile2(atchFileId, fileSn, programId, fileId){
		$.getJSON(
				"/edu/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn, programId : programId},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\"  class=\"input_file form-control\"/>");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}

	//]]>
</script>
<form name="agreeForm" enctype="multipart/form-data" action="<c:out value="${urlForm }" />" method="post" onsubmit="return checkForm(this);"  >
<input type="hidden" name="menuNo" value="${param.menuNo }" >
<input type="hidden" name="atchFileId" value="${result.atchFileId }" >
<input type="hidden" name="cnslSn" value="${result.cnslSn }" >
<input type="hidden" name="replyAt" value="N" >
<input type="hidden" name="cnsltReqCnSe" id="cnsltReqCnSe" value="" >
	<h3>기본정보입력</h3>
	<div class="bdView sub_board_body">
		<div class="board_caption"><span>표시 항목은 필수 입력 항목입니다.</span></div>
		<table class="table table-bordered contents_insight_view style_0" summary=" ">
			<caption>기본정보입력
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col  />
			</colgroup>
			<tbody>


				<tr>
					<th scope="row"><label for="userNm"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 이름</label></th>
					<td>
					<c:choose>
						<c:when test="${empty result.userNm }">
							<c:set var="userNm" value="${userInfo.userNm }" />
						</c:when>
						<c:otherwise>
							<c:set var="userNm" value="${result.userNm }" />
						</c:otherwise>
					</c:choose>
					<input type="text" class="input_style_3" name="userNm" id="userNm" value="<c:out value="${userNm }"/>" title="이름"/>
					</td>
				</tr>
				<tr>
					<c:choose>
						<c:when test="${empty result.brthdy }">
							<c:set var="brthdy" value="${userInfo.brthdy }" />
						</c:when>
						<c:otherwise>
								<c:set var="brthdy" value="${result.brthdy }" />
						</c:otherwise>
					</c:choose>
					<th scope="row"><label for="brthdy"><span class="hide_star"><span class="sr-only">(필수입력)</span></span>생년월일</label></th>
					<td><input type="text" id="brthdy" name="brthdy"  readonly="readonly" class="sdate input_style_3" title="생년월일 입력" style="width:130px" value="<c:out value="${brthdy }" />" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="sex"><span class="hide_star"><span class="sr-only">(필수입력)</span></span>성별</label></th>
					<td>
					<c:choose>
						<c:when test="${empty result.sex }">
							<c:set var="sex" value="${userInfo.sex }" />
						</c:when>
						<c:otherwise>
								<c:set var="sex" value="${result.sex }" />
						</c:otherwise>
					</c:choose>
					<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
						<input type="radio" name="sex" id="sex${status.count}" value="${code.code}" <c:if test="${fn:indexOf(sex, code.code) != -1}">checked="checked"</c:if>>
						<label for="sex<c:out value="${status.count}" />">	${code.codeNm} </label>
					</c:forEach>
					</td>
				</tr>
				<tr>
					<c:choose>
						<c:when test="${empty result.sex }">
							<c:set var="email" value="${userInfo.email }" />
						</c:when>
						<c:otherwise>
								<c:set var="email" value="${result.email }" />
						</c:otherwise>
					</c:choose>
					<c:set var="data" value="${fn:split(email,'@')}" />
					<th><label for="emlid"><span class="hide_star"><span class="sr-only">(필수입력)</span></span>이메일</label></th>
					<td><input type="text" name="emlid" id="emlid" class="w20p input_style_3" style="min-width:120px;" value="<c:out value="${data[0] }" />" title="이메일 아이디를 입력하세요." />
						@ <input type="text" name="emailAddr" id="emailAddr" class="w30p input_select email_addr input_style_3" style="min-width:120px;" value="<c:out value="${data[1] }" />" title="이메일 도메인 주소를 입력하세요." />
						<select name="sr_email_more" id="sr_email_more" class="email_addr" title="이메일 도메인을 선택해 주세요.">
							<option value="">이메일 선택</option>
							<option value="gmail.com"   >gmail.com</option>
							<option value="naver.com">naver.com</option>
		                    <option value="hanmail.net">hanmail.net</option>
		                    <option value="daum.net">daum.net</option>
		                    <option value="hotmail.com">hotmail.com</option>
		                    <option value="nate.com">nate.com</option>
		                    <option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="emaildomain_false">직접입력</option>
						</select>
					</td>
				</tr>
				<script type="text/javascript">
				//<![CDATA[
					$('#sr_email_more').val("<c:out value='${data[1] }'/>").attr("selected","selected");
				//]]>
				</script>
				<c:remove var="data" />
					<c:choose>
						<c:when test="${empty result.mbtlnum }">
							<c:set var="moblphon" value="${userInfo.moblphon }" />
						</c:when>
						<c:otherwise>
								<c:set var="moblphon" value="${result.mbtlnum }" />
						</c:otherwise>
					</c:choose>
				<c:set var="data" value="${fn:split(moblphon,'-')}" />
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 휴대폰</th>
					<td>
					<select name="mbtlnum1" id="mbtlnum1" title="(필수입력) 휴대폰번호 앞자리를 선택해 주세요." style="margin-right:0;">
							<option value="">선택</option>
							<option value="010" <c:if test="${data[0] eq '010'}"> selected="selected"</c:if>>010</option>
							<option value="011" <c:if test="${data[0] eq '011'}"> selected="selected"</c:if>>011</option>
							<option value="016" <c:if test="${data[0] eq '016'}"> selected="selected"</c:if>>016</option>
							<option value="017" <c:if test="${data[0] eq '017'}"> selected="selected"</c:if>>017</option>
							<option value="018" <c:if test="${data[0] eq '018'}"> selected="selected"</c:if>>018</option>
							<option value="019" <c:if test="${data[0] eq '019'}"> selected="selected"</c:if>>019</option>
					</select>
					- <input type="text" name="mbtlnum2" id="mbtlnum2" class="w20p input_style_3" maxlength="4" value="<c:out value="${data[1] }" />" title="(필수입력) 휴대폰번호 중간자리를 입력하세요." />
					- <input type="text" name="mbtlnum3" id="mbtlnum3" class="w20p input_style_3" maxlength="4" value="<c:out value="${data[2] }" />" title="(필수입력) 휴대폰번호 끝자리를 입력하세요." /></td>
				</tr>
				<c:remove var="data" />
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 거주지</th>
					<td>
						<input type="radio" name="resdncSe" value="01" id="resdncSe1" <c:if test="${result.resdncSe eq '01'}">checked="checked"</c:if> />
						<label for="resdncSe1">국내</label>
						<input type="radio" name="resdncSe" value="02" id="resdncSe2" <c:if test="${result.resdncSe eq '02'}">checked="checked"</c:if> />
						<label for="resdncSe2">해외</label>
						<select name="sido" id="sido" title="시도를 선택해 주세요." <c:if test="${not empty result and result.resdncSe ne '01' }">style="display: none;"</c:if> >
						<option value="" >시도 선택</option>
						<c:forEach var="item" items="${COM063CodeList }">
							<option value="<c:out value="${item.code }"/>"  ><c:out value="${item.codeNm }"/></option>
						</c:forEach>
						</select>
						<select name="gugun" id="gugun" title="구군을 선택해 주세요." <c:if test="${not empty result and result.resdncSe ne '01' }">style="display: none;"</c:if>>
						<option value="" >구군 선택</option>
						</select>
						<input type="text" class="input_style_3" name="resdncOvsea" id="resdncOvsea" style="width:200px;<c:if test="${(not empty result and result.resdncSe ne '02') or empty result }">display: none;</c:if>" value="<c:out value="${result.resdncOvsea }" />" onFocus="if(this.value=='해외인 경우 입력해주세요.') this.value='';"  title="해외인 경우 입력해주세요."     >
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<h3>추가정보</h3>
	<div class="bdView sub_board_body">
		<div class="board_caption"><span>표시 항목은 필수 입력 항목입니다.</span></div>
		<table cellspacing="0" cellpadding="0" class="table table-bordered contents_insight_view style_0" summary=" ">
			<caption>추가정보입력</caption>
			<colgroup>
			<col style="width:18%" />
			<col  />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="schul"> 학교</label></th>
					<td><input type="text" title="학교 입력" name="schul" id="schul" class="input_style_3" value="<c:out value="${result.schul }" />" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="subjct">학과</label></th>
					<td><input type="text" title="학과 입력" name="subjct" id="subjct" class="input_style_3" value="<c:out value="${result.subjct }" />" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="grade"> 학년</label></th>
					<td>
						<input type="text" title="학년 입력" name="grade" id="grade" class="input_style_3" value="<c:out value="${result.grade }" />" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="hopeJssfc">희망직무(공통)</label></th>
					<td><input type="text" class="input_style_3" title="희망직무(공통) 입력" name="hopeJssfc" id="hopeJssfc" title="희망직무" value="<c:out value="${result.hopeJssfc }" />" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="cnsltReqCnEtc"> 상담신청내용</label></th>
					<td>
						<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
							<span class="check_style_0_con">
								<input type="checkbox" class="check_style_0" name="cnsltReqCnSeData" id="cnsltReqCnSeData${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.cnsltReqCnSe, code.code) ne -1}">checked="checked"</c:if>>
								<label for="cnsltReqCnSeData${status.count}">${code.codeNm}</label>
							</span>
							<c:if test="${status.last }">(<input type="text" class="input_style_3" name="cnsltReqCnEtc" id="cnsltReqCnEtc" title="기타 내용을 입력해 주세요." maxlength="20" value="<c:out value="${result.cnsltReqCnEtc }" />" />)</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="PROFL1">이력서</label></th>
					<td>
						<div class="text-danger clear">이력서 검토 요청을 하실 경우에는 이력서양식을 다운로드 받아서 작성 후 첨부해주시기 바랍니다.</div>
						<div id="file_1" class="col-12 col-md-6" style="border:1px solid #e3e6e9; border-radius:3px;">
						<c:choose>
						 <c:when test="${empty fileVO  }">
						<input type="file" name="file_1"  title="이력서 등록 " class="col-md-8" />
						<br />
						</c:when>
						<c:otherwise>
						<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
							<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
						</a>
						<a href="#" onclick="javascript:delFile2('${fileVO.atchFileId}', '${fileVO.fileSn}', '${masterVO.bbsId}','file_1');">
							<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileVO.fileCn}"/> 삭제" />
						</a>
						</c:otherwise>
						</c:choose>
						</div>
						<span class="col-12 col-md-6 btn_style_2_con tr first last file_btn_con">
							<a href="/upload/culturist/resume.hwp" class="btn_style_2 file" title="새창열림" target="_blank">이력서 양식 다운로드</a>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="board_util_btn_con">
	<a href="/" class="btn_style_0 close">취소</a>
	<c:choose>
	<c:when test="${not empty result }">
		<button type="submit" class="btn_style_0 full edit">수정</button>
	</c:when>
	<c:when test="${empty result }">
		<button type="submit" class="btn_style_0 full check">신청</button>
	</c:when>
	</c:choose>
	</div>

</form>



















<%--########################################################################################################################## --%>


