<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">

	function del(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/progrm/instrctr/delete.do";
			form.submit();
		}
	}

</script>

<form name="f_regi" method="post" action="#" enctype="multipart/form-data">
	<input type="hidden" name="tchSn" value="${result.tchSn}">
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'>

	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col span="2">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">분야</th>
					<td>${result.realmNm}</td>
				</tr>
				<tr>
					<th scope="row">이름</th>
					<td>${result.tchNm}</td>
				</tr>
				<tr>
					<th scope="row">현소속</th>
					<td>${result.psitn}</td>
				</tr>
				<tr>
					<th scope="row">주요경력</th>
					<td>${result.career}</td>
				</tr>
				<tr>
					<th scope="row">연락처</th>
					<td>${result.tel}</td>
				</tr>
				<tr>
					<th scope="row">비고</th>
					<td>${result.rm}</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

<div class="row clear mt20">
	<div class="col-md-11 tac"><a href="/bos/progrm/instrctr/forUpdate.do?tchSn=${result.tchSn}&${pageQueryString}" class="btn btn-primary">수정</a>
		<a href="javascript:del();" class="btn btn-danger">삭제</a>
	</div>
	<div class="col-md-1"><a href="/bos/progrm/instrctr/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
</div>
