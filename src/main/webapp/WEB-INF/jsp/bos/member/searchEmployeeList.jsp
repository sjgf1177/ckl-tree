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
function returnUser(userId, userName)
{
	var retVal   = new Object();
	retVal.userId  = userId;
	retVal.userName  = userName;
	window.returnValue = retVal;
	window.close();
}	

function checkForm(form)
{
	if(!form.searchKeyword.value)
	{
		alert("부서명을 입력하세요.");
		form.searchKeyword.focus();
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
				
					
				<fieldset>
					<legend>게시판검색</legend>
						<form name="frm" method="post" action="/admin/member/searchEmployeeList.do">
						<div class="bbs_search">
							<div class="search_left">
								<label for="selectquarter" class="blind">소속선택</label>				
									<select name="deptId" class="vam" id="selectquarter" title="항목선택">
										<option value="">소속선택</option> 
										<c:forEach var="dept" items="${deptList}" varStatus="status">
									   <option value="${dept.deptId}" <c:if test="${param.deptId == dept.deptId}">selected="selected"</c:if> >${dept.deptName}</option>
										</c:forEach>
									</select>
							</div>
							<div class="search_right">
								<label for="name1"><span>검색어</span></label>
									<select id="name1" name="searchType" class="vam">
										<option value="">선택</option>
										<option value="0" <c:if test="${param.searchType == 0}">selected</c:if>>성명</option>
										<option value="1" <c:if test="${param.searchType == 1}">selected</c:if>>담당업무</option>
									</select>
									<input type="text" class="board1 vam" style="width:125px;" id="name2" name="searchTxt" value="${param.searchTxt}" />
									<label for="input2">
										<input id="input2" class="vam" type="image" alt="검색" src="/portal/open_content/images/common/btn/btn_search_01.gif" />
									</label>
							</div>
						</div>
						</form>
				</fieldset>
				
				<!-- board list start -->
				<table class="list_type01">
					<caption>게시판 목록</caption>
					<colgroup>
						<col width="*" />
						<col width="20%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="fir">소속과</th>
							<th scope="col">소속팀</th>
							<th scope="col">성명</th>
							<th scope="col">직위</th>
							<th scope="col">전화번호</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${fn:length(resultList) > 0}" >
						<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
						<tr>
							<td><a href="javascript:returnUser('${resultList[x].userId}', '${resultList[x].userName}');">${resultList[x].deptName}</a></td>
							<td><a href="javascript:returnUser('${resultList[x].userId}', '${resultList[x].userName}');">${resultList[x].teamName}</a></td>
							<td><a href="javascript:returnUser('${resultList[x].userId}', '${resultList[x].userName}');">${resultList[x].userName}</a></td>
							<td><a href="javascript:returnUser('${resultList[x].userId}', '${resultList[x].userName}');">${resultList[x].positionName}</a></td>
							<td>${resultList[x].tel}</td>
						</tr>
						</c:forEach>
						</c:if>		
						<c:if test="${fn:length(resultList) == 0}" >
						<tr><td colspan="6">데이터가없습니다.</td></tr>
						</c:if>		
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
			