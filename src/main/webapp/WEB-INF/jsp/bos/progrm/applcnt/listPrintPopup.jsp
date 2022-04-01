<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>페이지인쇄하기 <spring:message code='site.korName' text=''/></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="robots" content="all" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="/js/bootstrap/css/bootstrap-theme.css" />

<link rel="stylesheet" type="text/css" href="/ckl/css/common.css" />
<style>

</style>
<link rel="stylesheet" type="text/css" href="/bos/css/common.css" />
<link rel="stylesheet" type="text/css" href="/bos/css/sub.css" />
	<!-- <script type="text/javascript" src="/js/jquery.js"></script>
	<script type="text/javascript" src="/bos/js/common.js"></script>
	<script type="text/javascript" src="/bos/js/sub.js"></script> -->

<style type="text/css">
	body{background: #fff none 0 0 no-repeat;}
	#wrap{width: auto ;margin: 0 0 0 0;background-image:none;}
	#wraper{background-image: url(none);width: auto;}
	#container,
	#content{float:none;margin: 0;padding: 0;background-image:none;}
	.print_btn_set{text-align: center;}
	.spot_visual{position: relative;top:0;}
	#content {width:770px !important;}
	.hgroup a,
	.hgroup .btn_print {display:none;}
	span.button {display:none;}
	P.breakhere {page-break-before: always}

</style>
<script type="text/javascript">
//<![CDATA[

window.print();

window.document.onkeydown=function() {
	return false;
}

window.document.onclick=function() {
	return false;
}

window.document.ondblclick=function() {
	return false;
}


window.document.oncontextmenu=function() {
	return false;
}


window.document.ondragstart=function() {
	return false;
}


window.document.onselectstart=function() {
	return false;
}
//]]>
</script>
</head>
<body>
<!--
<div id="btn_print" style="display:none;width:680px;height:30px;text-align:center;padding-top:10px;"><a href="#btn_print" onclick="window.print();return false;" onkeypress="this.onclick();"><img src="/kab/home/img/common/btn/btn_print.gif" alt="인쇄하기" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#btn_print" onclick="window.close();return false;" onkeypress="this.onclick();"><img src="/kab/home/img/common/btn/close.gif" alt="창닫기" /></a></div>
<div id="btn_print" style="display:none;text-align:center;padding-top:10px;">
	<div class="tar">
		<a class="btn btn-sm btn-warning" href="#btn_print" onclick="window.close();return false;">창닫기</a>
		<a class="btn btn-sm btn-success" href="#" onclick="window.print();return false;" id="print" title="새창" alt="인쇄하기 (자바스크립트 미지원시 브라우저은 인쇄기능을 이용하세요)"><i class="fa fa-hover fa-print"></i><span >인쇄하기</span></a>
	</div>
</div>
-->


<c:forEach var="result" items="${infoList}" varStatus="status">

<P class="breakhere">
	<h4>개인정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col />
			</colgroup>
			<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td>${result.userId}</td>
					</tr>
				<c:if test="${result.nmUseAt eq 'Y'}">
					<tr>
						<th scope="row">이름</th>
						<td>${result.nm}</td>
					</tr>
				</c:if>
				<c:if test="${result.brthdyUseAt eq 'Y'}">
					<tr>
						<th scope="row">생년월일</th>
						<td>${result.brthdy}</td>
					</tr>
				</c:if>
				<c:if test="${result.sexUseAt eq 'Y'}">
					<tr>
						<th scope="row">성별</th>
						<td>${result.sexNm}</td>
					</tr>
				</c:if>
				<c:if test="${result.emailUseAt eq 'Y'}">
					<tr>
						<th scope="row">이메일</th>
						<td><a href="mailto:${result.email}">${result.email}</a></td>
					</tr>
				</c:if>
				<c:if test="${result.addEmailUseAt eq 'Y'}">
					<tr>
						<th scope="row">추가이메일</th>
						<td><a href="mailto:${result.addEmail}">${result.addEmail}</a></td>
					</tr>
				</c:if>
				<c:if test="${result.ownhomTelnoUseAt eq 'Y'}">
					<tr>
						<th scope="row">자택전화번호</th>
						<td>${result.ownhomTelno}</td>
					</tr>
				</c:if>
				<c:if test="${result.mbtlnumUseAt eq 'Y'}">
					<tr>
						<th scope="row">휴대폰</th>
						<td>${result.mbtlnum}</td>
					</tr>
				</c:if>
				<c:if test="${result.cmpnyTelnoUseAt eq 'Y'}">
					<tr>
						<th scope="row">회사전화번호</th>
						<td>${result.cmpnyTelno}</td>
					</tr>
				</c:if>
				<c:if test="${result.telnoUseAt eq 'Y'}">
					<tr>
						<th scope="row">전화번호</th>
						<td>${result.telno}</td>
					</tr>
				</c:if>
				<c:if test="${result.adresUseAt eq 'Y'}">
					<tr>
						<th scope="row">주소</th>
						<td>${result.adres}</td>
					</tr>
				</c:if>
				<c:if test="${result.resdncUseAt eq 'Y'}">
					<tr>
						<th scope="row">거주지역</th>
						<td>${result.resdnc}</td>
					</tr>
				</c:if>
				<c:if test="${result.jobUseAt eq 'Y'}">
					<tr>
						<th scope="row">직업</th>
						<td>${result.jobNm}</td>
					</tr>
				</c:if>
				<c:if test="${result.psitnUseAt eq 'Y'}">
					<tr>
						<th scope="row">소속</th>
						<td>${result.psitn}</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<h4>신청부가정보</h4>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col />
			</colgroup>
			<tbody>
				<c:forEach var="addinfo" items="${result.addInfo}" varStatus="status">
					<tr>
						<th scope="row">${addinfo.iemNm}</th>
						<td>
							<c:choose>
								<c:when test="${addinfo.attrb eq '06' or addinfo.attrb eq '08'}">${addinfo.codeNm}</c:when>
								<c:when test="${addinfo.attrb eq '07'}">
									<c:set var="num" value="0"/>
									<c:forEach var="code" items="${iemCodeList}" varStatus="status">
										<c:if test="${fn:indexOf(addinfo.attrbDataCn, code.code) > -1}"><c:if test="${num > 0}">, </c:if>${code.codeNm}<c:set var="num" value="${num+1}"/></c:if>
									</c:forEach>
								</c:when>
								<c:when test="${addinfo.attrb eq '09'}">${addinfo.attrbNm}</c:when>
								<c:when test="${addinfo.attrb eq '14'}">
									<c:set var="data" value="${fn:split(addinfo.attrbDataCn,'|')}" />
									<c:out value="${data[0]}"/><br/><br/>동의여부: <c:out value="${data[1] eq 'Y' ? '동의' : '비동의'}"/>
								</c:when>
								<c:when test="${addinfo.attrb eq '15'}">
									<c:set var="files" value="${addinfo.fileMap[addinfo.atchFileId]}" />
					    			<c:if test="${not empty files}">
							    		<a href="/bos/cmm/fms/FileDown.do?atchFileId=${files[0].atchFileId}&amp;fileSn=${files[0].fileSn}">
								    		<c:out value="${files[0].orignlFileNm}"/>&nbsp;[<c:out value="${files[0].fileMg}"/>&nbsp;byte]
							    		</a>
					    			</c:if>
								</c:when>
								<c:otherwise>${addinfo.attrbDataCn}</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</P>
</c:forEach>
<!--
<script type="text/javascript">
	//var openerHtml = opener.printBody.innerHTML ;
	var contentObj = opener.document.getElementById("content");

	if(contentObj)
	{
		var openerHtml = contentObj.innerHTML;
	//	var re1 = /<\s*a/gi
	//	var re2 = /<\/\s*a/gi
	//	openerHtml = openerHtml.replace(re1, "<span");
	//	openerHtml = openerHtml.replace(re2, "<\/span");

			var str = "<div id='content'>\n"
					+ openerHtml
					+ "<\/div>";
			document.write(str);
	}

</script> -->
<noscript>
	<p style="margin-bottom:5px;">자바스크립트가 작동 되지 않는 환경입니다. 현재 창을 닫으시고, 브라우저 메뉴의 인쇄기능을 이용하십시오.</p>
</noscript>
<script type="text/javascript">
	document.getElementById("btn_print").style.display = "";
</script>
<noscript>
	<p style="margin-bottom:5px;">자바스크립트가 작동 되지 않는 환경입니다. 현재 창을 닫으시고, 브라우저 메뉴의 인쇄기능을 이용하십시오.</p>
</noscript>
</body>
</html>