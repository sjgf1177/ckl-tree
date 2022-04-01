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
		"/edu/progrm/master/progrsSttusChk.json",
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
    var sysdate = '<span class="alert_design_text">현재시간</span><hr class="time_seperate_line">'+now.getFullYear() + '-' +'0'+(now.getMonth()+1) + '-' +now.getDate() + '<span style="padding-right:5px;"></span>'+now.getHours() + ':' + now.getMinutes();

	if (progrsSttus == '${FINISH_PSNCPA}') {
		progrsSttusFp = " | 선착순 마감";
	}
	else if (progrsSttus == '${FINISH}') {
		progrsSttusFp = " | 선착순 마감";
		progrsSttusF = " | 대기접수 마감";
	}

    html = "<div class='alert'>"+sysdate+progrsSttusFp+progrsSttusF+"</div>";

    $("#rltm").html(html);
}

//]]>
</script>
	<div id="rltm" class="tar">
	</div>
