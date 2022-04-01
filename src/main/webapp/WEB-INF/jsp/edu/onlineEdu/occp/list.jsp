
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" /> --%>


<!--content-->

	<div class="alert formLine">
		<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
			<input type="hidden" name="pGubun1" id="pGubun1" value='<c:out value="${not empty param.pGubun1?param.pGubun1:param.gubun }" />' />
			<input type="hidden" name="pGubun2" id="pGubun2" value='<c:out value="${not empty param.pGubun2?param.pGubun2:param.option1 }" />' />
			<input type="hidden" name="pGubun3" id="pGubun3" value='<c:out value="${not empty param.pGubun3?param.pGubun3:param.option5 }" />' />
			
			<input type="hidden" name="p_ordersnm" id="p_ordersnm" value='<c:out value="${param.p_ordersnm }"/>' />
			<input type="hidden" name="p_orders" id="p_orders" value='<c:out value="${param.p_orders }"/>' />

			<input type="hidden" name="p_subj" id="p_subj" value="" />
			<input type="hidden" name="p_subjnm" id="p_subjnm" value="" />
			<input type="hidden" name="p_isonoff" id="p_isonoff" value="" />
			<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="" />
			<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="" />
			<input type="hidden" name="p_year" id="p_year" value="" />
			<input type="hidden" name="p_subjseq" id="p_subjseq" value="" />
			
			<!-- paging s -->
			<input type="hidden" name="gubun" id="gubun" value="<c:out value='${param.gubun }' />" />
			<input type="hidden" name="option1" id="option1" value="<c:out value='${param.option1 }' />" />
			<input type="hidden" name="option5" id="option5" value="<c:out value='${param.option5 }' />" />
			<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${param.pageIndex }' />" />
			<!-- paging e -->
			

			<fieldset>
				<legend>검색 입력폼</legend>
				<div>
					<label for="p_searchtext" class="tac" style="width:130px"><strong>과정명</strong></label>
<!-- 					<select name="p_search" id="p_search" title="구분을 선택해 주세요." style="width:130px"> -->
<!-- 						<option value="title">제목</option> -->
<!-- 					</select> -->
					<input type="text" name="p_searchtext" id="p_searchtext" title="검색어를 입력해 주세요." value="${param.p_searchtext }" style="width:80%;" maxlength="30" />
					<a href="javascript:void(0);" onclick="fnCmdSearchList('A', '', '', 'subjnm', 'asc'); return false;" class="btn btn-primary">검색</a>
				</div>
			</fieldset>
		</form>
	</div>
	<div class="tar">
		<a href="/upload/onlineEdu/kocca_subjList.xlsx" class="btn btn-primary btnBlack icoDown mb30">에듀코카 과정 리스트 다운로드</a>
	</div>


	<div class="step">
		<ul>

			<!-- 직업별 탭 목록 s -->
			<c:forEach items="${occpTabList }" var="item" varStatus="status">

				<!-- 1depth s -->
				<c:choose>
					<c:when test="${item.code ne 'A'}">
						<li <c:if test="${param.pGubun1 eq item.code or param.gubun eq item.code }">class="on"</c:if>><a href="#sub${status.count }"><span <c:if test="${fn:length(realmTabList) eq status.count }">class="mr0"</c:if>>${item.codenm }</span></a>
					</c:when>
					<c:otherwise>
						<li <c:if test="${(empty param.pGubun1 and empty param.gubun) or param.pGubun1 eq 'A' }">class="on"</c:if>><a href="javascript:void(0);" onclick="fnCmdSearchList('${item.code }', '', '', 'subjnm', 'asc'); return false;"><span <c:if test="${fn:length(realmTabList) eq status.count }">class="mr0"</c:if>>${item.codenm }</span></a>
					</c:otherwise>
				</c:choose>
				<!-- 1depth e -->

					<c:if test="${item.code ne 'A'}">

						<div class="box" id="sub${status.count }">

							<!-- 직업별 탭 하위 목록 s -->
							<c:set var="nextcode" value="" />
							<c:forEach items="${occpSubTabList }" var="item2" varStatus="status2">

								<c:set var="jikcode" value="${item2.gubun1 }${item2.gubun2 }"  />
								<c:choose>
									<c:when test="${item.code eq jikcode }">
									
										<c:choose>
											<c:when test="${nextcode ne item2.gubun3 }">
												<dl>
													<dt>${item2.codenm }</dt>
													<dd>
														<a href="javascript:void(0);" onclick="fnCmdSearchList('${item2.gubun1 }${item2.gubun2 }', '${item2.gubun3 }', '${item2.gubun4 }', 'subjnm', 'asc'); return false;">${item2.gubun4nm }</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:void(0);" onclick="fnCmdSearchList('${item2.gubun1 }${item2.gubun2 }', '${item2.gubun3 }', '${item2.gubun4 }', 'subjnm', 'asc'); return false;">${item2.gubun4nm }</a>
											</c:otherwise>
										</c:choose>
										<c:set var="nextcode" value="${item2.gubun3 }" />
										<c:set var="nextVal" value="${occpSubTabList[status2.count] }" />
										
										<c:choose>
											<c:when test="${nextcode ne nextVal.gubun3 }">
													</dd>
												</dl>
											</c:when>
											<c:otherwise>
												<span class="bar"></span>
											</c:otherwise>
										</c:choose>
									
									</c:when>
									
									<c:otherwise>
											</dd>
										</dl>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<!-- 직업별 탭 하위 목록 e -->

							<span><a href="#self" class="closer"><span class="sr-only">하위메뉴 닫기</span></a></span>
						</div>

					</c:if>
				</li>
			</c:forEach>
			<!-- 직업별 탭 목록 e -->

		</ul>
	</div>


	<div class="row mb5">
		<div class="col-md-6">총 <strong class="fcRed">${resultCnt}</strong>건의 검색 결과가 있습니다.</div>
		<div class="col-md-6">
			<ul class="list-inline tar sorting">
				<li><a href="javascript:void(0);" onclick="fnCmdSearchList('${param.pGubun1 }', '${param.pGubun2 }', '${param.pGubun3 }', 'favorsubjcnt', 'asc'); return false;" <c:if test="${param.p_ordersnm eq 'favorsubjcnt' }">class="active"</c:if>>인기순</a></li>
				<li class="bgn"><a href="javascript:void(0);" onclick="fnCmdSearchList('${param.pGubun1 }', '${param.pGubun2 }', '${param.pGubun3 }', 'subjnm', 'asc'); return false;" <c:if test="${empty param.p_ordersnm or param.p_ordersnm eq 'subjnm' }">class="active"</c:if>>가나다순</a></li>
				
				
			</ul>
		</div>
	</div>

	<div class="photoGallery2 photoLine1">
	
	
		<!-- 직업소개 영역 s -->
		<c:if test="${param.pGubun2 ne null and param.pGubun2 ne ''}">
			<jsp:include page="/WEB-INF/jsp/edu/onlineEdu/occp/intJob.jsp" flush="true" />
		</c:if>
		<!-- 직업소개 영역 e -->
	

		<c:forEach items="${resultList }" var="item3" varStatus="status3">
			<ul>
				<li>
					<a href="javascript:void(0);" onclick="fnCmdViewPage('${item3.subj }', '${item3.subjnm }', '${item3.isonoff }', '${item3.scupperclass }', '${item3.uclassnm }', '${item3.scyear }', '${item3.subjseq }'); return false;">
						<% pageContext.setAttribute("crlf", "\\"); %>
						<span class="img">
							<c:choose>
								<c:when test="${item3.introducefilenamenew != null and item3.introducefilenamenew != '' }">
									<img alt="${item3.subjnm }" src="<c:out value="${fn:replace(item3.introducefilenamenew, crlf, '/') }" />" width="150px;" height="100px;" />
								</c:when>
								<c:otherwise>
									<img alt="${item3.subjnm }" src="/edu/images/edupro/stepsub-03.png" />
								</c:otherwise>
							</c:choose>

						</span>
						<span class="title point tal"><strong>${item3.subjnm }</strong></span>
						<span class="db tal">
							<c:set var="arrayofsubjintro" value="${fn:split(item3.intro,'-')}"/>
							<c:forEach var="i" begin="0" end="${fn:length(arrayofsubjintro)-1 }">
								- ${arrayofsubjintro[i] }<br />
							</c:forEach>
						</span>
						
						
					</a>
					<span class="linkers">
						<c:if test="${item3.isnew eq 'Y' }">
							<span class="ico1"><a href="#self"><img src="/edu/images/edupro/icolink_01.gif" alt="인기" /></a></span>
						</c:if>

						<c:if test="${item3.ishit eq 'Y' }">
							<span class="ico2"><a href="#self"><img src="/edu/images/edupro/icolink_02.gif" alt="추천" /></a></span>
						</c:if>

						<c:if test="${item3.mobileUseYn eq 'Y' }">
							<span class="ico3"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_03.gif" alt="모바일" /></a></span>
						</c:if>
					</span>
				</li>
			</ul>
		</c:forEach>
	</div>

	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
	</c:if>





<script type="text/javascript">
//<![CDATA[


	$(document).ready(function(){

		var stepLinks= $(".step li>a"); // 해당 탭리스트 링크 셀렉트
		$(stepLinks).each(function(index) {
			$(this).click(function() {
				var boxH = $(this).parent().find(".box").height()+120;

				$(this).parent().addClass('on').siblings().removeClass('on');
				$('.box').slideUp("fast");
				var boxHref = $(this).attr('href');
				$(boxHref).slideDown("fast");
				return false;
			});
		});
		$(".step .closer").click(function(){
			$('.box').slideUp("fast");
		});

		//과정 조회 enter key
		$("#p_searchtext").keydown(function(e) {
		    if (e.keyCode == 13) fnCmdSearchList('<c:out value="${param.pGubun1 }" />', '<c:out value="${param.pGubun2 }" />', '<c:out value="${param.pGubun3 }" />', 'subjnm', 'asc');
		});

	});


	//과정 조회
	function fnCmdSearchList(gubun1, gubun2, gubun3, ordersnm, orders){

		$("#pGubun1").val(gubun1);
		$("#pGubun2").val(gubun2);
		$("#pGubun3").val(gubun3);
		$("#p_ordersnm").val(ordersnm);

		if($("#p_orders").val() == "asc"){
			$("#p_orders").val("desc");
		}else{
			$("#p_orders").val("asc");
		}
		
		$("#pageIndex").val("1");
		$("#p_searchtext").val($.trim($("#p_searchtext").val()));
		$("#frm").attr({
					action:"/edu/onlineEdu/occp/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+gubun1+"&option1="+gubun2+"&option5="+gubun3,
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}

	//과정 상세화면
	function fnCmdViewPage(subj, subjnm, isonoff, scupperclass, uclassnm, scyear, subjseq){
		
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_isonoff").val(isonoff);
		$("#p_scupperclass").val(scupperclass);
		$("#p_uclassnm").val(uclassnm);
		$("#p_year").val(scyear);
		$("#p_subjseq").val(subjseq);
		
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/view.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+$("#pGubun1").val()+"&option1="+$("#pGubun2").val()+"&option5="+$("#pGubun3").val()+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}

//]]>
</script>





















