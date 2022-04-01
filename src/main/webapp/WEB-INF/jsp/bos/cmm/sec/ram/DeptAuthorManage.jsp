<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
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



<title>부서권한관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
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

function fncManageChecked() {

    var resultCheck = true;

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var selectAuthor = document.listForm.authorManageCombo;
    var booleanRegYn = document.listForm.regYn;

    var returnId = "";
    var returnAuthor = "";
    var returnRegYn = "";

    var checkedCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnId == "") {
                        returnId = checkField[i].value;
                        returnAuthor = selectAuthor[i].value;
                        returnRegYn = booleanRegYn[i].value;
                    }
                    else {
                        returnId = returnId + ";" + checkField[i].value;
                        returnAuthor = returnAuthor + ";" + selectAuthor[i].value;
                        returnRegYn = returnRegYn + ";" + booleanRegYn[i].value;
                    }
                }
            }
            if(checkedCount > 0)
                resultCheck = true;
            else {
                alert("선택된 사용자가 없습니다.");
                resultCheck = false;
            }
        } else {
        	if(document.listForm.delYn.checked == false) {
                alert("선택된 사용자가 없습니다.");
                resultCheck = false;
            }
            else {
            	returnId = checkId.value;
                returnAuthor = selectAuthor.value;
                returnRegYn = booleanRegYn.value;
                resultCheck = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.userIds.value = returnId;
    document.listForm.authorCodes.value = returnAuthor;
    document.listForm.regYns.value = returnRegYn;

    return resultCheck;
}

function fncSelectDeptAuthorList(pageNo) {
	if(document.listForm.deptCode.value == '') {
		alert("부서를 선택하세요");
		return;
	}

    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/bos/cmm/sec/ram/DeptAuthorList.do'/>";
    document.listForm.submit();
}

function fncAddDeptAuthorInsert() {

    if(!fncManageChecked()) return;

    if(confirm("등록하시겠습니까?")) {
        document.listForm.action = "<c:url value='/bos/cmm/sec/ram/DeptAuthorInsert.do'/>";
        document.listForm.submit();
    }
}

function fncDeptAuthorDeleteList() {

    if(!fncManageChecked()) return;

    if(confirm("삭제하시겠습니까?")) {
        document.listForm.action = "<c:url value='/bos/cmm/sec/ram/DeptAuthorDelete.do'/>";
        document.listForm.submit();
    }
}

function linkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/bos/cmm/sec/ram/DeptAuthorList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
    	fncSelectDeptAuthorList('1');
    }
}


$(function(){
	$("#larCd").change(function(){
		var larCd = $("#larCd option:selected").val();
		getMidCodeList(larCd);
	});
	$("#midCd").change(function(){
		var midCd = $("#midCd option:selected").val();
		getSmCodeList(midCd);
	});

	getLarCodeList();
});

function getLarCodeList(){
	$.getJSON(
			"/bos/deptPop/selectDeptList.json",
			{deptDepth : "1"},
			function(data)
			{
	        	$('#larCd').children().remove().end().append('<option selected="selected" value="">--소속국선택</option>') ;
				var jdata = data.resultList;
	            $.each(jdata, function(index, itemData) {
					if( itemData.deptId == "${param.larCd}" )
		            	$("#larCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
					else
		            	$("#larCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
	            });
			}
		);
}

function getMidCodeList(larCd){
	if( !larCd ) return;
	$.getJSON(
			"/bos/deptPop/findDeptList.json",
			{upperDeptId : larCd},
			function(data)
			{
	        	$('#midCd').children().remove().end().append('<option selected="selected" value="">--소속과선택</option>') ;
				var jdata = data.resultList;
	            $.each(jdata, function(index, itemData) {
					if( itemData.deptId == "${param.midCd}" )
		            	$("#midCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
					else
		            	$("#midCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
	            });
			}
		);
}

function getSmCodeList(midCd){
	if( !midCd ) return;
	$.getJSON(
			"/bos/deptPop/findDeptList.json",
			{upperDeptId : midCd},
			function(data)
			{
	        	$('#smCd').children().remove().end().append('<option selected="selected" value="">--소속팀선택</option>') ;
				var jdata = data.resultList;
	            $.each(jdata, function(index, itemData) {
					if( itemData.deptId == "${param.smCd}" )
		            	$("#smCd").append("<option value='"+itemData.deptId+"' selected='selected'>"+itemData.deptName+"</option>");
					else
		            	$("#smCd").append("<option value='"+itemData.deptId+"'>"+itemData.deptName+"</option>");
	            });
			}
		);
}

-->
</script>

</head>

<body>
<form name="listForm" action="<c:url value='/bos/cmm/sec/ram/DeptAuthorList.do'/>" method="post">
<input type="hidden" name="userId"/>
<input type="hidden" name="userIds"/>
<input type="hidden" name="authorCodes"/>
<input type="hidden" name="regYns"/>
<input type="hidden" name="searchCondition"/>
	<div id="content">
		<div class="hgroup"><h3>부서권한관리</h3></div>

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
			<sec:authorize ifAnyGranted="ROLE_SUPER">
				<label for="input1">
					<select id="larCd" name="larCd" title="소속국선택" style="width:150px">
					   <option value=''>--소속국선택</option>
					</select>
					<select id="midCd" name="midCd" title="소속과선택" style="width:150px">
					   <option value=''>--소속과선택</option>
					</select>
					<select id="smCd" name="smCd" title="소속과선택" style="width:150px">
					   <option value=''>--소속팀선택</option>
					</select>
				</label>
			</sec:authorize>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${param.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
				   <option value="4" <c:if test="${param.searchCnd == '4'}">selected="selected"</c:if> >사용자명</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${param.searchWrd}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<%-- <col width="10%" /> --%>
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>
					<th scope="col">사용자 ID</th>
					<th scope="col">사용자 명</th>
					<th scope="col">소속국</th>
					<th scope="col">소속과</th>
					<th scope="col">소속팀</th>
					<th scope="col" class="last">권한</th>
					<!-- <th scope="col" class="last">등록 여부</th> -->
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="deptAuthor" items="${deptAuthorList}" varStatus="status">
			  <tr>
			    <td class="lt_text3" nowrap><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${deptAuthor.uniqId}"/>" /></td>
			    <td class="lt_text3" nowrap><c:out value="${deptAuthor.userId}"/></td>
			    <td class="lt_text3" nowrap><c:out value="${deptAuthor.userNm}"/></td>
			    <td class="lt_text3" nowrap><c:out value="${deptAuthor.gookName}"/></td>
			    <td class="lt_text3" nowrap><c:out value="${deptAuthor.gwaName}"/></td>
			    <td class="lt_text3" nowrap><c:out value="${deptAuthor.teamName}"/></td>
			    <td class="lt_text3" nowrap><select name="authorManageCombo">
			            <c:forEach var="authorManage" items="${authorManageList}" varStatus="status">
			                <option value="<c:out value="${authorManage.authorCode}"/>" <c:if test="${authorManage.authorCode eq deptAuthor.authorCode}">selected</c:if> ><c:out value="${authorManage.authorNm}"/></option>
			            </c:forEach>
			        </select><input type="hidden" name="regYn" value="<c:out value="${deptAuthor.regYn}"/>">
			    </td>
			    <%-- <td class="lt_text3" nowrap><c:out value="${deptAuthor.regYn}"/><input type="hidden" name="regYn" value="<c:out value="${deptAuthor.regYn}"/>"></td> --%>
			  </tr>
			 </c:forEach>
			 </tbody>
			</tbody>
		</table>
	</div>

    <div align="right">
        <input type="text" name="message" value="<c:out value='${message}'/>" size="30" readonly/>
    </div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fncAddDeptAuthorInsert()"><span>등록</span></a>
		<a class="btn btn-danger"  href="javascript:fncDeptAuthorDeleteList()"><span>삭제</span></a>
	</div>

	<c:if test="${fn:length(deptAuthorList) > 0}">
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