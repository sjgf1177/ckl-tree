<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
				<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
				<script type="text/javascript">
				$(document).ready(function() {
					window.history.forward(0);
				});
				$(document).keydown(function(e){
				    if(e.target.nodeName != "INPUT" && e.target.nodeName != "TEXTAREA"){
				        if(e.keyCode === 8){
				        return false;
				        }
				    }
				});

				</script>
				<!-- Step4 memberComplete -->
					<div class="signup_step_bar">
						<div class="step_wrap">
							<p class="step_box">
								<span class="step_title">
									STEP1
								</span>
								개인정보 동의
							</p>
						</div>
						<div class="step_line_wrap">
							<div class="step_right_arrow"></div>
						</div>
						<div class="step_wrap">
							<p class="step_box">
								<span class="step_title">
									STEP2
								</span>
								신청 정보 입력
							</p>
						</div>
						<div class="step_line_wrap">
							<div class="step_right_arrow"></div>
						</div>
						<div class="step_wrap">
							<p class="step_box">
								<span class="step_title">
									STEP3
								</span>
								입력내용 확인
							</p>
						</div>
						<div class="step_line_wrap">
							<div class="step_right_arrow"></div>
						</div>
						<div class="step_wrap active">
							<p class="step_box">
								<span class="step_title">
									STEP4
								</span>
								신청완료
							</p>
						</div>
					</div>

						<div>
							<h3>단체수강 신청 접수가 완료되었습니다.</h3>
							<div class="mb25 alert big_box">
								<p class="alert_desc is_margin_desc">단체수강서비스는 자체 사이버연수원을 개설해드리며 체계적인 관리를 위한 교육담당자 관리 페이지도 제공됩니다.<br />
									에듀코카 소개 자료를 통해 더 자세한 내용 확인 가능하며, 궁금하신 점은 아래 번호로 언제든지 연락주시기 바랍니다. </p>

								<p class="alert_desc">에듀코카 교육담당 : 02-6310-0770 / <a href="mailto:edukocca@kocca.kr" target="_blank" title="담당자에게 메일 보내기(새창열림)">edukocca@kocca.kr</a> </p>
							</div>
						</div>
						<div class="board_util_btn_con center">
							<a href="/" class="btn_style_0 full check">완료</a>
						</div>
					<!-- Step4 memberComplete -->