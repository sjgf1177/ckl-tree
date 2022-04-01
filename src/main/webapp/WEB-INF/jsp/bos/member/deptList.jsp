<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<meta name="robots" content="all" />
<meta name="keywords" content="<spring:message code='site.korName' text=''/>" />
<meta name="description" content="<spring:message code='site.korName' text=''/>" />
<meta name="author" content="<spring:message code='site.korName' text=''/>" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript">
	$(function() {
		$("#chkAll").click(function(){
			if(this.checked)
				$(":checkbox").attr("checked", true);
			else
				$(":checkbox").attr("checked", false);
		});
	});

	function search(){
		if( !$("#searchWrd").val() ){
			alert("검색어을 입력하세요.");
			$("#searchWrd")[0].focus();
			return;
		}
		var f = document.frm2;
		f.action = "/bos/memberDept/list.do";
		f.submit();
	}
	function del(){
		if($(":checkbox:checked").length == 0)
		{
			alert("삭제할 부서를 선택하세요.");
			return;
		}
		if( !confirm("정말로 삭제하시겠습니까?") ){
			return;
		}
		var inData = $("#frm2").serialize();
		$.post(
			"/bos/memberDept/delete.json",
			inData,
			function(data){
				var resultCode = data.resultCode;
				var resultMsg = data.msg;
				alert(resultMsg);
				if(resultCode == "success") location.reload();
			}
		);
	}

	function modify(deptId){
		if( !$("#deptNmKor_" + deptId).val() ){
			alert("부서명을 입력하세요.");
			$("#deptNmKor_" + deptId)[0].focus();
			return;
		}
		if( !$("#deptNmEng_" + deptId).val() ){
			alert("영문부서명을 입력하세요.");
			$("#deptNmEng_" + deptId)[0].focus();
			return;
		}
		$("#deptId").val(deptId);
		$("#deptNmKor").val($("#deptNmKor_" + deptId).val());
		$("#deptNmEng").val($("#deptNmEng_" + deptId).val());
		var f = document.frm2;
		f.action = "/bos/memberDept/update.do";
		f.submit();
	}

	function reg(){
		if( !$("#deptNmKor0").val() ){
			alert("부서명을 입력하세요.");
			$("#deptNmKor0")[0].focus();
			return;
		}
		if( !$("#deptNmEng0").val() ){
			alert("영문부서명을 입력하세요.");
			$("#deptNmEng0")[0].focus();
			return;
		}
		$("#deptNmKor").val($("#deptNmKor0").val());
		$("#deptNmEng").val($("#deptNmEng0").val());
		var f = document.frm2;
		f.action = "/bos/memberDept/insert.do";
		f.submit();
	}
</script>

<title>부서관리</title>
</head>
<body>
	<div id="content">
		<div class="hgroup">
			<h3>부서관리</h3>
		</div>

<form id="frm2" name="frm2" method="post" action="/bos/memberDept/list.do" onsubmit="return search();">
	<input type="hidden" id="deptId" name="deptId" />
	<input type="hidden" id="deptNmKor" name="deptNmKor" />
	<input type="hidden" id="deptNmEng" name="deptNmEng" />
	<input type="hidden" name="searchCnd" value="1" />
		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
				<%-- <label for="stributary" class="blind">검색조건</label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >부서명</option>
				</select> --%>
				<input id="searchWrd" type="text" title="검색어입력" style="width:130px" name="searchWrd" value="${paramVO.searchWrd}" />
				<input id="input2" type="submit" class="btn btn-default" value="검색" />
			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->


<!-- board list start -->
	<div>
		<table class="table table-bordered table-striped">
			<caption>직원관리 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="10%" />
				<col width="40%" />
				<col width="40%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" /></th>
					<th scope="col" class="fir">번호</th>
					<th scope="col">부서명</th>
					<th scope="col">영문부서명</th>
					<th scope="col">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="deptIdData" value="${result.deptId}" /></td>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td><input type="text" name="deptNmKor_${result.deptId}" id="deptNmKor_${result.deptId}" class="board1 wr" value="${result.deptNmKor}" style="width:300px" /></td>
					<td><input type="text" name="deptNmEng_${result.deptId}" id="deptNmEng_${result.deptId}" class="board1 wr" value="${result.deptNmEng}" style="width:300px" /></td>
					<td><input type="button" class="btn btn-xs" name="btn" id="btn_${result.deptId}" value="수정" onclick="modify('${result.deptId}');"/></td>
				</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="5">데이터가없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>

	<div class="row">
		<div class="col-md-6"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div>
		<%-- <div class="col-md-6 tar">
			<a class="btn btn-primary" href="#"><span>부서등록</span></a>
			<a class="btn btn-primary" href="/bos/member/forInsert.do?${pageQueryString}"><span>등록</span></a>
		</div> --%>
	</div>

	<div class="bdView mt20">
		<table>
			<caption>회원가입필수정보 입력</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="deptNmKor0">부서명</label></th>
					<td>
						<input type="text" name="deptNmKor0" id="deptNmKor0" class="board1 wr" value="" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="deptNmEng0">영문부서명</label></th>
					<td>
						<input type="text" name="deptNmEng0" id="deptNmEng0" class="board1 wr" value="" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:reg();"><span>등록</span></a>
	</div>

</div>

</form>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>