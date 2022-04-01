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
    		<div class="container testbedmain">
    		</c:when>
    		<c:otherwise>
    		<div class="container testbedsub">
    		</c:otherwise>
    	</c:choose>
        
            <div class="row">
                <div class="col-xl-8 col-lg-8 col-md-12">
					<span>본 페이지에 게시된 이메일주소가 자동 수집되는 것을 거부하며, 이를 위반시 정보통신법에 의해 처벌됨을 유념하시기 바랍니다.</span>
					<ul>
                        <li>홍릉분원 : [02456] 서울특별시 동대문구 회기로 66</li>
                        <li>본원 : [58217] 전라남도 나주시 교육길 35 한국콘텐츠진흥원 | 사업자번호 : 105-82-17272</li>
                        <li>온라인교육 02-6310-0770</li>
                    </ul>
                    <span>Copyright 2015. Korea Creative Content Agency all rights reserved.</span>
                </div>
                <div class="col-xl-4 col-lg-4 col-md-12 ml-auto">
                    <a href="/edumobile/main/contents.do?menuNo=600083" class="app_download"><img src="/edu/new_image/download.jpg" alt="아카데미앱 다운로드"></a>
                    <div>
                        <select class="relation_site" name="relation_site" id="relation_site" onchange="window.open(this.options[this.selectedIndex].value,'_blank')" title="관련사이트 바로가기">
                            <option value="">관련사이트</option>
                                <option value="http://www.mcst.go.kr/main.jsp">문화체육관광부</option>
                                <option value="http://www.kocca.kr/cop/main.do">한국콘텐츠진흥원</option>
                                <option value="https://www.ckl.or.kr/ckl/main/main.do">콘텐츠코리아랩</option>
                                <%--<option value="http://www.culturist.or.kr/">종합인력정보</option> --%>
                                <!-- <option value="https://dream.kocca.kr/home.do">창의드림</option> -->
                                <option value="http://www.culturecontent.com/main.do">문화콘텐츠닷컴</option>
                                <option value="http://www.kgq.or.kr/service/pub/IntroServlet">게임국가자격기술검정</option>
                        </select>
                        <label for="relation_site"><span style="display:block; font-size:0; height:0; line-height:0; margin:0; overflow:hidden; padding:0; width:0">관련사이트 바로가기</span></label>
                        
                        
                        <ul class="footer_util_link" style="margin-top:-6px;">
                            <!-- <li><a href="#none" onclick="markPopupI('2017-R041');" title="새창열림">
                            	<img src="/edu/images/bm/footer_util_link_002.png" alt="인터넷 사이트 안전마크(i-Safe, 개인정보보호, 시스템보안, 소비자 보호)">
                            </a></li>
                            <li><a href="#none" onclick="markPopupE('2017-R088');" title="새창열림">
                            	<img src="/edu/images/bm/footer_util_link_001.png" alt="개인정보보호우수사이트(ePrivacy) 인증마크">
                            </a></li>
                            <li><a href="javascript:winMarkPopup('https://www.goodcontent.kr/upload_public/CERTIDW/2018-11-0008_0qx41u74mh4728j20181119134932.png','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림">
                                <img alt="굿콘텐츠 서비스 인증 마크" src="/edu/images/bm/footer_util_link_003.png">
                            </a></li>
                            <li><a href="javascript:winMarkPopup('/contents/temp/04_elearning.html','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림" >
                            	<img src="/edu/images/bm/footer_util_link_004.png" alt="한국u러닝연합회 e러닝전문기관인증 마크">
                            </a></li>
                            <li><a href="javascript:winMarkPopup('/contents/temp/01_contents_certificate.html','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림">
                            	<img src="/edu/images/bm/footer_util_link_005.png" alt="교육기부기관 교육부 Donation for Education 마크">
                            </a></li>
                            <li><a href="javascript:winMarkPopup('/contents/temp/internet_comunication_satisfaction_2018.html','','status=yes,scrollbars=no,width=430,height=575');" title="새창열림">
                           		<img width="27" height="28" src="/edu/images/bm/internet_comunication_satisfaction_logo_2018.png" alt="대한민국인터넷소통대상 (ICSI)인증마크">
                            </a></li>
                            <li><a href="javascript:winMarkPopup('/contents/temp/08_contents_certificate.html','','status=yes,scrollbars=no,width=430,height=560');" title="새창열림">
                                <img src="/edu/images/bm/footer_util_link_006.png" alt="에코어워드 인증 마크">
                            </a></li>
                            <li><a href="#" title="" >
                                <img alt="2018 소비자가 뽑은 올해의 브랜드 대상" src="/edu/images/bm/footer_util_link_007.png">
                            </a></li> -->
                            
                            <li style="width:100px;height:90px;">
                                <!-- <a href="http://webwatch.or.kr/certification/situation.html" title="새창열림" target="_blank">
                                    <img src="/upload/certificate/wa.png" alt="웹 접근성(WA)품질 인증마크 (공가 공인 인증 기관 웹와치)" style="width:80px;max-height:63px;">
                                </a> -->
                                <a href="http://www.webwatch.or.kr/Situation/WA_Situation.html?MenuCD=110" >
                                	<img src="/upload/certificate/WA2019.jpg" border="0" 
                                		alt="과학기술정보통신부 WEB ACCESSIBILITY 마크(웹 접근성 품질인증 마크)" 
                                		title="국가 공인 인증기관 : 웹와치 새창열림" target="_blank"
                                		style="width: 100px; max-height:90px;"/>
                                </a>
                        	</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 mobile_to_pc_view_btn_con">
    	<a href="https://edu.kocca.kr/edu/main/main.do?mobileTp=Y" class="mobile_btn_style_0">
    		PC버전
    	</a>
    	<a href="javascript:void(0)" class="mobile_btn_style_0 go_up_btn">
    		페이지 상단
    	</a>
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
