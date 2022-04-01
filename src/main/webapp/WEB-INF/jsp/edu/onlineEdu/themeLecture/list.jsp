<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<link href="/edu/css/new/videojs/video-js.css" rel="stylesheet">
<script src="/edu/js/new/videojs/videojs-ie8.js"></script>
<script src="/edu/js/new/videojs/video.js"></script>

<!--content-->
<!-- 스타일 500***.jsp 파일에 넣을 것 -->
<!-- <style type="text/css">
.lnb_wrap{display:none;}
.sub_contents_wrap .sub_contents{padding-left:0;}
</style> -->

<div class="sub_theme_process">
	<div class="col-12 show-table sub_board_header control_board_header">
		<div class="col-5 show-tablecell fn vm board_title">
			<h4 class="theme_process_title">
				총 <span class="board_count">${resultCnt}</span>개의 과정이 운영되고 있습니다.
			</h4>
		</div>
		<div class="col-7 show-tablecell fn vm tr board_sorting_con">
			<form id="frm" name="frm" action="/edu/onlineEdu/themeLecture/list.do" method="post" class="form-inline col-12 show-tablecell fr tr">
				<input type="hidden" name="pageQueryString" value='<c:out value="${pageQueryString }" escapeXml="false"/>' >
				<input type="hidden" name="menuNo" value='<c:out value="${param.menuNo }" escapeXml="false"/>' >
				<input type="hidden" name="pageIndex" id="pageIndex" value='<c:out value="${param.pageIndex }" escapeXml="false"/>' >
				<fieldset>
					<legend></legend>
					<span class="tl input_search_con" style="padding-right:0;">
						<input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어 입력" value="<c:out value="${param.searchWrd}" />">
						<a href="javascript:void(0);" onclick="fnCmdSearchList(); return false;" class="search_summit">검색</a>
<!-- 						<input type="submit" class="search_summit" id="" name="" value=""> -->
					</span>
				</fieldset>
			</form>
		</div>
	</div>
	
	<!-- <div class="col-12">
		<div class="mb37 alert big_box type_1">
		    <p class="alert_desc is_margin_desc">
		        온라인 과정의 <span class="apply_no_text">교육체계도 및 추천 Track</span>을 확인하실 수 있습니다.
		    </p>
		    <p class="alert_desc">
		        원하는 Track을 클릭하셔서 <span class="apply_no_text">세부 내용을 확인</span>하세요.
		    </p>
		    <a class="btn_go_edusystem" href="/edu/onlineEdu/edcsystm/list.do?menuNo=500030">교육체계도 바로가기</a>
		</div>
	</div>
	
    <div class="col-12 calc_wrap20">
        <div class="col-12 col-sm-6 sub_theme_process_list m_dn">
            <a class="border_box" href='#' style="height: auto;" id="themeCoursePreview">
                <div class="col-5 img_box">
                	<img src="/edu/new_image/eduCurr2.jpg" alt="테마과정" style="max-height: 93px; height: 93px;">
                </div>
                <div class="col-7 text_box">
                    <h5 style="height: auto;">테마과정</h5>
                    <p class="h_desc5">나에게 딱 맞는 테마과정으로 Pick!</p>
                </div>
            </a>
        </div>
        <div class="col-12 col-sm-6 sub_theme_process_list">
            <a class="border_box" href='/edu/onlineEdu/edcsystm/list.do?menuNo=500030' style="height: auto;">
                <div class="col-5 img_box">
                    <img src="/edu/new_image/eduCurr.png" alt="교육체계도" style="max-height: 93px; height: 93px;">
                </div>
                <div class="col-7 text_box">
                    <h5 style="height: auto;">교육체계도</h5>
                    <p class="h_desc5">온라인 과정의 교육체계도 및 추천 Track을 확인하실 수 있습니다.</p>
                </div>
            </a>
        </div> -->
        <div class="col-12"style="padding-left:20px;">
			<div class="mb37 alert big_box type_1" 
				style="position: relative;padding-bottom: 56.25%;padding-top: 25px;height: 0;">
			    <iframe title="테마과정 유튜브 홍보영상"
			    	style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;"
			    	src="https://www.youtube.com/embed/t9KSZzs2gGw" 
			    	frameborder="0" 
			    	allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
			    </iframe>
			</div>
			<div class="edu_youtube_subtitle_view_btn_con">
				<button class="edu_youtube_subtitle_view_btn caption_btn" onclick="showCaption();"><span class="edu_view_default" style="color:white">자막보기</span><span class="edu_view_active">자막닫기</span></button>
				<div class="edu_youtube_subtitle_view_text" tabindex="0">
					매월 다양한 주제로 진행되는<br>
					콘텐츠 장르별 테마과정!<br>
					나에게 딱 맞는 테마과정으로<br>
					PICK!<br>
					PICK!<br>
					PICK!<br>
					PICK!<br>
					<br>
					방송영상<br>
					1인 콘텐츠 제작 꿀팁 공개!<br>
					삼대장 X 양띵 X 허팝<br>
					채널 개설에서 콘텐츠 관리까지!<br>
					MCN에 대해 이해하고<br>
					1인 콘텐츠 실제 제작 방법을 알아봅시다!<br>
					<br>
					게임<br>
					인디게임 제작, 시작은 이렇게!<br>
					1인 게임 제작을 하고 싶지만<br>
					어떻게 시작해야 할지 몰라 망설이셨나요?<br>
					게임기획 방법부터 인디게임 실제 제작 과정까지 알아봅니다!<br>
					<br>
					만화/애니/캐릭터<br>
					웹툰 제작 프로그램 모음<br>
					클립스튜디오 X 스케치업<br>
					만화 제작에 대중적으로 쓰이는 '클립스튜디오'와<br>
					웹툰 배경 제작에 많이 이용하는 '스케치업' 툴 사용방법을<br>
					익히고 웹툰 제작에 활용해 봅니다!<br>
					<br>
					음악/공연<br>
					집이 곧 스튜디오! 도전, 홈레코더<br>
					프로툴즈 X 큐베이스<br>
					악기 녹음과 보컬 녹음을 홈레코딩으로!<br>
					홈레코딩에 필요한 장비와 소프트웨어<br>
					그리고 녹음하기까지의 과정을 안내합니다.<br>
					<br>
					테마과정으로<br>
					내가 듣고 싶은 과정을 쉽게!<br>
					<br>
					한국콘텐츠아카데미<br>
					홈페이지에서 확인해보세요!<br>
					<br>
					한국콘텐츠아카데미에서는<br>
					콘텐츠 분야의 꿈을 펼치실 여러분의<br>
					다양한 꿈과 희망을 응원합니다.<br>
					<br>
					한국콘텐츠아카데미
				</div>
			</div>
		</div>
    	<c:forEach items="${resultList }" var="result" varStatus="status" >
			<c:url var="url" value="/edu/onlineEdu/themeLecture/view.do">
				<c:param name="pId" value="${result.id }"/>
			</c:url>

	        <div class="col-12 col-sm-6 sub_theme_process_list">
	            <a class="border_box" href='<c:out value="${url }" />&amp;${pageQueryString }'>
	                <div class="col-5 img_box">
	                    <img src="${result.img }" alt="${result.title }" style="max-height: 93px; height: 93px;">
	                </div>
	                <div class="col-7 text_box">
	                    <h5>${result.title }</h5>
	                    <p class="h_desc5">${result.description }</p>
	                </div>
	            </a>
	        </div>
        </c:forEach>
    </div>

<!-- paging -->
<div class="paging">${pageNav}</div>
<!-- //paging -->
<!--//content-->

<script type="text/javascript">
	$(document).ready(function(){
		//과정 조회 enter key
		$("#searchWrd").keydown(function(e) {
		    if (e.keyCode == 13) fnCmdSearchList();

		});

		var myPlayer;
		$("#themeCoursePreview").on("click", function(){
			$("body").prepend($("<div/>").addClass("bg_popup themeCoursePreviewPopup").append([
				$("<div/>").append(
					$("<div/>").addClass("popup_box").append([
						$("<span/>").addClass("btn_popupClose").text("X"),
						$("<video/>").attr({id: "my-video", controls: true}).addClass("video-js").data("setup", {})
					])
				)
			]));

			$(".sub_layout_page").css({"position":"fixed"});
			myPlayer = videojs('my-video', {"controls" : true, "autoplay" : true, "preload" : "auto", "loop" : false});
			myPlayer.src({type:"video/mp4", src:"http://vod.kbrainc.com/kbrain/kocca/pr_video/pr_video_theme_course.mp4"});
		})

		$(document).on('click', '.btn_popupClose, .themeCoursePreviewPopup.bg_popup', function(e){
			if (e.target == this) {
				myPlayer.dispose();
				$(".themeCoursePreviewPopup.bg_popup").empty();
				$(".themeCoursePreviewPopup.bg_popup").remove();
				$(".sub_layout_page").css({"position":""});
			}
		});
	});

	function fnCmdSearchList(){
		$("#pageIndex").val("1");
		$("#frm").attr({
					action:"/edu/onlineEdu/themeLecture/list.do",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
</script>
<style>
.edu_youtube_subtitle_view_btn_con{text-align: right; margin-bottom: 40px;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn{font-size:14px; font-size:1.4rem; line-height:20px; line-height:2.0rem; color:#fff; display:inline-block; border-radius:1px; cursor: pointer;
    text-align: left; padding-right:41px; padding-left:12px; padding-top:9px; padding-bottom:8px; background-image:url('/edu/images/bm/edu_yotubue_subtitle_view.png'); background-repeat: no-repeat; background-position: right 12px center; background-color: #1da28d; box-sizing: border-box;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_default{display:inline-block;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_active{display:none;}
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_btn .edu_view_close_btn{display:none; float:right; width:17px; height:17px; background-image: url('/edu/images/bm/edu_yotubue_subtitle_close.png');}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn{overflow:hidden; display:block; width:100%; padding-left:25px; background-image:none; padding-right:25px;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_default{display:none;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_active{display:inline-block;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_btn .edu_view_close_btn{display:inline-block; }
.edu_youtube_subtitle_view_btn_con .edu_youtube_subtitle_view_text{font-size: 14.5px; font-size: 1.45rem; line-height: 26px; line-height: 2.6rem; color: #999999; letter-spacing: -0.025em;
    padding-top:20px; padding-left:25px; padding-right:25px; padding-bottom:20px; border:2px solid #5ac9b7; text-align: left; display:none; max-height:300px; overflow-y: auto;}
.edu_youtube_subtitle_view_btn_con.active .edu_youtube_subtitle_view_text{display:block;}
</style>
