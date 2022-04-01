<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" /> --%>

	<style type="text/css">
/* 	.lnb_con{display: none} */
/* 	.sub_contents_wrap .sub_contents {padding-left: 0;} */
	</style>
<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/viewEdu.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">

	<input type="hidden" name="pGubun1" id="pGubun1" value="${param.pGubun1 }" />
	<input type="hidden" name="pGubun2" id="pGubun2" value="${param.pGubun2 }" />
	<input type="hidden" name="pGubun3" id="pGubun3" value="${param.pGubun3 }" />

	<input type="hidden" name="p_subj" id="p_subj" value="${param.p_subj }" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" value="${param.p_subjnm }" />
	<input type="hidden" name="p_isonoff" id="p_isonoff" value="${param.p_isonoff }" />
	<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="${param.p_scupperclass }" />
	<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="${param.p_uclassnm }" />
	<input type="hidden" name="p_year" id="p_year" value="${param.p_year }" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" value="${param.p_subjseq }" />

	<input type="hidden" name="p_searchtext" id="p_searchtext" value="${param.p_searchtext }" />
	<input type="hidden" name="p_orders" id="p_orders" value="<c:out value="${param.p_orders }"/>" />
	<input type="hidden" name="p_ordersnm" id="p_ordersnm" value="<c:out value="${param.p_ordersnm }"/>" />

	<input type="hidden" name="p_tabselect" id="p_tabselect" value="<c:out value="${param.p_tabselect }"/>" />

	<!-- paging s -->
	<input type="hidden" name="gubun" id="gubun" value="<c:out value='${param.gubun }' />" />
	<input type="hidden" name="option1" id="option1" value="<c:out value='${param.option1 }' />" />
	<input type="hidden" name="option5" id="option5" value="<c:out value='${param.option5 }' />" />
	<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${param.pageIndex }' />" />
	<!-- paging e -->


	<!-- 학습하기 파라미터 s -->
	<input type="hidden" name="s_year" id="s_year" value="${param.s_year }" />
	<input type="hidden" name="s_cpsubj" id="s_cpsubj" value="${param.s_cpsubj }" />
	<input type="hidden" name="s_cpsubjseq" id="s_cpsubjseq" value="${param.s_cpsubjseq }" />
	<input type="hidden" name="s_company" id="s_company" value="${param.s_company }" />
	<input type="hidden" name="s_contenttype" id="s_contenttype" value="${param.s_contenttype }" />
	<input type="hidden" name="s_subj" id="s_subj" value="${param.s_subj }" />
	<input type="hidden" name="s_subjseq" id="s_subjseq" value="${param.s_subjseq }" />
	<input type="hidden" name="s_lesson" id="s_lesson" value="${param.s_lesson }" />
	<!-- 학습하기 파라미터 e -->

</form>


<div class="col-12 mb30 alert big_box">
		<p class="fl alert_title" style="margin-bottom:0;">${view.subjnm }</p>
			<%-- <c:set var="arrayofedumans" value="${fn:split(view.edumans,'-')}"/>
			<c:forEach var="i" begin="0" end="${fn:length(arrayofedumans)-1 }" varStatus="status">
				- ${arrayofedumans[i] } <c:if test="${not status.last }"> <br /></c:if>
			</c:forEach> --%>
		<!-- step 영역 s -->
		<jsp:include page="/WEB-INF/jsp/edu/onlineEdu/realm/eduStep.jsp" flush="true" />
		<!-- step 영역 e -->
</div>


<!-- 차시목록 -->
<div class="col-12 lectListSet" style="min-height:auto;">
	<div class="lectMenu">
		<a href="javascript:void(0);" class="icon lectToggle eduR_lt45" onclick="return false;"></a>
	</div>
	

	<!-- Movie Player -->
	<div class="lectMovSet" style="background:#ffffff; width:100%; overflow:hidden; position:relative">
		<!-- 차시내용 -->
		<div id="lectListTemp" style="display:none">
			<jsp:include page="lectList.jsp"></jsp:include>
		</div>
		<!-- //차시내용 -->
		<div class="lectListBox eduR_lt45" style="position:absolute;top:0px;left:0px;background:#000;width:373px;height:100%;z-index:1000;">
			<iframe id="lectFrame" style="background:#000;width:100%;height:100%;" scrolling="yes" title="본 프레임은 강의 목차 정보를 제공합니다."></iframe>
		</div>
	
		<%-- <div style="width: ${view.prewidth }px; height:${view.preheight }px; margin: 0 auto; overflow:hidden; z-index:-10; " > --%>
		<div style="position:relative; padding-bottom:60%; height:0; margin: 0 auto; overflow:hidden; z-index:999; " >
			<iframe name="openstudy" 
				id="openstudy" 
				src="${p_url }" 
				width="${view.prewidth }" 
				height="${view.preheight }" 
				frameborder="0" 
				title="본 프레임은 동영상 강의 정보를 제공합니다." 
				scrolling="no" 
				allowfullscreen="true"
				style="position:absolute; top:0; left:0; width:100%; height:100%;">
			</iframe>
		</div>
	</div>
	<!-- Movie Player -->
	<script type="text/javascript">
		document.getElementById("lectFrame").contentWindow.document.write("<div class='col-12 sub_section'>"+$('#lectListTemp').html()+"</div>");//rsg20171010
		//lectFrame.document.write($('#lectListTemp').html());
		//$('#lectFrame').write($('#lectListTemp').html());
	</script>

	<!-- movDescTxt -->
	<div class="mt15 board_util_btn_con" style="max-width:1000px; margin-left:auto; margin-right:auto;">
		<a href="javascript:void(0);" class="btn_style_0 green openlecture_eye close_w eye_off" style="display:none; margin-right:0; margin-bottom:0;">
			자막닫기
		</a>
		<a href="javascript:void(0);" class="${(fn:length(fn:replace(lessonView.subtitle,' ','')) == 0 ? 'hidden':'') } btn_style_0 green openlecture_eye eye_on" style="margin-right:0; margin-bottom:0;">
			자막보기
		</a>
	</div>
	<!-- movDescTxt -->
	<div class="movDescTxt" tabindex="0" style="display: none; max-width:1000px; margin-left:auto; margin-right:auto; box-sizing:border-box;
	font-size: 14.5px; font-size: 1.45rem; line-height: 26px; line-height: 2.6rem; color: #313131; letter-spacing: -0.025em;
    padding-top:20px; padding-left:25px; padding-right:25px; padding-bottom:20px; border:2px solid #5ac9b7; text-align: left; max-height:300px; overflow-y: auto;
    -ms-user-select:none; -moz-user-select:-moz-none; -khtml-user-select:none; -webkit-user-select:none; user-select:none;">
		<% pageContext.setAttribute("crlf", "\n"); %>
		${fn:replace(lessonView.subtitle, crlf, "<br />")}
	</div>

</div>
<%--
	<!-- liveRe Solution -->
	<div class="lectLiveReSet">
		<!-- 라이브리 설치 코드 -->
		<div id="lv-container" data-id="kocca">
			<script type="text/javascript">
				(function(d, s) {
					var j, e = d.getElementsByTagName(s)[0];
					if (typeof LivereTower === 'function') {
						return;
					}
					j = d.createElement(s);
					j.src = 'https://cdn-city.livere.com/js/embed.dist.js';
					j.async = true;
					e.parentNode.insertBefore(j, e);
				})
				(document, 'script');
			</script>
			<noscript>라이브리 댓글 작성을 위해 JavaScript를 활성화 해주세요.</noscript>
		</div>
		<!-- 설치 코드 끝 -->
<!-- 		<img src="/edu/images/edupro/_030205_info.jpg" width="1080" height="851"  alt=""/> -->
	</div>
	<!-- //liveReSolution -->
--%>


<!-- consumer_seq = 1077 /  -->
<!-- 아카데미이야기 24725 : MTA3Ny8yNDcyNS8xNTA5  livere_seq = 24892  / 강좌 24892 : MTA3Ny8yNDg5Mi8xNTA5   livere_seq = 1509 -->
<!-- 
<div class="mb20 pt40" style="clear:left;">
	<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_1" value="[알려주세요]"  class="livere_choiceImg">
	<label for="livere_choiceBtn_1">과정질문</label>
	<input type="hidden" id="livere_description_1" value=""/>
	
	<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_2" value="[좋아요]"  class="livere_choiceImg">
	<label for="livere_choiceBtn_2">[칭찬]</label>
	<input type="hidden" id="livere_description_2" value=""/>
	
	<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_3" value="[이건 어때요?]"  class="livere_choiceImg">
	<label for="livere_choiceBtn_3">[의견]</label>
	<input type="hidden" id="livere_description_3" value=""/>
	
	<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_4" value="[불편해요]"  class="livere_choiceImg">
	<label for="livere_choiceBtn_4">[오류]</label>
	<input type="hidden" id="livere_description_4" value=""/>
	
	<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_5" value="[기타]"  class="livere_choiceImg">
	<label for="livere_choiceBtn_5">[기타]</label>
	<input type="hidden" id="livere_description_5" value=""/>
</div>
<div id="livereContainer">
<script type="text/javascript">
// 	jQuery.noConflict();

	var consumer_seq = "1077";
	var livere_seq = "24892";  //말머리 : 24892 , 기본 : 24725
	var smartlogin_seq = "1509";
	var title = "<c:out value="${view.subjnm }" escapeXml="false" />";
	var viewUrl = window.location.hostname + window.location.pathname;
	var param = "&p_subj=<c:out value="${param.p_subj}" />&p_year=<c:out value="${param.p_year}" />&p_subjseq=<c:out value="${param.p_subjseq}" />";
	var refer= viewUrl + "?menuNo=<c:out value="${param.menuNo}" />";
	var vote_image = true;
	refer = refer.replace("https://","");
	var site = "http://"+refer + param;
	$(':hidden').each(function(){
		if(null != $(this).attr('name') && $(this).val() != "" && $(this).attr('name').indexOf("s_") >= 0){
			site += "&"+$(this).attr('name')+"="+$(this).val();
		}
	});
	livereReply = new Livere( livere_seq , refer + param, title );
	livereReply.site = site;
	livereLib.start();
</script>
</div>
 -->



<!-- //차시목록 -->

<script type="text/javascript">
//<![CDATA[

	$(document).ready(function(){
		$('.lnb_wrap').addClass('dn');

		$(".lectListBox").show();
		setTimeout(function(){$(".lectListBox").animate({width: 'hide'});}, 3000);

		$('.lectToggle').click(function() {
			$(".lectListBox").slideToggleWidth();
		});

		jQuery.fn.extend({
		  slideRight: function() {
		    return this.each(function() {
		      jQuery(this).animate({width: 'show', height:'100%'});
		    });
		  },
		  slideLeft: function() {
		    return this.each(function() {
		      jQuery(this).animate({width: 'hide', height:'600'});
		    });
		  },
		  slideToggleWidth: function() {
		    return this.each(function() {
		      var el = jQuery(this);
		      if (el.css('display') == 'none') {
		        el.slideRight();
		        $('.lectToggle').attr({"title":"차시목록 열기"});
				//console.log("open");
		      } else {
		        el.slideLeft();
		        $('.lectToggle').attr({"title":"차시목록 닫기"});
				//console.log("close");
		      }
		    });
		  }
		});

		$(".eye_off").click(function (e) {
			$(this).hide();
			$(".movDescTxt").hide();
			$(".eye_on").show();
			$(".eye_on").focus();
		});
		$(".eye_on").click(function (e) {
			$(this).hide();
			$(".movDescTxt").show();
			$(".eye_off").show();
			$(".eye_off").focus();
		});
	});

	//과정 조회
	function fnCmdSearchList(gubun1, gubun2, gubun3, ordersnm, orders){

		$("#p_gubun1").val(gubun1);
		$("#p_gubun2").val(gubun2);
		$("#p_gubun3").val(gubun3);
		$("#p_ordersnm").val(ordersnm);

		if($("#p_orders").val() == "asc"){
			$("#p_orders").val("desc");
		}else{
			$("#p_orders").val("asc");
		}

		$("#p_searchtext").val($.trim($("#p_searchtext").val()));
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+gubun1+"&option1="+gubun2+"&option5="+gubun3,
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}


	//학습하기
	function fnCmdLrnAction(lesson){

		$("#s_lesson").val(lesson);
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/viewEdu.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+$("#pGubun1").val()+"&option1="+$("#pGubun2").val()+"&option5="+$("#pGubun3").val()+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
	//다음 차시 넘어가는 기능 추가 rsg20171011
	function receiveMessage(event){
		if (event.origin.indexOf("edulms.kocca.kr") == -1 )//LMS 도메인 확인
			return;
		//console.log( "receiveMessage" );
		var curLesson = $("#s_lesson").val();
		fnCmdLrnAction( pad(parseInt(curLesson) + 1, curLesson.length) ); //다음 차시로 이동
	}
	function pad(n, width) {//정수 자릿수 변경
		n = n + '';
		return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}
	window.addEventListener("message", receiveMessage, false);
//]]>
</script>

