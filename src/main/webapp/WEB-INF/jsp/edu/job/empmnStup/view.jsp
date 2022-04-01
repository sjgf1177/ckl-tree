
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<%-- 반복문  --%>
<c:forEach var="fileList2" items="${fileList2}" varStatus="status">
	<c:if test="${fileList2.fileFieldName eq 'file1' }">
		<c:set var="fileVO" value="${fileList2 }"/>
	</c:if>
</c:forEach>

<c:choose>
	<c:when test="${empty fileVO.atchFileId and empty result.logoUrl}">
		<c:set value="/edu/images/common/company_noimg.jpg"  var="imgUrl"/>
	</c:when>
	<c:when test="${not empty fileVO.atchFileId and empty result.logoUrl}">
		<c:set value="/cmm/fms/getImage.do?atchFileId=${fileVO.atchFileId}&fileSn=${fileVO.fileSn}"  var="imgUrl"/>
	</c:when>
	<c:when test="${empty fileVO.atchFileId and not empty result.logoUrl }">
		<c:set value="${result.logoUrl }"  var="imgUrl"/>
	</c:when>
</c:choose>



<h2>채용정보</h2>
<div class="panel panel-primary">
  <div class="panel-heading">
    <h3 class="panel-title">알려드립니다.</h3>
  </div>
  <div class="panel-body">
    본 정보는 <c:out value="${result.entrprsNm }"/>에서 제공한 자료이며, 기재된 정보 내용에 대한 오류와 사용자가 본 정보를 신뢰하여 취한 모든 조치에 대하여 책임을
    지지 않습니다. 상기정보는 동의없이 무단으로 재배포할 수 없습니다.
  </div>
</div>
<div class="well">
	<span class="btn btn-sm btn-black">일반</span> <c:out value="${result.pblancNm }" />
</div>

<div class="row">
	<div class="col-md-3">
		<div class="mt10 tac">
			<c:if test="${not empty imgUrl }">
				<img src="<c:out value="${imgUrl }" />" height="100" width="150" alt="<c:out value="${not empty fileVO.fileSn ? result.entrprsNm : '이미지가 없습니다'}" />">
			</c:if>
		</div>
	</div>
	<c:remove var="fileVO"/>
	<div class="col-md-9">
		<dl class="dl-horizontal fl dlBordered vt" style="width:45%;margin-right:5%">
			<dt>기업명</dt>
			<dd><c:out value="${not empty result.entrprsNm ? result.entrprsNm : '-'}" /></dd>
			<dt>대표자명</dt>
			<dd><c:out value="${not empty result.rprsntv ? result.rprsntv : '-' }" /></dd>
			<dt>사원수</dt>
			<dd><c:out value="${not empty result.emplCo ? result.emplCo : '-' }" /></dd>
			<dt>설립연도</dt>
			<dd><c:out value="${not empty result.fondYear ? result.fondYear : '-' }" /></dd>
		</dl>
		<dl class="dl-horizontal fl dlBordered vt" style="width:45%;margin-right:5%">
			<dt>홈페이지</dt>
			<dd>
			<c:choose>
				<c:when test="${not empty result.hmpg }">
					<a href="http://<c:out value="${result.hmpg }"  />" target="_blank" title="새창 열길" ><c:out value="${result.hmpg }"/></a>
				</c:when>
				<c:otherwise>
				-
				</c:otherwise>
			</c:choose>

			</dd>
			<dt>자본금</dt>
			<dd><c:out value="${not empty result.capl ? result.capl : '-' }" /></dd>
			<dt>분야</dt>
			<dd>
				<c:forEach var="code" items="${COM099CodeList }" varStatus="status" >
					<c:if test="${fn:trim(code.code) eq fn:trim(result.entrprsStle)}"><c:out value="${code.codeNm}" /></c:if>
				</c:forEach>
			</dd>
			<dt>상장여부</dt>
			<dd><c:out value="${result.lstAt eq 'Y' ? '상장' : '비상장' }" /></dd>
		</dl>
	</div>
</div>


<h2>모집분야</h2>
<div class="alert alert-info">
	<p>
	 <c:out value="${resultJoBNm2 }" />
	 <c:if test="${not empty resultJobNm1 and not empty resultJoBNm2 }">-</c:if>
	 <c:out value="${resultJobNm1 }" />
	</p>
</div>

<h2>키워드</h2>
<div class="alert alert-info">
	<p>
		<c:out value="${result.kwrd }" escapeXml="false" />
	</p>
</div>


<h2>모집요강 및 자격 요건</h2>

<div class="bdList">
	<table class="table">
		<caption>
			<strong>모집요강 및 자격 요건</strong>
			<detail>
				<summary>인원,근무지,근무형태,경력,학력,성별로 구분되는 표</summary>
			</detail>
		</caption>
		<thead>
			<tr>
				<th scope="col">인원</th>
				<th scope="col">근무지</th>
				<th scope="col">근무형태</th>
				<th scope="col">경력</th>
				<th scope="col">학력</th>
				<th scope="col">성별</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><c:out value="${result.rcritNmpr }" /> 명</td>
				<td>
					<c:forEach var="code" items="${COM094CodeList }" varStatus="status" >
									<c:if test="${code.code eq fn:trim(result.wrkprc)}"><c:out value="${code.codeNm}" /></c:if>
					</c:forEach>
					<c:if test="${empty result.wrkprc }">-</c:if>
				</td>
				<td>
					<c:forEach var="code" items="${COM097CodeList }" varStatus="status" >
						<c:if test="${fn:indexOf(result.workStle, code.code) != -1}"><c:out value="${code.codeNm }" /><c:if test="${!status.last }">/</c:if></c:if>
					</c:forEach>
					<c:if test="${empty result.workStle }">-</c:if>
				</td>
				<td>
					<c:forEach var="code" items="${COM100CodeList }" varStatus="status">
						<c:if test="${code.code eq result.careerSe }"><c:out value="${code.codeNm }" /></c:if>
					</c:forEach>
					<fmt:formatNumber  var="career" value="${result.career/12}" maxFractionDigits="0" />
					<c:choose>
						<c:when test="${result.careerSe eq '02' and result.career >= 12}">
							<c:out value="${career }" />년 이상
						 </c:when>
						 <c:when test="${result.careerSe eq '02' and result.career < 12 }">
							<c:out value="${result.career }" />개월 이상
						 </c:when>
					 </c:choose>
				</td>
				<td>
					<c:forEach var="code" items="${COM096CodeList }">
							<c:if test="${code.code eq result.acdmcrSe }"><c:out value="${code.codeNm }" /></c:if>
					</c:forEach>
					<c:if test="${empty result.acdmcrSe }">-</c:if>
				</td>
				<td>
					<c:forEach var="code" items="${COM079CodeList }" varStatus="status" >
							<c:if test="${code.code eq result.sex }"><c:out value="${code.codeNm }" /></c:if>
					</c:forEach>
					<c:out value="${result.sex eq 'N' ? '무관':'' }" />
					<c:if test="${empty result.sex }">-</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>

<h3>급여사항 </h3>
<div class="alert alert-info">
	<p>

	<c:out value="${result.salary }" />

	</p>
</div>



<h2>주요 업무내용</h2>
<div class="well">
	<c:out value="${result.jobCn}" escapeXml="false"/>
</div>


<h2>제출 서류</h2>
<div class="well">
	<p>
			<% pageContext.setAttribute("crlf", "\n"); %>
			<c:out value='${fn:replace(result.presentnPapersCn, crlf, "<br/>")}' escapeXml="false"/>

	</p>
</div>



<h2>전형방법</h2>
<div class="well">
	<p>
		<c:out value='${fn:replace(result.slectnMthCn, crlf, "<br/>")}' escapeXml="false"/>
	</p>
</div>

<h2>접수기간</h2>
<div class="well">
	<p>
	<fmt:formatDate value="${result.rceptBeginDt }" pattern="yyyy-MM-dd"/> ~
	<c:choose>
		<c:when test="${result.rceptComptAt eq '2' }">채용시까지</c:when>
		<c:when test="${result.rceptComptAt eq '3' }">상시채용</c:when>
		<c:otherwise><fmt:formatDate value="${result.rceptEndDt }" pattern="yyyy-MM-dd"/></c:otherwise>
	</c:choose>

	</p>
</div>


<h2>접수방법</h2>
<div class="well">
	<p>
	<c:out value='${fn:replace(result.rceptMthCn, crlf, "<br/>")}' escapeXml="false"/>
	</p>
</div>
<c:if test="${not empty result.atchFileId }">
<h2>첨부파일</h2>
<div class="well">
	<p>
	<c:forEach var="file" items="${fileList}" varStatus="status">
		<a href="/edu/cmm/fms/FileDown.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
			<c:out value="${file.orignlFileNm}"/>&nbsp;[<c:out value="${file.fileMg}"/>&nbsp;byte] <br />
		</a>
	</c:forEach>
	</p>
</div>
</c:if>


<h2>담당자정보</h2>
<div class="bdView">
	<table  class="table table-bordered" >
		<caption>담당자정보 상세</caption>
		<colgroup>
		<col style="width:15%"  />
		<col  />
		<col style="width:15%"  />
		<col  />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">회사명</th>
				<td><c:out value="${not empty result.entrprsNm ? result.entrprsNm : '-' }"/></td>
				<th scope="row">담당자명</th>
				<td><c:out value="${not empty result.charger ? result.charger : '-'}" /></td>
			</tr>
			<tr>
				<th scope="row">연락처</th>
				<td> <c:out value="${not empty result.telno ? result.telno : '-'  }" /> </td>
				<th scope="row">이메일</th>
				<td><a href="mailto:<c:out value="${result.email }" />" target="_blank" title="담당자에게 이메일 보내기(새창열림)"><c:out value="${result.email }" /></a></td>
			</tr>
		</tbody>
	</table>
</div>




<c:url var="url" value="/edu/job/${paramVO.programId}/list.do?"/>

<div class="btnSet tar">
	<a href="${url}&amp;${pageQueryString}" class="btn btn-primary">목록</a>
</div>


