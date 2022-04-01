<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div id="footer">
		<div class="set">
			<!-- banner -->
			<div class="banner">
				<h2 class="sr-only">Banner Zone</h2>
				<div class="ctrl">
					<button type="button" class="banner_pre"><span>배너존 이전보기</span></button>
					<button type="button" class="banner_play"><span>배너존 재생</span></button>
					<button type="button" class="banner_stop"><span>배너존 정지</span></button>
					<button type="button" class="banner_next"><span>배너존 다음보기</span></button>
				</div>
				<div class="area">
					<div>
						<ul>
						<c:forEach var="banner" items="${bannerList }">
							<c:url var="imgUrl" value="/cmm/fms/getImage.do?atchFileId=${banner.atchFileId}&fileSn=${banner.fileSn}" />
							<li> <a href="<c:out value="${banner.bnrUrl }" />" target="_blank" title="새창열림(<c:out value='${banner.bnrNm }'/>)"> <img src="<c:out value='${imgUrl }' />" alt="<c:out value='${banner.bnrNm }'/>" /> </a> </li>
							<%--
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner02.gif" alt="농촌진흥청" /> </a> </li>
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner03.gif" alt="산림청" /> </a> </li>
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner04.gif" alt="농림축산검역본부" /> </a> </li>
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner05.gif" alt="국립종자원" /> </a> </li>
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner01.gif" alt="국립수산과학원" /> </a> </li>
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner02.gif" alt="국립수목원" /> </a> </li>
							<li> <a href="http://www.kocca.kr" target="_blank" title="새창열림"> <img src="/ckl/images/common/tmp_fbanner03.gif" alt="한국전통지식포털" /> </a> </li>
							 --%>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<!-- //banner -->



			<div class="fset">
				<div class="fl fLogoSet">
					<div class="fImages fLogo"><span class="sr-only">한국콘텐츠진흥원(하단로고)</span></div>
				</div>


				<div class="fContents">
					<div class="fLinks">
						<a href="/ckl/main/contents.do?menuNo=200047" class="ml0" title="새창열림"><strong>개인정보처리방침</strong></a>
						<a href="/ckl/main/contents.do?menuNo=200050">이용약관</a>
						<a href="/ckl/bbs/B0000037/list.do?menuNo=200016">문의하기</a>
						<a href="/ckl/main/contents.do?menuNo=200052">사이트맵</a>
					</div>
					<div class="footerRt">
						<a href="https://www.facebook.com/ContentKoreaLab" target="_blank" title="새창열림" class="fIcon faceBk mr5"><span class="sr-only">콘텐츠코리아랩 페이스북 바로가기</span></a>
						<a href="https://www.youtube.com/channel/UCfoovETPwMFH8dbW6NWMAnw" target="_blank" title="새창열림" class=" fIcon fUtube mr5"><span class="sr-only">콘텐츠코리아랩 유튜브 바로가기</span></a>
						<div class="selBox dib">
							<form name="siteForm1" action="none" method="post" class="dib" target="_blank" onsubmit="if(document.siteForm1.ftSiteUrl.value == '') {alert('Family Site를 선택해 주세요.');document.siteForm1.ftSiteUrl.focus();return false;} window.open(document.siteForm1.ftSiteUrl.value,'sitePop');return false;">
							<div class="selectBox dib">
								<label for="ftSiteUrl" class="sr-only">Family Site</label>
								<select id="ftSiteUrl" name="ftSiteUrl" class="vm replaceSel" title="Family Site를 선택해 주세요.(새창열림)">
									<option value="">Family Site</option>
									<option value="http://www.kocca.kr/">한국콘텐츠진흥원</option>
									<option value="http://portal.kocca.kr/portal/main.do">콘텐츠종합정보포털</option>
									<option value="http://edu.kocca.or.kr">에듀코카</option>
									<option value="http://www.culturecontent.com/">문화콘텐츠닷컴</option>
									<option value="http://www.kcdrc.kr">콘텐츠분쟁조정위원회</option>
									<option value="http://www.culturing.kr/main.do">컬처링</option>
									<option value="https://ctrd.kocca.or.kr/ext/main/main.jsp">연구개발정보관리시스템</option>
								</select>
							</div>
							<input type="image" src="/ckl/images/common/go.gif" alt="Family Site 이동(새창열림)" class="vm p0 mr5" />
							</form>

							<form name="siteForm2" action="none" method="get" class="dib" target="_blank" onsubmit="if(document.siteForm2.ftLinksUrl.value == '') {alert('관련사이트를 선택해 주세요.');document.siteForm2.ftLinksUrl.focus();return false;} window.open(document.siteForm2.ftLinksUrl.value,'sitePop');return false;">
							<div class="selectBox dib">
								<label for="ftLinksUrl" class="sr-only">관련사이트</label>
								<select name="ftLinksUrl" id="ftLinksUrl" class="vm replaceSel" title="관련사이트를 선택해 주세요.(새창열림)">
									<option value="">관련사이트</option>
									<option value="http://www.grb.or.kr ">게임물등급위원회</option>
									<option value="http://www.cfnmk.or.kr">국립박물관문화재단</option>
									<option value="http://www.gugakfm.co.kr">국악방송</option>
									<option value="http://www.kf.or.kr/">국제방송교류재단</option>
									<option value="http://www.kmrb.or.kr ">영상물등급위원회</option>
									<option value="http://www.kofic.or.kr ">영화진흥위원회</option>
									<option value="http://www.gokams.or.kr">예술경영지원센터</option>
									<option value="http://www.hanpac.or.kr">한국공연예술센터</option>
									<option value="http://www.visitkorea.or.kr">한국관광공사</option>
									<option value="http://www.klti.or.kr">한국문학번역원</option>
									<option value="http://www.kcti.re.kr">한국문화관광연구원</option>
									<option value="http://www.kofice.or.kr">한국문화산업교류재단</option>
									<option value="http://www.arko.or.kr">한국문화예술위원회</option>
									<option value="http://www.kpf.or.kr ">한국언론진흥재단</option>
									<option value="http://www.koreafilm.or.kr">한국영상자료원</option>
									<option value="http://www.copyright.or.kr">한국저작권위원회</option>
									<option value="http://www.kpipa.or.kr">한국출판문화산업진흥원</option>
									<option value="http://www.mcst.go.kr">문화체육관광부</option>
									<option value="http://www.kcc.go.kr">방송통신위원회</option>
									<option value="http://www.president.go.kr ">청와대</option>
								</select>
							</div>
							<input type="image" src="/ckl/images/common/go.gif" alt="관련사이트 이동(새창열림)" class="vm p0" />
							</form>
						</div>

						 <div class="logoGroup">
							<div><img src="/ckl/images/common/footer_06.png" alt="웹 접근성 우수사이트 인증마크(WA인증마크)" /></div>
						</div>

					</div>
					<div class="copyright">
						<p>본 페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 이를 위반시 정보통신법에 의해 처벌됨을 유념하시기 바랍니다.</p>
						<address>본원 : [58217] 전라남도 나주시 교육길 35 한국콘텐츠진흥원 | 사업자번호 : 105-82-17272<br />
						대학로분원 : [03082] 서울시 종로구 대학로 57 콘텐츠코리아랩 | 대표전화 : 02-2161-0000
						</address>
					</div>
					<div class="copy">Copyright 2015. Korea Creative Content Agency all rights reserved.</div>
				</div>
			</div>
		</div>
	</div>

<%
	String ip = request.getRemoteAddr();
	request.setAttribute("myIp", ip);
%>
<c:if test="${'127.0.0.1' eq myIp or '112.220.85.26' eq myIp }">
<div class="souceUrl">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
</c:if>

<!-- <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-71636448-1', 'auto');
  ga('send', 'pageview');

</script> -->

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-96105088-2', 'auto');
  ga('send', 'pageview');

</script>
