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

	var confmSttusPopup = $("#confmSttusPopup").dialog({
		autoOpen: false,
	  	height: "auto",
	  	width: "800",
	  	modal: true,
	  	position : {
  			my : "center center",
  			at : "center center",
  			of : $("body"),
  			within : $("body")
  		}
	});

	var partcptnComptPopup = $("#partcptnComptPopup").dialog({
		autoOpen: false,
	  	height: "auto",
	  	width: "800",
	  	modal: true,
	  	position : {
  			my : "center center",
  			at : "center center",
  			of : $("body"),
  			within : $("body")
  		}
	});

	$("#confmSttusPopupBtn").click(function() {
	    var userSnData = $(":input[name=userSnData]:checkbox:checked");
    	if (userSnData.length == 0) {
			alert("신청자를 선택하신 후 클랙해 주세요.");
			return false;
		}
    	var returnValue = [];
   		$("#userSnArr").val("");

    	for (var i=0; i<userSnData.length; i++) {
    		returnValue.push(userSnData[i].value);
    		$("#userSnArr").val(returnValue);
    	}
	  	var params = {viewType : "CONTBODY", prgSn : "${result.prgSn}"};
	  	//var frm = $("#frm").serialize();
	  	$( "#confmSttusPopup" ).load("/bos/progrm/applcnt/confmSttusPopup.do", params, function() {
	  		$( "#confmSttusPopupCont").empty();
	  		confmSttusPopup.dialog("open");
	  	});
	  	return false;
  	});

	$("#partcptnComptPopupBtn").click(function() {
	    var userSnData = $(":input[name=userSnData]:checkbox:checked");
    	if (userSnData.length == 0) {
			alert("신청자를 선택하신 후 클랙해 주세요.");
			return false;
		}
    	var returnValue = [];
   		$("#userSnArr").val("");

    	for (var i=0; i<userSnData.length; i++) {
    		returnValue.push(userSnData[i].value);
    		$("#userSnArr").val(returnValue);
    	}
	  	var params = {viewType : "CONTBODY", prgSn : "${result.prgSn}"};
	  	$( "#partcptnComptPopup" ).load("/bos/progrm/applcnt/partcptnComptPopup.do", params, function() {
	  		$( "#partcptnComptPopupCont").empty();
	  		partcptnComptPopup.dialog("open");
	  	});
	  	return false;
  	});

	$("#excelBtn").click(function() {
		if ($("input[name=userSnData]:checked").size() == 0) {
			alert("항목을 선택해 주세요.");
			return false;
		}
		if (!confirm("선택된 신청정보를 엑셀로 저장하시겠습니까?")) {
			return false;
		}

		$("#excelTp").val("");
		$("#frm").attr("action","/bos/progrm/applcnt/downloadExcel.xls");
		$("#frm").submit();
		$("#frm").attr("action","/bos/progrm/applcnt/list.do?menuNo=${param.menuNo}");
		return false;
	});

	$("#excelAllBtn").click(function() {
		if (!confirm("조회된 신청정보 전체를 엑셀로 저장하시겠습니까?")) {
			return false;
		}

		$("#excelTp").val("ALL");
		$("#frm").attr("action","/bos/progrm/applcnt/downloadExcel.xls");
		$("#frm").submit();
		$("#frm").attr("action","/bos/progrm/applcnt/list.do?menuNo=${param.menuNo}");
		return false;
	});

	$("#atchFileBtn").click(function() {
		if ($("input[name=userSnData]:checked").size() == 0) {
			alert("항목을 선택해 주세요.");
			return false;
		}
		if (!confirm("선택된 신청정보 첨부파일을 저장하시겠습니까?")) {
			return false;
		}

		$("#atchFileTp").val("");
		$("#frm").attr("action","/bos/progrm/applcnt/downloadFile.do");
		$("#frm").submit();
		$("#frm").attr("action","/bos/progrm/applcnt/list.do?menuNo=${param.menuNo}");
		return false;
	});

	$("#atchFileAllBtn").click(function() {
		if (!confirm("조회된 신청정보 전체 첨부파일을 저장하시겠습니까?")) {
			return false;
		}

		$("#atchFileTp").val("ALL");
		$("#frm").attr("action","/bos/progrm/applcnt/downloadFile.do");
		$("#frm").submit();
		$("#frm").attr("action","/bos/progrm/applcnt/list.do?menuNo=${param.menuNo}");
		return false;
	});

	$("#smsSndngBtn").click(function() {
		var params = $("#frm").serialize();
		window.open("/bos/progrm/applcnt/smsSndngPopup.do?viewType=BODY&"+params, "smsSndngPopup", "width=500px, height=380px, scrollbars=no");
  	});

	$("#printPopupBtn").click(function() {
		if ($("input[name=userSnData]:checked").size() == 0) {
			alert("항목을 선택해 주세요.");
			return false;
		}
		$("#atchFileTp").val("");

		var params = $("#frm").serialize();
		window.open("/bos/progrm/applcnt/listPrintPopup.do?viewType=BODY&"+params, "listPrntPopup", "width=800px, height=800px, scrollbars=yes");
	});

	$("#printPopupAllBtn").click(function() {
		$("#atchFileTp").val("ALL");

		var params = $("#frm").serialize();
		window.open("/bos/progrm/applcnt/listPrintPopup.do?viewType=BODY&"+params, "listPrntPopup", "width=800px, height=800px, scrollbars=yes");
		return false;
	});

	$("#chkAll").click(function(){
		if (this.checked) {
			$(":checkbox").prop("checked", true);
		}
		else {
			$(":checkbox").prop("checked", false);
		}
	});

	$("#bdList th").click(function(){
		var v_id = $(this).attr("id");
		var v_sort = "";
		
		if(v_id == "" || v_id == null){
			return;
		}
		
		if($("#pid").val() != $(this).attr("id")){
			v_sort = "";
			
		} else {
			v_sort = $("#pSort").val();
		}
		
		$("#pid").val(v_id);
		
		if(v_sort == "" || v_sort == "A"){
			v_sort = "D";
		} else if(v_sort == "D"){
			v_sort = "A";
		}
		
		$("#pSort").val(v_sort);
		
		document.frm.submit();
		
	});
	
	$("#searchBtn").click(function(){
		$("#pid").val("");		
		$("#pSort").val("");
		
		document.frm.submit();
		
	});
	
	var rPid = '${param.pid}';
	var rPsort = '${param.pSort}';
	var thTitle = "";
	
	if(rPid != "" || rPid != null){
		thTitle = $("#" + rPid).text();
		
		if(rPsort == "D"){
			$("#" + rPid).text(thTitle + "  ▼");
		} else if(rPsort == "A"){
			$("#" + rPid).text(thTitle + "  ▲");
		}
	}

});

</script>

<div id="confmSttusPopup" title="승인상태변경">
	<div id="confmSttusPopupCont"></div>
</div>
<div id="partcptnComptPopup" title="참여여부변경">
	<div id="partcptnComptPopupCont"></div>
</div>

<h4>프로그램정보 및 신청현황</h4>
	<div class="bdView mb5">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col  span="3" />
			<col  />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">구분/분류</th>
					<td>${masterResult.prgSeNm} ${empty masterResult.prgClNm ? '' : '/'} ${masterResult.prgClNm}</td>
					<th scope="row">프로그램명</th>
					<td>${masterResult.prgNm}</td>
				</tr>
				<tr>
					<th scope="row">담당부서</th>
					<td>
						${masterResult.deptNmKor}
						<input type="hidden" name="telNo" id="telNo" value="${masterResult.telNo}">
					</td>
					<th scope="row">진행상태</th>
					<td>
						<c:choose>
							<c:when test="${result.progrsSttus eq WAITING}">대기</c:when>
							<c:when test="${result.progrsSttus eq PROGRESS}">진행</c:when>
							<c:when test="${result.progrsSttus eq FINISH_PSNCPA}">진행</c:when>
							<c:when test="${result.progrsSttus eq FINISH}">마감</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row">신청방식</th>
					<td>${masterResult.reqstMthdNm}</td>
					<th scope="row">신청현황(정원/신청/대기정원/신청)</th>
					<td>
						<c:choose>
							<c:when test="${masterResult.reqstMthd eq '01'}">${masterResult.psncpa} /</c:when>
							<c:otherwise>- /</c:otherwise>
						</c:choose>
						${masterResult.totCnt02}
						<c:choose>
							<c:when test="${masterResult.waitReqstAt eq 'Y'}">/ ${masterResult.waitReqstNmpr} / ${masterResult.totCnt01}</c:when>
							<c:otherwise>/ - / -</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="bdList">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col  span="3" />
			<col  />
			<col  />
			<col  />
			<col  span="8" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="3">신청자수</th>
					<th scope="col" colspan="3">상태</th>
					<th scope="col" colspan="6">회원구분</th>
				</tr>
				<tr>
					<th scope="col" rowspan="2">신청완료</th>
					<th scope="col" rowspan="2">취소</th>
					<th scope="col" rowspan="2">대기신청</th>
					<th scope="col" colspan="2">성별</th>
					<th scope="col" colspan="4">나이</th>
				</tr>
				<tr>
					<th scope="row">남</th>
					<th scope="row">여</th>
					<th scope="row">20대</th>
					<th scope="row">30대</th>
					<th scope="row">40대</th>
					<th scope="row">50대</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${stats.totCnt}</td>
					<td>${stats.rceptSttus02Cnt}</td>
					<td>${stats.rceptSttus03Cnt}</td>
					<td>${stats.rceptSttus01Cnt}</td>
					<td>${stats.sexMCnt}</td>
					<td>${stats.sexWCnt}</td>
					<td>${stats.age20Cnt}</td>
					<td>${stats.age30Cnt}</td>
					<td>${stats.age40Cnt}</td>
					<td>${stats.age50Cnt}</td>
				</tr>
			</tbody>
		</table>
	</div>

<h4>신청자 검색</h4>
<form id="frm" name="frm" method="post" action="/bos/progrm/applcnt/list.do?menuNo=${param.menuNo}" class="form-inline">
	<input type="hidden" name="prgSn" value="${result.prgSn}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" name="userSnArr" id="userSnArr">
	<input type="hidden" name="excelTp" id="excelTp" value="" />
	<input type="hidden" name="atchFileTp" id="atchFileTp" value="" />
	<input type="" name="pid" id="pid" value="${param.pid}" />
	<input type="" name="pSort" id="pSort" value="${param.pSort}" />

	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col  span="3" />
			<col  />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="userId">아이디</label></th>
					<td><input type="text" name="userId" id="userId" value="${param.userId}" /></td>
					<th scope="row"><label for="nm">이름</label></th>
					<td><input type="text" name="nm" id="nm" value="${param.nm}" /></td>
				</tr>
				<tr>
					<!-- <th scope="row">회원여부</th>
					<td><label for="MGPS_0"><input type="radio" name="MGPS" value="라디오" id="MGPS_0" /> 전체 </label>
						<label for="MGPS_1"><input type="radio" name="MGPS" value="라디오" id="MGPS_1" /> 회원 </label>
						<label for="MGPS_2"><input type="radio" name="MGPS" value="라디오" id="MGPS_2" /> 비회원 </label></td> -->
					<th scope="row"><label for="rceptSttus">상태</label></th>
					<td ${masterResult.confmStepAt eq 'Y' ? '' : 'colspan=3'}>
						<select name="rceptSttus" id="rceptSttus" title="상태를 선택해 주세요.">
							<option value="">상태 선택</option>
						<c:forEach var="code" items="${COM055CodeList}" varStatus="status">
							<option value="${code.code}" <c:if test="${param.rceptSttus eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
						</c:forEach>
						</select>
					</td>
				<c:if test="${masterResult.confmStepAt eq 'Y'}">
					<th scope="row"><label for="confmSttus">승인상태</label></th>
					<td>
						<select name="confmSttus" id="confmSttus" title="승인상태를 선택해 주세요.">
							<option value="">상태 선택</option>
						<c:forEach var="code" items="${COM054CodeList}" varStatus="status">
							<option value="${code.code}" <c:if test="${param.confmSttus eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
						</c:forEach>
						</select>
					</td>					
				</c:if>
				</tr>
				<tr>
				<c:if test="${masterResult.sexUseAt eq 'Y'}">
					<th scope="row"><label for="sex">성별</label></th>
					<td>
						<select name="sex" id="sex" title="성별을 선택해 주세요.">
							<option value="">성별 선택</option>
							<option value="M" <c:if test="${param.sex eq 'M'}">selected="selected"</c:if>>남</option>
							<option value="W" <c:if test="${param.sex eq 'W'}">selected="selected"</c:if>>여</option>
						</select>
					</td>
				</c:if>		
					<th scope="row"><label for="partcptnComptAt">참여여부</label></th>
					<td>
						<select name="partcptnComptAt" id="partcptnComptAt" title="참여여부를 선택해 주세요.">
							<option value="">참여여부 선택</option>
							<option value="01" <c:if test="${param.partcptnComptAt eq '01'}">selected="selected"</c:if>>참여</option>
							<option value="02" <c:if test="${param.partcptnComptAt eq '02'}">selected="selected"</c:if>>미참여</option>
						</select>
					<input type="button" id="searchBtn" class="btn btn-primary fr" value="검색" />
					</td>		
				</tr>
			</tbody>
		</table>
	</div>

	<div class="row mt10 mb5">
		<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt}" /></strong>건 | <strong class="text-danger"><c:out value="${param.pageIndex}" /> / <c:out value="${totalPage}" /></strong> Page</div>
		<div class="col-md-6 tar">
			<label for="pageUnit">표시수 :</label>
			<select name="pageUnit" id="pageUnit">
				<option value="10" <c:if test="${param.pageUnit eq 10}">selected="selected"</c:if>>10개</option>
				<option value="20" <c:if test="${param.pageUnit eq 20}">selected="selected"</c:if>>20개</option>
				<option value="30" <c:if test="${param.pageUnit eq 30}">selected="selected"</c:if>>30개</option>
				<option value="50" <c:if test="${param.pageUnit eq 50}">selected="selected"</c:if>>50개</option>
			</select>
		</div>
	</div>

	<div class="bdList">
		<table class="table table-bordered" id="bdList">
			<caption>
			</caption>
			<colgroup>
			<col  span="3" />
			<col  />
			<col  />
			<col  />
			<col  span="5" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="chkAll" id="chkAll" /></th>
					<th scope="col" id="bd_resveNo">번호</th>
					<th scope="col" id="bd_userId">아이디</th>
				<c:if test="${masterResult.nmUseAt eq 'Y'}">
					<th scope="col" id="bd_nm">이름</th>
				</c:if>
				<c:if test="${masterResult.sexUseAt eq 'Y'}">
					<th scope="col" id="bd_sex">성별</th>
				</c:if>
				<c:if test="${masterResult.brthdyUseAt eq 'Y'}">
					<th scope="col" id="bd_brthdy">생년월일</th>
				</c:if>
					<th scope="col" id="bd_rDt">신청/접수일시</th>
					<th scope="col" id="bd_rceptSttusNm">상태</th>
					<th scope="col" id="bd_cDt">취소일시</th>
				<c:if test="${masterResult.confmStepAt eq 'Y'}">
					<th scope="col" id="bd_confmSttusNm">승인상태</th>
				</c:if>
					<th scope="col" id="bd_partcptnComptAt">참여여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><input type="checkbox" name="userSnData" id="userSnData_${result.reqstSn}" value="${result.reqstSn}"  title="선택${result.reqstSn}" /></td>
						<td>${result.resveNo}</td>
						<td><a href="/bos/progrm/applcnt/view.do?prgSn=${result.prgSn}&reqstSn=${result.reqstSn}&menuNo=${param.menuNo}&siteSe=${param.siteSe}">${result.userId}</a></td>
					<c:if test="${masterResult.nmUseAt eq 'Y'}">
						<td>${result.nm}</td>
					</c:if>
					<c:if test="${masterResult.sexUseAt eq 'Y'}">
						<td>${result.sex eq 'M' ? '남' : '여'}</td>
					</c:if>
					<c:if test="${masterResult.brthdyUseAt eq 'Y'}">
						<td>${result.brthdy}</td>
					</c:if>
						<td>${result.rDt}</td>
						<td>${result.rceptSttusNm}</td>
						<td>${empty result.cDt ? '-' : result.cDt}</td>
					<c:if test="${masterResult.confmStepAt eq 'Y'}">
						<td>${result.confmSttusNm}</td>
					</c:if>
						<td>${result.partcptnComptAt eq '01' ? '●' : 'X'}</td>
					</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>

				<tr>
					<td colspan="11">
						<a class="btn btn-info" href="#" id="excelBtn"><span>선택 엑셀로 저장</span></a>
						<a class="btn btn-default" href="#" id="atchFileBtn"><span>선택 첨부파일 다운로드</span></a>
					<c:if test="${masterResult.confmStepAt eq 'Y'}">
						<a class="btn btn-default" href="#" id="confmSttusPopupBtn"><span>선택 승인상태변경</span></a>
					</c:if>
						<a class="btn btn-default" href="#" id="partcptnComptPopupBtn"><span>선택 참여여부변경</span></a>
						<a class="btn btn-default" href="#" id="printPopupBtn"><span>선택 출력하기</span></a>
						<c:if test="${fn:length(resultList) == 0}" >- 검색 결과가 없습니다 -</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

	<div class="btn_set">
		<a class="btn btn-info" href="#self" id="excelAllBtn"><span>전체 엑셀로 저장</span></a>
		<!--
		<a class="btn btn-primary" href="#self" id="atchFileAllBtn"><span>전체 첨부파일 다운로드</span></a>
		 -->
		<c:if test="${result.prgCl eq 19}">
			<a href="/bos/progrm/master/forUpdate.do?${pageQueryString}" class="btn btn-primary">수정</a>
			<a class="btn btn-primary" href="/bos/progrm/master/regTmplat.do?${pageQueryString}">탬플릿수정</a>
		</c:if>
		<a class="btn btn-inverse" href="#self" id="smsSndngBtn"><span>전체 SMS발송</span></a>
		<a class="btn btn-default" href="#self" id="printPopupAllBtn"><span>전체 출력하기</span></a>
		<c:if test="${result.prgCl ne 19}">
			<a class="btn btn-primary" href="/bos/progrm/master/list.do?menuNo=${param.menuNo}&${pageQueryString}"><span>목록</span></a>
		</c:if>
	</div>

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		<div class="paginationSet">
			${pageNav}
		</div>
	</div>
</c:if>