<%@page contentType="text/html;charset=utf-8" %>

<!-- rsg20170901 -->
<%
//rsg20170901
String showViewNo = (String)request.getParameter("showViewNo") != null && (String)request.getParameter("showViewNo") != "" ? (String)request.getParameter("showViewNo") : "0" ;
%>

<div class="fontsize0 sub_contents_body sub_board_wrap">
	<div class="col-12 show-table sub_board_header control_board_header">
		<div class="col-5 show-tablecell fn vm board_title">
		    <h4>총 <span class="board_count">4개</span>의 게시글 등록</h4>
		</div>
		<div class="col-7 show-tablecell fn vm tr board_sorting_con">
	        <!--<input type="hidden" name="menuNo" value="500045">
	<input type="hidden" name="nttId" value="0">
	<input type="hidden" name="pageQueryString" value="searchCnd=&amp;searchWrd=&amp;gubun=&amp;delCode=0&amp;useAt=&amp;replyAt=&amp;menuNo=500045&amp;sdate=&amp;edate=&amp;viewType=&amp;type=&amp;siteId=&amp;option1=&amp;option5=&amp;pageIndex=1">-->
            <span class="tl select_box">
                <select name="" id="" class="select_style_0" title="검색 조건 선택">
                    <option value="1">제목</option>
                    <option value="2">내용</option>
                </select>
                <!-- <label for=""></label> -->
            </span>
            <span class="tl input_search_con">
                <input type="text" class="board_search" name="searchWrd" id="searchWrd" title="검색어를 입력해 주세요." placeholder="검색어 입력" value="">
                <input type="submit" id="input2" name="input2" value="" class="search_summit btn-primary" title="검색">
            </span>
	    </div>
	</div>
	<div class="col-12 sub_contents_view_calendar">
	    <div class="col-12 calc_wrap25">
	    	<div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v04">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img03.jpg" alt="타이터스">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        타이터스
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.10.18 ~ 10.20(금) / 10.21(토)</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v01">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img00.jpg" alt="데이드림 이미지">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        데이드림 - Day Dream
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.09.05 ~ 2017.09.06</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v02">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img01.jpg" alt="드로잉 로봇 이미지">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        드로잉 로봇 - Drawing Robot
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.09.06 ~ 2017.09.15</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	        <div class="col-12 col-sm-4 sub_contents_view_calendar_list">
	            <div class="border_box">
	                <div class="img_box">
	                    <div class="hidden_text_wrap">
	                        <div class="hidden_text_con">
	                            <div class="hidden_text">
	                                <a class="quick_btn" href="javascript:void(0)" data-for="sub_view_${paramVO.menuNo}v03">
	                                    바로가기
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                    <img src="/edu/images/bm/contents_list_img02.jpg" alt="Saltation: 도약">
	                </div>
	                <div class="text_box">
	                    <h5>
	                        Saltation: 도약
	                    </h5>
	                    <p class="h_data5">
	                        일자  :
	                        <span class="point0">2017.09.05 ~ 2017.09.06</span>
	                    </p>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</div>

<!-- 상세페이지 -->
<div class="sub_view" id="sub_view_${paramVO.menuNo}v01" style="display:none;">
	<jsp:include page="/WEB-INF/jsp/${paramVO.siteName}/cts/${paramVO.menuNo}v01.jsp" flush="true" />
</div>
<!-- //상세페이지 -->

<!-- 상세페이지 -->
<div class="sub_view" id="sub_view_${paramVO.menuNo}v02" style="display:none;">
	<jsp:include page="/WEB-INF/jsp/${paramVO.siteName}/cts/${paramVO.menuNo}v02.jsp" flush="true" />
</div>
<!-- //상세페이지 -->

<!-- 상세페이지 -->
<div class="sub_view" id="sub_view_${paramVO.menuNo}v03" style="display:none;">
	<jsp:include page="/WEB-INF/jsp/${paramVO.siteName}/cts/${paramVO.menuNo}v03.jsp" flush="true" />
</div>
<!-- //상세페이지 -->

<!-- 상세페이지 -->
<div class="sub_view" id="sub_view_${paramVO.menuNo}v04" style="display:none;">
	<jsp:include page="/WEB-INF/jsp/${paramVO.siteName}/cts/${paramVO.menuNo}v04.jsp" flush="true" />
</div>
<!-- //상세페이지 -->

<script>
$(function(){
	var selList = ".sub_contents_body.sub_board_wrap";
	var $listWrap = $(selList);
	var selClickView = ".sub_contents_view_calendar_list .quick_btn";
	var selClickList = ".ticketing_btn_wrap .btn_style_3.list";
	var selView = ".sub_view"; 
	
	
	var vewDateList0 = $(".view_date0 > li");
	var vewDateList1 = $(".view_date1 > li");
	var vewDateList2 = $(".view_date2 > li");
	var vewDateList3 = $(".view_date3 > li");
	
	
	var viewDateContents0 = $(".view_date_contents0.tab_contents");
	var viewDateContents1 = $(".view_date_contents1.tab_contents");
	var viewDateContents2 = $(".view_date_contents2.tab_contents");
	var viewDateContents3 = $(".view_date_contents3.tab_contents");
	
	
	vewDateList0.on('click', function(){
		var idx = vewDateList0.index(this);
		vewDateList0.removeClass('active');
		$(vewDateList0[idx]).addClass('active');
		
		viewDateContents0.removeClass("active");
		$(viewDateContents0[idx]).addClass("active");
	});
	
	vewDateList1.on('click', function(){
		var idx = vewDateList1.index(this);
		vewDateList1.removeClass('active');
		$(vewDateList1[idx]).addClass('active');
		
		viewDateContents1.removeClass("active");
		$(viewDateContents1[idx]).addClass("active");
	});
	
	vewDateList2.on('click', function(){
		var idx = vewDateList2.index(this);
		vewDateList2.removeClass('active');
		$(vewDateList2[idx]).addClass('active');
		
		viewDateContents2.removeClass("active");
		$(viewDateContents2[idx]).addClass("active");
	});
	
	vewDateList3.on('click', function(){
		var idx = vewDateList3.index(this);
		vewDateList3.removeClass('active');
		$(vewDateList3[idx]).addClass('active');
		
		viewDateContents3.removeClass("active");
		$(viewDateContents3[idx]).addClass("active");
	});
	
	
	
	$(selClickView).click(function(){
		var _targetId = $(this).attr("data-for");
		var $arrView = $(selView);
		$listWrap.hide();
		$arrView.hide();
		$("#"+_targetId).show();
	});
	
	$(selClickList).click(function(){
		var $arrView = $(selView);
		$arrView.hide();
		$listWrap.show();
	});
	
	if ( "<%= showViewNo %>" != "" && "<%= showViewNo %>" != null ){ // 주소로 상세보기 접근
		$("[data-for='sub_view_${paramVO.menuNo}v<%=showViewNo%>']").click();
	}
	
	
	
	
});
</script>