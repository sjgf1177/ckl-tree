<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="topCategories" value="${resultMap['CATEGORY_0']}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<title>출처목록</title>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script language="javascript1.2">
<!--
function fCheckAll() {
    var checkField = document.menuCreatManageForm.checkField;
    if(document.menuCreatManageForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function lnbMenu() {
	var depth01Cnt = ${fn:length(topCategories)};
	var _d = document,
	objID = _d.getElementById('lnb_menu'),
	objUl = objID.getElementsByTagName('ul'),
	objUlLength = objUl.length;

	var initialize = function() {
		for(var i=0; i<objUlLength; i++) {
			objUl[i].style.display = 'none';
		}
	};

	this.specifyOpen = function(idx) {
		for(var i=0; i<depth01Cnt; i++)
		{
			var lnbObj = _d.getElementById('lnb'+i);
			if( !lnbObj ){
				continue;
			}
			var lnbUlObj = lnbObj.getElementsByTagName('ul');
			if(idx == i)
			{
				lnbObj.style.display = 'block';
				for(var j=0; j<lnbUlObj.length; j++)
				{
					lnbUlObj[j].style.display = 'block';
				}
			}
			else
			{
				lnbObj.style.display = 'none';
				for(var j=0; j<lnbUlObj.length; j++)
				{
					lnbUlObj[j].style.display = 'none';
				}
			}
		}

		top.doResize();
	};


	initialize();
}


/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {

	if( $(":input[name='checkField']:checked").length == 0 ){
		alert("적용할 메뉴를 선택하세요.");
		return;
	}
	var chkValId = "";
	var chkValName = "";
	$(":input[name=checkField]:checked").each(function(){
		var categoryId = this.id.replace("checkField_", "");
		chkValId += this.value + ",";
		chkValName += $("#categoryName_"+categoryId).val() + ",";
	});
	chkValId = chkValId.slice(0,-1);
	chkValName = chkValName.slice(0,-1);
	opener.document.board.option6.value=chkValId;
	opener.document.board.option2.value=chkValName;
	self.close();
}
-->
</script>

</head>
<body>
<form name="menuCreatManageForm" action ="/sym/mpm/EgovMenuCreatSelect.do" method="post">
	<input name="pageIndex" value="${param.pageIndex}"  type="hidden" />
	<input name="searchKeyword" value="${param.searchKeyword}"  type="hidden" />
	<div id="content">
		<div class="hgroup"><h3>출처목록</h3></div>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fInsertMenuCreat()"><span>출처적용</span></a>
	</div>

	<div class="bdView">
	<table>
	  <tr>
	    <td height="10">
	    <input type='checkbox' name='checkAll' class='check2' onclick='javascript:fCheckAll();' />메뉴목록<br/>
		<div id="authomenu">
			<ul id="lnb_menu">
			<c:if test="${fn:length(topCategories)>0}">
		 	<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
		 	<c:if test="${topCategories[x].categoryClass eq '2'}">
				<li>
			<input type="hidden" id="categoryName_${topCategories[x].categoryId}" name="categoryName_${topCategories[x].categoryId}" value="${topCategories[x].categoryName}" />
			<input type='checkbox' id="checkField_${topCategories[x].categoryId}" name='checkField' class='check2' value="${topCategories[x].categoryId}" <c:if test="${topCategories[x].chkYeoBu > 0}">checked="checked"</c:if> />
		 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_folderopen.gif" />
	 		<a href="#" onclick="objLNB.specifyOpen(${x}); return false;" onkeypress="this.onclick();">${topCategories[x].categoryName}</a>
					<ul id="lnb${x}">
				<c:set var="d01MenuKey" value="CATEGORY_${topCategories[x].categoryId}" />
				<c:set var="d01Categories" value="${resultMap[d01MenuKey]}" />
				<c:if test="${fn:length(d01Categories)>0}">
		 		<c:forEach var="y" begin="0" end="${fn:length(d01Categories)-1}">
						<li>
					<input type="hidden" id="categoryName_${d01Categories[y].categoryId}" name="categoryName_${d01Categories[y].categoryId}" value="${d01Categories[y].categoryName}" />
					<input type='checkbox' id="checkField_${d01Categories[y].categoryId}" name='checkField' class='check2' value="${d01Categories[y].categoryId}" <c:if test="${d01Categories[y].chkYeoBu > 0}">checked="checked"</c:if> />
				 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_folderopen.gif" />
			 		${d01Categories[y].categoryName}
							<ul>
				<c:set var="menuKey" value="CATEGORY_${d01Categories[y].categoryId}" />
				<c:set var="d02Categories" value="${resultMap[menuKey]}" />
				<c:if test="${fn:length(d02Categories)>0}">
		 			<c:forEach var="z" begin="0" end="${fn:length(d02Categories)-1}">
								<li>
									<label>
										<input type="hidden" id="categoryName_${d02Categories[z].categoryId}" name="categoryName_${d02Categories[z].categoryId}" value="${d02Categories[z].categoryName}" />
										<input type='checkbox' id="checkField_${d02Categories[z].categoryId}" name='checkField' class='check2' value="${d02Categories[z].categoryId}" <c:if test="${d02Categories[z].chkYeoBu > 0}">checked="checked"</c:if> />
								 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_folderopen.gif" />
							 		${d02Categories[z].categoryName}
									</label>
								</li>
					</c:forEach>
				</c:if>
						</ul>
					</li>
				</c:forEach>
				</c:if>
					</ul>
				</li>
			</c:if>
			</c:forEach>
			</c:if>
			</ul>
		</div>
	    </td>
	  </tr>
	</table>
	</div>
</div>
</form>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
<script type="text/javascript">
//<![CDATA[
var objLNB = new lnbMenu();
//]]>
</script>

</body>
</html>