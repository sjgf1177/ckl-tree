
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<sec:authentication var="user" property="principal"/>
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
/* 시도 관련 코드  */
var sidoval = "<c:out value='${result.sido}'  />";
var gugunVal = "<c:out value='${result.gugun}' />";
var codeIdVal = "<c:out value='${codeId0}'/>";
/* ##시도 관련 코드##  */

	$(window).ready(function() {
		email_change();
		email_emptyChk();
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$(".calendar").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
		$('#sido').val("<c:out value='${result.sido }'/>").attr("selected","selected");
	});



	$(function() {
		//회원찾기
		$("#mberPoPBtn").click(function() {
			$("#memSelectTp2").click();
			var url = $(this).attr("href");
			window.open(url,"memberPopup","width=800, height= 700");
			return false;
		});

		$("input[name=memSelectTp]").click(function() {
			if ($(this).val() == "0") {
				$("#userNm").attr("readonly",false);
				$("#userSn").val("");
			}
			else {
				$("#userNm").attr("readonly",true);
			}
		});

		$("#resveRegBtn").click(function() {
			checkForm();
			return false;
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


	function checkForm() {
		var form = $("#board")[0];
		var v= new MiyaValidator(form);
		var cnsltReqSe = "";

		v.add("memSelectTp", {
	        required: true
	    });

		v.add("userNm", {
	        required: true
	    });

		v.add("sex", {
	        required: true
	    });

		v.add("brthdy", {
	        required: true
	    });

		v.add("ownhomTelno1", {
	        required: true
	    });

		v.add("ownhomTelno2", {
	        required: true
	    });

		v.add("ownhomTelno3", {
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


		v.add("email1", {
	        required: true
	    });

		v.add("email2", {
	        required: true
	    });

		v.add("resdncSe", {
			required: true
		});

		v.add("adres", {
	        required: true
	    });

		v.add("schul", {
	        required: true
	    });

		v.add("subjct", {
	        required: true
	    });

		v.add("hopeJssfc", {
	        required: true
	    });

		v.add("hopeEra", {
	        required: true
	    });
		v.add("cnsltReqSeData1", {
	        required: true
	    });



		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor( ); // 크로스에디터 Focus 이동
		    return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}
		var cont = CrossEditor.GetBodyValue();
		document.getElementById("cnsltReqCn").value= cont;

		var cnsltReqSe = "";
		$(":input[name^=cnsltReqSeData]:checked").each(function(){
			cnsltReqSe += $(this).val() + ",";
		});
		cnsltReqSe = cnsltReqSe.substring(0,cnsltReqSe.length-1);
		$("#cnsltReqSe").val(cnsltReqSe);


		var cnsltReqCnSe = "";
		$(":input[name^=cnsltReqCnSeData]:checked").each(function(){
			cnsltReqCnSe += $(this).val() + ",";
		});

		cnsltReqCnSe = cnsltReqCnSe.substring(0,cnsltReqCnSe.length-1);
		$("#cnsltReqCnSe").val(cnsltReqCnSe);
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
<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
		<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
		<input type="hidden" name="cnslSn" value="${result.cnslSn }" />
		<input type="hidden" name="htmlYn" value="${result.htmlYn}" />
		<input type="hidden" name="userSn" id="userSn" value="<c:out value="${result.userSn }" />" />
		<input type="hidden" name="replyAt" value="<c:out value="${not empty result ? 'Y' : 'N' }" />">
		<input type="hidden" name="atchFileId" value="<c:out value="${result.atchFileId }" />" />
		<input type="hidden" name="cnsltReqCnSe" id="cnsltReqCnSe" value="" />
		<input type="hidden" name="cnsltReqSe" id="cnsltReqSe" value="" />
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
							<th scope="row"><label for="memSelectTp1">회원여부</label></th>
							<td colspan="3">
							 	<label for="memSelectTp1"><input type="radio" name="memSelectTp"  id="memSelectTp1"  value="0" <c:if test="${result.userSn eq '0' or empty result.userSn  }"> checked="checked" </c:if> />직접입력</label>
								<label for="memSelectTp2"><input type="radio" name="memSelectTp"  id="memSelectTp2"  value="1" <c:if test="${result.userSn ne '0' and not empty result.userSn }"> checked="checked" </c:if> />회원선택 <br /> </label>
								<input type="text" id="userId" name="userId" value="<c:out value="${not empty result.userId ? result.userId : '' }" />" title="회원이름" <c:if test="${not empty result.userId }">readonly="readonly" </c:if> />
								<a href="/bos/userMember/memberPopup.do?viewType=BODY&amp;objUserNm=userNm&amp;objUserSn=userSn&amp;objUserid=userId" class="btn btn-primary" id="mberPoPBtn">찾기</a>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="sex1">이름 / 성별</label></th>
							<td>
							<input type="text" name="userNm" value="${result.userNm }" title="이름"> &nbsp;
							<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
								 <label for="sex<c:out value="${status.count}" /> "  >	<input type="radio" name="sex" id="sex${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.sex, code.code) != -1}">checked="checked"</c:if>>${code.codeNm} </label>
							</c:forEach>

							</td>
							<th scope="row">생년월일</th>
							<td>
							<input type="text" id="brthdy" name="brthdy" readonly="readonly"  value="<fmt:formatDate value="${result.brthdy}" pattern="yyyy-MM-dd"/>" class="board1 calendar" title="생년월일"/>
							</td>
						</tr>
							<tr>
							<th scope="row" for="ownhomTelno1"><label> 자택</label> </th>
							<td>
							 <c:set var="data" value="${fn:split(result.ownhomTelno,'-')}" />
								<select id="ownhomTelno1" name="ownhomTelno1" class="input_select" title="${formName }연락처 앞 자리">
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

						<c:remove var="data" />

							</td>
							<th scope="row">휴대폰</th>
							<td>
							<c:set var="data" value="${fn:split(result.mbtlnum,'-')}" />
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
						<c:remove var="data"  />
							</td>
						</tr>
						<tr>
							<th scope="row" >이메일</th>
							<td colspan="3">
							<c:set var="data" value="${fn:split(result.email,'@')}" />
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
						<script type="text/javascript">
							$('#sr_email_more').val("<c:out value='${data[1] }'/>").attr("selected","selected");

						</script>
						<c:remove var="data"  />

							</td>
						</tr>
						<tr>
							<th>
								<label for="resdncSe1" >거주지</label>
							</th>
							<td>
								<label for="resdncSe1"> <input type="radio" name="resdncSe" id="resdncSe1" value="01" <c:if test="${result.resdncSe eq '01'}">checked="checked"</c:if> > 국내 </label>
								<label for="resdncSe2"> <input type="radio" name="resdncSe" id="resdncSe2" value="02" <c:if test="${result.resdncSe eq '02'}">checked="checked"</c:if> > 해외 </label>
								<select name="sido" id="sido" title="시도를 선택해주세요"  <c:if test="${not empty result and result.resdncSe ne '01' }">style="display: none;"</c:if> >
									<option value="">시도 선택 </option>
									<c:forEach var="item" items="${COM063CodeList }">
										<option value="<c:out value="${item.code }"/>"  ><c:out value="${item.codeNm }"/></option>
									</c:forEach>
								</select>
								<select name="gugun" id="gugun" title="구군을 선택해주세요"  <c:if test="${not empty result and result.resdncSe ne '01' }">style="display: none;"</c:if> >
									<option value="">구군 선택</option>
								</select>
								<input type="text" name="resdncOvsea"   id="resdncOvsea" value="<c:out value="${result.resdncOvsea }" />" title="해외인 경우 입력해주세요." <c:if test="${(not empty result and result.resdncSe ne '02') or empty result }">style="display: none;"</c:if> >
							</td>
						</tr>
						<tr>
							<th scope="row" >주소</th>
							<td colspan="3"><input type="text" name="adres" title="주소" id="adres" class="" style="width: 100%;" value="${result.adres}" /></td>
						</tr>
					</tbody>
				</table>
			</div>

			<h4>■  추가 정보</h4>
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
								<th scope="row">학교</th>
								<td><input type="text" name="schul" id="schul" class="" value="${result.schul}" title="학교"/></td>
								<th scope="row">학과</th>
								<td><input type="text" name="subjct" id="subjct" class="" value="${result.subjct}" title="학과"/></td>
							</tr>
							<tr>
								<th>희망직무(공통)</th>
								<td colspan="3"> <input type="text" class="w500" value="<c:out value="${result.hopeJssfc}" />" id=""> </td>
							</tr>
							<tr>
								<th scope="row"><label for="grade"> 학년</label></th>
								<td>
									<input type="text" name="grade" id="grade" value="<c:out value="${result.grade }" />" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="cnsltReqCnEtc"> 상담신청내용</label></th>
								<td colspan="3">
									<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
										<label for="cnsltReqCnSeData${status.count}">
										<input type="checkbox" name="cnsltReqCnSeData" id="cnsltReqCnSeData${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.cnsltReqCnSe , code.code) ne -1}">checked="checked"</c:if>>${code.codeNm} </label>
										<c:if test="${status.last }">(<input type="text" name="cnsltReqCnEtc" id="cnsltReqCnEtc" value="<c:out value="${result.cnsltReqCnEtc }" />" />)</c:if>
									</c:forEach>
								</td>
							</tr>
							<c:if test="${not empty fileList}">
								<tr>
									<th scope="row">첨부된 첨부파일</th>
									<td  colspan="3">
									<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />	</td>
								</tr>
							</c:if>
								<tr>
									<th scope="row">첨부파일</th>
									<td colspan="3">
										<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
									</td>
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
							<td><input type="text" name="hopeJssfc" id="hopeJssfc" title="희망직종" class="" value="${result.hopeJssfc}" /></td>
							<th scope="row" >희망시기</th>
							<td><input type="text" name="hopeEra" id="hopeEra" title="희망시기"  class="board1 calendar" value="<fmt:formatDate value="${result.hopeEra}" pattern="yyyy-MM-dd"/>" /></td>
						</tr>
						<tr>
							<th scope="row" ><label for="cnsltReqSeData1" >상담신청구분</label></th>
							<td >
								<c:forEach var="code" items="${COM070CodeList}" varStatus="status">
								<label for="cnsltReqSeData${status.count}">
								<input type="checkbox" name="cnsltReqSeData" id="cnsltReqSeData${status.count}" value="${code.code}" <c:if test="${fn:indexOf(result.cnsltReqSe, code.code) ne -1}">checked="checked"</c:if>>${code.codeNm} </label>
								</c:forEach>
							</td>
							<th> 담당 컨설턴트</th>
							<td><input type="text" readonly="readonly" name="cnsltNm" value='<c:out value="${not empty result.cnsltNm ? result.cnsltNm : user.username }"/>'> </td>
						</tr>
						<tr>
							<th scope="row"  colspan="4">상담내용</th>
						</tr>
						<tr>
							<td class="outputEditor" colspan="4">
								<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
								(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
								</span><br/>
									<textarea id="cnsltReqCn" name="cnsltReqCn" cols="150" rows="30" style="display:none;" class="textarea"><c:out value="${result.cnsltReqCn}"/></textarea>
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




