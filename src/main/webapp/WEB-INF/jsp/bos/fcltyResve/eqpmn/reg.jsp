<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="action" value="" />
<c:set var="actTp" value="" />
<c:if test="${empty result}">
	<c:set var="action" value="/bos/fcltyResve/eqpmn/insert.do" />
	<c:set var="actTp" value="insert" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/fcltyResve/eqpmn/update.do" />
	<c:set var="actTp" value="update" />
</c:if>

<script type="text/javascript">
//<![CDATA[
var actTp = "<c:out value="${actTp}" />";

$(function(){

	var $item = $(".tempItem > div").clone();
	var listCnt =$("#eqpmnListDiv").find(".detailEqpmnItem").size();
	if (listCnt == 0) $item.appendTo($("#eqpmnListDiv"));



	$("#eqpmnForm").submit(function() {
		checkForm();
		return false;
	});

	$("#regBtn").click(function() {
		checkForm();
		return false;
	});


	$(".bdView").delegate("#addDetailBtn","click", function() {
		var $item = $(".tempItem > div").clone();
		var listCnt =$("#eqpmnListDiv").find(".detailEqpmnItem").size();
		//$item.find(".itemNum").text(listCnt+1);
		var maxNum = listCnt + 1;
		$item.find("input").each(function(n) {
			$(this).attr("name",($(this).attr("name")).replace(/[0-9]/g,'')+ maxNum);
			$(this).attr("id",($(this).attr("id")).replace(/[0-9]/g,'')+ maxNum);
		});

		$item.find("label").each(function(n) {
			$(this).attr("for",($(this).attr("for")).replace(/[0-9]/g,'')+ maxNum);

		});


		$item.appendTo($("#eqpmnListDiv"));

	});

	$(".bdView").delegate(".deleteDetailBtn","click", function() {

		var listCnt =$("#eqpmnListDiv").find(".detailEqpmnItem").size();
		if (listCnt > 1) {
			var items = [];
			var delEqpmnDetailSnArr = $("#delEqpmnDetailSnListStr").val().split(",");
			if ($("#delEqpmnDetailSnListStr").val() != "") items = delEqpmnDetailSnArr;
			var eqpmnDetailSn = $(this).closest(".detailEqpmnItem").find("input[name^=eqpmnDetailSn]").val();
			items.push(eqpmnDetailSn);

			$("#delEqpmnDetailSnListStr").val(items.join(","));
			$(this).closest(".detailEqpmnItem").remove();

		}
		else {
			alert("상세장비 입력 항목이 2개 이상 일 경우 삭제가 가능합니다.");
		}


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



function checkForm() {
	var form = $("#eqpmnForm")[0];
	var v = new MiyaValidator(form);



    v.add("resveSe", {
        required: true
    });

    v.add("eqpmnSe", {
        required: true
    });

    v.add("eqpmnNm", {
        required: true
    });

    v.add("resvePosblAt", {
        required: true
    });

    v.add("useAt", {
        required: true
    });

    v.add("dtlsInfo", {
        required: true
    });


    if ($("input[name=resveSe]:checked").val() == "N") {

	    v.add("resveImprtyResn", {
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

	var flag = true;
	var dtlEqpmnList = [];
	if ($("#eqpmnListDiv").find(".detailEqpmnItem").size() > 0) {
		$("#eqpmnListDiv").find("input[name^=eqpmnDetailNm]").each(function(n) {

			if ($(this).val() == "") {
				alert("상세장비명을 입력해 주세요");
				$(this).focus();
				flag = false;
				return false;
			}
			/*
			else if ($(this).closest("div").find("[name^=detailUseAt]:checked").val() != "Y") {
				alert("사용여부를 체크해주세요.");
				$(this).closest("div").find("[name^=detailUseAt]").focus();
				flag = false;
				return false;
			}
			*/

			var item = {};
			item.eqpmnDetailNm = $(this).val();
			item.eqpmnDetailSn = $(this).closest("div").find("[name^=eqpmnDetailSn]").val();
			item.detailUseAt = $(this).closest("div").find("[name^=detailUseAt]:checked").val();
			item.rm = $(this).closest("div.detailEqpmnItem").find("[name^=rm]").val();
			dtlEqpmnList.push(item);
		});

		if (!flag) return;

		var detailStr = JSON.stringify(dtlEqpmnList);
		detailStr = Base64.encode(detailStr);
		$("#detailEqpmnsStr").val(detailStr);



	}

	var msg = "등록";
	if (actTp == "update") msg = "수정";
	if (confirm(msg + "하시겠습니까?")) form.submit();
}



//]]>
</script>



<div class="tbrinfo text-danger"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>

<form id="eqpmnForm" name="eqpmnForm" method="post" enctype="multipart/form-data" action="<c:out value="${action }" />" class="form-inline">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<input type="hidden" name="detailEqpmnsStr" id="detailEqpmnsStr" value="" />
<input type="hidden" name="eqpmnSn" id="eqpmnSn" value="<c:out value="${result.eqpmnSn }" />" />
<input type="hidden" name="atchFileId" id="atchFileId" value="<c:out value="${result.atchFileId }" />" />
<input type="hidden" name="pageQueryString" id="pageQueryString" value="${pageQueryString }" />
<fieldset>
	<legend></legend>
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
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 장비구분</th>
					<td colspan="3">
						<select name="eqpmnSe" id="eqpmnSe" title="장비구분을 선택해 주세요.">
						 <option value="">-장비구분선택-</option>
						 <c:forEach var="item" items="${COM098CodeList }">
							<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq result.eqpmnSe}">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
						</c:forEach>
						</select>
					</td>

				</tr>
				<tr>
					<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="eqpmnNm">장비명</label></th>
					<td colspan="3"><input type="text" name="eqpmnNm" id="eqpmnNm" value="<c:out value="${result.eqpmnNm }" />" style="width:90%;" /></td>
				</tr>
				<tr>
					<th scope="row" ><label for="TOOLSEL">장비명(영문)</label></th>
					<td colspan="3"><input type="text" name="eqpmnNmEn" id="eqpmnNmEn" value="<c:out value="${result.eqpmnNmEn }" />" style="width:90%;" /></td>
				</tr>
				<tr>
					<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 예약가능여부</th>
					<td>
						<label for="resvePosblAt01"><input type="radio" name="resvePosblAt" value="Y" id="resvePosblAt01" <c:if test="${result.resvePosblAt eq 'Y' }">checked="checked"</c:if> /> 예약가능 </label>
						<label for="resvePosblAt02"><input type="radio" name="resvePosblAt" value="N" id="resvePosblAt02" <c:if test="${result.resvePosblAt eq 'N' }">checked="checked"</c:if> /> 예약불가 </label>
						<label for="resvePosblAt03"><input type="radio" name="resvePosblAt" value="I" id="resvePosblAt03" <c:if test="${result.resvePosblAt eq 'I' }">checked="checked"</c:if> /> 개별예약가능 </label>
					</td>
					<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 사용여부</th>
					<td>
						<label for="useAt01"><input type="radio" name="useAt" value="Y" id="useAt01" <c:if test="${result.useAt eq 'Y' }">checked="checked"</c:if> /> 사용 </label>
						<label for="useAt02"><input type="radio" name="useAt" value="N" id="useAt02" <c:if test="${result.useAt eq 'N' }">checked="checked"</c:if> /> 미사용 </label>
					</td>
				</tr>
				<tr id="resveImprtyResnTr" style="display:none">
					<th scope="row" ><span class="hide_star" id="resveImprtyResnRequired"><span class="sr-only">(필수입력)</span></span> <label for="resveImprtyResn">예약불가사유</label></th>
					<td colspan="3"><input type="text" name="resveImprtyResn" id="resveImprtyResn" value="<c:out value="${result.resveImprtyResn }" />" readonly="readonly" /></td>
				</tr>
				<tr>
					<th scope="row" ><label for="dtlsInfo"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 세부내역</label></th>
					<td colspan="3"><textarea name="dtlsInfo" id="dtlsInfo" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" ><c:out value="${result.dtlsInfo }" /></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row" ><label for="dtlsInfoEn">세부내역(영문)</label></th>
					<td colspan="3"><textarea name="dtlsInfoEn" id="dtlsInfoEn" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" ><c:out value="${result.dtlsInfoEn }" /></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row" >이미지</th>
					<td colspan="3">
					<div class="fileItem">
						<div class="inputFile" style="<c:if test="${fn:length(fileList) > 0 }">display:none;</c:if>">
							<span class="hide_star"><span class="sr-only">(필수입력)</span></span>
							대표 : <input type="file" name="mainImg" id="mainImg" title="대표이미지 등록 " class="col-md-8" style="float:none;" /> <span class="text-danger">※ 대표 이미지는 필수입력</span>
							<br />이미지 권장사이즈 : 710*464
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
				<tr>
					<th scope="row" ><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 상세장비</th>
					<td colspan="3">
					<div class="row">
						<div class="col-md-8" id="eqpmnListDiv">
						<input type="hidden" name="delEqpmnDetailSnListStr" id="delEqpmnDetailSnListStr" value="" />
						<c:forEach var="item" items="${detailList }" varStatus="status">
							<div class="detailEqpmnItem pt10" style="border-bottom:1px solid #e2e2e2;">
								<div>
									<span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="eqpmnDetailNm">상세장비명 1 : </label>
									<input type="text" name="eqpmnDetailNm${status.index }" id="eqpmnDetailNm${status.index }" value="<c:out value="${item.eqpmnDetailNm }" />" style="width:240px" />
									<label for="detailUseAt${status.index }"><input type="checkbox" name="detailUseAt${status.index }" id="detailUseAt${status.index }" value="Y" <c:if test="${item.useAt eq 'Y' }">checked="checked"</c:if> /> 사용여부</label>
									<input type="hidden" name="eqpmnDetailSn${status.index }" id="eqpmnDetailSn${status.index }" value="<c:out value="${item.eqpmnDetailSn }" />" />
								</div>
								<div>
									<label for="rm">비고 : </label> <input type="text" name="rm${status.index }" id="rm${status.index }" value="<c:out value="${item.rm }" />" style="width:240px" />

									<a class="btn btn-default deleteDetailBtn" href="#self"><span>삭제</span></a>
								</div>
							</div>
						</c:forEach>
						</div>
						<div class="col-md-4"><a class="btn btn-primary" href="#self" id="addDetailBtn"><span>추가</span></a></div>
					</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</fieldset>
</form>

<div class="btnSet clear mt20">

	<div class="row">
		<div class="col-md-12 tac"><a class="btn btn-primary" href="#self" id="regBtn"><span>확인</span></a>
			<a class="btn btn-default" href="/bos/fcltyResve/eqpmn/list.do?${pageQueryString }"><span>취소</span></a>
		</div>
	</div>
</div>

<div class="tempItem" style="display:none;">
	<div class="detailEqpmnItem pt10" style="border-bottom:1px solid #e2e2e2;">
		<div>
			<span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="eqpmnDetailNm1">상세장비명<span class="itemNum"></span> : </label>
			<input type="text" name="eqpmnDetailNm1" id="eqpmnDetailNm1" value="" style="width:240px" />
			<label for="detailUseAt1"><input type="checkbox" name="detailUseAt1" id="detailUseAt1" value="Y" /> 사용여부 </label>
			<input type="hidden" name="eqpmnDetailSn1" id="eqpmnDetailSn1" value="" />
		</div>
		<div class="mt5 mb10">
			<label for="rm1">비고 : </label> <input type="text" name="rm1" id="rm1" value="" style="width:240px" />
			<a class="btn btn-default deleteDetailBtn" href="#self"><span>삭제</span></a>
		</div>
	</div>
</div>


