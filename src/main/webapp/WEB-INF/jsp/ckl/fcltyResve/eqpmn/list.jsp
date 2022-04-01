<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
//<![CDATA[
var codeIdVal = "<c:out value="${ codeId0 }" />";
var eqpmnSeVal = "<c:out value="${ param.eqpmnSe }" />";


$(function(){
	//init
	getCodeList("seList", codeIdVal, "0", eqpmnSeVal);

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
			var $a = $("<a>").text("전체").attr("href","/ckl/fcltyResve/eqpmn/list.do?menuNo="+menuNo);
			$a.appendTo($li);
			$li.appendTo($obj);

			$.each(data.list, function(key,item) {
				$li = $("<li>");
				if (code == item.code ) $li.addClass("on");
				$a = $("<a>").text(item.codeNm).attr("href","/ckl/fcltyResve/eqpmn/list.do?menuNo="+menuNo+"&eqpmnSe="+item.code);
				$a.appendTo($li);
				$li.appendTo($obj);
			});
		}
	},"json");
}

//]]>
</script>

<!-- boardSearch -->
<div class="formLine1">
	<form id="eqpmnForm" name="eqpmnForm" method="get" action="/ckl/fcltyResve/eqpmn/list.do" class="form-inline">
		<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
		<fieldset>
			<legend>장비 검색</legend>
			<div class="clearfix">
			<select name="gubun1" id="gubun1" title="구분을 선택해 주세요.">
				<option>장비명</option>
			</select>
			<input type="text" name="eqpmnNm" id="eqpmnNm" class="mr5" title="검색어를 입력해 주세요." value="<c:out value="${param.eqpmnNm}" />" />
			<a href="#self" class="btn btn-sm icoSearch btn-primary" onclick="document.eqpmnForm.submit();return false;">검색</a>
			</div>
		</fieldset>
	</form>
</div>
<!-- //boardSearch -->

<div class="tabs">
	<ul class="list-inline length5" id="seList">
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
	<c:if test="${fn:length(resultList) > 0 }">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div class="box1">
				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId }" />&amp;fileFieldNm=mainImg" style="width:296px;height:210px;" alt="<c:out value="${result.eqpmnNm }" /> 장비 사진" /><br />
				<strong class="db"><a style="width:300px;" href="/ckl/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}"><c:out value="${result.eqpmnNm }" /></a></strong>
				<span class="mb10"><span class="icons ico6"></span>수량 : <c:out value="${result.eqpmnQy }" />EA</span>
				<c:if test="${result.resvePosblAt eq 'Y' }">
				<a href="/ckl/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm btn-danger"><span><span class="icons ico4"></span>예약가능</span></a>
				</c:if>

				<c:if test="${result.resvePosblAt eq 'I'}">
				<a href="/ckl/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm btn-success"><span><span class="icons ico4"></span>개별예약</span></a>
				</c:if>

				<c:if test="${result.resvePosblAt eq 'N'}" >
				<a href="/ckl/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm btn-gray"><span><span class="icons ico5"></span>예약불가</span></a>
				</c:if>
			</div>
		</li>
		</c:forEach>
	</ul>
	</c:if>
</div>
<!-- //board table -->
<!-- //bdList -->

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->
