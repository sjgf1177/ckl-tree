<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util"%>
<script src="/archive/js/layer_pop_archive.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/archive/css/archive.css" /><!-- 성과아카이브 css-->

<!-- 연도 사업구분 주관기관명 과제명 불러오기 -->
<form id="frm" name="frm" method="post" action="/edu/archiveUser/contentsDeptList.do?taskSeq=${param.archiveTaskSeq}&menuNo=${param.menuNo}" class="form-inline" >
   <div class="sub_contents_body archive"><!-- archive 클래스 추가. kmy -->
      <!--content-->
      <!-- thumb_list_view -->
      <div class="thumb_list_view">
          <div class="view_top">
              <div class="thumb_img">
              <c:forEach items="${taskList}" var="taskList" varStatus="status">
                  <c:choose>
					<c:when test="${taskList.atchFileId == null or taskList.atchFileId == '' }">
						<img src="/edu/images/bm/kofac_card_img_001.jpg" alt="${taskList.atchFileId } 임시 이미지"/>
					</c:when>
					<c:otherwise>
						<img alt="${taskList.atchFileId } - 메인 이미지" src='/cmm/fms/getImage.do?atchFileId=<c:out value="${taskList.atchFileId}&fileSn=1 "/>'  />
					</c:otherwise>
				</c:choose> 
			  </c:forEach>
              </div>
              <div class="cont">
                  <div class="in">
                   	  <c:forEach items="${taskList}" var="taskList">
                   		  <strong>${taskList.organNm}</strong>
						  <span class="category">${taskList.archiveFieldFullName}</span>
					  </c:forEach>
                  </div>
              </div>
          </div>
          <div class="view_info">
              <dl>
              	  <dt>과제개요</dt>
              	  <c:forEach items="${taskList}" var="taskList">
                  <dd>${taskList.taskSummary}</dd>
                  </c:forEach>
              </dl>
              <dl>
                  <dt>프로젝트</dt>
              	  	  <dd>
              	  	      <ul class="in_list">
              	  	       <c:forEach items="${resultList}" var="resultList">
              	  	           <li>
              	  	              <a href="javascript:void(0);"  onclick="layer_open('layerOpen1','<c:out value="${resultList.archiveProjectSeq}" />'); return false;">
                                      <div class="thumb_img">
                                        <c:choose>
							  			     <c:when test="${resultList.atchFileId == null or resultList.atchFileId == '' }">
							  			     	<img src="/edu/images/bm/kofac_card_img_001.jpg"  alt="${resultList.atchFileId } 임시 이미지"/>
							  			     </c:when>
							  			     <c:otherwise>             
							  			     	<img alt="${resultList.atchFileId } - 메인 이미지" src='/cmm/fms/getImage.do?atchFileId=<c:out value="${resultList.atchFileId}&fileSn=1 "/>'  />
							  			     </c:otherwise>
							  			</c:choose> 
                                      </div>
                                      <div class="cont">
                                          <strong>${resultList.projectNm}</strong>
                                          <small>${resultList.students}</small>
                                          <span class="date">${resultList.year}</span>
                                      </div>
                                  </a>
              	  	           </li>
              	  	        </c:forEach>
              	  	      </ul>
              	  	  </dd>
              </dl>
</form>


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

<script type="text/javascript">
           
	$(document).ready(function(){
					
		
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

