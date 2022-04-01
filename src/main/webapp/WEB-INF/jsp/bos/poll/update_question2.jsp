<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />



<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>

<script type="text/javascript">
function checkAndSubmit() {
	var condition = true;
	$(":input[name^=question2]").each(function(){
		if(!$(this).val()){
			alert("필수사항입니다.");
			this.focus();
			condition = false;
			return;
		}
	});
	if (!condition) {
		return false;
	} else {
		if (confirm('등록하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
	return true;
}

var idx = ${fn:length(resultList)};
function jaddRow()
{
	idx++;
	$("#tbl tr:last").after(
		"<tr id=\"tr"+idx+"\">" +
			"<td class=\"output\">"+idx+"<input type=\"hidden\" name=\"orderby\" value=\""+idx+"\" /></td>" +
			"<td class=\"output tal\" style=\"padding-left: 20px;\">" +
				"<input type=\"text\" name=\"question2\" value=\"\" style=\"width: 98%;\" class=\"board1\" />" +
			"</td>" +
			"<td class=\"output\">" +
				"<input type=\"button\" value=\"삭제\" onclick=\"jdelRow("+idx+");\" />" +
			"</td>" +
		"</tr>"
	);
}

function jdelRow(index)
{
	$("#tr"+index).remove();
}

</script>

</head>
<body>

<div id="content">
	<div class="hgroup">
		<h3 >설문조사</h3>
	</div>

		<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">제목</th>
					<td class="output">
						${checkformInfo.title}
					</td>
				</tr>


				<tr>
					<th scope="row">응모기간</th>
					<td class="output">
						<fmt:formatDate value="${checkformInfo.startDt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${checkformInfo.endDt}" pattern="yyyy년 MM월 dd일"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="contents">내용</label></th>
					<td class="outputEditor" colspan="3">
						${checkformInfo.contents}
					</td>
				</tr>
			</tbody>
		</table>
		</div>

<br/>
<br/>

		<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">문제</th>
					<td class="output">
						${resultQuestion1.question}
					</td>
				</tr>

				<tr>
					<th scope="row">출제유형</th>
					<td class="output">
						<c:if test="${resultQuestion1.questTypeCd == 'A'}">객관식</c:if>
						<c:if test="${resultQuestion1.questTypeCd == 'B'}">주관식</c:if>
					</td>
				</tr>

				<tr>
					<th scope="row">기타문항사용</th>
					<td class="output">
						<div id="other_yn">
							<c:if test="${resultQuestion1.otherYn == 'Y'}">사용함</c:if>
							<c:if test="${resultQuestion1.otherYn == 'N'}">사용안함 (객관식일 경우만 적용됨)</c:if>
						</div>
					</td>
				</tr>

				<tr>
					<th scope="row">답변형식</th>
					<td class="output">
						<div id="multi_check_yn">
							<c:if test="${resultQuestion1.multiCheckYn == 'N'}">단일선택</c:if>
							<c:if test="${resultQuestion1.multiCheckYn == 'Y'}">다중선택 (객관식일 경우만 적용됨)</c:if>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		</div>

	<form name="fm" action="/bos/poll/updateQuestion2.do" method="post" onsubmit="return checkAndSubmit(this);">
		<input type="hidden" name="masterCd" value="${param.masterCd}">
		<input type="hidden" name="question1Cd" value="${param.question1Cd}">
		<input type="hidden" name="questionCd" value="${param.question1Cd}">
		<input type="hidden" name="exposureType" value="${resultQuestion1.exposureType}">
		<input type="hidden" id="viewState" name="viewState" value="${param.viewState}">

	<div class="btn_set">
		<a class="btn btn-inverse" href="javascript:jaddRow();" /><span>추가</span></a>
	</div>

<div>
	<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="20%" />
				<col width="*" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">답변 항목</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="item" varStatus="status">
					<tr id="tr${status.count}">
						<td class="output">${status.count}<input type="hidden" name="orderby" value="${status.count}" /></td>
						<td class="output tal" style="padding-left: 20px;">
							<input type="text" name="question2" value="${item.question2}" style="width: 98%;" class="board1" />
						</td>
						<td class="output">
							<input type="button" value="삭제" onclick="jdelRow(${status.count});" />
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		<!-- board list end //-->

	<div class="btn_set">
		<input type="submit" value="저장"  class="btn btn-primary" />
			<c:url var="list_action" value="/bos/poll/list_question.do">
				<c:param name="masterCd" value="${param.masterCd}"/>
			</c:url>
		<a class="btn btn-primary" href="${list_action}"><span>목록</span></a>
	</div>

</form>
</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>
