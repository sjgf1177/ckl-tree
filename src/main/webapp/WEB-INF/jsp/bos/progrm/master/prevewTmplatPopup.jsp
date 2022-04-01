<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div id="wrap" class="popupWrap">

	<div class="row">
		<div class="col-md-12">
		<h1>신청부가정보 속성 항목</h1>
			<div class="panel panel-default">
				<div class="panel-body">

				<div style="width:95%;margin:0 auto;">

					<%-- <h2>개인정보 수집 및 이용 (필수)</h2>
					<div class="row">
						콘텐츠코리아랩은 프로그램 신청/접수을 위해 아래와 같은 최소한의 필수정보와 선택정보를 수집합니다.<br/><br/>
						개인정보보호를 위한 이용자 동의사항<br/>
						1. 수집•이용 목적 : [${masterResult.prgClNm}-${masterResult.prgNm}]의 신청/접수를 위한 사용자 정보 수집 및 이용<br/>
						2. 개인정보 수집 항목 :<br/>
						[프로그램]<br/>
						-	필수항목 :
						<c:set var="numY" value="0"/>
						<c:forEach var="val" items="${essntlAtYList}" varStatus="status">
							<c:if test="${numY > 0}">, </c:if><c:out value='${val.title}'/><c:set var="numY" value="${numY+1}"/>
						</c:forEach>
						<br/>
						-	선택항목 :
						<c:set var="numN" value="0"/>
						<c:forEach var="val" items="${essntlAtNList}" varStatus="status">
							<c:if test="${numN > 0}">, </c:if><c:out value='${val.title}'/><c:set var="numN" value="${numN+1}"/>
						</c:forEach>
						<br/>
						3. 개인정보 보유 및 이용기간 : 신청/접수 후 3년간 정보를 보관<br/>
						4. 동의 거부 시 불이익에 관한 사항 : 수집•이용에 관한 사항의 동의를 거부할 때에는 해당 서비스의 이용이 제한됩니다. 단, 선택정보 사항을 획득하지 못한 사유로 인하여 서비스 제공을 거부하지 않습니다.
						<br/><br/>
					</div> --%>

				<c:if test="${masterResult.indvdlinfoAgreAt eq 'Y'}">
					<h2>추가정보 수집 및 이용 동의</h2>
					<div class="row">
						<%-- <textarea name="TEXTA2" id="TEXTA2" cols="120" rows="12" class="col-md-12">${masterResult.indvdlinfoAgreCn}</textarea> --%>
						${masterResult.indvdlinfoAgreCn}
					</div>
				</c:if>

					<h2 class="clear ">개인정보</h2>
					<div class="tbrinfo text-danger clear"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>
					<div class="row">
						<div class="bdView">
							<%-- ${tmplatVal} --%>
							<table class="table table-bordered">
								<caption>기본정보입력</caption>
								<colgroup>
								<col style="width:15%">
								<col>
								</colgroup>
								<tbody>
									<c:forEach var="info" items="${listTmplatInfo}" varStatus="status">
										<c:import url="/bos/progrm/master/tmplatInfo.do" charEncoding="UTF-8">
											<c:param name="viewType" value="CONTBODY" />
											<c:param name="idx" value="${status.count}" />
											<c:param name="title" value="${info.title}" />
											<c:param name="key" value="${info.key}" />
											<c:param name="sortOrdr" value="${info.sortOrdr}" />
											<c:param name="essntlAt" value="${info.essntlAt}" />
											<c:param name="infoData" value="${info.infoData}" />
											<c:param name="prgSn" value="${param.prgSn}" />
										</c:import>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>

					<h2>신청부가정보</h2>
					<div class="alert alert-info">${param.gudanceWords}</div>

					<div class="tbrinfo text-danger clear m0"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 표시 항목은 필수 입력 항목입니다.</div>

					<div class="row">
						<div class="bdView">
							${addinfoVal}
						</div>
					</div>

				</div>

				<div class="btnSet tac">
					<a class="btn btn-primary" href="javascript:window.close();"><span>창닫기</span></a>
				</div>

	            </div>
	        </div>
		</div>
	</div>

</div>