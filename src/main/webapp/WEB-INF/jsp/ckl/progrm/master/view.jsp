<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>

<script type="text/javascript">

$(function() {
});

</script>

<h2>프로그램 정보</h2>
<div class="bdView">
	<table class="table">
		<caption>프로그램 정보 상세보기</caption>
		<colgroup>
		<col style="width:15%;" />
		<col style="width:35%;" />
		<col style="width:15%;" />
		<col  />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">구분/분류</th>
				<td colspan="3"><c:out value="${result.prgSeNm}"/> <c:out value="${empty result.prgClNm ? '' : '/'}"/> <c:out value="${result.prgClNm}"/></td>
			</tr>
			<tr>
				<th scope="row">프로그램명</th>
				<td colspan="3"><c:out value="${result.prgNm}"/></td>
			</tr>
			<tr>
				<th scope="row">담당부서</th>
				<td><c:out value="${result.deptNmKor}"/></td>
				<th scope="row">신청기간</th>
				<td><c:out value="${result.beginDt}"/> ~ <c:out value="${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}"/></td>
			</tr>
			<tr>
				<th scope="row">신청방식</th>
				<td><c:out value="${result.reqstMthdNm}"/> <c:if test="${result.reqstMthd eq '01'}">(<c:out value="${result.psncpa}"/>명)</c:if></td>
				<th scope="row">교육기간</th>
				<td><c:out value="${result.prgBgnde}"/> ~ <c:out value="${result.prgEndde}"/></td>
			</tr>
			<tr>
				<th scope="row">진행상태</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${progrsSttus eq WAITING}">대기</c:when>
						<c:when test="${progrsSttus eq PROGRESS}">진행</c:when>
						<c:when test="${progrsSttus eq FINISH_PSNCPA}">진행(선착순마감)</c:when>
						<c:when test="${progrsSttus eq FINISH}">마감</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<c:forEach var="fileVO" items="${fileList}" varStatus="status">
						<c:if test="${fileVO.fileFieldName ne 'mainImg'}">
							<a href="/edu/cmm/fms/FileDown.do?atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
								<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
							</a>
						</c:if>
					</c:forEach>
					<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td colspan="3">
					${result.prgCn}

					<!-- 본문이미지 대체텍스트 -->
					<!-- <div class="hidden">${result.imgDescCn}</div> -->

				</td>
			</tr>
		</tbody>
	</table>
</div>

<div class="btnSet tac">
	<%-- <c:if test="${progrsSttus eq PROGRESS}">
		<a href="/ckl/progrm/applcnt/reg01.do?prgSn=<c:out value='${result.prgSn}'/>&amp;sttus=02&amp;${pageQueryString}" onclick="return confirm('신청하시겠습니까?');" class="btn btn-primary">신청하기</a>
	</c:if> --%>
	
	<c:if test="${progrsSttus eq PROGRESS}">
		<c:if test="${result.prgSn ne '166' }">
			<a href="/ckl/progrm/applcnt/reg01.do?prgSn=<c:out value='${result.prgSn}'/>&amp;sttus=02&amp;${pageQueryString}" onclick="return confirm('신청하시겠습니까?');" class="btn btn-primary">신청하기</a>
		</c:if>
	</c:if>
	
	<c:if test="${progrsSttus eq FINISH_PSNCPA}">
		<a href="/ckl/progrm/applcnt/reg01.do?prgSn=<c:out value='${result.prgSn}'/>&amp;sttus=01&amp;${pageQueryString}" onclick="return confirm('대기접수하시겠습니까?');" class="btn btn-primary">대기접수하기</a>
	</c:if>
	<%-- <c:if test="${result.progrsSttus eq PROGRESS}">
		<c:if test="${result.psncpa > result.totCnt02}">
			<a href="/ckl/progrm/applcnt/reg01.do?prgSn=<c:out value='${result.prgSn}'/>&amp;sttus=02&amp;${pageQueryString}" onclick="return confirm('신청/접수하시겠습니까?');" class="btn btn-primary">신청/접수하기</a>
		</c:if>
		<c:if test="${result.waitReqstAt eq 'Y' and result.reqstMthd eq '01'}">
			<c:if test="${result.psncpa <= result.totCnt02 and result.waitReqstNmpr > result.totCnt01}">
				<a href="/ckl/progrm/applcnt/reg01.do?prgSn=<c:out value='${result.prgSn}'/>&amp;sttus=01&amp;${pageQueryString}" onclick="return confirm('대기 신청/접수하시겠습니까?');" class="btn btn-primary">대기 신청/접수하기</a>
			</c:if>
		</c:if>
	</c:if> --%>
	<a href="/ckl/progrm/master/list.do?${pageQueryString}" class="fr btn btn-primary">목록</a>
</div>


