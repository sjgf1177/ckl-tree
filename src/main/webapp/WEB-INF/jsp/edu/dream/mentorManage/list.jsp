

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<script type="text/javascript">
//<![CDATA[
$(function() {
	if ($(".listLineRt").find("li.fb").size() > 0) {
		document.title = $(".listLineRt").find("li.fb").text() + " " +  document.title;
	}
});
//]]>
</script>


<div class="tab_style_1_con">
	<ul class="tab_style_1 three_tab size_24">
		<li><a href="/edu/dream/mainRsltManage/list.do?menuNo=500040"><span>사업소개</span></a></li>
		<li><a href="/edu/dream/pltfomList/list.do?menuNo=500117"><span>플랫폼기관</span></a></li>
		<!-- <li class="active"><a href="/edu/dream/mentorManage/list.do?menuNo=500119" title="현재탭"><span>멘토라인업</span></a></li> -->
		<li><a href="/edu/bbs/B0000041/list.do?menuNo=500211"><span>창의현장</span></a></li>
	</ul>
</div>

<div class="col-12 mentoringlineup_header">
	<div class="col-5 text_box">
		<h5>
			<span>CATEGORY</span>
			MENU
		</h5>
		<hr class="h_line5">
		<ul class="list_style_6">
		<c:set var="curInsttSn" value="${param.insttSn}"/>
		<c:forEach var="code" items="${psitnCodeList }" varStatus="status">
			<li <c:if test="${curInsttSn eq  code.insttSn }">class="active"</c:if>>
				<a href="/edu/dream/mentorManage/list.do?menuNo=<c:out value="${paramVO.menuNo }"/>&amp;insttSn=<c:out value="${code.insttSn}"/>">
					<span class="list_title"><span class="is_title_wrap"></span><c:out value="${fn:trim(code.insttNm)}" /></span>
				</a>
			</li>
		</c:forEach>
		</ul>
	</div>
	<div class="col-8 img_box">
		<img src="/edu/images/bm/mentoringlineup_img_002.jpg" alt="멘토라인업 탭메뉴 이미지">
	</div>
</div>
<div class="mobile_full_select_box_con">
	<select name="mentorlineup_list" id="mentorlineup_list" title="카테고리를 선택해 주세요">
		<c:set var="curInsttSn" value="${param.insttSn}"/>
		<c:forEach var="code" items="${psitnCodeList }" varStatus="status">
			<option value="/edu/dream/mentorManage/list.do?menuNo=<c:out value="${paramVO.menuNo }"/>&amp;insttSn=<c:out value="${code.insttSn}"/>">
				<c:out value="${fn:trim(code.insttNm)}" />
			</option>
		</c:forEach>
    </select>
    <!-- <label for="mentorlineup_list"></label> -->
</div>
<script type="text/javascript">
    $("#mentorlineup_list").on("change", function(){
        if( this.value == "" ) return;
        else window.open(this.value);
    })
</script>
<div class="mentoringlineup_body web_mentoringlineup_body">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:choose>
		<c:when test="${status.index%11 eq 0 }">
			<c:set var="colorCode" value="#B6713A"/>
		</c:when>
		<c:when test="${status.index%11 eq 1 }">
			<c:set var="colorCode" value="#34546B"/>
		</c:when>
		<c:when test="${status.index%11 eq 2 }">
			<c:set var="colorCode" value="#678A00"/>
		</c:when>
		<c:when test="${status.index%11 eq 3 }">
			<c:set var="colorCode" value="#648DAB"/>
		</c:when>
		<c:when test="${status.index%11 eq 4 }">
			<c:set var="colorCode" value="#7B8836"/>
		</c:when>
		<c:when test="${status.index%11 eq 5 }">
			<c:set var="colorCode" value="#A98000"/>
		</c:when>
		<c:when test="${status.index%11 eq 6 }">
			<c:set var="colorCode" value="#937E4D"/>
		</c:when>
		<c:when test="${status.index%11 eq 7 }">
			<c:set var="colorCode" value="#888888"/>
		</c:when>
		<c:when test="${status.index%11 eq 8 }">
			<c:set var="colorCode" value="#7D6857"/>
		</c:when>
		<c:when test="${status.index%11 eq 9 }">
			<c:set var="colorCode" value="#575556"/>
		</c:when>
		<c:when test="${status.index%11 eq 10 }">
			<c:set var="colorCode" value="#EA7F85"/>
		</c:when>
	</c:choose>

	<c:forEach var="code" items="${psitnCodeList }">
		<c:if test="${result.insttSn eq code.insttSn }">
			<c:set var="psitnCode" value="${code }" />
		</c:if>
	</c:forEach>
	<c:set var="files" value="${fileMap[result.atchFileId] }" />
	<c:if test="${fn:length(files) gt 0}">
		<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
			<c:if test="${files[x].fileFieldName eq 'photo'}">
				<c:set var="file" value="${files[x]}" />
			</c:if>
		</c:forEach>
	</c:if>

	<c:if test="${status.index%2==0}">
	<div class="col-12 mentoringlineup_list">
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span>멘토링 분야 : <c:out value="${result.histCn }" /></span></p>
			
		</div>
	</div>
	</c:if>
	<c:if test="${status.index%2!=0}">
	<div class="col-12 mentoringlineup_list right">
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span>멘토링 분야 : <c:out value="${result.histCn }" /></span></p>
		</div>
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
	</div>
	</c:if>
	<c:set var="file" value="" />
	<c:set var="psitnCode" value="" />
	</c:forEach>
</div>

<div class="mentoringlineup_body mobile_mentoringlineup_body">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:choose>
		<c:when test="${status.index%11 eq 0 }">
			<c:set var="colorCode" value="#B6713A"/>
		</c:when>
		<c:when test="${status.index%11 eq 1 }">
			<c:set var="colorCode" value="#34546B"/>
		</c:when>
		<c:when test="${status.index%11 eq 2 }">
			<c:set var="colorCode" value="#678A00"/>
		</c:when>
		<c:when test="${status.index%11 eq 3 }">
			<c:set var="colorCode" value="#648DAB"/>
		</c:when>
		<c:when test="${status.index%11 eq 4 }">
			<c:set var="colorCode" value="#7B8836"/>
		</c:when>
		<c:when test="${status.index%11 eq 5 }">
			<c:set var="colorCode" value="#A98000"/>
		</c:when>
		<c:when test="${status.index%11 eq 6 }">
			<c:set var="colorCode" value="#937E4D"/>
		</c:when>
		<c:when test="${status.index%11 eq 7 }">
			<c:set var="colorCode" value="#888888"/>
		</c:when>
		<c:when test="${status.index%11 eq 8 }">
			<c:set var="colorCode" value="#7D6857"/>
		</c:when>
		<c:when test="${status.index%11 eq 9 }">
			<c:set var="colorCode" value="#575556"/>
		</c:when>
		<c:when test="${status.index%11 eq 10 }">
			<c:set var="colorCode" value="#EA7F85"/>
		</c:when>
	</c:choose>

	<c:forEach var="code" items="${psitnCodeList }">
		<c:if test="${result.insttSn eq code.insttSn }">
			<c:set var="psitnCode" value="${code }" />
		</c:if>
	</c:forEach>
	<c:set var="files" value="${fileMap[result.atchFileId] }" />
	<c:if test="${fn:length(files) gt 0}">
		<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
			<c:if test="${files[x].fileFieldName eq 'photo'}">
				<c:set var="file" value="${files[x]}" />
			</c:if>
		</c:forEach>
	</c:if>

	<c:if test="${status.index%2==0}">
	<div class="col-12 mentoringlineup_list">
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span>멘토링 분야 : <c:out value="${result.histCn }" /></span></p>
		</div>
	</div>
	</c:if>
	<c:if test="${status.index%2!=0}">
	<div class="col-12 mentoringlineup_list">
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span>멘토링 분야 : <c:out value="${result.histCn }" /></span></p>
		</div>
	</div>
	</c:if>
	<c:set var="file" value="" />
	<c:set var="psitnCode" value="" />
	</c:forEach>
</div>

<%-- <c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if> --%>

<script>
	$(function(){
		var selectListWrap = ".mentoringlineup_header .text_box ul";
		var classSelect = "active";

		if ( $( selectListWrap + " > li.active").length == 0 )
			$( selectListWrap + " li:first" ).addClass(classSelect);
	});
</script>

<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>



<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />

<script type="text/javascript">
//<![CDATA[
$(function() {
	if ($(".listLineRt").find("li.fb").size() > 0) {
		document.title = $(".listLineRt").find("li.fb").text() + " " +  document.title;
	}
});
//]]>
</script>


<div class="tab_style_1_con">
	<ul class="tab_style_1 three_tab size_33">
		<li><a href="/edu/dream/mainRsltManage/list.do?menuNo=500040"><span>사업소개</span></a></li>
		<li><a href="/edu/dream/pltfomList/list.do?menuNo=500117"><span>플랫폼기관</span></a></li>
		<li class="active"><a href="/edu/dream/mentorManage/list.do?menuNo=500119"><span>멘토라인업</span></a></li>
	</ul>
</div>

<div class="col-12 mentoringlineup_header">
	<div class="col-5 text_box">
		<h5>
			<span>CATEGORY</span>
			MENU
		</h5>
		<hr class="h_line5">
		<ul class="list_style_6">
		<c:set var="curInsttSn" value="${param.insttSn}"/>
		<c:forEach var="code" items="${psitnCodeList }" varStatus="status">
			<li <c:if test="${curInsttSn eq  code.insttSn }">class="active"</c:if>>
				<a href="/edu/dream/mentorManage/list.do?menuNo=<c:out value="${paramVO.menuNo }"/>&amp;insttSn=<c:out value="${code.insttSn}"/>">
					<span class="list_title"><span class="is_title_wrap"></span><c:out value="${fn:trim(code.insttNm)}" /></span>
				</a>
			</li>
		</c:forEach>
		</ul>
	</div>
	<div class="col-8 img_box">
		<img src="/edu/images/bm/mentoringlineup_img_002.jpg" alt="멘토라인업 탭메뉴 이미지">
	</div>
</div>
<div class="mobile_full_select_box_con">
	<select name="mentorlineup_list" id="mentorlineup_list">
		<c:set var="curInsttSn" value="${param.insttSn}"/>
		<c:forEach var="code" items="${psitnCodeList }" varStatus="status">
			<option value="/edu/dream/mentorManage/list.do?menuNo=<c:out value="${paramVO.menuNo }"/>&amp;insttSn=<c:out value="${code.insttSn}"/>">
				<c:out value="${fn:trim(code.insttNm)}" />
			</option>
		</c:forEach>
    </select>
    <label for="mentorlineup_list"></label>
</div>
<script type="text/javascript">
    $("#mentorlineup_list").on("change", function(){
        if( this.value == "" ) return;
        else window.open(this.value);
    })
</script>
<div class="mentoringlineup_body web_mentoringlineup_body">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:choose>
		<c:when test="${status.index%11 eq 0 }">
			<c:set var="colorCode" value="#B6713A"/>
		</c:when>
		<c:when test="${status.index%11 eq 1 }">
			<c:set var="colorCode" value="#34546B"/>
		</c:when>
		<c:when test="${status.index%11 eq 2 }">
			<c:set var="colorCode" value="#678A00"/>
		</c:when>
		<c:when test="${status.index%11 eq 3 }">
			<c:set var="colorCode" value="#648DAB"/>
		</c:when>
		<c:when test="${status.index%11 eq 4 }">
			<c:set var="colorCode" value="#7B8836"/>
		</c:when>
		<c:when test="${status.index%11 eq 5 }">
			<c:set var="colorCode" value="#A98000"/>
		</c:when>
		<c:when test="${status.index%11 eq 6 }">
			<c:set var="colorCode" value="#937E4D"/>
		</c:when>
		<c:when test="${status.index%11 eq 7 }">
			<c:set var="colorCode" value="#888888"/>
		</c:when>
		<c:when test="${status.index%11 eq 8 }">
			<c:set var="colorCode" value="#7D6857"/>
		</c:when>
		<c:when test="${status.index%11 eq 9 }">
			<c:set var="colorCode" value="#575556"/>
		</c:when>
		<c:when test="${status.index%11 eq 10 }">
			<c:set var="colorCode" value="#EA7F85"/>
		</c:when>
	</c:choose>

	<c:forEach var="code" items="${psitnCodeList }">
		<c:if test="${result.insttSn eq code.insttSn }">
			<c:set var="psitnCode" value="${code }" />
		</c:if>
	</c:forEach>
	<c:set var="files" value="${fileMap[result.atchFileId] }" />
	<c:if test="${fn:length(files) gt 0}">
		<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
			<c:if test="${files[x].fileFieldName eq 'photo'}">
				<c:set var="file" value="${files[x]}" />
			</c:if>
		</c:forEach>
	</c:if>

	<c:if test="${status.index%2==0}">
	<div class="col-12 mentoringlineup_list">
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span><c:out value ="${result.histSe eq '1' ? '대표작' : '약 력'}" /> : <c:out value="${result.histCn }" /></span></p>
			<p class="h_date6"><span>멘 티 :<c:out value="${result.mentoNm }" /></span></p>
		</div>
	</div>
	</c:if>
	<c:if test="${status.index%2!=0}">
	<div class="col-12 mentoringlineup_list right">
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span><c:out value ="${result.histSe eq '1' ? '대표작' : '약 력'}" /> : <c:out value="${result.histCn }" /></span></p>
			<p class="h_date6 right"><span>멘 티 :<c:out value="${result.mentoNm }" /></span></p>
		</div>
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
	</div>
	</c:if>
	<c:set var="file" value="" />
	<c:set var="psitnCode" value="" />
	</c:forEach>
</div>

<div class="mentoringlineup_body mobile_mentoringlineup_body">
	<c:forEach var="result" items="${resultList}" varStatus="status">
	<c:choose>
		<c:when test="${status.index%11 eq 0 }">
			<c:set var="colorCode" value="#B6713A"/>
		</c:when>
		<c:when test="${status.index%11 eq 1 }">
			<c:set var="colorCode" value="#34546B"/>
		</c:when>
		<c:when test="${status.index%11 eq 2 }">
			<c:set var="colorCode" value="#678A00"/>
		</c:when>
		<c:when test="${status.index%11 eq 3 }">
			<c:set var="colorCode" value="#648DAB"/>
		</c:when>
		<c:when test="${status.index%11 eq 4 }">
			<c:set var="colorCode" value="#7B8836"/>
		</c:when>
		<c:when test="${status.index%11 eq 5 }">
			<c:set var="colorCode" value="#A98000"/>
		</c:when>
		<c:when test="${status.index%11 eq 6 }">
			<c:set var="colorCode" value="#937E4D"/>
		</c:when>
		<c:when test="${status.index%11 eq 7 }">
			<c:set var="colorCode" value="#888888"/>
		</c:when>
		<c:when test="${status.index%11 eq 8 }">
			<c:set var="colorCode" value="#7D6857"/>
		</c:when>
		<c:when test="${status.index%11 eq 9 }">
			<c:set var="colorCode" value="#575556"/>
		</c:when>
		<c:when test="${status.index%11 eq 10 }">
			<c:set var="colorCode" value="#EA7F85"/>
		</c:when>
	</c:choose>

	<c:forEach var="code" items="${psitnCodeList }">
		<c:if test="${result.insttSn eq code.insttSn }">
			<c:set var="psitnCode" value="${code }" />
		</c:if>
	</c:forEach>
	<c:set var="files" value="${fileMap[result.atchFileId] }" />
	<c:if test="${fn:length(files) gt 0}">
		<c:forEach var="x" begin="0" end="${fn:length(files)-1}">
			<c:if test="${files[x].fileFieldName eq 'photo'}">
				<c:set var="file" value="${files[x]}" />
			</c:if>
		</c:forEach>
	</c:if>

	<c:if test="${status.index%2==0}">
	<div class="col-12 mentoringlineup_list">
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span><span class="mentoring_date6_title"><c:out value ="${result.histSe eq '1' ? '대표작' : '약 력'}" /></span><span class="mentoring_date6_semicolon"> : </span><c:out value="${result.histCn }" /></span></p>
			<p class="h_date6"><span><span class="mentoring_date6_title">멘 티</span><span class="mentoring_date6_semicolon"> : </span><c:out value="${result.mentoNm }" /></span></p>
		</div>
	</div>
	</c:if>
	<c:if test="${status.index%2!=0}">
	<div class="col-12 mentoringlineup_list">
		<div class="col-5 img_box">
			<c:if test="${not empty file }">
			<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nm } 멘토" />" />
			</c:if>
		</div>
		<div class="col-7 text_box">
			<h6>
				<c:out value="${result.nm }" /> 멘토
			</h6>
			<p class="h_dsec6">
				<c:out value="${result.psitn }" />
			</p>
			<p class="h_date6"><span><span class="mentoring_date6_title"><c:out value ="${result.histSe eq '1' ? '대표작' : '약 력'}" /></span><span class="mentoring_date6_semicolon"> : </span><c:out value="${result.histCn }" /></span></p>
			<p class="h_date6 right"><span><span class="mentoring_date6_title">멘 티</span><span class="mentoring_date6_semicolon"> : </span><c:out value="${result.mentoNm }" /></span></p>
		</div>
	</div>
	</c:if>
	<c:set var="file" value="" />
	<c:set var="psitnCode" value="" />
	</c:forEach>
</div>

<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>

<script>
	$(function(){
		var selectListWrap = ".mentoringlineup_header .text_box ul";
		var classSelect = "active";

		if ( $( selectListWrap + " > li.active").length == 0 )
			$( selectListWrap + " li:first" ).addClass(classSelect);
	});
</script>

<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>
 --%>