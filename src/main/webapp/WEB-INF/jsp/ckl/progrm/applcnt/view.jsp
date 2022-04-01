<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
//<![CDATA[

$(function() {

	rceptSttusChange = function(reqstSn, prgSn, prgNm) {
		if (!confirm("정말로 취소하시겠습니까?")) {
			return;
		}
		$.post(
			"/ckl/progrm/applcnt/rceptSttusChange.json",
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

	<!-- dlList Table -->
	<div class="dlListTable">
		<dl>
			<dt>구분/분류</dt>
			<dd><c:out value="${masterResult.prgSeNm}"/>/<c:out value="${masterResult.prgClNm}"/></dd>
		</dl>
		<dl>
			<dt>프로그램명</dt>
			<dd><c:out value="${masterResult.prgNm}"/></dd>
		</dl>
		<dl>
			<dt>신청/접수일시</dt>
			<dd><c:out value="${result.rDt}"/></dd>
		<c:if test="${masterResult.rceptNoIndictAt eq 'Y'}">
			<dt>접수번호</dt>
			<dd class="w25p tac"><c:out value="${result.resveNo}"/></dd>
		</c:if>
		</dl>
		<dl>
			<dt>취소여부</dt>
			<dd><c:out value="${result.rceptSttus eq '03' ? 'O' : 'X'}"/></dd>
			<dt>취소일시</dt>
			<dd class="w25p tac"><c:out value="${result.rceptSttus eq '03' ? result.cDt : '-'}"/></dd>
		</dl>
	</div>
	<!-- //dlList Table -->

	<h3>개인정보</h3>
	<!-- dlList Table -->
	<div class="dlListTable">

			<dl>
				<dt>아이디</dt>
				<dd><c:out value="${result.userId}"/></dd>
			</dl>
		<c:if test="${result.nmUseAt eq 'Y'}">
			<dl>
				<dt>이름</dt>
				<dd><c:out value="${result.nm}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.brthdyUseAt eq 'Y'}">
			<dl>
				<dt>생년월일</dt>
				<dd><c:out value="${result.brthdy}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.sexUseAt eq 'Y'}">
			<dl>
				<dt>성별</dt>
				<dd><c:out value="${result.sexNm}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.emailUseAt eq 'Y'}">
			<dl>
				<dt>이메일</dt>
				<dd><a href="mailto:<c:out value="${result.email}"/>" target="_blank" title="새창열림"><c:out value="${result.email}"/></a></dd>
			</dl>
		</c:if>
		<c:if test="${result.addEmailUseAt eq 'Y'}">
			<dl>
				<dt>추가이메일</dt>
				<dd><a href="mailto:<c:out value="${result.addEmail}"/>" target="_blank" title="새창열림"><c:out value="${result.addEmail}"/></a></dd>
			</dl>
		</c:if>
		<c:if test="${result.ownhomTelnoUseAt eq 'Y'}">
			<dl>
				<dt>자택전화번호</dt>
				<dd><c:out value="${result.ownhomTelno}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.mbtlnumUseAt eq 'Y'}">
			<dl>
				<dt>휴대폰</dt>
				<dd><c:out value="${result.mbtlnum}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.cmpnyTelnoUseAt eq 'Y'}">
			<dl>
				<dt>회사전화번호</dt>
				<dd><c:out value="${result.cmpnyTelno}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.telnoUseAt eq 'Y'}">
			<dl>
				<dt>전화번호</dt>
				<dd><c:out value="${result.telno}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.adresUseAt eq 'Y'}">
			<dl>
				<dt>주소</dt>
				<dd><c:out value="${result.adres}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.resdncUseAt eq 'Y'}">
			<dl>
				<dt>거주지역</dt>
				<dd>
					<c:set var="data" value="${fn:split(result.resdnc,'|')}" />
					<c:forEach var="code" items="${COM063CodeList}">
						<c:if test="${data[0] eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
					<c:forEach var="code" items="${COM063CodeList}">
						<c:if test="${data[1] eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
				</dd>
			</dl>
		</c:if>
		<c:if test="${result.jobUseAt eq 'Y'}">
			<dl>
				<dt>직업</dt>
				<dd><c:out value="${result.jobNm}"/></dd>
			</dl>
		</c:if>
		<c:if test="${result.psitnUseAt eq 'Y'}">
			<dl>
				<dt>소속</dt>
				<dd><c:out value="${result.psitn}"/></dd>
			</dl>
		</c:if>

	</div>
	<!-- //dlList Table -->

	<h3>신청부가정보</h3>
	<!-- dlList Table -->
	<div class="dlListTable">
		<c:forEach var="addinfo" items="${addInfoList}" varStatus="status">
			<dl>
				<dt>${addinfo.iemNm}</dt>
				<dd>
					<c:choose>
						<c:when test="${addinfo.attrb eq '06' or addinfo.attrb eq '08'}"><c:out value="${addinfo.codeNm}"/></c:when>
						<c:when test="${addinfo.attrb eq '07'}">
							<c:set var="num" value="0"/>
							<c:forEach var="code" items="${iemCodeList}" varStatus="status">
								<c:if test="${fn:indexOf(addinfo.attrbDataCn, code.code) > -1}"><c:if test="${num > 0}">, </c:if><c:out value="${code.codeNm}"/><c:set var="num" value="${num+1}"/></c:if>
							</c:forEach>
						</c:when>
						<c:when test="${addinfo.attrb eq '09'}"><c:out value="${addinfo.attrbNm}"/></c:when>
						<c:when test="${addinfo.attrb eq '14'}">
							<c:set var="data" value="${fn:split(addinfo.attrbDataCn,'|')}" />
							<c:out value="${data[0]}"/><br/><br/>동의여부: <c:out value="${data[1] eq 'Y' ? '동의' : '비동의'}"/>
						</c:when>
						<c:when test="${addinfo.attrb eq '15'}">
							<c:set var="files" value="${fileMap[addinfo.atchFileId]}" />
			    			<c:if test="${not empty files}">
					    		<a href="/ckl/cmm/fms/FileDown.do?atchFileId=<c:out value='${files[0].atchFileId}'/>&amp;fileSn=<c:out value='${files[0].fileSn}'/>">
					    			<c:out value="${files[0].orignlFileNm}"/>&nbsp;[<c:out value="${files[0].fileMg}"/>&nbsp;byte]
					    		</a>
					    	</c:if>
						</c:when>
						<c:otherwise>${addinfo.attrbDataCn}</c:otherwise>
					</c:choose>
				</dd>
			</dl>
		</c:forEach>
	</div>
	<!-- //dlList Table -->

	<div class="btnSet tar">
		<a href="/ckl/progrm/applcnt/listMypage.do?${pageQueryString}" class="btn btn-gray">목록</a>
	<c:if test="${result.rceptSttus ne '03'}">
		<c:if test="${masterResult.progrsSttus ne 'F'}"> <!-- 접수시간 마감 -->
			<a href="javascript:rceptSttusChange('<c:out value='${result.reqstSn}'/>', '<c:out value='${result.prgSn}'/>', '<c:out value='${result.prgSn}'/>');" class="btn btn-primary">신청/접수 취소</a>
		</c:if>
	</c:if>
	</div>
