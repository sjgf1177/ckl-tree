<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">
//<![CDATA[
	function checkForm() {
		var form = $("#frm")[0];

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		form.submit();
	}
//]]>
</script>

<div class="memberStep3">
	<div class="stepInline">
		<ol>
			<li>개인정보 동의</li>
			<li>신청 정보 입력</li>
			<li class="on">입력내용 확인<span class="sr-only">(현재단계)</span></li>
			<li>신청완료</li>
		</ol>
	</div>

<!-- 실시간 접수 상태 -->
<jsp:include page="/WEB-INF/jsp/ckl/progrm/applcnt/rltm.jsp" flush="true" />

	<form name="frm" id="frm" action="/ckl/progrm/applcnt/insert.do?prgSn=<c:out value='${param.prgSn}'/>" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="agreAt" value="${param.agreAt}">
	<input type="hidden" name="sttus" value="${param.sttus}">
	<input type="hidden" name="confmStepAt" value="${param.confmStepAt}">
	<input type="hidden" name="pageQueryString" value="menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>">

		<div>
			<h3>기본정보입력</h3>
			<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>기본정보입력</caption>
					<colgroup>
					<col style="width:15%">
					<col>
					</colgroup>
					<tbody>
						<c:forEach var="info" items="${infoList}" varStatus="status">
							<c:import url="/ckl/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
								<c:param name="viewType" value="CONTBODY" />
								<c:param name="mode" value="M" />
								<c:param name="idx" value="${status.count}" />
								<c:param name="title" value="${info.title}" />
								<c:param name="key" value="${info.key}" />
								<c:param name="sortOrdr" value="${info.sortOrdr}" />
								<c:param name="essntlAt" value="${info.essntlAt}" />
								<c:param name="infoData" value="${info.infoData}" />
								<c:param name="prgSn" value="${param.prgSn}" />
							</c:import>
						</c:forEach>
					</tbody>
				</table>
			</div>

		<c:if test="${param.agreAt eq 'Y'}">
			<div class="agreeScrBtm">
				<p>회원정보를 입력한 개인정보 내용으로 변경합니다.</p>
			</div>
		</c:if>

			<h2>신청부가정보</h2>
			<div class="alert alert-info">${param.gudanceWords}</div>

		<c:if test="${fn:length(addinfoList) > 0}">
			<div>
				<h3>학습정보입력</h3>
			</div>
			<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>학습정보입력</caption>
					<colgroup>
					<col style="width:15%">
					<col>
					<col style="width:15%">
					<col>
					</colgroup>
					<tbody>
						<c:forEach var="addInfo" items="${addinfoList}" varStatus="status">
							<c:import url="/ckl/progrm/master/tmplatAddinfo.do" charEncoding="UTF-8">
								<c:param name="viewType" value="CONTBODY" />
								<c:param name="mode" value="M" />
								<c:param name="idx" value="${status.count}" />
								<c:param name="attrbDataCn" value="${addInfo.attrbDataCn}" />
								<c:param name="addinfoSn" value="${addInfo.addinfoSn}" />
								<c:param name="iemNm" value="${addInfo.iemNm}" />
								<c:param name="attrb" value="${addInfo.attrb}" />
								<c:param name="addEssntlAt" value="${addInfo.addEssntlAt}" />
								<c:param name="sortOrdr" value="${addInfo.sortOrdr}" />
								<c:param name="attrbNm" value="${addInfo.attrbNm}" />
								<c:param name="iemCodeId" value="${addInfo.iemCodeId}" />
								<c:param name="fileNm" value="${addInfo.fileNm}" />
								<c:param name="prgSn" value="${param.prgSn}" />
							</c:import>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>

		</div>
	</form>
	<div class="btnSet tac">
		<a href="#" onclick="javascript:history.back(0);return false;" class="fl btn btn-primary">이전</a>
		<a href="javascript:checkForm();" class="btn btn-primary">저장</a>
		<a href="/ckl/progrm/master/view.do?prgSn=<c:out value='${param.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" onclick="return confirm('정말로 취소하시겠습니까?');" class="btn btn-primary">취소</a>
	</div>
</div>
