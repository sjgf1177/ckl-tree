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
	<div class="signup_step_bar recruit_step">
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP1</span>
	            개인정보 동의
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP2</span>
	            신청 정보 입력
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap active">
	        <p class="step_box">
	            <span class="step_title">STEP3</span>
	            입력내용 확인<span class="sr-only">(현재단계)</span>
	        </p>
	    </div>
	    <c:choose>
		    <c:when test="${param.prgCl eq '10'}">
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP4</span>
			       접수완료
			        </p>
			    </div>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP5</span>
				필수 온라인 과정 수료
			        </p>
			    </div>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP6</span>
			            신청완료
			        </p>
			    </div>   
		    </c:when>
		    <c:otherwise>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP4</span>
			            신청완료
			        </p>
			    </div>
		    </c:otherwise>
	    </c:choose>
	</div>

<!-- 실시간 접수 상태 -->
<jsp:include page="/WEB-INF/jsp/edu/progrm/applcnt/rltm.jsp" flush="true" />

	<form name="frm" id="frm" class="mt20" action="/edu/progrm/applcnt/insert.do?prgSn=<c:out value='${param.prgSn}'/>" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="agreAt" value="${param.agreAt}">
	<input type="hidden" name="sttus" value="${param.sttus}">
	<input type="hidden" name="confmStepAt" value="${param.confmStepAt}">
	<input type="hidden" name="pageQueryString" value="menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>">
		<div>
			<h3>기본정보입력</h3>
			<div class="tbrinfo text-danger clear hide_star_con"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView sub_board_body">
				<table class="table table-bordered contents_insight_view style_0">
					<caption>기본정보입력</caption>
					<colgroup>
					<col style="width:20%">
					<col>
					</colgroup>
					<tbody>
						<c:forEach var="info" items="${infoList}" varStatus="status">
							<c:import url="/edu/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
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

		<c:if test="${param.prgCl != '60'}">
		<c:if test="${param.gudanceWords != null && param.gudanceWords != '' }">
			<h3>신청부가정보</h3>
			<div class="bdView sub_board_body">
				<input type="hidden" name="gudanceWords" value="${param.gudanceWords}">
				<table class="table table-bordered contents_insight_view style_0">
					<colgroup>
					<col>
					</colgroup>
					<tbody>
						<td>

							<textarea cols="120" rows="12" class="col-md-12" readonly="true" >${param.gudanceWords}</textarea>

						</td>
					</tbody>
				</table>
			</div>
		</c:if>
		</c:if>

		<c:if test="${fn:length(addinfoList) > 0}">
			<div>
				<h3>학습정보입력</h3>
			</div>
			<div class="tbrinfo text-danger clear hide_star_con"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView sub_board_body">
				<table class="table table-bordered contents_insight_view style_0 entityChange" style="display:none;">
					<caption>학습정보입력</caption>
					<colgroup>
					<col style="width:20%">
					<col>
					</colgroup>
					<tbody>
						<c:forEach var="addInfo" items="${addinfoList}" varStatus="status">
							<c:import url="/edu/progrm/master/tmplatAddinfo.do" charEncoding="UTF-8">
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
								<c:param name="attrbDataEtc" value="${addInfo.attrbDataEtc}" />
							</c:import>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>

		</div>
	</form>
	<div class="board_util_btn_con">
		<a href="javascript:void(0);" onclick="javascript:history.back(0);return false;" class="fl btn_style_0 full left">이전</a>
		<a href="javascript:checkForm();" class="btn_style_0 full listBook">등록</a>
		<a href="/edu/progrm/master/view.do?prgSn=<c:out value='${param.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" onclick="return confirm('정말로 취소하시겠습니까?');" class="btn_style_0 full close_w">취소</a>
	</div>
</div>

<script>
$(function(){
	// 엔터티 문자 변환 
	$(".contents_insight_view.entityChange td").each(function(){
		var arrEnName = [ "&amp;", "&amp;", "&quot;", "&apos;", "&lt;", "&gt;" ];
		var arrEnNum = [ "&", "&#38;", "&#34;", "&#39;", "&#60;", "&#62;" ];
		var $td = $(this);
		for ( var i=0; i<arrEnNum.length; i++ ){
			$td.html( decodeHtmlEntity( $td.text().replace(/&amp;/gi,"&") ) );
			console.log( $td.text() );
		} 
	});
	$(".contents_insight_view.entityChange").show();
	
	 function decodeHtmlEntity(str){
		 var element = document.createElement('div');
	      str = str.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
	      str = str.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
	      element.innerHTML = str;
	      str = element.textContent;
	      element.textContent = '';
	      
		 return str;
	 }
});
</script>