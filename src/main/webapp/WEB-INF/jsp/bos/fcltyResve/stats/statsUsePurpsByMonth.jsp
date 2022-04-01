<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
//<![CDATA[
$(function() {


	$("#excelBtn").click(function() {
		$("#statsForm").attr("action","/bos/fcltyResve/stats/downloadExcelStatsUsePurpsByMonth.xls");
		$("#statsForm").submit();
		return false;
	});
});

//]]>
</script>

<!-- 게시판 게시물검색 -->
<form name="statsForm" id="statsForm" method="get" action="/bos/fcltyResve/stats/downloadExcelStatsUsePurpsByMonth.xls">
	<input type="hidden" name="menuNo" value="<c:out value="${param.menuNo }" />" />
<div class="sh form-inline pr10">
	<fieldset>
		<legend>시설이용목적별 현황 검색</legend>
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
						<th scope="row" >기간</th>
						<td><input type="text" id="resveSdate" name="resveSdate" title="시작월 입력" style="width:130px" value="<c:out value="${paramVO.resveSdate }" />" maxlength="6" />
							~
							<input type="text" id="resveEdate" name="resveEdate" title="종료월 입력" style="width:130px" value="<c:out value="${paramVO.resveEdate }" />" maxlength="6" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</fieldset>
</div>
</form>
<div class="btn_set"><a class="btn btn-info" href="#self" id="excelBtn"><span>엑셀로 저장</span></a></div>