<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">
//<![CDATA[
//]]>
</script>

<div class="memberStep4">
	<div class="signup_step_bar recruit_step">
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP1</span>
	            개인정보 동의
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP2</span>
	            신청 정보 입력
	        </p>
	    </div>
	    <div class="step_line_wrap">
	        <div class="step_right_arrow">
	        </div>
	    </div>
	    <div class="step_wrap">
	        <p class="step_box">
	            <span class="step_title">STEP3</span>
	            입력내용 확인
	        </p>
	    </div>
	    
	    <c:choose>
		    <c:when test="${param.prgCl eq '10'}">
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap active">
			        <p class="step_box">
			            <span class="step_title">STEP4</span>
			       접수완료<span class="sr-only">(현재단계)</span>
			        </p>
			    </div>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP5</span>
				필수 온라인 과정 수료
			        </p>
			    </div>
			    <div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap">
			        <p class="step_box">
			            <span class="step_title">STEP6</span>
			            신청완료
			        </p>
			    </div>   
		    </c:when>
		    <c:otherwise>
		    	<div class="step_line_wrap">
			        <div class="step_right_arrow">
			        </div>
			    </div>
			    <div class="step_wrap active">
			        <p class="step_box">
			            <span class="step_title">STEP4</span>
			            신청완료<span class="sr-only">(현재단계)</span>
			        </p>
			    </div>
		    </c:otherwise>
	    </c:choose>
	    
	</div>

	<div class="mb20">
		<h3 class="regCompt_title">
			<c:choose>
				<c:when test="${param.prgCl eq '10'}">
					<c:out value="${masterResult.prgNm}"/> <c:out value="${result.rceptSttus eq '01' ? '(대기)' : ''}"/> 접수가 <span class="point0">완료</span>되었습니다.</h3>
				</c:when>
				<c:otherwise>
					<c:out value="${masterResult.prgNm}"/> <c:out value="${result.rceptSttus eq '01' ? '(대기)' : ''}"/> 신청이 <span class="point0">완료</span>되었습니다.</h3>
				</c:otherwise>
			</c:choose>
		<div class="text_border_box corner">
			<ul class="list_style_15">
				<c:if test="${param.prgCl eq '10'}">
					<li>신청/접수 후 <span class="point1">필수 온라인 과정 1개 이상 수료</span>해야 신청이 최종 완료됩니다.</li>
				</c:if>
				<li>신청/접수한 내용에 대해서는 마이페이지 <span class="point1">[ 프로그램 신청/접수현황 ]</span> 메뉴에서 내용 확인 및 신청/접수 취소를 하실 수 있습니다.</li>
				<li>신청/접수를 취소를 원하실 경우에는 <span class="point1">신청 마감일까지 취소가 가능</span>합니다.</li>	
			</ul>
		</div>
	</div>

	<%-- <div>

		<div class="bdView sub_board_body">
			<table class="table table-bordered contents_insight_view style_0">
				<caption>기본정보입력</caption>
				<colgroup>
				<col style="width:15%">
				<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">신청/접수일시</th>
						<td>
							<c:out value="${result.rceptSttus eq '01' ? result.wDt : result.rDt}"/>
						</td>
					</tr>
				<c:if test="${masterResult.rceptNoIndictAt eq 'Y'}">
					<tr>
						<th scope="row">신청/접수번호</th>
						<td><c:out value="${result.resveNo}"/></td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>

		<h3>기본정보</h3>
		<div class="bdView sub_board_body">
			<table class="table table-bordered contents_insight_view style_0">
				<caption>기본정보입력</caption>
				<colgroup>
				<col style="width:15%">
				<col>
				</colgroup>
				<tbody>
					<c:forEach var="info" items="${infoList}" varStatus="status">
						<c:import url="/edu/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
							<c:param name="viewType" value="CONTBODY" />
							<c:param name="mode" value="M" />
							<c:param name="idx" value="${status.count}" />
							<c:param name="title" value="${info.title}" />
							<c:param name="key" value="${info.key}" />
							<c:param name="essntlAt" value="${info.essntlAt}" />
							<c:param name="sortOrdr" value="${info.sortOrdr}" />
							<c:param name="infoData" value="${info.infoData}" />
						</c:import>
					</c:forEach>
				</tbody>
			</table>
		</div>

	<c:if test="${param.agreAt eq 'Y'}">
		<div class="agreeScrBtm">
			<p>회원정보를 입력한 개인정보 내용으로 변경합니다.</p>
		</div>
	</c:if>

	<c:if test="${fn:length(addinfoList) > 0}">
		<div>
			<h3>신청부가정보</h3>
		</div>
		<div class="bdView sub_board_body">
			<table class="table table-bordered contents_insight_view style_0">
				<caption>신청부가정보</caption>
				<colgroup>
				<col style="width:20%">
				<col>
				</colgroup>
				<tbody>
					<c:forEach var="addInfo" items="${addinfoList}" varStatus="status">
						<c:import url="/edu/progrm/master/tmplatAddinfo.do" charEncoding="UTF-8">
							<c:param name="viewType" value="CONTBODY" />
							<c:param name="mode" value="M" />
							<c:param name="idx" value="${status.count}" />
							<c:param name="attrbDataCn" value="${addInfo.attrbDataCn}" />
							<c:param name="addinfoSn" value="${addInfo.addinfoSn}" />
							<c:param name="iemNm" value="${addInfo.iemNm}" />
							<c:param name="attrb" value="${addInfo.attrb}" />
							<c:param name="addEssntlAt" value="${addInfo.addEssntlAt}" />
							<c:param name="sortOrdr" value="${addInfo.sortOrdr}" />
							<c:param name="attrbNm" value="${addInfo.attrbNm}" />
							<c:param name="iemCodeId" value="${addInfo.iemCodeId}" />
							<c:param name="fileNm" value="${addInfo.fileNm}" />
							<c:param name="userSn" value="${user.userIdx}" />
							<c:param name="prgSn" value="${param.prgSn}" />
						</c:import>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>

	</div> --%>
	<div class="board_util_btn_con center">
        <a href="/edu/main/main.do" class="btn_style_0 radius blue">
            메인으로 이동
        </a>
        <a href="/edu/progrm/applcnt/listMypage.do?menuNo=500064" class="btn_style_0 radius green">
            사전등록 내역 보기
        </a>
    </div>
	<%-- <div class="board_util_btn_con">
		<c:url var="url" value="/edu/progrm/master/view.do?prgSn=${param.prgSn}&amp;prgSe=${param.prgSe}&amp;prgCl=${param.prgCl}&amp;menuNo=${param.menuNo}" />
		<a href="${url}" class="btn_style_0 full check">확인</a>
	</div> --%>
</div>
