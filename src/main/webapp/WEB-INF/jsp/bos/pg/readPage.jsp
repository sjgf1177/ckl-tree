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

	<div id="content">
		<div class="hgroup">
			<h3>필드리스트</h3>
		</div>

		<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="30%" />
				<col width="40%" />
				<col width="30%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">name</th>
					<th scope="col">text</th>
					<th scope="col">type</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="field" items="${pageVO.fields}" varStatus="status">
				<tr>
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
		<a class="btn btn-primary" href="/bos/pageGenerator/bbs/getFieldAttributes.do?menuNo=${param.menuNo}&pageType=${param.pageType}&bbsId=${param.bbsId}" target="_blank" title="새창열림"><span>필드속성팝업</span></a>
		<a class="btn btn-primary" href="/bos/bbs/addBoardArticle.do?${pageQueryString}"><span>페이지생성</span></a>
	</div>

