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


<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />

<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">

function setNum(obj) {
    var val=obj.value;
    var re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
};

function checkForm() {
	var f = document.fm;
	var v = new MiyaValidator(f);

    v.add("question", {
		required: true
    });
    v.add("questTypeCd", {
		required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (confirm('등록하시겠습니까?')) {
		f.submit();
	}
};


function funTypeSelect(gubun){
  if(gubun == "A"){
    other_yn.style.visibility = "visible";
    multi_check_yn.style.visibility = "visible";
  }else{
    other_yn.style.visibility = "hidden";;
    multi_check_yn.style.visibility = "hidden";
  }
};

</script>
<title>설문</title>
</head>
<body>

	<div id="content">
		<div class="hgroup">
			<h3>설문</h3>
		</div>

<form name="fm" method="post" action="/bos/poll/updateQuestion1.do">
	<input type="hidden" name="masterCd" value="${param.masterCd}"/>
	<input type="hidden" name="questionCd" value="${result.questionCd}"/>

	<div class="bdView">
		<table>
				<caption>설문</caption>
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
						<td class="output" colspan="2">
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
				<caption>자율점검 (점검표관리)</caption>
				<colgroup>
				<col width="15%"/>
				<col width="85%"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="question">문제</label></th>
						<td class="output">
							<textarea name="question" id="question" cols="50" rows="20" title="내용" style="width:100%;">${result.question}</textarea>
							(4000자 이내로 작성하십시요)
						</td>
					</tr>

					<tr>
						<th scope="row">출제유형</th>
						<td class="output">
							<label for="questTypeCd1"><input type="radio" id="questTypeCd1" name="questTypeCd" value="A" <c:if test="${result.questTypeCd == 'A'}">checked="checked" </c:if>onclick="javascript:funTypeSelect('A');">객관식</label>&nbsp;&nbsp;
							<label for="questTypeCd2"><input type="radio" id="questTypeCd2" name="questTypeCd" value="B" <c:if test="${result.questTypeCd == 'B'}">checked="checked" </c:if>onclick="javascript:funTypeSelect('B');">주관식</label>&nbsp;&nbsp;
						</td>
					</tr>

					<tr>
						<th scope="row">기타문항사용</th>
						<td class="output">
							<div id="other_yn" <c:if test="${result.QUEST_TYPE_CD == 'B'}">style="visibility: hidden;"</c:if>>
								<label for="otherYn1"><input type="radio" id="otherYn1" name="otherYn" value="Y" <c:if test="${result.otherYn == 'Y'}">checked="checked" </c:if>>사용함</label>&nbsp;&nbsp;
								<label for="otherYn2"><input type="radio" id="otherYn2" name="otherYn" value="N" <c:if test="${result.otherYn == 'N'}">checked="checked" </c:if>>사용안함</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
							</div>
						</td>
					</tr>

					<tr>
						<th scope="row"><label for="contents">답변형식</label></th>
						<td class="outputEditor">
							<div id="multi_check_yn" <c:if test="${result.questTypeCd == 'B'}">style="visibility: hidden;"</c:if>>
								<label for="multiCheckYn1"><input type="radio" id="multiCheckYn1" name="multiCheckYn" value="N" <c:if test="${result.multiCheckYn == 'N'}">checked="checked" </c:if>>단일선택</label>
								<label for="multiCheckYn2"><input type="radio" id="multiCheckYn2" name="multiCheckYn" value="Y" <c:if test="${result.multiCheckYn == 'Y'}">checked="checked" </c:if>>다중선택</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<c:url var="list_action" value="/bos/poll/list_question.do">
			<c:param name="masterCd" value="${param.masterCd}"/>
		</c:url>
		<a class="btn btn-primary" href="${list_action}"><span>목록</span></a>
	</div>

</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>