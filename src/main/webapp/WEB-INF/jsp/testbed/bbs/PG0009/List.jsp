
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>


<%-- 반복문  --%>

	<div class="col-12 mediazone_list_wrap">
		<div class="col-12 calc_wrap15">
		<c:forEach var="result" items="${resultList }" varStatus="status">
			<c:set value="${fileMap[result.atchFileId] }" var="fileList" />
			<c:forEach var="files" items="${fileList }">
				<c:if test="${files.fileFieldName eq 'main_image' }">
					<c:set  var="file" value="${files }"/>
				</c:if>
			</c:forEach>
			<div class="col-12 col-sm-6 tc mediazone_list">
				<div class="col-12 show fn mediazone_card">
					<a href=" /<c:out value="${paramVO.siteName }" />/bbs/<c:out value="${paramVO.bbsId }"/>/view.do?nttId=<c:out value="${result.nttId }"/>&amp;<c:out value="${pageQueryString }"  escapeXml="false"  />">
						<div class="img_box">
							<c:if test="${not empty file }">
								<img src='/cmm/fms/getImage.do?atchFileId=${file.atchFileId}&amp;fileSn=${file.fileSn}'  style="width: 300px;height: 150px;"  alt="<c:out value="${result.nttSj}"/>"  />
							</c:if>
						</div>
						<div class="text_box">
							<h5>
							<c:out value='${result.nttSj}' />
							</h5>
							<hr class="h_line5">
							<p class="h_desc5">
							<util:noTagStr length="150"  value="${result.nttCn}" brTp="true"  />
							</p>
							<p class="h_date5">
							<c:out  value="${result.frstRegisterPnttm}"/>
							</p>
						</div>
					</a>
				</div>
			</div>
			<c:set var="file" value=""/>
		</c:forEach>
		</div>
	</div>
	<c:if test="${fn:length(resultList) == 0}">
		<div class="col-12 mediazone_list_wrap">
			<div class="col-10 col-md-8 col-center tc mediazone_list">
				<div class="col-12 show fn mediazone_card nodata">
					<div class="img_box"></div>
					<div class="text_box">
						<h5>
							데이터가 없습니다.
						</h5>
					</div>
				</div>
			</div>
		</div>
	</c:if>

					<!-- paging -->
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
		<!-- paging end //-->
	</c:if>
	<!-- //paging -->
