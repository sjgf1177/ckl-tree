
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<%
		int year = egovframework.com.utl.DateUtil.getYear();
		pageContext.setAttribute("year", year);
%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/> --%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
$(window).ready(function() {
	email_change();
	email_emptyChk();
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$(".calendar").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

});
	function checkForm() {
		var form = $("#board")[0];
		var cnsltReqSe = "";

		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(



		    ); // 크로스에디터 Focus 이동
		    return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		var cont = CrossEditor.GetBodyValue();
		document.getElementById("cnsltReqCn").value= cont;

		$(":input[name^=cnsltReqSeData]:checked").each(function(){
			cnsltReqSe += $(this).val() + ",";
		});

		cnsltReqSe = cnsltReqSe.substring(0,cnsltReqSe.length-1);
		$("#cnsltReqSe").val(cnsltReqSe);
		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delPermanently.do";
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
				$('.email_addr:text[name=email2]').val('');
				$('.email_addr').attr('readonly',false).focus();
			}else{
				$('.email_addr:text[name=email2]').val('');
				$('.email_addr:text[name=email2]').val($(this).val());
				$('.email_addr').attr('readonly',true);
			}
		});
	}


	function delFile2(atchFileId, fileSn, programId, fileId){
		$.getJSON(
				"/bos/cmm/fms/deleteFileInfs.json",
				{atchFileId : atchFileId, fileSn : fileSn, programId : programId},
				function(data)
				{
					var jdata = data.resultCode;
		            if( jdata == 'success' ) {
		            	alert("성공적으로 삭제하였습니다.");
		            	$("#"+fileId).html("<input type=\"file\" name=\""+fileId+"\" id=\""+fileId+"\" class=\"input_file form-control\"/>");
		            }
		            else alert("삭제에 실패하였습니다.");
				}
			);
	}

</script>
<%-- ${paramVO } --%>
<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>
<div id="content">
<%-- ${masterVO } --%>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="cnslSn" value="${empty result.cnslSn ? 0 : result.cnslSn }" />
<%-- 	<input type="hidden" name="programId" value="${masterVO.programId}" /> --%>
<%-- 	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}"> --%>
		<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
		<input type="hidden" id="cnsltReqSe" name="cnsltReqSe"  />

			<h4>■ 상담자정보</h4>
			<div class="bdView">
				<table>
					<caption>
					상담자정보
					</caption>
					<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">회원여부</th>
							<td colspan="3">
								<input type="radio" name="option1"    value="0" <c:if test="${result.option1 eq '0' }"> checked="checked" </c:if> />직접입력
								<input type="radio" name="option1"	  value="1" <c:if test="${result.option1 eq '1' }"> checked="checked" </c:if> />회원선택 <br />
								<input type="text" name="userNm" value="${result.userNm }" />
							</td>
						</tr>
						<tr>
							<th scope="row">성별</th>
							<td>
							<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
									<input type="radio" name="sex" id="sex${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.sex, code.code) != -1}">checked="checked"</c:if>>${code.codeNm}
							</c:forEach>

							</td>
							<th scope="row">생년월일</th>
							<td>
							<input type="text" id="brthdy" name="brthdy" readonly="readonly"  value="${result.brthdy}" class="board1 calendar" title="생년월일"/>
							</td>
						</tr>
						<tr>
							<th scope="row">학교</th>
							<td>
							<input type="text" name="schul" id="schul" class="" value="${result.schul}" />
							</td>
							<th scope="row">학과</th>
							<td>
							<input type="text" name="subjct" id="subjct" class="" value="${result.subjct}" />
							</td>
						</tr>
							<tr>
							<th scope="row">자택</th>
							<td>
							 <c:set var="data" value="${fn:split(result.ownhomTelno,'-')}" />
		 				<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select id="ntcrTel1" name="ownhomTelno1" class="input_select" title="${formName }연락처 앞 자리">
									<option value="">선택</option>
									<option value="02" <c:if test="${data[0] eq '02'}"> selected="selected"</c:if>>02</option>
									<option value="070" <c:if test="${data[0] eq '070'}"> selected="selected"</c:if>>070</option>
									<option value="051" <c:if test="${data[0] eq '051'}"> selected="selected"</c:if>>051</option>
									<option value="053" <c:if test="${data[0] eq '053'}"> selected="selected"</c:if>>053</option>
									<option value="032" <c:if test="${data[0] eq '032'}"> selected="selected"</c:if>>032</option>
									<option value="062" <c:if test="${data[0] eq '062'}"> selected="selected"</c:if>>062</option>
									<option value="042" <c:if test="${data[0] eq '042'}"> selected="selected"</c:if>>042</option>
									<option value="052" <c:if test="${data[0] eq '052'}"> selected="selected"</c:if>>052</option>
									<option value="044" <c:if test="${data[0] eq '044'}"> selected="selected"</c:if>>044</option>
									<option value="031" <c:if test="${data[0] eq '031'}"> selected="selected"</c:if>>031</option>
									<option value="033" <c:if test="${data[0] eq '033'}"> selected="selected"</c:if>>033</option>
									<option value="043" <c:if test="${data[0] eq '043'}"> selected="selected"</c:if>>043</option>
									<option value="041" <c:if test="${data[0] eq '041'}"> selected="selected"</c:if>>041</option>
									<option value="063" <c:if test="${data[0] eq '063'}"> selected="selected"</c:if>>063</option>
									<option value="061" <c:if test="${data[0] eq '061'}"> selected="selected"</c:if>>061</option>
									<option value="054" <c:if test="${data[0] eq '054'}"> selected="selected"</c:if>>054</option>
									<option value="055" <c:if test="${data[0] eq '055'}"> selected="selected"</c:if>>055</option>
									<option value="064" <c:if test="${data[0] eq '064'}"> selected="selected"</c:if>>064</option>
								</select>
								-
								<input type="text" id="ownhomTelno2" name="ownhomTelno2" value="${data[1]}" class="input_txt tel" title="${formName }연락처 중간 4자리" maxlength="4" />
								-
								<input type="text" id="ownhomTelno3" name="ownhomTelno3" value="${data[2]}" class="input_txt tel" title="${formName }연락처 끝 4자리" maxlength="4" />
							</c:when>

							<c:otherwise>
							<select id="ntcrTel1" name="ownhomTelno1" id="ownhomTelno1"  >
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
								</select>
								-
								<input type="text" id="ownhomTelno2" name="ownhomTelno2" class="input_txt tel" title="${formName }연락처 중간 4자리" maxlength="4"/>
								-
								<input type="text" id="ownhomTelno3" name="ownhomTelno3" class="input_txt tel" title="${formName }연락처 끝 4자리" maxlength="4" />
							</c:otherwise>
						</c:choose>
						<c:set var="data" value="" />

							</td>
							<th scope="row">휴대폰</th>
							<td>
							<c:set var="data" value="${fn:split(result.mbtlnum,'-')}" />
				<c:choose>
					<c:when test="${fn:length(data) >= 3}">
						<select id="mbtlnum1" name="mbtlnum1" class="input_select" title="${formName} 핸드폰 앞 자리" >
							<option value="">선택</option>
							<option value="010" <c:if test="${data[0] eq '010'}"> selected="selected"</c:if>>010</option>
							<option value="011" <c:if test="${data[0] eq '011'}"> selected="selected"</c:if>>011</option>
							<option value="016" <c:if test="${data[0] eq '016'}"> selected="selected"</c:if>>016</option>
							<option value="017" <c:if test="${data[0] eq '017'}"> selected="selected"</c:if>>017</option>
							<option value="018" <c:if test="${data[0] eq '018'}"> selected="selected"</c:if>>018</option>
							<option value="019" <c:if test="${data[0] eq '019'}"> selected="selected"</c:if>>019</option>
						</select>
						-
						<input type="text" id="mbtlnum2" name="mbtlnum2" value="${data[1]}" class="input_txt tel" title="${formName} 핸드폰 중간 4자리" maxlength="4" />
						-
						<input type="text" id="mbtlnum3" name="mbtlnum3" value="${data[2]}" class="input_txt tel" title="${formName} 핸드폰 끝 4자리" maxlength="4" />
					</c:when>
					<c:otherwise>
						<select id="mbtlnum1" name="mbtlnum1" class="input_select" class="input_select" title="${formName} 핸드폰 앞 자리" >
							<option value="" selected="selected">선택</option>
							<option value="010" >010</option>
							<option value="011" >011</option>
							<option value="016" >016</option>
							<option value="017" >017</option>
							<option value="018" >018</option>
							<option value="019" >019</option>
						</select>
						-
						<input type="text" id="mbtlnum2" name="mbtlnum2" value="" class="input_txt tel" title="${formName} 핸드폰 중간 4자리" maxlength="4" />
						-
						<input type="text" id="mbtlnum3" name="mbtlnum3" value="" class="input_txt tel" title="${formName} 핸드폰 끝 4자리" maxlength="4" />
					</c:otherwise>
				</c:choose>
				<c:set var="data" value="" />
							</td>
						</tr>
						<tr>
							<th scope="row" >이메일</th>
							<td colspan="3">
							<c:set var="data" value="${fn:split(result.email,'@')}" />
						<c:choose>

						<c:when test="${fn:length(data) >= 2}">
								<input id="email1" name="email1" type="text" title="이메일 아이디" value="${data[0]}" class="board1 email_id" style="width:150px"/>
								@
								<input id="email2" name="email2" type="text" title="이메일 주소" value="${data[1]}" class="board1 email_addr" style="width:150px"/>
								<select id="sr_email_more" name="sr_email_more" class="input_select email_addr" style="width:auto" title="직접입력 선택시 자동활성화&포커스 이동">

									<option value="gmail.com"   >gmail.com</option>
									<option value="naver.com">naver.com</option>
				                    <option value="hanmail.net">hanmail.net</option>
				                    <option value="daum.net">daum.net</option>
				                    <option value="hotmail.com">hotmail.com</option>
				                    <option value="nate.com">nate.com</option>
				                    <option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="emaildomain_false">직접입력</option>

								</select>

						</c:when>
						<c:otherwise>
								<input id="email1" name="email1"  type="text" title="이메일 아이디" value="" class="board1 email_id" style="width:150px"/>
								@
								<input id="email2"  name="email2" type="text" title="이메일 주소" value="" class="board1 email_addr" style="width:150px"/>
								 <select id="sr_email_more" name="sr_email_more" class="input_select email_addr" style="width:auto" title="직접입력 선택시 자동활성화&포커스 이동">
									<option value="gmail.com">gmail.com</option>
									<option value="naver.com">naver.com</option>
								    <option value="hanmail.net">hanmail.net</option>
								    <option value="daum.net">daum.net</option>
								    <option value="hotmail.com">hotmail.com</option>
								    <option value="nate.com">nate.com</option>
								    <option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="emaildomain_false">직접입력</option>
								</select>
							</c:otherwise>
						</c:choose>
						<script type="text/javascript">
							$('#sr_email_more').val("<c:out value='${data[1] }'/>").attr("selected","selected");

						</script>
						<c:set var="data" value="" />

							</td>
						</tr>
						<tr>
							<th scope="row" >주소</th>
							<td colspan="3"><input type="text" name="adres" id="adres" class="" value="${result.adres}" /></td>
						</tr>
					</tbody>
				</table>
			</div>

			<h4>■ 상담내용	</h4>
			<div class="bdView">
				<table>
					<caption>

					</caption>
					<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" >희망직종</th>
							<td><input type="text" name="hopeJssfc" id="hopeJssfc" class="" value="${result.hopeJssfc}" /></td>
							<th scope="row" >희망시기</th>
							<td><input type="text" name="hopeEra" id="hopeEra" readonly="readonly" class="board1 calendar" value="${result.hopeEra}" /></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row" >상담일</th> -->
<!-- 							<td></td> -->
<!-- 							<th scope="row" >담당컨설턴트</th> -->
<!-- 							<td></td> -->
<!-- 						</tr> -->
						<tr>
							<th scope="row" >상담신청내용</th>
							<td colspan="3">
<!-- 								<input type="checkbox" name="cnsltReqst" id="cnsltReqst1" value="1" /> <label for="cnsltReqst1" > 진로/직무 컨설팅</label>
								<input type="checkbox" name="cnsltReqst" id="cnsltReqst2" value="2" /> <label for="cnsltReqst2" > 이력서/자기소개서 클리닉</label>
								<input type="checkbox" name="cnsltReqst" id="cnsltReqst3" value="3" /> <label for="cnsltReqst3" > 면접클리닉</label>
								<input type="checkbox" name="cnsltReqst" id="cnsltReqst4" value="4" /> <label for="cnsltReqst4" > 취업처 소개</label>
								<input type="checkbox" name="cnsltReqst" id="cnsltReqst5" value="5" /> <label for="cnsltReqst5" > 기타 </label> -->
								<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
									<input type="checkbox" name="cnsltReqSeData" id="cnsltReqSeData${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.cnsltReqSe, code.code) != -1}">checked="checked"</c:if>>${code.codeNm}
								</c:forEach>



							</td>
						</tr>
						<tr>
							<th scope="row"  colspan="4">상담내용</th>
						</tr>
						<tr>
						<td class="outputEditor" colspan="4">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
						<textarea id="cnsltReqCn" name="cnsltReqCn" cols="150" rows="30" style="display:none;" class="textarea">${result.cnsltReqCn}</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor.EditorStart();

 							var contentValue = document.getElementById("cnsltReqCn").value; // Hidden 값 참조
							function OnInitCompleted(){

							contentValue = contentValue.replace(/#script#/gi, "script");
 								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
 							}
						//]]>
						</script>
					</td>
						</tr>

					</tbody>
				</table>
			</div>
</form>
	<c:if test="${not empty result}">
	<%-- <div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
	</div>--%>
	</c:if>
</div>


<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
<%-- 	<c:if test="${result.delcode eq '0' }" > --%>
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
<%-- 	</c:if> --%>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/job/${paramVO.programId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>




