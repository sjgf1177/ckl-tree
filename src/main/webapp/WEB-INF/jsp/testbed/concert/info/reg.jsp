<%@page import="egovframework.com.cmm.service.FileVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
<%-- 	<c:set var="action" value="/bos/fcltyResve/eqpmn/insert.do" /> --%>
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
<%-- 	<c:set var="action" value="/bos/fcltyResve/eqpmn/update.do" /> --%>
	<c:set var="actTp" value="update" />
</c:if>



<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">

var actTp = "<c:out value="${actTp}" />";


$(function(){
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#reservStartDt").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	//일정추가 팝업
	var addTimePopup = $( "#addTimePopup" ).dialog({
		autoOpen: false,
	  	height: "auto",
	  	width: "800",
	  	modal: true,
	  	position : {
  			my : "center center",
  			at : "center center",
  			of : $("body"),
  			within : $("body")
  		}
	  //position : [80,0]
	});
	$("#addTimePopupBtn").click(function() { 
		/* 
		if ($("input[name=eqpmnUseAt]:checked").val() != "Y") {
			alert("선택장비 사용을 선택하신 후 클릭해 주세요.")
			return false;
		}
		 */
	  	var params = {viewType : "CONTBODY"};
	  	$( "#addTimePopup" ).load("/bos/concert/info/addTimePopup.do", params, function() {
	  		$( "#addTimePopupCont").empty();
	  		addTimePopup.dialog("open");
	  	});
	  	
	  	return false;
	});
	/* $("#prgEndde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#beginDate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#endDate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	getCodeList("prgCl", codeIdVal, "<c:out value='${result.prgSe}'/>", "<c:out value='${result.prgCl}'/>");

	$("select[name=prgSe]").change(function(){
		var val = $(this).val();
		getCodeList("prgCl", codeIdVal, val);
	});

	//대기신청 노출처리
	if ($(':radio[name="waitReqstAt"]:checked').val() == 'Y') {
		$("#waitReqstNmpr").attr("disabled", false).focus();
	}
	else {
		
		
		$("#waitReqstNmpr").attr("disabled", true);
	}

	$("input[name=waitReqstAt]").click(function(){
		var val = $(this).val();
		if (val == "Y") {
			$("#waitReqstNmpr").attr("disabled", false).focus();
		}
		else {
			$("#waitReqstNmpr").attr("disabled", true);
			$("#waitReqstNmpr").val("");
		}
	});

	$("input[name=rcritComptAt]").click(function(){
		if ($(':input[name="rcritComptAt"]:checked').val() == "Y") {
			$("#endDate").val("9999-12-31");
		}
		else {
			$("#endDate").val("");
		}
	});

	//신청방식 노출처리
	if ($(':radio[name="reqstMthd"]:checked').val() == "01") {
		$("#psncpa").attr("disabled", false).focus();
		$("#waitReqst").show();
	}
	else {
		$("#psncpa").attr("disabled", true);
		$("#waitReqst").hide();
	}

	$("input[name=reqstMthd]").click(function(){
		var val = $(this).val();
		if (val == "01") {
			$("#psncpa").attr("disabled", false).focus();
			$("#waitReqst").show();
		}
		else {
			$("#psncpa").attr("disabled", true);
			$("#psncpa").val("");
			$("#waitReqst").hide();
			$("#waitReqstAt1").prop("checked", true);
			$("#waitReqstNmpr").val("");
		}
	});
	 */

});

/* 
	//공통 코드목록 화면처리
	function getCodeList(elemntId, codeId, upperCode, code) {
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
				if ("prgCl" == elemntId && "" == upperCode) {
					$("<option>").text("분류 선택").attr("value","").appendTo($("#prgCl").empty());
				}
			}
		},"json");
	}
 */
	function checkForm() {
		var form = document.frm;
		var v = new MiyaValidator(form);

		v.add("mainDisplay", {
			required : true
		});
		v.add("concertTitle", {
			required : true
		});
		v.add("concertType", {
			required : true
		});
		v.add("concertPlace", {
			required : true
		});
		v.add("commentMsg", {
			required : true
		});
		v.add("useReserv", {
			required : true
		});
		v.add("reservStartDt", {
			required : true
		});
		v.add("reservStartTm", {
			required : true
		});
		$("#reservStartTime").val($("#reservStartDt").val()+" "+$("#reservStartTm").val());
		v.add("endHour", {
			required : true
		});
		v.add("endMin", {
			required : true
		});
		$("#reservEndTime").val($("#endHour").val()+$("#endMin").val()); //1030
		v.add("reservLimitCnt", {
			required : true
		});
		v.add("isFree", {
			required : true
		});
		if ( $("#reservUrlAt").is(":checked") == true)
			v.add("reservUrl", {
				required : true
			});
		else $("#reservUrl").val("");
		v.add("reservSitFix", {
			required : true
		});
		v.add("reservOnlineSitNum", {
			required : true
		});
		
		
		if ( actTp == "insert" && $("#mainImg").length > 0 ){
			v.add("mainImg", {
				required : true
			});
		} 
				
		if ( actTp == "insert" && $("#posterImg").length > 0 ){
			v.add("posterImg", {
				required : true
			});
		}
		
		v.add("helpCall1", {
			required : true,
			span : 3,
			glue : "-",
			option : "phone"
		});
		
		$("#helpCall").val($("#helpCall1").val()+"-"+$("#helpCall2").val()+"-"+$("#helpCall3").val());
		
		/* 
		if ($(':radio[name="reqstMthd"]:checked').val() == '01') { //선착순일때만 정원 기입
			v.add("psncpa", {
				required : true
			});
		}

		v.add("confmStepAt", {
			required : true
		});
		v.add("rceptNoIndictAt", {
			required : true
		});
		v.add("ctfhvIssuUseAt", {
			required : true
		});
		v.add("waitReqstAt", {
			required : true
		});

		if ($(':radio[name="waitReqstAt"]:checked').val() == 'Y') { //대기신청 가능할때 인원 기입
			v.add("waitReqstNmpr", {
				required : true
			});
		}

		v.add("indvdlinfoAgreAt", {
			required : true
		});
 */
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
	
		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		}
	
		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
		    return;
		}
	
		var cont = CrossEditor.GetBodyValue();
		document.getElementById("concertExplain").value= cont;
		
		form.submit();
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

	function del(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/concert/info/delete.do";
			form.submit();
		}
	}

	function fnSelectTch(){
		window.open("/bos/progrm/instrctr/instrctrPopup.do?viewType=BODY", "instrctrPopup", "width=940px, height=550px, scrollbars=no");
	}
	
</script>


<form name="frm" method="post" action="/bos/concert/info/${empty result ? 'insert' : 'update'}.do" enctype="multipart/form-data">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="siteSe" value="${empty result ? param.siteSe : result.siteSe}">
	<input type="hidden" name="concertId" value="${result.concertId}">

	<h4>공연 정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>공연 정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="mainDisplay1">메인노출</label></th>
					<td colspan="3">
						<label for="mainDisplay1"><input type="radio" name="mainDisplay" value="1" id="mainDisplay1" <c:if test="${result.mainDisplay ne '0'}">checked="checked"</c:if>> 허용 </label>
						<label for="mainDisplay2"><input type="radio" name="mainDisplay" value="0" id="mainDisplay2" <c:if test="${result.mainDisplay eq '0'}">checked="checked"</c:if>> 비허용 </label>
					</td>
				</tr>
				<tr>
					<th scope="row">메인이미지</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="mainImg"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
						<input type="file" name="mainImg" id="mainImg" title="상세이미지 등록 " class="col-md-8">
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="concertTitle">공연명</label></th>
					<td colspan="3"><input type="text" name="concertTitle" id="concertTitle" value="<c:out value="${result.concertTitle}" />" class="w500" ></td>
				</tr>
				<tr>
					<th scope="row">공연포스터</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="posterImg"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
						<input type="file" name="posterImg" id="posterImg" title="상세이미지 등록 " class="col-md-8">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="concertType">공연구분</label></th>
					<td><input type="text" name="concertType" id="concertType" value="${result.concertType}">
					</td>
					<th scope="row"><label for="concertPlace">공연장소</label></th>
					<td><input type="text" name="concertPlace" id="concertPlace" value="${result.concertPlace}">
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label>구분</label></th>
					<td colspan="3">
						<table>
							<thead>
								<th>날짜</th>
								<th>시작시간</th>
								<th>종료시간</th>
								<th>반복</th>
								<th>비고</th>
								<th>관리</th>
							</thead>
							<tbody>
								<c:forEach var="code" items="${timeList}" varStatus="status">
									공연기간
									공연기간
									공연기간
									공연기간
								</c:forEach>
							</tbody>
						</table>
						<div class="tac">
							<a class="btn btn-default btn-sm" href="javascript:fnSelectTch();" ><span>선택삭제</span></a>
							<a class="btn btn-default btn-sm" id="addTimePopupBtn" ><span>추가하기</span></a>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="helpCall1">문의가능 연락처</label></th>
					<td colspan="3">
						<input type="hidden" name="helpCall" id="helpCall" value="${result.helpCall}">
						<c:set var="data" value="${fn:split(result.helpCall,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="helpCall1" id="helpCall1" title="연락처 앞자리를 선택해 주세요." >
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}"> selected="selected"</c:if>>010</option>
									<option value="02" <c:if test="${data[0] eq '02'}"> selected="selected"</c:if>>02</option>
									<option value="0505" <c:if test="${data[0] eq '0505'}"> selected="selected"</c:if>>0505</option>
									<option value="0606" <c:if test="${data[0] eq '0606'}"> selected="selected"</c:if>>0606</option>
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
								<input type="text" id="helpCall2" name="helpCall2" value="${data[1]}" title="연락처 중간자리를 입력하세요." maxlength="4"  onkeyup="this.value=check_txt(this.value)"/>
								-
								<input type="text" id="helpCall3" name="helpCall3" value="${data[2]}" title="연락처 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" />
							</c:when>
							<c:otherwise>
								<select name="helpCall1" id="helpCall1" title="연락처 국번 앞 3자리" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="02">02</option>
									<option value="0505">0505</option>
									<option value="0606">0606</option>
									<option value="070">070</option>
									<option value="051">051</option>
									<option value="053">053</option>
									<option value="032">032</option>
									<option value="062">062</option>
									<option value="042">042</option>
									<option value="052">052</option>
									<option value="044">044</option>
									<option value="031">031</option>
									<option value="033">033</option>
									<option value="043">043</option>
									<option value="041">041</option>
									<option value="063">063</option>
									<option value="061">061</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="064">064</option>
								</select>
								-
								<input type="text" value="" id="helpCall2" name="helpCall2" title="발신번호 중간자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" />
								-
								<input type="text" value="" id="helpCall3" name="helpCall3" title="발신번호 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="commentMsg"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비고</label></th>
					<td colspan="3">
						<textarea name="commentMsg" id="commentMsg" cols="120" rows="10" class="col-md-12" title="비고">${result.commentMsg}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>공연상세정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="concertExplain"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 작품설명</label></th>
					<td colspan="3">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
						<textarea id="concertExplain" name="concertExplain" cols="150" rows="30" style="display:none;" class="textarea">${result.concertExplain}</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor.EditorStart();

							var contentValue = document.getElementById("concertExplain").value; // Hidden 값 참조
							function OnInitCompleted(){

								//contentValue = contentValue.replace(/#script#/gi, "script");
								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
							}
						//]]>
						</script>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="additionalTitle1">추가필드1 타이틀</label></th>
					<td colspan="3"><input type="text" name="additionalTitle1" id="additionalTitle1" value="<c:out value="${result.additionalTitle1}" />" class="w500" ></td>
				</tr>
				<tr>
					<th scope="row"><label for="additionalContent1"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 추가필드1 내용</label></th>
					<td colspan="3">
						<textarea name="additionalContent1" id="additionalContent1" cols="120" rows="4" class="col-md-12" title="추가필드 내용을 입력해 주세요.">${result.additionalContent1}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="additionalTitle2">추가필드2 타이틀</label></th>
					<td colspan="3"><input type="text" name="additionalTitle2" id="additionalTitle2" value="<c:out value="${result.additionalTitle2}" />" class="w500" ></td>
				</tr>
				<tr>
					<th scope="row"><label for="additionalContent2"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 추가필드2 내용</label></th>
					<td colspan="3">
						<textarea name="additionalContent2" id="additionalContent2" cols="120" rows="4" class="col-md-12" title="추가필드 내용을 입력해 주세요.">${result.additionalContent2}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="additionalTitle3">추가필드3 타이틀</label></th>
					<td colspan="3"><input type="text" name="additionalTitle3" id="additionalTitle3" value="<c:out value="${result.additionalTitle3}" />" class="w500" ></td>
				</tr>
				<tr>
					<th scope="row"><label for="additionalContent3"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 추가필드3 내용</label></th>
					<td colspan="3">
						<textarea name="additionalContent3" id="additionalContent3" cols="120" rows="4" class="col-md-12" title="추가필드 내용을 입력해 주세요.">${result.additionalContent3}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">상세이미지1</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="detailImg1"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
						<input type="file" name="detailImg1" id="detailImg1" title="상세이미지 등록 " class="col-md-8">
					</td>
				</tr>
				<tr>
					<th scope="row">상세이미지2</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="detailImg2"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
						<input type="file" name="detailImg2" id="detailImg2" title="상세이미지 등록 " class="col-md-8">
					</td>
				</tr>
				<tr>
					<th scope="row">상세이미지3</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="detailImg3"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
						<input type="file" name="detailImg3" id="detailImg3" title="상세이미지 등록 " class="col-md-8">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="additionalImg">추가이미지</label></th>
					<td colspan="3">
						<!-- 썸네일 -->
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="additionalImg"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
<!-- 						<input type="file" name="additionalImg" id="additionalImg" title="추가이미지 등록 " class="col-md-8"> -->
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>공연예약설정</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			
			<tbody>
				<tr>
					<th scope="row"><label for="useReserv1">예약버튼</label></th>
					<td colspan="3">
						<label for="useReserv1"><input type="radio" name="useReserv" value="1" id="useReserv1" <c:if test="${result.useReserv ne '0'}">checked="checked"</c:if>> 사용 </label>
						<label for="useReserv2"><input type="radio" name="useReserv" value="0" id="useReserv2" <c:if test="${result.useReserv eq '0'}">checked="checked"</c:if>> 미사용 </label>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 예약시작</th>
					<td colspan="3">
						<div>
							<input type="hidden" name="reservStartTime" id="reservStartTime" value="${result.reservStartTime}">
							<c:set var="reservStartDt">${fn:substring(result.reservStartTime, 0, 10)}</c:set>
							<c:set var="reservStartTm">${fn:substring(result.reservStartTime, 11, 13)}</c:set>
							<%-- <c:set var="beginMin">${fn:substring(result.beginDt, 14, 16)}</c:set> --%>
							<input type="text" name="reservStartDt" id="reservStartDt" style="width:110px" title="예약시작일 입력" value="${reservStartDt}" readonly="readonly" />
							<select id="reservStartTm" name="reservStartTm" style="width:60px" title="예약시작 시간">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="23">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq result.reservStartTimeHh}">selected="selected"</c:if>>${val}시</option>
							</c:forEach>
							</select>
						</div>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 예약마감시간</th>
					<td colspan="3">
						<div>
							<input type="hidden" name="reservEndTime" id="reservEndTime" value="${result.reservEndTime}">
							<select id="endHour" name="endHour" style="width:60px" title="예약마감시간">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="23">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq result.reservEndTimeHh}">selected="selected"</c:if>>${val}시</option>
							</c:forEach>
							</select>

							<select id="endMin" name="endMin" style="width:60px" title="예약마감분">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="59">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq result.reservEndTimeMi}">selected="selected"</c:if>>${val}분</option>
							</c:forEach>
							</select>
							전일기준 
						</div>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 1인최대 예매</th>
					<td>
						<div>

							<select id="reservLimitCnt" name="reservLimitCnt" style="width:60px" title="1인최대 예매">
							    <option value="">선택</option>
							<c:forEach var="x" begin="1" end="10">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq result.reservLimitCnt}">selected="selected"</c:if>>${val}</option>
							</c:forEach>
							</select>
						</div>
					</td>
					<th scope="row"><label for="isFree1">금액</label></th>
					<td>
						<label for="isFree1"><input type="radio" name="isFree" value="1" id="isFree1" <c:if test="${result.isFree eq '1'}">checked="checked"</c:if>> 무료 </label>
						<label for="isFree2"><input type="radio" name="isFree" value="0" id="isFree2" <c:if test="${result.isFree ne '1'}">checked="checked"</c:if>> 유료 </label>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><label for="reservUrl">별도 url설정</label></th>
					<td colspan="3">
						<input type="text" name="reservUrl" id="reservUrl" value="${result.reservUrl}"  placeholder="ex) http://www.kocca.kr" class="w500">
					</td>
				</tr>
				
				
				<tr>
					<th scope="row"><label for="reservSitFix1">예약좌석 설정</label></th>
					<td colspan="3">
						<label for="reservSitFix1"><input type="radio" name="reservSitFix" value="0" id="reservSitFix1" <c:if test="${result.reservSitFix ne '1'}">checked="checked"</c:if>> 지정 </label>
						<label for="reservSitFix2"><input type="radio" name="reservSitFix" value="1" id="reservSitFix2" <c:if test="${result.reservSitFix eq '1'}">checked="checked"</c:if>> 미지정(선착순 좌석배치) </label>
					</td>
				</tr>
				
				<tr>
					<th scope="row"><label for="reservOnlineSitNum">예약매수지정</label></th>
					<td colspan="3">
						예약매수 (제한)
						<input type="text" name="reservOnlineSitNum" id="reservOnlineSitNum" value="${result.reservOnlineSitNum}" onkeyup="this.value=check_txt(this.value)">
					</td>
				</tr>
				
			</tbody>
		</table>
	</div>

	<div class="row clear mt20">
		<div class="col-md-11 tac">
			<a href="javascript:checkForm();" class="btn btn-primary">${empty result ? '등록' : '수정'}</a>
			<c:if test="${empty result == false }">
				<a href="javascript:del();" class="btn btn-danger">삭제</a>
			</c:if>
		</div>
		<div class="col-md-1"><a href="/bos/concert/info/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
	</div>

<!-- 팝업창 -->
	<div id="addTimePopup" title="공연일정등록" style="top:0;">
		<div id="addTimePopupCont"></div>
	</div>
<!-- //팝업창 -->

</form>
