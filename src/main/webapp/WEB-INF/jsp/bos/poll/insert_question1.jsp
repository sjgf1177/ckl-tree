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

<form name="fm" method="post" action="/bos/eventDesc/insertQuestion1.do">
	<input type="hidden" name="masterCd" value="${paramVO.masterCd}"/>
	<input type="hidden" name="title" value="${paramVO.title}"/>

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
						<textarea name="question" id="question" cols="50" rows="20" title="내용" style="width:90%;"></textarea>
						<br/>(4000자 이내로 작성하십시요)
					</td>
				</tr>

				<tr>
					<th scope="row">출제유형</th>
					<td class="output">
						<label for="quest_type_cd_A"><input type="radio" id="quest_type_cd_A" name="questTypeCd" value="A" onclick="javascript:funTypeSelect('A');">객관식</label>&nbsp;&nbsp;
						<label for="quest_type_cd_B"><input type="radio" id="quest_type_cd_B" name="questTypeCd" value="B" onclick="javascript:funTypeSelect('B');">주관식</label>&nbsp;&nbsp;
					</td>
				</tr>

				<tr>
					<th scope="row">기타문항사용</th>
					<td class="output">
						<div id="other_yn" style="visibility:hidden">
							<label for="other_yn_Y"><input type="radio" id="other_yn_Y" name="otherYn" value="Y">사용함</label>&nbsp;&nbsp;
							<label for="other_yn_N"><input type="radio" id="other_yn_N" name="otherYn" value="N">사용안함</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
						</div>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="contents">답변형식</label></th>
					<td class="outputEditor">
						<div id="multi_check_yn"  style="visibility:hidden">
							<label for="multi_check_yn_Y"><input type="radio" id="multi_check_yn_Y" name="multiCheckYn" value="N">단일선택</label>
							<label for="multi_check_yn_N"><input type="radio" id="multi_check_yn_N" name="multiCheckYn" value="Y">다중선택</label>&nbsp;&nbsp;(객관식일 경우만 적용됨)
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:checkForm();"><span>등록</span></a>
		<c:url var="list_action" value="/bos/eventDesc/view.do">
			<c:param name="masterCd" value="${paramVO.masterCd}"/>
		</c:url>
		<a class="btn btn-primary" href="${list_action}"><span>목록</span></a>
	</div>


</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>