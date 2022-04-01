<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>


<script type="text/javascript">
//<![CDATA[
$(function() {
	$("#waitUpdBtn").click(function() {
		if(!confirm("대기예약정보 변경페이지로 이동하시겠습니까?")) {
			return false;
		}
	});

	$("#comptBtn").click(function() {
		if(confirm("승인완료 처리하시겠습니까?")) {
			fnConfirmProcess("02");
		}
		return false;
	});


	$("#waitBtn").click(function() {
		if(confirm("대기예약 처리하시겠습니까?")) {
			fnConfirmProcess("03");
		}
		return false;
	});



	$("#rejectBtn").click(function() {
		if(confirm("승인불가 처리하시겠습니까?")) {
			fnConfirmProcess("04");
		}
		return false;
	});

	$("#cancelBtn").click(function() {
		if(confirm("예약취소 처리하시겠습니까?")) {
			fnConfirmProcess("05");
		}
		return false;
	});

	$("#schdulBtn").click(function() {
		if(confirm("일정으로 등록하시겠습니까?")) {
			var url = "/bos/hkCultureResve/schdul/insert.json";
			var params = {
				eventDt : $("#resveDt").val(),
				eventBeginTime : $("#resveBeginTime").val(),
				eventEndTime : $("#resveEndTime").val(),
				eventNm : $("#eventNm").val(),
				place : $("#place").val(),
				refResveSn : $("#resveSn").val()
			};
			$.post(url,params,function(data) {

				if (data.resultCode == "success") {
					alert("일정등록이 완료되었습니다.");
				}
				else if (data.resultCode == "validate") {
					alert("해당 예약일련번호로 등록된 일정이 존재합니다. ");
				}
				else {
					alert("일정등록이 실패했습니다.");
				}
			},"json");
		}
		return false;
	});


	$("#cmmntSaveBtn").click(function() {
		if ( $("#admCmmnt").val() == "") {
			alert("코멘트를 입력해주세요.");
			return false;
		}
		var url = "/bos/hkCultureResve/resveSttus/saveCmmnt.json";
		var param = {
				admCmmnt : $("#admCmmnt").val(),
				resveSn  : $("#resveSn").val()
		};
		$.post(url,param,function(data) {
			if (data.resultCode == "success") {
				alert("저장되었습니다.");
			}
			else {
				alert("저장이 실패했습니다.");
			}
			return false;
		},"json");
		return false;
	});
});

function fnConfirmProcess(resveSttus) {
	var url = "/bos/hkCultureResve/resveSttus/updateResveSttus.json";
	params = {
		resveSn	: "<c:out value="${result.resveSn}" />",
		resveSttus	: resveSttus
	};
	$.post(url,params, function(data) {
		if (data.resultCode == "success") {
			alert("예약상태변경 처리가 완료되었습니다.");
			location.reload();
		}
		else {
			alert("예약상태변경 처리가 실패했습니다.");
		}
	},"json");
	return false;
}


//]]>
</script>

<h4>예약정보</h4>
<div class="bdView">
	<table>
		<caption>
		예약정보
		</caption>
		<colgroup>
		<col style="width:15%" />
		<col style="width:35%" />
		<col style="width:15%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">예약번호</th>
				<td colspan="3"><c:out value="${result.resveNo }" /></td>
			</tr>
			<tr>
				<th scope="row" >승인상태</th>
				<td><c:out value="${result.resveSttusNm }" /></td>
				<th scope="row" >사용여부</th>
				<td><c:out value="${result.useAtNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >시설공간</th>
				<td colspan="3">  <c:out value="${result.areaSeNm }" /> &gt; <c:out value="${result.lcSeNm }" /> &gt; <c:out value="${result.fcltySeNm }" /> &gt; <c:out value="${result.spceNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >예약일자</th>
				<td>

					<fmt:parseDate value="${result.resveDt}" var="dateFmt" pattern="yyyy-MM-dd"/>
                	<fmt:formatDate value="${dateFmt}" pattern="yyyy년 MM월 dd일"/>
				</td>
				<th scope="row" >예약시간</th>
				<td>
					${result.resveBeginTime }:00
					 ~ <c:out value="${result.resveEndTime }"/>:59 (<c:out value="${(result.resveEndTime-result.resveBeginTime+1) }" />시간)
				</td>
			</tr>
			<tr>
				<th scope="row" >등록일시</th>
				<td colspan="3"><c:out value="${result.frstRegistPnttm }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<input type="hidden" id="resveDt" value="<c:out value="${result.resveDt}" />" />
<input type="hidden" id="resveBeginTime" value="<c:out value="${result.resveBeginTime}" />" />
<input type="hidden" id="resveEndTime" value="<c:out value="${result.resveEndTime}" />" />
<input type="hidden" id="eventNm" value="<c:out value="${result.usePurposeCn}" />" />
<input type="hidden" id="place" value="<c:out value="${result.lcSeNm }" /> > <c:out value="${result.fcltySeNm }" /> > <c:out value="${result.spceNm }" />" />
<input type="hidden" id="resveSn" value="<c:out value="${result.resveSn}" />" />

<h4>예약 단체 정보</h4>
<div class="bdView">
	<table>
		<caption>

		</caption>
		<colgroup>
		<col style="width:15%" />
		<col style="width:35%" />
		<col style="width:15%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" >단체명</th>
				<td colspan="3"><c:out value="${result.resveNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >연락처</th>
				<td><c:out value="${result.mbtlnum }" /></td>
				<th scope="row" >이메일</th>
				<td><c:out value="${result.email }" /></td>
			</tr>
			<tr>
				<th scope="row" >거주지역</th>
				<td><c:out value="${result.resdncSeNm }" /></td>
				<th scope="row" >사용인원</th>
				<td><c:out value="${result.useNmpr }" /> 명</td>
			</tr>
			<tr>
				<th scope="row" >사용목적구분</th>
				<td colspan="3"><c:out value="${result.usePurposeSeNm }" /></td>
			</tr>
			<tr>
				<th scope="row" >사용목적</th>
				<td colspan="3">
					<% pageContext.setAttribute("crlf", "\n"); %>
					${fn:replace(result.usePurposeCn, crlf, "<br/>") }
				</td>
			</tr>
			<tr>
				<th scope="row" >예약정보<br />수신방법</th>
				<td colspan="3"><c:out value="${result.resveRecptnSeNm }" /></td>
			</tr>
		</tbody>
	</table>
</div>

<%-- <h4>사용정보</h4>
<div class="bdView">
	<table>
		<caption>

		</caption>
		<colgroup>
		<col style="width:15%" />
		<col style="width:35%" />
		<col style="width:15%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" >발권일시</th>
				<td><c:out value="${result.ntssDt }" /></td>
				<th scope="row" >키오스크위치</th>
				<td><c:out value="${result.koskIp }" /></td>
			</tr>
			<tr>
				<th scope="row" >재발권상태</th>
				<td><c:out value="${result.reNtssAt eq 'Y' ? '재발권' : '' }" /></td>
				<th scope="row" >재발권일시</th>
				<td><c:out value="${result.reNtssDt }" /></td>
			</tr>
		</tbody>
	</table>
</div> --%>


<div class="row">
	<div class="col-md-2">
	<c:if test="${result.resveSttus eq '03' }">
		<a href="/bos/hkCultureResve/resveSttus/resveStep1.do?resveSn=<c:out value="${result.resveSn }" />&menuNo=<c:out value="${param.menuNo }" />" id="waitUpdBtn" class="btn btn-danger">대기예약정보변경</a>
	</c:if>
	</div>
	<div class="col-md-8 tac"><a href="#self" id="comptBtn" class="btn btn-success">승인완료</a>
		<a href="#self" id="waitBtn" class="btn btn-default">대기예약</a>
		<a href="#self" id="rejectBtn" class="btn btn-default">승인불가</a>
		<a href="#self" id="cancelBtn" class="btn btn-default">예약취소</a>
		<!-- <a href="#self" id="schdulBtn" class="btn btn-success">키오스크에 일정으로 등록하기</a> -->
	</div>
	<div class="col-md-2"><a class="btn btn-primary" href="/bos/hkCultureResve/resveSttus/list.do?${pageQueryString }"><span>목록</span></a></div>
</div>


<div class="bdView mt50">
	<table>
		<caption>

		</caption>
		<colgroup>
		<col style="width:15%" />
		<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" >코멘트</th>
				<td><input type="text" name="admCmmnt" id="admCmmnt" style="width:500px;" value="<c:out value="${result.admCmmnt }" />" />
					<a class="btn btn-success" href="#" id="cmmntSaveBtn"><span>저장</span></a>
				</td>
			</tr>
		</tbody>
	</table>
</div>


<!-- board list end //-->
