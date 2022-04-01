<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
	<c:set var="action" value="/bos/hkFcltyResve/fclty/insert.do" />
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/hkFcltyResve/fclty/update.do" />
	<c:set var="actTp" value="update" />
</c:if>

<script type="text/javascript">
//<![CDATA[
var codeIdVal = "<c:out value="${ codeId0 }" />";
var areaSeVal = "<c:out value="${ not empty result.areaSe ? result.areaSe : param.areaSe }" />";
var lcSeVal = "<c:out value="${ not empty result.lcSe ? result.lcSe : param.lcSe }" />";
var fcltySeVal = "<c:out value="${ not empty result.fcltySe ? result.fcltySe : param.fcltySe }" />";
var actTp = "<c:out value="${actTp}" />";


$(function(){
	//init
	if (areaSeVal != "") getCodeList("lcSe", codeIdVal, areaSeVal, 2, lcSeVal);

	//지역선택 event
	$("#areaSe").change(function() {
		getCodeList("lcSe", codeIdVal, $(this).val(), 2);
	});

	//위치선택 event
	$("#lcSe").change(function() {
		getCodeList("fcltySe", codeIdVal, $(this).val(), 3);
	});


	$("#fcltyForm").submit(function() {
		checkForm();
		return false;
	});

	$("#regBtn").click(function() {
		checkForm();
		return false;
	});


	$("#resvePosblAt02").click(function() {
		$("#resveImprtyResnRequired").attr("class","hide_star");
		//$("#resveImprtyResn").attr("readonly",false);
		//$("#resveImprtyResnTr").show();
		$("#wkendResvePolsblAt02").attr("checked", true);
		document.fcltyForm.wkendResvePolsblAt[1].checked = true;
		//$("#wkendResvePolsblAtDiv").hide();

	});
	$("#resvePosblAt01").click(function() {
		$("#resveImprtyResnRequired").removeClass("hide_star");
		//$("#resveImprtyResn").attr("readonly",true);
		//$("#resveImprtyResnTr").hide();
		//$("#wkendResvePolsblAtDiv").show();
	});


	$("#eqpmnUseAt01").click(function() {
		$("#eqpmnSelectDiv").show();
	});

	$("#eqpmnUseAt02").click(function() {
		$("#eqpmnSelectDiv").hide();
		$("#eqpmnNms").val("");
		$("#eqpmnSns").val("");
	});



	var eqpmnPopup = $( "#eqpmnPopup" ).dialog({
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

	$("#eqpmnPopupBtn").click(function() {
		if ($("input[name=eqpmnUseAt]:checked").val() != "Y") {
			alert("선택장비 사용을 선택하신 후 클릭해 주세요.")
			return false;
		}
	  	var params = {viewType : "CONTBODY"};
	  	$( "#eqpmnPopup" ).load("/bos/hkFcltyResve/fclty/eqpmnPopup.do", params, function() {
	  		$( "#eqpmnPopupCont").empty();
	  		eqpmnPopup.dialog("open");
	  	});
	  	return false;
  	});

	$(".delFileBtn").click(function() {
		if (!confirm('파일을 삭제하시겠습니까?')) {
			return;
		}

		var atchFileId = $("input[name=atchFileId]").val();
		var fileSn = $(this).closest("div").find("input[name=fileSn]").val();
		var $this = $(this);
		$.getJSON(
			"/bos/cmm/fms/deleteFileInfs.json",
			{atchFileId : atchFileId, fileSn : fileSn},
			function(data)
			{
				var jdata = data.resultCode;
	            if( jdata == 'success' ) {
	            	alert("성공적으로 삭제하였습니다.");
	            	$this.closest("div.fileItem").find(".inputFile").show();
	            	$this.closest("div").remove();
	            }
	            else alert("삭제에 실패하였습니다.");
			}
		);
		return false;
	});
});

// 공통 코드목록 화면처리
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
			if (depth == 1) $("<option>").text("지역 선택").attr("value","").appendTo($obj);
			else if (depth == 2) $("<option>").text("위치 선택").attr("value","").appendTo($obj);
			else if (depth == 3) $("<option>").text("시설구분").attr("value","").appendTo($obj);
			$.each(data.list, function(key,item) {
				var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
				if (code == item.code) $codeItem.attr("selected",true);
				$codeItem.appendTo($obj);
			});

			if ("lcSe" == elemntId && "" == upperCode) {
				$("<option>").text("시설구분").attr("value","").appendTo($("#fcltySe").empty());
				$("<option>").text("위치 선택").attr("value","").appendTo($("#lcSe").empty());
			}
			else if ("fcltySe" == elemntId && "" == upperCode) {
				$("<option>").text("시설구분").attr("value","").appendTo($("#fcltySe").empty());
			}

			if ("lcSe" == elemntId && lcSeVal == code) getCodeList("fcltySe", codeIdVal, $("#lcSe").val(), 3, fcltySeVal);
			else if ("fcltySe" == elemntId && fcltySeVal == code) $("#fcltySe").find("[value="+fcltySeVal+"]").attr("selected",true);
		}
	},"json");

}


function checkForm() {
	var form = $("#fcltyForm")[0];
	var v = new MiyaValidator(form);

    v.add("areaSe", {
        required: true
    });

    v.add("lcSe", {
        required: true
    });

    v.add("fcltySe", {
        required: true
    });

    v.add("resveSe", {
        required: true
    });

    v.add("spceNm", {
        required: true
    });

    v.add("resvePosblAt", {
        required: true
    });

    v.add("nmpr", {
        number: true
    });


    v.add("useAt", {
        required: true
    });


    if ($("input[name=resveSe]:checked").val() == "N") {

	    v.add("resveImprtyResn", {
	        required: true
	    });
    }

    v.add("eqpmnUseAt", {
        required: true
    });

    if ($("input[name=eqpmnUseAt]:checked").val() == "Y") {
    	v.add("eqpmnNms", {
            required: true
        });
    }

    if (actTp == "insert" || !$("#mainImgDiv")) {
    	v.add("mainImg", {
            required: true
        });
    }


	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}


	if ($("input[name=eqpmnUseAt]:checked").val() == "N") {
		$("#eqpmnSns").val("");
	}

	var msg = "등록";
	if (actTp == "update") msg = "수정";
	if (confirm(msg + "하시겠습니까?")) form.submit();
}

//]]>
</script>

<div class="tbrinfo text-danger"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>

<form id="fcltyForm" name="fcltyForm" method="post" enctype="multipart/form-data" action="<c:out value="${action }" />" class="form-inline">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<input type="hidden" name="fcltySn" id="fcltySn" value="<c:out value="${result.fcltySn }" />" />
<input type="hidden" name="atchFileId" id="atchFileId" value="<c:out value="${result.atchFileId }" />" />
<input type="hidden" name="pageQueryString" id="pageQueryString" value="${pageQueryString }" />


<fieldset>
	<legend>시설관리 입력</legend>
	<div class="bdView">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 구분</th>
				<td colspan="3">
					<select name="areaSe" id="areaSe" title="지역을 선택해 주세요.">
					<option value="">지역선택</option>
					<c:forEach var="item" items="${COM144CodeList }">
						<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq (empty result.areaSe ? param.areaSe : result.areaSe)}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
					</c:forEach>
					</select>
					<select name="lcSe" id="lcSe" title="위치를 선택해 주세요.">
					<option value="">위치 선택</option>
					</select>
					<select name="fcltySe" id="fcltySe" title="시설구분을 선택해 주세요.">
					<option value="">시설구분</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 예약구분</th>
				<td>
					<label for="resveSe01"><input type="radio" name="resveSe" value="A" id="resveSe01" <c:if test="${result.resveSe eq 'A' }">checked="checked"</c:if> /> 내부/외부 </label>
					<label for="resveSe02"><input type="radio" name="resveSe" value="I" id="resveSe02" <c:if test="${result.resveSe eq 'I' }">checked="checked"</c:if> /> 내부 </label>
					<label for="resveSe03"><input type="radio" name="resveSe" value="O" id="resveSe03" <c:if test="${result.resveSe eq 'O' }">checked="checked"</c:if> /> 외부 </label>
				</td>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span>사용자노출여부</th>
				<td>
					<label for="openAt01"><input type="radio" name="openAt" value="Y" id="openAt01" <c:if test="${empty result or result.openAt eq 'Y' }">checked="checked"</c:if> />사용자 노출</label>
					<label for="openAt02"><input type="radio" name="openAt" value="N" id="openAt02" <c:if test="${result.openAt eq 'N' }">checked="checked"</c:if> /> 사용자 비노출 </label>
				</td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="spceNm">공간명</label></th>
				<td><input type="text" name="spceNm" id="spceNm" value="<c:out value="${result.spceNm }" />" /></td>
				<th scope="row" ><label for="spceNmEn">영문</label></th>
				<td><input type="text" name="spceNmEn" id="spceNmEn" value="<c:out value="${result.spceNmEn }" />" />
				</td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 예약가능여부</th>
				<td>
				<div class="clear">
				<label for="resvePosblAt01"><input type="radio" name="resvePosblAt" value="Y" id="resvePosblAt01" <c:if test="${result.resvePosblAt eq 'Y' }">checked="checked"</c:if> /> 예약가능 </label>
				<label for="resvePosblAt02"><input type="radio" name="resvePosblAt" value="N" id="resvePosblAt02" <c:if test="${result.resvePosblAt eq 'N' }">checked="checked"</c:if> /> 예약불가 </label>
				<%-- <label for="resvePosblAt03"><input type="radio" name="resvePosblAt" value="I" id="resvePosblAt03" <c:if test="${result.resvePosblAt eq 'I' }">checked="checked"</c:if> /> 개별예약가능 </label> --%>
				</div>

				<div id="wkendResvePolsblAtDiv" style="display: none;">
					 토/일 예약여부 :
					<%-- <label for="wkendResvePolsblAt01"><input type="radio" name="wkendResvePolsblAt" value="Y" id="wkendResvePolsblAt01" <c:if test="${result.wkendResvePolsblAt eq 'Y' }">checked="checked"</c:if> /> 가능 </label>
					<label for="wkendResvePolsblAt02"><input type="radio" name="wkendResvePolsblAt" value="N" id="wkendResvePolsblAt02" <c:if test="${result.wkendResvePolsblAt eq 'N' }">checked="checked"</c:if> /> 불가 </label> --%>
					<label for="wkendResvePolsblAt02" ><input type="radio" name="wkendResvePolsblAt" value="N" id="wkendResvePolsblAt02" checked="checked"/> 불가 </label>
				</div>


				</td>

				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 사용여부</th>
				<td><label for="useAt01"><input type="radio" name="useAt" value="Y" id="useAt01" <c:if test="${result.useAt eq 'Y' }">checked="checked"</c:if> /> 사용 </label>
					<label for="useAt02"><input type="radio" name="useAt" value="N" id="useAt02" <c:if test="${result.useAt eq 'N' }">checked="checked"</c:if> /> 미사용 </label></td>
			</tr>
			<tr id="resveImprtyResnTr">
				<th scope="row" ><span class="hide_star" id="resveImprtyResnRequired"><span class="sr-only">(필수입력)</span></span> <label for="resveImprtyResn">예약불가사유</label></th>
				<td colspan="3">

				<textarea name="resveImprtyResn" id="resveImprtyResn" rows="7" cols="30" ><c:out value="${result.resveImprtyResn }" /></textarea>
				</td>
			</tr>
			<tr>
				<th scope="row" ><label for="ar">면적</label></th>
				<td><input type="text" name="ar" id="ar" value="<c:out value="${result.ar }" />" />
				</td>
				<th scope="row"><label for="nmpr">인원</label></th>
				<td><input type="text" name="nmpr" id="nmpr" value="<c:out value="${result.nmpr }" />" />명
				</td>
			</tr>
			<tr>
				<th scope="row" ><label for="prpos">용도</label></th>
				<td colspan="3">
					<textarea name="prpos" id="prpos" rows="7" cols="30" ><c:out value="${result.prpos }" /></textarea>
				</td>
			</tr>
			<tr>
				<th scope="row" ><label for="prposEn">용도(영문)</label></th>
				<td colspan="3">
					<textarea name="prposEn" id="prposEn" rows="7" cols="30" ><c:out value="${result.prposEn }" /></textarea>
				</td>
			</tr>
			<tr>
				<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 장비</th>
				<td colspan="3"><div><label for="eqpmnUseAt01"><input type="radio" name="eqpmnUseAt" value="Y" id="eqpmnUseAt01" <c:if test="${result.eqpmnUseAt eq 'Y' }">checked="checked"</c:if> /> 선택장비 사용 </label>
					<label for="eqpmnUseAt02"><input type="radio" name="eqpmnUseAt" value="N" id="eqpmnUseAt02" <c:if test="${result.eqpmnUseAt eq 'N' }">checked="checked"</c:if> /> 선택장비 없음 </label></div>
					<div id="eqpmnSelectDiv">
					<input type="text" name="eqpmnNms" id="eqpmnNms" value="<c:out value="${result.eqpmnNms }" />" title="장비명을 입력하세요." style="width:500px;" readonly="readonly" />
					<a class="btn btn-default btn-sm" href="#self" id="eqpmnPopupBtn"><span>선택</span></a>
					<input type="hidden" name="eqpmnSns" id="eqpmnSns" value="<c:out value="${result.eqpmnSns }" />" />
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row" >이미지</th>
				<td colspan="3">
				<div class="fileItem">
					<div class="inputFile" style="<c:if test="${fn:length(fileList) > 0 }">display:none;</c:if>">
						<span class="hide_star"><span class="sr-only">(필수입력)</span></span>
						대표 : <input type="file" name="mainImg" id="mainImg" title="대표이미지 등록 " class="col-md-8" style="float:none;" /> <span class="text-danger">※ 대표 이미지는 필수입력</span>
						<br />이미지 권장사이즈 : 710*468
					</div>
					<c:if test="${fn:length(fileList) > 0 }">
					<div style="margin-left:60px;" id="mainImgDiv">
						<img src="/cmm/fms/getImage.do?atchFileId=${fileList[0].atchFileId}&fileSn=${fileList[0].fileSn}" width="200" alt="<c:out value="${fileList[0].orignlFileNm }" />" /> 파일명 : <c:out value="${fileList[0].orignlFileNm }" />
						<input type="hidden" name="fileSn" value="${fileList[0].fileSn}" />
						<a href="#" class="delFileBtn">
							<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileList[0].orignlFileNm}"/> 삭제" class="btn btn-sm" />
						</a>
					</div>
					</c:if>
				</div>
				<div class="fileItem">
					<div class="inputFile" style="<c:if test="${fn:length(fileList) > 1 }">display:none;</c:if>">
						이미지1 : <input type="file" name="subImg01" id="subImg01" title="이미지1 등록 " class="col-md-8" style="float:none;"  />
					</div>
					<c:if test="${fn:length(fileList) > 1 }">
					<div style="margin-left:60px;" id="subImg01Div">
						<img src="/cmm/fms/getImage.do?atchFileId=${fileList[1].atchFileId}&fileSn=${fileList[1].fileSn}" width="200" alt="<c:out value="${fileList[1].orignlFileNm }" />" /> 파일명 : <c:out value="${fileList[1].orignlFileNm }" />
						<input type="hidden" name="fileSn" value="${fileList[1].fileSn}" />
						<a href="#" class="delFileBtn">
							<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileList[1].orignlFileNm}"/> 삭제" class="btn btn-sm" />
						</a>
					</div>
					</c:if>
				</div>
				<div class="fileItem">
					<div class="inputFile" style="<c:if test="${fn:length(fileList) > 2 }">display:none;</c:if>">
						이미지2 : <input type="file" name="subImg02" id="subImg02" title="이미지2 등록 " class="col-md-8" style="float:none;"  />
					</div>
					<c:if test="${fn:length(fileList) > 2 }">
					<div style="margin-left:60px;" id="subImg02Div">
						<img src="/cmm/fms/getImage.do?atchFileId=${fileList[2].atchFileId}&fileSn=${fileList[2].fileSn}" width="200" alt="<c:out value="${fileList[2].orignlFileNm }" />" /> 파일명 : <c:out value="${fileList[2].orignlFileNm }" />
						<input type="hidden" name="fileSn" value="${fileList[2].fileSn}" />
						<a href="#" class="delFileBtn">
							<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileList[2].orignlFileNm}"/> 삭제" class="btn btn-sm" />
						</a>
					</div>
					</c:if>
				</div>
				<div class="fileItem">
					<div class="inputFile" style="<c:if test="${fn:length(fileList) > 3 }">display:none;</c:if>">
						이미지3 : <input type="file" name="subImg03" id="subImg03" title="이미지3 등록 " class="col-md-8" style="float:none;"  />
					</div>
					<c:if test="${fn:length(fileList) > 3 }">
					<div style="margin-left:60px;" id="subImg03Div">
						<img src="/cmm/fms/getImage.do?atchFileId=${fileList[3].atchFileId}&fileSn=${fileList[3].fileSn}" width="200" alt="<c:out value="${fileList[3].orignlFileNm }" />" /> 파일명 : <c:out value="${fileList[3].orignlFileNm }" />
						<input type="hidden" name="fileSn" value="${fileList[3].fileSn}" />
						<a href="#" class="delFileBtn">
							<img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${fileList[3].orignlFileNm}"/> 삭제" class="btn btn-sm" />
						</a>
					</div>
					</c:if>
				</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
</fieldset>

<div class="btnSet clear mt20">

	<div class="row">
		<div class="col-md-12 tac"><a class="btn btn-primary" href="#self" id="regBtn"><span>확인</span></a>
			<a class="btn btn-default" href="/bos/hkFcltyResve/fclty/list.do?${pageQueryString }"><span>취소</span></a>
		</div>
	</div>
</div>


<div id="eqpmnPopup" title="선택장비 찾기">
	<div id="eqpmnPopupCont"></div>
</div>


</form>