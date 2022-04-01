<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<h3 class="regCompt_title">1:1 컨설팅 신청이 <span class="text-danger">완료</span>되었습니다.</h3>

<div class="mb20 text_border_box corner">
	<ul class="list_style_15">
		<li>입력하신 정보를 바탕으로 취창업지원실에서 연락을 드릴 예정입니다. (업무일 기준 1~4일 이내)</li>
		<li>문의사항은 TEL 02-744-0530, Email : <a href="mailto:jobmaster@kooca.kr" target="_blank" title="담당자에게 메일 보내기(새창열림)">
			jobmaster@kooca.kr</a> 로 부탁드리겠습니다.</li>
		<li>이력서/자기소개서 클리닉 이용 시 아래의 버튼을 이용하여 이력서양식을 다운로드 하시기 바랍니다.
			</li>
	</ul>
</div>
<!-- <p>
<a href="/upload/culturist/resume.hwp" class="btn btn-gray" title="새창열림" target="_blank"><span class="icoHwp"></span> 이력서 양식 다운로드</a> 
</p> -->


<div class="board_util_btn_con center">
	<a href="/" class="btn_style_0 radius blue">메인으로 이동</a>
	<c:url value="/edu/job/empymnCnsl/empymnCnslListMypage.do" var="empymnCnslUrl">
		<c:param name="menuNo" value="${param.menuNo }"/>
	</c:url>
	<a href="<c:out value="${empymnCnslUrl }" />" class="btn_style_0 radius green">1:1 컨설팅 내역</a>
</div>