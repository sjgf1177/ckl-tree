<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>





<!-- bdList -->
<div>
	<div class="alert formLine1 formLine">
		<form action="/${paramVO.siteName }/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo }" method="post" class="form-inline">
			<fieldset>
				<legend>검색 입력폼</legend>
				<div>
					<label for="searchCnd" class="tac hidden"><strong>과정명</strong></label>
					<select name="searchCnd" id="searchCnd" title="검색 구분을 선택해 주세요.">
						<option value="1">제목</option>
					</select>
					<input type="text" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." value="">
					<input type="submit" id="input2" name="input2" value="검색" class="btn btn-primary">
					<c:if test="${not empty paramVO.searchWrd }">
					<a href="/${paramVO.siteName }/bbs/<c:out value="${paramVO.bbsId}" />/list.do?menuNo=<c:out value="${param.menuNo }"/>" class="btn btn-sm ml10">전체목록</a>
					</c:if>
				</div>
			</fieldset>
		</form>
	</div>
	<!-- backgroundColorBox : 1. #7d6857 2, #777777 3. #648602 4. #34546b, 5. # -->
	<div class="photoGallery4 bn"><!-- 5n+5의 간격으로 mr0클래스 필수 -->
		<ul class="photoBox">
			<c:forEach var="result" items="${resultList }" varStatus="status" >
				<c:choose>
					<c:when test="${status.index%11 eq 0 }">
					<c:set var="colorCode" value="#EB9856"/>
					</c:when>
					<c:when test="${status.index%11 eq 1 }">
					<c:set var="colorCode" value="#34546B"/>
					</c:when>
					<c:when test="${status.index%11 eq 2 }">
					<c:set var="colorCode" value="#87B304"/>
					</c:when>
					<c:when test="${status.index%11 eq 3 }">
					<c:set var="colorCode" value="#648DAB"/>
					</c:when>
					<c:when test="${status.index%11 eq 4 }">
					<c:set var="colorCode" value="#7B8836"/>
					</c:when>
					<c:when test="${status.index%11 eq 5 }">
					<c:set var="colorCode" value="#E8AC2A"/>
					</c:when>
					<c:when test="${status.index%11 eq 6 }">
					<c:set var="colorCode" value="#B99B5D"/>
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
						<c:if test="${result.option1 eq code.insttSn }">
							<c:set var="psitnCode" value="${code }" />
						</c:if>
				</c:forEach>

				<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<c:forEach var="fileList" items="${files }">
					<c:if test="${fileList.fileFieldName eq 'main_image' }">
						<c:set var="file" value="${fileList }" />
					</c:if>
				</c:forEach>

			<li> <a href="#self" class="inline">
				<c:if test="${not empty file}">
					<img src="/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}" alt="<c:out value="${result.nttSj }"/>" >
				</c:if>
				</a>
				<span class="db fl" style="background:<c:out value='${not empty psitnCode.themaColor ? psitnCode.themaColor:colorCode }'/>;">
				<c:url var="url" value="/${paramVO.siteName }/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&amp;${pageQueryString}" />
				<a href="<c:out value='${url}' escapeXml='false'/>" class="inline">
				<span class="title mb5"> <c:out value="${empty psitnCode.insttNm ? '기획' : psitnCode.insttNm }"/> </span>
				<span class="desc"><c:out value="${result.nttSj }"/></span> </a>
				<span class="w100p mt5">
					<span class="w40p fl fs13"><c:out value="${result.frstRegisterPnttm }" /></span>
					<span class="w60p fs13 tar"><span class="icoSm icoStory"></span><c:out value="${param.menuNm }" /> <c:out value="${result.option2Nm }"  escapeXml="false" /> </span></span>
				</span>
			</li>
			</c:forEach>
		</ul>
	</div>

	<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div>
	</c:if>
	<!-- //paging -->
</div>
<!-- //bdList -->