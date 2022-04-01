<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!-- <link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.min.css">-->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/bootstrap.reset.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/animate.min.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/common.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="/ckl/css/layout.css"> -->
<link rel="stylesheet" type="text/css" href="/ckl/css/sub.css"> 

<style>
.photoRev .box1{
	width: 100%;
}
.tabs li.on a{
	border: 1px solid #40abd4;
	border-bottom-color: transparent;
	color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
	text-decoration: unset;
}
.tabs li a{
	border-bottom-color: #40abd4;
	font-size: 1.45rem;
	font-weight: 400;
}
.photoRev .box1 a.btn{
	background-color: #5ac9b7;
}
.formLine1 input[type=text]{
	width: 130px;
}
@media (min-width: 845px) {
	.photoRev li{
		width: 30%;
		margin-left: 2%;
	}
}
@media (max-width: 845px) {
	.photoRev li{
		width: 45%;
		margin-left: 2%;
	}
}
@media (max-width: 530px) {
	.photoRev li{
		width: 95%;
		margin-left: 3%;
	}
	.formLine1{
		width: 98%;
	}
}
</style>

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
			var $a = $("<a>").text("전체").attr("href","/edu/hkFcltyResve/eqpmn/list.do?menuNo="+menuNo);
			$a.appendTo($li);
			$li.appendTo($obj);

			$.each(data.list, function(key,item) {
				$li = $("<li>");
				if (code == item.code ) $li.addClass("on");
				$a = $("<a>").text(item.codeNm).attr("href","/edu/hkFcltyResve/eqpmn/list.do?menuNo="+menuNo+"&eqpmnSe="+item.code);
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
	<form id="eqpmnForm" name="eqpmnForm" method="get" action="/edu/hkFcltyResve/eqpmn/list.do" class="form-inline">
		<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
		<fieldset>
			<legend>장비 검색</legend>
			<div class="clearfix board_util_btn_con board_sorting_con">
			<span class="select_box">
			<select class="select_style_0" name="gubun1" id="gubun1" title="구분을 선택해 주세요.">
				<option selected>장비명</option>
			</select>
			</span>
			<input type="text" name="eqpmnNm" id="eqpmnNm" class="mr5" title="검색어를 입력해 주세요." value="<c:out value="${param.eqpmnNm}" />" />
			<a href="#self" class="btn_style_0 blue small" onclick="document.eqpmnForm.submit();return false;">검색</a>
			</div>
		</fieldset>
	</form>
</div>
<!-- //boardSearch -->

<!-- board table -->

<div class="photoGallery4 photoRev" style="display: flex;">
	<c:if test="${fn:length(resultList) > 0 }">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div class="box1">
				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId }" />&amp;fileFieldNm=mainImg" style="width:100%;height:210px;" alt="<c:out value="${result.eqpmnNm }" /> 장비 사진" /><br />
				<strong class="db" style="padding-top: 0px;"><a style="width:100%;" href="/edu/hkFcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}"><c:out value="${result.eqpmnNm }" /></a></strong>
				<span class="mb10"><span class="icons ico6"></span>수량 : <c:out value="${result.eqpmnQy }" />EA</span>
				<c:if test="${result.resvePosblAt eq 'Y' }">
				<a href="/edu/hkFcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm btn-danger"><span><span class="icons ico4"></span>상세보기</span></a>
				</c:if>

				<c:if test="${result.resvePosblAt eq 'I'}">
				<a href="/edu/hkFcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm btn-success"><span><span class="icons ico4"></span>개별예약</span></a>
				</c:if>

				<c:if test="${result.resvePosblAt eq 'N'}" >
				<a href="/edu/hkFcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm btn-gray"><span><span class="icons ico5"></span>예약불가</span></a>
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
