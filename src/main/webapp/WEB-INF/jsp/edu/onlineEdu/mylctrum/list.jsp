
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<link rel="stylesheet" type="text/css" href="/edu/css/mypage_new.css"  />

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" /> --%>


<!--content-->

<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
	<input type="hidden" name="tabtype" id="tabtype" value="<c:out value="${param.tabtype }" default="current" />" />
	<input type="hidden" name="p_subj" id="p_subj" value="" />
	<input type="hidden" name="p_year" id="p_year" value="" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" value="" />
	<input type="hidden" name="p_userid" id="p_userid" value="" />
	<input type="hidden" name="p_kind" id="p_kind" value="" />
	<input type="hidden" name="p_grcode" id="p_grcode" value="" />
	<input type="hidden" name="p_tabselect" id="p_tabselect" value="" />
	
	<input type="hidden" name="p_menuTab" id="p_menuTab" value="<c:out value="${param.p_menuTab }" />" />
	
	<input type="hidden" name="s_subj" id="s_subj" value="" />
	<input type="hidden" name="s_year" id="s_year" value="" />
	<input type="hidden" name="s_subjseq" id="s_subjseq" value="" />

</form>

<!-- stepInline 영역 s -->
<%-- <jsp:include page="/WEB-INF/jsp/edu/onlineEdu/mylctrum/mylctrumStep.jsp" flush="true" /> --%>
<!-- stepInline 영역 e -->

<!-- Tab -->
<div class="tab_style_1_con">
	<ul class="tab_style_1">
		<c:choose>
			<c:when test="${param.viewType eq 'old' }">
				<li><a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061&viewType=current"><span>현재학습</span></a></li>
				<li class="active"><a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061&viewType=old" title="현재탭"><span>지난과정</span></a></li>
			</c:when>
			<c:otherwise>
				<li class="active"><a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061&viewType=current" title="현재탭"><span>현재학습</span></a></li>
				<li><a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061&viewType=old"><span>지난과정</span></a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>
<!-- //Tab -->

<div class="mb10 alert big_box">
	<ul class="list_style_4 no_decimal color_gray dot">
		<li>진도율 <span class="point0">70% 이상</span> 되어야 수료증 출력 및 만족도 설문 가능</li>
		<li>열린강좌는 <span class="point0">테마과정에 등록된 내역</span>만 확인가능합니다.</li>
	</ul>
</div>
<!-- <div style="width:100%;text-align:right;margin-bottom:10px;">진도율 60% 이상 되어야 수료증 출력 및 만족도 설문 가능</div> -->
<div class="col-12 mypage_online_edu_list_wrap">
	<!-- 정규과정 학습목록 s -->
	<c:forEach items="${resultList }" var="item" varStatus="status">
	<div class="col-12 mypage_online_edu_list">
		<div class="col-12 mypage_online_edu_inner">
			<div class="mypage_online_edu_img_box">
				<c:choose>
					<c:when test="${item.introducefilenamenew != null and item.introducefilenamenew != '' }">
						<%-- <img alt="<c:out value="${item.subjnm }"/>" src="<c:out value="${fn:replace(item.introducefilenamenew, crlf, '/') }" />" width="290px;" height="190px;" /> --%>
						<!-- 실서버 업로드 시 위 img 태그 주석 풀어서 사용, 아래 img 태그는 제거 -->
						<img alt="<c:out value="${item.subjnm }"/>" src="${item.introducefilenamenew}" width="290px;" height="190px;" />
					</c:when>
					<c:otherwise>
						<img alt="<c:out value="${item.subjnm }"/>" src="/edu/images/bm/kofac_card_img_000.jpg" width="290px;" height="190px;" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="mypage_online_edu_text_box">
				<div class="mypage_online_edu_header">
					<c:choose>
						<c:when test="${item.contenttype eq 'GOLD' }">
							[열린강좌]
						</c:when>
						<c:otherwise>
							[정규과정]
						</c:otherwise>
					</c:choose>
				</div>
				<div class="mypage_online_edu_title">
					<c:out value="${item.subjnm }" /></span>
				</div>
				<c:choose>
					<c:when test="${item.contenttype eq 'GOLD' }">
						<div class="mypage_online_edu_learn_date">
							강좌신청일 : <span class="myapge_inline_edu_learn_date_num">${item.edustart}</span>
						</div>
					</c:when>
					<c:otherwise>
						<div class="mypage_online_edu_learn_date">
							강좌수강일 : <span class="myapge_inline_edu_learn_date_num">${item.edustart} ~ ${item.eduend}</span>
						</div>
						<div class="mypage_online_edu_learn_date">
							최근학습일 : <span class="myapge_inline_edu_learn_date_num">${item.lastStudy}</span> 
						</div>
					</c:otherwise>
				</c:choose>
				<div class="mypage_online_edu_link_btn_con">
					<a href="javascript:void(0);" class="mypage_online_edu_link_btn" onclick="fnCmdViewPage('${item.contenttype }','${item.subj}', '${item.year }', '${item.subjseq }', '${item.isuse }', '${item.possibleCnt }'); return false;">강의 바로가기</a>
				</div>
			</div>
		</div>
		<!-- 수업진도율 -->
		<c:if test="${item.contenttype ne 'GOLD' }">
			<div class="col-12 my_progress_bar_wrap">
				<div class="col-12 my_progress_bar_con">
					<div class="my_progress_bar_text">나의 진도율 (%)</div>
					
					<!-- <span class="my_progress_pass"><p class="pass_text">수료기준 진도 60%</p><img src="/edu/images/mypage/pro_flag.png" /></span> -->
					<c:set var="tstepPercent" value="${item.tstep - 1}"/>
					<c:set var="humanPercent" value="${item.tstep}"/>
					<c:if test="${item.tstep > 80}">
						<c:set var="tstepPercent" value="${item.tstep - 4}"/>
						<c:set var="humanPercent" value="${item.tstep - 2}"/>
					</c:if>
					<div class="my_progress_bar_box">
						<div class="my_progress_bar">
							<%-- <span class="my_progress_per" style="left:${tstepPercent}%"><fmt:parseNumber integerOnly="true" value="${item.tstep}" type="number" />%</span> --%>
							<%-- <span class="my_progress_run"><img src="/edu/images/mypage/pro_human.png"  style="left:${humanPercent}%"/></span> --%>
							<div class="my_progress_bar_value" style="width:${item.tstep}%"></div>
						</div>
						<div class="my_progress_bar_value_text">${item.tstep}%</div>
					</div>
				</div>
				
				<div class="col-12 my_progress_bar_con style_2">
					<c:set var="promotion" value="0"/>
					<c:choose>
						<c:when test="${item.promotion > 21}"><c:set var="promotion" value="100"/></c:when>
						<c:when test="${item.promotion > 15}"><c:set var="promotion" value="80"/></c:when>
						<c:when test="${item.promotion > 7}"><c:set var="promotion" value="60"/></c:when>
						<c:otherwise><c:set var="promotion" value="40"/></c:otherwise>
					</c:choose>
					<c:set var="promotionPercent" value="${promotion - 1}"/>
					<c:if test="${promotion > 80}"><c:set var="promotionPercent" value="${promotion - 4}"/></c:if>
					<div class="my_progress_bar_text">권장 진도율 (%)</div>
					
					<%-- <span class="re_progress_per" style="left:${promotionPercent}%"><fmt:parseNumber integerOnly="true" value="${promotion}" type="number" />%</span> --%>
					<%-- <span class="re_progress_complete" style="width:${promotion}%"></span> --%>
					<div class="my_progress_bar_box">
						<div class="my_progress_bar">
							<div class="my_progress_bar_value" style="width:${promotion}%"></div>
						</div>
						<div class="my_progress_bar_value_text">${promotion}%</div>
					</div>
				</div>
			</div>
		</c:if>
		<!-- 수업진도율 -->
		
		<%--
		* 학습기간별 권장진도율
		1~7일 : 40%
		8~15일 : 60%
		16~21일 : 80%
		22~30일 : 100%
		--%>
			<%-- <div class="ntitle_all">
				<p class="ntitle2">
					<span style="line-height:30px;float:right;">
						<c:if test="${item.mobileUseYn eq 'Y' }">
							<span class="ico3"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_03.gif" alt="모바일에서 재생가능" title="모바일에서 재생가능" class="subico"/></a></span>
						</c:if>
					</span>
				</p>
			</div> --%>
		
		<%-- <c:set var="complete" value="N"/>
		<c:if test="${item.subj ne '' and item.isgraduated eq 'Y'}">
			<c:set var="complete" value="Y"/>
		</c:if>
		<p class="nbtn">
			<c:if test="${item.subj ne '' and item.isgraduated eq 'Y'}">
				<input type="button" value="만족도설문" class="nbtn_on" onclick="fnCmdQestnrList('${item.subj }', '${item.subjnm }', '${item.year }', '${item.subjseq }'); return false;"/>
				<input type="button" value="수료증" class="nbtn_on" style="margin-left:5px;" onclick="fnCmdCtfhv('${item.subj}', '${item.year}', '${item.subjseq}', '${item.userid}', '1', '${grcode}'); return false;"/>
			</c:if>
		</p> --%>
	</div>
	</c:forEach>
</div>
		
<!-- 
<span class="linkers">
	<c:if test="${item.isnew eq 'Y' }">
		<span class="ico1"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_01.gif" alt="인기강좌" title="인기강좌" /></a></span>
	</c:if>
	
	<c:if test="${item.ishit eq 'Y' }">
		<span class="ico2"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_02.gif" alt="추천강좌" title="추천강좌" /></a></span>
	</c:if>
	
	<c:if test="${item.mobileUseYn eq 'Y' }">
		<span class="ico3"><a href="javascript:void(0);" onclick="return false;"><img src="/edu/images/edupro/icolink_03.gif" alt="모바일에서 재생가능" title="모바일에서 재생가능" /></a></span>
	</c:if>
</span>
 -->


<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
</c:if>


<script type="text/javascript">
//<![CDATA[
           
           
	$(document).ready(function(){
					
		
	});

	//설문 목록화면
	function fnCmdQestnrList(subj, subjnm, year, subjseq){
		
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
// 		$("#p_isonoff").val(isonoff);
// 		$("#p_scupperclass").val(scupperclass);
// 		$("#p_uclassnm").val(uclassnm);
		$("#p_year").val(year);
		$("#p_subjseq").val(subjseq);
		
		
		$("#p_tabselect").val("qestnr");
		
		$("#frm").attr({
					action:"/edu/onlineEdu/mylctrum/listQestnr.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+$("#pGubun1").val()+"&option1="+$("#pGubun2").val()+"&option5="+$("#pGubun3").val()+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
	//수료증 출력
	function fnCmdCtfhv(subj, year, subjSeq, userid, kind, subjgrcode){
		
		$("#p_subj").val(subj);
		$("#p_year").val(year);
		$("#p_subjseq").val(subjSeq);
		$("#p_userid").val(userid);
		$("#p_kind").val(kind);
		$("#p_grcode").val(subjgrcode);
		
		window.open("","openSuryoJeungPrint","scrollbars=no, width=830, height=800, scrollbars=yes, resizable=NO");
		
		$("#frm").attr({
					action:"/edu/onlineEdu/mylctrum/viewCtfhv.do?menuNo=<c:out value='${paramVO.menuNo }'/>&viewType=CONTBODY",
					method:"post",
					target:"openSuryoJeungPrint"
					});
		$("#frm").submit();
		
	}
	
	
	//과정 상세화면
	function fnCmdViewPage(type, subj, year, subjseq, isUse, possibleCnt){
		
		if(isUse != null && isUse == "N"){
			alert("폐지된 과정입니다!");
			return;
		}
		if(possibleCnt != null && possibleCnt == 0){
			alert("현재 개설되어 있지 않은 과정입니다!");
			return;
		}
		
		if(type == 'GOLD'){
			$("#frm").attr({
				action:"/edu/onlineEdu/openLecture/view.do?pSeq="+subj+"&menuNo=500085&pageIndex=1",
				method:"post",
				target:"_self"
				});
			$("#frm").submit();
		}else{
			$("#s_subj").val(subj);
			$("#s_year").val(year);
			$("#s_subjseq").val(subjseq);
			$("#p_subj").val(subj);
			$("#p_year").val(year);
			$("#p_subjseq").val(subjseq);
			$("#frm").attr({
						action:"/edu/onlineEdu/realm/view.do?menuNo=500027",
						method:"post",
						target:"_self"
						});
			$("#frm").submit();
		}
	}


//]]>
</script>
