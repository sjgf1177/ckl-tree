<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[
var codeIdVal = "<c:out value="${ codeId0 }" />";
var areaSeVal = "01";
var lcSeVal = "<c:out value="${ param.lcSe }" />";


$(function(){
	//init
	getCodeList("lcList", codeIdVal, areaSeVal, lcSeVal);

	/*
	$(".resveBtn").click(function() {
		var chkTpNum = $(this).attr("data-value");
		if (Number(chkTpNum) >= 2) {
			alert("오늘날짜 기준으로 90일동안 미사용이 2회일 경우, 최종 미사용일로 부터 30일간 예약 불가합니다.");
			return false;
		}
	});
	*/

});

// 공통 코드목록 화면처리
function getCodeList(elemntId, codeId, upperCode,code) {
	var menuNo = "<c:out value="${paramVO.menuNo}" />";
	var $obj = $("#"+ elemntId);
	var url = "/cmmn/cmmncode/codeListJson.do";
	var params = {
		codeId : codeId,
		upperCode : upperCode
	};
	$.get(url, params, function(data) {
		if (data) {
			$obj.empty();
			var $li = $("<li>");
			if (code == "") $li.addClass("on");
			var $a = $("<a>").text("All").attr("href","/ckleng/fcltyResve/fclty/list.do?menuNo="+menuNo);
			$a.appendTo($li);
			$li.appendTo($obj);

			$.each(data.list, function(key,item) {
				$li = $("<li>");
				if (code == item.code ) $li.addClass("on");
				$a = $("<a>").text(item.codeNmEn).attr("href","/ckleng/fcltyResve/fclty/list.do?menuNo="+menuNo+"&lcSe="+item.code);
				$a.appendTo($li);
				$li.appendTo($obj);
			});
		}
	},"json");
}

//]]>
</script>



<!-- bdList -->

<div class="formLine1">
	<form id="fcltyForm" name="fcltyForm" method="get" action="/ckleng/fcltyResve/fclty/list.do">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="lcSe" id="lcSe" value="<c:out value="${param.lcSe }" />" />
		<fieldset>
			<legend>Facility</legend>
			<div class="clearfix">
			<select name="gubun1" id="gubun1" title="Facility">
				<option>Facility</option>
			</select>
			<input type="text" name="spceNm" id="spceNm" class="mr5" title="" value="<c:out value="${param.spceNm }" />" />
			<a href="#self" class="btn btn-sm icoSearch btn-primary" onclick="document.fcltyForm.submit();return false;">Search</a>
			</div>
		</fieldset>
	</form>
</div>
<!-- //boardSearch -->


<div class="tabs">
	<ul class="list-inline length5" id="lcList">
	</ul>
</div>

<!-- board table -->
<div class="photoGallery4 photoRev">
	<c:if test="${fn:length(resultList) > 0}">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div class="box1">

				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId }" />&amp;fileFieldNm=mainImg" style="width:296px;height:210px;" alt="<c:out value="${result.spceNmEn }" /> Image" /><br />
				<strong class="db"><a style="width:300px;" href="/ckleng/fcltyResve/fclty/view.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;${pageQueryString}"><c:out value="${result.spceNmEn }" /></a></strong>
				<span><span class="icons ico1"></span>Location  : <c:out value="${result.lcSeNmEn }" /></span>
				<span><span class="icons ico2"></span>Area  : <c:out value="${result.ar }" />㎡</span>
				<span><span class="icons ico3"></span>Personnel size  : <c:out value="${result.nmpr }" /></span>

				<%-- <c:if test="${result.resvePosblAt eq 'Y' and result.resveSe ne 'I'}">
								<a href="/ckl/fcltyResve/resveSttus/step0.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm btn-danger resveBtn"><span><span class="icons ico4"></span>예약가능</span></a>
								</c:if>
								<c:if test="${result.resvePosblAt ne 'Y' or result.resveSe eq 'I'}">
								<a href="#self" onclick="return false;" class="btn btn-sm btn-gray"><span><span class="icons ico5"></span>예약불가</span></a>
								</c:if> --%>

			</div>
		</li>
		</c:forEach>

	</ul>
	</c:if>
</div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->
<!-- //board table -->

<!-- //bdList -->

