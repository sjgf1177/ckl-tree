<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>" ></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">

var codeIdVal = "COM050";

$(function(){
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#prgBgnde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#prgEndde").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#beginDate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#endDate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

/* 	getCodeList("prgCl", codeIdVal, "<c:out value='${result.prgSe}'/>", "<c:out value='${result.prgCl}'/>");

	$("select[name=prgSe]").change(function(){
		var val = $(this).val();
		getCodeList("prgCl", codeIdVal, val);
	}); */

	//대기신청 노출처리
	if ($(':radio[name="waitReqstAt"]:checked').val() == 'Y') {
		$("#waitReqstNmpr").attr("disabled", false).focus();
	}
	else {
		$("#waitReqstNmpr").attr("disabled", true);
	}

	$("input[name=waitReqstAt]").click(function(){
		var val = $(this).val();
		if (val == "Y") {
			$("#waitReqstNmpr").attr("disabled", false).focus();
		}
		else {
			$("#waitReqstNmpr").attr("disabled", true);
			$("#waitReqstNmpr").val("");
		}
	});

	$("input[name=rcritComptAt]").click(function(){
		if ($(':input[name="rcritComptAt"]:checked').val() == "Y") {
			$("#endDate").val("9999-12-31");
		}
		else {
			$("#endDate").val("");
		}
	});
	
	//신청방식 노출처리
	if ($(':radio[name="reqstMthd"]:checked').val() == "01") {
		$("#psncpa").attr("disabled", false).focus();
		$("#waitReqst").show();
	}
	else {
		$("#psncpa").attr("disabled", true);
		$("#waitReqst").hide();
	}

	$("input[name=reqstMthd]").click(function(){
		var val = $(this).val();
		if (val == "01") {
			$("#psncpa").attr("disabled", false).focus();
			$("#waitReqst").show();
		}
		else {
			$("#psncpa").attr("disabled", true);
			$("#psncpa").val("");
			$("#waitReqst").hide();
			$("#waitReqstAt1").prop("checked", true);
			$("#waitReqstNmpr").val("");
		}
	});
	
	$("input[name=indvdlinfoThreeAgreAt]").click(function(){
		if ($(':input[name="indvdlinfoThreeAgreAt"]:checked').val() == "Y") {
			$("#provider").prop("disabled", false);
		}
		else {
			$("#provider").prop("disabled", true);
		}
	});

});


	//공통 코드목록 화면처리
	function getCodeList(elemntId, codeId, upperCode, code) {
		var $obj = $("#"+ elemntId);
		var url = "/cmmn/cmmncode/codeListJson.do";
		var params = {
			codeId : codeId,
			upperCode : upperCode
		};
		$.get(url, params, function(data) {
			if (data) {
				$obj.empty();
				$("<option>").text("분류 선택").attr("value","").appendTo($obj);
				$.each(data.list, function(key,item) {
					var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
					if (code == item.code) $codeItem.attr("selected",true);
					$codeItem.appendTo($obj);
				});
				if ("prgCl" == elemntId && "" == upperCode) {
					$("<option>").text("분류 선택").attr("value","").appendTo($("#prgCl").empty());
				}
			}
		},"json");
	}

	function checkForm() {
		var form = document.frm;
		var v = new MiyaValidator(form);

		if ($("#prgSe option:selected").val() != '05') {
			v.add("prgCl", {
				required : true
			});
		}

		v.add("prgNm", {
			required : true
		});
		v.add("deptId", {
			required : true
		});
		v.add("useAt", {
			required : true
		});
		if ($("#prgCl").val() != '17'){
			v.add("telNo1", {
				required : true,
				span : 3,
				glue : "-",
				option : "phone"
			});
			v.add("prgBgnde", {
				required : true
			});
			v.add("prgEndde", {
				required : true
			});
			v.add("beginDate", {
				required : true
			});
			v.add("beginHour", {
				required : true
			});
			v.add("beginMin", {
				required : true
			});
			v.add("endDate", {
				required : true
			});
			v.add("endHour", {
				required : true
			});
			v.add("endMin", {
				required : true
			});
			v.add("reqstMthd", {
				required : true
			});

			if ($(':radio[name="reqstMthd"]:checked').val() == '01') { //선착순일때만 정원 기입
				v.add("psncpa", {
					required : true
				});
			}
			v.add("confmStepAt", {
				required : true
			});
			v.add("rceptNoIndictAt", {
				required : true
			});
			v.add("ctfhvIssuUseAt", {
				required : true
			});
			v.add("waitReqstAt", {
				required : true
			});
			if ($(':radio[name="waitReqstAt"]:checked').val() == 'Y') { //대기신청 가능할때 인원 기입
				v.add("waitReqstNmpr", {
					required : true
				});
			}

			v.add("indvdlinfoAgreAt", {
				required : true
			});
		}

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		}

		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
		    return;
		}

		var cont = CrossEditor.GetBodyValue();
		var cont2 = CrossEditor2.GetBodyValue();
			
		document.getElementById("prgCn").value= cont;
		document.getElementById("indvdlinfoAgreCn").value= cont2;
		form.submit();

	}

    function check_txt(value) {
	    if (isNaN(value)) {
	  	  alert("숫자만 입력가능합니다.");
	    return "";
		}
	    else {
	    	return value;
	    }
	}

	function del(){
		var form = document.f_regi;
		if (confirm("정말로 삭제하시겠습니까?")) {
			form.action="/bos/progrm/master/delete.do";
			form.submit();
		}
	}

	function fnSelectTch(){
		window.open("/bos/progrm/instrctr/instrctrPopup.do?viewType=BODY", "instrctrPopup", "width=940px, height=550px, scrollbars=no");
	}

</script>

<form name="frm" method="post" action="/bos/progrm/master/${empty result ? 'insert' : 'update'}.do" enctype="multipart/form-data">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" name="atchFileId" id="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="prgSn" value="${empty result ? 0 : result.prgSn}" >
	<input type="hidden" name="siteSe" value="${empty result ? param.siteSe : result.siteSe}">
	<c:if test="${paramVO.prgCl eq 17 }">
		<input type="hidden" name="prgCl" id="prgCl" value="${paramVO.prgCl}">
	</c:if>
	<h4>프로그램 정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>프로그램 정보</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="mainImg">대표이미지</label></th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="img"/>
							<c:param name="fileFieldName" value="mainImg"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
						<input type="file" name="mainImg" id="mainImg" title="대표이미지 등록 " class="col-md-8">
					</td>
				</tr>
				<tr>
					<c:choose>
						<c:when test="${paramVO.prgCl eq 17 }">
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="prgSe">구분</label></th>
							<td colspan="3">
								<input type="hidden" name="prgSe" value="${empty result ? paramVO.prgSe : result.prgSe }" />
								<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
									<c:if test="${paramVO.prgSe eq code.code}">${code.codeNm}</c:if>
								</c:forEach>
							</td>
						</c:when>
						<c:otherwise>
							<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="prgSe">구분</label></th>
							<td>
								<input type="hidden" name="prgSe" value="${empty result ? paramVO.prgSe : result.prgSe }" />
								<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
									<c:if test="${paramVO.prgSe eq code.code}">${code.codeNm}</c:if>
								</c:forEach>
								<%-- <select name="prgSe" id="prgSe" title="구분">
									<option value="">구분 선택</option>
									<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
										<c:if test="${paramVO.prgSe eq code.code}">
											<option value="${code.code}" <c:if test="${paramVO.prgSe eq code.code or result.prgSe eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
										</c:if>
									 </c:forEach>
								</select> --%>
							</td>
							<th scope="row"><label for="prgCl">분류</label></th>
							<td>
								<!-- <select name="prgCl" id="prgCl" title="분류" >
									<option value="">분류 선택</option>
								</select> -->
								<select name="prgCl" id="prgCl" title="분류" >
									<option value="">분류 선택</option>
									<c:choose>
										<c:when test="${user.authorCode eq 'ROLE_TASK_STEPUP_INSITE' }">
											<c:choose>
										 		<c:when test="${user.userId eq 'gameliteracy' }">
										 			<option value="14">게임리터러시교육</option>
										 		</c:when>
										 		<c:otherwise>
										 			<option value="12">콘텐츠 스텝업</option>
													<option value="13">콘텐츠 인사이트</option>
												<option value="15">콘텐츠 밸류업</option>
												<option value="16">게임 인재원</option>
												<option value="14">게임리터러시교육</option>
										 		</c:otherwise>
										 	</c:choose>
									</c:when>
										<c:otherwise>
											<c:forEach var="code" items="${prgSeCodeList}" varStatus="status">
											<c:if test="${paramVO.prgSe eq code.upperCode}">
													<option value="${code.code}" <c:if test="${result.prgCl eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</select>
							</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="prgNm">프로그램명</label></th>
					<td colspan="3"><input type="text" name="prgNm" id="prgNm" value="<c:out value="${result.prgNm}" />" class="col-md-12"></td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="deptId">담당부서</label></th>
					<td>
						<c:choose>
							<c:when test="${empty result}"><c:set var="deptId" value="${user.deptId}"/></c:when>
							<c:otherwise><c:set var="deptId" value="${result.deptId}"/></c:otherwise>
						</c:choose>
						<select id="deptId" name="deptId" title="담당부서">
						    <option value="">부서 선택</option>
						<c:forEach var="dept" items="${deptList}" varStatus="status">
							<option value="${dept.deptId}" <c:if test="${deptId eq dept.deptId}">selected="selected"</c:if>>${dept.deptNmKor}[${dept.deptNmEng}]</option>
						</c:forEach>
						</select>
					</td>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="useAt">사용여부</label></th>
					<td>
						<label for="useAt1"><input type="radio" name="useAt" value="Y" id="useAt1" <c:if test="${result.useAt eq 'Y'}">checked="checked"</c:if>> 사용 </label>
						<label for="useAt2"><input type="radio" name="useAt" value="N" id="useAt2" <c:if test="${result.useAt eq 'N'}">checked="checked"</c:if>> 미사용 </label>
					</td>
				</tr>
				<c:if test="${paramVO.prgCl ne 17}">
					<tr>
						<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="telNo1">발신번호</label></th>
						<td colspan="3">
							<c:set var="data" value="${fn:split(result.telNo,'-')}" />
							<c:choose>
								<c:when test="${fn:length(data) >= 3}">
									<select name="telNo1" id="telNo1" title="연락처 앞자리를 선택해 주세요." >
										<option value="">선택</option>
										<option value="02" <c:if test="${data[0] eq '02'}"> selected="selected"</c:if>>02</option>
										<option value="0505" <c:if test="${data[0] eq '0505'}"> selected="selected"</c:if>>0505</option>
										<option value="0606" <c:if test="${data[0] eq '0606'}"> selected="selected"</c:if>>0606</option>
										<option value="070" <c:if test="${data[0] eq '070'}"> selected="selected"</c:if>>070</option>
										<option value="051" <c:if test="${data[0] eq '051'}"> selected="selected"</c:if>>051</option>
										<option value="053" <c:if test="${data[0] eq '053'}"> selected="selected"</c:if>>053</option>
										<option value="032" <c:if test="${data[0] eq '032'}"> selected="selected"</c:if>>032</option>
										<option value="062" <c:if test="${data[0] eq '062'}"> selected="selected"</c:if>>062</option>
										<option value="042" <c:if test="${data[0] eq '042'}"> selected="selected"</c:if>>042</option>
										<option value="052" <c:if test="${data[0] eq '052'}"> selected="selected"</c:if>>052</option>
										<option value="044" <c:if test="${data[0] eq '044'}"> selected="selected"</c:if>>044</option>
										<option value="031" <c:if test="${data[0] eq '031'}"> selected="selected"</c:if>>031</option>
										<option value="033" <c:if test="${data[0] eq '033'}"> selected="selected"</c:if>>033</option>
										<option value="043" <c:if test="${data[0] eq '043'}"> selected="selected"</c:if>>043</option>
										<option value="041" <c:if test="${data[0] eq '041'}"> selected="selected"</c:if>>041</option>
										<option value="063" <c:if test="${data[0] eq '063'}"> selected="selected"</c:if>>063</option>
										<option value="061" <c:if test="${data[0] eq '061'}"> selected="selected"</c:if>>061</option>
										<option value="054" <c:if test="${data[0] eq '054'}"> selected="selected"</c:if>>054</option>
										<option value="055" <c:if test="${data[0] eq '055'}"> selected="selected"</c:if>>055</option>
										<option value="064" <c:if test="${data[0] eq '064'}"> selected="selected"</c:if>>064</option>
									</select>
									-
									<input type="text" id="telNo2" name="telNo2" value="${data[1]}" title="연락처 중간자리를 입력하세요." maxlength="4" />
									-
									<input type="text" id="telNo3" name="telNo3" value="${data[2]}" title="연락처 끝자리를 입력하세요." maxlength="4" />
								</c:when>
								<c:otherwise>
									<select name="telNo1" id="telNo1" title="연락처 국번 앞 3자리" >
										<option value="">선택</option>
										<option value="02">02</option>
										<option value="0505">0505</option>
										<option value="0606">0606</option>
										<option value="070">070</option>
										<option value="051">051</option>
										<option value="053">053</option>
										<option value="032">032</option>
										<option value="062">062</option>
										<option value="042">042</option>
										<option value="052">052</option>
										<option value="044">044</option>
										<option value="031">031</option>
										<option value="033">033</option>
										<option value="043">043</option>
										<option value="041">041</option>
										<option value="063">063</option>
										<option value="061">061</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="064">064</option>
									</select>
									-
									<input type="text" value="" id="telNo2" name="telNo2" title="발신번호 중간자리를 입력하세요." maxlength="4" />
									-
									<input type="text" value="" id="telNo3" name="telNo3" title="발신번호 끝자리를 입력하세요." maxlength="4" />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:if>
				<tr>
					<c:choose>
					<c:when test="${paramVO.prgCl eq 17}">
						<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span>일정</th>
						<td>
							<c:set var="beginDate">${fn:substring(result.beginDt, 0, 10)}</c:set>
							<c:set var="beginHour">${fn:substring(result.beginDt, 11, 13)}</c:set>
							<c:set var="beginMin">${fn:substring(result.beginDt, 14, 16)}</c:set>
							<input type="text" name="beginDate" id="beginDate" style="width:110px" title="행사일 입력" value="${beginDate}" readonly="readonly" />
							<select id="beginHour" name="beginHour" style="width:60px" title="행사시간 시">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="23">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq beginHour}">selected="selected"</c:if>>${val}시</option>
							</c:forEach>
							</select>

							<select id="beginMin" name="beginMin" style="width:60px" title="행사시간 분">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="59">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq beginMin}">selected="selected"</c:if>>${val}분</option>
							</c:forEach>
							</select>
						</td>
						<th scope="row"><label for="tchNm">강사</label></th>
						<td>
							<input type="text" name="tchNm" id="tchNm" value="${result.tchNm}" readonly="readonly"><a class="btn btn-default btn-sm" href="javascript:fnSelectTch();" ><span>찾기</span></a>
							<input type="hidden" name="tchSn" id="tchSn" value="${result.tchSn}">
						</td>
					</c:when>
					<c:otherwise>
						<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 교육기간</th>
						<td>
							<input type="text" id="prgBgnde" name="prgBgnde" title="교육기간 시작일 입력" style="width:110px" value="<fmt:formatDate value="${result.prgBgnde}" pattern="yyyy-MM-dd"/>">
							~
							<input type="text" id="prgEndde" name="prgEndde" title="교육기간 종료일 입력" style="width:110px" value="<fmt:formatDate value="${result.prgEndde}" pattern="yyyy-MM-dd"/>">
						</td>
						<th scope="row"><label for="tchNm">강사</label></th>
						<td>
							<input type="text" name="tchNm" id="tchNm" value="${result.tchNm}" readonly="readonly"><a class="btn btn-default btn-sm" href="javascript:fnSelectTch();" ><span>찾기</span></a>
							<input type="hidden" name="tchSn" id="tchSn" value="${result.tchSn}">
						</td>
					</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th scope="row"><label for="prgCn"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 내용</label></th>
					<td colspan="3">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
						<textarea id="prgCn" name="prgCn" cols="150" rows="30" style="display:none;" class="textarea">${result.prgCn}</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor = new NamoSE("crosseditor");
							CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor.EditorStart();

							var contentValue = document.getElementById("prgCn").value; // Hidden 값 참조
						//]]>
						</script>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="imgDescCn"> 본문이미지<br/>대체텍스트</label></th>
					<td colspan="3">
						<textarea name="imgDescCn" id="imgDescCn" cols="120" rows="10" class="col-md-12" title="본문이미지 대체텍스트을 입력해 주세요.">${result.imgDescCn}</textarea>
					</td>
				</tr>
						<!-- <div class="row">
							<div class="col-md-8">
								<div class="mb5"><input type="file" name="file" id="file" title="대표이미지 등록 " class="col-md-8"></div>
								<div><input type="file" name="FILE2" id="FILE2" title="이미지1 등록 " class="col-md-8"></div>
							</div>
							<div class="col-md-4"><a class="btn btn-primary" href="#self"><span>추가</span></a>
							<a class="btn btn-default" href="#self"><span>삭제</span></a></div>
						</div> -->
			<c:if test="${not empty fileList}">
				<tr>
					<th scope="row">첨부된 첨부파일</th>
					<td colspan="3">
						<c:import url="/bos/cmm/fms/fileList.do">
							<c:param name="listType" value="noImg"/>
							<c:param name="updateFlag" value="Y"/>
						</c:import>
					</td>
				</tr>
			</c:if>
				<tr>
					<th scope="row">첨부파일</th>
					<td colspan="3">
						<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
					</td>
				</tr>
				<c:if test="${paramVO.prgCl ne 17}">
					<tr>
						<th scope="row"><label for="stsfdgScore">만족도점수</label></th>
						<td colspan="3"><input type="text" name="stsfdgScore" id="stsfdgScore" value="${result.stsfdgScore}" onkeyup="this.value=check_txt(this.value)"> 점</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<c:if test="${paramVO.prgCl ne 17}">
	<h4>신청정보</h4>
	<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%">
			<col style="width:35%">
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 신청기간</th>
					<td>
						<div>
							<c:set var="beginDate">${fn:substring(result.beginDt, 0, 10)}</c:set>
							<c:set var="beginHour">${fn:substring(result.beginDt, 11, 13)}</c:set>
							<c:set var="beginMin">${fn:substring(result.beginDt, 14, 16)}</c:set>
							<input type="text" name="beginDate" id="beginDate" style="width:110px" title="신청기간 시작일 입력" value="${beginDate}" readonly="readonly" />
							<select id="beginHour" name="beginHour" style="width:60px" title="신청기간 시작시간">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="23">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq beginHour}">selected="selected"</c:if>>${val}시</option>
							</c:forEach>
							</select>

							<select id="beginMin" name="beginMin" style="width:60px" title="신청기간 시작분">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="59">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq beginMin}">selected="selected"</c:if>>${val}분</option>
							</c:forEach>
							</select>
							~
						</div>
						<div>
							<c:set var="endDate">${fn:substring(result.endDt, 0, 10)}</c:set>
							<c:set var="endHour">${fn:substring(result.endDt, 11, 13)}</c:set>
							<c:set var="endMin">${fn:substring(result.endDt, 14, 16)}</c:set>
							<input type="text" name="endDate" id="endDate" style="width:110px" title="신청기간 종료일 입력" value="${endDate}" readonly="readonly" />
							<select id="endHour" name="endHour" style="width:60px" title="신청기간 종료시간">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="23">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq endHour}">selected="selected"</c:if>>${val}시</option>
							</c:forEach>
							</select>
							<select id="endMin" name="endMin" style="width:60px" title="신청기간 종료분">
							    <option value="">선택</option>
							<c:forEach var="x" begin="0" end="59">
								<c:set var="val"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
								<option value="${val}" <c:if test="${val eq endMin}">selected="selected"</c:if>>${val}분</option>
							</c:forEach>
							</select>
						</div>
						<input type="checkbox" name="rcritComptAt" id="rcritComptAt" value="Y" <c:if test="${result.rcritComptAt eq 'Y'}">checked="checked"</c:if>>
						<label for="rcritComptAt"> 모집 완료 시 까지</label>
					</td>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 신청방식</th>
					<td>
						<label for="reqstMthd1"><input type="radio" name="reqstMthd" value="01" id="reqstMthd1" <c:if test="${result.reqstMthd eq '01'}">checked="checked"</c:if>> 선착순 </label>
						<label for="reqstMthd2"><input type="radio" name="reqstMthd" value="02" id="reqstMthd2" <c:if test="${result.reqstMthd eq '02'}">checked="checked"</c:if>> 기한모집 </label>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 승인단계 사용</th>
					<td>
						<label for="confmStepAt1"><input type="radio" name="confmStepAt" value="Y" id="confmStepAt1" <c:if test="${result.confmStepAt eq 'Y'}">checked="checked"</c:if>> 사용 </label>
						<label for="confmStepAt2"><input type="radio" name="confmStepAt" value="N" id="confmStepAt2" <c:if test="${result.confmStepAt eq 'N'}">checked="checked"</c:if>> 미사용 </label>
					</td>
					<th><label for="psncpa">정원</label></th>
					<td><input type="text" name="psncpa" id="psncpa" value="${result.psncpa}" onkeyup="this.value=check_txt(this.value)"> 명</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 접수번호 표시</th>
					<td>
						<label for="rceptNoIndictAt1"><input type="radio" name="rceptNoIndictAt" value="Y" id="rceptNoIndictAt1" <c:if test="${result.rceptNoIndictAt eq 'Y'}">checked="checked"</c:if>> 표시</label>
						<label for="rceptNoIndictAt2"><input type="radio" name="rceptNoIndictAt" value="N" id="rceptNoIndictAt2" <c:if test="${result.rceptNoIndictAt eq 'N'}">checked="checked"</c:if>> 숨김 </label>
					</td>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 수료증 발급</th>
					<td>
						<label for="ctfhvIssuUseAt1"><input type="radio" name="ctfhvIssuUseAt" value="Y" id="ctfhvIssuUseAt1" <c:if test="${result.ctfhvIssuUseAt eq 'Y'}">checked="checked"</c:if>> 사용 </label>
						<label for="ctfhvIssuUseAt2"><input type="radio" name="ctfhvIssuUseAt" value="N" id="ctfhvIssuUseAt2" <c:if test="${result.ctfhvIssuUseAt eq 'N'}">checked="checked"</c:if>> 미사용 </label>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 개인정보<br/>제3자 제공을 위한<br/>동의사항</th>
					<td colspan="3">
						<label for="indvdlinfoThreeAgreAt1"><input type="radio" name="indvdlinfoThreeAgreAt" value="Y" id="indvdlinfoThreeAgreAt1" <c:if test="${result.indvdlinfoThreeAgreAt ne 'N'}">checked="checked"</c:if>> 사용 </label>
						<label for="indvdlinfoThreeAgreAt2"><input type="radio" name="indvdlinfoThreeAgreAt" value="N" id="indvdlinfoThreeAgreAt2" <c:if test="${result.indvdlinfoThreeAgreAt eq 'N'}">checked="checked"</c:if>> 미사용 </label>
						<div>
							<span style="float:left" class="col-md-1">제공기관 : </span>
							<input type="text" name="provider" id="provider" class="col-md-11" value="${result.indvdlinfoProvider}" <c:if test="${result.indvdlinfoThreeAgreAt eq 'N'}">disabled="disabled"</c:if>>
						</div>
					</td>
				</tr>				
				<tr id="waitReqst">
					<th scope="row">대기신청</th>
					<td colspan="3">
						<label for="waitReqstAt1"><input type="radio" name="waitReqstAt" value="N" id="waitReqstAt1" <c:if test="${result.waitReqstAt eq 'N'}">checked="checked"</c:if>> 대기신청 불가 </label>
						<label for="waitReqstAt2"><input type="radio" name="waitReqstAt" value="Y" id="waitReqstAt2" <c:if test="${result.waitReqstAt eq 'Y'}">checked="checked"</c:if>> 대기신청 가능 </label>
						<input type="text" name="waitReqstNmpr" id="waitReqstNmpr" value="${result.waitReqstNmpr}" title="대기 신청 인원" onkeyup="this.value=check_txt(this.value)"> 명
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 추가정보<br/>수집 및 이용 동의<br/>사용</th>
					<td colspan="3">
						<label for="indvdlinfoAgreAt1"><input type="radio" name="indvdlinfoAgreAt" value="Y" id="indvdlinfoAgreAt1" <c:if test="${result.indvdlinfoAgreAt eq 'Y'}">checked="checked"</c:if>> 사용 </label>
						<label for="indvdlinfoAgreAt2"><input type="radio" name="indvdlinfoAgreAt" value="N" id="indvdlinfoAgreAt2" <c:if test="${result.indvdlinfoAgreAt eq 'N'}">checked="checked"</c:if>> 미사용 </label>

						<div>
							<textarea name="indvdlinfoAgreCn" id="indvdlinfoAgreCn" cols="120" rows="30" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" title="기타 의견을 입력해 주세요." style="display:none;" class="textarea">
<c:if test="${empty result.indvdlinfoAgreCn}">(작성 예시)
아래의 작성 예시는 참고 용이며 개인 정보를 제공 받을 경우 제공 받는 위탁사 및 개인 정보 항목에 따라 변경/고지 하여야 합니다.
위반시에는 관계 법령에 따라 처벌 받을 수 있음을 알려드립니다.

1. 개인정보를 제공받는 자 : (주)스톰미디어
2. 제공하는 개인정보의 항목 :
&nbsp;&nbsp;&nbsp;- 필수항목 : 이름 , 생년월일 , 성별 , 이메일 , 휴대폰번호
&nbsp;&nbsp;&nbsp;- 선택항목 : 없음
&nbsp;&nbsp;&nbsp;(홈페이지에서 회원 가입시 수집하는 항목 외에 추가적으로 수집하는 개인정보 항목을 모두 명시 하여야 합니다.)
3. 개인정보를 제공받는 자의 개인정보 이용목적 : 프로그램 신청/접수를 위한 사용자 정보 수집 및 이용
4. 개인정보를 제공받는 자의 개인정보 이용기간 및 보유기간 : 위탁계약 종료 시까지
※ 거부에 따른 불이익 : 추가정보의 제공을 거부하실 수 있습니다. 다만 거부하실 경우에는 관련 서비스 이용이 불가능함을 알려드립니다.</c:if><c:if test="${not empty result.indvdlinfoAgreCn}">${result.indvdlinfoAgreCn}</c:if>
</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var CrossEditor2 = new NamoSE("crosseditor2");
							CrossEditor2.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
							CrossEditor2.EditorStart();

							var contentValue2 = document.getElementById("indvdlinfoAgreCn").value; // Hidden 값 참조
							function OnInitCompleted(){

								//contentValue = contentValue.replace(/#script#/gi, "script");
								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
								CrossEditor2.SetBodyValue(contentValue2); // 컨텐츠 내용 에디터 삽입
							}
						//]]>
						</script>

						</div>
						
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</c:if>

	<div class="row clear mt20">
		<div class="col-md-11 tac">
			<a href="javascript:checkForm();" class="btn btn-primary">${empty result ? '등록' : '수정'}</a>
			<a href="javascript:del();" class="btn btn-danger">삭제</a>
		</div>
		<c:choose>
			<c:when test="${paramVO.prgCl eq 19}">
				<div class="col-md-1"><a href="/bos/progrm/applcnt/list.do?prgSn=<c:out value="${paramVO.prgSn}"/>&${pageQueryString}" class="btn btn-primary">목록</a></div>
			</c:when>
			<c:otherwise>
				<div class="col-md-1"><a href="/bos/progrm/master/list.do?${pageQueryString}" class="btn btn-primary">목록</a></div>
			</c:otherwise>
		</c:choose>
		
	</div>

</form>
