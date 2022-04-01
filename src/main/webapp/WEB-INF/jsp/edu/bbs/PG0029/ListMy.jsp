<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper"%>
<%@ page import="kr.co.unp.member.vo.UsersVO"%>
<%
UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
%>

<c:if test='${not empty user.userId && !"".equals(user.userId) && !"anonymousUser".equals(user.userId) && !"anonymousUser".equals(user.userNm) }'>
   	<c:url value="/edu/html/selfview/ajaxLogin.html" var="url">
	  <c:param name="id" value="${user.userId}" />
	  <c:param name="name" value="${user.userNm}" />
	</c:url>
	<iframe src="${url}" style="display: none;"></iframe>
</c:if>


<script type="text/javascript">


    var currPage = 1;
    var countPerPage = 12;
    var pageNumBlock = 10;
    var totalPage = 100;
    var totalPageCount = 100;
    var prevKeyword = "";

    var noDataHtml = '<li>' +
            '<p>' +
            '모의면접 평가결과가 없습니다.' +
            '</p>' +
            '</li>';

    function getInterview( currentPage ){

        currPage = currentPage;

        $("#interviewList").html("");
        //$("#interviewList").html("<tr><td colspan='2'>"+keyword+ " 검색결과 가져오는중" +"</td></tr>");


        $.ajax({
            method : "post",
            dataType : "jsonp",
            url : "https://kocca.selfview.co.kr/member/ajax/load_mylist_dream.ajax.php",
            data : {page : currPage, listcount:countPerPage},
            success : function(res){


                if( res.result == "0"){
                    alert("모의면접 접속에 실패하였습니다.");
                    makeObj( [] );//rsg20171012
                }else{
                    if( res.list && res.list.length > 0 ){
                    	
                        currPage = parseInt( res.page );
                        totalPageCount = parseInt( res.listcount ); // 전체 갯수
                        //totalPage = Math.ceil( totalPageCount / countPerPage ); // 전체 페이지 갯수
                        totalPage = parseInt(res.pagecount); // 전체 페이지 갯수

                        $("#interviewList").html("");
                        makeObj( res.list );
                    }else{
                        makeObj( [] );
                    }
                }

            },
            error : function(e){
                console.log( "list error!!" );
                console.log( e );
            }
        });

    }

    function enterSearch() {
        var evt_code = (window.netscape) ? ev.which : event.keyCode;
        if (evt_code == 13) {
            event.keyCode = 0;
            getInterview(); //jsonp사용시 enter검색
        }
    }
    
    function openPopupResult( url ){
    	window.open(url, "모의면접 결과보기", "width=1180, height=760, menubar=no, status=no, toolbar=no");
    }
    
    function deleteResult( seq ){
    	
    	if( confirm("삭제하시겠습니까?") === false ) return;
    	
    	$.ajax({
            method : "post",
            dataType : "jsonp",
            url : "https://kocca.selfview.co.kr/member/ajax/del_list.ajax.php?seq="+seq,
            success : function(res){
            	
            	console.log( res );
                if( res.result == "1"){
                    alert("선택하신 모의면접 평가결과가 삭제되었습니다.");
                }else{
                    alert("평가결과 삭제에 실패하였습니다.");
                }
               	getInterview( currPage );

            },
            error : function(e){
                console.log( "list error!!" );
                console.log( e );
            }
        });
    }

    function makeObj( list ){

        htmlStr = "";
        cnt = 0;

        if( list.length > 0 ){
            for( var i=0; i<list.length; i++ ){
                var url =  list[i].linkurl;
                var seq =  list[i].seq;
                var imagesrc =  list[i].imagesrc;
                var reg_date =  list[i].regdatetext;
                
                url = url.replace("my_view.html", "my_viewtest.html");
                
                htmlStr += '<div class="col-12 col-md-4 demo_interview_card_wrap">';
                htmlStr += '	<div class="col-12 demo_interview_card_list">';
                htmlStr += '		<div class="col-12 img_box">';
                htmlStr += '			<img src="'+imagesrc+'" alt="모의면접 평가결과_'+seq+'">';
                htmlStr += '		</div>';
                htmlStr += '		<div class="col-12 text_box">';
                htmlStr += '			<div class="demo_interview_title">모의면접 평가결과</div>';
                htmlStr += '			<div class="demo_interview_desc">'+reg_date+'</div>';
                htmlStr += '			<div class="demo_interview_more_btn_con">';
                htmlStr += '				<a href="javascript:openPopupResult(\''+url+'\');" class="demo_interview_more_btn full">';
                htmlStr += '					결과보기';
                htmlStr += '				</a>';
                htmlStr += '				<a href="javascript:deleteResult(\''+seq+'\');" class="demo_interview_more_btn">';
                htmlStr += '					결과삭제';
                htmlStr += '				</a>';
                htmlStr += '			</div>';
                htmlStr += '		</div>';
                htmlStr += '	</div>';
                htmlStr += '</div>';
                
//                 htmlStr += "<td width='70'><a href='"+url+"' target='_blank'><img src='"+imagesrc+"' alt='"+seq+"'/></a></td>";
//                 htmlStr += "<td>";
//                 htmlStr += reg_date;
//                 htmlStr += "</td>";
//                 htmlStr += "</tr>";
                cnt++;
            }
        }

        if( cnt > 0 ){
            $("#interviewList").html(htmlStr);
            $("#paging").html("");
            $("#paging").html( setPaging() );
            $("#paging").show();
        }else{
            $("#interviewList").html(noDataHtml);
            $("#paging").html("");
            $("#paging").hide();
        }
    }



    function setPaging(){


        var block = Math.ceil( currPage / pageNumBlock );
        var pagingStart = ( (block - 1) * pageNumBlock ) + 1;
        var pagingEnd = pagingStart + pageNumBlock - 1;
        if( pagingEnd > totalPage ) pagingEnd = totalPage;

        var pagingHtml = "";
		
        // 이전 버튼 영역
        //pagingHtml += '<a href="javascript:getInterview(1)" >처음</a>';
        pagingHtml += '<li class="first disabled" onclick="javascript:getInterview(1)" ><span role="text" aria-label="처음 목록으로 이동" tabindex="0">처음 목록으로 이동</span></li>';
        var prevBtnPage = 0;
        if( currPage > pageNumBlock ){
            prevBtnPage = currPage - pageNumBlock;
            //pagingHtml += '<a href="javascript:getInterview('+ prevBtnPage +')" class="prev">이전</a>';
            pagingHtml += '<li class="prev disabled" onclick="javascript:getInterview('+ prevBtnPage +');"><span role="text" aria-label="이전 목록으로 이동" tabindex="0">이전 목록으로 이동</span></li>';
        }else{
            //pagingHtml += '<a href="javascript:getInterview(1)" class="prev">이전</a>';
            pagingHtml += '<li class="prev disabled" onclick="javascript:getInterview(1);"><span role="text" aria-label="이전 목록으로 이동" tabindex="0">이전 목록으로 이동</span></li>';
        }

        // 넘버링
        for( var i=pagingStart; i<=pagingEnd; i++){
            if( i == currPage ){
                //pagingHtml += '<a href="javascript:getInterview('+currPage+')" class="current">'+i+'</a>';
                pagingHtml += '<li class="active"><span role="text" aria-label="'+i+', 현재페이지" tabindex="0"><em><span>'+i+', 현재페이지</span></em></span></li>';
            }else{
                //pagingHtml += '<a href="javascript:getInterview('+i+')">'+i+'</a>';
                pagingHtml += '<li><a href="javascript:getInterview('+i+');"><span role="text" aria-label="'+i+'" tabindex="0">'+i+'</span></a></li>';
            }
        }

        // 다음 버튼 영역
        var nextBtnPage = 0;
        if( totalPage > pageNumBlock && currPage+pageNumBlock < totalPage ){
            nextBtnPage = currPage + pageNumBlock;
            //pagingHtml += '<a href="javascript:getInterview('+nextBtnPage+');" class="next">다음</a>';
            pagingHtml += '<li class="next"><a style="opacity:1" title="다음 10페이지 목록으로 이동" href="javascript:getInterview('+nextBtnPage+');">다음 10페이지 목록으로 이동</a></li>';
        }else{
            //pagingHtml += '<a href="javascript:getInterview('+totalPage+');" class="next">다음</a>';
            pagingHtml += '<li class="next"><a style="opacity:1" title="다음 10페이지 목록으로 이동" href="javascript:getInterview('+totalPage+');">다음 10페이지 목록으로 이동</a></li>';
        }
        //pagingHtml += '<a href="javascript:getInterview('+totalPage+')" >마지막</a>';
        pagingHtml += '<li class="end"><a style="opacity:1" title="끝 페이지로 이동" href="javascript:getInterview('+totalPage+');">끝 페이지로 이동</a></li>';
        return pagingHtml;
    }


    $(function(){
    	setTimeout(function(){
        	getInterview(currPage);
    	}, 1500);
    });

</script>
<ul class="list_style_2 big_style">
    <li>모의면접 시 미리 준비해야 할 사항</li>
</ul>
<ul class="mb40 list_style_9">
    <li>실전 면접이라 생각하고 태도 및 자세를 올바르게 한다.</li>
    <li>시선처리와 표정관리를 올바르게 한다.</li>
    <li>열정과 자신감이 표현될 수 있도록 한다.</li>
    <li>면접관이 정확하게 이해 할 수 있는 목소리 크기와 말하기 습관을 미리 연습한다. </li>
</ul>
<div class="board_util_btn_con center pb20">
	<a href="/edu/bbs/B0000060/listSec.do?menuNo=500139" class="btn_style_0 green center short">모의면접 시작</a>
</div>
<hr class="recruit_online_seperate_line mb40">
<div class="col-12">
	<div class="col-12" id="interviewList">
		<%--
		<!-- 여기부터 반복 -->
		<div class="col-12 col-md-4 demo_interview_card_wrap">
			<div class="col-12 demo_interview_card_list">
				<div class="col-12 img_box">
					<img src="/edu/images/bm/demo_interview_detail_img.jpg" alt="모의면접 평가결과">
				</div>
				<div class="col-12 text_box">
					<div class="demo_interview_title">모의면접 평가결과</div>
					<div class="demo_interview_desc">
						2017.06.19 23:44:05
					</div>
					<div class="demo_interview_more_btn_con">
						<a href="javascript:void(0)" class="demo_interview_more_btn">
							결과보기
						</a>
					</div>
				</div>
			</div>
		</div>
		--%>
	</div>
</div>
<div class="paging">
	<div class="paginationSet">
		<ul class="pagination pagination-centered" id="paging">
		</ul>
	</div>
</div>


<!-- <div class="paging" id="paging"></div> -->
<!-- paging -->
<%-- 
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">${pageNav}</div>
</c:if> 
--%>
<!-- //paging -->
