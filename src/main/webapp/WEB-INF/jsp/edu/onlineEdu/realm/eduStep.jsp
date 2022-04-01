<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authentication var="user" property="principal"/>
<c:set value="${user != 'anonymousUser' ? user.username : '' }" var="userVrify" />
<c:set value="${userVrify }" var="idCeck" />

<c:set value="${not empty param.p_subj_step?param.p_subj_step:param.p_subj }" var="stepsubj" />
<c:set value="${not empty param.p_subjnm_step?p_subjnm_step:param.p_subjnm }" var="stepsubjnm" />
<c:set value="${not empty param.p_subjseq_step?p_subjseq_step:param.p_subjseq }" var="stepsubjseq" />

<div class="online_edu_alert_link_item">
	<ul>
		<li <c:if test="${param.p_tabselect eq 'view' or param.p_tabselect eq '' }">class="on"</c:if>><a href="javascript:void(0);" onclick="fnCmdViewPage('${stepsubj }', '${stepsubjnm }', '${param.p_isonoff }', '${param.p_scupperclass }', '${param.p_scupperclass }', '${param.p_year }', '${stepsubjseq }'); return false;">과정정보</a></li>
		
		<c:if test="${not empty idCeck  }">
		
			<c:if test="${param.pGubun1 ne 'Y0' }">
				<li <c:if test="${param.p_tabselect eq 'qestnr' }">class="on"</c:if>>
					<a href="javascript:void(0);" onclick="fnCmdQestnrList('${stepsubj }', '${stepsubjnm }', '${param.p_isonoff }', '${param.p_scupperclass }', '${param.p_scupperclass }', '${param.p_year }', '${stepsubjseq }'); return false;">설문</a>
				</li>
			</c:if>
			
			<%-- <li id="regsubjfavor">
				<c:choose>
					<c:when test="${view.favorYn eq 'N' }">
						<a href="javascript:void(0);" onclick="fnCmdRegSubjFavor('01', '${param.p_subj }', 'register'); return false;"><span><span class="ico ico03"></span>찜하기</span></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:void(0);" onclick="fnCmdRegSubjFavor('01', '${param.p_subj }', 'cancel'); return false;"><span><span class="ico ico03"></span>찜취소</span></a>
					</c:otherwise>
				</c:choose>
			</li> --%>
			
			<c:if test="${param.pGubun1 ne 'Y0' }">
				<li <c:if test="${param.p_tabselect eq 'listData' }">class="on"</c:if>><a href="javascript:void(0);" onclick="fnCmdDataList(); return false;">자료실</a></li>
			</c:if>
			
		</c:if>
		

		<li class="mr0"><a href="javascript:void(0);" onclick="fnCmdSubjList('${paramVO.menuNo }', '${param.pGubun1 }', '${param.pGubun2 }', '${param.pGubun3 }'); return false;">목록가기</a></li>
	</ul>
</div>

<c:set var="subTitle" value=""/>
<c:set var="removeTitle" value="N"/>
<c:if test="${param.p_tabselect eq 'view' or param.p_tabselect eq '' }">
	<c:set var="subTitle" value="과정정보 | "/>
</c:if>
<c:if test="${param.p_tabselect eq 'qestnr' }">
	<c:set var="subTitle" value="설문(목록) | "/>
	<c:set var="removeTitle" value="Y"/>
</c:if>
<c:if test="${param.p_tabselect eq 'listData' }">
	<c:set var="subTitle" value="자료실(목록) | "/>
	<c:set var="removeTitle" value="Y"/>
</c:if>

<script type="text/javascript">
//<![CDATA[
    if('<c:out value="${removeTitle}" />' == 'Y'){
	    $('title').html( $('title').html().replace('(목록)', '') );
	    $('title').html( $('title').html().replace(' |', '<') );
    }
    $('title').html( '<c:out value="${subTitle}"/>' + $('title').html() );
           
	//과정 상세화면
	function fnCmdViewPage(subj, subjnm, isonoff, scupperclass, uclassnm, year, subjseq){
		
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_isonoff").val(isonoff);
		$("#p_scupperclass").val(scupperclass);
		$("#p_uclassnm").val(uclassnm);
		$("#p_year").val(year);
		$("#p_subjseq").val(subjseq);
		
		$("#p_tabselect").val("view");
		
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/view.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+$("#pGubun1").val()+"&option1="+$("#pGubun2").val()+"&option5="+$("#pGubun3").val()+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
	//과정 조회
	function fnCmdSubjList(menuNo, gubun1, gubun2, gubun3){
		
		var menu = "";
		if(menuNo == "500029"){
			menu = "occp";
		}else{
			menu = "realm";
		}
		
		$("#pGubun1").val(gubun1);
		$("#pGubun2").val(gubun2);
		$("#pGubun3").val(gubun3);
		$("#frm").attr({
					action:"/edu/onlineEdu/"+menu+"/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+gubun1+"&option1="+gubun2+"&option5="+gubun3+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
           
	//설문 목록화면
	function fnCmdQestnrList(subj, subjnm, isonoff, scupperclass, uclassnm, year, subjseq){
		
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_isonoff").val(isonoff);
		$("#p_scupperclass").val(scupperclass);
		$("#p_uclassnm").val(uclassnm);
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
	
	//찜하기, 취소
	function fnCmdRegSubjFavor(classtype, subj, jobtype){
	
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/mylctrum/regSubjFavorInsert.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			data:{
				"p_classtype":classtype,
				"p_subj":subj,
				"p_jobtype":jobtype
				},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				
				if(data.result == "1"){
					
					if(jobtype == "register"){
						$("#regsubjfavor").html("<a href=\"#\" onclick=\"fnCmdRegSubjFavor('01', '"+subj+"', 'cancel'); return false;\"><span><span class=\"ico ico03\"></span>찜취소</span></a>");
						
					}else if(jobtype == "cancel"){
						$("#regsubjfavor").html("<a href=\"#\" onclick=\"fnCmdRegSubjFavor('01', '"+subj+"', 'register'); return false;\"><span><span class=\"ico ico03\"></span>찜하기</span></a>");
					}
					
					alert(data.system_msg);
					
				}else{
					alert(data.system_msg);
					return;
				}
				
			},
			error:function(){
				alert("서버와 통신 실패");
			}
			
		});
		
	}
	
	
	//과정 자료실 목록화면
	function fnCmdDataList(){
		
		$("#p_tabselect").val("listData");
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/listData.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+$("#pGubun1").val()+"&option1="+$("#pGubun2").val()+"&option5="+$("#pGubun3").val()+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
		
	}
           
           
           
//]]>
</script>