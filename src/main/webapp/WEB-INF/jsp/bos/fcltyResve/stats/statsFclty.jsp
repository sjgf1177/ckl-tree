<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
//<![CDATA[
var codeIdVal = "<c:out value="${ codeId0 }" />";
var areaSeVal = "<c:out value="${ param.areaSe }" />";
var lcSeVal = "<c:out value="${ param.lcSe }" />";
var fcltySeVal = "<c:out value="${ param.fcltySe }" />";
var spceNmVal = "<c:out value="${ param.spceNm }" />";



$(function(){
	//init
	if (areaSeVal != "") getCodeList("lcSe", codeIdVal, $("#areaSe").val(), 2, lcSeVal);

	$('#tbList').rowspan(0,"총계");
	$('#tbList').rowspan(1,"총계");
	$('#tbList').rowspan(2,"총계");


	//지역선택 event
	$("#areaSe").change(function() {
		getCodeList("lcSe", codeIdVal, $(this).val(), 2);
	});

	//위치선택 event
	$("#lcSe").change(function() {
		getCodeList("fcltySe", codeIdVal, $(this).val(), 3);
	});

	//시설선택 event
	$("#fcltySe").change(function() {
		fnSpceNmList();
	});


	$("#term01Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),1);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#term03Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),3);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#term06Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),6);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#term12Btn").click(function() {
		if ($("#resveSdate").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveSdate").val(),12);
		$("#resveEdate").val(edate);
		return false;
	});

	$("#excelBtn").click(function() {
		$("#statsForm").attr("action","/bos/fcltyResve/stats/downloadExcelStatsFclty.xls");
		$("#statsForm").submit();
		return false;
	});
});

// 공통 코드목록 화면처리
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
			if (depth == 1) $("<option>").text("지역 선택").attr("value","").appendTo($obj);
			else if (depth == 2) $("<option>").text("위치 선택").attr("value","").appendTo($obj);
			else if (depth == 3) $("<option>").text("시설구분").attr("value","").appendTo($obj);
			$.each(data.list, function(key,item) {
				var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
				if (code == item.code) $codeItem.attr("selected",true);
				$codeItem.appendTo($obj);
			});

			if ("lcSe" == elemntId && "" == upperCode) {
				$("<option>").text("시설구분").attr("value","").appendTo($("#fcltySe").empty());
				$("<option>").text("위치 선택").attr("value","").appendTo($("#lcSe").empty());
				$("<option>").text("공간명 선택").attr("value","").appendTo($("#spceNm").empty());
			}
			else if ("fcltySe" == elemntId && "" == upperCode) {
				$("<option>").text("시설구분").attr("value","").appendTo($("#fcltySe").empty());
				$("<option>").text("공간명 선택").attr("value","").appendTo($("#spceNm").empty());
			}
			else if ("lcSe" == elemntId && lcSeVal == code)  {
				getCodeList("fcltySe", codeIdVal, $("#lcSe").val(), 3, fcltySeVal);
			}
			else if ("fcltySe" == elemntId && fcltySeVal == code) {
				$("#fcltySe").find("[value="+fcltySeVal+"]").attr("selected",true);
				fnSpceNmList(spceNmVal);
			}
			else if ("fcltySe" == elemntId) {
				$("<option>").text("공간명 선택").attr("value","").appendTo($("#spceNm").empty());
			}
		}
	},"json");
}

// 공간명 목록
function fnSpceNmList(spceNm) {
	var url = "/bos/fcltyResve/resveSttus/listFcltySpceNm.json";
	var params = {
		areaSe : $("#areaSe").val(),
		lcSe : $("#lcSe").val(),
		fcltySe : $("#fcltySe").val()
	};
	$.get(url, params, function(data) {
		if (data) {
			var $obj = $("#spceNm");
			$obj.empty();
			$("<option>").text("공간명 선택").attr("value","").appendTo($obj);
			$.each(data.resultList, function(key,item) {
				var $item = $("<option>").attr("value", item.spceNm).text(item.spceNm);
				if (spceNm == item.spceNm) $item.attr("selected",true);
				$item.appendTo($obj);
			});
		}
	},"json");
}

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

<!-- 게시판 게시물검색 -->
<form name="statsForm" id="statsForm" method="get" action="/bos/fcltyResve/stats/statsFclty.do">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<div class="sh form-inline pr10">
	<fieldset>
		<legend>시설예약 통계(시간)</legend>
		<div class="shView">
			<table class="table">
				<caption>
				</caption>
				<colgroup>
				<col />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >시설/공간</th>
						<td colspan="3">
							<select name="areaSe" id="areaSe" title="위치를 선택해 주세요.">
								<option value="">지역 선택</option>
								<c:forEach var="item" items="${COM059CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.areaSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							<select name="lcSe" id="lcSe" title="지역을 선택해 주세요.">
								<option value="">위치 선택</option>
							</select>
							<select name="fcltySe" id="fcltySe" title="시설구분을 선택해 주세요.">
								<option value="">시설구분</option>
							</select>
							<select name="spceNm" id="spceNm" title="공간명을 선택해 주세요.">
								<option value="">공간명</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="ageSe">회원구분</label></th>
						<td>
							<select name="ageSe" id="ageSe" title="나이 선택을 선택해 주세요.">
								<option value="">나이선택</option>
								<c:forEach var="item" items="${COM081CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.ageSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							<select name="jobSe" id="jobSe" title="직업을 선택해 주세요.">
								<option value="">직업선택</option>
								<c:forEach var="item" items="${COM056CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.jobSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
							<select name="resdncSe" id="resdncSe" title="거주지역을 선택해 주세요.">
								<option value="">거주지역 선택</option>
								<c:forEach var="item" items="${COM063CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.resdncSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" >예약일자</th>
						<td><input type="text" id="resveSdate" name="resveSdate"  class="sdate" title="예약일자 시작일 입력" style="width:130px" value="<c:out value="${paramVO.resveSdate }" />" readonly="readonly" />
							~
							<input type="text" id="resveEdate" name="resveEdate"  class="edate" title="예약일자 종료일 입력" style="width:130px" value="<c:out value="${paramVO.resveEdate }" />" readonly="readonly" />

							<a class="btn btn-default" href="#self" id="term01Btn"><span>1개월</span></a>
							<a class="btn btn-default" href="#self" id="term03Btn"><span>3개월</span></a>
							<a class="btn btn-default" href="#self" id="term06Btn"><span>6개월</span></a>
							<a class="btn btn-default" href="#self" id="term12Btn"><span>12개월</span></a>

						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</div>
<!-- //게시판 게시물검색 -->


<div class="row clear mt20 tac">
	<div class="col-md-12"><input type="submit" class="btn btn-primary" value="확인" /></div>
</div>
</form>

<div class="row mt10 mb5">
	<fmt:parseDate value="${paramVO.resveSdate}" var="sdateFmt" pattern="yyyy-MM-dd"/>
	<fmt:parseDate value="${paramVO.resveEdate}" var="edateFmt" pattern="yyyy-MM-dd"/>
	<div class="col-md-12"> 기간 : <fmt:formatDate value="${sdateFmt}" pattern="yyyy년 MM월 dd일"/> ~ <fmt:formatDate value="${edateFmt}" pattern="yyyy년 MM월 dd일"/> </div>
</div>

<!-- boardView -->
<div class="bdList">
	<table class="table table-bordered">
		<caption>

		</caption>
		<colgroup>
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		<col />
		</colgroup>
		<thead>
			<tr>
				<th scope="row"  rowspan="2">지역</th>
				<th scope="row"  rowspan="2">위치</th>
				<th scope="row"  rowspan="2">시설구분</th>
				<th scope="row"  rowspan="2">공간명</th>
				<th scope="row"  colspan="6">승인상태</th>
				<th scope="row"  colspan="4">사용여부</th>
			</tr>
			<tr>
				<th scope="row" >승인대기</th>
				<th scope="row" >승인완료</th>
				<th scope="row" >승인불가</th>
				<th scope="row" >대기예약</th>
				<th scope="row" >예약취소</th>
				<th scope="row" >계</th>
				<th scope="row" >사용</th>
				<th scope="row" >미사용</th>
				<th scope="row" >대기</th>
				<th scope="row" >계</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td scope="row"><c:out value="${result.areaSeNm }" /></td>
				<td scope="row"><c:out value="${result.lcSeNm }" /></td>
				<td scope="row"><c:out value="${result.fcltySeNm }" /></td>
				<td scope="row"><c:out value="${result.spceNm }" /></td>
				<td><fmt:formatNumber value="${result.sttus01 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus02 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus04 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus03 }" type="number" /></td>
				<td><fmt:formatNumber value="${result.sttus05 }" type="number" /></td>
				<td><strong><fmt:formatNumber value="${result.sttusall }" type="number" /></strong></td>
				<td><fmt:formatNumber value="${result.useYes }" type="number" /></td>
				<td><fmt:formatNumber value="${result.useNo }" type="number" /></td>
				<td><fmt:formatNumber value="${result.useWait }" type="number" /></td>
				<td><strong><fmt:formatNumber value="${result.sttusall }" type="number" /></strong></td>
			</tr>
		</c:forEach>
		</tbody>
		<!--
		<tfoot>
			<tr>
				<th scope="row"  colspan="4">총계</th>
				<td>202</td>
				<td>285</td>
				<td>17</td>
				<td>25</td>
				<td>20</td>
				<td><strong>549</strong></td>
				<td>265</td>
				<td>15</td>
				<td>10</td>
				<td><strong>285</strong></td>
			</tr>
		</tfoot>
		 -->
	</table>
</div>
<!-- //boardView -->

<div class="btn_set"><a class="btn btn-info" href="#self" id="excelBtn"><span>엑셀로 저장</span></a></div>
