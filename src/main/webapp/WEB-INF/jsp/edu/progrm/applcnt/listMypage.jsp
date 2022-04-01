<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>

<%!
public boolean isQuotation(String html) throws Exception {
    return html.indexOf( "'" ) > -1 || html.indexOf( "\"" ) > -1; 
}
%>

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
				"/edu/progrm/applcnt/rceptSttusChange.json",
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
			window.open("/edu/progrm/applcnt/ctfhvPopup.do?viewType=CONTBODY&prgSn="+prgSn+"&reqstSn="+reqstSn, "ctfhvPopup", "top=200, left=600, width=800, height=750, status=yes, resizable=yes, scrollbars=no");
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
	<div class="tal alert formLine1 program_design_box">
			<fieldset>
				<legend>신청현황 검색</legend>
				<div class="clearfix">
				<div class="show mr50 board_util_btn_con">
					<a href="#self" class="btn_style_0 small empty" id="term01Btn">1개월</a>
					<a href="#self" class="btn_style_0 small empty" id="term03Btn">3개월</a>
					<a href="#self" class="btn_style_0 small empty" id="term06Btn">6개월</a>
					<a href="#self" class="btn_style_0 small empty" id="term12Btn">12개월 이전</a>
				</div>
				<input type="text" id="rceptStDt" name="rceptStDt" class="sdate" title="예약일자 시작일 입력" style="width:108px" value="<c:out value="${paramVO.rceptStDt }" />" />
					~
				<input type="text" id="rceptEdDt" name="rceptEdDt" class="edate" title="예약일자 종료일 입력" style="margin-left:7px; width:108px" value="<c:out value="${paramVO.rceptEdDt }" />" />
				<input type="submit" class="design_summit_btn" id="submitBtn" value="검색" title="검색" />
				</div>
			</fieldset>
	</div>

	<div class="row clear tar mb20"></div>
</form>


<div class="infoTable">
	<table class="board_type_0 small" style="word-break:break-all;">
		<caption>
			<strong>
				프로그램 신청/접수 현황 목록
				번호, 구분, 분류, 프로그램명, 신청방식(정원), 신청/접수일시, 취소여부(취소일시), 진행상태, 기타로 구분되는 표
			</strong>
			<details>
			<summary>설명</summary>
			<p>번호, 구분, 분류, 프로그램명, 신청방식 (정원), 신청/접수일시, 취소여부
					(취소일시), 진행상태, 기타 정보를 포함하는 표</p>
			</details>
		</caption>
		<colgroup>
			<col width="6%">
			<col width="10%">
			<col width="10%">
			<col>
			<col width="7%">
			<col width="7%">
			<col width="7%">
			<col width="8%">
			<col width="145px">
			<col width="8%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">분류</th>
				<th scope="col">프로그램명</th>
				<th scope="col">신청방식 (정원)</th>
				<th scope="col">신청/접수일시</th>
				<th scope="col">상담자</th><!-- rsg20170823 최초추가 -->
				<th scope="col">취소여부<br>
					(취소일시)</th>
				<th scope="col">진행상태</th>
				<th scope="col">기타</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:out value="${result.confmSttusNm}"/>
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td><c:out value="${result.prgSeNm}"/></td>
					<td><c:out value="${result.prgClNm}"/></td>
					<td class="tal">
						<a href="/edu/progrm/applcnt/view.do?prgSn=<c:out value="${result.prgSn}"/>&amp;reqstSn=<c:out value="${result.reqstSn}"/>&amp;menuNo=${param.menuNo}"><c:out value="${result.prgNm}"/></a>
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
							<c:when test="${result.prgClNm eq '입사지원서 컨설팅'}">황경애</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose> 
					</td>
					<td>
						<c:choose>
							<c:when test="${result.rceptSttus eq '03'}">취소<br/><c:out value="${result.cDt}"/></c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose>
					</td>
					<td>
						<div class="apply_end_text">
							<c:choose>
								<c:when test="${result.prgClNm eq '콘텐츠 플러스'}">
									<c:choose>
										<c:when test="${result.confmSttus eq '01' }">승인대기</c:when>
										<c:when test="${result.confmSttus eq '02' }">1차승인</c:when>
										<c:when test="${result.confmSttus eq '03' }">2차승인</c:when>
										<c:when test="${result.confmSttus eq '04' }">승인완료</c:when>
										<c:when test="${result.confmSttus eq '05' }">미승인</c:when>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:out value="${result.rceptSttusNm}"/>
								</c:otherwise>
							</c:choose>
						</div>
                        <c:set var='idxPrgNm' value='${result.prgNm}'/>
                        <%
                        String idxPrgNm = (String)pageContext.getAttribute("idxPrgNm") != null ? (String)pageContext.getAttribute("idxPrgNm") : "" ;
                        %>
						<c:if test="${result.rceptSttus ne '03'}">
							<c:choose>
								<c:when test="${result.reqstMthd eq '01'}">
									<!--
										선착순일시 취소여부?
									 -->
									<c:if test="${result.progrsSttus ne FINISH}">
										<p class="board_util_btn_con center"><a href="javascript:rceptSttusChange('<c:out value='${result.reqstSn}'/>', '<c:out value='${result.prgSn}'/>' <%= (isQuotation(idxPrgNm)?"":",'"+idxPrgNm+"'") %> );" class="btn_style_0 small gray">신청/접수 취소</a></p>
									</c:if>
								</c:when>
								<c:when test="${result.reqstMthd eq '02'}">
									<c:if test="${result.progrsSttus ne FINISH}">
										<p class="board_util_btn_con center"><a href="javascript:rceptSttusChange('<c:out value='${result.reqstSn}'/>', '<c:out value='${result.prgSn}'/>' <%= (isQuotation(idxPrgNm)?"":",'"+idxPrgNm+"'") %> );" class="btn_style_0 small gray">신청/접수 취소</a></p>
									</c:if>
								</c:when>
							</c:choose>
						</c:if>
					</td>
					<td>
						<c:if test="${result.rceptSttus ne '03'}"> <!-- 취소 X -->
							<c:if test="${result.progrsSttus ne FINISH}">
								<p class="board_util_btn_con center"><a href="/edu/progrm/applcnt/forUpdate.do?prgSn=<c:out value="${result.prgSn}"/>&amp;reqstSn=<c:out value="${result.reqstSn}"/>&amp;menuNo=${param.menuNo}" class="btn_style_0 small">수정</a></p>
							</c:if>

							<c:if test="${result.rceptSttus eq '02'}"> <!-- 신청완료 -->
								<c:if test="${result.prgEnddeEndDt eq FINISH}"> <!-- 교육기간 마감 -->
									<c:if test="${result.ctfhvIssuUseAt eq 'Y'}">
										<c:if test="${result.partcptnComptAt eq '01'}">
											<p class="board_util_btn_con center"><a href="javascript:void(0);" onclick="ctfhvPopup(<c:out value='${result.prgSn}'/>,<c:out value='${result.reqstSn}'/>);" class="btn_style_0 small mt5" title="수료증발급 (새창열림)">수료증발급</a></p>
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
					<td colspan="9">-    검색 결과가 없습니다 -</td>
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
