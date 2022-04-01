<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty result}">
	<c:set var="action" value="/edu/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/edu/bbs/${paramVO.bbsId}/update.do" />
</c:if>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript">
//<![CDATA[
	var mberSe = "<c:out value='${user.mberSe}'/>";
	var gugunVal = "<c:out value='${param.gugun}'/>";

	crtfcPopup = function(authSe) { // 이메일/휴대폰 인증 팝업창
		var val = "";
		var email = $("#email1").val()+"@"+$("#email2").val();
		var mbtlnum = $("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val();
		var height = "343";
		var mode = "";

		if (authSe == "01") {
			val = email;
			height = "463";
			mode= "Y";
			
			window.open("/edu/userMember/crtfcEmailPopup.do?viewType=BODY&authSe="+authSe+"&val="+val+"&mode="+mode, "crtfcPopup", "top=300, left=600, width=568, height="+height+", status=yes, resizable=yes, scrollbars=no");
		}else{
			val = mbtlnum;
			height = "463";
			mode = "Y";
			
			window.open("/edu/userMember/crtfcPopup.do?viewType=BODY&authSe="+authSe+"&val="+val+"&mode="+mode, "crtfcPopup", "top=300, left=600, width=568, height="+height+", status=yes, resizable=yes, scrollbars=no");
		}
		
	};

	authDel = function(authSe) {
		if(authSe == "01"){ 
			// 휴대폰 인증 삭제
			$("#mbtlnumAuthAt").val("");
			$("#mbtlnumAuth").show();
			$("#mbtlnumAuthCmt").hide();
			$("#mbtlnumAuthDel").hide();
			$("#mbtlnum1").attr('disabled', false);
			$("#mbtlnum2").attr('disabled', false);
			$("#mbtlnum3").attr('disabled', false);
			$("#mbtlnum").val("");
		}else if(authSe == "02"){
			// 이메일 인증 삭제
			$("#emailAuthAt").val("");
			$("#emailAuth").show();
			$("#emailAuthCmt").hide();
			$("#emailAuthDel").hide();
			$("#email1").attr('disabled', false);
			$("#email2").attr('disabled', false);
			$("select.input_select.select_email_js").attr("disabled", false);
			$("#email").val("");
		}
	};
	$(function(){
		$(".boardType > li").css({"display":"none"});
		$(".boardType > li.active").css({"display":"block"});
		if($(".boardType > li.active").index() == 0){
			$(".type02, .type03").css({"display":"none"});
			if(${empty result}){
				$("div.type01").css({"display":"block"});	
			}
			$("tr.type01").css({"display":"table-row"});
		}else if($(".boardType > li.active").index() == 1){
			$(".type01, .type03").css({"display":"none"});
			$("div.type02").css({"display":"block"});
			$("tr.type02").css({"display":"table-row"});
		}else if($(".boardType > li.active").index() == 2){
			$(".type01, .type02").css({"display":"none"});
			$("div.type03").css({"display":"block"});
			$("tr.type03").css({"display":"table-row"});
		}
		
		$("input[name=userAuth]").change(function(){
			if($("#phoneAt").is(":checked")){
				$(".phoneAtTr").css({"display":"table-row"});
				$(".emailAtTr").css({"display":"none"});
			}else{
				$(".emailAtTr").css({"display":"table-row"});
				$(".phoneAtTr").css({"display":"none"});
			}
		});
		
		$("input[type=radio][name=option2]").on('change', function(){
			var idx = $("input[name='option2']:checked").val();
			var txtIdx = idx == '01' ? 1 : idx == '02' ? 2 : idx == '03' ? 3 : '';
			$(".boardType li:nth-child("+txtIdx+")").addClass("active");
			$(".boardType li:nth-child("+txtIdx+")").siblings("li").removeClass("active");
			
			$(".boardType > li").css({"display":"none"});
			$(".boardType > li.active").css({"display":"block"});
			if($(".boardType > li.active").index() == 0){
				$(".type02, .type03").css({"display":"none"});
				$("div.type01").css({"display":"block"});
				$("tr.type01").css({"display":"table-row"});
			}else if($(".boardType > li.active").index() == 1){
				$(".type01, .type03").css({"display":"none"});
				$("div.type02").css({"display":"block"});
				$("tr.type02").css({"display":"table-row"});
			}else if($(".boardType > li.active").index() == 2){
				$(".type01, .type02").css({"display":"none"});
				$("div.type03").css({"display":"block"});
				$("tr.type03").css({"display":"table-row"});
			}
		})
	})
	

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		
		if($("input[name='option2']:checked").val() == '01'){
			//건의하기
			if("${empty result}" == "true"){
				
				v.add("agreAt1", {
			        required: true
			    });
				
			    if ($("#emailAuthAt").val() == "" && $("#mbtlnumAuthAt").val() == "") {
					alert("이메일, 휴대폰 1개이상 인증해야 합니다.");
					return;
				}
			}
		}else if($("input[name='option2']:checked").val() == '02'){
			//참여하기
			v.add("option1", {
		        required: true
		    });
		}else{
			//불편사항 접수
			
		}
		v.add("ntcrNm", {
	        required: true
	    });
		v.add("nttSj", {
	        required: true
	    });
	    v.add("nttCn", {
	        required: true
	    });

		
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm("등록하시겠습니까?")) {
			return;
		}

		form.submit();
	}

	function check_txt(value) {
	    if (isNaN(value)) {
			alert("숫자로만 입력하셔야 합니다.");
			return "";
		}
	    else {
	    	return value;
	    }
	}
	
	/* function typeChange(ele){
		var idx = $(ele).val();
		var txtIdx = idx == '01' ? 1 : idx == '02' ? 2 : idx == '03' ? 3 : '';
		$(".boardType li:nth-child("+txtIdx+")").addClass("active");
		$(".boardType li:nth-child("+txtIdx+")").siblings("li").removeClass("active");
		
		$(".boardType > li").css({"display":"none"});
		$(".boardType > li.active").css({"display":"block"});
		if($(".boardType > li.active").index() == 0){
			$(".type02, .type03").css({"display":"none"});
			$("div.type01").css({"display":"block"});
			$("tr.type01").css({"display":"table-row"});
		}else if($(".boardType > li.active").index() == 1){
			$(".type01, .type03").css({"display":"none"});
			$("div.type02").css({"display":"block"});
			$("tr.type02").css({"display":"table-row"});
		}else if($(".boardType > li.active").index() == 2){
			$(".type01, .type02").css({"display":"none"});
			$("div.type03").css({"display":"block"});
			$("tr.type03").css({"display":"table-row"});
		}
		
	} */
	
	function del(){
		var form = $("#board")[0];
		form.action = "/edu/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	} 
//]]>
</script>
<div class="mb50 alert big_box type_1">
	<p class="alert_title short_bottom" style="margin-bottom:0;">
		함께 : 톡톡은 에듀코카 서비스를 이용하시면서 불편하거나 개선이 필요한 부분 그리고 콘텐츠인재양성 프로그램에 제안하고 싶은 사항에 대한 <span class="apply_no_text">의견을 기재하는 공간</span>입니다.
	</p>
</div>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="ntcrTel" value="<c:out value='${user.moblphon}'/>"/>
	<input type="hidden" name="ntcrEmail" value="<c:out value='${user.email}'/>"/>
	<input type="hidden" name="nttId" value="<c:out value='${empty result.nttId ? 0 : result.nttId}'/>" />
	<input type="hidden" name="bbsId" value="<c:out value='${masterVO.bbsId}'/>" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="<c:out value='${result.atchFileId}'/>">
	<input type="hidden" name="htmlAt" value="${empty result ? 'N' : result.htmlAt }" />
	<input type="hidden" name="option20" value="${user.userId }" />
	<input type="hidden" name="myAt" value="Y" />
	
	<div class="sub_board_header">
		<div class="table_style_0">
			<span class="radio_box_con" style="<c:if test="${not empty result && result.option2 ne '03'}" >display:none;</c:if>">
				<input type="radio" class="radio_style_0" name="option2" id="option2_03"<c:if test="${result.option2 eq '03' || empty result}">checked="checked"</c:if> value="03" title="불편사항 접수" style="height:auto;">
				<label for="option2_03" style="top:0">	
					불편사항 접수
				</label>
			</span>
			<span class="radio_box_con" style="<c:if test="${not empty result && result.option2 ne '02'}" >display:none;</c:if>">
				<input type="radio" class="radio_style_0" name="option2" id="option2_02"<c:if test="${result.option2 eq '02'}">checked="checked"</c:if> value="02" title="참여하기" style="height:auto;">
				<label for="option2_02" style="top:0">
					참여하기
				</label>
			</span>
			<span class="radio_box_con" style="<c:if test="${not empty result && result.option2 ne '01'}" >display:none;</c:if>">
				<input type="radio" class="radio_style_0" name="option2" id="option2_01"<c:if test="${result.option2 eq '01'}">checked="checked"</c:if> value="01" title="건의하기" style="height:auto;">
				<label for="option2_01" style="top:0">
					건의하기
				</label>
			</span>
			<%-- <select name="option2" id="option2" class="arrow" title="질문하려는 분야를 선택해 주십시오" onchange="typeChange(this)" style="margin-right:20px;">
				<option value="01" <c:if test="${result.option2 eq '01'}">selected="selected"</c:if> <c:if test="${not empty result && result.option2 ne '01'}" >style="display:none;"</c:if>>공감</option>
				<option value="02" <c:if test="${result.option2 eq '02'}">selected="selected"</c:if> <c:if test="${not empty result && result.option2 ne '02'}" >style="display:none;"</c:if>>참여</option>
				<option value="03" <c:if test="${result.option2 eq '03'}">selected="selected"</c:if> <c:if test="${not empty result && result.option2 ne '03'}" >style="display:none;"</c:if>>같이</option>
			</select> --%>
			
			<ul class="list_style_2 boardType" style="margin-top:10px;">
				<li <c:if test="${result.option2 eq '01'}"> class='active'</c:if>>
					홈페이지 개선 및 교육 프로그램 성장을 위한 의견 접수
				</li>
				
				<li <c:if test="${result.option2 eq '02'}"> class='active'</c:if>>
					콘텐츠 인재 양성 사업 관련 아이디어 및 의견 접수
				</li>
				<li <c:if test="${result.option2 eq '03'}"> class='active'</c:if> <c:if test="${empty result}"> class='active'</c:if>>
					교육 내용 문의, 홈페이지 및 학습 오류 등 이용에 대한 불편 사항 접수
				</li>
			</ul>
		</div>
	</div>
	<div class="signup_write_con type01" style="margin-bottom:80px; <c:if test='${not empty result}'>display:none;</c:if>">
		<h3>개인정보 수집 및 이용동의</h3>
		<div tabindex="0" class="agreeScr" style="font-size: 1.4rem; line-height: 2.05rem;">
	       	에듀코카는 원활한 고객상담, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 필수 정보를 수집합니다.
			<br><br>
			<strong style="color:#3C309C; font-size:130%;">개인정보보호를 위한 이용자 동의사항</strong>
			<br>
			1. 수집&middot;이용 목적 : 회원제 서비스 제공 및 고객 맞춤형 서비스 목적<br>
			<br>
			2. 개인정보 수집 항목<br>
			&nbsp;&nbsp;<strong style="color:#3C309C">[개인회원정보]</strong><br>
			&nbsp;&nbsp;&nbsp;&nbsp;항목 : 이름, 생년월일, 성별, 아이디, 비밀번호, 이메일, 휴대폰, 인재캠퍼스 정보수신 여부, 콘텐츠문화광장 정보수신 여부, 직업,<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			14세 미만인 경우 보호자의 이름 및 휴대폰 번호<br> 
			&nbsp;&nbsp;<strong style="color:#3C309C">[온라인교육 수강정보]</strong><br>
			&nbsp;&nbsp;&nbsp;&nbsp;항목 : 아이디, 성명, 휴대폰, 이메일, 수강과목정보<br>
			&nbsp;&nbsp;<strong style="color:#3C309C">[오프라인교육 신청정보]</strong><br>
			&nbsp;&nbsp;&nbsp;&nbsp;항목 : 아이디, 이름, 생년월일, 성별, 이메일, 휴대폰번호, 소속<br>
			&nbsp;&nbsp;<strong style="color:#3C309C">[시설예약 신청]</strong><br>
			&nbsp;&nbsp;&nbsp;&nbsp;항목 : 이름, 휴대폰, 이메일, 사용인원, 사용목적, 예약정보수신방법<br>
			<br>
			<strong style="color:#3C309C; font-size:130%">3. 개인정보 보유 및 이용기간 : 3년 혹은 회원 탈퇴 후 즉시 삭제</strong><br>
			<br>
	        4. 동의 거부 시 불이익에 관한 사항 : 수집 &middot;이용에 관한 사항의 동의를 거부할 때에는 해당 서비스의 이용이 제한됩니다.<br>
	    </div>
		<div class="agreeScrBtm" style="line-height: 2.05rem; font-size: 1.6rem; text-align:right;">
			<span class="radio_box_con">
	 			<input type="checkbox" name="essentialAgreAt"  id="agreAt1" value="Y" title="동의합니다." tabindex="0">
	        	<label for="agreAt1">&nbsp;&nbsp;&nbsp;&nbsp;(필수) 개인정보 수집 및 이용 내용에 동의합니다.</label>
	        </span>
	    </div>
	</div>
	
	<div class="signup_write_con type01" style="margin-bottom:80px; <c:if test="${not empty result}" >display:none;</c:if>">
		<h3>본인 인증(휴대폰 및 이메일)</h3>
		<div class="input_wrap no_margin">
			<span class="radio_box_con">
				<input type="radio" class="radio_style_0" name="userAuth" value="01" id="phoneAt" checked="checked" title="본인인증 선택 라디오 - 휴대폰 인증">
				<label for="phoneAt">휴대폰 인증</label>
			</span>
			<span class="radio_box_con">
				<input type="radio" class="radio_style_0" name="userAuth" value="02" id="emailAt" title="본인인증 선택 라디오 - 이메일 인증">
				<label for="emailAt">이메일 인증</label>
			</span>
		</div>
		<table class="table_style_0 contents_insight_view">
			<caption>본인확인 게시판입니다.</caption>
			<colgroup>
				<col width="20%" class="board_header_column">
				<col width="auto">
			</colgroup>
			<tbody style="border-top:2px solid #cccccc;">
				<tr class="phoneAtTr">
					<th>
						<span>휴대폰</span>
					</th>
					<td>
						<span class="board_type_1_select_con">
							<select class="select_style_1 arrow size_15" name="mbtlnum1" id="mbtlnum1" title="휴대폰 앞자리">
								<option value="" title="선택">선택</option>
								<option value="010" title="010">010</option>
								<option value="011" title="011">011</option>
								<option value="016" title="016">016</option>
								<option value="017" title="017">017</option>
								<option value="018" title="018">018</option>
								<option value="019" title="019">019</option>
							</select>
							<!-- <label for="mbtlnum1"></label> -->
						</span>
						<span class="table_text line">-</span>
						<span class="board_type_1_input_con" style="display:inline;">
							<input type="text" value="" id="mbtlnum2" name="mbtlnum2" class="input_style_0 phone" title="휴대폰 중간자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" style="width:25%; min-width:80px;">
							<!-- <label for="mbtlnum2"></label> -->
						</span>
						<span class="table_text line">-</span>
						<span class="board_type_1_input_con" style="display:inline">
							<input type="text" class="input_style_0 phone" value="" id="mbtlnum3" name="mbtlnum3" title="휴대폰 끝자리를 입력하세요." maxlength="4" onkeyup="this.value=check_txt(this.value)" style="width:25%; min-width:80px;">
							<!-- <label for="mbtlnum3"></label> -->
						</span>
						<input type="hidden" name="mbtlnum" id="mbtlnum">
						<input type="hidden" name="mbtlnumAuthAt" id="mbtlnumAuthAt">
						<a href="javascript:crtfcPopup('02');" title="휴대폰 인증하기(새창열림)" class="btn btn-default btn-sm" id="mbtlnumAuth" style="background:#0480A9; color:white;">인증하기</a>
						<a href="#self" class="btn btn-success btn-sm" id="mbtlnumAuthCmt" style="display:none;">인증완료</a>
						<a href="javascript:authDel('01');" onclick="return confirm('인증삭제를 하시겠습니까?');" class="btn btn-danger btn-sm" id="mbtlnumAuthDel" style="display:none;">인증삭제</a>
					</td>
				</tr>
				<tr class="emailAtTr" style="display:none;">
					<th><span>이메일</span></th>
					<td>
						<input name="email1" id="email1" class="w20p" type="text" title="이메일 아이디" value="" />
						@
						<input name="email2" id="email2" class="w20p emaildomain_form" type="text" title="이메일 주소" value="" />
						<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
						<select id="sr_email_more" class="input_select select_email_js" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
							<option selected="selected">메일주소선택</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
		                    <option value="hanmail.net">hanmail.net</option>
		                    <option value="daum.net">daum.net</option>
		                    <option value="hotmail.com">hotmail.com</option>
		                    <option value="nate.com">nate.com</option>
		                    <option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="emaildomain_false">직접입력</option>
						</select>
						<script type="text/javascript">
						//<![CDATA[
						jQuery(function(){
							$('#email2').attr('readonly',true);
							$('select.select_email_js').change(function() {
								if ($(this).val()=='emaildomain_false') {
									$('#email2').val('');
									$('#email2').attr('readonly',false).focus();
								}
								else {
									$('#email2').val('');
									$('#email2').val($(this).val());
									$('#email2').attr('readonly',true);
								}
							});
						});
						//]]>
						</script>

						<input type="hidden" name="authEmailAt" value="N" />
						<input type="hidden" name="emailAuthAt" id="emailAuthAt" /> <!-- 스크립트체크 -->
						<input type="hidden" name="email" id="email">
						<a href="javascript:crtfcPopup('01');" title="이메일 인증하기(새창열림)" class="btn btn-default btn-sm" id="emailAuth" style="background:#0480A9; color:white;">인증하기</a>
						<a href="#self" class="btn btn-success btn-sm" id="emailAuthCmt" style="display:none;">인증완료</a>
						<a href="javascript:authDel('02');" onclick="return confirm('인증삭제를 하시겠습니까?');" class="btn btn-danger btn-sm" id="emailAuthDel" style="display:none;">인증삭제</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="signup_write_con">
		<h3>접수 내용(<span style="color:red;">*<span class="ally-hidden">(필수)</span></span>표는 필수항목)</h3>
		<table class="table_style_0 contents_insight_view">
			<caption>접수내용 게시판입니다.</caption>
			<colgroup>
				<col width="20%" class="board_header_column">
				<col width="auto">
			</colgroup>
			<tbody style="border-top:2px solid #cccccc;">
				<tr>
					<th class="warning_text">
						<span class="ally-hidden">(필수)</span>
						<span>이름</span>
					</th>
					<td>
						<span class="board_type_1_input_con">
							<input type="text" class="input_style_0" name="ntcrNm" id="ntcrNm" value="<c:out value='${empty result ? user.userNm : result.ntcrNm}'/>" title="이름을 입력해 주십시오">				
						</span>
					</td>
				</tr>
				<tr class="type02">
					<th class="warning_text">
						<span class="ally-hidden">(필수)</span>
						<span>참여사업명</span>
					</th>
					<td>
						<span class="board_type_1_input_con" style="width:100%">
							<input type="text" name="option1" id="option1" value="<c:out value='${result.option1}'/>" class="input_style_0" title="참여사업명을 입력해 주십시오" style="width:100%">
						</span>
					</td>
				</tr>
				<tr>
					<th class="warning_text">
						<span class="ally-hidden">(필수)</span>
						<span>제목</span>
					</th>
					<td>
						<span class="board_type_1_input_con" style="width:100%">
							<input type="text" name="nttSj" id="nttSj" value="<c:out value='${result.nttSj}'/>" class="input_style_0" title="제목을 입력해 주십시오" style="width:100%">
						</span>
					</td>
				</tr>
				<tr>
					<th class="warning_text">
						<span class="ally-hidden">(필수)</span>
						<span>내용</span>
					</th>
					<td>
						<span class="board_type_1_textarea_con" style="width:100%">
							<textarea name="nttCn" id="nttCn" rows="10" onfocus="if(this.value=='내용을 입력하세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하세요.')this.value='';" title="내용을 입력하세요." style="width:100%">${result.nttCn}</textarea>
						</span>
					</td>
				</tr>
				<tr class="type03">
					<th>
						<span>첨부파일</span>
					</th>
					<td>
						<div>첨부된 파일</div>
						<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
						
						
						<c:if test="${not empty result.atchFileId}">
							<div>첨부파일</div>
							<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

</form>

<div class="btnSet tac">
	<a href="javascript:checkForm();" class="btn btn-primary" style="font-size:1.4rem;">저장</a>
	<c:if test="${not empty result}" >
		<a href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');" class="btn btn-gray" style="font-size:1.4rem;">삭제</a>
	</c:if>
</div>
<!--  webfilter -->
<%@ include file="/webfilter/inc/initCheckWebfilter.jsp"%>
<!--  webfilter -->

