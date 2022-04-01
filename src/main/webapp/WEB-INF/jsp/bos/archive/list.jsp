<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.unp.archive.service.ArchiveBosService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util"%>
<ui:pagination paginationInfo="${paginationInfo}" type="adminImage" jsFunction="fn_egov_select"/>

<script type="text/javascript">
$(function() {
	
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	
	 $('#sdate').datepicker();
	    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
	    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#edate").datepicker( "option", "minDate", selectedDate );
	    });

	    $('#edate').datepicker();
	    $('#edate').datepicker("option", "minDate", $("#sdate").val());
	    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#sdate").datepicker( "option", "maxDate", selectedDate );
	    });
	
	
	$("#chkAll").click(function(){
		if(this.checked)
			$(":checkbox").attr("checked", true);
		else
			$(":checkbox").attr("checked", false);
	});
});


</script>

<form id="frm" name="frm" method="post" action="/bos/archive/list.do?menuNo=${param.menuNo}" class="form-inline">
 <input type="hidden" name="taskSeq" value="${param.taskSeq}"> 
 <input type="hidden" name="pageIndex"  id="pageIndex"  value="<c:out value='${param.pageIndex }' />" />
	<fieldset>
		<legend></legend>
		<div class="bdView mb0">
			<table class="table table-bordered">
				<caption></caption>
				<colgroup>
					<col span="3">
					<col>
				</colgroup>
				
				<tbody>
					<tr>
						<th><label for="year">연도</label></th>
					<td>
						<select id="year" name="year" title="연도" style="width:100px" class="required">
					    	<option value="" <c:if test="${result.year eq ''}">selected</c:if>>전체</option>
						    
						    <!-- 현재년도를 가져온다 -->
						    <c:set var="today" value="<%=new java.util.Date()%>" />
						    <!-- 형병환 : date to String -->
						    <fmt:formatDate value="${today}" pattern="yyyy" var="nowY"/> 
						    <!-- 시작년도  -->
					        <c:set var="sYear" value="${nowY - 3}" />
					        <!-- 반복문 개수 -->
					        <c:set var="endNum" value="${nowY + 3 - sYear}" />
						   <!-- 년도를 노출시킨다. -->
						    <c:forEach var="i" begin="0" end="${endNum}">
						    	<c:set var="yearOption" value="${sYear + i}" />
						    	<option value="${yearOption}" <c:if test="${param.year eq yearOption}">selected</c:if>>${yearOption}</option>
							</c:forEach>
							
						</select>
						</td>
						
						<th><label for="division">사업구분</label></th>
						<td>
						<select id="workField" name="workField" class="form-control input-sm">
								<option value="">전체</option>
								<option value='1' <c:if test="${param.workField == '1'}">selected="selected"</c:if>>창의인재동반</option>
								<option value='2' <c:if test="${param.workField == '2'}">selected="selected"</c:if>>실감콘텐츠창작</option>
								<option value='3' <c:if test="${param.workField == '3'}">selected="selected"</c:if>>콘텐츠원캠퍼스</option>
								<option value='4' <c:if test="${param.workField == '4'}">selected="selected"</c:if>>콘텐츠임팩트</option>
								<option value='5' <c:if test="${param.workField == '5'}">selected="selected"</c:if>>AI연계콘텐츠창작</option>
						</select>
						</td>
						
						<th><label for="prgNm">주관기관명</label></th>
						<td colspan="1"><input type="text" name="organNm"
							id="organNm" value="${param.organNm}"></td>
					</tr>
					<tr>
						<th><label for="taskNm">과제명</label></th>
						<td colspan="1"><input type="text" name="taskNm" id="taskNm"
							value="${param.taskNm}"></td>

						<th><label for="useAt">사용여부</label></th>
						<td><select name="useAt" id="useAt" title="사용여부를 선택해 주세요.">
								<option value="">전체</option>
								<option value='Y' <c:if test="${param.useAt == 'Y'}">selected="selected"</c:if>>사용</option>
								<option value='N' <c:if test="${param.useAt == 'N'}">selected="selected"</c:if>>미사용</option>
						</select></td>
						<th>등록일</th>
						<td colspan="1"><input type="text" id="sdate" name="sdate" 
							value="${param.sdate}" style="width: 110px" title="신청기간 시작일 입력" />
							~ <input type="text" id="edate" name="edate" 
							value="${param.edate}" style="width: 110px" title="신청기간 종료일 입력" />
						</td>
					</tr>
				
				</tbody>
			</table>
		</div>
		
		<div class="btnSet">
			<input type="submit" class="btn btn-primary btnSet" value="검색" />
		</div>
	
	</fieldset>
</form>

<div class="row mt10 mb5">
	<div class="col-md-12">
		총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건
		| <strong class="text-danger"><c:out
				value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong>
		Page
	</div>
</div>

<div class="bdList">
	<table class="table table-bordered">
		<caption></caption>
		<colgroup>
			<!-- 번호  -->
			<col style="width: 35px;">
			<!-- 연도  -->
			<col style="width: 40px;">
			<!-- 사업구분 -->
			<col style="width: 110px;">
			<!-- 기관명 -->
			<col style="width: 200px;">
			<!-- 과제명 -->
			<col style="width: 170px;">
			<!-- 프로젝트 -->
			<col style="width: 70px;">
			<!-- 사용여부 -->
			<col style="width: 70px;">
			<!-- 등록자 -->
			<col style="width: 60px;">
			<!-- 등록일 -->
			<col style="width: 95px;">
			<!-- 과제관리 -->
			<col style="width: 60px;">
			<!-- 프로젝트 관리 -->
			<col style="width: 60px;">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>연도</th>
				<th>사업구분</th>
				<th>기관명</th>
				<th>과제명</th>
				<th>프로젝트</th>
				<th>사용여부</th>
				<th>등록자</th>
				<th>등록일</th>
				<th>과제관리</th>
				<th>프로젝트관리</th>
			</tr>
		</thead>
		<tbody  style="text-align:center;">
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					
					<td>${result.year}</td>
						<c:choose>
							<c:when test="${result.workField eq 2}">
							<td>실감콘텐츠장착</td>
							</c:when>
							<c:when test="${result.workField eq 3}">
							<td>콘텐츠원캠퍼스</td>
							</c:when>
							<c:when test="${result.workField eq 4}">
							<td>콘텐츠임팩트 </td>
							</c:when>
							<c:when test="${result.workField eq 5}">
							<td>AI연계콘텐츠창작</td>
							</c:when>							
							<c:otherwise>
							<td>창의인재동반</td>
							</c:otherwise>
						</c:choose>
					
					<td style="text-align:left;">${result.organNm}</td>
					<td style="text-align:left;">${result.taskNm}</td>
					<td>${result.projectCnt}</td>
					<td>${result.useAt eq 'N' ? '미사용' : '사용'}</td>
					<td>${result.userNm}</td>
				    <td><fmt:formatDate value="${result.frstRegistPnttm}" pattern="yyyy-MM-dd"/></td> 
					
					<td><c:url value='/bos/archive/forUpdate.do?taskSeq=${result.archiveTaskSeq}&menuNo=${param.menuNo}&projectCnt=${result.projectCnt }&pageIndex=${param.pageIndex}' var="read_url" />
						<a class="btn btn-primary btn-sm" href="${read_url}">관리</a></td>
					
					<td><a class="btn btn-primary btn-sm" href="/bos/archive/deptList.do?taskSeq=${result.archiveTaskSeq}&menuNo=${param.menuNo}"><span>관리</span></a></td>
				
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="11">데이터가 없습니다.</td>
				</tr>
			</c:if>
		
		</tbody>
	</table>
</div>

<div class="btn_set">
	<a class="btn btn-primary" href="/bos/archive/forInsert.do?menuNo=${param.menuNo}"><span>과제 등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div>
</c:if>

