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
		
		$(".radio-value").on("click", function(){
			var valueChk = $(this).val();
			var isChk = $(this).is(":checked");
			
			if(isChk){
				if(valueChk != "RE"){
					$("#attrbRetc" + $(this).attr("data")).prop("disabled", true);
					$("#attrbRetc" + $(this).attr("data")).css("background", "#E0E0E0");
				}else{
					$("#attrbRetc" + $(this).attr("data")).prop("disabled", false);
					$("#attrbRetc" + $(this).attr("data")).css("background", "#FFFFFF");
					$("#attrbRetc" + $(this).attr("data")).focus();
				}
			}
		});
		
		$(".checkbox-value").on("click", function(){
			var valueChkArr = [];
			
			$("input[name=attrbDataCn" + $(this).attr("data") + "]:checked").each(function(){
				valueChkArr.push($(this).val());
			});
			
			if(valueChkArr.indexOf("CE") > -1){
				$("#attrbCetc" + $(this).attr("data")).prop("disabled", false);
				$("#attrbCetc" + $(this).attr("data")).css("background", "#FFFFFF");
				$("#attrbCetc" + $(this).attr("data")).focus();
			}else{
				$("#attrbCetc" + $(this).attr("data")).prop("disabled", true);
				$("#attrbCetc" + $(this).attr("data")).css("background", "#E0E0E0");
			}
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
		
		var attrDuplVal = new Array(); //목록 리스트 중복체크 배열
		
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
			
			/*목록 리스트 중복체크 배열 담기 시작*/
			if(addAttrb == "06" ){ 	
				if ( $(':input[name=attrbDataCn'+aidx+']').val() != '' && $(':input[name=attrbDataCn'+aidx+']').val() != null ) //rsg20170830
					attrDuplVal.push ( $(':input[name=attrbDataCn'+aidx+']').val() ); //rsg20170830
			}
			/*목록 리스트 중복체크 배열 담기 끝*/
			
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
		
		/* 목록 리스트 중복 체크 시작 */
		if('${param.prgCl}' == '60'){
			var attrDuplResult = [];
			$.each(attrDuplVal, function(index, element){
				//if ( element == '' || element == null ) return ;//rsg20170830
				if($.inArray(element, attrDuplResult) == -1  ){ 
					attrDuplResult.push(element);
				}
			});
			
			if(attrDuplVal.length != attrDuplResult.length){
				alert("중복된 입사면접기업이 존재합니다.");
				return;
			}
		}
		/* 첨부파일 사이즈 확인 */
		if ( '${param.prgCl}' == '60' || '${param.prgCl}' == '61') {
			var flagFile = false;
			$(form).find("input[type='file']").each(function(){
				if ( !fileCheck(this) ){ //파일 사이즈 확인
					alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다."+"(최대파일사이즈 : 5MB)");
					flagFile = true;
				}
			});
			if ( flagFile ) {
				return ;
			}
		}
		
		/* 목록 리스트 중복 체크 끝 */
		if (!confirm('확인 페이지로 넘어갑니다.')) {
			return;
		}

		form.submit();
	}
	
	/* 업로드 체크 */
	function fileCheck( file )
	{
	        // 사이즈체크
	        var maxSize  = 5 * 1024 * 1024    //5MB
	        var fileSize = 0;

		// 브라우저 확인
		var browser=navigator.appName;
		
		// 익스플로러일 경우
		if (browser=="Microsoft Internet Explorer")
		{
			var oas = new ActiveXObject("Scripting.FileSystemObject");
			fileSize = oas.getFile( file.value ).size;
		}
		// 익스플로러가 아닐경우
		else
		{
			fileSize = file.files[0].size;
		}

        if(fileSize > maxSize)
        	return false;
        else return true; 
	}

//]]>
</script>

<div class="memberStep2">
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
	    <div class="step_wrap active">
	        <p class="step_box">
	            <span class="step_title">STEP2</span>
	            신청 정보 입력<span class="sr-only">(현재단계)</span>
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP3</span>
	            입력내용 확인
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

	<form name="frm" id="frm" class="mt20" action="/edu/progrm/applcnt/reg03.do?prgSn=<c:out value='${param.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="sttus" value="${param.sttus}">
	<input type="hidden" name="confmStepAt" value="${param.confmStepAt}">
		<div>
			<h3>기본정보입력</h3>
			<div class="tbrinfo text-danger clear hide_star_con"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView sub_board_body">
				<table class="table table-bordered contents_insight_view style_0">
					<caption>기본정보입력</caption>
					<colgroup>
					<col style="width:20%;">
					<col>
					</colgroup>
					<tbody>
						<c:forEach var="info" items="${listTmplatInfo}" varStatus="status">
							<c:set var="essntlAt" value="${info.essntlAt }" />
							<c:if test="${info.key == 'nm'}">
								<c:set var="essntlAt" value="Y" />
							</c:if>
							<c:import url="/edu/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
								<c:param name="viewType" value="CONTBODY" />
								<c:param name="idx" value="${status.count}" />
								<c:param name="title" value="${info.title}" />
								<c:param name="key" value="${info.key}" />
								<c:param name="sortOrdr" value="${info.sortOrdr}" />
								<c:param name="essntlAt" value="${essntlAt }" />
								<c:param name="infoData" value="${info.infoData}" />
								<c:param name="prgSn" value="${param.prgSn}" />
							</c:import>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!--
			<div class="agreeScrBtm">
				<a href="/edu/userMember/forUpdate.do?menuNo=500056" >개인정보</a>
				</table>
			</div> -->

		<c:if test="${param.prgCl != '60'}">
		<c:if test="${result.gudanceWords != null && result.gudanceWords != '' }">
			<h3>신청부가정보</h3>
			<div class="bdView sub_board_body">
				<input type="hidden" name="gudanceWords" value="${result.gudanceWords}">
				<table class="table table-bordered contents_insight_view style_0">
					<colgroup>
					<col>
					</colgroup>
					<tbody>
						<td>

							<textarea cols="120" rows="12" class="col-md-12" readonly="true" >${result.gudanceWords}</textarea>

						</td>
					</tbody>
				</table>
			</div>
		</c:if>
		</c:if>

		<c:if test="${fn:length(listTmplatAddInfo) > 0}">
			<div>
				<h3>부가정보입력</h3>
			</div>
			<div class="tbrinfo text-danger clear hide_star_con"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
			<div class="bdView sub_board_body">
				<table class="table table-bordered contents_insight_view style_0 input_delete">
					<caption>부가정보입력</caption>
					<colgroup>
					<col style="width:20%;" />
					<col/>
					</colgroup>
					<tbody>
						<c:forEach var="addInfo" items="${listTmplatAddInfo}" varStatus="status">
							<c:import url="/edu/progrm/master/tmplatAddinfo.do" charEncoding="UTF-8">
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
	<div class="board_util_btn_con">
		<a href="javascript:void(0);" onclick="javascript:history.back(0);return false;" class="fl btn_style_0 full left">이전</a>
		<a href="javascript:checkForm();" class="btn_style_0 full right">다음</a>
		<a href="/edu/progrm/master/view.do?prgSn=<c:out value='${param.prgSn}'/>&amp;menuNo=<c:out value="${param.menuNo }"/>&amp;prgSe=<c:out value="${param.prgSe }"/>&amp;prgCl=<c:out value="${param.prgCl }"/>&amp;siteSe=<c:out value="${param.siteSe }"/>" onclick="return confirm('정말로 취소하시겠습니까?');" class="btn_style_0 full close_w">취소</a>
	</div>
</div>
