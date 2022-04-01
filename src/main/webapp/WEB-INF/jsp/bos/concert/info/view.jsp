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
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/concert/info/delete.do";
			form.submit();
		}
	}

</script>

<form name="f_regi" method="post" action="#" enctype="multipart/form-data">
	<input type="hidden" name="concertId" value="${result.concertId}">
	<input type="hidden" name="pageQueryString" value='${pageQueryString}'>

	<h4>공연정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>공연관리 정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>공연명</th>
					<td colspan="3"><h5>${result.concertTitle}</h5></td>
				</tr>
				<tr>
					<th>메인노출</th>
					<td colspan="3">${result.mainDisplay eq '1' ? '허용' : '비허용'}</td>
				</tr>
				<tr>
					<th>메인이미지</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="mainImg"/>
						</c:import>
					</td>
				</tr>
				<tr>
					<th>공연포스터</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="posterImg"/>
						</c:import>
					</td>
				</tr>
				<tr>
					<th>공연구분</th>
					<td>${result.concertType}</td>
					<th>공연장소</th>
					<td>${result.concertPlace}</td>
				</tr>
				<tr>
					<th>문의가능 연락처</th>
					<td colspan="3">${result.helpCall}</td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="3">
						${result.commentMsg}
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<h4>공연상세정보</h4>
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
					<th>작품설명</th>
					<td colspan="3">
						${result.concertExplain}
					</td>
				</tr>
				<tr>
					<th>추가필드1 타이틀</th>
					<td colspan="3">
						${result.additionalTitle1}
					</td>
				</tr>
				<tr>
					<th>추가필드1 내용</th>
					<td colspan="3">
						${result.additionalContent1}
					</td>
				</tr>
				<tr>
					<th>추가필드2 타이틀</th>
					<td colspan="3">
						${result.additionalTitle2}
					</td>
				</tr>
				<tr>
					<th>추가필드2 내용</th>
					<td colspan="3">
						${result.additionalContent2}
					</td>
				</tr>
				<tr>
					<th>추가필드3 타이틀</th>
					<td colspan="3">
						${result.additionalTitle3}
					</td>
				</tr>
				<tr>
					<th>추가필드3 내용</th>
					<td colspan="3">
						${result.additionalContent3}
					</td>
				</tr>
				<tr>
					<th>추가필드4 타이틀</th>
					<td colspan="3">
						${result.additionalTitle4}
					</td>
				</tr>
				<tr>
					<th>추가필드4 내용</th>
					<td colspan="3">
						${result.additionalContent4}
					</td>
				</tr>
				<tr>
					<th>추가필드5 타이틀</th>
					<td colspan="3">
						${result.additionalTitle5}
					</td>
				</tr>
				<tr>
					<th>추가필드5 내용</th>
					<td colspan="3">
						${result.additionalContent5}
					</td>
				</tr>
				<tr>
					<th>상세이미지1</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="detailImg1"/>
						</c:import>
					</td>
				</tr>
				<tr>
					<th>상세이미지2</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="detailImg2"/>
						</c:import>
					</td>
				</tr>
				<tr>
					<th>상세이미지3</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="detailImg3"/>
						</c:import>
					</td>
				</tr>
				<tr>
					<th>추가이미지</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="additionalImg"/>
						</c:import>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<h4>공연예약설정</h4>
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
					<th>메인노출</th>
					<td colspan="3">${result.useReserv eq '1' ? '사용' : '미사용'}</td>
				</tr>
				<tr>
					<th> 예약시작</th>
					<td colspan="3">
						${result.reservStartTime}
					</td>
				</tr>
				<tr>
					<th> 예약마감시간</th>
					<td colspan="3">
						${result.reservEndTimeHh}시 ${result.reservEndTimeMi }분
					</td>
				</tr>
				<tr>
					<th>1인최대 예매</th>
					<td>
						${result.reservLimitCnt}
					</td>
					<th>금액</th>
					<td>
						${result.isFree}
					</td>
				</tr>
				<tr>
					<th> 별도 url설정</th>
					<td colspan="3">
						${result.reservUrl}
					</td>
				</tr>
				<tr>
					<th>예약좌석 설정</th>
					<td colspan="3">${result.reservSitFix eq '1' ? '지정' : '미지정'}</td>
				</tr>
				<tr>
					<th>예약매수지정</th>
					<td colspan="3">
						${result.reservOnlineSitNum}
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="row clear mt20">
		<div class="col-md-11 tac"><a href="/bos/concert/info/forUpdate.do?concertId=${result.concertId}&${pageQueryString}" class="btn btn-primary">수정</a>
			<a href="javascript:del();" class="btn btn-danger">삭제</a>
		</div>
		<div class="col-md-1"><a href="/bos/concert/info/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
	</div>

</form>

