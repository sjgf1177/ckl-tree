<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title><spring:message code='site.korName' text=''/></title>
<link href="/admin/common/css/pollCss/default.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/common.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/blue.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/board_blue.css" rel="stylesheet" type="text/css" />

<script>

function selectCheckedHandleitemList(year_cd, company_cd, company_id) {
	var openParam = "dialogWidth:800px;dialogHeight:500px;scroll:yes;status:no;center:yes;resizable:no;";
	var varParam = new Object();
	window.showModalDialog('/admin/freecheck/checkform/checked_handleitem_list.do?year_cd='+year_cd+'&company_cd='+company_cd+'&company_id='+company_id, varParam, openParam);
	return false;
};


function viewAnswer(master_cd, company_id) {
	location.href = "/admin/portal/poll/forCheck.do?master_cd="+master_cd+"&company_id="+company_id;
};

function deleteResponse(masterCd, companyId)
{
	if(confirm("해당 사용자의 설문데이터가 모두삭제됩니다. 정말로삭제하시겠습니까?"))
	{
		var url = "/admin/portal/poll/checkform/checkedList/delete.do?master_cd="+masterCd+"&delete_company_id="+companyId;
		location.href = url;
	}
}
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		설문
</h2>
<p class="title_deco"></p>
<div class="body">

		<table summary="의약업소 자율점검 (점검표관리) 페이지" class="bdView">
			<caption>의약업소 자율점검 (점검표관리)</caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td class="output">
						${checkformInfo.title}
					</td>
				</tr>
				
				
				<tr>
					<th scope="row">응모기간</th>
					<td class="output">
						<fmt:formatDate value="${checkformInfo.start_dt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${checkformInfo.end_dt}" pattern="yyyy년 MM월 dd일"/>
					</td>
				</tr>
				
				<tr>
					<td class="output" colspan="2">
						${checkformInfo.contents}
					</td>
				</tr>
				
				
				
				<tr>
					<th scope="row">첨부파일</th>
					<td class="output">
						<c:url value="/portal/poll/download.do" var="download_action">
							<c:param name="file" value="${checkformInfo.attachfile1}" />
						</c:url>
						
						<a href="${download_action}"><strong style="color: gray;">${checkformInfo.attachfile1}</strong></a>
					</td>
				</tr>
				
			</tbody>
		</table>
	</div>
	
			<form action="/admin/freecheck/checkform/saveExcel.do" method="post">
				<input type="hidden" name="master_cd" value="${Bean.master_cd}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="엑셀저장" /></span>
</div>
			</form>
		
	
	
	<table class="bdView">
		<caption>의약업소 자율점검 (점검표관리) 목록</caption>
<!--		<colgroup>-->
<!--			<col width="5%" />-->
<!--			<col width="*" />-->
<!--			<col width="10%" />-->
<!--			<col width="10%" />-->
<!--			<col width="8%" />-->
<!--			<col width="12%" />-->
<!--			<col width="15%" />-->
<!--			<col width="5%" />-->
<!--		</colgroup>-->
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">사용자번호</th>
				<th scope="col">관리</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${fn:length(resultList) != 0}">
				<c:forEach items="${resultList}" var="item" varStatus="status">
					<tr>
						<!-- 번호 -->
						<td>
							 ${(resultListSize + 1) - ((Bean.pageIndex - 1) * Bean.pageSize + status.count)} 
						</td>
						
						<!-- ID-->
						<td>
							<a href="javascript:viewAnswer(${Bean.master_cd}, ${item.COMPANY_ID});">${item.COMPANY_ID}</a>
						</td>
						
						<!-- 관리 -->
						<td>
							<a href="javascript:deleteResponse('${Bean.master_cd}', '${item.COMPANY_ID}');">삭제</a>
							
							<a href="javascript:viewAnswer(${Bean.master_cd}, ${item.COMPANY_ID});">보기</a>
						</td>
						
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="8">검색된 리스트가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	
<ol class="paging">${pagingInfoString}</ol>
	
			<form action="/admin/portal/poll/checkform/list.do" method="post" onsubmit="return checkAndSubmit(this);">
				<input type="hidden" name="searchKeyword" value="${Bean.searchKeyword}"/>
				<input type="hidden" name="year_cd" value="${Bean.year_cd}"/>
<div class="board_btn_set mt13">
	<span class="btn_del"><input type="submit" value="목록보기" /></span>
</div>
			</form>
			
</div>
</body>
</html>