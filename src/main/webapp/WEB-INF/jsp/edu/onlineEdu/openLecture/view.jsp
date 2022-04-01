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
	.lnb_con{display: none;}
	.sub_contents_wrap .sub_contents {padding-left: 0;}
</style>
<script type="text/javascript">
	document.title = "<c:out value="${result.lecnm }" escapeXml="false" /> < " +document.title;
	
	$(document).ready(function(){
		$('.lnb_wrap').addClass('dn');
	
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
	}

	function fnDirectLoadMP4(file, width, height){
		var tagObj = "";
		
		tagObj = '<video width="100%" height="auto" max-width="'+width+'" oncontextmenu="return false;" controls="true" controlslist="nodownload">\n';
		tagObj += '<source src="'+file+'" type="video/mp4">\n';
		tagObj += '</video>';
		
	 	$("#vodArea").html( tagObj );
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
		} else {
			if(vodPath.indexOf("ksp.credu.com") > 0){
				$("#vodAreaHtml").html( "<div bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\"><div id=\"vodArea\"></div></div>" );
				fnLoadMP4(vodPath, 1080, 630);
			} else if(vodPath.indexOf("mp4") > 0){
				$("#vodAreaHtml").html( "<div bgcolor=\"#ffffff\" leftmargin=\"0\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\"><div id=\"vodArea\"></div></div>" );
				fnDirectLoadMP4(vodPath, width, height);	
			}else{
				$.get(vodUrl, function(data){
				}, 'html').done(function (data){
					$("#vodAreaHtml").html( "<div "+data.substring(data.indexOf("<body")+6, data.indexOf("</body>") ) + "</div>" );
					var url = $("#oFlashVar").val();
					fnLoadSWF(vodPath, 1080, 630, true, "vodURL=" + url);
				});
			}
		}
		
		$("#vodArea > video").focus();
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
</script>

<div class="alert big_box type_1" style="overflow:hidden;">
	<p style="margin-bottom: 3px;">
		<c:if test="${not empty result.lvnm}">
			<c:choose>
				<c:when test="${result.lvcd eq 'L0101' or result.lvcd eq 'L0201'}">
					<span class="tag L1" style="margin-left: 0;">${result.lvnm}</span>
				</c:when>
				<c:when test="${result.lvcd eq 'L0102' or result.lvcd eq 'L0202'}">
					<span class="tag L2" style="margin-left: 0;">${result.lvnm}</span>
				</c:when>
				<c:when test="${result.lvcd eq 'L0103' or result.lvcd eq 'L0203'}">
					<span class="tag L3" style="margin-left: 0;">${result.lvnm}</span>
				</c:when>								
			</c:choose>
		</c:if>
		<span class="gray_txt" style="line-height: 20px;">
			<c:if test="${not empty result.g1nm}">
				${result.g1nm}
			</c:if>
			<c:if test="${not empty result.g2nm}">
				&gt; ${result.g2nm}
			</c:if>
			<c:if test="${not empty result.g3nm}">
				&gt; ${result.g3nm}
			</c:if>			
		</span>
	</p>
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
					열린강좌 목록으로
				</a>
			</li>
		</ul>
	</div>
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
	<a href="javascript:void(0);" class="${(fn:length(fn:replace(result.subtitle,' ','')) == 0?'hidden':'') } btn_style_0 green openlecture_eye eye_on" style="margin-right:0; margin-bottom:0;"  >
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

<!-- consumer_seq = 1077 /  -->
<!-- 아카데미이야기 24725 : MTA3Ny8yNDcyNS8xNTA5  livere_seq = 24892  / 강좌 24892 : MTA3Ny8yNDg5Mi8xNTA5   livere_seq = 1509 -->

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
									<c:if test="${not empty nextResult.lvnm}">
										<c:choose>
											<c:when test="${nextResult.lvcd eq 'L0101' or nextResult.lvcd eq 'L0201'}">
												<span class="tag L1">${nextResult.lvnm}</span>
											</c:when>
											<c:when test="${nextResult.lvcd eq 'L0102' or nextResult.lvcd eq 'L0202'}">
												<span class="tag L2">${nextResult.lvnm}</span>
											</c:when>
											<c:when test="${nextResult.lvcd eq 'L0103' or nextResult.lvcd eq 'L0203'}">
												<span class="tag L3">${nextResult.lvnm}</span>
											</c:when>								
										</c:choose>
									</c:if>

									<c:if test="${not empty nextResult.g3nm}">
										<span class="gray_txt">${nextResult.g3nm}</span>
									</c:if>		
									
									<c:if test="${empty nextResult.g3nm}">
										<span class="gray_txt">${nextResult.g2nm}</span>
									</c:if>

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
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<div class="online_edu_card_view_btn">
		<button class="online_edu_card_view_btn_inner" onclick="moreBtnClick();">
			<div class="more_btn_img">
				<img src="/edu/images/bm/online_edu_card_view_more_btn.png" alt="더보기">
			</div>
			<div class="more_btn_text">
				더보기
			</div>
		</button>
	</div>
</c:if>

<form id="frm" name="frm" method="post" class="form-inline">
	<input type="hidden" name="p_subj" id="p_subj" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" />
</form>

<script type="text/javascript">
	var realmList = $(".online_edu_card_wrap");
	var realmParent = realmList.parent();
	var len = realmList.length;
	var moreBtn = $(".online_edu_card_view_btn_inner");
	var pageBlockNum = 4;
	
	function getBlockHei(){
		var blockLen = len;
		if( len >= pageBlockNum ) blockLen = pageBlockNum;
		
		var hei = 0;
		for( var i=0; i<blockLen; i++ ){
			if( hei < $(realmList[i]).outerHeight() ) hei = $(realmList[i]).outerHeight();
		}
		return hei;
	}
	
	function initHeight( h ){
		TweenMax.to($(realmParent), 0.5, {"height": h+"px", ease: Cubic.easeInOut});
	}
	
	function moreBtnClick(){
		var blockHeight = getBlockHei();
		var totalHeight = blockHeight * Math.ceil(len / pageBlockNum);
		initHeight( totalHeight );
		moreBtn.parent().hide();
	}
	
	$(document).ready(function(){
		
		if( len <= pageBlockNum ) moreBtn.parent().hide();
		
		var blockHeight = getBlockHei();
		
		initHeight( blockHeight );
		
	});
	
	function getBlockHei(){
		var blockLen = len;
		if( len >= pageBlockNum ) blockLen = pageBlockNum;
		
		var hei = 0;
		for( var i=0; i<blockLen; i++ ){
			if( hei < $(realmList[i]).outerHeight() ) hei = $(realmList[i]).outerHeight();
		}
		return hei;
	}
	
	function initHeight( h ){
		TweenMax.to($(realmParent), 0.5, {"height": h+"px", ease: Cubic.easeInOut});
	}
	
	//과정 상세화면
	function fnCmdViewPage(type, subj, subjnm, isonoff, scupperclass, uclassnm, year, subjseq){
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_subjseq").val(subjseq);
		
		url = "/edu/onlineEdu/openLecture/view.do?pSeq="+subj+"&menuNo=500085&pageIndex=1";
		
		$("#frm").attr({
					action:url,
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
</script>
