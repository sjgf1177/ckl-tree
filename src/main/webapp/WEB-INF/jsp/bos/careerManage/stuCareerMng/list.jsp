<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/bos/js/xlsx.full.min.js"></script>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		$("#popClose").on("click", function(){
			$("#eduMngPop").css("display", "none");
		});
	});
	
	function excelUploadPop (){
		$("#modal_btnbox").empty();
		$("#eduMngInsertForm").prop("action", "/bos/careerManage/stuCareerMng/uploadExcelFile.json?menuNo=100244");
		$("#modal_btnbox").html("<a class='btn btn-info' href='javaScript:insert();'><span>등록</span></a>");
		$("#duplbtn").css("display", "inline-block");
		$("#eduMngPop").css("display", "block");
	}
	
	function insert(){
		var target = document.getElementById('file');
		var file = target.files[0];
		var excelDataList = new Array();
		
		var reader = new FileReader();
		reader.onload = function(){
			var fileData = reader.result;
			var wb = XLSX.read(fileData, {type : 'binary'});
			var sheetNameList = wb.SheetNames;
			var firstSheetName = sheetNameList[0];
			var firstSheet = wb.Sheets[firstSheetName];
			
			var xlsdata = XLSX.utils.sheet_to_json (firstSheet);

			for (var i=2; i<xlsdata.length;i++){
				var data = new Object();
				data.datatype = xlsdata[i].__EMPTY;
				data.stuNm = xlsdata[i].__EMPTY_1;
				data.gender = xlsdata[i].__EMPTY_2;
				data.birth = xlsdata[i].__EMPTY_3;
				data.phone = xlsdata[i].__EMPTY_4;
				data.email = xlsdata[i].__EMPTY_5;
				data.jobSearchYn = xlsdata[i].__EMPTY_6;
				data.interField = xlsdata[i].__EMPTY_7;
				data.fldStrDtl = xlsdata[i].__EMPTY_8;
				data.fldEtcDtl = xlsdata[i].__EMPTY_9;
				data.interJob = xlsdata[i].__EMPTY_10;
				data.jobEtcDtl = xlsdata[i].__EMPTY_11;
				data.fieldCareerYn = xlsdata[i].__EMPTY_12;
				data.fieldCreateYn = xlsdata[i].__EMPTY_13;
				data.fieldCreatePeriod = xlsdata[i].__EMPTY_14;
				data.schGubun = xlsdata[i].__EMPTY_15;
				data.schNm = xlsdata[i].__EMPTY_16;
				data.graduatedYn = xlsdata[i].__EMPTY_17;
				data.graduatedYear = xlsdata[i].__EMPTY_18;
				data.majorField = xlsdata[i].__EMPTY_19;
				data.major = xlsdata[i].__EMPTY_20;
				data.qualificationExam = xlsdata[i].__EMPTY_21;
				data.transferYn = xlsdata[i].__EMPTY_22;
				data.eduCode = xlsdata[i].__EMPTY_23;
				data.eduYear = xlsdata[i].__EMPTY_24;
				data.joineduDtl = xlsdata[i].__EMPTY_25;
				data.compNm = xlsdata[i].__EMPTY_26;
				data.joinYear = xlsdata[i].__EMPTY_27;
				data.resignYear = xlsdata[i].__EMPTY_28;
				data.employmentYn = xlsdata[i].__EMPTY_29;
				data.workerType = xlsdata[i].__EMPTY_30;
				data.rank = xlsdata[i].__EMPTY_31;
				data.createYear = xlsdata[i].__EMPTY_32;
				data.contractGroup = xlsdata[i].__EMPTY_33;
				data.createNm = xlsdata[i].__EMPTY_34;

				excelDataList.push(data);
			}
			
			
			$.ajax({
				type:"POST",
				url:"/bos/careerManage/stuCareerMng/excelCareerInsert.json?menuNo=100245",
				data:{"excelDataList":JSON.stringify(excelDataList)},
				cache:false,
				async:false,
				dataType:"JSON",
				success:function(data){
					alert("저장되었습니다.");
					location.reload();
				},
				error:function(){
					alert("서버와 통신 실패");
				}
			});
		}
		reader.readAsBinaryString(file);

	}
	
	
	function searchSubmit(){

		var interField = "";
		var i = 0;
		$("input:checkbox[name='interFieldCheck']").each(function(){
			if(this.checked){
				if(i < 1){
					interField = interField + this.value;
				} else {
					interField = interField + "," + this.value;
				}
				i += 1; 
			}
		});
		
		$("#interField").val(interField);
		$("#stuListForm").submit();	
	}
	
	function downloadAllExcel(){
		$("#stuListForm").attr("action","/bos/careerManage/stuCareerMng/downloadExcel.xls");
		$("#stuListForm").submit();
		$("#stuListForm").attr("action","/bos/careerManage/stuCareerMng/list.do?menuNo=${param.menuNo}");
		return false;
	}
	
//]]>
</script>

<form id="stuListForm" name="stuListForm" method="get" action="/bos/careerManage/stuCareerMng/list.do?menuNo=100245" class="form-inline">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<input type="hidden" name="interField" id="interField" value="" />
	<fieldset>
		<legend></legend>
		<div class="bdView mb0">
			<table class="table table-bordered">
				<caption></caption>
				<colgroup>
					<col width="10%"/>
					<col width="35%"/>
					<col width="10%"/>
					<col width="45%"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" ><label for="eduSn">참여사업</label></th>
						<td colspan="3">
							<select name="eduSn" id="eduSn" style="width:200px;">
								<option value="">선택</option>
								<c:forEach var="eduList" items="${eduList }">
									<option value="<c:out value='${eduList.eduSn}'/>" <c:if test="${param.eduSn eq eduList.eduSn}">selected</c:if>><c:out value='${eduList.eduNm}'/></option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="stuNm">성 명</label></th>
						<td colspan="3">
							<input type="text" name="stuNm" id="stuNm" value="<c:out value='${param.stuNm}'/>"/>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="gender">성 별</label></th>
						<td>
							<label><input type="radio" name="gender" value="">전체</label>
							<label><input type="radio" name="gender" value="M" <c:if test="${param.gender eq 'M'}">checked</c:if>>남</label>
							<label><input type="radio" name="gender" value="F" <c:if test="${param.gender eq 'F'}">checked</c:if>>여</label>
						</td>
						<th scope="row" ><label for="generation">연 령</label></th>
						<td>
							<label><input type="radio" name="generation" value="">전체</label>
							<label><input type="radio" name="generation" value="10" <c:if test="${param.generation eq '10'}">checked</c:if>>10대</label>
							<label><input type="radio" name="generation" value="20" <c:if test="${param.generation eq '20'}">checked</c:if>>20대</label>
							<label><input type="radio" name="generation" value="30" <c:if test="${param.generation eq '30'}">checked</c:if>>30대</label>
							<label><input type="radio" name="generation" value="40" <c:if test="${param.generation eq '40'}">checked</c:if>>40대</label>
							<label><input type="radio" name="generation" value="50" <c:if test="${param.generation eq '50'}">checked</c:if>>50대 이상</label>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="interFieldCheck">관심분야</label></th>
						<td colspan="3">
							<c:forEach var="interFieldList" items="${COM162CodeList }">
								<label><input type="checkbox" name="interFieldCheck" value="<c:out value='${interFieldList.code}'/>"><c:out value='${interFieldList.codeNm}'/></label>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="phone">휴대폰</label></th>
						<td><input type="text" name="phone" id="phone" value="<c:out value='${param.phone}'/>"/></td>
						<th scope="row" ><label for="email">이메일</label></th>
						<td><input type="text" name="email" id="email" value="<c:out value='${param.email}'/>"/></td>
					</tr>
					<tr>
						<th scope="row" ><label for="finalSch">최종학력</label></th>
						<td>
							<select name="finalSch" id="finalSch" style="width:200px;">
								<option value="">선택</option>	
								<c:forEach var="finalSchList" items="${COM165CodeList}">
									<option value="<c:out value='${finalSchList.code}'/>" <c:if test="${finalSchList.code eq param.finalSch}">selected</c:if>><c:out value='${finalSchList.codeNm}'/></option>
								</c:forEach>
							</select>
						</td>
						<th scope="row" ><label for="major">전공</label></th>
						<td><input type="text" name="major" id="major" value="<c:out value='${param.major}'/>"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btnSet tar">
			<a href="javaScript:searchSubmit();" class="btn btn-primary">검색</a>
		</div>
	</fieldset>
	
	<hr />

	<div class="row mt10 mb5">
		<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page <!-- <a class="btn btn-info thin" href="#self" id="excelDownBtn"><span>엑셀로 저장</span></a> --></div>
		<div class="col-md-6 tar">
			<a class="btn btn-info thin" href="javaScript:downloadAllExcel();" id="downloadAllExcel"><span>전체 엑셀 다운로드</span></a>
			<a class="btn btn-info thin" href="javaScript:excelUploadPop();" id="excelUploadPop"><span>일괄등록</span></a>
			<label for="pageUnit">표시수 :</label>
			<select name="pageUnit" id="pageUnit">
				<option value="10" <c:if test="${paramVO.pageUnit eq 10 }">selected="selected"</c:if>>10개</option>
				<option value="20" <c:if test="${paramVO.pageUnit eq 20 }">selected="selected"</c:if>>20개</option>
				<option value="30" <c:if test="${paramVO.pageUnit eq 30 }">selected="selected"</c:if>>30개</option>
				<option value="40" <c:if test="${paramVO.pageUnit eq 40 }">selected="selected"</c:if>>40개</option>
				<option value="50" <c:if test="${paramVO.pageUnit eq 50 }">selected="selected"</c:if>>50개</option>
			</select>
		</div>
	</div>
</form>

<div class="bdList">
	<table class="table table-bordered tac">
		<colgroup>
			<col width="6%"/>
			<col width="10%"/>
			<col width="6%"/>
			<col width="6%"/>
			<col width="15%"/>
			<col width="15%"/>
			<col width="12%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >번호</th>
				<th scope="row" >성명</th>
				<th scope="row" >성별</th>
				<th scope="row" >연령</th>
				<th scope="row" >연락처</th>
				<th scope="row" >이메일</th>
				<th scope="row" >최종학력</th>
				<th scope="row" >참여사업</th>
				<th scope="row" >근무경력</th>
				<th scope="row" >작품활동 경력</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1)) }" /></td>
					<td>
						<a href="/bos/careerManage/stuCareerMng/view.do?menuNo=100245&stuSn=<c:out value='${result.stuSn}' />"><c:out value="${result.stuNm }" /></a>
					</td>
					<td>
						<c:out value="${result.gender eq 'M' ? '남' : '여'}" />
					</td>
					<td><c:out value="${result.age }" /></td>
					<td><c:out value="${result.phone }" /></td>
					<td><c:out value="${result.email }" /></td>
					<td>
						<c:forEach var="item" items="${COM165CodeList }">
							<c:if test="${result.finalSch eq item.code}">
								<c:out value="${item.codeNm }"/>
							</c:if>
						</c:forEach>
					</td>
					<td><a href="/bos/careerManage/stuCareerMng/joinEduView.do?menuNo=100245&stuSn=<c:out value='${result.stuSn}'/>${pageQueryString}" class="btn btn-sm btn-default thin">상세보기</a></td>
					<td><a href="/bos/careerManage/stuCareerMng/careerView.do?menuNo=100245&stuSn=<c:out value='${result.stuSn}'/>${pageQueryString}" class="btn btn-sm btn-default thin">상세보기</a></td>
					<td><a href="/bos/careerManage/stuCareerMng/createView.do?menuNo=100245&stuSn=<c:out value='${result.stuSn}'/>${pageQueryString}" class="btn btn-sm btn-default thin">상세보기</a></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr><td colspan="10">- 검색 결과가 없습니다 -</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btn_set"><a class="btn btn-primary" href="/bos/careerManage/stuCareerMng/forInsert.do?menuNo=100245${pageQueryString }"><span>등록</span></a></div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->

<div id="eduMngPop" class="modal">
	<div class="modal-header">
		<span id="popClose" class="close">&times;</span>
		<p>일괄등록</p>
	</div>
	<div class="modal-content">
		<div class="bdView mb0">
			<form id="excelInsertForm" name="excelInsertForm" method="post" action="" enctype="multipart/form-data">
				
				<table class="table table-bordered">
					<tbody>
						<%-- <tr>
							<td>
								<select name="eduSn" style="width:200px;">
									<option value="">참여사업선택</option>
									<c:forEach var="eduList" items="${eduList }">
										<option value="<c:out value='${eduList.eduSn}'/>" <c:if test="${param.eduSn eq eduList.eduSn}">selected</c:if>><c:out value='${eduList.eduNm}'/></option>
									</c:forEach>
								</select>
							</td>
						</tr> --%>
						<tr>
							<td>
								<input name="file" type="file" id="file" class="input_file form-control" style="width:70%; max-width:500px; display:inline-block;"/>
								<a href="https://edu.kocca.kr/upload/careerManage/samples.xlsx" style="display:inline-block;">양식다운로드</a>
							</td>
						</tr>
					</tbody>
				</table>
			</form>		
		</div>
		<div id="modal_btnbox"></div>
	</div>
</div>

<style>
/* The Modal (background) */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  padding-top: 10%;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}


.modal-header {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 30%;
	font-size: 18px;
	font-weight: bold;
}
/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 30%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	position:relative;
	top: -5px;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.modal input{width:300px; margin-right:5px; padding-left:5px;}
.modal label{margin-top:6px;}
.modal #modal_btnbox{text-align: center; margin-top: 5px;}
#duplbtn{display:none;}

input[type=checkbox]{
	margin-left:15px;
}

input[type=radio]{
	margin-left:10px;
}
input[type=text]{width:270px;}
.thin{height:20px; padding:0px 5px 0px 5px;}
</style>
