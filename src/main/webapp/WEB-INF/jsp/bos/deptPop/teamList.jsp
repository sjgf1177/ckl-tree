<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript">
$(function(){
	$("#pageUnit").change(function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});
});


function selectMenuCreat(vAuthorCode) {
	document.frm.authorCode.value = vAuthorCode;
   	document.frm.action = "<c:url value='/sym/mpm/EgovMenuCreatSelect.do'/>";
   	document.frm.submit();
}

function selectTeamMemList(deptId,teamId){
   	var retVal;
	var url = "/cmm/sec/team/selectAdminDeptMemList.do";
	var varParam = new Object();
	// IE
	//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
	// FIREFOX
	var openParam = "dialogWidth:800px;dialogHeight:600px;scroll:yes;status:no;center:yes;resizable:no;";
	retVal = window.showModalDialog(url, varParam, openParam);
	if(retVal) {
		$("#deptId_" + menuNo).val(retVal.deptId);
		$("#teamId_" + menuNo).val(retVal.teamId);
    }
}
</script>

<title>${brdMstrVO.bbsNm}</title>
</head>
<body>
<form id="frm" name="frm" action ="/bos/deptPop/teamMng/list.do" method="post">
	<input type="hidden" name="programId" value="${param.programId}" />
	<div id="content">
		<div class="hgroup">
			<h3>???????????????</h3>
			<a class="btn btn-success" href="/bos/forprint.jsp" id="print" title="??????" onclick="window.open(this.href, 'printPage', 'width=800,height=550,scrollbars,toolbar,status');return false;" alt="???????????? (?????????????????? ???????????? ??????????????? ??????????????? ???????????????)"><i class="fa fa-hover fa-print"></i> <span>????????????</span></a>
		</div>

		<!-- ????????? ??????????????? start -->
		<div class="sh">
			<fieldset>
			<legend>????????? ???????????????</legend>
			<label for="upperDeptId" class="blind">????????????</label>
			<select name="upperDeptId" class="vam" id="upperDeptId" title="????????????">
				<option value="">????????????</option>
				<c:forEach var="dept" items="${deptList}" varStatus="status">
			    	<option value="${dept.deptId}" <c:if test="${param.upperDeptId == dept.deptId}">selected="selected"</c:if> >${dept.deptName2}</option>
				</c:forEach>
			</select>
			<label for="input2">
				<input type="submit" id="input2" name="input2" value="??????" class="btn btn-default" />
			</label>
			</fieldset>
		</div>
		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>????????? ??????</caption>
			<colgroup>
				<col width="8%" />
				<col width="20%" />
				<col width="*" />
				<col width="10%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">??? ???</th>
					<th scope="col">??? ????????????</th>
					<th scope="col">??? ????????????</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
    			<c:url value='/bos/deptPop/teamMng/forUpdate.do' var="read_url">
					<c:param name="programId" value="${param.programId}"></c:param>
					<c:param name="deptId" value="${result.deptId}"></c:param>
				</c:url>
				<tr>
					<td class="output">${resultCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit}</td>
					<!-- ?????? -->
					<td class="output">
						<a href="${read_url}">${result.deptName}</a>
					</td>
			    	<td class="output">
						<a href="${read_url}">
						${result.teamName}
						</a>
					</td>
			    	<td class="output">${result.deptRank}</td>
			    	<td class="output">
			    	<c:choose>
			    		<c:when test="${result.useYn eq 'Y'}">??????</c:when>
			    		<c:otherwise>????????????</c:otherwise>
			    	</c:choose>
			    	</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">???????????? ????????????.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
	</c:if>

	<div class="btn_set">
		<a href="/bos/deptPop/teamMng/forInsert.do?${pageQueryString}" class="btn btn-primary">??? ??????</a>
	</div>

</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>