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
	
		if (fileExt != "xlsx") {
			alert('엑셀파일(xlsx)만 등록 가능합니다.\n엑셀파일을 선택해 주세요.');
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
	<h4>회원 일괄 등록</h4>
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
			<br /> <img alt="샘플엑셀 양식" src="/images/tmp/member_sample.png">
		</div>
		<div style="color: red;">
			<p>- 아이디는 6~30자까지 영문자(소문자), 숫자 사용 가능합니다.</p>
			<p>- 비밀번호는 8~16자까지 영문 대/소문자, 숫자, 특수문자 중 3개 이상의 조합.</p>
			<p>- 비밀번호는 아이디와 동일하게 사용할 수 없습니다.</p>
			<p>- 비밀번호는 동일 문자, 연속 문자는 사용할 수 없습니다.(Ex : aaa, abc 등)</p>
			<p>- 비밀번호가 공백일 경우 아이디 + '!'로 저장됩니다.(Ex : test01 => test01!)</p>
			<p>- 성별, 정보 수신, 직업은 해당 코드 이외 코드 입력 시 저장이 안 될 수 있습니다.</p>
			<p>- 엑셀파일은 확장자가 xlsx 파일만 등록 가능합니다.</p>
			<p>- 생년월일은  지정된 형식으로 입력하세요.(Ex : 19900101)</p>
		</div>
	</div>
	<br />
	<br />
	<br />
	<div>
		<p>2) 회원 일괄 등록</p>
	</div>
	<br />
	<div style="line-height: 80%;">
		<p style="color: blue;">※ 엑셀파일 선택 후 오류 확인을 하여 오류가 없을 시 등록이 가능합니다.</p>
		<br />
		<div class="bdView">
			<table class="table table-bordered">
				<caption>회원 일괄 등록</caption>
				<colgroup>
					<col style="width: 15%">
					<col>
				</colgroup>
				<tbody>
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
				<col style="width: 6%;">	<!-- 이름  -->
				<col style="width: 7%;">	<!-- 생년월일  -->
				<col style="width: 4%;">	<!-- 성별  -->
				<col style="width: 10%;">	<!-- ID  -->
				<col>						<!-- 결과 -->
			</colgroup>
			<thead>
				<tr>
					<th>이름</th>
					<th>생년월일</th>
					<th>성별</th>
 					<th>아이디</th>
	<!--				<th>비밀번호</th>
					<th>이메일</th>
					<th>휴대폰</th>
					<th>인재캠퍼스 정보 수신(E-mail)</th>
					<th>인재캠퍼스 정보 수신(SMS)</th>
					<th>콘텐츠문화광장 정보 수신(E-mail)</th>
					<th>콘텐츠문화광장 정보 수신(SMS)</th>
					<th>직업</th>-->
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
					<td style="text-align: center;">${result.nm}</td>
 					<td style="text-align: center;">${result.bd}</td>
					<td style="text-align: center;">${result.sx}</td>
					<td style="text-align: center;">${result.id}</td>
<%--					<td style="text-align: center;">${result.nm}</td>
					--%>
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
			<a href="javascript:eInCheckForm();" class="btn btn-primary">회원 일괄 등록</a>
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
