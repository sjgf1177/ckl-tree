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


$(function(){
	//init
	if (areaSeVal != "") getCodeList("lcSe", codeIdVal, $("#areaSe").val(), 2, lcSeVal);

	//지역선택 event
	$("#areaSe").change(function() {
		getCodeList("lcSe", codeIdVal, $(this).val(), 2);
	});

	//위치선택 event
	$("#lcSe").change(function() {
		getCodeList("fcltySe", codeIdVal, $(this).val(), 3);
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
			}
			else if ("fcltySe" == elemntId && "" == upperCode) {
				$("<option>").text("시설구분").attr("value","").appendTo($("#fcltySe").empty());
			}
			if ("lcSe" == elemntId && lcSeVal == code) getCodeList("fcltySe", codeIdVal, $("#lcSe").val(), 3, fcltySeVal);
			else if ("fcltySe" == elemntId && fcltySeVal == code) $("#fcltySe").find("[value="+fcltySeVal+"]").attr("selected",true);
		}
	},"json");
}

//]]>
</script>

<form id="fcltyForm" name="fcltyForm" method="get" action="/bos/hkCultureResve/fclty/list.do">
<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
<fieldset>
	<legend>시설관리 검색</legend>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>시설관리</caption>
			<colgroup>
			<col />
			<col />
			<col />
			<col />
			</colgroup>
				<tbody>
					<tr>
						<th scope="row" >시설정보</th>
						<td colspan="3">
						<select name="areaSe" id="areaSe" title="지역선택">
							<option value="">지역선택</option>
						<c:forEach var="item" items="${COM172CodeList }">
							<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.areaSe }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
						</c:forEach>
						</select>
						<select name="lcSe" id="lcSe" title="위치를 선택해 주세요.">
							<option value="">위치 선택</option>
						</select>
						<select name="fcltySe" id="fcltySe" title="시설구분을 선택해 주세요.">
							<option value="">시설구분</option>
						</select></td>
					</tr>
					<tr>
						<th scope="row" ><label for="spceNm">공간명</label></th>
						<td><input type="text" name="spceNm" id="spceNm" value="<c:out value="${param.spceNm }" />" /></td>
						<th scope="row" ><label for="prpos">용도</label></th>
						<td>
							<input type="text" name="prpos" id="prpos" value="<c:out value="${param.prpos }" />" />
							<input type="submit" class="btn btn-primary" value="검색" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>


<hr />


<div class="row mt10 mb5">
	<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
	<div class="col-md-6 tar">
		<label for="pageUnit">표시수 :</label>
		<select name="pageUnit" id="pageUnit">
			<option value="10" <c:if test="${paramVO.pageUnit eq 10 }">selected="selected"</c:if>>10개</option>
			<option value="20" <c:if test="${paramVO.pageUnit eq 20 }">selected="selected"</c:if>>20개</option>
			<option value="30" <c:if test="${paramVO.pageUnit eq 30 }">selected="selected"</c:if>>30개</option>
			<option value="40" <c:if test="${paramVO.pageUnit eq 40 }">selected="selected"</c:if>>40개</option>
			<option value="50" <c:if test="${paramVO.pageUnit eq 50 }">selected="selected"</c:if>>50개</option>
		</select>
	</div>
</div>
</form>

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
	</colgroup>
		<thead>
			<tr>
				<th scope="row" >번호</th>
				<th scope="row" >위치</th>
				<th scope="row" >시설구분</th>
				<th scope="row" >공간명</th>
				<th scope="row" >예약구분</th>
				<th scope="row" >예약가능여부</th>
				<th scope="row" >상태</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1)) }" /></td>
				<td><c:out value="${result.areaSeNm }" /> / <c:out value="${result.lcSeNm }" /></td>
				<td><c:out value="${result.fcltySeNm }" /></td>
				<td><a href="/bos/hkCultureResve/fclty/view.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;${pageQueryString}"><c:out value="${result.spceNm }" />(<c:out value="${result.spceNmEn }" />)</a></td>
				<td><c:out value="${result.resveSeNm }" /></td>
				<td><c:out value="${result.resvePosblAt eq 'Y' ? '예약가능' : '예약불가' }" /></td>
				<td><c:out value="${result.useAt eq 'Y' ? '사용' : '미사용' }" /></td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td colspan="7">- 검색 결과가 없습니다 -</td></tr>
		</c:if>
		</tbody>
	</table>
</div>




<div class="btn_set"><a class="btn btn-primary" href="/bos/hkCultureResve/fclty/forInsert.do?${pageQueryString}"><span>등록</span></a></div>


<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->




</form>