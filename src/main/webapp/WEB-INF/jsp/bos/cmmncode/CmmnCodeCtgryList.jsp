<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/bos/cmmncode/CmmnCodeCtgryList.do'/>";
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
	location.href = "/bos/cmmncode/CmmnCodeCtgryRegist.do?menuNo=${param.menuNo}";
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
function fnDetail(codeId){
	var varForm				 = document.all["Form"];
	varForm.action           = "/bos/cmmncode/CmmnCodeCtgryDetail/" + codeId + ".do?menuNo=${param.menuNo}";
	varForm.codeId.value     = codeId;
	varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
	//
}

function fnCdDtlPop(cdCatId) {

	var url = "/bos/cmmncode/CmmnCodeDetailPop.do";
	var params = "?codeId=" + cdCatId;
	window.open(url+params , "cdDtlPop", "width=800, height=750, scrollbars=yes");

}
//-->


function fnCdDtlPop(codeId) {

	var url = "/bos/cmmncode/CmmnCodeDetailPop.do";
	var params = "?codeId=" + codeId;
	window.open(url+params , "cdDtpPop", "width=800, height=750, scrollbars=yes");

}
</script>
</head>
	<form name="Form" action="" method="post">
		<input type=hidden name="codeId">
	</form>
	<form name="listForm" action="<c:url value='/bos/cmmncode/CmmnCodeCtgryList.do'/>" method="post">
		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input name="menuNo" type="hidden" value="<c:out value='${param.menuNo}'/>"/>
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>

				<label for="clCode" class="blind">구분</label>
				<select name="clCode" class="select">
				<option value="">-- 분류 --</option>
				<c:forEach var="result" items="${cmmnClCode}" varStatus="status">
					<option value="${result.clCode}" <c:if test="${result.clCode eq param.clCode }">selected="selected"</c:if>><c:out value="${result.clCodeNm}" /></option>
				</c:forEach>
				</select>
		   		<select name="searchCondition" class="select">
				   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>코드ID</option>
				   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>코드ID명</option>
			    </select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchKeyword" value="${searchVO.searchKeyword}" />
				</label>
				<label for="input2">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-default" />
				</label>
			</fieldset>
		</div>
	</form>
<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="15%" />
				<col width="*" />
				<col width="15%" />
				<col width="25%" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">분류명</th>
					<th scope="col">코드ID</th>
					<th scope="col">코드카테고리명</th>
					<th scope="col">사용여부</th>
					<th scope="col" class="last">코드관리</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
			<tr>
				<td>${(resultCnt) - (searchVO.pageSize * (searchVO.pageIndex-1))}</td>
				<td><a href="javascript:fnDetail('${resultInfo.codeId}');">${resultInfo.clCodeNm}</a></td>
				<td><a href="javascript:fnDetail('${resultInfo.codeId}');">${resultInfo.codeId}</a></td>
				<td>${resultInfo.codeIdNm}</td>
				<td><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}"><font color='red'>미사용</font></c:if></td>
				<td><a href="#" onclick="fnCdDtlPop('${resultInfo.codeId}');return false;" target="_blank" title="새창열림" class="btn btn-xs">관리</a></td>
			</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>

			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td class="lt_text3" colspan="6">
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
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
