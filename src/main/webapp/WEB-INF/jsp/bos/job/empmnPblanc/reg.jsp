
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<sec:authentication var="user" property="principal"/>
<c:if test="${empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/update.do" />
</c:if>
<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">
//<![CDATA[
	var codeIdVal = "COM093";
	var ctgrySe1Val = "<c:out value='${fn:trim(result.chrgJob2) }' />";
	var ctgrySe2Val = "<c:out value='${fn:trim(result.chrgJob) }' />";
	$(function() {
		//init
		if (ctgrySe1Val != "") getCodeList("chrgJob", 'COM093', $("#chrgJob2").val(), 2, ctgrySe2Val);

		//모집분야 event
		$("#chrgJob2").change(function() {
			getCodeList("chrgJob", codeIdVal, $(this).val(), 2);

		});

		if($('#careerSe').val() == '02'){
			$("#careerOther").show();
		}


		$('input:radio[name="sex"]:radio[value="<c:out value='${result.sex }'/>"]').attr("checked","checked");

		$(".entrprsChoise").click(function() {
			var url = $(this).attr("href");
			console.log(url);
			window.open(url, "entrprsList", "scrollbars=yes,width=800, height=700");
			return false;
		});


		$('#careerSe').on('change', function() {
			$carrerSe = $(this).val();
			if($carrerSe =="02" ){
				$("#career").val("");
				$("#careerOther").show();
			}else {
				$("#career").val("");
				$("#careerOther").hide();

			}
		});

		$('#rceptComptAt').on('change', function() {
			$rtca = $(this).val();
			if($rtca > 1){
				$("#rceptEndDt").val("");
			}
		});

	});

	function getCodeList(elemntId, codeId, upperCode, depth, code) {
		var $obj = $("#"+ elemntId);
		var url = "/cmmn/cmmncode/codeListJson.do";
		var params = {
			codeId : codeId,
			upperCode : upperCode
		};
		$.get(url, params, function(data) {
			if (data) {
				$obj.empty();
				if (depth == 1) $("<option>").text("카테고리구분1 선택").attr("value","").appendTo($obj);
				else if (depth == 2) $("<option>").text("카테고리구분2 선택").attr("value","").appendTo($obj);
				$.each(data.list, function(key,item) {
					var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
					if (code == item.code) $codeItem.attr("selected",true);
					$codeItem.appendTo($obj);
				});

				if (ctgrySe2Val="" && ctgrySe2Val != "") {
					getCodeList("chrgJob", codeIdVal, $("#chrgJob2").val(), 2, ctgrySe2Val);
				}
				else if ("chrgJob" == elemntId && "" == upperCode) {
// 					$("<option>").text("카테고리구분1 선택").attr("value","").appendTo($("#ctgrySe1").empty());
// 					$("<option>").text("카테고리구분2 선택").attr("value","").appendTo($("#ctgrySe2").empty());
				}
			}
		},"json");
	}

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		var workStle = "";
		v.add("entrprsNm", {
			required : true
		});

		v.add("pblancNm", {
			required : true
		});

		v.add("chrgJob2", {
			required : true
		},"모집분야");


		v.add("kwrd", {
			required : true
		});

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
		if (!confirm('등록하시겠습니까?')) {
			return;
		}
		var cont = CrossEditor.GetBodyValue();
		document.getElementById("jobCn").value = cont;

		var cksw = $('input:checkbox[name="useAtData"]').is(":checked");
		if (cksw == true) {
			$('#useAt').val('Y');
		} else {

			$('#useAt').val('N');

		}

		$(":input[name^=workStleData]:checked").each(function(){
			workStle += $(this).val() + ",";
		});

		workStle = workStle.substring(0,workStle.length-1);
		$("#workStle").val(workStle);
		form.submit();
	}

	function del() {
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delete.do";
		form.submit();
	}

	function restore() {
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/restore.do";
		form.submit();
	}

	function delPermanently() {
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delPermanently.do";
		form.submit();
	}
	//]]>
</script>
<title><c:out value='${masterVO.bbsNm}'/> - 게시물 <c:out value="${empty result ? '쓰기' : '수정' }" /> </title>
</head>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
<input type="hidden" name="pblancSn" value="${empty result.pblancSn ? 0 : result.pblancSn }" />
<input type="hidden" name="entrprsSn" id="entrprsSn" value="${result.entrprsSn }" />
<input type="hidden" name="workStle" id="workStle" value="" />
<input type="hidden" name="useAt"  id="useAt" value="" />
<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<h4>■ 기업정보</h4>

	<div class="bdView">
		<table>
			<caption>
			기업정보
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col style="width:35%" />
			<col style="width:15%" />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="entrprsNm">기업선택</label></th>
					<td colspan="3">
						<input type="text" id="entrprsNm" name="entrprsNm" value="<c:out value="${result.entrprsNm }" />" title="기업명" readonly="readonly" />
						<c:url var="popupUrl" value="/bos/job/entrprsManage/entrprsListPopup.do" >
							<c:param name="viewType" value="BODY"/>
							<c:param name="objEntrprsNm" value="entrprsNm" />
							<c:param name="objCharger" value="charger" />
							<c:param name="objTelno" value="telno" />
							<c:param name="objEmail" value="email" />
							<c:param name="objEntrprsSn" value="entrprsSn" />
						</c:url>
						<a href="<c:out value="${popupUrl }" />" class="btn btn-primary entrprsChoise" id="mberPoPBtn">찾기</a>
						<br />
						* 기업이 없는 경우 등록 후 채용공고를 등록하시기 바랍니다.
						<!-- rsg20180119 --> 
						<br />
						※ 공고자료가 아래에서 제공된 경우 체크 필수! 
						<br />
						<c:set var='infoFix' value='${result.infoFix eq null?-1:result.infoFix}'/>
						<%
						// 채용공고란  고정 문구 및 로고 수정 사항 ( rsg20180119 )
						// 								1
						String [] arrInfoFix = { "", "미디어잡" }; // 고정 기업 목록
						int nInfoFix = Integer.parseInt(pageContext.getAttribute("infoFix").toString());
						//int nInfoFix = Integer.parseInt((String)pageContext.getAttribute("infoFix"));
						//int nInfoFix = (String)pageContext.getAttribute("infoFix") != null ? (String)pageContext.getAttribute("infoFix") : -1 ;
						for ( int e=1; e<arrInfoFix.length; e++ ){
						%> 
							<!-- infoFix: <%= pageContext.getAttribute("infoFix") %> -->
							<label>
							<input type="checkbox" <%= (nInfoFix==e?"checked='checked'":"") %> value="<%=e%>" name="infoFix" id="infoFix"> <%= arrInfoFix[e] %> 
							</label>
						<%
						}
						%>
						<!-- //rsg20180119 --> 
					</td>
				</tr>

				<tr>
					<th>담당자명</th>
					<td colspan="3"> <input type="text" name="charger" id="charger" readonly="readonly" value="<c:out value="${result.charger }" />"  > </td>
				</tr>

				<tr>
					<th>연락처 </th>
					<td> <input type="text" name="telno" id="telno" readonly="readonly"  maxlength="13" value="<c:out value="${result.telno }"/>" > </td>
					<th>이메일</th>
					<td> <input type="text" name="email" id="email" readonly="readonly" value="<c:out value="${result.email }" />" > </td>
				</tr>

			</tbody>
		</table>
	</div>

	<h4>■  채용정보	</h4>
	<div class="bdView">
		<table>
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%" />
			<col style="width:35%" />
			<col style="width:15%" />
			<col />
			</colgroup>
			<tbody>
				<tr>
					<th>* 채용제목</th>
					<td colspan="3"> <input type="text" id="pblancNm" name="pblancNm"  class="w500" value="<c:out value="${result.pblancNm }" escapeXml="false"  />"  title="채용제목" > <label><input type="checkbox" value="Y" name="useAtData" id="useAtData" <c:if test="${result.useAt eq 'Y' }">checked="checked"</c:if> /> 메인노출 </label> </td>
				</tr>
				<tr>
					<th>* 모집분야</th>
					<td colspan="3" >
					<select name="chrgJob2" id="chrgJob2" >
							<option value="">모집분야선택</option>
							<c:forEach var="code" items="${COM093CodeList }" varStatus="status" >
								<c:if test="${code.upperCode eq 0}">
								<option value="${code.code }"<c:if test="${code.code eq fn:trim(result.chrgJob2)}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
								</c:if>
							</c:forEach>
					</select>
					<select name="chrgJob" id="chrgJob">
							<option value="">모집분야선택</option>
							<%-- <c:forEach var="code" items="${COM093CodeList }" varStatus="status" >
								<option value="${code.code }"<c:if test="${code.code eq result.chrgJob2}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
							</c:forEach> --%>
					</select>
					</td>
				</tr>
				<tr>
					<th>* 키워드</th>
					<td colspan="3"> <input type="text" id="kwrd" name="kwrd" class="w500" value="<c:out value="${result.kwrd }" escapeXml="false" />" title="키워드" > </td>
				</tr>
				<tr>
					<th>모집인원</th>
					<td> <input type="text" name="rcritNmpr" id="rcritNmpr" value="<c:out value="${result.rcritNmpr }" />" title="모집인원" > </td>
					<th><label for="wrkprc">근무지</label>  </th>
					<td>
						<select id="wrkprc" name="wrkprc" title="근무지" >
								<option value="" >근무지 선택</option>
								<c:forEach var="code" items="${COM094CodeList }" varStatus="status" >
									<option value="${code.code }"<c:if test="${code.code eq fn:trim(result.wrkprc)}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th> <label for="workStleData"> 근무형태 </label> </th>
					<td colspan="3">
					<c:forEach var="code" items="${COM097CodeList }" varStatus="status" >
						<label> <input type="checkbox" name="workStleData" id="workStleData_<c:out value="${status.index }" />" value="<c:out value="${code.code }" />" <c:if test="${fn:indexOf(result.workStle, code.code) != -1}">checked="checked"</c:if> /><c:out value="${code.codeNm }" /></label>
					</c:forEach>
					</td>
				</tr>
				<tr>
					<th> <label for="careerSe">경력</label> </th>
					<td colspan="3">
						<select name="careerSe" id="careerSe" >
							<option value="">경력선택</option>
							<c:forEach var="code" items="${COM100CodeList }" varStatus="status">
								<option value="<c:out value="${code.code }" />" <c:if test="${code.code eq result.careerSe }">selected="selected"</c:if> ><c:out value="${code.codeNm }" /></option>
							</c:forEach>
						</select>
						<span id="careerOther" style="display: none;"> <input type="text" name="career" value="${result.career }" id="career" >개월 이상 </span>

					 </td>
				</tr>

				<tr>
					<th>학력</th>
					<td>
						<select name="acdmcrSe" id="acdmcrSe" >
							<option value="">학력선택</option>
							<c:forEach var="code" items="${COM096CodeList }" varStatus="status">
								<option value="<c:out value="${code.code }" />" <c:if test="${code.code eq result.acdmcrSe }">selected="selected"</c:if> ><c:out value="${code.codeNm }" /></option>
							</c:forEach>
						</select>

					</td>
					<th>성별</th>
					<td>
					<c:forEach var="code" items="${COM079CodeList }" varStatus="status" >
						<label for="sex<c:out value="${status.index }" />" > <input type="radio" name="sex" id="sex<c:out value="${status.index }" />" value="<c:out value="${code.code }" />" /><c:out value="${code.codeNm }" /> </label>
					</c:forEach>
						<label for="sexOther" > <input type="radio" name="sex" id="sexOther"" value="N" />무관 </label>
					</td>
				</tr>
					<%--선택된 학력 체크 박스  --%>
				<tr>
					<th> 급여사항 </th>
					<td colspan="3" > <input type="text" name="salary" id="salary" value="<c:out value="${result.salary }" />" title="급여사항" > </td>
				</tr>
				<tr>
					<th> 주요 업무 내용 </th>
					<td class="outputEditor" colspan="3">
						<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
						(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
						</span><br/>
							<textarea id="jobCn" name="jobCn" cols="150" rows="30" style="display:none;" class="textarea"><c:out value="${result.jobCn}"/></textarea>
							<script type="text/javascript">
							//<![CDATA[
								var CrossEditor = new NamoSE("crosseditor");
								CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
								CrossEditor.EditorStart();

	 							var contentValue = document.getElementById("jobCn").value; // Hidden 값 참조
								function OnInitCompleted(){

								contentValue = contentValue.replace(/#script#/gi, "script");
	 								CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
	 							}
							//]]>
							</script>
					</td>
				</tr>
				<tr>
					<th> 제출 서류 </th>
					<td colspan="3">
						<textarea title="제출 서류 및 접수방법" cols="120" rows="5" name="presentnPapersCn" id="presentnPapersCn" class="col-md-12" value="내용을 입력하여 주세요." onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" ><c:out value="${result.presentnPapersCn }" escapeXml="false" /></textarea>
					</td>
				</tr>
				<tr>
					<th> 전형 방법 </th>
					<td colspan="3">
						<textarea title="전형방법" cols="120" rows="5" name="slectnMthCn" id="slectnMthCn" class="col-md-12" value="내용을 입력하여 주세요." onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" ><c:out value="${result.slectnMthCn }" escapeXml="false" /> </textarea>
					</td>
				</tr>
				<tr>
					<th> 접수기간 </th>
					<td colspan="3">
					<input title="접수시작기간" type="text" name="rceptBeginDt" id="rceptBeginDt" readonly="readonly" value="<fmt:formatDate value="${result.rceptBeginDt }" pattern="yyyy-MM-dd"/>"  class="sdate">
					~
					<input title="접수종료기간" type="text" name="rceptEndDt" id="rceptEndDt" readonly="readonly" value="<fmt:formatDate value="${result.rceptEndDt }" pattern="yyyy-MM-dd"/>" class="edate">
					<select id="rceptComptAt" name="rceptComptAt">
						<option value=""  >채용선택</option>
						<option value="2" <c:if test="${fn:indexOf(result.rceptComptAt, '2') != -1}">selected="selected"</c:if>>채용시까지</option>
						<option value="3" <c:if test="${fn:indexOf(result.rceptComptAt, '3') != -1}">selected="selected"</c:if>>상시</option>
					</select>

					</td>
				</tr>
				<tr>
					<th> 접수방법 </th>
					<td colspan="3">
						<textarea title="접수방법" cols="120" rows="5" name="rceptMthCn" id="rceptMthCn" class="col-md-12" value="내용을 입력하여 주세요." onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" ><c:out value="${result.rceptMthCn }" escapeXml="false" /></textarea>
					</td>
				</tr>
				<c:if test="${not empty fileList}">
				<tr>
					<th scope="row">첨부된 첨부파일</th>
					<td colspan="3"><jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" /></td>
				</tr>
				</c:if>
				<tr>
					<th scope="row">첨부파일</th>
					<td colspan="3" ><jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>
</div>

<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/job/${paramVO.programId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
</div>
