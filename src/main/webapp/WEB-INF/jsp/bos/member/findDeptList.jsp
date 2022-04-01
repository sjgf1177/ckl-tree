<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>

<base target="_self">

<link rel="stylesheet" type="text/css" href="/admin/common/css/common_style.css">
<link rel="stylesheet" type="text/css" href="/admin/common/css/board.css">

<script type="text/javascript">
function selectDept(deptCode, deptNm)
{
	opener.setAuthoValue(deptCode, deptNm, '${param.idx}');
	self.close();
}
function returnDept(deptId, deptNm)
{
	var retVal   = new Object();
	retVal.deptId  = deptId;
	retVal.deptNm  = deptNm;
	window.returnValue = retVal;
	window.close();
}	

function checkForm(form)
{
	if(!form.searchTxt.value)
	{
		alert("부서명을 입력하세요.");
		form.searchTxt.focus();
		return false;
	}
	return true;
}
</script>
</head>
	<body>
			<!-- title -->
			<h3 class="tit_03">부서목록</h3>
			
			<!-- text_area start -->
			<div class="text_area">
				
					
				<!-- 게시판 게시물검색 start -->
				<fieldset id="src">
					<legend>게시판 게시물검색</legend>
						<form name="frm" method="post" action="/admin/member/findDeptList.do" onsubmit="return checkForm(this)">
							<input type="hidden" name="idx" value="${param.idx}" />
							<span class="boardsearch">	
							<label for="input1">
								<input id="input1" class="searchinput" type="text" title="검색어입력" style="width:150px" name="searchTxt" value="${param.searchTxt}" />
							</label>
							<label for="input2">
								<input id="input2" type="image" alt="검색" src="/admin/images/common/btn/btn_search_01.gif" />
							</label>				
							</span>
						</form>
				</fieldset><!-- 게시판 게시물검색 end -->
				
				<!-- board list start -->
				<table class="list_type01" >
					<caption>게시판 목록</caption>
					<colgroup>
						<col width="15%" />
						<col width="25%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">부서ID</th>
							<th scope="col">부서명</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td ><a href="javascript:returnDept('${result.deptId}', '${result.deptName}');">${result.deptId}</a></td>
							<td class="tal">
								<a href="javascript:returnDept('${result.deptId}', '${result.deptName}');">
									<c:if test="${result.deptLevel == '2'}">┖ </c:if>${result.deptName}</option>
								</a>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<!-- board list end //-->
								
				<div class="paging">
					<div class="paging_con">
						${pageNav}
					</div>
				</div><!-- paging end //-->
			</div>
			<!-- text_area end -->
		</body>
</html>
			