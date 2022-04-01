<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){
	$(":input[id^=update_]").click(function(){
		var pageCode = this.id.replace("update_", "");
		location.href = "/bos/pg/readPage.do?menuNo=${param.menuNo}&pageCode=" + pageCode;
	});
	$(":input[id^=delete_]").click(function(){
		if( confirm("정말로 삭제하시겠습니까?") ){
			var pageCode = this.id.replace("delete_", "");
			location.href = "/bos/pg/deletePageAttr.do?menuNo=${param.menuNo}&pageCode=" + pageCode;
		}
	});
});
</script>

<form id="frm" name="frm" action ="/bos/pg/pageAttrList.do?menuNo=${param.menuNo}" method="post">
	<input type="hidden" name="bbsId" value="${param.bbsId}" />
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
					<th scope="col">게시판속성코드</th>
					<th scope="col">게시판속성명</th>
					<th scope="col">관리</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td class="output">${status.count}</td>
					<td class="output"><a href="/bos/pg/readPage.do?pageCode=${result.pageCode}&bbsId=${param.bbsId}&menuNo=${param.menuNo}">${result.pageCode}</a></td>
					<td class="output"><a href="/bos/pg/readPage.do?pageCode=${result.pageCode}&bbsId=${param.bbsId}&menuNo=${param.menuNo}">${result.pageName}</a></td>
					<td class="output">
						<input type="button" class="mr20 btn btn-xs"  id="update_${result.pageCode}" name="update" value="수정" />
						<input type="button" class="btn btn-xs btn-danger" id="delete_${result.pageCode}" name="delete" value="삭제" />
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btn_set">
		<a class="btn btn-primary" href="/bos/pg/regPage.do?menuNo=${param.menuNo}"><span>등록</span></a>
	</div>

</form>
