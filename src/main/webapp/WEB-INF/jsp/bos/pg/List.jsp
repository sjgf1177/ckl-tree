<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript">
$(function(){
	$("#pageUnit").change(function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});
});
</script>

<form id="frm" name="frm" action ="/bos/bbs/selectBoardList.do?menuNo=${param.menuNo}" method="post">
<input type="hidden" name="bbsId" value="${boardVO.bbsId}" />
<input type="hidden" name="type" value="${param.type}" />

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="40%" />
				<col width="30%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">게시판속성명</th>
					<th scope="col">게시판속성코드</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="field" items="${pageVO.fields}" varStatus="status">
				<tr>
					<td class="output">${fn:length(resultList) - status.count}</td>
					<td class="output">${field.name}</td>
					<td class="output">${field.text}</td>
					<td class="output">${field.type}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="3">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/pageGenerator/bbs/getFieldAttributes.do?pageType=${param.pageType}?menuNo=${param.menuNo}" target="_blank" title="새창열림"><span>필드속성팝업</span></a>
		<a class="btn btn-primary" href="/bos/bbs/addBoardArticle.do?${pageQueryString}"><span>페이지생성</span></a>
	</div>

</form>
