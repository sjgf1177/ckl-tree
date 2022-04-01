<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>

<script type="text/javascript" src="/js/slider.js"></script>

<div class="jobMain">
	<!-- section1 -->
	<div class="section01">

		<div class="sm1RollingSet">

			<!-- popupzone -->
			<div class="popupzone">
				<div class="ctrl">
					<button type="button" class="popupzone_play"><span>알림판 재생</span></button>
					<button type="button" class="popupzone_stop"><span>알림판 정지</span></button>
					<button type="button" class="popupzone_pre"><span>알림판 이전보기</span></button>
					<button type="button" class="popupzone_next"><span>알림판 다음보기</span></button>
				</div>
				<div class="area">
					<ul>
						<c:forEach items="${popupList}" var="result" varStatus="status">
							<li>
								<a href="#pop_list_${status.count}" class="num">
									<span class="r"><span class="t">${status.count}번 팝업 보기</span></span>
								</a>
								<a href="<c:out value="${result.ntcnUrl}"/>" <c:if test="${result.popupAt eq 'Y'}">target="_blank"</c:if> class="view" id="pop_list_${status.count}" title="새창열림">
									<img class="thumbLg" src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&amp;fileSn=<c:out value="${result.file1Sn}"/>" title="<c:out value="${result.ntcnNm}"/>" alt="<c:out value="${result.ntcnNm}"/>" />
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<script type="text/javascript">
				//<![CDATA[
					jQuery(function(){
						jQuery(".popupzone").slideCtrl({
							//photo_list : jQuery('.popupzone>.area li'),
							photo_list_left : jQuery('.popupzone_pre'),
							photo_list_right : jQuery('.popupzone_next'),
							photo_list_play : jQuery(".popupzone_play"),
							photo_list_stop : jQuery(".popupzone_stop"),
							FXconfig:true,
							d_time : 3000
						});
					});
				//]]>
				</script>
			</div>
			<!-- //popupzone -->

		</div>

		<div class="noticeSet">
			<div class="notice">
				<h2><a href="#self">공지사항</a></h2>
				<ul>
					<c:forEach items="${B0000011List}" var="result" varStatus="status">
						<li><a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008"><c:out value="${result.nttSj}"/></a></li>
					</c:forEach>
				</ul>
				<div class="tac">
					<a href="/edu/bbs/B0000011/list.do?menuNo=500008" class="more"><span class="hidden">공지사항 더보기</span></a>
				</div>
			</div>

		</div>

	</div>


	<div class="submainCtsSet">

		<div class="section02">
			<div class="ingJobSet">
			<!-- ingJob -->
				<h2>콘텐츠의 미래를 만나다</h2>
				<div class="ingJob">
					<ul>
						<c:forEach items="${B0000020List}" var="result" varStatus="status">
							<c:if test="${status.count == 3}"><c:set var="clss" value="class=mr0"/></c:if>
							<li ${clss}>
								<a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500011" >
									<c:choose>
										<c:when test="${not empty result.fileSn}">
											<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileFieldNm=main_image" alt="" />
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									<span class="title"><c:out value="${result.nttSj}" escapeXml="flase"/></span>
								</a>
								<span class="date"><c:out value="${result.frstRegisterPnttm}"/></span>
							 </li>
						</c:forEach>
					</ul>
					<a href="/edu/bbs/B0000020/list.do?menuNo=500011" class="more"><span class="hidden">콘텐츠의 미래를 만나다 더보기</span></a>
				</div>
			</div>
			<div class="ingJob2">
				<h2>발로뛰는 취 &#8226; 창업지원실</h2>
				<div class="boxs">
					<a href="/edu/bbs/<c:out value="${B0000047List[0].bbsId}"/>/view.do?nttId=<c:out value="${B0000047List[0].nttId}"/>&amp;menuNo=500095" >
						<c:choose>
							<c:when test="${not empty B0000047List[0].fileSn}">
								<img src="/cmm/fms/getImage.do?atchFileId=${B0000047List[0].atchFileId}&amp;fileSn=${B0000047List[0].fileSn}" alt="" />
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						<span class="title"><c:out value="${B0000047List[0].nttSj}" /></span>
					</a>
					<span class="date"><c:out value="${B0000047List[0].frstRegisterPnttm}"/></span>
				</div>
				<a href="/edu/bbs/B0000047/list.do?menuNo=500095" class="more"><span class="hidden">발로뛰는 취 &#8226; 창업지원실더보기</span></a>

			</div>
		</div>

		<div class="section03">
			<div class="jobInfoLt">
				<h2>채용정보</h2>

				<div class="listInfo">
					<ul class="jobList">
						<c:forEach items="${empmnLogoList}" var="result" varStatus="status">
							<c:if test="${status.count eq 4}"><c:set var="clss2" value="class=mr0"/></c:if>
							<li ${clss2}>
								<a href="/edu/job/empmnPblanc/view.do?pblancSn=<c:out value="${result.pblancSn}"/>&amp;menuNo=500093">
								<c:choose>
									<c:when test="${not empty result.fileSn}">
										<img src="/cmm/fms/getImage.do?atchFileId=${result.atchFileId}&amp;fileSn=${result.fileSn}" height="88" width="196" alt="" />
									</c:when>
									<c:otherwise>
										<img src="/edu/images/common/company_noimg.jpg" height="88" width="196" alt="">
									</c:otherwise>
								</c:choose>
								<span class="db inDesc">
									<strong class="comTit"><c:out value="${result.entrprsNm}"/></strong>
									<span class="desc"><c:out value="${result.pblancNm}" escapeXml="flase"/></span>
									<span class="descDay"><c:out value="${result.beginDt}"/>~<c:out value="${result.rceptComptAt eq 'Y' or empty result.endDt ? ' 채용시' : result.endDt}"/></span>
								</span></a>
							</li>
						</c:forEach>
					</ul>
					<a href="/edu/job/empmnPblanc/list.do?menuNo=500093" class="more"><span class="hidden">채용정보 더보기</span></a>
				</div>
			</div>

			<div class="mt30" style="width:312px;float:left;">
				<div class="bandBorder" style="height:10px;overflow:hidden;background-image:url(/edu/images/submain/jobInfoLink.gif)"></div>
				<div class="telLink">
					<span class="hidden">취/창업지원실 02-2161-0003~5, FAX : 02-2161-0080, E-mail:jobmaster@kocca.kr</span>
				</div>
				<div style="text-align:center;">
					<a href="https://api.happytalk.io/api/kakao/chat_open?yid=%40%ED%95%9C%EA%B5%AD%EC%BD%98%ED%85%90%EC%B8%A0%EC%95%84%EC%B9%B4%EB%8D%B0%EB%AF%B8&site_id=6000000011&category_id=66690&division_id=66691" target="_blank" title="새창 상담 팝업">
						<img src="/edu/images/submain/kakaoCounselBtn20170705.png" title="카카오톡으로 상담하세요" alt="한국콘텐츠아카데미 카카오톡 플러스친구 채널이 오픈되었습니다!카카오톡 플친 맺고 취업 1:1 상담 서비스도 만나보세요.각종 취업 관련 정보도 한국콘텐츠아카데미 플친을 맺으면 만나볼 수 있어요 :)" style="vertical-align: baseline; border: 0px solid rgb(0, 0, 0);">
						<span class="hidden">카카오톡으로 상담하세요</span>
					</a>
				</div>
				<div class="bandBorder" style="height:10px;overflow:hidden;background-image:url(/edu/images/submain/jobInfoLink.gif)"></div>
			</div>

			<%-- <div class="jobInfoRt">
				<h2>실시간 채용정보 현황</h2>
				<ul>
					<c:forEach items="${empmnList}" var="result" varStatus="status">
						<li>
							<a href="/edu/job/empmnPblanc/view.do?pblancSn=<c:out value="${result.pblancSn}"/>&amp;menuNo=500093">
								<strong class="comTit"><c:out value="${result.entrprsNm}"/></strong>
								<span class="desc"><c:out value="${result.pblancNm}" escapeXml="flase"/></span>
								<span class="descDay"><c:out value="${result.rceptBeginDt}"/>~<c:out value="${result.rceptComptAt eq 'Y' ? ' 채용시' : result.rceptEndDt}"/></span>
							</a>
						</li>
					</c:forEach>
				</ul>
				<a href="/edu/job/empmnPblanc/list.do?menuNo=500093" class="more"><span class="hidden">실시간 채용정보 현황 더보기</span></a>
			</div> --%>

		</div>
	</div>

</div>

