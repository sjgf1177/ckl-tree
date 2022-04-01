<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<title><spring:message code='site.korName' text=''/></title>
<link href="/admin/common/css/pollCss/default.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/common.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/blue.css" rel="stylesheet" type="text/css" />
<link href="/admin/common/css/pollCss/board_blue.css" rel="stylesheet" type="text/css" />

<script>

function checkUpdate()
{
	document.fm.submit();
}
</script>

</head>
<body style="background:none;padding:10px;">
<h2 style="padding:15px 0 15px 0;">	
		설문정보
</h2>
<p class="title_deco"></p>
<div class="body">

	<table class="bdView" summary="제목, 주관부서, 등록일, 조회수, 첨부파일, 내용으로 구성되어 있습니다.">
		<caption>민원서식 상세내용</caption>
		<colgroup>
			<col style="width:20%;"/>
			<col style="width:80%;"/>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">제목</th>
				<td class="output tal">${result.title}</td>
			</tr>
			<tr>
				<th scope="row">설문기간</th>
				<td class="output tal">
					<fmt:formatDate value="${result.startDt}" pattern="yyyy년MM월dd일"/> ~ 
					<fmt:formatDate value="${result.endDt}" pattern="yyyy년MM월dd일"/></td>
			</tr>
			<tr >
				<th scope="row">설문내용</th>
				<td class="output tal">
					${result.contents}
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td class="output tal">
					<c:url value="/portal/poll/download.do" var="download_url">
						<c:param name="file" value="${result.attachfile1}"></c:param>
					</c:url>
					<a href="${download_url}"><strong>${result.attachfile1}</strong></a>
				</td>
			</tr>
		</tbody>
	</table>
	
<br/>
<br/>
	<form name="fm" action="/admin/portal/poll/checkUpdate.do" method="post">
		<input type="hidden" name="answerCd" value="${answer.answerCd == null ? 0 : answer.answerCd}" />
		<input type="hidden" name="masterCd" value="${result.masterCd}" />
		<input type="hidden" name="questionListSize" value="${fn:length(questionList)}"/>
				
		<!-- write form start -->
		<table id="check_form" class="bdView">
			<caption>응모 할 수 있는 항목</caption>
			<colgroup>
				<col style="width:7%;"/>
				<col style="width:93%;"/>
			</colgroup>
			<tbody>
				<tr >
					<th scope="row">사용자번호</th>
					<td class="output tal">
						<font color="red">${param.company_id}<input type="hidden" name="company_id" value="${param.company_id}"></font>
					</td>
				</tr>
				<c:if test="${fn:length(questionList) > 0}">
					<c:forEach items="${questionList}" var="questionItem" varStatus="qStatus">		
						<tr>
							<th>${qStatus.count}</th>
							<td class="tal">
								<dl>
									<dt style="margin-top: 6px;">${questionItem.QUESTION}</dt>
									<dd style="margin-top: 6px; margin-bottom: 6px;">
										<!-- 주관식 -->
										<c:choose>
											<c:when test="${questionItem.QUEST_TYPE_CD == 'B'}">
												<input type="hidden" name="question_cd_${qStatus.count}" value="${questionItem.QUESTION_CD}"></input>
												<input type="hidden" name="question2_cd_${qStatus.count}" value="${questionItem.QUESTION2_CD}"></input>
												<input type="text" title="문제 ${qStatus.count}번" name="other_${qStatus.count}" value="${questionItem.OTHER}" class="t_text vam" style="width: 98%; padding-left: 3px;" <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
											</c:when>
											
											<c:otherwise>
												<input type="hidden" name="question_cd_${qStatus.count}" value="${questionItem.QUESTION_CD}"></input>
												<input type="hidden" name="multi_check_yn_${qStatus.count}" value="${questionItem.MULTI_CHECK_YN}"></input>
												<input type="hidden" name="other_${qStatus.count}" value=""/>
												<c:forEach items="${questionItem.answerList}" var="answerItem" varStatus="aStatus">
													<!-- 객관식 --> <!-- questionItem.QUEST_TYPE_CD == 'A' 인지 체크를 해줘야하지만 그렇지 않아도 A만 나올 것임 -->
													
														<c:if test="${questionItem.MULTI_CHECK_YN == 'Y'}">
															<input type="hidden" name="checkbox_count_${qStatus.count}" value="${fn:length(questionItem.answerList)}" />
														</c:if>
														<c:choose>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'Y'}">
																<input type="checkbox" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}_${aStatus.count}" value="${answerItem.QUESTION2_CD}" id="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, answerItem.QUESTION2_CD) >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
																<input type="radio" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="${answerItem.QUESTION2_CD}" id="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, answerItem.QUESTION2_CD) >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
														</c:choose>
														${answerItem.QUESTION2}
<!--													<label for="answer2_${qStatus.count}_${answerItem.QUESTION2_CD}">-->
<!--													</label>-->
												</c:forEach>
												<!-- 기타항목 -->
												<c:if test="${questionItem.OTHER_YN == 'Y'}">

														<c:choose>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'Y'}">
																<input type="checkbox" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="9999" id="answer2_${qStatus.count}_99}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, ':9999:') >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
															<c:when test="${questionItem.MULTI_CHECK_YN == 'N'}">
																<input type="radio" title="문제 ${qStatus.count}번" name="question2_cd_${qStatus.count}" value="9999" id="answer2_${qStatus.count}_99}" <c:if test="${fn:indexOf(questionItem.QUESTION2_CD, ':9999:') >= 0}">checked="checked"</c:if> <c:if test="${Bean.view_state == 'readonly'}"> disabled='disabled'</c:if>/>
															</c:when>
														</c:choose>
														기타
<!--													<label for="answer2_${qStatus.count}_99">														-->
<!--													</label>-->
												</c:if>
											</c:otherwise>
										</c:choose>
									</dd>
								</dl>
								
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(questionList) == 0}">
					<tr>
						<td colspan="2">
							등록된 문제 리스트가 없습니다.
						</td>
					</tr>		
				</c:if>
			</tbody>
		</table>

		<c:if test="${message != null or fn:length(message) > 0}">
			<script>
				alert('${message}');
			</script>
		</c:if>


<div class="board_btn_set mt13">
	<span class="btn_del"><a href="javascript:checkUpdate();">수정하기</a></span>

				<c:url value="/admin/portal/poll/checkform/checkedList.do" var="list_action">
					<c:param name="company_id" value="${Bean.id}"/>
					<c:param name="master_cd" value="${result.master_cd}"/>
				</c:url>
	<span class="btn_list"><a href="${list_action}">목록보기</a></span>
</div>			
	</form>

</div>
</body>
</html>

