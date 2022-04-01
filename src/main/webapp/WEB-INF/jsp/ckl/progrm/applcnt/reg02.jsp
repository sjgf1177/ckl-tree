<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[

	$(function(){
		$(".maskdate").each(function() {
			$(this).mask("9999-99-99");
		});
	});

	function checkForm() {
		var form = $("#frm")[0];

		/*
		기본정보 체크
		*/
	    var idx = 0;
	    var key = "";
	    var title = "";
		var msg = "";
	    var essntlAt = "";
		$(":input[name^=infoData]").each(function() {
			var iidxNm = this.name.replace('infoData', '');
			var iidx = iidxNm.split('_')[0];

			$(":input[name^=key]").each(function() { // 항목속성
				var kIdx = this.name.replace('key', '');
				if (kIdx == iidx) key = this.value;
			});
			$(":input[name^=title]").each(function() { // 속성이름
				var titIdx = this.name.replace('title', '');
				if (titIdx == iidx) title = this.value;
			});
			$(":input[name^=essntlAt]").each(function() { // 필수여부
				var essntlIdx = this.name.replace('essntlAt', '');
				if (essntlIdx == iidx) essntlAt = this.value;
			});

			if (essntlAt == "Y") {
				if (iidx != "") {
					var flag = true;

					if (key == "sex" || key == "job") {
						if ($(':radio[name=infoData'+iidx+']:checked').length == 0) {
							flag = false;
							msg = title+"을(를) 선택하세요.";
						}
					}
					else {
						if (!this.value) {
							flag = false;
							msg = title+"을(를) 입력하세요.";
						}
					}

					if (flag == false) {
						//$("#"+key).focus();
						this.focus();
						idx = iidx;
						return false;
					}
				}
			}

		});

		if (idx > 0) {
			alert(msg);
			return;
		}

		/*
		신청부가정보 체크
		*/
		var addIdx = 0;
		var addAttrb = "";
		var addIemNm = "";
		var addMsg = "";
		var addEssntlAt = "";
		$(":input[name^=attrbDataCn]").each(function() {
			var aidxNm = this.name.replace('attrbDataCn', '');
			var aidx = aidxNm.split('_')[0];

			$(":input[name^=aattrb]").each(function() { // 항목속성
				var aaidx = this.name.replace('aattrb', '');
				if (aaidx == aidx) addAttrb = this.value;
			});
			$(":input[name^=iemNm]").each(function() { // 속성이름
				var iemIdx = this.name.replace('iemNm', '');
				if (iemIdx == aidx) addIemNm = this.value;
			});
			$(":input[name^=addEssntlAt]").each(function() { // 필수여부
				var essntlIdx = this.name.replace('addEssntlAt', '');
				if (essntlIdx == aidx) addEssntlAt = this.value;
			});

			if (addEssntlAt == "Y") {
				if (aidx != "") {
					var flag = true;
					if (addAttrb == "07") {
						if ($(':input[name=attrbDataCn'+aidx+']:checked').length == 0) {
							flag = false;
							addMsg = addIemNm+"을(를) 선택하세요.";
						}
					}
					else if (addAttrb == "08") {
						if ($(':radio[name=attrbDataCn'+aidx+']:checked').length == 0) {
							flag = false;
							addMsg = addIemNm+"을(를) 선택하세요.";
						}
					}
					else {
						if (!this.value) {
							flag = false;
							if (addAttrb == "15") {
								addMsg = addIemNm+"을(를) 첨부하세요.";
							}
							else {
								addMsg = addIemNm+"을(를) 입력하세요.";
							}
						}
					}

					if (flag == false) {
						this.focus();
						addIdx = aidx;
						return false;
					}
				}
			}

		});

		if (addIdx > 0) {
			alert(addMsg);
			return;
		}

		if (!confirm('확인 페이지로 넘어갑니다.')) {
			return;
		}

		form.submit();
	}

//]]>
</script>

<div class="memberStep2">
	<div class="stepInline">
		<ol>
			<li>개인정보 동의</li>
			<li class="on">신청 정보 입력<span class="sr-only">(현재단계)</span></li>
			<li>입력내용 확인</li>
			<li>신청완료</li>
		</ol>
	</div>

<!-- 실시간 접수 상태 -->
<jsp:include page="/WEB-INF/jsp/ckl/progrm/applcnt/rltm.jsp" flush="true" />

	<form name="frm" id="frm" action="/ckl/progrm/applcnt/reg03.do?prgSn=<c:out value='${param.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="sttus" value="${param.sttus}">
	<input type="hidden" name="confmStepAt" value="${param.confmStepAt}">
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
						<c:forEach var="info" items="${listTmplatInfo}" varStatus="status">
							<c:import url="/ckl/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
								<c:param name="viewType" value="CONTBODY" />
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
			<!--
			<div class="agreeScrBtm">
				<a href="/ckl/userMember/forUpdate.do?menuNo=500056" >개인정보</a>
			</div> -->

			<h2>신청부가정보</h2>
			<div class="alert alert-info">
				<input type="hidden" name="gudanceWords" value="${result.gudanceWords}">
				${result.gudanceWords}
			</div>

		<c:if test="${fn:length(listTmplatAddInfo) > 0}">
			<div>
				<h3>부가정보입력</h3>
			</div>
			<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView">
				<table class="table table-bordered">
					<caption>부가정보입력</caption>
					<colgroup>
					<col style="width:15%">
					<col>
					<col style="width:15%">
					<col>
					</colgroup>
					<tbody>
						<c:forEach var="addInfo" items="${listTmplatAddInfo}" varStatus="status">
							<c:import url="/ckl/progrm/master/tmplatAddinfo.do" charEncoding="UTF-8">
								<c:param name="viewType" value="CONTBODY" />
								<c:param name="idx" value="${status.count}" />
								<c:param name="attrbDataCn" value="${addInfo.attrbDataCn}" />
								<c:param name="addinfoSn" value="${addInfo.addinfoSn}" />
								<c:param name="iemNm" value="${addInfo.iemNm}" />
								<c:param name="attrb" value="${addInfo.attrb}" />
								<c:param name="addEssntlAt" value="${addInfo.essntlAt}" />
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
		<a href="javascript:checkForm();" class="btn btn-primary">다음</a>
		<a href="/ckl/progrm/master/view.do?prgSn=<c:out value='${param.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" onclick="return confirm('정말로 취소하시겠습니까?');" class="btn btn-primary">취소</a>
	</div>
</div>
<br/><br/><br/><br/><br/><br/><br/><br/>