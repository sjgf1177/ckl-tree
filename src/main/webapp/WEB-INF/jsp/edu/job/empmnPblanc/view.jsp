<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<!-- rsg20170822 -->
<%
//rsg20170822
String scrollHeight = (String)request.getParameter("scrollHeight") != null && (String)request.getParameter("scrollHeight") != "" ? (String)request.getParameter("scrollHeight") : "0" ;

%>
<script>

	$(function(){
		// 팝업 처리 rsg20170831
		$(window).scrollTop( <%= scrollHeight %> );    
		if ( <%= scrollHeight %> != null && <%= scrollHeight %> != "" ) {
			$(".header_wrap").css("display","none");
			$(".footer_link_wrap").css("display","none");
			$(".footer_wrap").css("display","none");
			$(".sub_contents").css({"padding-top":"15px", "background-image":"none"});
			$(".sub_contents_wrap .sub_contents").css({"padding-bottom":"40px"});
			$(".board_util_btn_con .btn_style_0.full.list").css("display", "none");
		}
	});
	
</script>
<!-- //rsg20170822 -->

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


<c:if test="${result.deleteAt eq '0' }">
<div class="text_box_style_0_wrap">
<!-- //rsg20180119 -->

  <div class="text_box_style_0_header">
    <p class="text_box_style_0_title">알려드립니다.</p>
  </div>
  <div class="text_box_style_0_body">
  <!-- rsg20180119 -->
	<c:set var='infoFix' value='${result.infoFix eq null?-1:result.infoFix}'/>
		<!-- default -->
		<c:if test="${result.infoFix eq -1 or result.infoFix eq null}">
			     본 정보는 <c:out value="${result.entrprsNm }"/>에서 제공한 자료이며, 기재된 정보 내용에 대한 오류와 사용자가 본 정보를 신뢰하여 취한 모든 조치에 대하여 책임을
			    지지 않습니다. 상기정보는 동의없이 무단으로 재배포할 수 없습니다.
		</c:if>
		<!-- //default -->
		<!-- 미디어잡 -->
		<c:if test="${result.infoFix eq 1}">
			<div class="col-12 col-md-3 pt10 pb10 pr20 fn show-md-tablecell vm ">
				<a href="http://www.mediajob.co.kr" alt="미디어잡 링크(새창)" target="_blank">
					<img src="/upload/empmn/mediajob.jpg" alt="미디어잡 기업 이미지">
				</a>
			</div>
			<div class="col-12 col-md-9 fn show-md-tablecell">
			본 정보는 미디어잡에서 제공한 자료이며 에듀코카는 기재된 내용에 대한 오류 및 지연, 사용자가 이를 신뢰하여 취한 조취에 대한 책임을 지지 않습니다. <br>
			또한 본 정보는 미디어잡의 동의없이 재배포 할 수 없습니다.
			</div>
		</c:if>
		
		<!-- //미디어잡 -->
  </div>
</div>
<div class="mb30 alert">
	<div class="btn_style_2_con first">
		<span class="btn_style_2">일반</span>
	</div> <c:out value="${result.pblancNm }" />
</div>

<div class="over-hidden mb20">
	<div class="col-md-3">
		<div class="mt10 tac">
			<c:if test="${not empty imgUrl }">
				<img src="<c:out value="${imgUrl }" />" height="100" width="150" alt="<c:out value="${not empty fileVO.fileSn ? result.entrprsNm : ''}" />">
			</c:if>
		</div>
	</div>
	<c:remove var="fileVO"/>
	<div class="col-md-9">
	    <table class="contents_insight_view contact_us_view" summary="contact_us info view">
	        <caption>채용 정보 보기</caption>
	        <colgroup>
	            <col width="20%">
	            <col width="auto">
	            <col width="20%">
	            <col width="auto">
	        </colgroup>
	        <tbody>
	        <tr>
	            <th>기업명</th>
	            <td colspan="3"><c:out value="${not empty result.entrprsNm ? result.entrprsNm : '-'}" /></td>
	        </tr>
	        <tr>
	            <th>대표자명</th>
	            <td><c:out value="${not empty result.rprsntv ? result.rprsntv : '-' }" /></td>
	            <th>사원수</th>
	            <td><c:out value="${not empty result.emplCo ? result.emplCo : '-' }" /></td>
	        </tr>
	        <tr>
	            <th>자본금</th>
	            <td><c:out value="${not empty result.capl ? result.capl : '-' }" /></td>
	            <th>상장여부</th>
	            <td><c:out value="${result.lstAt eq 'Y' ? '상장' : '비상장' }" /></td>
	        </tr>
	        <tr>
	            <th>설립연도</th>
	            <td><c:out value="${not empty result.fondYear ? result.fondYear : '-' }" /></td>
	            <th>분야</th>
	            <td>
                    <c:forEach var="code" items="${COM099CodeList }" varStatus="status" >
                        <c:if test="${fn:trim(code.code) eq fn:trim(result.entrprsStle)}"><c:out value="${code.codeNm}" /></c:if>
                    </c:forEach>
                </td>
	        </tr>
	        <tr>
	            <th>홈페이지</th>
	            <td colspan="3">
	                <c:choose>
                        <c:when test="${not empty result.hmpg }">
                            <a href="http://<c:out value="${result.hmpg }"  />" target="_blank" title="새창 열길" ><c:out value="${result.hmpg }"/></a>
                        </c:when>
                        <c:otherwise>
                        -
                        </c:otherwise>
                    </c:choose>
	            </td>
	        </tr>
	        </tbody>
	    </table>
	</div>
</div>


<p class="alert_title">모집분야</p>
<div class="mb20 alert">
	<p>
	 <c:out value="${resultJoBNm2 }" />
	 <c:if test="${not empty resultJobNm1 and not empty resultJoBNm2 }">-</c:if>
	 <c:out value="${resultJobNm1 }" />
	</p>
</div>

<p class="alert_title">키워드</p>
<div class="mb20 alert">
	<p>
		<c:out value="${result.kwrd }" escapeXml="false" />
	</p>
</div>


<p class="alert_title">모집요강 및 자격 요건</p>

<div class="mb20 sub_board_body">
	<table class="board_type_0 small" summary="Application Guidelines and Qualifications" style="margin-bottom:0;">
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
				<td><c:out value="${result.rcritNmpr }" /></td>
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

<p class="alert_title">급여사항 </p>
<div class="mb20 alert">
	<p>

	<c:out value="${result.salary }" />

	</p>
</div>



<p class="alert_title">주요 업무내용</p>
<div class="mb20 alert">
	<c:out value="${result.jobCn}" escapeXml="false"/>
</div>


<p class="alert_title">제출 서류</p>
<div class="mb20 alert">
	<p>
			<% pageContext.setAttribute("crlf", "\n"); %>
			<c:out value='${fn:replace(result.presentnPapersCn, crlf, "<br/>")}' escapeXml="false"/>

	</p>
</div>



<p class="alert_title">전형방법</p>
<div class="mb20 alert">
	<p>
		<c:out value='${fn:replace(result.slectnMthCn, crlf, "<br/>")}' escapeXml="false"/>
	</p>
</div>

<p class="alert_title">접수기간</p>
<div class="mb20 alert">
	<p>
	<fmt:formatDate value="${result.rceptBeginDt }" pattern="yyyy-MM-dd"/> ~
	<c:choose>
		<c:when test="${result.rceptComptAt eq '2' }">채용시까지</c:when>
		<c:when test="${result.rceptComptAt eq '3' }">상시채용</c:when>
		<c:otherwise><fmt:formatDate value="${result.rceptEndDt }" pattern="yyyy-MM-dd"/></c:otherwise>
	</c:choose>

	</p>
</div>


<p class="alert_title">접수방법</p>
<div class="mb20 alert">
	<p>
	<c:out value='${fn:replace(result.rceptMthCn, crlf, "<br/>")}' escapeXml="false"/>
	</p>
</div>
<c:if test="${not empty result.atchFileId }">
<p class="alert_title">첨부파일</p>
<div class="mb20 alert">
	<p>
	<c:forEach var="file" items="${fileList}" varStatus="status">
		<a href="/edu/cmm/fms/FileDown.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}&amp;bbsId=${param.bbsId}" class="${icn}">
			<c:out value="${file.orignlFileNm}"/>&nbsp;[<c:out value="${file.fileMg}"/>&nbsp;byte] <br />
		</a>
	</c:forEach>
	</p>
</div>
</c:if>


<p class="alert_title">담당자정보</p>
<div class="mb30 sub_board_body">
	<table class="contents_insight_view contact_us_view" summary="recruit_manager_info detail" style="word-break:break-all;">
		<caption>담당자정보 상세</caption>
		<colgroup>
		<col style="width:20%"  />
		<col/>
		<col style="width:20%"  />
		<col/>
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
</c:if>

<c:if test="${result.deleteAt eq '1' }">

	<div class="mt40 mb40 tc">
		<h4>삭제된 게시글 입니다.</h4>
	</div>
	
</c:if>


<c:url var="url" value="/edu/job/${paramVO.programId}/list.do?"/>

<div class="board_util_btn_con">
	<a href="${url}&amp;${pageQueryString}" class="btn_style_0 full list">목록</a>
</div>


