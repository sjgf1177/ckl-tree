<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/bos/cmmncode/CmmnCodeClList.do?menuNo=${param.menuNo}'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리
 ******************************************************** */
function fnSearch(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수
 ******************************************************** */
function fnRegist(){
	location.href = "/bos/cmmncode/CmmnCodeClRegist.do?menuNo=${param.menuNo}";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fnModify(){
	location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fnDetail(clCode){
	var varForm				 = document.all["Form"];
	varForm.action           = "/bos/cmmncode/CmmnCodeClDetail/" + clCode + ".do?menuNo=${param.menuNo}";
	varForm.clCode.value     = clCode;
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	//
}
//-->
</script>
		<form name="Form" action="" method="post">
			<input type=hidden name="clCode">
		</form>
		<form name="listForm" action="/bos/cmmncode/CmmnCodeClList.do?menuNo=${param.menuNo}" method="post">
			<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
			<div class="sh">
				<fieldset>
					<legend>게시판 게시물검색</legend>
					<label for="searchCondition" class="blind">구분</label>
			   		<select name="searchCondition" class="select" id="searchCondition">
					   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>분류코드</option>
					   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>분류코드명</option>
				    </select>
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchKeyword" value="${searchVO.searchKeyword}" />
					<a href="javascript:fnSearch();" class="btn btn-seach">검색</a>
				</fieldset>
			</div>
		</form>
	<!-- 게시판 게시물검색 end -->

	<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>공통분류코드 목록</caption>
			<colgroup>
				<col style="width:10%" />
				<col style="width:20%" />
				<col style="width:50%" />
				<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">분류코드</th>
					<th scope="col">분류코드명</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
			    	<td>${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}</td>
					<td><a href="javascript:fnDetail('${resultInfo.clCode}');">${resultInfo.clCode}</a></td>
					<td><a href="javascript:fnDetail('${resultInfo.clCode}');">${resultInfo.clCodeNm}</a></td>
					<td><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}"><font color='red'>미사용</font></c:if></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="4">
						<spring:message code="common.nodata.msg" />
					</td>
				</tr>
			</c:if>
			</tbody>
		</table>
	</div>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fnRegist();"><span>등록</span></a>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
	</c:if>
