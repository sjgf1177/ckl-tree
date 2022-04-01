<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="		<spring:message code='site.engName' text=''/>" />
<meta name="description" content="		<spring:message code='site.engName' text=''/>" />
<meta name="author" content="		<spring:message code='site.engName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />


<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>

<script type="text/javascript">
//<![CDATA[

function fnRtnDtlCdView() {
	location.href = location.href;
}


/**
 * 상위메뉴 등록(1depth) 페이지 이동
 */
function fnGoCodeReg() {
	var frm = document.codeForm;
	var regFrm = document.codeRegForm;
	var upperCode = 0;
	regFrm.upperCode.value = upperCode;
	regFrm.depth.value = 1;

	var defaultVw = document.getElementById("defaultVw");
	var regVw = document.getElementById("regVw");
	var defaultBtn = document.getElementById("defaultBtn");
	var regBtn = document.getElementById("regBtn");

	defaultVw.style.display = "none";
	regVw.style.display  = "";
	defaultBtn.style.display = "none";
	regBtn.style.display  = "";
}

/**
 * 하위메뉴 등록 페이지 이동
 */
function fnGoChildCodeReg(vUpperCd) {
	if (vUpperCd == "") {
		alert("해당 코드를 선택해 주세요.");
		return;
	}
	var frm = document.codeForm;
	var regFrm = document.codeRegForm;
	var upperCode = frm.code.value;
	regFrm.upperCode.value = upperCode;
	regFrm.depth.value = Number(frm.depth.value) + 1;

	var defaultVw = document.getElementById("defaultVw");
	var regVw = document.getElementById("regVw");
	var defaultBtn = document.getElementById("defaultBtn");
	var regBtn = document.getElementById("regBtn");

	defaultVw.style.display = "none";
	regVw.style.display  = "";
	defaultBtn.style.display = "none";
	regBtn.style.display  = "";
}


function fnCodeRegProc() {
	var frm = document.codeRegForm;

	if (frm.codeId.value == "") {
		alert("코드ID를 입력해주세요.");
		frm.codeId.focus();
		return false;
	}
	else if (frm.upperCode.value == "") {
		alert("상위코드를 입력해주세요.");
		frm.upperCode.focus();
		return false;
	}
	else if (frm.code.value == "") {
		alert("코드를 입력해주세요.");
		frm.code.focus();
		return false;
	}
	else if (frm.code.value == "") {
		alert("코드명을 입력해주세요.");
		frm.codeNm.focus();
		return false;
	}
	else if (frm.codeDc.value == "") {
		alert("코드설명을 입력해주세요.");
		frm.codeDc.focus();
		return false;
	}
	else if (frm.sortOrdr.value == "") {
		alert("정렬순을 입력해주세요.");
		frm.sortOrdr.focus();
		return false;
	}

	if (confirm("코드를 등록 하시겠습니까?")) {

		frm.action = "/bos/cmmncode/CmmnCodeDetailRegist.do";
		frm.submit();

	}
}

/**
 * 상세코드정보 수정하기
 */
function fnCodeModifyProc(cd) {

	var frm = document.codeForm;
	var codeId =frm.codeId.value;

	if (frm.codeId.value == "") {
		alert("코드ID를 입력해주세요.");
		frm.codeId.focus();
		return false;
	}
	else if (frm.upperCode.value == "") {
		alert("상위코드를 입력해주세요.");
		frm.upperCode.focus();
		return false;
	}
	else if (frm.code.value == "") {
		alert("코드를 입력해주세요.");
		frm.code.focus();
		return false;
	}
	else if (frm.codeNm.value == "") {
		alert("코드명을 입력해주세요.");
		frm.codeNm.focus();
		return false;
	}
	else if (frm.codeDc.value == "") {
		alert("코드설명을 입력해주세요.");
		frm.codeDc.focus();
		return false;
	}
	else if (frm.sortOrdr.value == "") {
		alert("정렬순을 입력해주세요.");
		frm.sortOrdr.focus();
		return false;
	}

	if (confirm("해당코드를 수정하시겠습니까?")) {

		frm.action = "/bos/cmmncode/CmmnCodeDetailModify.do";
		frm.code.value = cd;
		frm.submit();
	}
}

function fnCodeDeleteProc(cd) {
	if (confirm("해당코드를 삭제하시겠습니까?")) {
		var frm = document.codeForm;
		var codeId =frm.codeId.value;
		frm.action = "/bos/cmmncode/CmmnCodeDetailRemove.do";
		frm.code.value = cd;
		frm.submit();
	}

}


//]]>
</script>
</head>
<body>
	<div id="content" style="width:780px;">
		<div class="hgroup" style="padding-bottom:40px;">
			<h3>${cdCatVO.codeIdNm}(${cdCatVO.codeId}) 공통상세코드 관리</h3>
		</div>

	<table width="700" cellpadding="8" class="table-search" border="0">
	  <tr>
	   <td width="400" height="600"  class="title_left">
		<div class="tree" style="position:absolute; left:0px; top:83px; width:380px; z-index:10; BORDER : #EEEEEE 0.5pt solid;">

		<link rel="StyleSheet" href="/common/dtree/dtree.css" type="text/css" />
		<script type="text/javascript" src="/common/dtree/dtree.js"></script>
		<script type="text/javascript">
			//<!CDATA[
			var d = new dTree('d');
			d.add(0,-1,'상세코드 관리', '/bos/cmmncode/CmmnCodeDetailPop.do?codeId=${cdCatVO.codeId}&code=0');
			<c:forEach var="lstRst" items="${list}" varStatus="status" >
				d.add('${lstRst.code}','${lstRst.upperCode}','<span style="<c:if test="${lstRst.useAt ne 'Y'}">color:red;text-decoration:line-through;</c:if>"><c:out value="${lstRst.codeNm}"  escapeXml="false" />(${lstRst.code})</span>','/bos/cmmncode/CmmnCodeDetailPop.do?codeId=${lstRst.codeId}&code=${lstRst.code}');
			</c:forEach>
			document.write(d);
			//]]>
		</script>
		</div>
	   </td>

	   <td width="400" valign="top" style="margin:0; padding:0">
		<table width="100%">
	   	<tr>
	   	<td>

			<div class="bdView" id="defaultVw">
			<form  id="codeForm" name="codeForm" action="<c:url value='/bos/cmmncode/CmmnCodeDetailPop.do'/>" method="post">
			<input name="codeId" type="hidden" value="<c:out value="${searchVO.codeId}" />" />
			<input name="cmd" type="hidden" value="Modify" />

			<table summary="게시물 리스트" width="100%">
				<caption>게시판 쓰기</caption>
				<colgroup>
					<col width="40%"/>
					<col width="60%"/>
				</colgroup>
				<tbody>
			  <tr>
			    <th scope="row">상위코드<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td>
			    	&nbsp; <input name="upperCode" id="upperCode" type="text" size="15" value="<c:out value="${not empty result.upperCode  ? result.upperCode : '0' }" />"  maxlength="15" readonly="readonly" />
			    </td>
			  </tr>
			  <tr>
			    <th scope="row">코드<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td nowrap>
			      &nbsp; <input name="code" id="code" type="text" size="15" value="<c:out value="${not empty result.code ? result.code  :  '0' }" />"  maxlength="15" <c:if test="${not empty result or empty param.code}">readonly="readonly"</c:if> />
			    </td>
			  </tr>
			  <tr>
			    <th scope="row">코드명<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td nowrap>
			      &nbsp; <input name="codeNm" id="codeNm" type="text" size="30" value="<c:out value="${result.codeNm}"  escapeXml="false" />"  maxlength="30" />
			    </td>
			  </tr>

			  <tr>
			    <th scope="row">코드명(영문)</th>
			    <td nowrap>
			      &nbsp; <input name="codeNmEn" id="codeNmEn" type="text" size="30" value="<c:out value="${result.codeNmEn}"  escapeXml="false" />"  maxlength="30" />
			    </td>
			  </tr>

			  <tr>
			    <th scope="row">Depth</th>
			    <td nowrap>
			      &nbsp; <c:out value="${result.depth}" />
			      <input type="hidden" name="depth" value="<c:out value="${result.depth}" />" />
			    </td>
			  </tr>

			  <tr>
			    <th scope="row">코드설명</th>
			    <td nowrap>
			      &nbsp; <textarea name="codeDc" id="codeDc" cols="25" rows="4"><c:out value="${result.codeDc }" escapeXml="false" /></textarea>
			    </td>
			  </tr>

			  <tr>
			    <th scope="row">코드설명(영문)</th>
			    <td nowrap>
			      &nbsp; <textarea name="codeDcEn" id="codeDcEn" cols="25" rows="4"><c:out value="${result.codeDcEn }" escapeXml="false" /></textarea>
			    </td>
			  </tr>

			  <tr>
				<th scope="row">정렬순서<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
				<td>
			      <input type="text" name="sortOrdr" size="15" maxlength="15" value="<c:out value='${result.sortOrdr }' />" />
				</td>
			 </tr>

			 <!--
			<tr>
				<th scope="row">옵션1</th>
				<td>
			      <input type="text" name="option1" size="15" maxlength="15" value="<c:out value='${result.option1 }' />" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션2</th>
				<td>
			      <input type="text" name="option2" size="15" maxlength="15" value="<c:out value='${result.option2 }' />" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션3</th>
				<td>
			      <input type="text" name="option3" size="15" maxlength="15" value="<c:out value='${result.option3 }' />" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션4</th>
				<td>
			      <input type="text" name="option4" size="15" maxlength="15" value="<c:out value='${result.option4 }' />" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션5</th>
				<td>
			      <input type="text" name="option5" size="15" maxlength="15" value="<c:out value='${result.option5 }' />" />
				</td>
			 </tr>
			  -->


			  <tr>
			    <th scope="row">코드사용여부<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td nowrap>
			      &nbsp; <input name="useAt" id="useAt" type="radio" value="Y" <c:if test="${result.useAt eq 'Y' }">checked="checked"</c:if> /> 사용 <input name="useAt" type="radio" value="N" <c:if test="${result.useAt eq 'N' }">checked="checked"</c:if> />미사용
			    </td>
			  </tr>

			</table>
			</form>
			</div>



			<div class="bdView" id="regVw" style="display:none">
			<form  id="codeRegForm" name="codeRegForm" action="<c:url value='/bos/sym/ccm/cde/CcmCmmnDetailCodeList.do'/>" method="post">
			<input name="codeId" type="hidden" value="<c:out value='${searchVO.codeId}'/>" />
			<table summary="게시물 리스트" width="100%">
				<caption>게시판 쓰기</caption>
				<colgroup>
					<col width="40%"/>
					<col width="60%"/>
				</colgroup>
				<tbody>
			  <tr>
			    <th scope="row">상위코드<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td>
			    	&nbsp; <input name="upperCode" type="text" size="15" value="<c:out value="${not empty result.upperCode  ? result.upperCode : '0' }" />"  maxlength="15" readonly="readonly" />
			    </td>
			  </tr>
			  <tr>
			    <th scope="row">코드<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td nowrap>
			      &nbsp; <input name="code" type="text" size="15" value=""  maxlength="15" />
			    </td>
			  </tr>
			  <tr>
			    <th scope="row">코드명<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td nowrap>
			      &nbsp; <input name="codeNm" type="text" size="30" value=""  maxlength="30" />
			    </td>
			  </tr>

			  <tr>
			    <th scope="row">Depth</th>
			    <td nowrap>
			      <input type="text" name="depth" value="" readonly="readonly" />
			    </td>
			  </tr>

			  <tr>
			    <th scope="row">코드설명</th>
			    <td nowrap>
			      &nbsp; <textarea name="codeDc" cols="25" rows="4"></textarea>
			    </td>
			  </tr>

			  <tr>
				<th scope="row">정렬순서<img src="/bos/images/common/required.gif" alt="필수"  width="15" height="15"></th>
				<td>
			      <input type="text" name="sortOrdr" size="15" maxlength="15" value="" />
				</td>
			 </tr>

			<!--
			<tr>
				<th scope="row">옵션1</th>
				<td>
			      <input type="text" name="option1" size="15" maxlength="15" value="" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션2</th>
				<td>
			      <input type="text" name="option2" size="15" maxlength="15" value="" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션3</th>
				<td>
			      <input type="text" name="option3" size="15" maxlength="15" value="" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션4</th>
				<td>
			      <input type="text" name="option4" size="15" maxlength="15" value="" />
				</td>
			 </tr>
			<tr>
				<th scope="row">옵션5</th>
				<td>
			      <input type="text" name="option5" size="15" maxlength="15" value="" />
				</td>
			 </tr>
			  -->

			  <tr>
			    <th scope="row">코드사용여부<img src="/bos/images/common/required.gif" width="15" height="15"></th>
			    <td nowrap>
			      &nbsp; <input name="useAt" type="radio" value="Y" checked="checked" /> 사용 <input name="useAt" type="radio" value="N" />미사용
			    </td>
			  </tr>

			</table>
			</form>
			</div>



		 </td>
		 </tr>
	   	<tr>
	   	<td>
			<div class="btn_set" id="defaultBtn">

				<span class="button"><a href="" onclick="fnGoCodeReg();return false;">최상위(1depth)코드등록</a></span>
				<span class="button"><a href="" onclick="fnGoChildCodeReg('<c:out value="${empty param.code  ? '0' : param.code }" />');return false;">하위코드등록</a></span>
				<c:if test="${not empty param.code && param.code ne '0'}">
				<span class="button"><a href="" onclick="fnCodeModifyProc('<c:out value="${result.code }" />');return false;">수정</a></span>
				<!--
				<span class="button"><a href="" onclick="fnCodeDeleteProc('<c:out value="${result.code }" />');return false;">삭제</a></span>
				 -->
				</c:if>
			</div>


			<div class="btn_set" id="regBtn" style="display:none;">

				<span class="button"><a href="" onclick="fnCodeRegProc();return false;">등록저장</a></span>
				<span class="button"><a href="" onclick="fnRtnDtlCdView();return false;">뒤로 돌아가기</a></span>
			</div>

		 </td>
		 </tr>
	   	</table>

	   </td>
	 </tr>

	</table>

</div>


</body>
</html>


