<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<script type="text/javascript">

$(function() {

	var confmSttusPopup = $("#confmSttusPopup").dialog({
		autoOpen: false,
	  	height: "auto",
	  	width: "800",
	  	modal: true,
	  	position : {
  			my : "center center",
  			at : "center center",
  			of : $("body"),
  			within : $("body")
  		}
	});

	var partcptnComptPopup = $("#partcptnComptPopup").dialog({
		autoOpen: false,
	  	height: "auto",
	  	width: "800",
	  	modal: true,
	  	position : {
  			my : "center center",
  			at : "center center",
  			of : $("body"),
  			within : $("body")
  		}
	});

	$("#confmSttusPopupBtn").click(function() {
   		$("#userSnArr").val('${param.reqstSn}');
	  	var params = {viewType : "CONTBODY", userSnArr : "${param.reqstSn}", prgSn : "${result.prgSn}"};
	  	$( "#confmSttusPopup" ).load("/bos/progrm/applcnt/confmSttusPopup.do", params, function() {
	  		$( "#confmSttusPopupCont").empty();
	  		confmSttusPopup.dialog("open");
	  	});
	  	return false;
  	});

	$("#partcptnComptPopupBtn").click(function() {
   		$("#userSnArr").val('${param.reqstSn}');
	  	var params = {viewType : "CONTBODY", userSnArr : "${param.reqstSn}", prgSn : "${result.prgSn}"};
	  	$( "#partcptnComptPopup" ).load("/bos/progrm/applcnt/partcptnComptPopup.do", params, function() {
	  		$( "#partcptnComptPopupCont").empty();
	  		partcptnComptPopup.dialog("open");
	  	});
	  	return false;
  	});

	$("#rceptSttusBtn").click(function() {
		if (!confirm("신청완료 상태로 변경하시겠습니까?")) {
			return false;
		}
		$.post(
			"/bos/progrm/applcnt/rceptSttusChange.json",
			{reqstSn : '${result.reqstSn}', rceptSttus : '02', prgSn : "${result.prgSn}", authSe : "${result.authSe}", mbtlnum : "${result.telNo}"},
			function(data)
			{
				if (data.resultCode == "success") {
					alert("변경이 완료되었습니다.");
					location.reload();
				}
			},"json"
		);
	  	return false;
	});

	ctfhvPopup = function(prgSn, reqstSn) { // 수료증 팝업창
		window.open("/bos/progrm/applcnt/ctfhvPopup.do?viewType=CONTBODY&prgSn="+prgSn+"&reqstSn="+reqstSn, "ctfhvPopup", "top=200, left=600, width=800, height=750, status=yes, resizable=yes, scrollbars=no");
	};

});

</script>

<div id="confmSttusPopup" title="승인상태변경">
	<div id="confmSttusPopupCont"></div>
</div>
<div id="partcptnComptPopup" title="참여여부변경">
	<div id="partcptnComptPopupCont"></div>
</div>

<div class="bdView">
	<input type="hidden" name="userSnArr" id="userSnArr">
	<table class="table table-bordered">
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
				<!-- <th scope="row">번호</th>
				<td>대기1</td> -->
				<th scope="row">신청/접수일시</th>
				<td colspan="3">${result.rDt}</td>
			</tr>
			<tr>
				<th scope="row">상태</th>
				<td>${result.rceptSttusNm}</td>
				<th scope="row">취소일시</th>
				<td>${result.rceptSttus eq '03' ? result.cDt : '-'}</td>
			</tr>
			<tr>
				<c:if test="${masterResult.confmStepAt eq 'Y'}">
					<th scope="row">승인상태</th>
					<td>${result.confmSttusNm} <a class="btn btn-default btn-sm" href="#" id="confmSttusPopupBtn"><span>승인상태변경</span></a></td>
				</c:if>
				<th scope="row">참여여부</th>
				<td ${masterResult.confmStepAt eq 'Y' ? '' : 'colspan=3'}>${result.partcptnComptAt eq '01' ? '●' : 'X'} 	<a class="btn btn-default btn-sm" href="#" id="partcptnComptPopupBtn"><span>참여여부변경</span></a>

					<c:if test="${result.rceptSttus eq '02'}">
						<c:if test="${masterResult.prgEnddeEndDt eq 'F'}"> <!-- 교육기간 마감 -->
							<c:if test="${masterResult.ctfhvIssuUseAt eq 'Y'}"> <!-- 발급여부 Y -->
								<c:if test="${result.partcptnComptAt eq '01'}"> <!-- 참여여부 Y -->
									<a class="btn btn-default btn-sm" href="javascript:ctfhvPopup(<c:out value='${masterResult.prgSn}'/>,<c:out value='${result.reqstSn}'/>);" ><span>수료증발급</span></a>
								</c:if>
							</c:if>
						</c:if>
					</c:if>

				</td>
			</tr>
		</tbody>
	</table>
</div>


<h4>개인정보</h4>
<div class="bdView">

	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width:15%" />
		<col />
		</colgroup>
		<tbody>
				<tr>
					<th scope="row">아이디</th>
					<td>${result.userId}</td>
				</tr>
			<c:if test="${result.nmUseAt eq 'Y'}">
				<tr>
					<th scope="row">이름</th>
					<td>${result.nm}</td>
				</tr>
			</c:if>
			<c:if test="${result.brthdyUseAt eq 'Y'}">
				<tr>
					<th scope="row">생년월일</th>
					<td>${result.brthdy}</td>
				</tr>
			</c:if>
			<c:if test="${result.sexUseAt eq 'Y'}">
				<tr>
					<th scope="row">성별</th>
					<td>${result.sexNm}</td>
				</tr>
			</c:if>
			<c:if test="${result.emailUseAt eq 'Y'}">
				<tr>
					<th scope="row">이메일</th>
					<td><a href="mailto:${result.email}">${result.email}</a></td>
				</tr>
			</c:if>
			<c:if test="${result.addEmailUseAt eq 'Y'}">
				<tr>
					<th scope="row">추가이메일</th>
					<td><a href="mailto:${result.addEmail}">${result.addEmail}</a></td>
				</tr>
			</c:if>
			<c:if test="${result.ownhomTelnoUseAt eq 'Y'}">
				<tr>
					<th scope="row">자택전화번호</th>
					<td>${result.ownhomTelno}</td>
				</tr>
			</c:if>
			<c:if test="${result.mbtlnumUseAt eq 'Y'}">
				<tr>
					<th scope="row">휴대폰</th>
					<td>${result.mbtlnum}</td>
				</tr>
			</c:if>
			<c:if test="${result.cmpnyTelnoUseAt eq 'Y'}">
				<tr>
					<th scope="row">회사전화번호</th>
					<td>${result.cmpnyTelno}</td>
				</tr>
			</c:if>
			<c:if test="${result.telnoUseAt eq 'Y'}">
				<tr>
					<th scope="row">전화번호</th>
					<td>${result.telno}</td>
				</tr>
			</c:if>
			<c:if test="${result.adresUseAt eq 'Y'}">
				<tr>
					<th scope="row">주소</th>
					<td>${result.adres}</td>
				</tr>
			</c:if>
			<c:if test="${result.resdncUseAt eq 'Y'}">
				<tr>
					<th scope="row">거주지역</th>
					<td>
						<c:set var="data" value="${fn:split(result.resdnc,'|')}" />
						<c:forEach var="code" items="${COM063CodeList}">
							<c:if test="${data[0] eq code.code}"><c:out value="${code.codeNm}"/></c:if>
						</c:forEach>
						<c:forEach var="code" items="${COM063CodeList}">
							<c:if test="${data[1] eq code.code}"><c:out value="${code.codeNm}"/></c:if>
						</c:forEach>
					</td>
				</tr>
			</c:if>
			<c:if test="${result.jobUseAt eq 'Y'}">
				<tr>
					<th scope="row">직업</th>
					<td>${result.jobNm}</td>
				</tr>
			</c:if>
			<c:if test="${result.psitnUseAt eq 'Y'}">
				<tr>
					<th scope="row">소속</th>
					<td>${result.psitn}</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>


<h4>신청부가정보</h4>
<div class="bdView">
	<table class="table table-bordered">
		<caption>
		</caption>
		<colgroup>
		<col style="width:15%" />
		<col />
		</colgroup>
		<tbody>
			<c:forEach var="addinfo" items="${addInfoList}" varStatus="status">
				<tr>
					<th scope="row">${addinfo.iemNm}</th>
					<td>
						<c:choose>
							<c:when test="${addinfo.attrb eq '06'}">${addinfo.codeNm}</c:when>
							<c:when test="${addinfo.attrb eq '07'}">
								${addinfo.attrbDataCn}
								<%-- <c:set var="num" value="0"/>
								<c:forEach var="code" items="${iemCodeList}" varStatus="status">
									<c:if test="${fn:indexOf(addinfo.attrbDataCn, code.code) > -1}">
										<c:if test="${num > 0}">, </c:if>
										${code.codeNm}
										<c:set var="num" value="${num+1}"/>
									</c:if>
								</c:forEach> --%>
								<c:if test="${fn:indexOf(addinfo.attrbDataCnOrg, 'CE') > -1}">
									<br/>(기타)<br/>
									${fn:replace(addinfo.attrbDataEtc, newLineChar,"<br/>")}
								</c:if>							
							</c:when>
							<c:when test="${addinfo.attrb eq '08'}">
								<c:out value="${addinfo.attrbDataCn}"/>
								<c:if test="${addinfo.attrbDataCnOrg eq 'RE'}">
									<br/>${fn:replace(addinfo.attrbDataEtc, newLineChar,"<br/>")}
								</c:if>									
							</c:when>
							<c:when test="${addinfo.attrb eq '09'}">${addinfo.attrbNm}</c:when>
							<c:when test="${addinfo.attrb eq '14'}">
								<c:set var="data" value="${fn:split(addinfo.attrbDataCn,'|')}" />
								<c:out value="${data[0]}"/><br/><br/>동의여부: <c:out value="${data[1] eq 'Y' ? '동의' : '비동의'}"/>
							</c:when>
							<c:when test="${addinfo.attrb eq '15'}">
								<c:set var="files" value="${fileMap[addinfo.atchFileId]}" />
				    			<c:if test="${not empty files}">
						    		<a href="/bos/cmm/fms/FileDown.do?atchFileId=${files[0].atchFileId}&amp;fileSn=${files[0].fileSn}">
							    			<c:out value="${files[0].orignlFileNm}"/>&nbsp;[<c:out value="${files[0].fileMg}"/>&nbsp;byte]
						    		</a>
				    			</c:if>
							</c:when>
							<c:otherwise>${fn:replace(addinfo.attrbDataCn, newLineChar,"<br/>")}</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


<div class="btnSet clear">
	<c:if test="${result.rceptSttus eq '01'}">
		<div class="col-md-8 tac"><a class="btn btn-primary" href="#" id="rceptSttusBtn"><span>대기신청 확정변경</span></a></div>
	</c:if>
	<div class="fr"><a class="btn btn-primary" href="/bos/progrm/applcnt/list.do?prgSn=${result.prgSn}&menuNo=${param.menuNo}&siteSe=${param.siteSe}"><span>목록</span></a></div>
</div>


