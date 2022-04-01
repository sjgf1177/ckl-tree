<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>

<p class="vocIntro_title">함께 : 톡톡은 </p>
<p class="alert_title short_bottom" style="margin-bottom:0;">
	에듀코카 서비스를 이용하시면서 불편하거나 개선이 필요한 부분, 그리고 콘텐츠인재양성 프로그램에 제안하고 싶은 사항에 대한 <span class="apply_no_text">의견을 기재하는 공간</span>입니다.
</p>

<div class="vocIntro_box">
	<ul>
		<li>
			<span>불편사항 접수</span>
			<img src="/edu/new_image/icon/voc_icon1.png" alt="불편사항 접수 아이콘">
			<span>교육 내용 문의, 홈페이지 및 학습 오류 등 이용에 대한 불편 사항 접수</span>
		</li>
		<li>
			<span>참여하기</span>
			<img src="/edu/new_image/icon/voc_icon2.png" alt="참여하기 아이콘">
			<span>콘텐츠 인재 양성 사업 관련 아이디어 및 의견 접수</span>
		</li>
		<li>
			<span>건의하기</span>
			<img src="/edu/new_image/icon/voc_icon3.png" alt="건의하기 아이콘">
			<span>홈페이지 개선 및 교육 프로그램 성장을 위한 의견 접수</span>
		</li>
	</ul>
</div>

<div class="btnSet tac">
	<a href="/edu/bbs/B0000076/forInsert.do?menuNo=500221" class="btn btn-primary" style="font-size:1.4rem;">글쓰기</a>
</div>

<div class="col-12 sub_board_body">
	<table class="board_type_0">
		<caption>${masterVO.bbsNm} 목록</caption>
		<colgroup>
			<col width="8%"/>
			<col width="12%"/>
			<col />
			<col width="15%"/>
			<col width="8%"/>
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성일</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}${pageQueryString}" />
					<td>${(resultCnt) - (paginationInfo.pageSize * (paramVO.pageIndex-1)) - (status.index)}</td>
					<td style="text-align: center;">
						<c:choose>
							<c:when test="${result.option2 eq '01' }">건의하기</c:when>
							<c:when test="${result.option2 eq '02' }">참여하기</c:when>
							<c:when test="${result.option2 eq '03' }">불편사항 접수</c:when>
						</c:choose>
					</td>
					<td style="text-align: left; padding-left: 20px;">
						<a href="javascript:lock();">${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}</a>
					</td>
					<td>
						<c:out value="${result.frstRegisterPnttm}"/>
					</td>
					<td>
						<c:set var = "length" value = "${fn:length(result.ntcrNm)}"/>
						<c:out value="${fn:substring(result.ntcrNm, 0, 1)}"/>
						*
						<c:out value="${fn:substring(result.ntcrNm, length-1, length)}"/>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
</c:if>
</div>

<script>
	function lock(){
		alert("비공개글입니다.");	
	}
</script>
