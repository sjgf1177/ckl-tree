<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/${paramVO.programId}/update.do" />
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>


<script type="text/javascript">

	$(function() {

	});

	function checkForm() {

		var form = $("#board")[0];
		var v = new MiyaValidator(form);
	    v.add("wordSe", {
	        required: true
	    });
	    v.add("wordNm", {
	        required: true
	    });
	    v.add("wordEngNm", {
	        required: true
	    });
	    v.add("wordEngAbrv", {
	        required: true
	    });
	    v.add("wordDfn", {
	        required: true
	    });
	    v.add("themaArea", {
	        required: true
	    });

		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		form.submit();
	}

</script>

<title>행정용어사전 - 게시글쓰기</title>
</head>
<body>

<div id="content">
	<div class="hgroup">
		<h3>행정용어사전</h3>
	</div>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="seq" value="${empty result.seq ? 0 : result.seq }" />


<div class="bdView">
<table>
	<caption>게시판 쓰기</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="wordSe">구분</label></th>
			<td>
				<select id="wordSe" name="wordSe" title="구분선택">
				   <option value="">선택</option>
				   <option value="표준어" <c:if test="${result.wordSe eq '표준어'}">selected="selected"</c:if> >표준어</option>
				   <option value="동의어" <c:if test="${result.wordSe eq '동의어'}">selected="selected"</c:if> >동의어</option>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordNm">용어명</label></th>
			<td>
				<input type="text" name="wordNm" id="wordNm" style="width:95%" class="board1" value="${result.wordNm}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordEngNm">영문용어명</label></th>
			<td>
				<input type="text" name="wordEngNm" id="wordEngNm" style="width:95%" class="board1" value="${result.wordEngNm}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordEngAbrv">용문약어명</label></th>
			<td>
				<input type="text" name="wordEngAbrv" id="wordEngAbrv" style="width:95%;" class="board1" value="${result.wordEngAbrv}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordDfn">용어정의</label></th>
			<td>
				<textarea name="wordDfn" id="wordDfn" style="width:95%;height:120px;" class="board1">${result.wordDfn}</textarea>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="themaArea">주제영역</label></th>
			<td>
				<input type="text" name="themaArea" id="themaArea" style="width:95%" class="board1" value="${result.themaArea}" />
			</td>
		</tr>
	<c:if test="${not empty result}" >
		<tr>
			<th scope="row"><label for="frstRegisterPnttm">등록일</label></th>
			<td>
				${result.frstRegistPnttm}
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="subject">수정일</label></th>
			<td>
				${result.lastUpdtPnttm}
			</td>
		</tr>
	</c:if>
	</tbody>
</table>
</div>
</form>
	<div class="btn_set">
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary">등록</a>
	</c:when>
	<c:otherwise>
		<c:if test="${result.deleteCode ne '0' }" >
			<a href="/bos/${paramVO.programId}/restore.do?seq=${result.seq}&amp;deleteAt=N" class="btn btn-inverse" onclick="return confirm('정말로 복구하시겠습니까?');">복구</a>
		</c:if>
		<c:if test="${result.deleteCode eq '0' }" >
			<a href="javascript:checkForm();" class="btn btn-primary">수정</a>
			<a href="/bos/${paramVO.programId}/delete.do?seq=${result.seq}&amp;deleteAt=Y" class="btn btn-primary" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
		</c:if>
		<c:if test="${result.deleteCode ne '0' }" >
			<a href="/bos/${paramVO.programId}/delPermanently.do?seq=${result.seq}" class="btn btn-danger" onclick="return confirm('정말로 삭제하시겠습니까?');">완전삭제</a>
		</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/${paramVO.programId}/list.do?${pageQueryString}" />
		<a href="${url}" class="btn btn-primary">목록</a>
	</div>

</div>
	<div class="btn_set_flr clearfix">
</div>
</body>
</html>