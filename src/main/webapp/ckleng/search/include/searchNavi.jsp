<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%    
    //페이지 네비게이션===========================================================================================
    final int DISPLAYSIZE5  = 5;
    final int DISPLAYSIZE10 = 10;
    final int DISPLAYSIZE15 = 15;

    int rowsPerPage=0, totalPage=0, totalRows=0, currentPage=0, startPosition=0, numOfLinkIndex=0, startIndex=0, endIndex=0;
    String labelForFirst, labelForPrev, labelFor10Prev,  labelForNext, labelFor10Next, labelForLast, labelForIndex;
    String destination = "#";

    rowsPerPage = 10; // 페이지당 출력되는 항목 수
    totalPage = 0; // 검색 결과에 의해 나타날 수 있는 총 페이지 수
    totalRows = 0; // 검색 결과 총 갯수

    totalRows = pagenavi_TotalSize;
    currentPage     = InPageNumber;

	numOfLinkIndex  = DISPLAYSIZE10;

    totalPage = ((totalRows - 1) / rowsPerPage) + 1;
    int prevPage = (int)Math.floor((currentPage - 1) / numOfLinkIndex) * numOfLinkIndex;
    int nextPage = prevPage + numOfLinkIndex + 1;

	labelForFirst = "<li class=\"img\"><a href=\"" + destination + "\" ><span class=\"pagell\"><span>처음목록으로 이동</span></span></a></li>";	
    labelFor10Prev ="<li class=\"img\"><a href=\"" + destination + "\"><span class=\"pagel\"><span>이전 10페이지 목록으로 이동</span></span></a></li>";
    labelForPrev  = "<a href=\"" + destination + "\" class=\"prev\" ><img src=\"/images/board/btn_prev.gif\" alt=\"게시물 이전 페이지\" /></A>";
    labelForNext  = "<a href=\"" + destination + "\" class=\"next\" ><img src=\"/images/board/btn_next.gif\" alt=\"게시물 다음 페이지\" /></A>";
    labelFor10Next = "<li class=\"img\"><a href=\"" + destination + "\" ><span class=\"pagerr\"><span>다음 10페이지 목록으로 이동</span></span></a></li>";
    labelForLast  = "<li class=\"img\"><a href=\"" + destination + "\" ><span class=\"pager\"><span>마지막 목록으로 이동</span></span></a></li>";

	//처음 목록
    if(currentPage > 1){
    	labelForFirst = "<li class=\"img\"><a href=\"" + destination + "\" onClick=\"javascript:pageLink('1');\"><span class=\"pagell\"><span>처음목록으로 이동</span></span></a></li>";
    }
    //10페이지 전
    if (prevPage > 0){ 
        labelFor10Prev = "<li class=\"img\"><a href=\"" + destination + "\" onClick=\"javascript:pageLink('" + Integer.toString(prevPage) + "');\"><span class=\"pagel\"><span>이전 10페이지 목록으로 이동</span></span></a></li>";
    }
    //이전 페이지 
    if(currentPage > 1){
    	labelForPrev = "<a href=\"" + destination + "\" class=\"prev\" onClick=\"javascript:pageLink('" + (currentPage-1)+ "');\"><img src=\"/images/board/btn_prev.gif\" alt=\"게시물 이전 페이지\" /></a>";	
    }

    //다음 블록
    if (totalPage >= nextPage){
        labelFor10Next = "<li class=\"img\"><a href=\"" + destination + "\" onClick=\"javascript:pageLink('" + Integer.toString(nextPage)+ "');\"  ><span class=\"pagerr\"><span>다음 10페이지 목록으로 이동</span></span></a></li>";
    }
    //마지막 목록
    if(currentPage < totalPage){
        labelForNext = "<a href=\"" + destination + "\" class=\"next\" onClick=\"javascript:pageLink('" + (currentPage+1) + "');\"><img src=\"/images/board/btn_next.gif\" alt=\"게시물 다음 페이지\" /></A>";
        labelForLast = "<li class=\"img\"><a href=\"" + destination + "\" onClick=\"javascript:pageLink('" + totalPage + "');\"><span class=\"pager\"><span>마지막 목록으로 이동</span></span></a></li>"; 	
    }
    
    
    startIndex = ((currentPage - 1) / numOfLinkIndex) * numOfLinkIndex + 1;
    labelForIndex = "";
    
    //현재 블록
    for(int i = 1 + prevPage; i < nextPage && i <= totalPage; i++){
        if (i == currentPage){ 
            labelForIndex += "<li><em title=\"현재페이지\">" +Integer.toString(i) + "</em></li>";
        }else{ 
            labelForIndex += "<li><a href=\"javascript:pageLink('" + Integer.toString(i)+ "');\" >"+Integer.toString(i)+ "</a></li>";
        }
    }
    //페이지 네비게이션===========================================================================================
%>

<div class="paging" <%if(searchCategory.equals("orgin") || searchCategory.equals("attfile")){%> style="margin-top:15px;" <%}%> >
	<ol>
		<%=labelForFirst%>
		<%=labelFor10Prev%>
		<%=labelForIndex%>
		<%=labelFor10Next%>
		<%=labelForLast%>
	</ol>
</div>