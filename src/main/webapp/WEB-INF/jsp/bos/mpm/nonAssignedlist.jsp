<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="egovframework.com.cmm.service.Globals" var="Globals"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>콘텐츠관리</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />



<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javaScript" language="JavaScript">
<!--

function fncSelectDeptAuthorPop(menuNo) {
	var retVal;
	var url = "/bos/employee/listPop.do?programId=employee";
	var varParam = new Object();
	// IE
	//var openParam = "dialogWidth:500px;dialogHeight:325px;scroll:no;status:no;center:yes;resizable:yes;";
	// FIREFOX
	var openParam = "dialogWidth:1000px;dialogHeight:900px;scroll:no;status:no;center:yes;resizable:no;";
	retVal = window.showModalDialog(url, varParam, openParam);
	if(retVal) {
		$("#deptId_" + menuNo).val(retVal.deptId);
		$("#userId_" + menuNo).val(retVal.userId);
		$("#userName_" + menuNo).val(retVal.userName);
    }

    //window.open(url,"부서검색",'width=500,height=485,scrollbars=no,resizable=no,status=no,center:yes');

}

function finish(menuNo){
	if(!$("#userName_"+menuNo).val()){
		alert("담당자를 먼저지정해 주세요");
		$("#userName_"+menuNo)[0].focus();
		return;
	}

	   var go_url = "${Globals.OS_TYPE eq 'UNIX' ? siteInfo.siteUrl : ''}/bos/mpm/commonContents/assign.do?siteId=${zvl.siteId}&menuNo="+menuNo+"&userId="+$("#userId_"+menuNo).val()+"&deptId="+$("#deptId_"+menuNo).val();
	   window.open(go_url,"menuLoad","resizable=1,scrollbars=1 ,width=300,height=200");
	   /*
	$.getJSON(
			"${siteInfo.siteUrl}/bos/mpm/commonContents/assign.json",
			{
				menuNo : menuNo,
				userId : $("#userId_"+menuNo).val(),
				deptId : $("#deptId_"+menuNo).val(),
				userName : $("#userName_"+menuNo).val(),
				siteId : "${zvl.siteId}"
			},
			function(data){
				var jdata = data.result;
				if( jdata == "0" ){
					alert("상태변경에 실패하였습니다.");
				}
				else{
					alert("성공적으로 수정되였습니다..");
					//location.reload();
				}
			}
		);
	 */
}

function init(menuNo){
	if( !confirm("초기화 하시겠습니까?") ){
		return;
	}
	$("#deptId_" + menuNo).val("");
	$("#userId_" + menuNo).val("");
	$("#userName_" + menuNo).val("");

   var go_url = "${Globals.OS_TYPE eq 'UNIX' ? siteInfo.siteUrl : ''}/bos/mpm/commonContents/assign.do?siteId=${zvl.siteId}&menuNo="+menuNo;
   window.open(go_url,"menuLoad","resizable=1,scrollbars=1 ,width=300,height=200");
}
//-->
</script>
</head>

	<div id="content">
		<div class="hgroup">
		<c:set var="h3Title" value="" />
		<c:choose>
			<c:when test="${param.assigned eq 'Y'}">
				<c:set var="h3Title" value="페이지 담당자 지정대기" />
			</c:when>
			<c:when test="${param.assigned eq 'N'}">
				<c:set var="h3Title" value="페이지 담당자 미지정대기" />
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
			<h3><c:out value="${h3Title}" /></h3>
		</div>

	<form name="listForm" action="<c:url value='/bos/mpm/commonContents/nonAssignedlist/${zvl.siteId}.do'/>" method="post">
  		<input type="hidden" name="assigned" value="${param.assigned}"/>
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="searchType" class="blind">검색조건</label>
		    	<%-- <select name="searchType" id="searchType"  class="select" style="vertical-align:middle;">
		    		<option value="1" ${param.searchType eq '1' ? 'selected="selected"' : ''}>메뉴명</option>
		    	</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchTxt" value="${param.searchTxt}" />
				</label> --%>
				<select name="searchType" id="searchType"  class="select" style="vertical-align:middle;">
				  <option value="0" <c:if test="${param.searchType == '0'}">selected="selected"</c:if> >메뉴명</option>
				   <option value="1" <c:if test="${param.searchType == '1'}">selected="selected"</c:if> >담당자ID</option>
				   <option value="2" <c:if test="${param.searchType == '2'}">selected="selected"</c:if> >담당자</option>
				   <option value="3" <c:if test="${param.searchType == '3'}">selected="selected"</c:if> >메뉴번호</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchTxt" value="${param.searchTxt}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="10%" />
				<col width="*" />
				<col width="30%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">매뉴번호</th>
					<th scope="col">매뉴명</th>
					<th scope="col">담당자</th>
					<th scope="col" class="last">담당자지정</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:choose>
					<c:when test="${Globals.OS_TYPE eq 'WINDOWS'}">
						<c:set var="url" value="" />
					</c:when>
					<c:otherwise>
						<c:set var="url" value="http://www.jungnang.seoul.kr" />
					</c:otherwise>
				</c:choose>

				<tr>
					<td class="output">${resultCnt - (pageInfo.pageIndex-1)*pageInfo.pageUnit}</td>
					<td class="output">${result.menuNo}</td>
			    	<td class="output tal"><a href="${url}${result.fullMenuLink}" target="_blank" title="새창열림">${result.path}</a></td>
			    	<td class="output">
			    		<input type="text" id="userName_${result.menuNo}" name="userName" readonly="readonly" style="width:50px" value="${result.userName}" />
			    		<input type="text" id="userId_${result.menuNo}" name="userId" readonly="readonly" style="width:50px" value="${result.userId}" />
			    		<input type="text" id="deptId_${result.menuNo}" name="deptId" readonly="readonly" style="width:50px" value="${result.deptId}" />
			    		<input type="button" class="btn btn-default" id="btn_${result.menuNo}" name="btn" value="담당자지정" onclick="fncSelectDeptAuthorPop(${result.menuNo});"/>
			    	</td>
					<td class="output">
						<input type="button" class="btn btn-default" id="btnFns_${result.menuNo}" name="btnFns" value="완료" onclick="finish(${result.menuNo});"/>
						<input type="button" class="btn btn-default" id="initBtn_${result.menuNo}" name="initBtn" value="초기화" onclick="init(${result.menuNo});"/>
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	</form>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
</div>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
