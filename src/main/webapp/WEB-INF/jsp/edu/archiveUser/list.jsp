<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<style>
.visual_wrap h2{margin-bottom:80px !important;}
@media all and(min-width:992px){
	.visual_wrap h2{margin-bottom:100px !important;}
}
.lnb_wrap {display: none !important;}
.sub_contents_wrap .sub_contents {padding-left:0 !important;}
</style>

<script src="/archive/js/layer_pop_archive.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/archive/css/archive.css" /><!-- 성과아카이브 css-->

	<!--content-->
	<div>
		<ul class="photoTab photoTabSize5 online_edu_tab_style tab_wrap" id="tabNavCtrl">
			<!-- 분류별 탭 목록 s -->
			<li id="tab1" class="active">
                <a href="/edu/archiveUser/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&workField=1" title="현재탭">콘텐츠 창의인재동반</a>
            </li>
            <li id="tab3">
                <a href="/edu/archiveUser/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&workField=3">콘텐츠 원캠퍼스</a>
            </li>
            <li id="tab4">
                <a href="/edu/archiveUser/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&workField=4">콘텐츠 임팩트</a>
            </li>
            <li id="tab2">
                <a href="/edu/archiveUser/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&workField=2">실감 콘텐츠 창작 양성</a>
            </li>
            <li id="tab5">
                <a href="/edu/archiveUser/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&workField=5">AI연계콘텐츠창작</a>
            </li>            
		</ul>
	</div>

	<div class="col-12 show-table sub_board_header control_board_header">
		<div class="col-3 show-tablecell fn vm board_title online_edu_board_title">
			<h4>
				총 <span class="board_count">${resultCnt}</span> 건의 검색 결과가 있습니다.
			</h4>
		</div>
		
		<form id="frm" name="frm" action="/edu/archiveUser/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>&workField=${param.workField }" method="post">
				<input type="hidden" name="workField"  id="workField"  value="<c:out value='${param.workField }' />" />
		</form>
	</div>
	
	<div class="photoGallery2 photoLine1">
	
		<div class="col-12 calc_wrap20">
			<c:forEach items="${resultList }" var="item3" varStatus="status3">
				<div class="col-12 col-md-3 online_edu_card_wrap">
					<div class="col-12 online_edu_card_list">
						<a class="show-block" href="javascript:void(0);" onclick="layer_open('layerOpen1','<c:out value="${item3.archiveProjectSeq}" />'); return false;">
							<div class="img_box">
							<c:choose>
				  			     <c:when test="${item3.atchFileId == null or item3.atchFileId == '' }">
				  			     	<img src="/edu/images/bm/kofac_card_img_001.jpg" style="width:100%" alt="${item3.atchFileId } 임시 이미지"/>
				  			     </c:when>
				  			     <c:otherwise>             
				  			     	<img alt="${item3.atchFileId } - 메인 이미지" src='/cmm/fms/getImage.do?atchFileId=<c:out value="${item3.atchFileId}&fileSn=1 "/>'  />
				  			     </c:otherwise>
				  			</c:choose>
							</div>
							<div class="text_box">
								<div class="online_edu_card_title">
									<h4>${item3.projectNm }</h4>
								</div>
								<div class="">
									${item3.organNm }
								</div>
								<div class="">
									${item3.archiveFieldFullNm}
								</div>
								<div class="">
									${item3.year }
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<c:if test="${resultCnt > 0}">
		<div class="paging">${pageNav}</div>
	</c:if>

	<!--레이어팝업 시작-->
	<div class="archive_layer">
	    <!--레이어배경-->
	    <div class="layer_bg"></div>
	
	    <!--레이어팝업창-->
	    <div class="layer_pop" id="layerOpen1">
	
	        <div class="header"     id="layerHeaders"></div>
	        <div class="layer_cont" id="layerContents"></div>
	        <div class="layer_top"  id="LayerTop"></div>
	        <div class="video_auto" id="iframeVideoTag">
	        	
	        	<div id="iframeArea">
	        		<iframe width="730" height="410" id="iframeLayer" src="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	        	</div>
	        	
	       		<div id="videoArea">
		       		<video width="730" height="410" id="video" autobuffer="true" autoplay="true" loop="false" volume="50"  playsinline="true">
		       			<source src="" id="videoLayer" type="video/mp4">
		       		</video> 
	       		</div>
	       		
	        </div>
	        <a href="javascript:void(0);" class="btn_layer_close">x</a>
	        
	    </div>
	    <!--레이어팝업창-->
	</div>
	<!-- 페이어팝업 끝 -->

<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
		
$(document).ready(function(){
	
	$( document ).ready(function(){
	    // parameter 값 가져오는 function
	    $.extend({
	        getUrlVars: function(){
	            var vars = [], hash;
	            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	            for(var i = 0; i < hashes.length; i++) {
	                hash = hashes[i].split("=");
	                vars.push(hash[0]);
	                vars[hash[0]] = hash[1];
	            }
	            return vars;
	        },
	        getUrlVar: function(name) {
	            return $.getUrlVars()[name];
	        }
	    });
	    // workField 뒤의 파라미터값을 가져옴
	    var pgcode = $.getUrlVar("workField");

	    // acitve
	 	if(pgcode == '1'){
	    	$("#tab1").addClass("active");
	    	$("#tab2").removeClass("active");
	    	$("#tab3").removeClass("active");
	    	$("#tab4").removeClass("active");
	    	$("#tab5").removeClass("active");
	    }
	    if(pgcode == '2'){
	    	$("#tab1").removeClass("active");
	    	$("#tab2").addClass("active");
	    	$("#tab3").removeClass("active");
	    	$("#tab4").removeClass("active");
	    	$("#tab5").removeClass("active");
	    }
	    if(pgcode == '3'){
	    	$("#tab1").removeClass("active");
	    	$("#tab2").removeClass("active");
	    	$("#tab3").addClass("active");
	    	$("#tab4").removeClass("active");
	    	$("#tab5").removeClass("active");
	    }
	    if(pgcode == '4'){
	    	$("#tab1").removeClass("active");
	    	$("#tab2").removeClass("active");
	    	$("#tab3").removeClass("active");
	    	$("#tab4").addClass("active");
	    	$("#tab5").removeClass("active");
	    }
	    if(pgcode == '5'){
	    	$("#tab1").removeClass("active");
	    	$("#tab2").removeClass("active");
	    	$("#tab3").removeClass("active");
	    	$("#tab4").removeClass("active");
	    	$("#tab5").addClass("active");
	    }	    
	});
});
	
	// 프로젝트 상세 팝업
	function getLayerId(id) {
		var headers    = '';
		var contents   = '';
		var youtubeUrl = '';
		var videoUrl   = '';
		var LayerTop   = '';
		
		// iframe태그 생성을 하고, video태그를 삭제한다.
		if(id == '72' || id == '73' || id == '74' || id == '75'){
			$('#videoArea').show();
			$('#iframeArea').hide();
		} else {
			$('#videoArea').hide();
			$('#iframeArea').show();
		}
		
		$.ajax({
			  type     : "post"
			, url      : "/edu/archiveUser/ajaxProjectDetail.json"
		    , dataType : "JSON"
		    , data     : {
		    	  archiveProjectSeq : id
		    			}
		    , success : function(ajaxData) {
		    	
		    	headers    = "<h2>" + ajaxData.projectDetail.projectNm + "</h2>";
				contents   = "<p>" + ajaxData.projectDetail.projectSummary + "</p>";
				
				if(id != '72' || id != '73' || id != '74' || id != '75'){
				youtubeUrl = ajaxData.projectDetail.resultUrl + "?rel=0;autoplay=1;showinfo=0;";
				}
				if(id == '72'){
					$('#video').remove();
					$('#videoArea').html('<video width="730" height="410" id="video" autobuffer="true" autoplay="true" loop="false" volume="100"  playsinline="true"><source src="" id="videoLayer" type="video/mp4"></video>');
					videoUrl   = '/archive/projectVideo/campany2.mp4';
				}
				if(id == '73'){
					$('#video').remove();
					$('#videoArea').html('<video width="730" height="410" id="video" autobuffer="true" autoplay="true" loop="false" volume="100"  playsinline="true"><source src="" id="videoLayer" type="video/mp4"></video>');
					videoUrl   = '/archive/projectVideo/campany1.mp4';
				}
				if(id == '74'){
					$('#video').remove();
					$('#videoArea').html('<video width="730" height="410" id="video" autobuffer="true" autoplay="true" loop="false" volume="100"  playsinline="true"><source src="" id="videoLayer" type="video/mp4"></video>');
					videoUrl   = '/archive/projectVideo/contents2.mp4';
				}
				if(id == '75'){
					$('#video').remove();
					$('#videoArea').html('<video width="730" height="410" id="video" autobuffer="true" autoplay="true" loop="false" volume="100"  playsinline="true"><source src="" id="videoLayer" type="video/mp4"></video>');
					videoUrl   = '/archive/projectVideo/contents1.mp4';
				}
				
				
		        $('#layerHeaders').html(headers);
				$('#layerContents').html(contents);
				$('#LayerTop').html(LayerTop);
				$('#iframeLayer').attr('src', youtubeUrl);
				$('#videoLayer').attr('src', videoUrl);
	    	}
		    ,   error :  function(arg1, arg2) {
		            alert("오류가 발생하여 플레이 할 수 없습니다.");
		        }
		});
		
	}; 
	
	
</script>





















