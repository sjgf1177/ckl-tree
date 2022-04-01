<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<c:set var="WAITING" value="<%=ProgrmMasterService.Status.WAITING.getValue()%>"/>
<c:set var="PROGRESS" value="<%=ProgrmMasterService.Status.PROGRESS.getValue()%>"/>
<c:set var="FINISH_PSNCPA" value="<%=ProgrmMasterService.Status.FINISH_PSNCPA.getValue()%>"/>
<c:set var="FINISH" value="<%=ProgrmMasterService.Status.FINISH.getValue()%>"/>

<script type="text/javascript">
//<![CDATA[

$(function() {
	getRltm();
	setInterval(function(){
		//alert($("#progrsSttus").val());
		getRltm();
	}, 5000);
});

function getRltm() {
	$.post(
		"/ckl/progrm/master/progrsSttusChk.json",
		{prgSn : '${param.prgSn}'},
		function(data)
		{
			getHtml(data.progrsSttus);
		},"json"
	);
}

function getHtml(progrsSttus) {
	var html = "";
	var progrsSttusFp ="";
	var progrsSttusF ="";
	var now = new Date();
    var sysdate = '<span class="icons ico23"></span> 현재 시간 : <span class="text-danger">'+now.getFullYear() + '</span> 년 <span class="text-danger">' + (now.getMonth()+1) + '</span>월 <span class="text-danger">' + now.getDate() + '</span>일 <span class="text-danger">' + now.getHours() + ':' + now.getMinutes()+'</span>';

	if (progrsSttus == '${FINISH_PSNCPA}') {
		progrsSttusFp = " | <span class=\"dib btn btn-sm round btn-danger\"><span class=\"icons icoTimeR\"></span>선착순 마감</span>";
	}
	else if (progrsSttus == '${FINISH}') {
		progrsSttusFp = " |  <span class=\"dib btn btn-sm round btnWhiteGray\"><span class=\"icons icoTimeR\"></span>선착순 마감</span>";
		progrsSttusF = " |  <span class=\"dib btn btn-sm round btnWhiteGray\"><span class=\"icons icoTimeR\"></span>대기접수 마감</span>";
	}

    html = "<p>"+sysdate+progrsSttusFp+progrsSttusF+"</p>";

    $("#rltm").html(html);
}

//]]>
</script>
	<div id="rltm" class="tar">
	</div>
