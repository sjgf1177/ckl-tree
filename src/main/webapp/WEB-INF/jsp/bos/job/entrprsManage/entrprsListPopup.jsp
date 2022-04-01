<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" >
//<![CDATA[


var objEntrprsNm = "<c:out value="${param.objEntrprsNm}" />";
var objCharger = "<c:out value="${param.objCharger}" />";
var objTelno = "<c:out value="${param.objTelno}" />";
var objEmail = "<c:out value="${param.objEmail}" />";
var objEntrprsSn = "<c:out value="${param.objEntrprsSn}" />";

$(function() {
	$('window').ready(function() {
		$(".pagination  li a").attr("href", function() {
			var $url  = this.href;
			return $url + "&objEntrprsNm=entrprsNm&objCharger=charger&objTelno=telno&objEmail=email&objEntrprsSn=entrprsSn&entrprsNm=<c:out value='${param.entrprsNm }'/>";
		});
	});


	$("#confirmBtn").click(function() {
		if ($("input[name=entrprsSn]:checked").size() == 0) {
			alert("회사를 선택해 주세요.");
			return false;
		}

		var $entrprsSn = $("input[name=entrprsSn]:checked");
		var entrprsSn = $entrprsSn.val();;
		var entrprsNm = $entrprsSn.closest("tr").find("td.entrprsNm").text();
		var charger = $entrprsSn.closest("tr").find("td.charger").text();
		var email = $entrprsSn.closest("tr").find("td.email").text();
		var telno = $entrprsSn.closest("tr").find("td.telno").text();

		$("#"+objEntrprsSn, opener.document).val(entrprsSn);
		$("#"+objEntrprsNm, opener.document).val(entrprsNm);
		$("#"+objCharger, opener.document).val(charger);
		$("#"+objEmail, opener.document).val(email);
		$("#"+objTelno, opener.document).val(telno);

		window.close();
		return false;
	});
});
//]]>
</script>
<div class="row">
	<div class="col-md-12">
    	<h1>기업 찾기</h1>
        <div class="panel panel-default">
			<div class="panel-body">
			<form action="/bos/job/entrprsManage/entrprsListPopup.do" name="entrprsFrom" id="entrprsFrom" method="get">
				<input type="hidden" name="viewType" value="<c:out value="${param.viewType }" />" />
				<input type="hidden" name="objEntrprsNm" value="<c:out value="${param.objEntrprsNm }" />" />
				<input type="hidden" name="objCharger" value="<c:out value="${param.objCharger }" />" />
				<input type="hidden" name="objTelno" value="<c:out value="${param.objTelno }" />" />
				<input type="hidden" name="objEmail" value="<c:out value="${param.objEmail }" />" />
				<input type="hidden" name="objEntrprsSn" value="<c:out value="${param.objEntrprsSn }" />" />
				<fieldset>
					<legend>기업 찾기</legend>
						<div class="bdView mb0">
							<table class="table table-bordered">
								<caption>기업 찾기</caption>
								<colgroup>
								<col />
								<col />
								<col />
								<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="entrprsNm">기업명</label></th>
										<td><input type="text" name="entrprsNm" id="entrprsNm" value="<c:out value="${param.entrprsNm }" />" /></td>
										<th scope="row"><label for="rprsntv">담당자명</label></th>
										<td><input type="text" name="charger" id="charger" value="<c:out value="${param.charger }" />" /></td>
									</tr>
								</tbody>
							</table>
						</div>
				</fieldset>

				<div class="btnSet tar"><input type="submit" class="btn btn-primary" value="검색" /></div>
			</form>
			</div>
		</div>
	    <div class="panel panel-default">
			<div class="panel-body">
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
					</colgroup>
					<thead>
						<tr>
							<th scope="row" >선택</th>
							<th scope="row" >기업명</th>
							<th scope="row" >담당자명</th>
							<th scope="row" >연락처</th>
							<th scope="row" >이메일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="entrprsSn"><input type="radio" name="entrprsSn" value="${result.entrprsSn}" /></td>
							<td class="entrprsNm"><c:out value="${result.entrprsNm}" /></td>
							<td class="charger"><c:out value="${result.charger}" /></td>
							<td class="telno"><c:out value="${result.telno}" /></td>
							<td class="email"><c:out value="${result.email}" /></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}" >
						<tr><td colspan="5">데이터가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
				</div>


				<c:if test="${fn:length(resultList) > 0}">
				<div class="paging">
					${pageNav}
				</div>
				</c:if>

				<div class="btnSet"><a href="#self" class="btn btn-primary" id="confirmBtn">확인</a></div>

	        </div>
	    </div>
	</div>
</div>


