<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta charset="utf-8">
<title>		<p class="flogo thidden"><spring:message code='site.engName' text=''/></p> | ${result.orignlFileNm} 빠른보기</title>
<link rel="stylesheet" type="text/css" href="/portal/css/sub.css"/>
<style type="text/css">
body{padding: 0;margin: 0;font-size: 12px;}
h1{margin: 0;}
#quick_view{position: relative;}
.header{background-color: #2c7dc1;}
.preview_close{position: absolute;right:12px;top:16px;border:none;background-color: transparent;padding: 0;margin: 0;cursor: pointer;}
.title{margin: 20px 20px;background: url(/portal/images/common/box_tit_bu.gif) no-repeat 0 center;padding: 0 0 0 25px;font-size: 14px;font-weight: bold;line-height: 20px;}
.title a{color: #333;text-decoration:none;}
#contents{border:1px solid #d5d5d5;margin: 20px;padding: 10px;text-align: center;}
@media print {
.preview_close,
.header,
.title{display:none;}
#contents img{}
}
</style>
</head>
<body>
<div id="quick_view">
	<div class="header">
		<h1 class="fl pr20">
			<img src="/portal/images/portalPopup/preview_logo.gif" alt="CKL 빠른보기" /></h1>
	</div>
	<div class="contents">
		<p class="title">
			<a href="/portal/cmm/fms/FileDown.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}">
				${result.orignlFileNm} [${result.fileMg} byte]
				<span class="button small"><span class="ico_file2"></span><span>다운로드</span></span>
			</a>
			<!--
			<a href="/common/forDozenPrint.do?lang=${param.lang}" id="print" title="새창" onclick="window.open(this.href, 'printPage', 'width=710,height=550,scrollbars,toolbar,status');return false;" alt="인쇄하기 (자바스크립트 미지원시 브라우저 인쇄기능을 이용하세요)">
			<c:choose>
			<c:when test="${param.lang ne ''}">
			<img src="/images/popup/ico_print.gif" alt="인쇄" class="vm"  />
			</c:when>
			<c:otherwise>
			<img src="/images/popup/btn_print.gif" alt="인쇄" class="vm"  />
			</c:otherwise>
			</c:choose>
			</a> -->
		</p>
		<div class="view" id="contents">
			<c:forEach var="file" items="${imgFiles}" varStatus="status">
				<img src="${file.imgUrl}" alt="${result.orignlFileNm} 빠른보기" />
			</c:forEach>
		</div>
	</div>
	<button type="button" class="preview_close" onclick="self.close()"><img src="/portal/images/portalPopup/preview_close.gif" alt="닫기" /></button>
</div>
</body>
</html>


