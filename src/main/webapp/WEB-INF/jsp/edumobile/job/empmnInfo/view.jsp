<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- bdView -->
<p class="alert_title">채용기업정보</p>
<div class="mb20">
	<table class="contents_insight_view contact_us_view" style="word-break:break-all;">
		<caption>채용기업정보</caption>
		<colgroup>
		<col style="width:20%" />
		<col style="width:30%" />
		<col style="width:20%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">회사명</th>
				<td colspan="3"><c:out value="${result.corpNm }" /></td>
			</tr>
			<tr>
				<th scope="row">대표자명</th>
				<td><c:out value="${result.reperNm }" /></td>
				<th scope="row">근로자수</th>
				<td><c:out value="${result.totPsncnt }" /></td>
			</tr>
			<tr>
				<th scope="row">자본금</th>
				<td><c:out value="${result.capitalAmt }" /></td>
				<th scope="row">연매출액</th>
				<td><c:out value="${result.yrSalesAmt }" /></td>
			</tr>
			<tr>
				<th scope="row">업종</th>
				<td colspan="3"><c:out value="${result.indTpCdNm }" /></td>
			</tr>
			<tr>
				<th scope="row">주요사업내용</th>
				<td colspan="3"><c:out value="${result.busiCont }" /></td>
			</tr>
			<tr>
				<th scope="row">회사주소</th>
				<td colspan="3"><c:out value="${result.corpAddr }" /></td>
			</tr>
			<tr>
				<th scope="row">홈페이지</th>
				<td colspan="3"><c:out value="${result.homePg }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<p class="alert_title">모집요강</p>
<div class="mb20 alert">
	<p> 콘텐츠 인력을 모집 (콘텐츠분야)  자세한 내용은 모집요강을 참조하세요</p>
</div>
<div class="mb20">
	<table class="contents_insight_view contact_us_view">
		<caption>모집요강</caption>
		<colgroup>
		<col style="width:20%" />
		<col style="width:30%" />
		<col style="width:20%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">모집직종</th>
				<td colspan="3"><c:out value="${result.jobsNm }" /></td>
			</tr>
			<tr>
				<th scope="row">채용제목</th>
				<td colspan="3"><c:out value="${result.wantedTitle }" /></td>
			</tr>
			<tr>
				<th scope="row">직무내용</th>
				<td colspan="3">
					<% pageContext.setAttribute("crlf", "\n"); %>
					<c:out value='${fn:replace(result.jobCont, crlf, "<br/>")}' escapeXml='false' />
				</td>
			</tr>
			<tr>
				<th scope="row">접수마감일</th>
				<td><c:out value="${result.receiptCloseDt }" /></td>
				<th scope="row">고용형태</th>
				<td><c:out value="${result.empTpNm }" /></td>
			</tr>
			<tr>
				<th scope="row">모집인원</th>
				<td><c:out value="${result.collectPsncnt }" /></td>
				<th scope="row">임금조건</th>
				<td><c:out value="${result.salTpNm }" /></td>
			</tr>
			<tr>
				<th scope="row">경력조건</th>
				<td><c:out value="${result.enterTpNm }" /></td>
				<th scope="row">학력</th>
				<td><c:out value="${result.eduNm }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<p class="alert_title">우대사항</p>
<div class="mb20">
	<table class="contents_insight_view contact_us_view" style="word-break:break-all;">
		<caption>우대사항</caption>
		<colgroup>
		<col style="width:20%" />
		<col style="width:30%" />
		<col style="width:20%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">외국어능력</th>
				<td><c:out value="${result.forLang }" /></td>
				<th scope="row">전공</th>
				<td><c:out value="${result.major }" /></td>
			</tr>
			<tr>
				<th scope="row">자격면허</th>
				<td><c:out value="${result.certificate }" /></td>
				<th scope="row">병역특례채용희망</th>
				<td><c:out value="${result.mltsvcExcHope }" /></td>
			</tr>
			<tr>
				<th scope="row">컴퓨터활용능력</th>
				<td><c:out value="${result.compAbl }" /></td>
				<th scope="row">우대조건</th>
				<td><c:out value="${result.pfCond }" /></td>
			</tr>
			<!--
			<tr>
				<th scope="row">장애인 채용희망</th>
				<td colspan="3"><c:out value="${result.corpNm }" /></td>
			</tr>
			 -->
			<tr>
				<th scope="row">기타 우대사항</th>
				<td colspan="3"><c:out value="${result.etcPfCond }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<p class="alert_title">전형방법</p>
<div class="mb20">
	<table class="contents_insight_view contact_us_view" style="word-break:break-all;">
		<caption>전형방법</caption>
		<colgroup>
		<col style="width:20%" />
		<col style="width:30%" />
		<col style="width:20%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">전형방법</th>
				<td><c:out value="${result.selMthd }" /></td>
				<th scope="row">접수방법</th>
				<td><c:out value="${result.rcptMthd }" /></td>
			</tr>
			<tr>
				<th scope="row">제출서류 준비물</th>
				<td colspan="3"><c:out value="${result.corpNm }" /></td>
			</tr>
			<tr>
				<th scope="row">제출서류양식 첨부</th>
				<td colspan="3"><c:out value="${result.corpNm }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<p class="alert_title">근무환경 및 복리후생</p>
<div class="mb20">
	<table class="contents_insight_view contact_us_view" style="word-break:break-all;">
		<caption>근무환경 및 복리후생</caption>
		<colgroup>
		<col style="width:20%" />
		<col style="width:30%" />
		<col style="width:20%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">근무예정지</th>
				<td colspan="3"><c:out value="${result.workRegion }" /></td>
			</tr>
			<tr>
				<th scope="row">소속산업단지</th>
				<td colspan="3"><c:out value="${result.indArea }" /></td>
			</tr>
			<tr>
				<th scope="row">인근전철역</th>
				<td colspan="3"><c:out value="${result.nearLine }" /></td>
			</tr>
			<tr>
				<th scope="row">근무형태/시간</th>
				<td colspan="3"><c:out value="${result.workdayWorkhrCont }" /></td>
			</tr>
			<tr>
				<th scope="row">연금4대보험</th>
				<td><c:out value="${result.fourIns }" /></td>
				<th scope="row">퇴직금지급방법</th>
				<td><c:out value="${result.retirepay }" /></td>
			</tr>
			<tr>
				<th scope="row">기타복리후생</th>
				<td><c:out value="${result.corpNm }" /></td>
				<th scope="row">장애인편의시설</th>
				<td><c:out value="${result.corpNm }" /></td>
			</tr>
		</tbody>
	</table>
</div>


<p class="alert_title">기타 입력사항</p>
<div class="mb30 alert">
	<c:out value='${fn:replace(result.etcHopeCont, crlf, "<br/>")}' escapeXml='false' />
</div>

<div class="mb30">
	<a href="http://www.work.go.kr" target="_blank" title="워크넷 바로가기(새창열림)"><img src="/edu/images/sub5/info_source.gif" alt="정보출처 : 워크넷(Worknet)  본 자료는 고용노동부 워크넷(www.work.go.kr)에서 제공된 정보이며, 무단복제 및 배포를 금지합니다." /></a>
</div>

<div class="board_util_btn_con">
	<a href="/edumobile/job/empmnInfo/list.do?${pageQueryString}" class="btn_style_0 full list">목록</a>
</div>

<!-- //bdView -->
