<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div id="footer">
		<div class="set">


			<div class="fset">
				<div class="fl fLogoSet">
					<div class="fImages fLogo"><span class="sr-only">Korea Creative Content Agency</span></div>
				</div>


				<div class="fContents">
					
					<div class="footerRt">
						<a href="https://www.facebook.com/ContentKoreaLab" target="_blank" title="새창열림" class="fIcon faceBk mr5"><span class="sr-only">Contents Korea Lab Facebook</span></a>
						<a href="https://www.youtube.com/channel/UCfoovETPwMFH8dbW6NWMAnw" target="_blank" title="새창열림" class=" fIcon fUtube mr5"><span class="sr-only">Contents Korea Lab YouTube</span></a>
					</div>
					<div class="copyright">
						<address>
							Headquarters : [58217] Gyoyookgil 35, Najusi, JeollaNamdo, KOCCA | Business registration : 105-82-17272 <br />
							Daehakro office : [03082] Daehakro 57, Jongrogu, Seoul Contents Korea Lab | TEL : (+82-2) 2161-0000
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

