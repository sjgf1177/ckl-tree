<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>

<div class="tab_style_1_con"> 
	<ul class="tab_style_1 three_tab">
		<li class="active">
			<a href="/edu/onlineEdu/themeLecture/list.do?menuNo=500204" title="현재탭">
				<span>테마과정</span>
			</a>
		</li>
		<li>
			<a href="/edu/bbs/B0000048/list.do?menuNo=500205">
				<span>이벤트</span>
			</a>
		</li>
		<li>
			<a href="/edu/bbs/B0000023/list.do?menuNo=500206">
				<span>콘텐츠이야기</span>
			</a>
		</li>
	</ul>
</div>

<!--content-->
<div class="col-12 mb37 alert big_box">
	<p class="alert_title" style="margin-bottom:0;">
	${result.title }
	<c:if test="${result.posterImg ne null && result.posterImg ne ''}">
		<img alt="${result.title }" src="${result.posterImg}" />
	</c:if>
	</p>
</div>
<div class="col-12 mb17">
    <ul class="list_style_10 font_light">
        <li>현재 <span class="point0">${fn:length(themeSubjList) }</span>개의 과정이 운영되고 있습니다. 희망하는 과정을 체크 후 신청버튼을 클릭하세요.</li>
        <li>수료증은 <span class="point0">“나의 강의실”</span>에서 확인 및 출력이 가능합니다.(정규과정만 수료증 제공)
  			<div class="small_text_box">※ 열린강좌인 경우 수료증이 제공되지 않습니다.</div></li>
    </ul>
</div>

<div class="col-12 board_util_btn_con mb40">
	<div class="tc">
		<a href="javascript:void(0)" class="btn_style_0 img_left edit online_edu blue" id="studySubj">
			학습하기
		</a>
		<a href="/edu/onlineEdu/themeLecture/list.do?${pageQueryString }&amp;pLectureCls=${param.pLectureCls }" class="btn_style_0 gray online_edu">
			목록가기	
		</a>
	</div>
</div>

<div class="col-12 sub_board_body">
	<div class="col-12 theme_process_list_wrap">
		<!-- 반복 -->
		<c:forEach items="${themeSubjList }" var="list" varStatus="status" >
	    <div class="col-12 theme_process_list_con">
	        <div class="check_style_0_con">
	            <input type="checkbox" class="check_style_0" name="checkname" id="checkid_${list.courseSeq }" value="${list.courseSeq }" checked="true">
	            <label for="checkid_${list.courseSeq }"><span class="hidden">${list.courseName}_체크박스</span></label>
	        </div>
	        <div class="theme_process_list">
	            <div class="img_box">
	                <img src="${list.imgfile}" alt="${list.courseName }">
	            </div>
	            <div class="text_box">
		            <div class="online_edu_card_icon_con">
						<span class="online_edu_card_icon">
							<img src="/edu/images/bm/online_pc_icon.png" alt="pc에서 재생가능" title="pc에서 재생가능">
						</span>
						<c:if test="${list.mobileUseYn eq 'Y' }">
						<span class="online_edu_card_icon">
							<img src="/edu/images/bm/online_mobile_icon.png" alt="모바일에서 재생가능" title="모바일에서 재생가능">
						</span>
						</c:if>
						<h5>${list.courseName }</h5>
					</div>
	                <p class="theme_process_list_desc">
	                	${list.intro }
	                </p>
	                <div class="theme_process_list_more_btn_con">
						<a href="javascript:void(0)"  onclick="javascript:fnCmdViewPage('${list.type }', '${list.courseId }', '${list.courseName }', '${list.isonoff }', '${list.scupperclass }', '${list.uclassnm }', '${list.year }', '${list.subjseq }'); return false;" class="btn_style_0">
							상세보기
						</a>
					</div>
	            </div>
	        </div>
	    </div>
	    </c:forEach>
		<!-- //반복 -->
	</div>
</div>
<!--//content-->
<form id="frm" name="frm" method="post" class="form-inline">
	<input type="hidden" name="p_subj" id="p_subj" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" />
	<input type="hidden" name="p_year" id="p_year" value="" />
	<input type="hidden" name="s_subj" id="s_subj" value="" />
	<input type="hidden" name="s_year" id="s_year" value="" />
	<input type="hidden" name="s_subjseq" id="s_subjseq" value="" />
</form>
<script type="text/javascript">
//과정 상세화면
function fnCmdViewPage(type, subj, subjnm, isonoff, scupperclass, uclassnm, year, subjseq){
	
	var url = "";
	if(type == "S"){
		$("#s_subj").val(subj);
		$("#s_year").val(year);
		$("#s_subjseq").val(subjseq);
		$("#p_subj").val(subj);
		$("#p_year").val(year);
		$("#p_subjseq").val(subjseq);
		$("#p_subjnm").val(subjnm);
		url = "/edu/onlineEdu/realm/view.do?menuNo=500027";
	}else{
		url = "/edu/onlineEdu/openLecture/view.do?pSeq="+subj+"&menuNo=500085&pageIndex=1";
	}
	
	$("#frm").attr({
				action:url,
				method:"post",
				target:"_self"
				});
	$("#frm").submit();
}
$(document).ready(function(){
	$("#studySubj").click(function(){
		var check_array = Array();
		var check_cnt = 0;
		var chkbox = $('input[name="checkname"]');
		
		for(i=0; i<chkbox.length; i++){
			if(chkbox[i].checked == true){
				check_array[check_cnt] 		= chkbox[i].value;
				check_cnt++;
			}
		}
		
		if(check_cnt == 0){
			alert("학습할 강의를 선택해 주세요.");
			return;
		}
		
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/themeLecture/studySubjReg.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			data:{"p_course_id":JSON.stringify(check_array)},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				var result = data.result;
				if(result.sReturnCode == 'needLogin'){
					alert("로그인 후 사용해 주세요.");
					return;
				}else{
					var msg = "";
// 					msg += "정규강좌 " + result.sReturnSubjCnt + "건\n"
// 					msg += "열린강좌 " + result.sReturnGoldClassCnt + "건\n"
					msg += "신청이 되었습니다.";
					alert(msg);
					location.replace("/edu/onlineEdu/mylctrum/list.do?menuNo=500061");
					return;
				}
				
			},
			error:function(){
				alert("서버와 통신 실패");
			}
			
		});
	});
	
});
</script>
