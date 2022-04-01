<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.do" />
</c:if>
	<%--데이터 전화번호, Emil 등등등 --%>
	<%--휴대전화번호 체크 --%>
	<%--전화번호 체크 --%>
<c:if test="${not empty result.ntcrHp }" >
	 <c:set var="ntcrHp" value="${fn:split(result.ntcrHp,'-')}" />
</c:if>

<c:if test="${not empty result.ntcrTel }" >
	<c:set var="ntcrTel" value="${fn:split(result.ntcrTel,'-')}" />
</c:if>

<c:if test="${not empty result.ntcrEmail }" >
	<c:set var="ntcrEmail" value="${fn:split(result.ntcrEmail,'@')}" />
</c:if>



<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">

$(window).ready(function() {
	<c:if test="${not empty ntcrTel }" >
	$('#ntcrTel1').val("<c:out value='${ntcrTel[0] }'/>").attr("selected","selected");
	</c:if>
	<c:if test="${not empty ntcrHp }" >
	$('#ntcrHp1').val("<c:out value='${ntcrHp[0] }'/>").attr("selected","selected");
	</c:if>
	<c:if test="${not empty ntcrEmail }" >
	$('#sr_email_more').val("<c:out value='${ntcrEmail[1] }'/>").attr("selected","selected");
	email_emptyChk()
	</c:if>
	email_change();



	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$(".calendar").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

});


	function checkForm() {
		var form = $("#board")[0];
// 		var v = new MiyaValidator(form);

/* 		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		} */

/* 		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		} */

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		var option18= "";
		$(":input[name^=option18Data]:checked").each(function(){
			option18 += $(this).val() + ",";
		});

		option18 = option18.substring(0,option18.length-1);
		$("#option18").val(option18);


		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
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
				$('.email_addr:text[name=ntcrEmail2]').val('');
				$('.email_addr').attr('readonly',false).focus();
			}else{
				$('.email_addr:text[name=ntcrEmail2]').val('');
				$('.email_addr:text[name=ntcrEmail2]').val($(this).val());
				$('.email_addr').attr('readonly',true);
			}
		});
	}
	function delFile2(atchFileId, fileSn, bbsId, fileId) {
		$.getJSON(
			"/bos/cmm/fms/deleteFileInfs.json",
			{
				atchFileId : atchFileId,
				fileSn : fileSn
				,
				bbsId : bbsId
			},
			function(data) {
				var jdata = data.resultCode;
				if (jdata == 'success') {
					alert("성공적으로 삭제하였습니다.");
					$("#" + fileId)
							.html(
									"<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/>");
				} else
					alert("삭제에 실패하였습니다.");
			});
	}


</script>



<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

	<div id="content">

			<h4>기본정보입력</h4>
			<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
				<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
					<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
					<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
					<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
					<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
					<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
					<input type="hidden" id="option18" name="option18" value="" />
			<div class="bdView">

				<table class="table table-bordered">
					<caption>기본정보입력</caption>
					<colgroup>
					<col style="width:15%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:15%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="nttSj">기관명</label></th>
							<td colspan="4" >
								<input type="text" name="nttSj" id="nttSj" style="width: 100%;" value="${result.nttSj }" title="기관명" class="w500" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="ntcrAddr1">주소</label></th>
							<td colspan="4" >
								<input type="text" name="ntcrAddr1" id="nterAddr1" style="width: 100%;" value="${result.ntcrAddr1 }" title="주소" class="w500" />
							</td>
						</tr>

						<tr >
							<th scope="row" rowspan="2">
							<label>담당자</label></th>
							<th>부서/직급	</th>
							<td><input type="text" id="option1" name="option1" value="${result.option1 }" /> </td>
							<th scope="row" scope="row" >유선전화</td>
							<td>
								<select id="ntcrTel1" name="ntcrTel1" id="ntcrTel1"  class="input_select" >
									<option value="" selected="selected">선택</option>
									<option value="02" >02</option>
									<option value="070" >070</option>
									<option value="051" >051</option>
									<option value="053" >053</option>
									<option value="032" >032</option>
									<option value="062" >062</option>
									<option value="042" >042</option>
									<option value="052" >052</option>
									<option value="044" >044</option>
									<option value="031" >031</option>
									<option value="033" >033</option>
									<option value="043" >043</option>
									<option value="041" >041</option>
									<option value="063" >063</option>
									<option value="061" >061</option>
									<option value="054" >054</option>
									<option value="055" >055</option>
									<option value="064" >064</option>
									<option value="0505" >0505</option>
									<option value="0506" >0506</option>
								</select>
								<input type="text" id="ntcrTel2" class="input_txt tel" name="ntcrTel2" maxlength="4" value="${ntcrTel[1] }" />
								<input type="text" id="ntcrTel3" class="input_txt tel" name="ntcrTel3" maxlength="4" value="${ntcrTel[2] }" />
							</td>
						</tr>
						<tr>
							<th>성명</th>
							<td>	<input type="text" name="ntcrNm" id="ntcrNm" value="${result.ntcrNm }" />
							</td>
							<th>이메일</th>
						 	<td>
						 		<input id="ntcrEmail1" class="board1 email_id" name="ntcrEmail1" type="text" value="${ntcrEmail[0] }" style="width:32%"/>@
							 	<input type="text" id="ntcrEmail2" class="board1 email_addr" name="ntcrEmail2" value="${ntcrEmail[1] }" style="width:32%"/>
							 	<select id="sr_email_more" name="sr_email_more" class="input_select email_addr" style="width:auto" title="이메일 주소">
							 			<option value=""> 이메일 선택</option>
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
						<tr>
						 	<th>기관구분</th>
						 	<td colspan="2">
						 		<c:forEach items="${COM161CodeList }" var="code" varStatus="status">
									<span class="radio_box_con">
										<input type="radio" value="<c:out value='${code.code }'/>" id="option12Data${status.count }" title="신청분야" name="option12" class="radio_style_0" <c:if test="${code.code eq result.option12}">checked="checked"</c:if>/>
										<label for="option12Data${status.count }">${code.codeNm }</label>
									</span>
								</c:forEach>
						 	</td>
							<th>홈페이지</th>
						 	<td colspan="2">
						 		<input type="text" id="option2" name ="option2" value="${result.option2 }" />
						 	</td>
						</tr>
						<tr>
							<th scope="row"><label for="option13">운영목적</label></th>
							<td colspan="4" >
								<input type="text" name="option13" id="option13" style="width: 100%;" value="${result.option13 }" title="운영목적" class="w500" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="option14">기관소개</label></th>
							<td colspan="4" >
								<textarea name="option14" id="option14" cols="120" rows="12" class="col-md-12" title="기타문의" style="width:100%">${result.option14 }</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>


			<h4>학습정보입력</h4>
			<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>
					</caption>
					<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col  />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 운영계획</th>
							<td colspan="3">
								<span class="radio_box_con">
									<input type="radio" value="정기" id="option15Data1" title="운영계획" name="option15" class="radio_style_0" <c:if test="${result.option15 eq '정기'}">checked="checked"</c:if>/>
									<label for="option15Data1">정기</label>
								</span>
								
								<span class="radio_box_con">
									<input type="radio" value="비정기" id="option15Data2" title="운영계획" name="option15" class="radio_style_0" <c:if test="${result.option15 eq '비정기'}">checked="checked"</c:if>/>
									<label for="option15Data2">비정기</label>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row">수강신청기간</th> <!-- option3 ~ option4 -->
							<td>
								<input type="text" class="calendar" readonly="readonly" value="${result.option3 }" name="option3" id="option3"/>~
								<input type="text" class="calendar" readonly="readonly" value="${result.option4 }" name="option4" id="option4"/>
							</td>
							<th scope="row">학습기간</th>
							<td>
								<input type="text" class="calendar" readonly="readonly" value="${result.option16 }" name="option16" id="option16"/>~
								<input type="text" class="calendar" readonly="readonly" value="${result.option17 }" name="option17" id="option17"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 신청분야</th>
							<td colspan="3">
								<c:forEach items="${COM074CodeList }" var="code" >
									<input type="checkbox" value="${code.code }" id="option18Data${status.count }" name="option18Data" <c:if test="${fn:indexOf(result.option18, code.code) != -1}">checked="checked"</c:if> />
									<label for="option18Data${status.count }">${code.codeNm } </label>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th scope="row">신청과정</th>
							<td colspan="3">
								<input type="text" title="신청과정" name="option9" id="option9" value="${result.option9 }" style="width:100%"> 
							</td>
						</tr>
						<tr>
							<th scope="row">수료기준</th>
							<td colspan="3">
								<span class="radio_box_con">
										<input type="radio" value="60" id="option20Data1" title="수료기준" name="option20" class="radio_style_0" <c:if test="${result.option20 eq '60'}">checked="checked"</c:if>/>
										<label for="option20Data1">진도 60% 이상</label>
									</span>
									<span class="radio_box_con">
										<input type="radio" value="80" id="option20Data2" title="수료기준" name="option20" class="radio_style_0" <c:if test="${result.option20 eq '80'}">checked="checked"</c:if>/>
										<label for="option20Data2">진도 80% 이상</label>
									</span>
									<span class="radio_box_con">
										<input type="radio" value="100" id="option20Data3" title="수료기준" name="option20" class="radio_style_0" <c:if test="${result.option20 eq '100'}">checked="checked"</c:if>/>
										<label for="option20Data3">진도 100% 이상</label>
									</span> 
							</td>
						</tr>
						
						<tr>
							<th scope="row">예상입과인원</th>
							<td colspan="3">
								<input type="text" name="option7" id="option7" value="${result.option7 }"/> 명
							</td>
						</tr>
						<tr>
							<th scope="row">연수원도메인</th>
							<td colspan="3">
								http://<input id="option11" name="option11" value="${result.option11 }" type="text">.edukocca.kr
							</td>
						</tr>
						<tr>
							<th scope="row">LOGO 업로드</th>
							<td colspan="3">
								<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
									<c:if test="${not empty fileList}">
										<div id="${fileList[0].fileFieldName }" name="${fileList[0].fileFieldName }">
											<a href="/bos/cmm/fms/FileDown.do?atchFileId=${fileList[0].atchFileId}&amp;fileSn=${fileList[0].fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
													<c:out value="${fileList[0].orignlFileNm}"/>&nbsp;[<c:out value="${fileList[0].fileMg}"/>&nbsp;byte]
													</a>
													<a href="#" onclick="javascript:delFile2('${fileList[0].atchFileId}', '${fileList[0].fileSn}', '${masterVO.bbsId}','${fileList[0].fileFieldName }');">
												<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileList[0].fileCn}"/> 삭제" />
											</a>
									</c:if>
									<c:if test="${empty fileList }">
											 <input name="thumbImage" type="file" id="logImage" class="input_file form-control" title="첨부파일 1">
										</div>
									</c:if>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
</form>
	<c:if test="${not empty result}">
	<div class="fl">
<%-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> --%>
	</div>
	</c:if>
	<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
<%-- 		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a> --%>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
		</div>
	</div>
