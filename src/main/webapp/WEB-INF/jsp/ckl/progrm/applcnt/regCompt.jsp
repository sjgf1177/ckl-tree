<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">
//<![CDATA[
//]]>
</script>

<div class="memberStep4">
	<div class="stepInline">
		<ol>
			<li>개인정보 동의</li>
			<li>신청 정보 입력</li>
			<li>입력내용 확인</li>
			<li class="on">신청완료<span class="sr-only">(현재단계)</span></li>
		</ol>
	</div>

	<div>
		<h3><c:out value="${masterResult.prgNm}"/> <c:out value="${result.rceptSttus eq '01' ? '(대기)' : ''}"/> 신청 접수가 완료되었습니다.</h3>
		<div>
			<p>신청/접수한 내용에 대해서는 마이페이지 [ 프로그램 신청/접수현황 ] 메뉴에서 내용 확인 및 신청/접수 취소를 하실 수 있습니다.</p>
			<p>신청/접수를 취소를 원하실 경우에는 신청 마감일까지 취소가 가능합니다.</p>
		</div>
	</div>

	<div>

		<div class="bdView">
			<table class="table table-bordered">
				<caption>기본정보입력</caption>
				<colgroup>
				<col style="width:15%">
				<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">신청/접수일시</th>
						<td>
							<c:out value="${result.rceptSttus eq '01' ? result.wDt : result.rDt}"/>
						</td>
					</tr>
				<c:if test="${masterResult.rceptNoIndictAt eq 'Y'}">
					<tr>
						<th scope="row">신청/접수번호</th>
						<td><c:out value="${result.resveNo}"/></td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>

		<h3>기본정보</h3>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>기본정보입력</caption>
				<colgroup>
				<col style="width:15%">
				<col>
				</colgroup>
				<tbody>
					<c:forEach var="info" items="${infoList}" varStatus="status">
						<c:import url="/ckl/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
							<c:param name="viewType" value="CONTBODY" />
							<c:param name="mode" value="M" />
							<c:param name="idx" value="${status.count}" />
							<c:param name="title" value="${info.title}" />
							<c:param name="key" value="${info.key}" />
							<c:param name="essntlAt" value="${info.essntlAt}" />
							<c:param name="sortOrdr" value="${info.sortOrdr}" />
							<c:param name="infoData" value="${info.infoData}" />
						</c:import>
					</c:forEach>
				</tbody>
			</table>
		</div>

	<c:if test="${param.agreAt eq 'Y'}">
		<div class="agreeScrBtm">
			<p>회원정보를 입력한 개인정보 내용으로 변경합니다.</p>
		</div>
	</c:if>

	<c:if test="${fn:length(addinfoList) > 0}">
		<div>
			<h3>신청부가정보</h3>
		</div>
		<div class="bdView">
			<table class="table table-bordered">
				<caption>신청부가정보</caption>
				<colgroup>
				<col style="width:15%">
				<col>
				<col style="width:15%">
				<col>
				</colgroup>
				<tbody>
					<c:forEach var="addInfo" items="${addinfoList}" varStatus="status">
						<c:import url="/ckl/progrm/master/tmplatAddinfo.do" charEncoding="UTF-8">
							<c:param name="viewType" value="CONTBODY" />
							<c:param name="mode" value="M" />
							<c:param name="idx" value="${status.count}" />
							<c:param name="attrbDataCn" value="${addInfo.attrbDataCn}" />
							<c:param name="addinfoSn" value="${addInfo.addinfoSn}" />
							<c:param name="iemNm" value="${addInfo.iemNm}" />
							<c:param name="attrb" value="${addInfo.attrb}" />
							<c:param name="addEssntlAt" value="${addInfo.addEssntlAt}" />
							<c:param name="sortOrdr" value="${addInfo.sortOrdr}" />
							<c:param name="attrbNm" value="${addInfo.attrbNm}" />
							<c:param name="iemCodeId" value="${addInfo.iemCodeId}" />
							<c:param name="fileNm" value="${addInfo.fileNm}" />
							<c:param name="userSn" value="${user.userIdx}" />
							<c:param name="prgSn" value="${param.prgSn}" />
						</c:import>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>

	</div>
	<div class="btnSet tac">
		<c:url var="url" value="/ckl/progrm/master/view.do?prgSn=${param.prgSn}&amp;prgSe=${param.prgSe}&amp;prgCl=${param.prgCl}&amp;menuNo=${param.menuNo}" />
		<a href="${url}" class="btn btn-primary">확인</a>
	</div>
</div>
