<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

			<jsp:include page="/WEB-INF/jsp/edu/inc/eduHead.jsp" flush="true" />
			
		<div class="lectListSet" style="min-height:auto;text-align:center;">
			<div class="lectListInner">
				<div class="lectTitle mb20">
					<h3 class="pt20">차시목록</h3>
					<span class="linkers">
	
						<c:if test="${viewdata.isnew eq 'Y' }">
							<span class="ico1"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_01.gif" alt="인기" /></a></span>
						</c:if>
	
						<c:if test="${viewdata.ishit eq 'Y' }">
							<span class="ico2"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_02.gif" alt="추천" /></a></span>
						</c:if>
	
						<c:if test="${viewdata.mobileUseYn eq 'Y' }">
							<span class="ico3"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_03.gif" alt="모바일" /></a></span>
						</c:if>
					</span>
				</div>
	
	
				<!-- 수업진도율 -->
				<div class="lectProgressSet">
					<div class="lecProgress"></div>
					<div class="lectProBar mt5">
						<div class="progress-bar progress-bar-success" style="width:<fmt:parseNumber integerOnly="true" value="${myProgress }" type="number" />%" title="<fmt:parseNumber integerOnly="true" value="${myProgress }" type="number" />% 진도율">
							<span class="icon progressInfo"><fmt:parseNumber integerOnly="true" value="${myProgress }" type="number" /><span class="sr-only">% 진도율</span></span>
						</div>
						<c:choose>
							<c:when test="${p_subj eq 'CK20010'}">
								<div class="progress-bar progressIng" style="width: 100%;" title="수료기준 진도100%">
									<span class="sr-only">수료기준 진도100%</span>
								</div>
							</c:when>
							<c:otherwise>
								<div class="progress-bar progressIng" style="width: 70%;" title="수료기준 진도70%">
									<span class="sr-only">수료기준 진도70%</span>
								</div>
							</c:otherwise>
						</c:choose>
						
					</div>
					<p class="point" align="center"><strong>진도율(%)</strong></p>
					<c:choose>
						<c:when test="${p_subj eq 'CK20010'}">
							<div class="row">
								<div class="col-md-6">수료기준 진도 100%</div>
								<c:if test="${myProgress ge 100.0 }">
									<div class="col-md-6 tar"><span class="icon icoSm lectCheck"></span> 수료함</div>
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<div class="row">
								<div class="col-md-6">수료기준 진도 70%</div>
								<c:if test="${myProgress ge 70.0 }">
									<div class="col-md-6 tar"><span class="icon icoSm lectCheck"></span> 수료함</div>
								</c:if>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- //수업진도율 -->
	
	
				<div class="lectList">
					<ul>
						<c:set var="isEducated" value="" />
						<c:forEach items="${eduLessonList }" var="item" varStatus="status">
	
							<li class="marker <c:if test="${item.lesson eq param.s_lesson }"> on </c:if> "><!-- 즐겨찾기 항목: marker, 현재 탭: on -->
	
								<a href="javascript:void(0);" onclick="parent.fnCmdLrnAction('${item.lesson }'); return false;">
									<span class="descs">${item.lesson }. ${item.sdesc }</span>
	
									<c:set var="isEducated" value="" />
									<c:choose>
										<c:when test="${item.starting eq null or item.starting eq '' }"><c:set var="isEducated" value="P" /></c:when>
										<c:when test="${item.firstEdu ne null and item.firstEdu ne '' }"><c:set var="isEducated" value="Y" /></c:when>
										<c:otherwise><c:set var="isEducated" value="" /></c:otherwise>
									</c:choose>
	
									<c:if test="${isEducated eq 'Y' }">
	
										<c:if test="${item.ldate ne null and item.ldate ne ''}">
											<span class="date point">
												<span class="icon icoSm icoBook"></span>
												<fmt:parseDate var="dateString" value="${item.ldate}" pattern="yyyyMMddHHmmss" />
											 	학습일 : <fmt:formatDate value="${dateString}" pattern="yyyy.MM.dd HH:mm" />
											 </span>
										</c:if>
										<c:if test="${not empty item.firstEdu }"> <span class="icon markerIco"><span class="sr-only">진도체크 항목</span></span></c:if>  <!-- 진도체크 항목 -->
										<span class="icon icoIngarr"><span class="sr-only">현재 진행중</span></span><!-- 현재 진행중 -->
									</c:if>
								</a>
							</li>
	
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

