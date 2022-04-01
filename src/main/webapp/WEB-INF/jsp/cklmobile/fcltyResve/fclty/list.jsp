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
			var $a = $("<a>").text("전체").attr("href","/cklmobile/fcltyResve/fclty/list.do?menuNo="+menuNo);
			$a.appendTo($li);
			$li.appendTo($obj);

			$.each(data.list, function(key,item) {
				$li = $("<li>");
				if (code == item.code ) $li.addClass("on");
				var codeNm = item.codeNm;
				codeNm = codeNm.replace(/[(]|[^(]*[)]/gi, "");
				$a = $("<a>").text(codeNm).attr("href","/cklmobile/fcltyResve/fclty/list.do?menuNo="+menuNo+"&lcSe="+item.code);
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
	<form id="fcltyForm" name="fcltyForm" method="get" action="/cklmobile/fcltyResve/fclty/list.do">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="lcSe" id="lcSe" value="<c:out value="${param.lcSe }" />" />
		<fieldset>
			<legend>시설 검색</legend>
			<div class="clearfix">
			<select name="gubun1" id="gubun1" title="구분을 선택해 주세요.">
				<option>시설명</option>
			</select>
			<input type="text" name="spceNm" id="spceNm" class="mr5" title="검색어를 입력해 주세요." value="<c:out value="${param.spceNm }" />" />
			<a href="#self" class="btn btn-sm icoSearch btn-primary" onclick="document.fcltyForm.submit();return false;">검색</a>
			</div>
		</fieldset>
	</form>
</div>
<!-- //boardSearch -->


<div class="tabs">
	<ul class="list-inline length5" id="lcList">
	<!--
		<li class="on"><a href="#self">전체</a></li>
		<li><a href="#self">2F Synergy Ocean</a></li>
		<li><a href="#self">10F Idea Village </a></li>
		<li><a href="#self">14F Floating Sky </a></li>
		<li><a href="#self">15F Floating Sky</a></li>
	 -->
	</ul>
</div>



<!-- board table -->
<div class="photoGallery4 photoRev">
	<c:if test="${fn:length(resultList) > 0}">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div class="box1">

				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId }" />&amp;fileFieldNm=mainImg" alt="<c:out value="${result.spceNm }" /> 사진" /><br />
				<strong class="db"><a style="width:300px;" href="/cklmobile/fcltyResve/fclty/view.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;${pageQueryString}"><c:out value="${result.spceNm }" /></a></strong>
				<span><span class="icons ico1"></span>위치 : <c:out value="${result.lcSeNm }" /></span>
				<span><span class="icons ico2"></span>면적 : <c:out value="${result.ar }" />㎡</span>
				<span><span class="icons ico3"></span>인원 : <c:out value="${result.nmpr }" />명</span>
				<a href="/cklmobile/fcltyResve/fclty/view.do?fcltySn=<c:out value="${result.fcltySn }" />&amp;${pageQueryString}" class="btn btn-sm"><span><span class="icons ico4"></span>상세보기</span></a>

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

