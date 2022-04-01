
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script>
$(function(){
	// 동영상 불러오기 BM 20170829
	publishVideo(".wveditor_video");
});

function publishVideo( strSelc ){ // by. BM 
	var $conVideo = $(strSelc);
	
	var videoInfo = parseVideo( $conVideo.attr("data-wv-video-url") );
    var n = new Date();
    var videoSeq = "Player" + n.getTime();
    if( videoInfo.type === undefined || videoInfo.id == "" ){
        alert("주소가 올바르지 않습니다.");
        return;
    }

    $conVideo.find(".realPlayer").html("");
    $conVideo.find(".realPlayer").append("<div class='video_player'></div>")
    $conVideo.find(".video_player").attr("id",videoSeq); 
    $conVideo.find(".tempPlayer").css("z-index", 4);
    //$conVideo.find(".video_player").attr( { "id": videoSeq, "data-video-id" : videoSeq, "data-video-type" : this.selectedPlayer } );
    // API 활용 youtube 사용
    //var youtube = new Youtube( videoInfo.id, "100%", "100%" );
    var youtubePlayer = new YoutubePlayer( videoInfo.id, "100%", "100%" );
    if ( typeof window.YT === "undefined" ) { // js 로딩이 완료되었을때 영상을 붙힙니다. 
        window.onYouTubePlayerAPIReady = function() {
            publishYoutubePlayer( $conVideo, videoSeq, youtubePlayer );
        }
    } else {
        publishYoutubePlayer( $(this.target), videoSeq, youtubePlayer );
    }
    function publishYoutubePlayer( $target, videoSeq, youtubePlayer ){
        $target.find(".tempPlayer").css("z-index", 2);
        var newPlayer = new YT.Player( videoSeq, {
            height: youtubePlayer.height,
            width: youtubePlayer.width,
            //videoId: youtubePlayer.videoId, // 여기에 비디오 아이디값을 넣으면 반복재생이 제한적으로 안됨 
            //playerVars : {'enablejsapi':1, 'controls':0, 'playlist':youtubePlayer.videoId}, // 비디오아이디값을 플레이리스트에 담아서 해결
            playerVars : {'enablejsapi':1, 'playlist':youtubePlayer.videoId}, // 비디오아이디값을 플레이리스트에 담아서 해결
            events: {
                'onReady': function(e){
                	console.log("youtube ready");
                    //_this.onYoutubePlayerReady.call(_this, e);
                },
                'onStateChange': function(e){
                    //_this.onPlayStateChange.call(_this, e);
                }
            }
        });
        console.log( newPlayer );
    }
}
</script>

	<table class="board_type_0 detail notice" summary="notice board view">
	<caption>현장스토리 게시판 뷰 페이지</caption>
		<colgroup>
			<col width="100%">
		</colgroup>
	<thead>
	<tr>
		<th>
			<span>
				<c:out value="${result.nttSj}" />
			</span>
			<span class="writer_info">
				<span class="tar"> <c:out value="${result.ntcrNm}"/></span>
				<span>
				<c:out value="${result.frstRegisterPnttm}" />
				</span>
			</span>
		</th>
	</tr>
	</thead>
		<tbody>
		<tr>
			<td>
				<div class="contents_view_area">
					<c:choose>
						<c:when test="${result.htmlYn=='Y'}">${result.nttCn}</c:when>
						<c:otherwise>
								<% pageContext.setAttribute("crlf", "\n"); %>
							${fn:replace(result.nttCn, crlf, "<br/>")}
						</c:otherwise>
					</c:choose>
					<!-- 영상URL -->
					<c:choose>
						<c:when test="${result.option1 != ''}">
							<div class="col-12 wveditor_video" data-wv-video-url="${result.option1}" style="height:600px;">
								<div class="tc fontsize50 tempPlayer" style="position: absolute; display: table; width: 100%; height: 100%; z-index: 12; background-size: cover; cursor: pointer;background:#fff;border:1px solid #a2a1a1;color:#40abd4;">
					            	<span style="display: table-cell; width: 100%; vertical-align: middle;">▷</span>
						        </div>
								<div class="realPlayer" style="position: absolute; width: 100%; height: 100%; z-index: 3;">
									<div class="video_player" data-wv-video-id="" data-wv-video-type=""></div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							등록된 동영상이 없습니다.
						</c:otherwise>
					</c:choose>
					<!-- //영상URL -->
					

					<!-- 본문이미지 대체텍스트 -->
					<!-- <div class="hidden">${result.imgDescCn}</div> -->
				</div>
			</td>
		</tr>
		</tbody>
	</table>

	<div class="paging view_paging">
		<ul class="pagination">
		<c:if test="${prevNextMap['PREV'].prevNttId > 0}">
			<li class="btn_singlePage prev">
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['PREV'].prevNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">	
					${prevNextMap['PREV'].nttSj }
				</a>	
			</li>
		</c:if>
		<c:if test="${prevNextMap['NEXT'].nextNttId > 0}">
			<li class="btn_singlePage next">
				<a href="/<c:out value="${paramVO.siteName }"/>/bbs/<c:out value='${paramVO.bbsId}'/>/view.do?nttId=<c:out value="${prevNextMap['NEXT'].nextNttId}" />&amp;<c:out value="${pageQueryString}" escapeXml="false" />">
					${prevNextMap['NEXT'].nttSj }
				</a>
			</li>
		</c:if>
		</ul>
	</div>
	<div class="board_util_btn_con">
	<c:url var="url" value="/edu/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
	<a class="btn_style_0 full list" href="<c:out value='${url}' escapeXml='false'/>">
	목록
	</a>
	</div>



<style>
	.linemap_wrap .linemap_con li:nth-child(4) { display:none }
</style>

<script>
function parseVideo( url ){ //BM
    url.match(/(http:|https:|)\/\/(player.|www.)?(vimeo\.com|youtu(be\.com|\.be|be\.googleapis\.com))\/(video\/|embed\/|watch\?v=|v\/)?([A-Za-z0-9._%-]*)(\&\S+)?/);
    if (RegExp.$3.indexOf('youtu') > -1) {
        var type = "youtube";
    } else if (RegExp.$3.indexOf('vimeo') > -1) {
        var type = "vimeo";
    }
    return {
        type: type,
        id: RegExp.$6
    };
};
var YoutubePlayer = function( id, width, height ){ //BM
    //if( document.getElementById('youtubeScript') == null ){
        var tag = document.createElement('script');
        tag.src = "//www.youtube.com/iframe_api";
        //tag.id = "youtubeScript";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
    //}

    this.videoId = id;
    this.width = width ? width : "100%";
    this.height = height ? height : "100%";
};
</script>