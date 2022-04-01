
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>

<sec:authentication var="user" property="credentials"/>
<%-- <c:set value="${user != 'anonymousUser' ? user : '' }" var="userVrify" /> --%>
<c:set value="${user }" var="userflag" />
<style type="text/css">
/* 	.lnb_con{display: none} */
/* 	.sub_contents_wrap .sub_contents {padding-left: 0;} */
</style>
<script type="text/javascript">
//<![CDATA[
document.title = "<c:out value="${result.lecnm }" escapeXml="false" /> < " +document.title;

$(document).ready(function(){

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
	
	// 이벤트 페이지를 통해 접근 & 로그인안한 사용자일경우
	if('${event}' == 'Y' && '${userVO.userIdx}' == 0){
		checkEvent();
	}
});

function fnMsg(msg){
	if('${userVO.userId}' == 'kkj9699'){
		alert(msg);
	}
}

function checkEvent(){
	if(confirm("이벤트 참여를 위해 로그인 하시겠습니까?")){
		
		var viewUrl = window.location.hostname + window.location.pathname;
		viewUrl = viewUrl.replace("https://","");
		var param = "?menuNo=<c:out value="${param.menuNo}" />;amp;pSeq=<c:out value="${param.pSeq}" />";
		var redirectUrl = "http://"+viewUrl + param;
		
		var loginForm = "";
		loginForm += "<form id='eventLoginForm' name='eventLoginForm'>";
		loginForm += "    <input type='hidden' name='menuNo' value='500077'/>";
		loginForm += "    <input type='hidden' name='redirectUrl' value='"+redirectUrl+"'/>";
		loginForm += "</form>";
		$('body').append(loginForm);
		$('#eventLoginForm').attr({
			action : '/edu/member/forLogin.do',
			target : '_self'
		}).submit();
	}
}


/**
 * 임베드 유형의 열린강좌 열기
 */

function returnFLV(str){
     returnVal = document.getElementById("oFlashVar").value;
     return returnVal;
}


function fnLoadSWF(file, width, height, trans, flashVars){
    // file = "http://edu.kocca.or.kr" + file;

    var tagObj = "";
    tagObj += "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='" + width + "' height='" + height + "' id='objOpenClass' align='middle'>\n";
    tagObj += "<param name='allowScriptAccess' value='always' />\n";
    tagObj += "<param name='movie' value='" + file + "' />\n";
    tagObj += "<param name='menu' value='false' />\n";
    tagObj += "<param name='flashvars' value='" + flashVars + "'>\n";
    if (trans == true){
        tagObj += "<param name='wmode' value='transparent' />\n";
    }
    tagObj += "<embed src='" + file + "' quality='high' bgcolor='#ffffff' width='" + width + "' height='" + height + "' name='embOpenClass' align='middle' wmode='transparent' allowScriptAccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />\n";
    tagObj += "</object>";

    $("#vodArea").html( tagObj );
    //document.getElementById("vodArea").innerHTML = tagObj;


}

function fnLoadMP4(creduGateUrl, width, height){
	$.ajax({
	        type : "post"
	    ,   url : "/edu/onlineEdu/openLecture/creduReturnXml.json?menuNo=<c:out value='${paramVO.menuNo }'/>"
	    ,   dataType : "JSON"
	    ,   data : {
	    	url : creduGateUrl,
	    	p_process : "creduSubj" 
	    }
	    ,   success : function(ajaxData) {
		    	var tagObj = "";
		        tagObj  = '<OBJECT CLASSID="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" width="'+width+'" height="'+height+'" id="objContents" align="middle">';
		    	tagObj += '	<PARAM name="autoStart" value="true">';
		    	tagObj += '	<PARAM name="MENU" value="false">';
		    	tagObj += '	<PARAM name="windowlessVideo" value="1">';
		    	tagObj += '	<PARAM name="URL" value="'+ ajaxData.result +'">';
		    	tagObj += '</OBJECT>';
	
		        $("#vodArea").html( tagObj );
	    	}
	    ,   error :  function(arg1, arg2) {
	            alert("오류가 발생하여 플레이 할 수 없습니다.");
	        }
	});
	
}

/**
 * 임베드 유형의 열린강좌 닫기
 */
function fnCloseViewWin() {
    $("#vodArea").html( "" );
    $(".divPopupMask, #divPopup, #vodArea, .vodWinCloseBtn").hide();
    $(".play_movie > a").focus();
}

/**
 * 열린강좌 보기
 * @param seq 열린강좌 일련번호
 * @param vodPath 열린강좌 실제 동영상 경로
 * @param width 열린강좌 동영상 넓이
 * @param height 열린강좌 동영상 높이
 * @param lectureType 강좌 유형 (P: 팝업(값이 없으면 popup), E: 임베드)
 */
function fnViewOpenClass(seq, vodPath, width, height, lectureType, vodUrl) {
    lectureType = (lectureType == "") ? "P" : lectureType;

	viewCount(seq);

	if ( lectureType == "P" ) {
		 fnViewOpenClassByPopup(vodUrl,width,height);
		 //fnViewOpenClassByPopup(vodUrl,1080,630);
	}
	else {
		if(vodPath.indexOf("ksp.credu.com") > 0){
// 			$.get(vodUrl,function( data ) {
				$("#vodAreaHtml").html( "<div bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\"><div id=\"vodArea\"></div></div>" );
				fnLoadMP4(vodPath, 1080, 630);
// 			},"html");
		}else{
			$.get(vodUrl,function( data ) {
				$("#vodAreaHtml").html( "<div "+data.substr(data.indexOf("<body")+6, data.indexOf("</body>") -7 ) + "</div>" );
				var url = $("#oFlashVar").val();
				fnLoadSWF(vodPath, 1080, 630, true, "vodURL=" + url);
			},"html");
		}
	}
}



/**
 * 팝업 유형의 열린강좌 보기.
 * 기존 방식을 이용하므로 별도의 조회수 갱신 함수를 호출할 필요가 없음.
 * @param seq 열린강좌 일련번호
 * @param w 콘텐츠 넓이
 * @param h 콘텐츠 높이
 */
function fnViewOpenClassByPopup(vodUrl,w,h) {

    if (w.length > 0) {
        window.open(vodUrl, "ViewVod", "top=0, left=0, width="+w+", height="+h+", status=no, resizable=no");

    } else {
        window.open(vodUrl, "ViewVod", "top=0, left=0, width=1008, height=570, status=no, resizable=no");
    }
	//window.open(vodUrl, "ViewVod", "top=0, left=0, width=1008, height=570, status=no, resizable=no");

	/*
    var formObj = document.openClassForm;
    formObj.action = "/servlet/controller.infomation.GoldClassHomePageServlet";
    formObj.p_process.value = "popUpVod";
    formObj.p_seq.value = seq;
    formObj.target = "ViewVod";
    formObj.submit();
    formObj.target = "_self";
    */
}

/**
 * 외부 링크를 타고 들어온 경우 해당 열린 강좌 정보를 조회하여 바로 보여줌.
 */
function fnViewOpenClassDirect(seq) {

    $.ajax({
            type : "get"
        ,   url : "/servlet/controller.infomation.GoldClassHomePageServlet"
        ,   dataType : "xml"
        ,   data : "p_process=getOpenClassInfo&seq=" + seq
        ,   success : function (xml) {
                var xmlDoc = $(xml).find("ROOT");
                var vodPath = $(xmlDoc).find("d_vod_path").text();
                var vodUrl = $(xmlDoc).find("d_vodurl").text();
                var width = $(xmlDoc).find("d_width_s").text();
                var height = $(xmlDoc).find("d_height_s").text();
                var lectureType = $(xmlDoc).find("d_lecture_type").text();

                fnViewOpenClass(seq, vodPath, width, height, lectureType, vodUrl);

            }
        // ,   complete : fnOnComplete
        ,   error :  fnOnError
    });
}

function viewCount(seq){
	
	var event = "N";
	// 로그인안한 사용자일경우 이벤트 체크 추가
	if('${userVO.userIdx}' > 0){
		event = "Y";
	}
	
	$.ajax({
		type : "post",
		url:"/edu/onlineEdu/openLecture/popUpVod.json",
		data : {
			menuNo : '<c:out value='${param.menuNo}' />',
			seq : seq,
			event : event,
			userid : userId
		},
		success:function(data){
			if(data.resultCode == 'success'){
				vodFlagMessage = "OK";
			}else{
				vodFlagMessage = "데이터 통신에 실패하였습니다";
			}

		},error:function(xhr,status,error){
			alert('에러' + xhr.status);
		}
	});

}


/*
function fnOnSuccess(data) {
}
function fnOnComplete(data) {
}
*/

var userId = "<c:out value="${userVO.userId ne 'anonymousUser' ? userVO.userId : '' }" />";
/**
 * 찜하기
 */

//찜하기, 취소
	function fnCmdRegSubjFavor(classtype, subj, jobtype){
		if(userId !=""){
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/openLecture/regSubjFavorInsert.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			data:{
				"p_classtype":classtype,
				"p_subj":subj,
				"p_jobtype":jobtype,
				"userId":userId
				},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){

				if(data.result == "1"){

					if(jobtype == "register"){
						$(".myBookmark ").html("<a href=\"#\" onclick=\"fnCmdRegSubjFavor('01', '"+subj+"', 'cancel'); return false;\"><span><span class=\"ico ico03\"></span>찜취소</span></a>");

					}else if(jobtype == "cancel"){
						$(".myBookmark ").html("<a href=\"#\" onclick=\"fnCmdRegSubjFavor('01', '"+subj+"', 'register'); return false;\"><span><span class=\"ico ico03\"></span>찜하기</span></a>");
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
		}else{
			alert("로그인후 사용하실수 있습니다.");
		}
	}

//]]>
</script>


<%-- <div class="stepInline step">
	<ul>
	<li><a href="#self"><span><span class="ico ico01"></span>강좌정보</span></a></li>
		<li class="myBookmark" >
			<c:choose>
				<c:when test="${result.favorYn eq 'N' }">
						<a href="javascript:void(0);" onclick="fnCmdRegSubjFavor('02','<c:out value="${result.seq }" />','register')"><span><span class="ico ico03"></span>찜하기</span></a>
				</c:when>
				<c:otherwise>
						<a href="javascript:void(0);" onclick="fnCmdRegSubjFavor('02','<c:out value="${result.seq }" />','cancel')"><span><span class="ico ico03"></span>찜취소</span></a>
				</c:otherwise>
			</c:choose>
		</li>

	<li><a href="#self"><span><span class="ico ico04"></span>공유하기</span></a></li>
	</ul>
</div> --%>

<div class="alert big_box type_1" style="overflow:hidden;">
	<p class="fl alert_title" style="margin-bottom:0;">
		<c:out value="${result.lecnm }" escapeXml="false" />
	</p>
	<div class="online_edu_alert_link_item">
		<ul>
			<li>
				<a href="/edu/onlineEdu/realm/list.do?p_ordersnm=ldate&p_orders=desc&menuNo=500027">정규과정 목록으로</a>
			</li>
			<li>
				<c:choose>
				<c:when test="${not empty param.myOpenLecture and param.myOpenLecture eq 'Y' }">
					<c:url value="/edu/onlineEdu/openLecture/myOpenLetureList.do?${pageQueryString }&amp;pLectureCls=${param.pLectureCls }" var="listUrl" />
				</c:when>
				<c:otherwise>
					<c:url value="/edu/onlineEdu/openLecture/list.do?${pageQueryString }&amp;pLectureCls=${param.pLectureCls }" var="listUrl" />
				</c:otherwise>
				</c:choose>
				<a href="${listUrl }" escapeXml="false">
					열린과정 목록으로
				</a>
			</li>
		</ul>
	</div>
	<!-- <dl class="point fl cel pb40 tac">
		<dt class="mb10 fs3"><c:out value="${result.lecnm }" escapeXml="false" /></dt>
		<dd  class="fs2"><c:out value="${result.tutornm }" /> </dd>
	</dl>-->
</div>
<!-- Movie Player  width: 1080px;height: 630;기본 사이즈 -->
<div class="mt20 lectMovSet" id="vodArea">
	<a href="javascript:fnViewOpenClass('<c:out value="${param.pSeq }"/>','<c:out value="${result.vodPath }" />','<c:out value="${result.widthS }"/>','<c:out value="${result.heightS }"/>','<c:out value="${result.lectureType }"/>','<c:out value="${result.vodurl }" />');" > <!-- rsg20170908 onclick="return confirm('강의를 시청하시겠습니까?');" -->
	<img src="<c:out value="${result.vodimg }"/>" style="width: 1080px;height: 664;"   alt="강좌보기"/>
	<span class="maskPlay"></span>
	</a>
</div>
<!-- Movie Player -->
<div id="vodAreaHtml" style="display:none;"></div>
<div class="mt15 board_util_btn_con" style="max-width:1080px; margin-left:auto; margin-right:auto;">
	<a href="javascript:void(0);" class="btn_style_0 green openlecture_eye close_w eye_off" style="display:none; margin-right:0; margin-bottom:0;">
		자막닫기
	</a>
	<a href="javascript:void(0);" class="${(fn:length(fn:replace(result.subtitle,' ','')) == 0 ? 'hidden':'') } btn_style_0 green openlecture_eye eye_on" style="margin-right:0; margin-bottom:0;"  >
		자막보기
	</a>
</div>
<div class="movDescTxt" tabindex="0" style="display: none; max-width:1080px; margin-left:auto; margin-right:auto; box-sizing:border-box;
	font-size: 14.5px; font-size: 1.45rem; line-height: 26px; line-height: 2.6rem; color: #313131; letter-spacing: -0.025em;
    padding-top:20px; padding-left:25px; padding-right:25px; padding-bottom:20px; border:2px solid #5ac9b7; text-align: left; max-height:300px; overflow-y: auto;
    -ms-user-select:none; -moz-user-select:-moz-none; -khtml-user-select:none; -webkit-user-select:none; user-select:none;">
	<% pageContext.setAttribute("crlf", "\n"); %>
	${fn:replace(result.subtitle, crlf, "<br />")}
</div>

<%-- <h2><c:out value="${result.lecnm }" escapeXml="false" /></h2> --%>

<div class="openlecture_text_box">
	<div class="openlecture_text_box_header">
		01. 이 강좌에 대해서
	</div>
	<div class="openlecture_text_box_contents">
		<c:out value="${result.intro }"/>
	</div>
</div>
<div class="openlecture_text_box">
	<div class="openlecture_text_box_header">
		02. 강사 소개
	</div>
	<div class="openlecture_text_box_contents">
		<c:out value="${result.tutornm }"/>
		<c:if test="${fn:length(result.tutornm) == 0 }">강사에 대한 정보가 업습니다.</c:if>	
	</div>
</div>

<div class="mb90 openlecture_text_box">
	<div class="openlecture_text_box_header">
		03. 강사 이력
	</div>
	<div class="openlecture_text_box_contents">
		<% pageContext.setAttribute("crlf","\r\n"); %>
		${fn:replace(fn:replace(fn:escapeXml(result.tutorcareer), crlf, '<br/>') , ' ', '&nbsp;')}
		${fn:replace(fn:replace(fn:escapeXml(result.tutorauthor), crlf, '<br/>') , ' ', '&nbsp;')}
	</div>
</div>
<%--
<!-- liveRe Solution -->
	<div class="lectLiveReSet">
		<!-- 라이브리 설치 코드 -->
		<div id="lv-container" data-id="kocca">
			<script type="text/javascript">
			var viewUrl = window.location.protocol+"//"+window.location.hostname + window.location.pathname;
			var refer= viewUrl + "?" + "pSeq=<c:out value="${param.pSeq}" />&menuNo=<c:out value="${param.menuNo}" />";


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


<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_1" value="[질문하기]"  class="livere_choiceImg">
<label for="livere_choiceBtn_1" class="livere_choiceBtn">[질문하기]</label>
<input type="hidden" id="livere_description_1" value=""/>
<input type="radio" name="livere_ImgCheckBtn" id="livere_choiceBtn_2" value="[건의하기]"  class="livere_choiceImg">
<label for="livere_choiceBtn_2" class="livere_choiceBtn">[건의하기]</label>
<input type="hidden" id="livere_description_2" value=""/>

<!-- 24725 MTA3Ny8zMzEwMS85NTIw / 24892 MTA3Ny8zMzEwMi85NTIw -->
<!-- 
<div id="livereContainer">
<script type="text/javascript">
	//jQuery.noConflict();

	var consumer_seq = "1077";
	var livere_seq = "24892";  //말머리 : 24892 , 기본 : 24725
	var smartlogin_seq = "1509";
	var title = "<c:out value="${result.lecnm }" escapeXml="false" />";
	var viewUrl = window.location.hostname + window.location.pathname;
	var refer= viewUrl + "?" + "pSeq=<c:out value="${param.pSeq}" />&menuNo=<c:out value="${param.menuNo}" />";
	var vote_image = true;
	refer = refer.replace("http://","");
	livereReply = new Livere( livere_seq , refer , title );
	livereLib.start();
</script>
</div>
 -->
</div>

<p class="online_edu_card_view_title">
	연계 과정
</p>

<c:if test="${not empty nextList }">
<div class="photoGallery2 photoLine1" style="border-top:none; border-bottom:none; padding-top:0; padding-bottom:0;">
	
	<div class="col-12 over-hidden calc_wrap20">
	<!-- calc_wrap20 있는 div에 style로 height값 유동적으로 부여 하면 됨(더보기 컨트롤) -->
		<c:forEach items="${nextList }" var="nextResult">
			<div class="col-12 col-md-3 online_edu_card_wrap">
				<div class="col-12 online_edu_card_list">
					<c:url var="url" value="/edu/onlineEdu/openLecture/view.do?pSeq=${nextResult.seq }&amp;${pageQueryString }&amp;pageIndex=${param.pageIndex }&amp;pageIndex2=&amp;pLectureCls=${param.pLectureCls }"/>
					<c:choose>
						<c:when test="${nextResult.type == 'S'}">
							<a class="show-block" href="/edu/onlineEdu/realm/view.do?p_gubun=&amp;p_subj=${nextResult.courseId }&amp;p_subjseq=${nextResult.subjseq }&amp;p_year=${nextResult.year }&amp;menuNo=500027">
						</c:when>
						<c:otherwise>
							<a class="show-block" href="javascript:void(0);" onclick="fnCmdViewPage('${nextResult.type }', '${nextResult.courseId }', '${nextResult.courseName }', '${nextResult.isonoff }', '${nextResult.scupperclass }', '${nextResult.uclassnm }', '${nextResult.year }', '${nextResult.subjseq }'); return false;">
						</c:otherwise>
					</c:choose>
						<div class="img_box">
							<img alt="<c:out value="${not empty nextResult.courseName ? nextResult.courseName : '다음강좌' }" />" src='<c:out value="${nextResult.imgfile }" />'  />
							<!-- <img src="/edu/images/bm/kofac_card_img_001.jpg" style="width:100%"> -->
						</div>
						<div class="text_box">
							<div class="online_edu_card_icon_con">
								<span class="online_edu_card_icon">
									<img src="/edu/images/bm/online_pc_icon.png" alt="pc에서 재생가능" title="pc에서 재생가능">
								</span>
								<c:if test="${item3.mobileUseYn eq 'Y' }">
									<span class="online_edu_card_icon">
										<img src="/edu/images/bm/online_mobile_icon.png" alt="모바일에서 재생가능" title="모바일에서 재생가능" />
									</span>
								</c:if>
							</div>
							<div class="online_edu_card_title">
								<h4><%-- [${nextResult.type }] --%><c:out value="${nextResult.courseName }" escapeXml="false" /></h4>
							</div>
							<div class="online_edu_desc">
								<c:out value="${nextResult.tutornm }" />
								<c:out value="${nextResult.intro }" />
							</div>
						</div>
					</a>
					<%-- <span class="linkers">
						<c:if test="${item3.isnew eq 'Y' }">
							<span class="ico1"><img src="/edu/images/edupro/icolink_01.gif" alt="인기강좌" title="인기강좌" /></span>
						</c:if>
						
						<c:if test="${item3.ishit eq 'Y' }">
							<span class="ico2"><img src="/edu/images/edupro/icolink_02.gif" alt="추천강좌" title="추천강좌" /></span>
						</c:if>
						
						<c:if test="${item3.mobileUseYn eq 'Y' }">
							<span class="ico3"><img src="/edu/images/edupro/icolink_03.gif" alt="모바일에서 재생가능" title="모바일에서 재생가능" /></span>
						</c:if>
					</span> --%>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<div class="online_edu_card_view_btn">
	<div class="online_edu_card_view_btn_inner">
		<div class="more_btn_img">
			<img src="/edu/images/bm/online_edu_card_view_more_btn.png" alt="더보기">
		</div>
		<div class="more_btn_text">
			더보기
		</div>
	</div>
</div>
<%-- <h3>연계과정</h3>

<div class="photoGallery2 photoLine1">
  <ul>
            <li>
             	<c:url var="url" value="/edu/onlineEdu/openLecture/view.do?pSeq=${nextResult.seq }&amp;${pageQueryString }&amp;pageIndex=${param.pageIndex }&amp;pageIndex2=&amp;pLectureCls=${param.pLectureCls }"/>
				<a href="javascript:void(0);" onclick="fnCmdViewPage('${nextResult.type }', '${nextResult.courseId }', '${nextResult.courseName }', '${nextResult.isonoff }', '${nextResult.scupperclass }', '${nextResult.uclassnm }', '${nextResult.scyear }', '${nextResult.subjseq }'); return false;">
					<span class="title point tal">[${nextResult.type }]<strong></strong></span>
					<span class="fs12"><c:out value="${nextResult.tutornm }" /></span>
					<span class="db tal" style="height:42px;"><c:out value="${nextResult.intro }" /></span>
				</a>

				<c:if test="${nextResult.newYn eq 'Y'  }">
				<span class="linkers">
					<span class="ico1"><a href="#self"><img src="/edu/images/edupro/icolink_01.gif" alt="신규" /></a></span>
				</span>
				</c:if>
            </li>
   </ul>
</div> --%>
</c:if>

<!-- <iframe name="vodiframe" id="vodiframe" src="/common/empty.jsp" frameborder="0" width="0" height="0" title="hidden 동영상 관련 정보"></iframe> -->

<form id="frm" name="frm" method="post" class="form-inline">
	<input type="hidden" name="p_subj" id="p_subj" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" />
</form>

<script type="text/javascript">


$(document).ready(function(){
	
	
	var realmList = $(".online_edu_card_wrap");
	var realmParent = realmList.parent();
	var len = realmList.length;
	var moreBtn = $(".online_edu_card_view_btn");
	
	if( len <= pageBlockNum ) moreBtn.hide();
	
	var pageBlockNum = 5;
	
	function getBlockHei(){
		var blockLen = len;
		if( len >= pageBlockNum ) blockLen = pageBlockNum;
		
		var hei = 0;
		for( var i=0; i<blockLen; i++ ){
			if( hei < $(realmList[i]).outerHeight() ) hei = $(realmList[i]).outerHeight();
		}
		return hei;
	}
	var blockHeight = getBlockHei();
	
	function initHeight( h ){
		TweenMax.to($(realmParent), 0.5, {"height": h+"px", ease: Cubic.easeInOut});
	}
	
	initHeight( blockHeight );
	
	
	moreBtn.on("click", function(){
		var totalHeight = blockHeight * Math.ceil(len / pageBlockNum);
		initHeight( totalHeight );
		$(this).hide();
	});
	
});


//과정 상세화면
function fnCmdViewPage(type, subj, subjnm, isonoff, scupperclass, uclassnm, year, subjseq){
	$("#p_subj").val(subj);
	$("#p_subjnm").val(subjnm);
	$("#p_subjseq").val(subjseq);
	
	/* var url = "";
	if(type == "S"){
		url = "/edu/onlineEdu/realm/view.do?menuNo=500027";
		url = "/edu/onlineEdu/realm/view.do?p_gubun=&p_subj="+subj+"&p_subjseq="+subjseq+"&p_year="+year+"&menuNo=500027";
	}else{ */
		url = "/edu/onlineEdu/openLecture/view.do?pSeq="+subj+"&menuNo=500085&pageIndex=1";
	/* } */
	
	$("#frm").attr({
				action:url,
				method:"post",
				target:"_self"
				});
	$("#frm").submit();
}
</script>
