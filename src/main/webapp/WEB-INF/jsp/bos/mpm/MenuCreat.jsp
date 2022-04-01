<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="topCategories" value="${adminMenuCategoryMap['menu_0']}" />

<script type="text/javascript">

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
	};

	initialize();
}


/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {
	/*
	if( $(":input[name='checkField']:checked").length == 0 ){
		alert("적용할 메뉴를 선택하세요.");
		return;
	}
	 */
    document.menuCreatManageForm.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
    document.menuCreatManageForm.action = "<c:url value='/bos/mpm/MenuCreatInsert.do?menuNo=${param.menuNo}'/>";
    document.menuCreatManageForm.submit();
}
/* ********************************************************
 * 메뉴사이트맵 생성 화면 호출
 ******************************************************** */
function fMenuCreatSiteMap() {
	id = document.menuCreatManageForm.authorCode.value;
	window.open('/mpm/EgovMenuCreatSiteMapSelect.do?authorCode='+id,'Pop_SiteMap','scrollbars=yes, width=500, height=700');
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>

</script>

<form name="menuCreatManageForm" action ="/mpm/EgovMenuCreatSelect.do" method="post">
	<input name="checkedAuthorForInsert"  type="hidden" />
	<input name="pageIndex" value="${param.pageIndex}"  type="hidden" />
	<input name="searchKeyword" value="${param.searchKeyword}"  type="hidden" />

	<div class="bdView">
	<table>
		<caption>게시판 쓰기</caption>
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tbody>
		 <tr>
	        <th scope="row">권한코드&nbsp;</th>
	        <td><input name="authorCode" type="text" size="30" value="${resultVO.authorCode}"  maxlength="30" readonly /></td>
	      </tr>
		</tbody>
	</table>
	</div>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fInsertMenuCreat()"><span>권한적용</span></a>
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
				<li>
		 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_folderopen.gif" />
	 		<a href="#" onclick="objLNB.specifyOpen(${x}); return false;" onkeypress="this.onclick();">${topCategories[x].menuNm}</a>
					<ul id="lnb${x}">
				<c:set var="d01MenuKey" value="menu_${topCategories[x].menuNo}" />
				<c:set var="d01Categories" value="${adminMenuCategoryMap[d01MenuKey]}" />
				<c:if test="${fn:length(d01Categories)>0}">
		 		<c:forEach var="y" begin="0" end="${fn:length(d01Categories)-1}">
						<li>
							<label>
							<c:if test="${d01Categories[y].leafNodeYn eq 'Y'}">
								<input type='checkbox' name='checkField' class='check2' value="${topCategories[x].menuNo}_${d01Categories[y].menuNo}" <c:if test="${d01Categories[y].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d01Categories[y].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
							</c:if>
						 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_folderopen.gif" />
					 		${d01Categories[y].menuNm}
							</label>
							<ul>
				<c:set var="menuKey" value="menu_${d01Categories[y].menuNo}" />
				<c:set var="d02Categories" value="${adminMenuCategoryMap[menuKey]}" />
				<c:if test="${fn:length(d02Categories)>0}">
		 			<c:forEach var="z" begin="0" end="${fn:length(d02Categories)-1}">
								<li>
									<label>
									<c:if test="${d02Categories[z].leafNodeYn eq 'Y'}">
										<input type='checkbox' name='checkField' class='check2' value="${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}" <c:if test="${d02Categories[z].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d02Categories[z].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
									</c:if>
								 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_folderopen.gif" />
							 		${d02Categories[z].menuNm}
									</label>
									<ul>
						<c:set var="d02MenuKey" value="menu_${d02Categories[z].menuNo}" />
						<c:set var="d03Categories" value="${adminMenuCategoryMap[d02MenuKey]}" />
						<c:if test="${fn:length(d03Categories)>0}">
						 	<c:forEach var="k" begin="0" end="${fn:length(d03Categories)-1}">
										<li>
										<label>
									<c:if test="${d03Categories[k].leafNodeYn eq 'Y'}">
										<input type='checkbox' name='checkField' class='check2' value="${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}_${d03Categories[k].menuNo}" <c:if test="${d03Categories[k].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d03Categories[k].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
									</c:if>
												 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_page.gif" />
											 		${d03Categories[k].menuNm}
										</label>
											<ul>
								<c:set var="d03MenuKey" value="menu_${d03Categories[k].menuNo}" />
								<c:set var="d04Categories" value="${adminMenuCategoryMap[d03MenuKey]}" />
								<c:if test="${fn:length(d04Categories)>0}">
								 	<c:forEach var="l" begin="0" end="${fn:length(d04Categories)-1}">
												<li>
												<label>
											<c:if test="${d04Categories[l].leafNodeYn eq 'Y'}">
												<input type='checkbox' name='checkField' class='check2' value="${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}_${d03Categories[k].menuNo}_${d04Categories[l].menuNo}" <c:if test="${d04Categories[l].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d04Categories[l].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
											</c:if>
														 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_page.gif" />
													 		${d04Categories[l].menuNm}
												</label>
													<ul>
										<c:set var="d04MenuKey" value="menu_${d04Categories[l].menuNo}" />
										<c:set var="d05Categories" value="${adminMenuCategoryMap[d04MenuKey]}" />
										<c:if test="${fn:length(d05Categories)>0}">
										 	<c:forEach var="m" begin="0" end="${fn:length(d05Categories)-1}">
														<li>
														<label>
													<c:if test="${d05Categories[m].leafNodeYn eq 'Y'}">
														<input type='checkbox' name='checkField' class='check2' value="${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}_${d03Categories[k].menuNo}_${d04Categories[l].menuNo}_${d05Categories[m].menuNo}" <c:if test="${d05Categories[m].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d05Categories[m].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
													</c:if>
																 	<img id=icon1 border=0 alt=Folder src="/bos/images/utl/menu_page.gif" />
															 		${d05Categories[m].menuNm}
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
							</c:forEach>
						</c:if>
									</ul>
								</li>
					</c:forEach>
				</c:if>
						</ul>
					</li>
				</c:forEach>
				</c:if>
					</ul>
				</li>
			</c:forEach>
			</c:if>
			</ul>
		</div>
	    </td>
	  </tr>
	</table>
	</div>
</form>


<script type="text/javascript">
//<![CDATA[
var objLNB = new lnbMenu();
//]]>
</script>
