<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="now"/>
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
<title>설문</title>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
function checkAndSubmit() {

	var f = document.fm;
	var v = new MiyaValidator(f);

    v.add("title", {
		required: true
    });
    v.add("startDt", {
		required: true
    });
    v.add("endDt", {
		required: true
    });
    v.add("contents", {
		required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	f.submit();
}

function viewEssayList(questionCd) {
	var openParam = "dialogWidth:830px;dialogHeight:600px;scroll:yes;status:no;center:yes;resizable:yes;";
	var varParam = new Object();
	var url = '/portal/poll/selectEssayList.do?masterCd=${checkformInfo.masterCd}&questionCd='+questionCd;
	window.showModalDialog(url, varParam, openParam);
};


function viewOtherList(questionCd) {
	var openParam = "dialogWidth:830px;dialogHeight:600px;scroll:yes;status:no;center:yes;resizable:yes;";
	var varParam = new Object();
	var url = '/portal/poll/selectOtherList.do?masterCd=${checkformInfo.masterCd}&questionCd='+questionCd;
	window.showModalDialog(url, varParam, openParam);
};


</script>
</head>
<body>

	<div id="content">
		<div class="hgroup">
			<h3>설문</h3>
		</div>

	<div class="bdView">
		<table>
			<caption>설문</caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
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
						<fmt:formatDate value="${checkformInfo.startDt}" pattern="yyyy-MM-dd"/> ~
						<fmt:formatDate value="${checkformInfo.endDt}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td class="output" colspan="2">
						${checkformInfo.contents}
					</td>
				</tr>



				<tr>
					<th scope="row">첨부파일</th>
					<td class="output">
							<c:if test="${empty result.attachfileorg1}"><font style="color: lightgray;">첨부된 파일이 없습니다</font></c:if>
							<c:if test="${not empty result.attachfileorg1}">
								<c:url value="/portal/poll/download.do" var="download_action">
									<c:param name="masterCd" value="${result.masterCd}" />
								</c:url>
								<a href="${download_action}"><strong style="color: gray;">${result.attachfileorg1}</strong></a>
							</c:if>
					</td>
				</tr>

			</tbody>
		</table>
	</div>

	<fmt:formatDate value="${checkformInfo.startDt}" pattern="yyyy-MM-dd" var="modifyCheck"/>
	<div class="btn_set">
		<c:if test="${modifyCheck > now}">
			<a class="btn btn-primary" href="/bos/poll/forInsertQuestion1.do?masterCd=${checkformInfo.masterCd}"><span>문제등록</span></a>
		</c:if>
		<c:url var="url" value="/bos/poll/list.do" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>


<h4><font color="red">문제/문항 입/수정/삭제는 응모기간 이전에만 가능합니다.</font></h4>
<br/>
<br/>


<c:if test="${fn:length(resultList) > 0}">
	<c:forEach items="${resultList}" var="questionItem" varStatus="status">
		<h5>&nbsp;&nbsp;${status.count}.&nbsp;${questionItem.question}</h5>

	<div>
		<table class="table table-bordered table-striped table-hover">
				<caption>투표할 수 있는 항목</caption>
				<colgroup>
					<col width="30%" />
					<col width="25%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">답변</th>
						<th scope="col">비율</th>
						<th scope="col">비율그래프</th>
					</tr>
				</thead>
				<tbody>
			<c:choose>
				<c:when test="${questionItem.questTypeCd == 'B'}">
					<tr><td colspan="3"><a href="javascript:viewEssayList('${questionItem.questionCd}');">상세보기</a></td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${questionItem.answer}" var="answerItem" varStatus="status">
					<tr>
						<td class="tal">
							${status.count}. ${answerItem.question2}
						</td>
						<td class="tal">${answerItem.tc}/${answerItem.tot} (${answerItem.percent2}%)</td>
						<td class="tal">
							 <img src="/images/grp1.gif" style="width:${answerItem.percent2}%; height:8px" alt="" />
				<c:if test="${answerItem.question2Cd == 0}">
				<a href="javascript:viewOtherList('${questionItem.questionCd}');">상세보기</a>
				</c:if>
						</td>
					</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
				</tbody>
			</table>
		</div>

		<div class="btn_set">
			<c:if test="${modifyCheck > now}">
				<c:url value="/bos/poll/forUpdateQuestion1.do" var="question_modify_url">
					<c:param name="questionCd" value="${questionItem.questionCd}" />
					<c:param name="masterCd" value="${param.masterCd}" />
				</c:url>
				<a class="btn btn-primary" href="${question_modify_url}"><span>문제수정</span></a>

				<c:url value="/bos/poll/selectQuestion2ForUpdate.do" var="question2_modify_url">
					<c:param name="questionCd" value="${questionItem.questionCd}" />
					<c:param name="question1Cd" value="${questionItem.questionCd}" />
					<c:param name="masterCd" value="${param.masterCd}" />
					<c:param name="viewState" value="select"/>
				</c:url>
				<a class="btn btn-primary" href="${question2_modify_url}"><span>문항입/수정</span></a>
			</c:if>
			<c:url value="/bos/poll/deleteQuestion1.do" var="question_delete_url">
				<c:param name="questionCd" value="${questionItem.questionCd}" />
				<c:param name="masterCd" value="${param.masterCd}" />
			</c:url>
			<a class="btn btn-danger" href="${question_delete_url}"><span>삭제</span></a>
		</div>

	</c:forEach>
</c:if>
<c:if test="${fn:length(resultList) == 0}">
	등록된 문제 리스트가 없습니다.
</c:if>

</div>
<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>