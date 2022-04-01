<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<title>부서 조회 팝업</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked)
                    checkField[i].value = checkId[i].value;
                if(returnValue == "")
                    returnValue = checkField[i].value;
                else
                    returnValue = returnValue + ";" + checkField[i].value;
            }
        }
    }

    document.listForm.groupIds.value = returnValue;
}

function fncSelectDeptList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
 // document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectDept(deptCode, deptNm) {
 // window.returnValue = deptCode + "|" + deptNm;
    opener.listForm.deptCode.value = deptCode;
    opener.listForm.deptNm.value = deptNm;
    window.close();
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
   //document.listForm.action = "<c:url value='/cmm/sec/ram/EgovDeptSearchList.do'/>";
    document.listForm.submit();
}

function fncSelectDeptConfirm() {
	var checkField = document.listForm.delYn;
    var checkFieldCd = document.listForm.checkId;
	var checkFieldNm = document.listForm.checkNm;
	var checkCount = 0;

	var org_cd;
	var org_nm;

	if(checkField) {
		if(checkField.length > 1) {
			for(var i=0; i<checkField.length; i++) {
				if(checkField[i].checked) {
					checkCount++;
                    org_cd = checkFieldCd[i].value;
                    org_nm = checkFieldNm[i].value;
				}
			}

			if(checkCount == 1) {
             // window.returnValue = org_cd + "|" + org_nm;
                opener.listForm.deptCode.value = org_cd;
                opener.listForm.deptNm.value = org_nm;
                window.close();
		    } else {
			    alert("하나의 부서를 선택하세요.");
			    return;
			}
		} else {
			if(document.listForm.delYn.checked) {
             // window.returnValue = document.listForm.checkId.value + "|" + document.listForm.checkNm.value;
                opener.listForm.deptCode.value = org_cd;
                opener.listForm.deptNm.value = org_nm;
                window.close();
			} else {
	            alert("선택된 항목이 없습니다.");
	            return;
			}
		}
	} else {
        alert("조회 후 선택하시기 바랍니다.");
        return;
	}
}

function press() {

    if (event.keyCode==13) {
    	fncSelectDeptList('1');
    }
}
-->
</script>

</head>

<body>
<form name="listForm" method="post" action="<c:url value='/bos/cmm/sec/ram/DeptSearchList'/>">
<input type="hidden" name="pageIndex" value="<c:out value='${deptAuthorVO.pageIndex}'/>"/>
<input type="hidden" name="searchCondition"/>
	<div id="content">
		<div class="hgroup">
			<h3>부서 조회 팝업</h3>
		</div>

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="input1">
					부서 명 : <input name="searchKeyword" type="text" value="<c:out value="${deptAuthorVO.searchKeyword}"/>" title="검색" onkeypress="press();" />
				</label>
				<label for="input2">
					<a href="javascript:fncSelectDeptList('1')" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="3%" />
				<col width="15%" />
				<col width="25%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">부서 ID</th>
					<th scope="col" class="last">부서 명</th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="dept" items="${deptList}" varStatus="status">
			  <tr>
			    <td><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${dept.deptCode}"/>" /><input type="hidden" name="checkNm" value="<c:out value="${dept.deptNm}"/>" /></td>
			    <td>
			    	<a href="javascript:fncSelectDept('${dept.deptCode}', '${dept.deptNm}')">
			    		${dept.deptCode}
			    	</a>
			    </td>
			    <td>
			    	<a href="javascript:fncSelectDept('${dept.deptCode}', '${dept.deptNm}')">
			    		${dept.deptNm}
			    	</a>
			    </td>
			  </tr>
			 </c:forEach>
			<c:if test="${fn:length(deptList) == 0}"><tr><td colspan="3">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fncSelectDeptConfirm()"><span>확인</span></a>
	</div>

	<c:if test="${fn:length(deptList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>

