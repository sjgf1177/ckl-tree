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

	function del(){
		console.log('test');
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/progrm/master/delete.do";
			form.submit();
		}
	}

</script>

<form name="f_regi" method="post" action="#" enctype="multipart/form-data">
	<input type="hidden" name="prgSn" value="${result.prgSn}">
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'>

	<h4>프로그램 정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>프로그램 정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>대표이미지</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="mainImg"/>
						</c:import>
					</td>
				</tr>
				<tr>
					<th>구분</th>
					<td>${result.prgSeNm}</td>
					<th>교육분류</th>
					<td>${result.prgClNm}</td>
				</tr>
				<tr>
					<th>프로그램명</th>
					<td colspan="3">${result.prgNm}</td>
				</tr>
				<tr>
					<th>담당부서</th>
					<td>${result.deptNmKor}</td>
					<th>사용여부</th>
					<td>${result.useAt eq 'N' ? '미사용' : '사용'}</td>
				</tr>
				<c:choose>
					<c:when test="${paramVO.prgCl eq 17}">
						<tr>
							<th>일정</th>
							<td>${result.beginDt}</td>
							<th>강사</th>
							<td>${result.tchNm}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<th>발신번호</th>
							<td colspan="3">${result.telNo}</td>
						</tr>
						<tr>
							<th>교육기간</th>
							<td><fmt:formatDate value="${result.prgBgnde}" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${result.prgEndde}" pattern="yyyy-MM-dd"/></td>
							<th>강사</th>
							<td>${result.tchNm}</td>
						</tr>
					</c:otherwise>
				</c:choose>
				<tr>
					<th>내용</th>
					<td colspan="3">
						${result.prgCn}
					</td>
				</tr>
				<tr>
					<th scope="row">첨부된 첨부파일</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="noImg"/>
						</c:import>
					</td>
				</tr>
				<c:if test="${paramVO.prgCl ne 17}">
					<tr>
						<th>만족도점수</th>
						<td colspan="3">${result.stsfdgScore}</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<c:if test="${paramVO.prgCl ne 17}">
	<h4>신청정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>신청정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>신청기간</th>
					<td>${result.beginDt} ~ ${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}</td>
					<th>진행상태</th>
					<td>
						<c:choose>
							<c:when test="${progrsSttus eq WAITING}">대기</c:when>
							<c:when test="${progrsSttus eq PROGRESS}">진행</c:when>
							<c:when test="${progrsSttus eq FINISH_PSNCPA}">진행</c:when>
							<c:when test="${progrsSttus eq FINISH}">마감</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>신청방식</th>
					<td>${result.reqstMthdNm}</td>
					<th>정원</th>
					<td>${result.reqstMthd eq '01' ? result.psncpa : ''} ${result.reqstMthd eq '01' ? '명' : '-'}</td>
				</tr>
				<tr>
					<th>대기신청여부</th>
					<td colspan="3">대기신청
						<c:choose>
							<c:when test="${result.waitReqstAt eq 'Y'}">가능 ( ${result.waitReqstNmpr}명 )</c:when>
							<c:otherwise>불가</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>접수번호표시</th>
					<td>${result.rceptNoIndictAt eq 'N' ? '숨김' : '표시'}</td>
					<th>승인단계사용</th>
					<td>${result.confmStepAt eq 'N' ? '미사용' : '사용'}</td>
				</tr>
				<tr>
					<th>수료증발급</th>
					<td>${result.ctfhvIssuUseAt eq 'N' ? '미사용' : '사용'}</td>
					<th>위탁제공사용</th>
					<td>${result.indvdlinfoAgreAt eq 'N' ? '미사용' : '사용'}</td>
				</tr>
				<tr>
					<th>개인정보 제3자<br/> 제공을 위한 동의사항</th>
					<td>${result.indvdlinfoThreeAgreAt eq 'Y' ? '사용' : '미사용'}</td>
					<th>제공기관</th>
					<td>${result.indvdlinfoProvider}</td>					
				</tr>									
				<tr>
					<th>추가정보 수집 및<br/> 이용 동의 코멘트</th>
					<td colspan="3">${result.indvdlinfoAgreAt eq 'Y' ? result.indvdlinfoAgreCn : '미사용'}</td>
				</tr>
			</tbody>
		</table>
	</div>
	</c:if>

	<div class="row clear mt20">
		<div class="col-md-11 tac"><a href="/bos/progrm/master/forUpdate.do?prgSn=${result.prgSn}&${pageQueryString}" class="btn btn-primary">수정</a>
			<a href="javascript:del();" class="btn btn-danger">삭제</a>
		</div>
		<div class="col-md-1"><a href="/bos/progrm/master/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
	</div>

</form>

