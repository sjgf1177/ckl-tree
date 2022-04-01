<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.unp.archive.service.ArchiveBosService"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util"%>
<ui:pagination paginationInfo="${paginationInfo}" type="adminImage" jsFunction="fn_egov_select"/>
<script type="text/javascript">

// 체크 박스 체크 여부 
$(function() {
	$("#chkAll").click(function(){
		if(this.checked)
			$(":checkbox").attr("checked", true);
		else
			$(":checkbox").attr("checked", false);
	});
});

</script>

<!-- 연도 사업구분 주관기관명 과제명 불러오기 -->
<form id="frm" name="frm" method="post" action="/bos/archive/deptList.do?taskSeq=${param.taskSeq}&menuNo=${param.menuNo}" class="form-inline" >
		
 		<input type="hidden" name="taskSeq" value="${param.taskSeq}"> 
		<input type="hidden" name="pageQueryString" value="${pageQueryString}">
		<fieldset>
		<div class="bdView mb0">
			<table class="table table-bordered">
				<caption></caption>
					<colgroup>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
			</colgroup>
				
				<tbody>
				<c:forEach var="task" items="${taskList}" varStatus="status">
					<tr>
						<th><label for="year">연도</label></th>
						<td>${task.year}</td>
						
						<th><label for="workField">사업구분</label></th>
						<c:if test="${task.workField eq '1'}">
							<td>창의인재동반 </td>
						</c:if>
						<c:if test="${task.workField eq '2'}">
							<td>실감콘텐츠장착 </td>
						</c:if>
						<c:if test="${task.workField eq '3'}">
							<td>콘텐츠원캠퍼스 </td>
						</c:if>
						<c:if test="${task.workField eq '4'}">
							<td>콘텐츠임팩트 </td>
						</c:if>
					</tr>
					<tr>
						<th><label for="organNm">주관기관명</label></th>
						<td colspan="3">${task.organNm}</td>
					</tr>
					<tr>
						<th><label for="taskNm">과제명</label></th>
						<td colspan="3">${task.taskNm}</td>
					</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</div>
	</fieldset>
</form>

<!-- 페이징 처리 -->
<div class="row mt10 mb5">
	<div class="col-md-12">
		총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건
		| <strong class="text-danger"><c:out
				value="${paramVO.projectPageIndex }" /> / <c:out value="${totalPage }" /></strong> Page
	</div>
</div> 

<div class="bdList">
	<table class="table table-bordered">
		<caption></caption>
		<colgroup>
			<!-- 번호  -->
			<col style="width: 35px;">
			<!-- 프로젝트명  -->
			<col>
			<!-- 사용여부 -->
			<col style="width: 70px;">
			<!-- 공개여부-->
			<col style="width: 70px;">
			<!-- 주요성과 여부 -->
			<col style="width: 70px;">
			<!-- 등록자 -->
			<col style="width: 70px;">
			<!-- 등록일 -->
			<col style="width: 100px;">
			<!-- 프로젝트 관리 -->
			<col style="width: 70px;">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>프로젝트명</th>
				<th>사용여부</th>
				<th>공개여부</th>
				<th>주요성과 여부</th>
				<th>등록자</th>
				<th>등록일</th>
				<th>프로젝트 관리</th>
			</tr>
		</thead>
		<tbody  style="text-align:center;">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td style="text-align:left;">${result.projectNm}</td>
					<td>${result.useAt1 eq 'N' ? '미사용' : '사용'}</td>
					<td>${result.openAt eq 'N' ? '미공개' : '공개'}</td>
					<td>${result.mainResultAt eq 'N' ? '미사용' : '사용'}</td>
					<td>${result.userNm}</td>
					<td><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></td> 
					<td><c:url value='/bos/archive/deptListForUpdate.do?taskSeq=${param.taskSeq}&projectTaskSeq=${result.archiveProjectSeq}&menuNo=${param.menuNo}&deptAt=Y&pageIndex=${param.pageIndex}' var="read_url" />
						<a class="btn btn-primary btn-sm" href="${read_url}">관리</a>
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="8">데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<div class="btn_set">
	<a class="btn btn-primary" href="/bos/archive/list.do?menuNo=${param.menuNo}"><span>목록</span></a>
</div>

<div class="btn_set">					
	<a class="btn btn-primary" href="/bos/archive/deptListForInsert.do?taskSeq=${param.taskSeq}&projectTaskSeq=${result.archiveProjectSeq}&menuNo=${param.menuNo}"><span>프로젝트 등록</span></a>
</div>



<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div>
</c:if>

