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
			form.action="/bos/concert/reserv/delete.do";
			form.submit();
		}
	}

</script>

<form name="f_regi" method="post" action="#" enctype="multipart/form-data">
	<input type="hidden" name="prgSn" value="${result.prgSn}">
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'>

	<h4>예약정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>예약정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>예약구분</th>
					<td colspan="3">${result.mainDisplay ne '1' ? '온라인' : '현장'}</td>
				</tr>
				<tr>
					<th>신청,접수일</th>
					<td><c:out value="${result.concertTitle}"/></td>
					<th>취소일</th>
					<td>${result.cancleDt}</td>
				</tr>
				<tr>
					<th>참여여부</th>
					<td colspan="3">
						${result.status eq '1' ? '예약' : '취소'}
						&nbsp;&nbsp;
						<a class="btn btn-default btn-sm" href="javascript:updateReservStatus()" id="updtReservStatusBtn">
							<span>
								참여여부변경
							</span>
						</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>개인정보</h4>
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
					<th>아이디</th>
					<td colspan="3">
						${result.userId}
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td colspan="3">
						${result.userNm}
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td colspan="3">
						${result.brthdy}
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td colspan="3">
						${result.sex}
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="3">
						${result.email}
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td colspan="3">
						${result.mbtlnum}
					</td>
				</tr>
				<tr>
					<th>거주지역</th>
					<td colspan="3">
						${result.resdncSeNm}
					</td>
				</tr>
				<tr>
					<th>직업</th>
					<td colspan="3">
						${result.job}
					</td>
				</tr>
				<tr>
					<th>소속</th>
					<td colspan="3">
						${result.psitn}
					</td>
				</tr>
				<%-- 
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
					<th>개인정보 제3자<br/>위탁제공 코멘트</th>
					<td colspan="3">${result.indvdlinfoAgreAt eq 'Y' ? result.indvdlinfoAgreCn : '미사용'}</td>
				</tr>
				 --%>
			</tbody>
		</table>
	</div>

	<h4>신청부가정보</h4>
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
					<th>이메일 수신</th>
					<td>${result.concertEmailAt eq 'Y' ? '승인' : '미승인'}</td>
					<th>SMS 수신</th>
					<td>${result.concertSmsAt eq 'Y' ? '승인' : '미승인'}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="row clear mt20">
		<div class="col-md-11 tac">
		<a href="/bos/concert/reserv/forUpdate.do?prgSn=${result.prgSn}&${pageQueryString}" class="btn btn-primary">수정</a>
			<a href="javascript:del();" class="btn btn-danger">삭제</a>
		</div>
		<div class="col-md-1"><a href="/bos/concert/reserv/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
	</div>

</form>

