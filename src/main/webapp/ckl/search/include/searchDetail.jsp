<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

	<%
	String detailStyle = "display:none;";
	if(detailDisplay.equals("on")){  detailStyle = "display:block;";  }
	%>
	<fieldset class="bbs_bxSearch bgSch" style="<%=detailStyle%>">
	<form name="formDetail" id="ts_1_Form" method="post">
		<input type="hidden" name="searchCategory" value="<%=searchCategory%>" />
		<input type="hidden" name="searchQuery" value="<%=searchQuery%>" />
		<input type="hidden" name="researchQuery" value="<%=researchQuery%>" />
		<input type="hidden" name="allsearchQuery" value="<%=allsearchQuery%>" />
		<input type="hidden" name="detailDisplay" value="on" />
		<input type="hidden" name="kistepwhereSetStr" value="<%=kistepwhereSetStr%>" />
		<input type="hidden" name="orginwhereSetStr" value="<%=orginwhereSetStr%>" />
		<input type="hidden" name="attfilewhereSetStr" value="<%=attfilewhereSetStr%>" />
		
	
		<legend>통합검색 상세검색</legend>
		<div class="select" style="width:230px;margin-right:20px; z-index:21;"> <span class="ctrl"><span class="arrow"></span></span>
			<div class="myValue"></div>
			<ul class="iList" style="display: block;">
				<li>
					<input name="searchArea" id="csq0" class="option" type="radio" value="total" <%if(searchArea.equals("total")){%> checked="checked" <%}%> />
					<label for="csq0">검색영역 : 전체</label>
				</li>
				<li>
					<input name="searchArea" id="csq1" class="option" type="radio" value="title" <%if(searchArea.equals("title")){%> checked="checked" <%}%> />
					<label for="csq1">검색영역 : 제목</label>
				</li>
				<li>
					<input name="searchArea" id="csq2" class="option" type="radio" value="contents" <%if(searchArea.equals("contents")){%> checked="checked" <%}%> />
					<label for="csq2">검색영역 : 내용</label>
				</li>
				<li>
					<input name="searchArea" id="csq3" class="option" type="radio" value="orgin" <%if(searchArea.equals("orgin")){%> checked="checked" <%}%> />
					<label for="csq3">검색영역 : 출처기관</label>
				</li>
				<li>
					<input name="searchArea" id="csq4" class="option" type="radio" value="keyword" <%if(searchArea.equals("keyword")){%> checked="checked" <%}%> />
					<label for="csq4">검색영역 : 키워드</label>
				</li>
			</ul>
		</div>
		<input type="radio" name="searchPeriod" id="date1" value="total" <%if(searchPeriod.equals("total")){%> checked="checked" <%}%>  onclick="javascript:setPeriod('total');" />
		<label for="date1">전체기간</label>
		&nbsp;
		<input type="radio" name="searchPeriod" id="date2" value="week" <%if(searchPeriod.equals("week")){%> checked="checked" <%}%> onclick="javascript:setPeriod('week');"  />
		<label for="date2">최근 일주일</label>
		&nbsp;
		<input type="radio" name="searchPeriod" id="date3" value="month" <%if(searchPeriod.equals("month")){%> checked="checked" <%}%> onclick="javascript:setPeriod('month');" />
		<label for="date3">최근 1개월</label>
		&nbsp;
		<input type="radio" name="searchPeriod" id="date4" value="etc" <%if(searchPeriod.equals("etc")){%> checked="checked" <%}%> onclick="javascript:setPeriod('etc');" />
		<label for="date4">직접 선택</label>
		&nbsp;
		<div class="select fl" style="width:230px;margin-right:10px; z-index:20;"> <span class="ctrl"><span class="arrow"></span></span>
			<div class="myValue"></div>
			<ul class="iList" style="display: block;">
				<li>
					<input name="searchSort" id="dsort0" class="option" type="radio" value="weight"  <%if(searchSort.equals("weight")){%> checked="checked" <%}%>  />
					<label for="dsort0">검색정렬 : 중요도순</label>
				</li>
				<li>
					<input name="searchSort" id="dsort1" class="option" type="radio" value="date" <%if(searchSort.equals("date")){%> checked="checked" <%}%> />
					<label for="dsort1">검색정렬 : 최신순</label>
				</li>
			</ul>
		</div>
		<input type="text" class="w100" name="searchStartDate" id="sDate" title="조회 시작일" value="<%=searchStartDate%>" readonly="readonly" />
		<a style="padding-left:3px;" href="../../common/calendarPop/calendarPop.jsp?div=sDate&amp;pattern=YYYYMMDD" onclick="window.open(this.href, 'popwin', 'left=400,top=200,width=260,height=270'); return false;" target="_blank" title="새창열림"><img src="<%=ImgUrl%>/ckl/images/icon/ico_cal.gif" alt="조회 시작일 달력" /></a> &nbsp; ~  &nbsp;
		<input type="text" class="w100" name="searchEndDate" id="eDate" title="조회 종료일" value="<%=searchEndDate%>" readonly="readonly" />
		<a style="padding-left:3px;" href="../../common/calendarPop/calendarPop.jsp?div=eDate&amp;pattern=YYYYMMDD" onclick="window.open(this.href, 'popwin', 'left=400,top=200,width=260,height=270'); return false;" target="_blank" title="새창열림"><img src="<%=ImgUrl%>/ckl/images/icon/ico_cal.gif" alt="조회 종료일 달력" /></a> <a href="javascript:goDetailSearch();" ><img src="<%=ImgUrl%>/ckl/images/common/btn_result.gif" alt="검색결과보기" /></a> <span class="fr close"><a href=""><img src="<%=ImgUrl%>/ckl/images/icon/btn_close.gif" alt="닫기" /></a></span>
	</form>
	</fieldset>