.<%@ page contentType="text/html; charset=utf-8"%>
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
<%
String imagePath_icon   = "/bos/images/common/";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.engName' text=''/>" />
<meta name="description" content="<spring:message code='site.engName' text=''/>" />
<meta name="author" content="<spring:message code='site.engName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>

<title>카테고리</title>
<script type="text/javascript">
<!--
/* ********************************************************
 * 파일검색 화면 호출 함수
 ******************************************************** */
function searchFileNm() {
	document.menuListForm.tmp_SearchElementName.value = "progrmFileNm";
	window.open('/bos/sym/mpm/ProgramListSearch','','width=500,height=350');
}

/* ********************************************************
 * 메뉴등록 처리 함수
 ******************************************************** */
function insertMenuList() {

	if(!fn_validatorMenuList()){return;}
	document.menuListForm.action = "<c:url value='/bos/category/insert.do'/>";
	menuListForm.submit();

}

function insertChildMenuList() {
	initlMenuList();
	document.menuListForm.upperCategoryId.value = document.menuListForm.categoryId.value;
	//alert(document.menuListForm.upperCategoryId.value);
	document.menuListForm.categoryId.value = "0";
	document.menuListForm.orderly.value = "0";
	document.menuListForm.categoryName.value = "하위카테고리";
	document.menuListForm.action = "<c:url value='/bos/category/insert.do'/>";
	menuListForm.submit();
}

/* ********************************************************
 * 메뉴수정 처리 함수
 ******************************************************** */
function updateMenuList() {
    if(!fn_validatorMenuList()){return;}
    //alert(document.menuListForm.upperCategoryId.value);
	document.menuListForm.action = "<c:url value='/bos/category/update.do'/>";
	menuListForm.submit();
}

/* ********************************************************
 * 메뉴삭제 처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(!confirm("정말로 삭제하시겠습니까?")) return;
	document.menuListForm.action = "<c:url value='/bos/category/delete.do'/>";
	menuListForm.submit();
}

/* ********************************************************
 * 메뉴리스트 조회 함수
 ******************************************************** */
function selectMenuList() {
    document.menuListForm.action = "<c:url value='/bos/category/list.do'/>";
    document.menuListForm.submit();
}

/* ********************************************************
 * 초기화 함수
 ******************************************************** */
function initlMenuList() {
	document.menuListForm.orderly.value="";
	document.menuListForm.categoryName.value="";
}

/* ********************************************************
 * 조회 함수

 ******************************************************** */
function selectMenuListTmp() {
	document.menuListForm.req_RetrunPath.value = "/bos/sym/mpm/MenuList.do";
    document.menuListForm.action = "<c:url value='/bos/sym/mpm/MenuListSelectTmp.do'/>";
    document.menuListForm.submit();
}

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
 function choiceNodes(nodeNum) {
		var nodeValues = nodes[nodeNum].split("|");
		document.menuListForm.categoryId.value = nodeValues[0];
		document.menuListForm.upperCategoryId.value = nodeValues[1];
		document.menuListForm.orderly.value = nodeValues[5];
		document.menuListForm.categoryName.value = nodeValues[6];
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
	if(document.menuListForm.orderly.value == ""){alert("카테고리순서는 Not Null 항목입니다."); return false;}
	if(!checkNumber(document.menuListForm.orderly.value)){alert("카테고리순서는 숫자만 입력 가능합니다."); return false;}
	if(document.menuListForm.categoryName.value == ""){alert("카테고리명은 Not Null 항목입니다."); return false;}

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

function fncMenuLinkCl(){
	if (document.menuListForm.gcon_pcode) document.menuListForm.gcon_pcode.value = "";
	if (document.menuListForm.gcon_uid) document.menuListForm.gcon_uid.value = "";
}

function selectCate(id, nm){
	if (id=='' || id=='0'){
		alert('분류를 선택하여 주십시요.');
		return;
	} else {
		if ('${param.cls}' == '1'){
			opener.document.board.gubun.value=id;
			opener.document.board.option5.value=nm;
		} else {
			opener.document.board.option6.value=id;
			opener.document.board.option2.value=nm;
		}
		self.close();
	}
}
-->
</script>

</head>
<body>
	<div id="content">
		<div class="hgroup"><h3>${param.cls eq '1' ? '분류' : '출처'}찾기
		<c:if test="${not empty param.gubun}">
		(
			<c:if test="${param.gubun eq '1'}">HRST</c:if>
			<c:if test="${param.gubun eq '2'}">RSTI</c:if>
			<c:if test="${param.gubun eq '3'}">RDPS</c:if>
			<c:if test="${param.gubun eq '4'}">ICST</c:if>
			<c:if test="${param.gubun eq '5'}">BIS</c:if>
			<c:if test="${param.gubun eq '6'}">AIM</c:if>
		)
		</c:if>
		</h3></div>

<form name="menuListForm" enctype="multipart/form-data" action ="/bos/category/list.do" method="post">
	<input type="hidden" name="programId" value="pubCategory" />
	<input type="hidden" name="pageQueryString" value="gubun=<c:out value="${param.gubun}"/>&cls=<c:out value="${param.cls}"/>" />
<DIV id="main" style="display:">

<link rel="StyleSheet" href="/common/dtree/dtree.css" type="text/css" />
<script type="text/javascript" src="/common/dtree/dtree.js"></script>

<p><img src="<%=imagePath_icon %>tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle"/>&nbsp;카테고리목록</td></p>
<!-- 메뉴사용 여부 표시 -->
<c:set var="deleteRedTagSt" value="<font color=red>"/>
<c:set var="deleteRedTagEn" value="</font>"/>
<table width="100%" cellpadding="8" class="table-search" border="0">
  <tr>
   <td width="240" height="800" valign="top"  class="title_left" rowspan='2'>
	<div class="tree" style="position:absolute; left:0px; top:112px; width:228px; z-index:10; BORDER : #EEEEEE 0.5pt solid;">

	<script type="text/javascript">
		//<!CDATA[
		d = new dTree('d');
		d.add(0,-1,'메뉴 관리');
		<c:forEach var="result" items="${resultList}" varStatus="status" >
			<c:if test="${result.useYn eq 'Y'}">
				<c:out value="d.add(${result.categoryId},${result.upperCategoryId},'${result.categoryName}','/bos/category/list.do?curCategoryId=${result.categoryId}&gubun=${param.gubun}&cls=${param.cls}');" escapeXml="false"/>
			</c:if>
			<c:if test="${result.useYn eq 'N'}">
				<c:out value="d.add(${result.categoryId},${result.upperCategoryId},'${result.categoryName}${deleteRedTagSt}(x)${deleteRedTagEn}','/bos/category/list.do?curCategoryId=${result.categoryId}&gubun=${param.gubun}&cls=${param.cls}');" escapeXml="false"/>
			</c:if>
			<c:if test="${result.categoryId eq param.curCategoryId}">
				<c:set var="curCategory" value="${result}"/>
			</c:if>
		</c:forEach>
		document.write(d);
		//]]>
	</script>
	</div>
   </td>

   <td width="540" valign="top" style="margin:0; padding:0">
	<table width="100%">
	<c:if test="${not empty curCategory}">
   	<tr>
   	<td>
		<div class="bdView">
		<table summary="게시물 리스트" width="100%">
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
			<tbody>
		  <tr>
		    <th scope="row">분류명:<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td>
		    	${fn:substring(curCategory.categoryName2,1,fn:length(curCategory.categoryName2))}
		    </td>
		  </tr>
		  </tbody>
		  </table>
		</div>
		<div class="btn_set">
			<a class="btn btn-primary"  href="javascript:selectCate('${curCategory.categoryId}','${fn:substring(curCategory.categoryName2,1,fn:length(curCategory.categoryName2))}')"><span>선택</span></a>
		</div>
	 </td>
	 </tr>
   	<tr>
	</c:if>

   	<td>
		<div class="bdView">
		<table summary="게시물 리스트" width="100%">
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
			<tbody>
		  <tr>
		    <th scope="row">카테고리ID<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td>
		    	<input name="gubun" type="hidden" size="10" value="<c:out value='${param.gubun}'/>"  maxlength="10" readonly/>
		    	<input name="cls" type="hidden" size="10" value="<c:out value='${param.cls}'/>"  maxlength="10" readonly/>
		    	<input name="categoryId" type="text" size="10" value="${empty curCategory.categoryId ? '0' : curCategory.categoryId}"  maxlength="10" readonly/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">카테고리순서<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="orderly" type="text" size="10" value="${empty curCategory.orderly ? '0' : curCategory.orderly}"  maxlength="10"/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">카테고리명<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="categoryName" type="text" size="50" value="${curCategory.categoryName}"  maxlength="100"/>
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">상위카테고리ID<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap><input name="upperCategoryId" type="text" size="10" value="${empty curCategory.upperCategoryId ? '0': curCategory.upperCategoryId}"  maxlength="30" />
		    </td>
		  </tr>
		  <tr>
		    <th scope="row">카테고리사용여부<img src="<%=imagePath_icon %>required.gif" width="15" height="15"></th>
		    <td nowrap>
		    	<label><input name="useYn" type="radio" value="Y" <c:if test="${empty curCategory.useYn or curCategory.useYn eq 'Y' }">checked</c:if>> 사용</label>
		     	<label><input name="useYn" type="radio" value="N" <c:if test="${curCategory.useYn eq 'N' }">checked</c:if>/>미사용</label>
		    </td>
		  </tr>
		</table>
		</div>
	 </td>
	 </tr>
   	<tr>
   	<td>
		<div class="btn_set">
			<a class="btn btn-primary" href="javascript:insertChildMenuList()"><span>하위등록</span></a>
			<a class="btn btn-primary" href="javascript:insertMenuList()"><span>등록</span></a>
			<a class="btn btn-primary" href="javascript:updateMenuList()"><span>수정</span></a>
			<a class="btn btn-danger" href="javascript:deleteMenuList()"><span>삭제</span></a>
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
</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>