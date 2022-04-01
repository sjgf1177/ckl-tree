<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<script type="text/javascript">
//<![CDATA[

$(function() {

	rceptSttusChange = function(reqstSn, prgSn, prgNm) {
		if (!confirm("정말로 취소하시겠습니까?")) {
			return;
		}
		$.post(
			"/edu/progrm/applcnt/rceptSttusChange.json",
			{reqstSn : reqstSn, prgSn : prgSn, prgNm : prgNm, rceptSttus : '03'},
			function(data)
			{
				if (data.resultCode == "success") {
					alert("취소되었습니다.");
					location.reload();
				}
			},"json"
		);
	  	return;
	};

});

//]]>
</script>
	<div class="mb30 sub_board_body">
		<table class="contents_insight_view contact_us_view style_0">
			<caption>프로그램 신청/접수 정보</caption>
			<colgroup>
			<col style="width:20%">
			<col>
			<col style="width:20%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>구분/분류</th>
					<td colspan="3"><c:out value="${masterResult.prgSeNm}"/>/<c:out value="${masterResult.prgClNm}"/></td>
				</tr>
				<tr>
					<th>프로그램명</th>
					<td colspan="3"><c:out value="${masterResult.prgNm}"/></td>
				</tr>
				<tr>
					<th>신청/접수일시</th>
					<td><c:out value="${result.rDt}"/></td>
					<th>접수번호</th>
					<td>
						<c:if test="${masterResult.rceptNoIndictAt eq 'Y'}">
							<c:out value="${result.resveNo}"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>취소여부</th>
					<td><c:out value="${result.rceptSttus eq '03' ? 'O' : 'X'}"/></td>
					<th>취소일시</th>
					<td><c:out value="${result.rceptSttus eq '03' ? result.cDt : '-'}"/></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<p class="alert_title">개인정보</p>
	<div class="mb30 sub_board_body">
		<table class="contents_insight_view contact_us_view style_0">
			<caption>프로그램 신청/접수 개인정보</caption>
			<colgroup>
			<col style="width:20%">
			<col>
			<col style="width:20%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th>아이디</th>
					<td colspan="3"><c:out value="${result.userId}"/></td>
				</tr>
				<c:if test="${result.nmUseAt eq 'Y'}">
					<tr>
						<th>이름</th>
						<td colspan="3"><c:out value="${result.nm}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.brthdyUseAt eq 'Y'}">
					<tr>
						<th>생년월일</th>
						<td colspan="3"><c:out value="${result.brthdy}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.sexUseAt eq 'Y'}">
					<tr>
						<th>성별</th>
						<td colspan="3"><c:out value="${result.sexNm}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.emailUseAt eq 'Y'}">
					<tr>
						<th>이메일</th>
						<td colspan="3"><a href="mailto:<c:out value="${result.email}"/>" target="_blank" title="새창열림"><c:out value="${result.email}"/></a></td>
					</tr>
				</c:if>
				<c:if test="${result.addEmailUseAt eq 'Y'}">
					<tr>
						<th>추가이메일</th>
						<td colspan="3"><a href="mailto:<c:out value="${result.addEmail}"/>" target="_blank" title="새창열림"><c:out value="${result.addEmail}"/></a></td>
					</tr>
				</c:if>
				<c:if test="${result.ownhomTelnoUseAt eq 'Y'}">
					<tr>
						<th>자택전화번호</th>
						<td colspan="3"><c:out value="${result.ownhomTelno}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.mbtlnumUseAt eq 'Y'}">
					<tr>
						<th>휴대폰</th>
						<td colspan="3"><c:out value="${result.mbtlnum}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.cmpnyTelnoUseAt eq 'Y'}">
					<tr>		
						<th>회사전화번호</th>
						<td colspan="3"><c:out value="${result.cmpnyTelno}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.telnoUseAt eq 'Y'}">
					<tr>
						<th>전화번호</th>
						<td colspan="3"><c:out value="${result.telno}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.adresUseAt eq 'Y'}">
					<tr>
						<th>주소</th>
						<td colspan="3"><c:out value="${result.adres}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.resdncUseAt eq 'Y'}">
					<tr>
						<th>거주지역</th>
						<td colspan="3">
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
						<th>직업</th>
						<td colspan="3"><c:out value="${result.jobNm}"/></td>
					</tr>
				</c:if>
				<c:if test="${result.psitnUseAt eq 'Y'}">
					<tr>
						<th>소속</th>
						<td colspan="3"><c:out value="${result.psitn}"/></td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<p class="alert_title">신청부가정보</p>
	<div class="mb30 sub_board_body">
		<table class="contents_insight_view contact_us_view style_1">
			<caption>프로그램 신청/접수 신청부가정보</caption>
			<colgroup>
			<col style="width:20%">
			<col>
			</colgroup>
			<tbody>
				<c:forEach var="addinfo" items="${addInfoList}" varStatus="status">
					<tr>
						<th>${addinfo.iemNm}</th>
						<td>
							<c:choose>
								<c:when test="${addinfo.attrb eq '06'}"><c:out value="${addinfo.codeNm}"/></c:when>
								<c:when test="${addinfo.attrb eq '07'}">
									${addinfo.attrbDataCn}
									<%-- <c:set var="num" value="0"/>
									<c:forEach var="code" items="${iemCodeList}" varStatus="status">
										<c:if test="${fn:indexOf(addinfo.attrbDataCn, code.code) > -1}"><c:if test="${num > 0}">, </c:if><c:out value="${code.codeNm}"/><c:set var="num" value="${num+1}"/></c:if>
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
								<c:when test="${addinfo.attrb eq '09'}"><c:out value="${addinfo.attrbNm}"/></c:when>
								<c:when test="${addinfo.attrb eq '14'}">
									<c:set var="data" value="${fn:split(addinfo.attrbDataCn,'|')}" />
									<c:out value="${data[0]}"/><br/><br/>동의c:out value="${data[1] eq 'Y' ? '동의' : '비동의'}"/>
								</c:when>
								<c:when test="${addinfo.attrb eq '15'}">
									<c:set var="files" value="${fileMap[addinfo.atchFileId]}" />
					    			<c:if test="${not empty files}">
							    		<a href="/edu/cmm/fms/FileDown.do?atchFileId=<c:out value='${files[0].atchFileId}'/>&amp;fileSn=<c:out value='${files[0].fileSn}'/>">
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
	<!-- //dlList Table -->

	<div class="board_util_btn_con">
		<a href="/edu/progrm/applcnt/listMypage.do?${pageQueryString}" class="btn_style_0 full list">목록</a>
	<c:if test="${result.rceptSttus ne '03'}">
		<c:if test="${masterResult.progrsSttus ne 'F'}"> <!-- 접수시간 마감 -->
			<a href="javascript:rceptSttusChange('<c:out value='${result.reqstSn}'/>', '<c:out value='${result.prgSn}'/>', '<c:out value='${result.prgSn}'/>');" class="btn_style_0 full add">신청/접수 취소</a>
		</c:if>
	</c:if>
	</div>
