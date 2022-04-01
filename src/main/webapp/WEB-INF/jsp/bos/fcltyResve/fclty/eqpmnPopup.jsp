<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="wrap" class="popupWrap">
	<div class="row">
         <div class="col-md-12">
             <h1>선택장비 찾기</h1>
             <div class="panel panel-default">
				<div class="panel-body">
				<form action="" name="eqpmnPopForm" id="eqpmnPopForm" method="get">
					<fieldset>
						<legend>선택장비 찾기</legend>
							<div class="bdView mb0">
								<table class="table table-bordered">
								<caption>선택장비 찾기</caption>
								<colgroup>
								<col />
								<col />
								<col />
								<col />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row" ><label for="srh_eqpmnNm">장비명</label></th>
										<td><input type="text" name="eqpmnNm" id="srh_eqpmnNm" value="" /></td>
										<th scope="row" ><label for="srh_dtlsInfo">세부내역</label></th>
										<td><input type="text" name="dtlsInfo" id="srh_dtlsInfo" value="" /></td>
									</tr>
								</tbody>
								</table>
							</div>
					</fieldset>
				</form>
				<div class="btnSet tar"><a href="#self" id="eqpmnPopSrhBtn" class="btn btn-primary">검색</a></div>
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
						<col />
						</colgroup>
						<thead>
							<tr>
								<th scope="row" >선택</th>
								<th scope="row" >장비구분</th>
								<th scope="row" >장비명</th>
								<th scope="row" >상세장비수량</th>
								<th scope="row" >예약구분</th>
								<th scope="row" >예약가능여부</th>
							</tr>
						</thead>
						<tbody class="eqpmnPopList">
						<c:forEach var="result" items="${eqpmnList}" varStatus="status">
							<tr>
								<td><input type="checkbox" name="eqpmnSns" id="eqpmnSns<c:out value="${status.index }"/>" value="<c:out value="${result.eqpmnSn }" />"  class="data_eqpmnSns" title="선택<c:out value="${status.index }"/>" /></td>
								<td class="data"><c:out value="${result.eqpmnSeNm }" /></td>
								<td class="data_eqpmnNms"><c:out value="${result.eqpmnNm }" /></td>
								<td class="data_eqpmnQy"><c:out value="${result.eqpmnQy }" /></td>
								<td class="data_resveSeNm"><c:out value="${result.resveSeNm }" /></td>
								<td class="data_useAt"><c:out value="${result.useAt eq 'Y' ? '사용' : '미사용' }" /></td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(eqpmnList) == 0}">
							<tr><td colspan="5" class="tac">- 검색 결과가 없습니다 -</td></tr>
						</c:if>
						</tbody>
					</table>


					<table style="display:none">
						<tbody class="tmp_eqpmnPopList">
							<tr>
								<td><input type="checkbox" name="eqpmnSns" class="data_eqpmnSns" title="선택" /></td>
								<td class="data_eqpmnNm"></td>
								<td class="data_eqpmnQy"></td>
								<td class="data_resveSeNm"></td>
								<td class="data_useAt"></td>
							</tr>
						</tbody>
					</table>
					</div>

					<div class="btnSet"><a href="#self" class="btn btn-primary" id="eqpmnPopCnfrmBtn">확인</a></div>

				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[


	$("#eqpmnPopSrhBtn").click(function() {
		var url = "/bos/fcltyResve/fclty/eqpmnPopup.json";
		var params = $("#eqpmnPopForm").serialize();
		$.get(url, params, function(data) {
			var $trClone = $(".tmp_eqpmnPopList > tr").clone();
			$(".eqpmnPopList").empty();
			$.each(data.eqpmnList, function(key, item) {
				$trClone.find(".data_eqpmnSns").val(item.eqpmnSn);
				$trClone.find(".data_eqpmnNms").text(item.eqpmnNm);
				$trClone.find(".data_eqpmnQy").text(item.eqpmnQy);
				$trClone.find(".data_resveSeNm").text(item.resveSeNm);
				$trClone.find(".data_useAt").text(item.useAt == "Y" ? "사용" : "미사용");
				$trClone.appendTo($(".eqpmnPopList"));
			});
			if (data.eqpmnList.length == 0) {
				$("<tr>").append($("<td>").attr({"class" : "tac", "colspan" : "5"}).text("- 검색 결과가 없습니다 -")).appendTo($(".eqpmnPopList"));
			}

		},"json");
	});

	$("#eqpmnPopCnfrmBtn").click(function() {
		//$("eqpmnNms").val();
		if ($(".eqpmnPopList").find(".data_eqpmnSns").filter(":checked").size() == 0) {
			alert("장비를 선택해 주세요.");
			return false;
		}

		var eqpmnSns = [];
		var eqpmnNms = [];
		$(".eqpmnPopList").find(".data_eqpmnSns").filter(":checked").each(function(n) {
			eqpmnSns.push($(this).val());
			eqpmnNms.push($(this).closest("tr").find(".data_eqpmnNms").text());
		});
		$("#eqpmnNms").val(eqpmnNms.join(","));
		$("#eqpmnSns").val(eqpmnSns.join(","));

		$(".ui-dialog-titlebar-close").trigger("click");
	});

//]]>
</script>