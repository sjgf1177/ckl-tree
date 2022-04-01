<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
$(function(){
	$("#term01Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveStDt").val(),1);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#term03Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveStDt").val(),3);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#term06Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveStDt").val(),6);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#term12Btn").click(function() {
		if ($("#resveStDt").val() == "") {
			alert("예약시작일자를 선택해 주세요.");
			return false;
		}
		var edate = fnAddCalMonth($("#resveStDt").val(),12);
		$("#resveEdDt").val(edate);
		return false;
	});

	$("#submitBtn2").click(function() {
		$("#submitBtn").click();
		return false;
	});

	$(".resveCancelBtn").click(function() {
		if (confirm("예약을 취소하시겠습니까?")) {
			var url = "/<c:out value="${paramVO.siteName}" />/hkFcltyResve/resveSttus/cancelResveSttus.json";
			var params = {
				resveSn : $(this).closest("tr").find("input[name=resveSn]").val()
			};
			$.post(url, params, function(data) {
				if (data.resultCode == "success") {
					alert("예약취소가 완료되었습니다.");
					window.location.reload();
				}
				else {
					alert("예약취소가 싶패하였습니다.");
				}
			},"json");
		}
		return false;
	});
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

<style>
.pagination li.active{
	z-index: auto;
}
.calendarzone .calendar-frame{
	height: 290px;
}
@media (max-width: 992px) {
	.classview{
		display: none;
	}
}
</style>



<form id="resveSttusForm" name="resveSttusForm" method="get" class="form-inline" action="/<c:out value="${paramVO.siteName }" />/hkFcltyResve/resveSttus/listMypage.do">
<input type="hidden" name="menuNo" value="<c:out value="${paramVO.menuNo }" />" />
<div class="tal alert formLine1 program_design_box" style="margin-bottom: 10px;">
		<fieldset>
			<legend>예약신청현황 검색</legend>
			<div class="clearfix">
			<span class="show mr50 board_util_btn_con">
				<a href="#self" class="btn_style_0 small empty" id="term01Btn">1개월</a>
				<a href="#self" class="btn_style_0 small empty" id="term03Btn">3개월</a>
				<a href="#self" class="btn_style_0 small empty" id="term06Btn">6개월</a>
				<a href="#self" class="btn_style_0 small empty" id="term12Btn">12개월</a>
			</span>
			<input type="text" id="resveStDt" name="resveStDt"  class="sdate" title="예약일자 시작일 입력" style="width:120px" value="<c:out value="${paramVO.resveStDt }" />" />
				~
			<input type="text" id="resveEdDt" name="resveEdDt"  class="edate" title="예약일자 종료일 입력" style="width:120px" value="<c:out value="${paramVO.resveEdDt }" />" />
			<input type="submit" class="design_summit_btn" id="submitBtn" value="검색" title="검색" />
			</div>
		</fieldset>
</div>


<div class="row clear tar mb20 board_util_btn_con tl board_sorting_con">
	<label for="resveSttus">승인상태</label>
	<span class="select_box">
	<select name="resveSttus" class="select_style_0" id="resveSttus" title="승인상태를 선택해 주세요.">
		<option value="">상태선택</option>
		<c:forEach var="item" items="${COM071CodeList }">
			<option value="<c:out value="${item.code }" />" <c:if test="${item.code eq param.resveSttus }">selected="selected"</c:if>><c:out value="${item.codeNm }" /></option>
		</c:forEach>
	</select>
	</span>
	<a href="javascript:void(0);" class="btn_style_0 green small" id="submitBtn2" style="margin-left: 20px;">확인</a>
</div>
</form>



<div class="infoTable">
	<table class="board_type_0 small" style="word-break:break-all;">
		<caption>인적사항</caption>
		<colgroup>
			<col style="width:10%">
			<col class="classview" style="width:10%">
			<col class="classview" style="width:8%">
			<col style="width:16%">
			<col style="width:10%">
			<col style="width:14%">
			<col style="width:14%">
			<col style="width:10%">
			<col class="classview" style="width:8%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">예약번호</th>
				<th class="classview" scope="col">위치</th>
				<th class="classview" scope="col">시설구분</th>
				<th scope="col">공간명</th>
				<th scope="col">장비</th>
				<th scope="col">예약일자</th>
				<th scope="col">예약시간</th>
				<th scope="col">승인상태</th>
				<th class="classview" scope="col">사용여부</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td><c:out value="${result.resveNo }" /><input type="hidden" name="resveSn" value="<c:out value="${result.resveSn }" />" /></td>
				<td class="classview"><c:out value="${result.areaSeNm }" /> / <c:out value="${result.lcSeNm }" /></td>
				<td class="classview"><c:out value="${result.fcltySeNm }" /></td>
				<td class="tal"><a href="#self" class="aTrigger"><c:out value="${result.spceNm }" /> <c:if test="${not empty result.spceNmEn }">Ⅰ(<c:out value="${result.spceNmEn }" />)</c:if></a></td>
				<td class="tal"><c:out value="${result.eqpmnNms }" /></td>
				<td><c:out value="${result.resveDt }" /></td>
				<td><c:out value="${result.resveBeginTime }" />시~<c:out value="${result.resveEndTime }" />시</td>
				<td>
				<c:choose>
					<c:when test="${result.resveSttus eq '01' }"><strong class="db text-primary"><c:out value="${result.resveSttusNm }" /></strong>

						<p><a href="#self" class="btn btn-xs btn-gray resveCancelBtn">예약취소</a></p>

					</c:when>
					<c:when test="${result.resveSttus eq '02' }"><strong class="db text-success"><c:out value="${result.resveSttusNm }" /></strong>
						<c:if test="${result.useAt ne 'N' && result.cancelUseAt eq 'Y' }">
						<p><a href="#self" class="btn btn-xs btn-gray resveCancelBtn">예약취소</a></p>
						</c:if>
					</c:when>
					<c:when test="${result.resveSttus eq '03' }"><strong class="db text-danger"><c:out value="${result.resveSttusNm }" /></strong>
						<c:if test="${result.useAt ne 'N' && result.cancelUseAt eq 'Y' }">
						<p><a href="#self" class="btn btn-xs btn-gray resveCancelBtn">예약취소</a></p>
						</c:if>
					</c:when>
					<c:when test="${result.resveSttus eq '04' }"><p class="db"><c:out value="${result.resveSttusNm }" /></p></c:when>
					<c:when test="${result.resveSttus eq '05' }"><p class="db"><c:out value="${result.resveSttusNm }" /></p></c:when>
				</c:choose>
				</td>
				<td class="classview">
					<c:choose>
					<c:when test="${result.useAt eq 'Y' }"><strong class="db text-primary"><c:out value="${result.useAtNm }" /></strong></c:when>
					<c:when test="${result.useAt eq 'N' }"><strong class="db text-primary"><c:out value="${result.useAtNm }" /></strong></c:when>
					<c:otherwise><c:out value="${result.useAtNm }" /></c:otherwise>
				</c:choose>
				</td>
			</tr>
			<!-- 장비클릭시 내용 -->
			 <tr class=" dn">
				<td colspan="5">
				<dl class="dl-horizontal tal">
					<dt>등록일시 			:</dt> <dd><c:out value="${result.frstRegistPnttm }" /></dd>
					<dt>나이 				:</dt> <dd><c:out value="${result.ageSeNm }" /></dd>
					<dt>직업 				:</dt> <dd><c:out value="${result.jobSeNm }" /> </dd>
					<dt>거주지역 			:</dt> <dd><c:out value="${result.resdncSeNm }" /></dd>
					<dt>사용인원 			:</dt> <dd><c:out value="${result.useNmpr }" />명</dd>
					<dt>사용목적 			:</dt> <dd><c:out value="${result.usePurposeSeNm }" /></dd>
					<dt>예약정보 수신방법 	:</dt> <dd><c:out value="${result.resveRecptnSeNm }" /></dd>
					<dt>코멘트 	:</dt> <dd><c:out value="${result.admCmmnt }" /></dd>
				</dl>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}">
			<tr class="listMypageNoData"><td colspan="9" class="tac">- 검색 결과가 없습니다 -</td></tr>
		</c:if>
		</tbody>
	</table>
</div>


<!-- <div class="btnSet"><a class="btn btn-primary" href="#self"><span>등록</span></a> <a class="btn btn-default" href="#self"><span>비밀번호 초기화</span></a> <a class="btn btn-danger" href="#self"><span>삭제</span></a> <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a></div> -->


<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
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
