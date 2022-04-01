
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" /> --%>


<!--content-->

<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/listQestnr.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
	<input type="hidden" name="p_subj" id="p_subj" value="${param.p_subj }" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" value="${param.p_subjnm }" />
	<input type="hidden" name="p_grcode" id="p_grcode" value="" />
	<input type="hidden" name="p_gyear" id="p_gyear" value="" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" value="${param.p_subjseq }" />
	
	<input type="hidden" name="p_sulpapernum" id="p_sulpapernum" value="" />
	<input type="hidden" name="p_sulpapernm" id="p_sulpapernm" value="" />
	<input type="hidden" name="p_sulstart" id="p_sulstart" value="" />
	<input type="hidden" name="p_sulend" id="p_sulend" value="" />
	<input type="hidden" name="p_sulnums" id="p_sulnums" value="" />
	
	<input type="hidden" name="s_subj" id="s_subj" value="" />
	<input type="hidden" name="s_grcode" id="s_grcode" value="" />
	<input type="hidden" name="p_listok" id="p_listok" value="" />
	
    <input type="hidden" name="p_answers" id="p_answers" value="" />
	<input type="hidden" name="p_reloadlist" id="p_reloadlist" value="" />
	<input type="hidden" name="p_isalways" id="p_isalways" value="<c:out value="${param.p_isalways }"/>" />
	
	<input type="hidden" name="p_searchtext" id="p_searchtext" value="${param.p_searchtext }" />
	<input type="hidden" name="p_orders" id="p_orders" value="<c:out value="${param.p_orders }"/>" />
	<input type="hidden" name="p_ordersnm" id="p_ordersnm" value="<c:out value="${param.p_ordersnm }"/>" />
	
	
	<input type="hidden" name="pGubun1" id="pGubun1" value="${param.pGubun1 }" />
	<input type="hidden" name="pGubun2" id="pGubun2" value="${param.pGubun2 }" />
	<input type="hidden" name="pGubun3" id="pGubun3" value="${param.pGubun3 }" />
	
	<!-- paging s -->
	<input type="hidden" name="gubun" id="gubun" value="<c:out value='${param.gubun }' />" />
	<input type="hidden" name="option1" id="option1" value="<c:out value='${param.option1 }' />" />
	<input type="hidden" name="option5" id="option5" value="<c:out value='${param.option5 }' />" />
	<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${param.pageIndex }' />" />
	<!-- paging e -->
	
	
	<!-- setp menu param s -->
	<input type="hidden" name="p_subj_step" id="p_subj_step" value="${param.p_subj_step }" />
	<input type="hidden" name="p_subjnm_step" id="p_subjnm_step" value="${param.p_subjnm_step }" />
	<input type="hidden" name="p_isonoff" id="p_isonoff" value="${param.p_isonoff }" />
	<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="${param.p_scupperclass }" />
	<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="${param.p_uclassnm }" />
	<input type="hidden" name="p_year" id="p_year" value="${param.p_year }" />
	<input type="hidden" name="p_subjseq_step" id="p_subjseq_step" value="${param.p_subjseq_step }" />
	<input type="hidden" name="p_tabselect" id="p_tabselect" value="<c:out value="${param.p_tabselect }"/>" />
	<!-- setp menu param e -->
	
</form>

<!-- step 영역 s -->
<jsp:include page="/WEB-INF/jsp/edu/onlineEdu/realm/eduStep.jsp" flush="true" />
<!-- step 영역 e -->


<div class="col-12 mt30 sub_board_body">
	<table class="board_type_0">
		<caption>설문지 목록(번호, 설문지, 응시진도율, 참여로 구분되는 표)</caption>
		<colgroup>
		<col style="width:10%;" />
		<col  />
		<col style="width:12%;" />
		<col style="width:12%;" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>설문지</th>
				<th scope="col">응시진도율</th>
				<th scope="col">참여</th>
			</tr>
		</thead>
		<tbody>
			<!-- 과정 설문 목록 -->
			<c:forEach items="${subjQestnrList }" var="item" varStatus="status">
				<tr>
					<td><c:out value="${status.count }" /></td>
					<td class="tal">[<c:out value="${item.subjnm }" />] <c:out value="${item.sulpapernm }" /> </td>
					<td><fmt:parseNumber integerOnly="true" value="${item.tstep }" type="number" /> / <fmt:parseNumber integerOnly="true" value="${myProgress }" type="number" /></td>
					<td>
						<c:choose>
							<c:when test="${item.eachcnt eq '1'}">
								<a href="javascript:void(0);" onclick="return false;" class="btn btn-xs btn-default"><span class="ico icoEdu"></span>완료</a>	
							</c:when>
							<c:when test="${item.eachcnt eq '0' and myProgress >= item.progress }">
								<c:choose>
									<c:when test="${item.dispyn eq 'Y' }">
										<a href="javascript:void(0);" onclick="fnCmdQestnr('${item.subjnm}', '${item.subj }', '${item.grcode }', '${item.year }', '${item.subjseq }', '${item.sulpapernum }', '${item.sulpapernm }', '', '', '${item.sulnums }'); return false;" class="btn btn-xs btn-default"><span class="ico icoEdu"></span>참여</a>
									</c:when>
									<c:otherwise>
										설문기간아님
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${item.eachcnt eq '0' and myProgress < item.progress }">
								<c:choose>
									<c:when test="${item.dispyn eq 'Y' }">
										진도미달
									</c:when>
									<c:otherwise>
										설문기간아님
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>정보없음</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			
			<!-- 일반 설문 목록 -->
			<c:forEach items="${contentsQestnrList }" var="item" varStatus="status">
				<tr>
					<td><c:out value="${status.count }" /></td>
					<td class="tal">[<c:out value="${item.subjnm }" />] <c:out value="${item.sulpapernm }" /> </td>
					<td><fmt:parseNumber integerOnly="true" value="${item.tstep }" type="number" /> / <fmt:parseNumber integerOnly="true" value="${myProgress }" type="number" /></td>
					<td>
						<c:choose>
							<c:when test="${item.contentsdata eq '0'}">
								<a href="javascript:void(0);" onclick="fnCmdQestnr('${item.subjnm}', '${item.subj }', '${item.grcode }', '${item.year }', '${item.subjseq }', '${item.sulpapernum }', '${item.sulpapernm }', '', '', '${item.sulnums }'); return false;" class="btn btn-xs btn-default"><span class="ico icoEdu"></span>참여</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:void(0);" onclick="return false;" class="btn btn-xs btn-default"><span class="ico icoEdu"></span>완료</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
			
			
			<c:if test="${empty contentsQestnrList && empty subjQestnrList }">
				<tr><td colspan="4" style="text-align: center">해당 목록이 없습니다</td></tr>
			</c:if>
			
		
		</tbody>
	</table>
	
	
	
		
	<div class="bdPoll" style="display: none;" id="qestnrArea">
		<h2></h2>
		<fieldset>
			<legend>설문지 입력양식</legend>
			<form id="frm2" name="frm2" action="" method="post" class="form-inline">
				<ol class="decimal" id="qestnrExamArea"></ol>
			</form>
		</fieldset>
		<div class="btnSet tac">
			<a href="javascript:void(0);" onclick="fnCmdQestnrInsert(); return false;" class="btn btn-whitegray"><span class="ico icoList"></span> 설문지 제출</a>
		</div>
	
	</div>

	
	
</div>


<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
//<![CDATA[
           
           
	$(document).ready(function(){
					
		
	});
	
	
	//설문 참여
	function fnCmdQestnr(p_subjnm, p_subj, p_grcode, p_gyear, p_subjseq, p_sulpapernum, p_sulpapernm, p_sulstart, p_sulend, p_sulnums){
		
		$("#p_subj").val(p_subj);
		$("#p_subjnm").val(p_subjnm);
		$("#p_grcode").val(p_grcode);
		$("#p_gyear").val(p_gyear);
		$("#p_subjseq").val(p_subjseq);
		$("#p_sulpapernum").val(p_sulpapernum);
		$("#p_sulpapernm").val(p_sulpapernm);
		$("#p_sulstart").val(p_sulstart);
		$("#p_sulend").val(p_sulend);
		$("#p_sulnums").val(p_sulnums);
		
		$("#s_subj").val(p_subj);
		$("#s_grcode").val(p_grcode);
		$("#p_listok").val("0");
		
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/mylctrum/listQestnar.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			data:{
				"p_subjnm":p_subjnm,
				"p_subj":"ALL",
				"p_grcode":"ALL",
				"p_gyear":p_gyear,
				"p_subjseq":p_subjseq,
				"p_sulpapernum":p_sulpapernum,
				"p_sulpapernm":p_sulpapernm,
				"p_sulstart":p_sulstart,
				"p_sulend":p_sulend,
				"p_sulnums":p_sulnums
				},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				
				if(data != null){
					$("#qestnrArea > h2").html("["+p_subjnm+"] "+p_sulpapernm+"");
					$("#qestnrExamArea").html(data.qestnarList);
					$("#qestnrArea").show();
				}
			},
			error:function(){
				alert("서버와 통신 실패");
			}
			
		});
	}
	
	
	//설문지 제출
	function fnCmdQestnrInsert(){
		
		var i=0;
		var b_name="";
		var c_name="";
		var c_value="";
		var b_type=""; 
		var result="";
		var temp=""; 
		var textarr ="";
		var answercnt=0;
		var replycnt =0;
		
		for(i = 0; i < document.frm2.length; i++) {
			c_name  = document.frm2.elements[i].name;
			c_value = document.frm2.elements[i].value;
			
			if (i == 0) {
				b_name=c_name;
				
			} else {
				if (eval(b_name.indexOf("|")) > 0) {
					answercnt++;
					if (b_type=="text" || temp !="") {
						replycnt++;
					}
					if (answercnt==1) {
						result = temp;
					} else {
						result = result + temp  ;
					}
					
					b_name = c_name;
					temp = "";	  
				} else if (c_name != b_name ) {
					answercnt++;
					if (b_type=="text" || temp !="") {
						replycnt++;
					}
					if (answercnt==1) {
						result = temp;
					} else {
						result = result + ","+ temp;
					}
					b_name = c_name;
					temp = "";
				}
			}
			
			if (document.frm2.elements[i].type=="checkbox") {
				b_type="checkbox";
				if (document.frm2.elements[i].checked==true) {
					temp = temp+c_value+':';
				}
			} else if (document.frm2.elements[i].type=="radio") {
				b_type="radio";
				
				if (document.frm2.elements[i].checked==true) {
					temp = c_value;
				}
			} else if (document.frm2.elements[i].type=="text"||document.frm2.elements[i].type=="textarea") {
				b_type="text";
				temp  = "";
				textarr = c_value.split(",");
				if (eval(c_name.indexOf("|"))>0){
					for(var j=0; j<textarr.length; j++) {
						temp =  temp + textarr[j];
					}
					if(temp.length>0){
						temp = ":" + temp + ":";
					}
				} else {
					for(var j=0; j<textarr.length; j++) {
						temp = temp + textarr[j];
					}
				}
			}
		}
		
		if (b_type=="text" || temp !="") {
			replycnt++;
		}
		
		answercnt++;
		
		if (answercnt==1) {
			result = temp;    
		} else if (eval(b_name.indexOf("|"))>0) {
			result = result + temp  ;  
		}else {
			result = result + ","+ temp;
		}
		
		if (replycnt < answercnt) {
			alert("응답하지 않은 설문이 있습니다.");
			return;
		}
		
		$("#p_answers").val(result);
		$("#p_reloadlist").val("true");
		
		var options = {
			url: "/edu/onlineEdu/mylctrum/insertQestnar.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			dataType: "json",
			type: "post",
			success : function(data) {
				
				alert(data.system_msg);
				$(location).attr("href", "/edu/onlineEdu/mylctrum/listQestnr.do?menuNo=<c:out value='${paramVO.menuNo }'/>&p_subj="+$("#p_subj").val()+"&p_year="+$("#p_year").val()+"&p_subjseq="+$("#p_subjseq").val()+"&p_isonoff="+$("#p_isonoff").val()+"&p_scupperclass="+$("#p_scupperclass").val()+"&p_uclassnm="+$("#p_uclassnm").val());
				
			},
			error:function (){
				alert("서버와 통신이 실패했습니다.\n잠시 후 다시 시도해주세요!");
				return false;
			}
		}
		$("#frm").ajaxSubmit(options);
		
	}
	
//]]>
</script>

