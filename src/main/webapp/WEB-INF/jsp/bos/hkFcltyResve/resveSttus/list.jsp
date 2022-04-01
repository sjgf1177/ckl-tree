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


	$("#excelDownBtn").click(function() {

		if (confirm("엑셀을 다운로드 하시겠습니까?")) {
			$("#resveSttusForm").attr("action","/bos/hkFcltyResve/resveSttus/downloadExcel.xls");
			$("#resveSttusForm").submit();
			$("#resveSttusForm").attr("action","/bos/hkFcltyResve/resveSttus/list.do");
		}
		return false;

	});
	
	$("#useAt_chg_exec").click(function() {

		if($("#useAt_chg").val()==''){
			alert("변경 할 값을 선택해 주세요.");
			return false; 
		}
		
		var resveSn_list='';
		$("input[name=idx]:checked").each(function(){
			if(resveSn_list==''){
				resveSn_list=$(this).val();
			}else{
				resveSn_list+=","+$(this).val();
			}
		});
		
		var url = "/bos/hkFcltyResve/resveSttus/chgResveSn.json";
		var params = {
				resveSn : resveSn_list,
				useAt : $("#useAt_chg").val()
			};
		
		$.get(url, params, function(data) {
			if (data.resultCode == "success") {
				alert("사용여부 처리가 완료되었습니다.");
				location.reload();
			}
			else {
				alert("사용여부 처리가 실패했습니다.");
			}
		},"json");
	
		
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
			else if ("lcSe" == elemntId && lcSeVal == code) {
				getCodeList("fcltySe", codeIdVal, $("#lcSe").val(), 3, fcltySeVal);
			}
			else if ("fcltySe" == elemntId && fcltySeVal == code) {
				$("#fcltySe").find("[value="+fcltySeVal+"]").attr("selected",true);
				$("<option>").text("공간명 선택").attr("value","").appendTo($("#spceNm").empty());
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
	var url = "/bos/hkFcltyResve/resveSttus/listFcltySpceNm.json";
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

//]]>
</script>

<form id="resveSttusForm" name="resveSttusForm" method="get" action="/bos/hkFcltyResve/resveSttus/list.do">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<!-- 게시판 게시물검색 start -->
<div class="sh form-inline pr10">
	<fieldset>
		<legend>예약현황 검색</legend>
		<div class="shView">
			<table class="table">
				<caption>
				</caption>
				<colgroup>
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" >시설/공간</th>
						<td colspan="3">
							<select name="areaSe" id="areaSe" title="위치를 선택해 주세요.">
								<option value="">지역 선택</option>
								<c:forEach var="item" items="${COM144CodeList }">
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
							</select></td>
						<th scope="row" ><label for="장비명">장비명</label></th>
						<td>
							<select name="eqpmnSn" id="eqpmnSn" title="장비명을 선택해 주세요.">
								<option value="">장비명 선택</option>
								<c:forEach var="item" items="${listEqpmnNm }">
									<option value="<c:out value="${item.eqpmnSn }" />" <c:if test="${item.eqpmnSn eq param.eqpmnSn }">selected="selected"</c:if>><c:out value="${item.eqpmnNm }" /></option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="resveNo">예약번호</label></th>
						<td><input type="text" name="resveNo" id="resveNo" value="<c:out value="${param.resveNo }" />" /></td>
						<th scope="row"><label for="resveNm">이름</label></th>
						<td><input type="text" name="resveNm" id="resveNm" value="<c:out value="${param.resveNm }" />" /></td>
						<th scope="row" ><label for="mbtlnum">휴대폰번호</label></th>
						<td><input type="text" name="mbtlnum" id="mbtlnum" value="<c:out value="${param.mbtlnum }" />" /></td>
					</tr>
					<tr>
						<th scope="row" >예약일자</th>
						<td colspan="3"><input type="text" id="resveStDt" name="resveStDt"  class="sdate" title="예약일자 시작일 입력" style="width:130px" value="<c:out value="${param.resveStDt }" />" />
							~
							<input type="text" id="resveEdDt" name="resveEdDt"  class="edate" title="예약일자 종료일 입력" style="width:130px" value="<c:out value="${param.resveEdDt }" />" /></td>
						<th scope="row"><label for="resveBeginTime">예약시간</label></th>
						<td><input type="text" name="resveBeginTime" id="resveBeginTime" title="예약 시작 시간을 입력하세요." style="width:60px" value="<c:out value="${param.resveBeginTime }" />" />
							시 ~  
							<input type="text" name="resveEndTime" id="resveEndTime" title="예약 종료 시간을 입력하세요." style="width:60px" value="<c:out value="${param.resveEndTime }" />" />
							시</td>
					</tr>
					<tr>
						<th scope="row" ><label for="resveSttus">승인상태</label></th>
						<td>

							<select name="resveSttus" id="resveSttus">
								<option value="">상태선택</option>
								<c:forEach var="item" items="${COM071CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.resveSttus }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
						</td>
						<th><label for="useAt">사용여부</label></th>
						<td colspan="2">
							<select name="useAt" id="useAt">
								<option value="">선택</option>
								<c:forEach var="item" items="${COM073CodeList }">
									<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.useAt }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
								</c:forEach>
							</select>
						</td>
						<td class="tar"><input type="submit" class="btn btn-primary" value="검색" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</div>


<!-- 게시판 게시물검색 end -->

<div class="row mt10 mb5">
	<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
	<div class="col-md-6 tar">
		<span style="margin-right: 50px;">
		사용여부를 &nbsp;
		<select name="useAt_chg" id="useAt_chg">
			<option value="">선택</option>
			<c:forEach var="item" items="${COM073CodeList }">
				<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.useAt }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
			</c:forEach>
		</select>
		로
		<input type="button" class="btn" id="useAt_chg_exec" value="변경"> 
		</span>
		<label for="SELC">표시수 :</label>
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

<!-- boardView -->
<div>
	<table class="table table-bordered table-striped table-hover">
		<caption>
		</caption>
		<colgroup>
		<col style="width:50px" />
		<col style="width:70px" />
		<col style="width:90px"/>
		<col style="width:80px" />
		<col />
		<col style="width:120px"/>
		<col style="width:60px" />
		<col style="width:95px" />
		<col style="width:80px" />
		<col style="width:70px" />
		<col style="width:70px" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col" >예약 번호</th>
				<th scope="col">위치</th>
				<th scope="col">시설구분</th>
				<th scope="col">공간명</th>
				<th scope="col">장비</th>
				<th scope="col">이름</th>
				<th scope="col">예약일자</th>
				<th scope="col">예약시간</th>
				<th scope="col">승인상태</th>
				<th scope="col">사용여부</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${(resultCnt) - (paramVO.pageUnit * (paramVO.pageIndex-1)) }" /></td>
				<td><c:out value="${result.resveNo }" /></td>
				<td><c:out value="${result.areaSeNm }" /> / <c:out value="${result.lcSeNm }" /></td>
				<td><c:out value="${result.fcltySeNm }" /></td>
				<td><a href="/bos/hkFcltyResve/resveSttus/view.do?resveSn=<c:out value="${result.resveSn }" />&amp;${pageQueryString}"><c:out value="${result.spceNm }" /> <c:if test="${not empty result.spceNmEn }"></c:if></a></td>
				<td><c:out value="${result.eqpmnNms }" /></td>
				<td><c:out value="${result.resveNm }" /></td>
				<td><c:out value="${result.resveDt }" /></td>
				<td><c:out value="${result.resveBeginTime }" />시~<c:out value="${result.resveEndTime }" />시</td>
				<td>
				<c:if test="${result.resveSttus ne '03' }">
					<c:out value="${result.resveSttusNm }" />
				</c:if>
				<c:if test="${result.resveSttus eq '03' }">
					<span style="color:red;"><c:out value="${result.resveSttusNm }" /></span>
				</c:if>
				</td>
				<td><input type="checkbox" name="idx" value="${result.resveSn }"><c:out value="${result.useAtNm }" /> </td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr><td colspan="11" class="tac">- 검색 결과가 없습니다 -</td></tr>
		</c:if>
		</tbody>
	</table>
</div>
<!-- //boardView -->

<div class="btn_set"><a class="btn btn-info" href="#self" id="excelDownBtn"><span>엑셀로 저장</span></a>
<!--
<a class="btn btn-primary" href="/bos/hkFcltyResve/resveSttus/resveStep1.do?menuNo=<c:out value="${param.menuNo }" />"><span>예약하기</span></a>
 -->
 </div>

<!-- board list end //-->

<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>

