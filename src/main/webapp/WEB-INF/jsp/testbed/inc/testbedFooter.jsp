<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
String menuNm = (String)request.getParameter("menuNm");
String menuNo = (String)request.getParameter("menuNo");
%>
<c:set var="menuNm" value="<%=menuNm %>"/>
<c:set var="menuNo" value="<%=menuNo %>"/>
<!-- 정보보호인증마크 JS -->
<script type="text/javascript" src="https://www.eprivacy.or.kr:40018/seal/mark.js"></script>
<script type="text/javascript">
function winMarkPopup(theURL,winName,features) { //v2.0
    window.open(theURL,winName,features);
}
</script>
<!-- 정보보호인증마크 JS -->

    <!-- footer -->
<div id="footer" class="col-12">
<c:choose>
	<c:when test="${menuNo eq '500108' }">
	<div class="testbedmain container">
	</c:when>
	<c:otherwise>
	<div class="testbedsub container">
	</c:otherwise>
</c:choose>
	<div class="col-xl-8 col-lg-8 col-md-12">
        <ul>
			<li><a href="javascript:winMarkPopup('http://www.kocca.kr/cop/contents.do?menuNo=200931','','status=yes,scrollbars=yes,width=1280,height=800')" 
			class="footer_link_item fontweight400" title="새창열림">개인정보처리방침</a></li>
			<li><a href="/edu/main/contents.do?menuNo=500072" class="footer_link_item">이용약관</a></li>
			<li><a href="/edu/bbs/B0000011/list.do?menuNo=500008" class="footer_link_item">공지사항</a></li>
			<li><a href="/edu/bbs/B0000046/list.do?menuNo=500073" class="footer_link_item">FAQ</a></li>
			<li><a href="/edu/main/contents.do?menuNo=500227" class="footer_link_item">찾아오시는길</a></li>
		</ul>
		<span>본 페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 이를 위반시 정보통신법에 의해 처벌됨을 유념하시기 바랍니다.</span>
		<ul>
             <li>홍릉분원 : [02456] 서울특별시 동대문구 회기로 66</li>
             <li>본원 : [58217] 전라남도 나주시 교육길 35 한국콘텐츠진흥원 | 사업자번호 : 105-82-17272</li>
             <li>온라인교육 02-6310-0770</li>
             <li>Copyright 2015. Korea Creative Content Agency all rights reserved.</li>
        </ul>
         	<br/>
        </div>
        <!-- onchange="window.open(this.options[this.selectedIndex].value,'_blank')"  -->
        <div class="col-xl-4 col-lg-4 col-md-12 ml-auto">
        	<div class="footer_sns_link">
				<span class="footer_sns_icon">
					<a href="https://www.facebook.com/edukocca" target="_blank" title="새창열림">
						<img src="/edu/images/bm/facebook_icon_color.png" alt="페이스북 바로가기">
					</a>
				</span>
				<span class="footer_sns_icon">
					<a href="https://twitter.com/edukocca" target="_blank" title="새창열림">
						<img src="/edu/images/bm/twitter_icon_color.png" alt="트위터 바로가기">
					</a>
				</span>
				<span class="footer_sns_icon">
					<a href="https://blog.naver.com/edukocca" target="_blank" title="새창열림">
						<img src="/edu/images/bm/blog_icon_color.png" alt="블로그 바로가기">
					</a>
				</span>
				<span class="footer_sns_icon">
					<a href="https://www.youtube.com/channel/UCJ78W_fNjOW7A-lZ6uEClgA" target="_blank" title="새창열림">
						<img src="/edu/images/bm/youtube_icon_color.png" alt="유튜브 바로가기">
					</a>
				</span>
				<span class="footer_sns_icon">
					<a href="https://www.instagram.com/edu.kocca/" target="_blank" title="새창열림">
						<img src="/edu/images/bm/instargram_icon_color.png" alt="인스타그램 바로가기">
					</a>
				</span>
			</div>
            <!-- <a href="/edu/main/contents.do?menuNo=500091" class="app_download"><img src="/edu/new_image/download.jpg" alt="아카데미앱 다운로드"></a> -->
            <div class="relation_site_link">
            	<select class="relation_site" name="relation_site" id="relation_site" title="관련사이트 바로가기">
                	<option value="">관련사이트</option>
                    <option value="http://www.mcst.go.kr/main.jsp">문화체육관광부</option>
                    <option value="http://www.kocca.kr/cop/main.do">한국콘텐츠진흥원</option>
                    <option value="https://www.ckl.or.kr/ckl/main/main.do">콘텐츠코리아랩</option>
                    <%--<option value="http://www.culturist.or.kr/">종합인력정보</option> --%>
                    <!-- <option value="https://dream.kocca.kr/home.do">창의드림</option> -->
                    <option value="http://www.culturecontent.com/main.do">문화콘텐츠닷컴</option>
                    <option value="http://www.kgq.or.kr/service/pub/IntroServlet">게임국가자격기술검정</option>
             	</select>
				<input type="button" value="이동" onclick="window.open(document.getElementById('relation_site').value,'_blank')" title="관련사이트 새창열림" class="relation_site_button">
	            <label for="relation_site"><span style="display:block; font-size:0; height:0; line-height:0; margin:0; overflow:hidden; padding:0; width:0">관련사이트 바로가기</span></label>
	            <ul class="footer_util_link">
                	<li>
                		<a href="#none" onclick="markPopupI('2019-R044');" title="새창열림">
                 			<img src="https://www.eprivacy.or.kr/seal/mark_i.gif" alt="인터넷 사이트 안전마크(i-Safe, 개인정보보호, 시스템보안, 소비자 보호)">
                 		</a>
                 	</li>
	                <li>
	                 	<a href="#none" onclick="markPopupE('2019-R105');" title="새창열림">
	                  		<img src="https://www.eprivacy.or.kr/seal/mark_e.gif" alt="개인정보보호우수사이트(ePrivacy) 인증마크">
	                  	</a>
	                </li>
					<li>
                    	<img alt="굿콘텐츠 서비스 인증 마크" src="/edu/images/bm/footer_util_link_003.png">
                 	</li>
                 	<li>
                 		<a href="javascript:winMarkPopup('/contents/temp/04_elearning.html','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림" >
                 			<img src="/edu/images/bm/footer_util_link_004.png" alt="한국u러닝연합회 e러닝전문기관인증 마크">
                 		</a>
                 	</li>
	                <li>
	                 	<a href="javascript:winMarkPopup('/contents/temp/01_contents_certificate.html','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림">
	                  		<img src="/edu/images/bm/footer_util_link_005.png" alt="교육기부기관 교육부 Donation for Education 마크">
	                  	</a>
	                </li>
                 	<li>
                 	 	<a href="javascript:winMarkPopup('/contents/temp/internet_comunication_satisfaction_2020.html','','status=yes,scrollbars=no,width=430,height=575');" title="새창열림">
                			<img src="/edu/images/bm/internet_comunication_satisfaction_logo_2019.png" alt="대한민국인터넷소통대상 (ICSI)인증마크">
                 		</a>
                 	</li>
                 	<li>
	                  	<a href="javascript:winMarkPopup('/contents/temp/08_contents_certificate.html','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림">
	                     	<img src="/edu/images/bm/footer_util_link_006.png" alt="에코어워드 인증 마크">
	                 	</a>
					</li>
                 	<li>
                 		<a href="http://www.webwatch.or.kr/Situation/WA_Situation.html?MenuCD=110" title="국가 공인 인증기관 : 웹와치 새창열림" target="_blank"><img src="/edu/images/bm/web_watch_mark.jpg" border="0" alt="과학기술정보통신부 WEB ACCESSIBILITY 마크(웹 접근성 품질인증 마크)"/>
                 		</a>
                 	</li>
             	</ul>
         	</div>
        </div>
	</div>
</div>
    
    <!-- //footer -->

<iframe name="ssoAuthFrame" id="ssoAuthFrame" style="width:0px;height:0px;border:0;" src="${ssoDomain }/sso/member/checkSSO.do?service=${paramVO.siteName }&amp;menuNo=<c:out value="${paramVO.menuNo }" />&amp;userTp=<c:out value="${userVO.userIdx }" />" title="SSO 로그인 유무확인 프레임 입니다."></iframe>

<%
	String ip = request.getRemoteAddr();
	request.setAttribute("myIp", ip);
%>
<c:if test="${'127.0.0.1' eq myIp or '112.220.85.26' eq myIp or myIp.indexOf('123.212.160') > 0}">
<div class="souceUrl"  style="color:#fff">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
</c:if>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-96105088-12', 'auto');
  ga('send', 'pageview');

</script>

<!-- UX분석 뷰저블 -->
<script type="text/javascript">
(function(w, d, a){
	w.__beusablerumclient__ = {
		load : function(src){
			var b = d.createElement("script");
			b.src = src; b.async=true; b.type = "text/javascript";
			d.getElementsByTagName("head")[0].appendChild(b);
		}
	};w.__beusablerumclient__.load(a);
})(window, document, '//rum.beusable.net/script/b170309e165707u559/204ae352d6');
</script>
<!-- UX분석 뷰저블 -->
