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
			var $a = $("<a>").text("전체").attr("href","/cklmobile/fcltyResve/eqpmn/list.do?menuNo="+menuNo);
			$a.appendTo($li);
			$li.appendTo($obj);

			$.each(data.list, function(key,item) {
				$li = $("<li>");
				if (code == item.code ) $li.addClass("on");
				$a = $("<a>").text(item.codeNm).attr("href","/cklmobile/fcltyResve/eqpmn/list.do?menuNo="+menuNo+"&eqpmnSe="+item.code);
				$a.appendTo($li);
				$li.appendTo($obj);
			});
		}
	},"json");
}

//]]>
</script>



<div class="tabs">
	<ul class="list-inline length3" id="seList">
	</ul>
</div>

<!-- board table -->

<div class="photoGallery4 photoRev">
	<c:if test="${fn:length(resultList) > 0 }">
	<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div class="box1">
				<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId }" />&amp;fileFieldNm=mainImg"  alt="<c:out value="${result.eqpmnNm }" /> 이미지" /><br />
				<strong class="db"><a style="width:300px;" href="/cklmobile/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}"><c:out value="${result.eqpmnNm }" /></a></strong>
				<span class="mb10"><span class="icons ico6"></span>수량 : <c:out value="${result.eqpmnQy }" />EA</span>
				<a href="/cklmobile/fcltyResve/eqpmn/view.do?eqpmnSn=<c:out value="${result.eqpmnSn }" />&amp;${pageQueryString}" class="btn btn-sm"><span><span class="icons ico4"></span>상세보기</span></a>
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
