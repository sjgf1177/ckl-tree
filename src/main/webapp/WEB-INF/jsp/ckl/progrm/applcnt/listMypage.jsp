<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>

<script type="text/javascript">
//<![CDATA[

	$(function() {

		$("#term01Btn").click(function() {
			if ($("#rceptStDt").val() == "") {
				alert("신청/접수시작일자를 선택해 주세요.");
				return false;
			}
			var edate = fnAddCalMonth($("#rceptStDt").val(),1);
			$("#rceptEdDt").val(edate);
			return false;
		});

		$("#term03Btn").click(function() {
			if ($("#rceptStDt").val() == "") {
				alert("신청/접수시작일자를 선택해 주세요.");
				return false;
			}
			var edate = fnAddCalMonth($("#rceptStDt").val(),3);
			$("#rceptEdDt").val(edate);
			return false;
		});

		$("#term06Btn").click(function() {
			if ($("#rceptStDt").val() == "") {
				alert("신청/접수시작일자를 선택해 주세요.");
				return false;
			}
			var edate = fnAddCalMonth($("#rceptStDt").val(),6);
			$("#rceptEdDt").val(edate);
			return false;
		});

		$("#term12Btn").click(function() {
			if ($("#rceptStDt").val() == "") {
				alert("신청/접수시작일자를 선택해 주세요.");
				return false;
			}
			var edate = fnAddCalMonth($("#rceptStDt").val(),12);
			$("#rceptEdDt").val(edate);
			return false;
		});

		rceptSttusChange = function(reqstSn, prgSn, prgNm) {
			if (!confirm("정말로 취소하시겠습니까?")) {
				return;
			}
			$.post(
				"/ckl/progrm/applcnt/rceptSttusChange.json",
				{reqstSn : reqstSn, prgSn : prgSn, prgNm : prgNm, rceptSttus : '03'},
				function(data)
				{
					if (data.resultCode == "success") {
						alert("취소되었습니다.");
						location.reload();
					}
				},"json"
			);
		  	return;
		};

		ctfhvPopup = function(prgSn, reqstSn) { // 수료증 팝업창
			window.open("/ckl/progrm/applcnt/ctfhvPopup.do?viewType=CONTBODY&prgSn="+prgSn+"&reqstSn="+reqstSn, "ctfhvPopup", "top=200, left=600, width=800, height=750, status=yes, resizable=yes, scrollbars=no");
		};

	});

	function fnAddCalMonth(date, addMonth) {
		var dateArray = date.split("-");
		var tmpDate = new Date(dateArray[0], Number(dateArray[1])-1 ,dateArray[2]);
		tmpDate.setMonth(Number(dateArray[1])-1+ addMonth);

		var year = tmpDate.getFullYear();
		var month = tmpDate.getMonth()+1;
		if (month < 10) month = "0"+month;
		var day = tmpDate.getDate();
		if (day < 10) day = "0"+day;
		var resultDate = year + "-" + month + "-" +  day;
		return resultDate;
	}

//]]>
</script>

<form id="applcntForm" name="applcntForm" method="get" class="form-inline" action="/<c:out value="${paramVO.siteName }" />/progrm/applcnt/listMypage.do">
	<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
	<div class="tal alert formLine1">
			<fieldset>
				<legend>신청현황 검색</legend>
				<div class="clearfix">
				<span class="btn-group fl mr10">
					<a href="#self" class="btn btn-sm btn-default" id="term01Btn">1개월</a>
					<a href="#self" class="btn btn-sm btn-default" id="term03Btn">3개월</a>
					<a href="#self" class="btn btn-sm btn-default" id="term06Btn">6개월</a>
					<a href="#self" class="btn btn-sm btn-default" id="term12Btn">12개월 이전</a>
				</span>
				<input type="text" id="rceptStDt" name="rceptStDt" class="sdate" title="예약일자 시작일 입력" style="width:120px" value="<c:out value="${paramVO.rceptStDt }" />" />
					~
				<input type="text" id="rceptEdDt" name="rceptEdDt" class="edate" title="예약일자 종료일 입력" style="width:120px" value="<c:out value="${paramVO.rceptEdDt }" />" />
				<input type="submit" class="btn btn-primary" id="submitBtn" value="검색" />
				</div>
			</fieldset>
	</div>

	<div class="row clear tar mb20"></div>
</form>


<div class="bdList infoTable">
	<table class="table">
		<caption>프로그램 신청/접수 현황 목록</caption>
		<colgroup>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">분류</th>
				<th scope="col">프로그램명</th>
				<th scope="col">신청방식 (정원)</th>
				<th scope="col">신청/접수일시</th>
				<th scope="col">취소여부<br>
					(취소일시)</th>
				<th scope="col">진행상태</th>
				<th scope="col">기타</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td><c:out value="${result.prgSeNm}"/></td>
					<td><c:out value="${result.prgClNm}"/></td>
					<td class="tal">
						<a href="/ckl/progrm/applcnt/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;reqstSn=<c:out value="${result.reqstSn}"/>&amp;menuNo=${param.menuNo}"><c:out value="${result.prgNm}"/></a>
					</td>
					<td>
						<c:out value="${result.reqstMthdNm}"/>
						<c:choose>
							<c:when test="${result.reqstMthd eq '01'}">(<c:out value="${result.psncpa}"/>)</c:when>
							<c:otherwise>( - )</c:otherwise>
						</c:choose>
					</td>
					<td><c:out value="${result.rDt}"/></td>
					<td>
						<c:choose>
							<c:when test="${result.rceptSttus eq '03'}">취소<br/><c:out value="${result.cDt}"/></c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:out value="${result.rceptSttusNm}"/>
						<%-- <c:choose>
							<c:when test="${result.progrsSttus eq WAITING}">대기</c:when>
							<c:when test="${result.progrsSttus eq PROGRESS}">진행</c:when>
							<c:when test="${result.progrsSttus eq FINISH_PSNCPA}">진행(대기신청)</c:when>
							<c:when test="${result.progrsSttus eq FINISH}">마감</c:when>
						</c:choose> --%>

						<c:if test="${result.rceptSttus ne '03'}">
							<c:choose>
								<c:when test="${result.reqstMthd eq '01'}">
									<!--
										선착순일시 취소여부?
									 -->
									<c:if test="${result.progrsSttus ne FINISH}">
										<p><a href="javascript:rceptSttusChange('<c:out value='${result.reqstSn}'/>', '<c:out value='${result.prgSn}'/>', '<c:out value='${result.prgNm}'/>');" class="btn btn-xs btn-gray">신청/접수 취소</a></p>
									</c:if>
								</c:when>
								<c:when test="${result.reqstMthd eq '02'}">
									<c:if test="${result.progrsSttus ne FINISH}">
										<p><a href="javascript:rceptSttusChange('<c:out value='${result.reqstSn}'/>', '<c:out value='${result.prgSn}'/>', '<c:out value='${result.prgNm}'/>');" class="btn btn-xs btn-gray">신청/접수 취소</a></p>
									</c:if>
								</c:when>
							</c:choose>

						</c:if>
					</td>
					<td>
						<c:if test="${result.rceptSttus ne '03'}"> <!-- 취소 X -->
							<c:if test="${result.progrsSttus ne FINISH}">
								<p><a href="/ckl/progrm/applcnt/forUpdate.do?prgSn=<c:out value="${result.prgSn}"/>&amp;reqstSn=<c:out value="${result.reqstSn}"/>&amp;menuNo=${param.menuNo}" class="btn btn-xs btn-success">수정</a></p>
							</c:if>

							<c:if test="${result.rceptSttus eq '02'}"> <!-- 신청완료 -->
								<c:if test="${result.prgEnddeEndDt eq FINISH}"> <!-- 교육기간 마감 -->
									<c:if test="${result.ctfhvIssuUseAt eq 'Y'}">
										<c:if test="${result.partcptnComptAt eq '01'}">
											<p><a href="#" onclick="ctfhvPopup(<c:out value='${result.prgSn}'/>,<c:out value='${result.reqstSn}'/>);" class="btn btn-xs btn-success" target="_blank" title="수료증발급 (새창열림)">수료증발급</a></p>
										</c:if>
									</c:if>
								</c:if>
							</c:if>
						</c:if>
					</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td colspan="9">- 검색 결과가 없습니다 -</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->
<!-- //bdList -->

<script type="text/javascript">
//<![CDATA[
  $('.aTrigger').click(function() {

	  var detail = $(this).parents("tr").next().html();

	  if($(this).parents("tr").next().is(':visible')){
		  $(this).parent().parent().find('td').removeClass('on');
		  $(this).parents("tr").next().addClass('dn');
	}else{
		  $(this).parent().parent().find('td').addClass('on');
		  $(this).parents("tr").next().removeClass('dn');
	}
	 return false;
  });

//]]>
</script>
