<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>

<script type="text/javascript">

var codeIdVal = "COM050";
var prgSeVal = "<c:out value='${param.prgSe}'/>";
var prgClVal = "<c:out value='${param.prgCl}'/>";

$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

/* 	if (prgSeVal != "") getCodeList("prgCl", codeIdVal, $("#prgSe").val(), 2, prgClVal);

	$("select[name=prgSe]").change(function(){
		var val = $(this).val();
		getCodeList("prgCl", codeIdVal, val, 2);
	}); */
});

//공통 코드목록 화면처리
function getCodeList(elemntId, codeId, upperCode, depth, code) {
	var $obj = $("#"+ elemntId);
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};
	$.get(url, params, function(data) {
		if (data) {
			$obj.empty();
			$("<option>").text("분류 선택").attr("value","").appendTo($obj);
			$.each(data.list, function(key,item) {
				var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
				if (code == item.code) $codeItem.attr("selected",true);
				$codeItem.appendTo($obj);
			});
			if ("prgCl" == elemntId && "" == upperCode) {
				$("<option>").text("분류 선택").attr("value","").appendTo($("#prgCl").empty());
			}
		}
	},"json");
}

</script>

<form id="frm" name="frm" method="post" action="/bos/progrm/master/list.do?menuNo=${param.menuNo}" class="form-inline">
	<input type="hidden" name="siteSe" value="${param.siteSe}" >
	<fieldset>
		<legend></legend>
			<div class="bdView mb0">
				<table class="table table-bordered">
					<caption>
					</caption>
					<colgroup>
					<col span="3">
					<col>
					</colgroup>
					<tbody>
						<tr>
							<th><label for="prgSe">구분</label></th>
							<td>
								<input type="hidden" name="prgSe" value="${paramVO.prgSe}" />
								
								<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
									<c:if test="${paramVO.prgSe eq code.code}">${code.codeNm}</c:if>
								</c:forEach>
								
								<%-- <select name="prgSe" id="prgSe" title="구분 선택">
									<option value="">구분 선택</option>
									<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
										<c:if test="${paramVO.prgSe eq code.code}">
											<option value="${code.code}" <c:if test="${paramVO.prgSe eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
										</c:if>
									 </c:forEach>
								</select> --%>
							</td>
							<th><label for="prgCl">분류</label></th>
							<td>
								<select name="prgCl" id="prgCl" title="분류" >
									<option value="">분류 선택</option>
									<c:choose>
										<c:when test="${paramVO.prgCl eq 17}">
											<option value="17" selected>오픈특강</option>
										</c:when>
										<c:when test="${paramVO.prgCl eq 70}">
											<option value="70" selected>교육신청</option>
										</c:when>
										<c:otherwise>
											<sec:authorize ifNotGranted="ROLE_PROGRAM_STEP_INSITE, ROLE_TASK_STEPUP_INSITE, ROLE_EDU_PRGR, ROLE_TASK_VALUEUP">
												<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
													<c:if test="${paramVO.prgSe eq code.upperCode}">
														<option value="${code.code}" <c:if test="${paramVO.prgCl eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
													</c:if>
												 </c:forEach>
											</sec:authorize>
											<sec:authorize ifAnyGranted="ROLE_TASK_STEPUP_INSITE">
												<c:choose>
													<c:when test="${user.userId eq 'gameliteracy' }">
														<option value="14">게임리터러시교육</option>
													</c:when>
		
											 		<c:otherwise>
											 			<option value="12">콘텐츠 스텝업</option>
														<option value="13">콘텐츠 인사이트</option>
														<option value="15">콘텐츠 밸류업</option>
														<option value="16">게임 인재원</option>
														<option value="14">게임리터러시교육</option>
											 		</c:otherwise>
											 	</c:choose>
											</sec:authorize> 
										 </c:otherwise>
									 </c:choose>
								</select>
							</td>
						</tr>
						<tr>
							<c:choose>
								<c:when test="${paramVO.prgCl eq 17}">
									<th><label for="prgNm">프로그램명</label></th>
									<td colspan="3"><input type="text" name="prgNm" id="prgNm" value="${param.prgNm}"></td>
								</c:when>
								<c:otherwise>
									<th><label for="prgNm">프로그램명</label></th>
									<td><input type="text" name="prgNm" id="prgNm" value="${param.prgNm}"></td>
									<th>신청기간</th>
									<td>
										<input type="text" id="sdate" name="sdate" value="${param.sdate}" style="width:130px" title="신청기간 시작일 입력" /> ~
									    <input type="text" id="edate" name="edate" value="${param.edate}" style="width:130px" title="신청기간 종료일 입력" />
									</td>
								</c:otherwise>
							</c:choose>
							
						</tr>
						<c:if test="${paramVO.prgCl ne 17}">
							<tr>
								<th><label for="reqstMthd">신청방식</label></th>
								<td>
									<select name="reqstMthd" id="reqstMthd" title="신청방식 선택">
										<option value="">신청방식 선택</option>
										<c:forEach var="code" items="${COM053CodeList}" varStatus="status">
											<option value="${code.code}" <c:if test="${paramVO.reqstMthd eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
										 </c:forEach>
									</select>
								</td>
								<th><label for="progrsSttus2">진행상태</label></th>
								<td>
									<select name="progrsSttus2" id="progrsSttus2" title="진행상태 선택">
										<option value="">진행상태 선택</option>
										<c:forEach var="code" items="${COM052CodeList}" varStatus="status">
											<option value="${code.code}" <c:if test="${paramVO.progrsSttus2 eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
										 </c:forEach>
									</select>
								</td>
							</tr>
						</c:if>
						<tr>
							<th><label for="deptId">담당부서</label></th>
							<td>
								<select name="deptId" id="deptId" title="담당부서를 선택해 주세요.">
									<option value="">부서 선택</option>
								<c:forEach var="dept" items="${deptList}" varStatus="status">
									<option value="${dept.deptId}" <c:if test="${deptId eq dept.deptId}">selected="selected"</c:if>>${dept.deptNmKor}[${dept.deptNmEng}]</option>
								</c:forEach>
								</select>
							</td>
							<th><label for="useAt">사용여부</label></th>
							<td>
								<select name="useAt" id="useAt" title="사용여부를 선택해 주세요.">
									<option value="" >사용여부 선택</option>
									<option value="Y" <c:if test="${param.useYn eq 'Y'}">selected="selected"</c:if>>사용</option>
									<option value="N" <c:if test="${param.useYn eq 'N'}">selected="selected"</c:if>>미사용</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><label for="prgCn"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 내용</label></th>
							<td colspan="3">
							<textarea name="prgCn" id="prgCn" cols="120" rows="2" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';">${param.prgCn}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="btnSet">
				<input type="submit" class="btn btn-primary" value="검색" />
				<a class="btn btn-primary" href="/bos/progrm/applcnt/applcntBatchExcel.do?${pageQueryString}"><span>신청자 일괄 등록</span></a>
				<a class="btn btn-primary" href="/bos/progrm/master/forInsert.do?${pageQueryString}"><span>프로그램 신규 등록</span></a>
			</div>
	</fieldset>
</form>

<div class="row mt10 mb5">
	<div class="col-md-12"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
</div>

<div class="bdList">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
			<c:choose>
				<c:when test="${paramVO.prgCl eq 17 }">
					<col style="width: 50px;"><!-- 번호  -->
					<col style="width: 90px;"><!-- 구분 -->
					<col style="width: 120px;"><!-- 분류 -->
					<col>					<!-- 프로그램명 -->
					<col style="width: 90px;"><!-- 담당부서 -->
					<col style="width: 70px;"><!-- 사용여부 -->
				</c:when>
				<c:otherwise>
					<col style="width: 35px;"><!-- 번호  -->
					<col style="width: 35px;"><!-- 구분 -->
					<col style="width: 90px;"><!-- 분류 -->
					<col>					<!-- 프로그램명 -->
					<col style="width: 90px;"><!-- 교육기간 -->
					<col style="width: 60px;"><!-- 신청방식 -->
					<col style="width: 125px;"><!-- 신청기간 -->
					<col style="width: 40px;"><!-- 진행상태 -->
					<col style="width: 80px;"><!-- 담당부서 -->
					<col style="width: 35px;"><!-- 사용여부 -->
					<col style="width: 100px;"><!-- 신청현황 -->
					<col><!-- 템플릿관리 -->
				</c:otherwise>
			</c:choose>
			
			
			
		</colgroup>
		<thead>
			<tr>
				<c:choose>
					<c:when test="${paramVO.prgCl eq 17 }">
						<th>번호</th>
						<th>구분</th>
						<th>분류</th>
						<th>프로그램명</th>
						<th>담당부서</th>
						<th>사용여부</th>
					</c:when>
					<c:otherwise>
						<th>번호</th>
						<th>구분</th>
						<th>분류</th>
						<th>프로그램명</th>
						<th>교육기간</th>
						<th>신청방식</th>
						<th>신청기간</th>
						<th>진행상태</th>
						<th>담당부서</th>
						<th>사용여부</th>
						<th>신청현황<br>(정원/신청/대기정원/신청)</th>
						<th>템플릿관리</th>
					</c:otherwise>
				</c:choose>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>${result.prgSeNm}</td>
					<td>${result.prgClNm}</td>
					<td><a href="/bos/progrm/master/view.do?prgSn=${result.prgSn}&${pageQueryString}">${result.prgNm}</a></td>
					<c:if test="${paramVO.prgCl ne 17 }">
						<td>${result.prgBgnde} ~ ${result.prgEndde}</td>
						<td>${result.reqstMthdNm}</td>
						<td>${result.beginDt} ~ ${result.rcritComptAt eq 'Y' ? '모집완료시' : result.endDt}</td>
						<td>
							<c:choose>
								<c:when test="${result.progrsSttus eq WAITING}">대기</c:when>
								<c:when test="${result.progrsSttus eq PROGRESS}">진행</c:when>
								<c:when test="${result.progrsSttus eq FINISH_PSNCPA}">진행</c:when>
								<c:when test="${result.progrsSttus eq FINISH}">마감</c:when>
							</c:choose>
						</td>
					</c:if>
					<td>인재양성팀</td>
					<td>${result.useAt eq 'N' ? '미사용' : '사용'}</td>
					<c:if test="${paramVO.prgCl ne 17 }">
						<td>
							<a class="btn btn-default btn-sm" href="/bos/progrm/applcnt/list.do?prgSn=${result.prgSn}&${pageQueryString}">
								<span>
									<c:choose>
										<c:when test="${result.reqstMthd eq '01'}">${result.psncpa} /</c:when>
										<c:otherwise>- /</c:otherwise>
									</c:choose>
									${result.totCnt02}
									<c:choose>
										<c:when test="${result.waitReqstAt eq 'Y'}">/ ${result.waitReqstNmpr} / ${result.totCnt01}</c:when>
										<c:otherwise>/ - / -</c:otherwise>
									</c:choose>
								</span>
							</a>
						</td>
						<td><a class="btn btn-primary btn-sm" href="/bos/progrm/master/regTmplat.do?prgSn=${result.prgSn}&${pageQueryString}"><span>관리</span></a></td>
					</c:if>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="11">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btn_set">
	<a class="btn btn-success" href="/bos/progrm/master/downloadExcel.xls?${pageQueryString}"><span>엑셀저장</span></a>
	<a class="btn btn-primary" href="/bos/progrm/master/forInsert.do?${pageQueryString}"><span>프로그램 신규 등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paginationSet">
			${pageNav}
		</div>
	</div>
</c:if>

