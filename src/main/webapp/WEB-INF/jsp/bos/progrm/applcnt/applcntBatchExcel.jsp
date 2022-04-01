<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.ckl.progrm.service.ProgrmMasterService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/showModalDialog.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function(){

	});
	
	function fnPgNmListSet(pgCd) {
		var url = "/bos/progrm/applcnt/applcntPgNmList.json";
		var params = {prgCl : pgCd};
		
		$.get(url, params, function(data) {
			if (data) {
				var $obj = $("#prgSn");
				
				$obj.empty();
				$("<option>").text("프로그램명 선택").attr("value", "").appendTo($obj);
				$.each(data.prgNmList, function(key, item) {
					var $item = $("<option>").attr("value", item.prgSn).text(item.prgNm);
					if ('${param.prgNm}' == item.prgNm) 
						$item.attr("selected", true);
						$item.appendTo($obj);
				});
			}
		}, "json");
	}
	
	function checkForm() {
		var form = $("#frmUpl")[0];

		if ($('#prgCl').val() == "") {
			alert('분류를 선택해 주세요.');
			$('#prgCl').focus();
		    return;
		}
		
		if ($('#prgSn').val() == "") {
			alert('프로그램을 선택해 주세요.');
			$('#prgSn').focus();
		    return;
		}		
		
		if($('#uploadFile').val() == "") {
			alert("파일을 등록해 주세요.");
		    $("#uploadFile").focus();
		    return;
		}
		
		var file = document.getElementById('uploadFile');
		var filePath = file.value;
		var filePathSplit = filePath.split('\\'); 
		var filePathLength = filePathSplit.length;
		var fileNameSplit = filePathSplit[filePathLength-1].split('.');
		var fileName = fileNameSplit[0];
		var fileExt = fileNameSplit[1];
		var fileSize = file.files[0].size;
	
		if (fileExt != "xls" && fileExt != "xlsx") {
			alert('엑셀파일만 등록 가능합니다.\n엑셀파일을 선택해 주세요.');
			$("#uploadFile").focus();
		    return;
		}		
		
		if (!confirm("오류 확인을 진행 하시겠습니까?")) {
		    return;
		}	

		form.submit();
	}	
	
	function eInCheckForm() {
		if ($('#prgCl').val() == "") {
			alert('분류를 선택해 주세요.');
			$('#prgCl').focus();
		    return;
		}
		
		if ($('#prgSn').val() == "") {
			alert('프로그램을 선택해 주세요.');
			$('#prgSn').focus();
		    return;
		}
		
		if (!confirm("수강생 일괄 등록을 진행 하시겠습니까?")) {
		    return;
		}	

		location.href="/bos/progrm/applcnt/excelInsert.do?aId=${paramVO.atchFileId}&prgCl=${paramVO.prgCl}&prgSn=${paramVO.prgSn}";
	}		
</script>

<form id="frmUpl" name="frmUpl" method="post" enctype="multipart/form-data">
<input type="hidden" name="atchFileId" id="atchFileId" >
	<h4>수강생 일괄 등록</h4>
	<div class="bdView"></div>
	<div>
		<p>
			1) 일괄등록 양식 다운로드&nbsp;&nbsp;&nbsp; 
			<a class="btn btn-default btn-sm" href="javascript:fnSampleDown();"><span>양식 다운로드</span></a>
		</p>
		<br />
		<br />
		<br />
		<div class="bdList" style="line-height: 80%;">
			<p style="color: blue;">※ 다음 양식대로 등록하되, 아래 유의사항을 필히 확인하세요.</p>
			<br /> <img alt="샘플엑셀 양식" src="/images/tmp/excelTmp.png">
		</div>
		<div style="color: red;">
			<p>- 회원가입이 안되어 있을 경우, 수강생 일괄 등록이 불가합니다.</p>
			<p>- 양식대로 기입하지 않을 경우, 일괄 등록이 불가합니다.</p>
			<p>- 팀 구분이 T일 경우, 팀명, 아이디, 성명은 필수사항이며, 팀원은 아이디, 성명만 기입하시면 됩니다.</p>
			<p>- 팀 구분이 T일 경우, 해당 라인의 입력자는 팀 대표로 저장됩니다.</p>
			<p>- 팀 구분은 대문자로 입력해주시고, 대문자가 아닌 경우 등록이 불가합니다.</p>
			<p>- 팀원 입력 시 팀 구분이 있을 경우, 다른 팀으로 저장이 됩니다.</p>
			<p>- 팀 구분이 P일 경우, 아이디, 성명은 필수사항입니다.</p>
			<p>- 엑셀파일이 아닐 경우 일괄 등록이 불가합니다.</p>
			<p>- 팀이 다를 경우라도 아이디 중복 시 수강생 일괄 등록이 불가합니다.</p>
		</div>
	</div>
	<br />
	<br />
	<br />
	<div>
		<p>2) 수강생 일괄 등록</p>
	</div>
	<br />
	<div style="line-height: 80%;">
		<p style="color: blue;">※ 분류, 프로그램명, 엑셀파일 선택 후 오류 확인 후 오류가 없을 시 등록이 가능합니다.</p>
		<br />
		<div class="bdView">
			<table class="table table-bordered">
				<caption>수강생 일괄 등록</caption>
				<colgroup>
					<col style="width: 15%">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="prgCl">분류</label></th>
						<td>
							<select name="prgCl" id="prgCl" title="분류" onChange="javascript:fnPgNmListSet(this.value)">
								<option value="">분류 선택</option>
								<c:forEach var="code" items="${prgSeOpenCodeList}" varStatus="status">
									<c:if test="${code.prgCnt < 100}">
										<option value="${code.code}"
											<c:if test="${paramVO.prgCl eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="prgSn">프로그램명</label></th>
						<td>
							<select name="prgSn" id="prgSn" title="프로그램명">
								<option value="">프로그램명 선택</option>
								<c:forEach var="code" items="${prgNmList}" varStatus="status">
									<option value="${code.prgSn}"
										<c:if test="${paramVO.prgSn eq code.prgSn}">selected="selected"</c:if>>${code.prgNm}</option>
								</c:forEach>								
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="mainImg">파일명</label></th>
						<td>
							<input type="file" name="uploadFile" id="uploadFile" title="업로드파일" class="col-md-8"> 
							&nbsp;&nbsp;
							<input type="button" onclick="checkForm()" value="오류확인" class="btn btn-default btn-sm" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

<c:if test="${isCheck eq 'Y'}">
	<h4>오류 확인 결과 </h4>
	<div class="bdList">
		<table class="table table-bordered">
			<caption></caption>
			<colgroup>
				<col style="width: 8%;">	<!-- 팀구분  -->
				<col style="width: 20%;">	<!-- 팀명 -->
				<col style="width: 25%;">	<!-- 프로젝트명 -->
				<col style="width: 13%">	<!-- 아이디 -->
				<col style="width: 10%;">	<!-- 성명 -->
				<col>						<!-- 결과 -->
			</colgroup>
			<thead>
				<tr>
					<th>팀구분(T/P)</th>
					<th>팀명</th>
					<th>프로젝트명</th>
					<th>아이디</th>
					<th>성명</th>
					<th>결과</th>
				</tr>
			</thead>
			<tbody>
		<c:choose>
			<c:when test="${isErrSample eq true}">			
				<tr>
					<td colspan="6" style="text-align: center;">등록한 엑셀파일 양식이 다릅니다. 확인 후 다시 등록하여 주세요.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:set var="errCnt" value="0" />
				<c:forEach var="result" items="${excelList}" varStatus="status">
				<tr>
					<td style="text-align: center;">${result.tt}</td>
					<td>${result.tn}</td>
					<td>${result.pj}</td>
					<td style="text-align: center;">${result.id}</td>
					<td style="text-align: center;">${result.nm}</td>
					
					<c:set var="msgColor" value="blue" />
					<c:if test="${result.msg ne 'OK'}">
						<c:set var="msgColor" value="red" />
						<c:set var="errCnt" value="1" />
					</c:if>
					<td style="color: ${msgColor}">${result.msg}</td>
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>				
			</tbody>
		</table>
	</div>
</c:if>

	<div class="row clear mt20">
		<div class="col-md-11 tac">
		<c:if test="${errCnt == 0}">
			<a href="javascript:eInCheckForm();" class="btn btn-primary">수강생 등록</a>
		</c:if>
		</div>
		<c:choose>
			<c:when test="${paramVO.prgCl eq 19}">
				<div class="col-md-1">
					<a href="/bos/progrm/applcnt/list.do?prgSn=<c:out value="${paramVO.prgSn}"/>&${pageQueryString}" class="btn btn-primary">목록</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="col-md-1">
					<a href="/bos/progrm/master/list.do?${pageQueryString}" class="btn btn-primary">목록</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</form>
