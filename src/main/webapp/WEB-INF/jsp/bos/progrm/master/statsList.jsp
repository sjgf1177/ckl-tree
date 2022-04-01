<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

var codeIdVal = "COM050";
var prgSeVal = "<c:out value='${param.prgSe}'/>";
var prgClVal = "<c:out value='${param.prgCl}'/>";
var prgYearVal = "<c:out value='${param.prgYear}'/>";

$(function() {

/* 	if (prgSeVal != "") getCodeList("prgCl", codeIdVal, $("#prgSe").val(), 2, prgClVal);

	$("select[name=prgSe]").change(function(){
		var val = $(this).val();
		getCodeList("prgCl", codeIdVal, val, 2);
		getPrgNmList(val, '');
	});
*/

	getPrgYearList(prgClVal); 
	
	if (prgYearVal != "" || prgClVal != "") {
		getPrgNmList(prgSeVal, prgClVal, prgYearVal);
	}

	$("select[name=prgCl]").change(function(){
		getPrgYearList($(this).val());
		
		if(prgClVal == $(this).val()){
			getPrgNmList(prgSeVal, $(this).val(), prgYearVal);
		}else{
			getPrgNmList(prgSeVal, $(this).val(), '');
		}
		
	});
	
	$("select[name=prgYear]").change(function(){
		getPrgNmList(prgSeVal, $("#prgCl").val(), $(this).val());
	});

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
				$("<option>").text("프로그램 선택").attr("value","").appendTo($("#prgNm").empty());
			}
			getPrgNmList(prgSeVal, prgClVal);
		}
	},"json");
}

function getPrgYearList(prgCl) {
	var url = "/bos/progrm/master/prgYearList.json";
	var params = {prgCl : prgCl};
	
	$.get(url, params, function(data) {
		if (data) {
			var $obj = $("#prgYear");
			$obj.empty();
			$("<option>").text("프로그램년도 선택").attr("value","").appendTo($obj);
			$.each(data.prgYearList, function(key,item) {
				var $item = $("<option>").attr("value", item.prgYear).text(item.prgYear);
				
				if('${param.prgCl}' == prgCl){
					if ('${param.prgYear}' == item.prgYear) $item.attr("selected",true);
				}
				
				$item.appendTo($obj);
			});
		}
	},"json");
}

function getPrgNmList(prgSe, prgCl, prgYear) {
	var url = "/bos/progrm/master/prgNmList.json";
	var params = {prgSe : prgSe, prgCl : prgCl, siteSe : '${param.siteSe}', viewType : 'CONTBODY', prgYear : prgYear};
	$.get(url, params, function(data) {
		if (data) {
			var $obj = $("#prgSn");
			$obj.empty();
			$("<option>").text("프로그램명 선택").attr("value","").appendTo($obj);
			$.each(data.prgNmList, function(key,item) {
				var $item = $("<option>").attr("value", item.prgSn).text(item.prgNm);
				if ('${param.prgSn}' == item.prgSn) $item.attr("selected",true);
				$item.appendTo($obj);
			});
		}
	},"json");
}

//상세 팝업
function fnApplcntPopup(prgSn) {
	window.open("/bos/progrm/applcnt/listPopup.do?viewType=BODY&prgSn="+prgSn, "listPopup", "width=1030px, height=670px, scrollbars=no");
}

</script>

<form id="frm" name="frm" method="post" action="/bos/progrm/master/statsList.do?menuNo=${param.menuNo}" class="form-inline">
	<input type="hidden" name="siteSe" value="${param.siteSe}" >
	<fieldset>
		<legend>프로그램 운영 통계 검색 화면</legend>
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
						<th scope="row"><label for="deptId">부서선택</label></th>
						<td colspan="3" >
							<select id="deptId" name="deptId" title="담당부서">
							    <option value="">부서 선택</option>
							<c:forEach var="dept" items="${deptList}" varStatus="status">
								<option value="${dept.deptId}" <c:if test="${param.deptId eq dept.deptId}">selected="selected"</c:if>>${dept.deptNmKor}[${dept.deptNmEng}]</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="prgSe">프로그램선택</label></th>
						<td colspan="3" >
							<input type="hidden" name="prgSe" value="${paramVO.prgSe}" />
							<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
								<c:if test="${paramVO.prgSe eq code.code}">${code.codeNm}</c:if>
							</c:forEach>
							<select name="prgCl" id="prgCl" title="분류" >
								<option value="">분류 선택</option>
								<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
									<c:if test="${paramVO.prgSe eq code.upperCode}">
										<option value="${code.code}" <c:if test="${paramVO.prgCl eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
									</c:if>
								 </c:forEach>
							</select>
							<select name="prgYear" id="prgYear" title="프로그램년도 선택">
								<option value="">프로그램년도 선택</option>
							</select>							
							<select name="prgSn" id="prgSn" title="프로그램명 선택">
								<option value="">프로그램명 선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">성별</th>
						<td>
							<label for="sex0"><input type="radio" name="sex" value="" id="sex0" <c:if test="${empty param.sex}">checked="checked"</c:if>/> 전체 </label>
							<label for="sex1"><input type="radio" name="sex" value="M" id="sex1" <c:if test="${param.sex eq 'M'}">checked="checked"</c:if>/> 남  </label>
							<label for="sex2"><input type="radio" name="sex" value="W" id="sex2" <c:if test="${param.sex eq 'W'}">checked="checked"</c:if>/> 여 </label>
						</td>
						<th scope="row">나이</th>
						<td>
							<select name="age" id="age" title="나이를 선택해 주세요.">
								<option value="">나이선택</option>
								<option value="20" <c:if test="${param.age eq '20'}">selected="selected"</c:if>>20대</option>
								<option value="30" <c:if test="${param.age eq '30'}">selected="selected"</c:if>>30대</option>
								<option value="40" <c:if test="${param.age eq '40'}">selected="selected"</c:if>>40대</option>
								<option value="50" <c:if test="${param.age eq '50'}">selected="selected"</c:if>>50대</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btnSet">
			<input type="submit" class="btn btn-primary" value="검색" />
			<a class="btn btn-info" href="/bos/progrm/master/downloadExcelStats.xls?${pageQueryString}"><span>엑셀저장</span></a>
		</div>	
	</fieldset>
</form>

<div class="tbrinfo text-danger clear" style="float:left;">※ 인원단위(대상 / 참여)</div>
<div class="bdView">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col  span="3" />
		<col  />
		<col  />
		<col  />
		<col  span="10" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="3">구분</th>
				<th scope="col" rowspan="3">분류　</th>
				<th scope="col" rowspan="3">프로그램명</th>
				<th scope="col" rowspan="3">만족도점수　</th>
				<th scope="col" rowspan="3">신청자수</th>
				<th scope="col" colspan="3">상태</th>
				<th scope="col" colspan="6">회원구분</th>
			</tr>
			<tr>
				<th scope="col" rowspan="2">신청<br />완료</th>
				<th scope="col" rowspan="2">취소</th>
				<th scope="col" rowspan="2">대기신청</th>
				<th scope="col" colspan="2">성별</th>
				<th scope="col" colspan="4">나이</th>
			</tr>
			<tr>
				<th scope="col">남</th>
				<th scope="col">여</th>
				<th scope="col">20대</th>
				<th scope="col">30대</th>
				<th scope="col">40대</th>
				<th scope="col">50대</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${result.prgSeNm}</td>
					<td>${result.prgClNm}</td>
					<td><a href="javascript:fnApplcntPopup('${result.prgSn}');" >${result.prgNm}</a></td>
					<td>${result.stsfdgScore}</td>
					<td>${result.totCnt}(${result.totCnt2})</td>
					<td>${result.rceptSttus02Cnt}(${result.rceptSttus02Cnt2})</td>
					<td>${result.rceptSttus03Cnt}(${result.rceptSttus03Cnt2})</td>
					<td>${result.rceptSttus01Cnt}(${result.rceptSttus01Cnt2})</td>
					<td>${result.sexMCnt}(${result.sexMCnt2})</td>
					<td>${result.sexWCnt}(${result.sexWCnt2})</td>
					<td>${result.age20Cnt}(${result.age20Cnt2})</td>
					<td>${result.age30Cnt}(${result.age30Cnt2})</td>
					<td>${result.age40Cnt}(${result.age40Cnt2})</td>
					<td>${result.age50Cnt}(${result.age50Cnt2})</td>
				</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}" >
				<tr><td colspan="14">데이터가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>