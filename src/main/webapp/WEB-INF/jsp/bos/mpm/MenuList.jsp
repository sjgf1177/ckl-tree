<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.siteMng.service.SiteMngService" var="SiteMngService"/>
<ccc:constantsMap className="egovframework.com.cmm.service.Globals" var="Globals"/>

<c:set var="ImgUrl" value="/images/egovframework/sym/mpm/"/>
<c:set var="CssUrl" value="/css/egovframework/sym/mpm/"/>

<c:set var="siteId" value="${siteId}" />
<c:if test="${empty siteId}" >
	<c:set var="siteId" value="1" />
</c:if>
<c:set var="siteUrl" value="${Globals.OS_TYPE eq 'WINDOWS' ? '' : siteInfo.siteUrl}" />
<%
//showmodaldialog 참고자료 http://www.egovframe.go.kr/wiki/doku.php?id=egovframework:com:v3:cmm:showmodaldialog
String imagePath_icon   = "/bos/images/common/";
%>
<script type="text/javascript" src="<c:url value="/validator.do" />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript">
<!--
/* ********************************************************
 * 파일검색 화면 호출 함수
 ******************************************************** */
function searchFileNm() {
	document.menuListForm.tmp_SearchElementName.value = "progrmFileNm";
	window.open('/bos/mpm/ProgramListSearch','','width=500,height=350');
}

/* ********************************************************
 * 메뉴등록 처리 함수
 ******************************************************** */
function insertMenuList() {

	if(!fn_validatorMenuList()){return;}
	document.menuListForm.action = "<c:url value='/bos/mpm/MenuListInsert.do'/>";
	menuListForm.submit();

}

function insertChildMenuList() {
	initlMenuList();
	document.menuListForm.upperMenuId.value = document.menuListForm.cMenuNo.value;
	//alert(document.menuListForm.upperMenuId.value);
	document.menuListForm.cMenuNo.value = "0";
	document.menuListForm.menuOrdr.value = "0";
	document.menuListForm.menuNm.value = "하위메뉴";
	if(document.menuListForm.gcon_pcode) document.menuListForm.gcon_pcode.value = "";
	if(document.menuListForm.gcon_uid) document.menuListForm.gcon_uid.value = "";

	document.menuListForm.action = "<c:url value='/bos/mpm/MenuListInsert.do'/>";
	menuListForm.submit();
}

/* ********************************************************
 * 메뉴수정 처리 함수
 ******************************************************** */
function updateMenuList() {
    if(!fn_validatorMenuList()){return;}
    //alert(document.menuListForm.upperMenuId.value);
	document.menuListForm.action = "<c:url value='/bos/mpm/MenuListUpdt.do'/>";
	menuListForm.submit();
}

/* ********************************************************
 * 메뉴삭제 처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(!fn_validatorMenuList()){return;}
    if(!confirm("정말로 삭제하시겠습니까?")) return;
	document.menuListForm.action = "<c:url value='/bos/mpm/MenuListDelete.do'/>";
	menuListForm.submit();
}

/* ********************************************************
 * 메뉴리스트 조회 함수
 ******************************************************** */
function selectMenuList() {
    document.menuListForm.action = "<c:url value='/bos/mpm/MenuListSelect.do'/>";
    document.menuListForm.submit();
}


/* ********************************************************
 * 초기화 함수
 ******************************************************** */
function initlMenuList() {
	document.menuListForm.menuOrdr.value="";
	document.menuListForm.menuNm.value="";
	document.menuListForm.menuDc.value="";
	document.menuListForm.menuLink.value="";
	document.menuListForm.menuPopupYn.value="";
	<c:if test="${not siteId eq '1'}">
	document.menuListForm.contentsPath.value="";
	</c:if>
	//document.menuListForm.deptId.value = "";
}

/* ********************************************************
 * 조회 함수

 ******************************************************** */
function selectMenuListTmp() {
	document.menuListForm.req_RetrunPath.value = "/bos/mpm/MenuList.do";
    document.menuListForm.action = "<c:url value='/bos/mpm/MenuListSelectTmp.do'/>";
    document.menuListForm.submit();
}

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
 function choiceNodes(nodeNum) {
		var nodeValues = nodes[nodeNum].split("|");
		document.menuListForm.cMenuNo.value = nodeValues[0];
		document.menuListForm.upperMenuId.value = nodeValues[1];
		document.menuListForm.menuOrdr.value = nodeValues[5];
		document.menuListForm.menuNm.value = nodeValues[6];
		document.menuListForm.menuDc.value = nodeValues[8];
		document.menuListForm.siteId.value = nodeValues[12];
		document.menuListForm.menuLink.value = nodeValues[13];
		document.menuListForm.menuPopupYn.value = nodeValues[14];
		document.menuListForm.deptId.value = nodeValues[15];
}

/* ********************************************************
 * 입력값 validator 함수
 ******************************************************** */
function fn_validatorMenuList() {
	if(document.menuListForm.menuOrdr.value == ""){alert("메뉴순서는 Not Null 항목입니다."); return false;}
	if(!checkNumber(document.menuListForm.menuOrdr.value)){alert("메뉴순서는 숫자만 입력 가능합니다."); return false;}
	if(document.menuListForm.menuNm.value == ""){alert("메뉴명은 Not Null 항목입니다."); return false;}

    return true;
}

/* ********************************************************
 * 필드값 Number 체크 함수
 ******************************************************** */
function checkNumber(str) {
    var flag=true;
    if (str.length > 0) {
        for (i = 0; i < str.length; i++) {
            if (str.charAt(i) < '0' || str.charAt(i) > '9') {
                flag=false;
            }
        }
    }
    return flag;
}

function fncSelectDeptAuthorPop() {
	var retVal;
	var url = "/bos/member/listPop.do";
	var varParam = new Object();
	// IE
	//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
	// FIREFOX
	var openParam = "dialogWidth:1000px;dialogHeight:900px;scroll:no;status:no;center:yes;resizable:no;";
	retVal = window.showModalDialog(url, varParam, openParam, 'showModalDialogDeptAuthorCallback');
	if (retVal) {
        document.menuListForm.deptId.value = retVal.deptId;
        document.menuListForm.userId.value = retVal.userId;
        document.menuListForm.userName.value = retVal.userName;
	}
}

function showModalDialogDeptAuthorCallback(retVal) {
	if (retVal) {
        document.menuListForm.deptId.value = retVal.deptId;
        document.menuListForm.userId.value = retVal.userId;
        document.menuListForm.userName.value = retVal.userName;
	}
}

function fnSelectBbsMaster() {
	var retVal;
	var url = "/bos/bbs/SelectBBSMasterInfs.do?popupYn=Y&siteId=${siteId}";
	var varParam = new Object();
	// IE
	//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
	// FIREFOX
	var openParam = "dialogWidth:1000px;dialogHeight:650px;scroll:no;status:no;center:yes;resizable:no;";
	retVal = window.showModalDialog(url, varParam, openParam);
}

function showModalDialogCallback(retVal) {
	if (retVal) {
        document.menuListForm.menuLink.value = retVal.menuLink;
        document.menuListForm.bbsId.value = retVal.bbsId;
	}
}

function fncMenuLinkPopup(){
	var url = "/bos/mpm/MenuLinkSearchList.do";

	window.open(url,"부서검색",'width=600,height=500,scrollbars=no,resizable=no,status=no,center:yes');

}

function menuNmChange(obj){
	if(document.getElementsByName("lang_menu_nm")[0]){
		document.getElementsByName("lang_menu_nm")[0].value=obj.value;
	}
}

function lang_use_at_clk(num){
	if(document.getElementsByName("lang_use_at")[num]){
		if (document.getElementsByName("lang_use_at_chk")[num].checked==true){
			document.getElementsByName("lang_use_at")[num].value="Y";
		} else {
			document.getElementsByName("lang_use_at")[num].value="N";
		}
	}
}

function menuLoad(){
   var siteId = "${siteId}";
   var go_url = "/bos/mpm/MenuLoadSite/"+siteId + ".do";
   window.open(go_url,"menuLoad","resizable=1,scrollbars=1 ,width=300,height=200");
}

function menuLoadAll(){
	   var go_url = "/bos/mpm/MenuLoadSite.do";
	   window.open(go_url,"menuLoad","resizable=1,scrollbars=1 ,width=300,height=200");
}

function fncMenuLinkCl(){
	if (document.menuListForm.gcon_pcode) document.menuListForm.gcon_pcode.value = "";
	if (document.menuListForm.gcon_uid) document.menuListForm.gcon_uid.value = "";
}

function win_preView() {
	<c:if test="${empty cMenuNo}">
	alert('매뉴를 먼저 선택하여 주십시오.');
	return;
	</c:if>
	var siteId = "${siteId}";
	var _action = "${siteUrl}/${siteInfo.siteName}/cts/preview/${cMenuNo}.do";
	var FormObj = document.menuListForm;
	var PopWindow = "pop_win";
	var win = window.open("",PopWindow,"resizable=1,scrollbars=1 ,width=900,height=600");
	FormObj.target = PopWindow ; // 팝업윈도우 객체
	FormObj.action = _action; // target JSP명
	FormObj.submit();
}

function winHistoryView(obj) {
	<c:if test="${empty cMenuNo}">
	alert('매뉴를 먼저 선택하여 주십시오.');
	return;
	</c:if>
	window.open(obj.href,"history","resizable=1,scrollbars=1 ,width=900,height=600");
	return;
}

function initDept(){
	$("#deptId").val("");
	$("#userId").val("");
	$("#userName").val("");
}
-->
</script>

<div id="main" style="display:"></div>
<form name="menuListForm" action ="/bos/mpm/MenuListSelect.do" method="post">
<input type="hidden" name="req_RetrunPath" value="/bos/mpm/MenuList" />
<input type="hidden" name="siteId" value="${siteId}" />
<input type="hidden" name="menuNo" value="${param.menuNo}" />


<link rel="stylesheet" href="/common/dtree/dtree.css" type="text/css" />
<script type="text/javascript" src="/common/dtree/dtree.js"></script>

<p><img src="<%=imagePath_icon %>tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle"/>&nbsp;메뉴 목록</td></p>
<!-- 메뉴사용 여부 표시 -->
<c:set var="deleteRedTagSt" value="<font color=red>"/>
<c:set var="deleteRedTagEn" value="</font>"/>
<table width="100%" cellpadding="8" class="table-search" border="0">
  <tr>
   <td width="240" height="800"  class="title_left" rowspan='2' style="vertical-align:top">
	<div class="tree" style="left:0px; top:0; width:228px; z-index:10; BORDER : #EEEEEE 0.5pt solid;">

	<script type="text/javascript">
		//<!CDATA[
		d = new dTree('d');
		d.add(0,-1,'메뉴 관리');
		<c:forEach var="result" items="${list_menulist}" varStatus="status" ><c:if test="${result.useYn eq 'Y'}"><c:out value="d.add(${result.menuNo},${result.upperMenuNo},'${result.menuNm}','/bos/mpm/MenuListSelect/${result.siteId}.do?cMenuNo=${result.menuNo}&menuNo=${param.menuNo}');" escapeXml="false"/></c:if>
		<c:if test="${result.useYn eq 'N'}"><c:out value="d.add(${result.menuNo},${result.upperMenuNo},'${result.menuNm}${deleteRedTagSt}(x)${deleteRedTagEn}','/bos/mpm/MenuListSelect/${result.siteId}.do?cMenuNo=${result.menuNo}&menuNo=${param.menuNo}');" escapeXml="false"/></c:if>
		<c:if test="${result.menuNo eq cMenuNo}"><c:set var="cMenu" value="${result}"/></c:if></c:forEach>
		document.write(d);
		//]]>
	</script>
	</div>
   </td>

   <td width="540" valign="top" style="margin:0; padding:0">
	<table width="100%">
   	<tr>
   	<td>
		<div class="btn_set">
			<a class="btn btn-primary" href="javascript:insertChildMenuList()"><span>하위메뉴등록</span></a>
			<a class="btn btn-primary" href="javascript:menuLoad();"><span>해당 사이트 메뉴 적용</span></a>
		</div>
	 </td>
	 </tr>
   	<tr>
   	<td>
		<div class="bdView">
		<table class="fixed" >
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col style="width:110px"/>
				<col />
			</colgroup>
			<tbody>
		  <tr>
		    <th scope="row">메뉴번호<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td><input name="cMenuNo" type="text" size="10" value="${empty cMenu.menuNo ? '0' : cMenu.menuNo}"  maxlength="10" readonly/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">메뉴순서<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="menuOrdr" type="text" size="10" value="${cMenu.menuOrdr}"  maxlength="10"/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">메뉴명<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="menuNm" type="text" size="50" value="${cMenu.menuNm}"  maxlength="100"/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">상위메뉴No<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="upperMenuId" type="text" size="10" value="${empty cMenu.upperMenuNo ? '0': cMenu.upperMenuNo}"  maxlength="30" />
		    </td>
		  </tr>

		  <tr>
		    <th scope="row">메뉴팝업유무<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap>
		    	<label><input name="menuPopupYn" type="radio" value="Y" ${cMenu.menuPopupYn eq 'Y' ? 'checked' : ''}> 사용</label>
		    	<label><input name="menuPopupYn" type="radio" value="N" ${cMenu.menuPopupYn ne 'Y' ? 'checked' : ''} />미사용</label>
		    </td>
		  </tr>

		  <tr>
		    <th scope="row">메뉴링크<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap>
		      <input name="menuLink" type="text" size="60" value="${cMenu.menuLink}"  maxlength="300" style="width:350px"/>
		      <input type="hidden" name="bbsId" value="${cMenu.bbsId}" />
		      <input type="button" class="btn btn-default" name="user" value="게시판선택" onclick="fnSelectBbsMaster()" />
		    </td>
		  </tr>
		 <tr>
		    <th scope="row">담당자 지정<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td width="35%" nowrap>
		      <input type="text" id="userName" name="userName" value="${cMenu.userName}" size="30" cssClass="txaIpt" maxlength="30" readonly="readonly"  style="width:100px"/>
		      <input type="hidden" id="deptId" name="deptId" value="${cMenu.deptId }" class="board1 w100" readonly="readonly" />
		      <input type="text" id="userId" name="userId" value="${cMenu.userId }" class="board1 w100" readonly="readonly" />
		      <input type="button" class="btn" name="user" value="선택" onclick="fncSelectDeptAuthorPop()" />
		      <input type="button" class="btn" name="user" value="초기화" onclick="initDept()" />
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">메뉴사용여부<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap>
		    	<label><input name="useYn" type="radio" value="Y" <c:if test="${cMenu.useYn eq 'Y' }">checked</c:if>> 사용</label>
		     	<label><input name="useYn" type="radio" value="N" <c:if test="${cMenu.useYn eq 'N' }">checked</c:if>/>미사용</label>
		    </td>
		  </tr>
		  <tr>
		    <th height="23" class="required_text" >메뉴설명</th>
		    <td class="td_txtarea"><textarea name="menuDc" class="textarea"  cols="45" rows="2"  style="width:98%;" value="">${cMenu.menuDc}</textarea>
		    </td>
		  </tr>
		  <c:if test="${siteId != '1'}">
		  <tr>
		    <th scope="row">자료담당자</th>
		    <td nowrap><input name="pic" type="text" size="70" value="${cMenu.userName}"  maxlength="200" />
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">전화번호</th>
		    <td nowrap><input name="tel" type="text" size="70" value="${cMenu.tel}"  maxlength="200" />
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">콘텐츠경로<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="contentsPath" type="text" size="70" value="${cMenu.contentsPath}"  maxlength="200" />
		    </td>
		  </tr>
		  <tr>
		    <td colspan="2" style="padding:10px 3px 10px 3px;">
			  <table width="100%" cellSpacing="0" cellPadding="0" border="0">
			  <tr>
			  <td><!-- <input type="checkbox" name="chkConModi" id="chk_con_modi" value="Y"/> <label for="chk_con_modi" >콘텐츠 등록/수정</label>(메뉴링크 없을 경우 노출.)<br/> --></td>
			  <td align="right">
				<!-- <a href="javascript:win_preView();">[콘텐츠 미리보기]</a> -->
			  	<a href="/bos/mpm/commonContents/forUpdate.do?siteId=${siteId}&sMenuNo=${cMenuNo}&viewType=BODY" target="_blank" title="새창열림" onclick="window.open(this.href,'contentPop','width=970,height=800');return false;">[콘텐츠 버젼관리]</a></td>
			  </tr>
			  </table>
		    </td>
		  </tr>
		  </c:if>

		</table>
		</div>
	 </td>
	 </tr>
   	<tr>
   	<td>
		<div class="btn_set">
			<a class="btn btn-primary" href="javascript:initlMenuList()"><span>초기화</span></a>
			<a class="btn btn-primary" href="javascript:insertMenuList()"><span>메뉴등록</span></a>
			<a class="btn btn-info" href="javascript:updateMenuList()"><span>수정</span></a>
			<a class="btn btn-danger"  href="javascript:deleteMenuList()"><span>삭제</span></a>
		</div>
	 </td>
	 </tr>
   	</table>

   </td>
 </tr>

</table>
<br/>

<div>
    <input type="hidden" name="tmp_SearchElementName" value="">
    <input type="hidden" name="tmp_SearchElementVal" value="">
    <input type="hidden" name="tmp_CheckVal" value="">
</DIV>

</form>
