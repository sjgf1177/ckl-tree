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
	document.listForm.action = "<c:url value='/bos/cmmncode/CmmnCodeDetailList.do?menuNo=${param.menuNo}'/>";
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
	location.href = "/bos/cmmncode/CmmnCodeDetailRegist.do?menuNo=${param.menuNo}";
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
function fnDetail(codeId, code){
	var varForm				 = document.all["Form"];
	varForm.action           = "/bos/cmmncode/CmmnCodeDetailDetail/" + codeId + "/" + code + ".do?menuNo=${param.menuNo}";
	varForm.codeId.value     = codeId;
	varForm.code.value       = code;
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

		<!-- 게시판 게시물검색 start -->
	<form name="Form" action="" method="post">
		<input type=hidden name="codeId">
		<input type=hidden name="code">
	</form>
	<form name="listForm" action="<c:url value='/bos/cmmncode/CmmnCodeDetailList.do?menuNo=${param.menuNo}'/>" method="post">
		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<label for="searchCondition" class="blind">구분</label>
		   		<select name="searchCondition" class="select">
				   <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>코드ID</option>
				   <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>코드</option>
				   <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>코드명</option>
				   <option value='4' <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>>분류명</option>
			    </select>
				<label for="input1">
					<input id="input1" type="text" title="검색어입력" style="width:130px" name="searchKeyword" value="${searchVO.searchKeyword}" />
				</label>
				<label for="input2">
					<a href="javascript:fnSearch();" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>
	</form>
<!-- 게시판 게시물검색 end -->

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="20%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">분류명</th>
					<th scope="col">코드ID</th>
					<th scope="col">코드</th>
					<th scope="col">코드명</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				<tr>
					<td class="output">${result.nttType=='1' ? '공지' : (resultCnt) - (boardVO.pageSize * (boardVO.pageIndex-1))}</td>
			    	<td class="output">
						${resultInfo.codeIdNm}
			    	</td>
			    	<td class="output">
						<a href="javascript:fnDetail('${resultInfo.codeId}','${resultInfo.code}');">
							${resultInfo.codeId}
						</a>
			    	</td>
					<td class="output">
						<a href="javascript:fnDetail('${resultInfo.codeId}','${resultInfo.code}');">
							${resultInfo.code}
						</a>
					</td>
			    	<td class="output">
						<a href="javascript:fnDetail('${resultInfo.codeId}','${resultInfo.code}');">${resultInfo.codeNm}</a>
					</td>
					<td class="output"><c:if test="${resultInfo.useAt == 'Y'}">사용</c:if><c:if test="${resultInfo.useAt == 'N'}"><font color='red'>미사용</font></c:if></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
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

