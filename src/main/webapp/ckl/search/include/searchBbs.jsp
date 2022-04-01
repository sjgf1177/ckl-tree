<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%if(bbs_TotalSize > 0 ){%>
	<%if(searchCategory.equals("total")){%>
<h5 class="sch_h5">게시물(검색결과 <%=formatter.format(Long.parseLong(Integer.toString(bbs_TotalSize))) %>건) <span class="sch_more"> <a href="javascript:goCategory('bbs');" > <img src="<%=ImgUrl%>/ckl/images/common/sch_btn_more.gif" alt="게시물 더보기"> </a> </span> </h5>
	<%}else{%>

<div class="sch_h5">
<h5>게시물(검색결과 <%=formatter.format(Long.parseLong(Integer.toString(bbs_TotalSize))) %>건)	</h5>
	<div class="sch_more">
		<label for="seq_Opt_0">
			<input type="radio" name="seq_Opt" value="date" id="seq_Opt_0" <%if(searchSort.equals("date")){%> checked="checked" <%}%> onclick="javascript:goSort('date');" />
			최신순</label>
		<label for="seq_Opt_1">
			<input type="radio" name="seq_Opt" value="weight" id="seq_Opt_1" <%if(searchSort.equals("weight")){%> checked="checked" <%}%> onclick="javascript:goSort('weight');" />
			중요도순</label>
	</div>
</div>
<h5 class="sch_h5"><span class="sch_more"> </span> </h5>
	<%}%>

<ul class="list_style list_style4">
	<%
	for (int i=0; i < bbs_RealSize; i++) {
		for(int k=0 ; k < bbs_result.getNumField() ; k++){

			selectFieldTITLE = new String(bbs_getselectSet[k].getField()); //선택할 필드
			if(selectFieldTITLE.equals("NTT_CLS")){
				NTT_CLS = new String(bbs_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("NTT_SJ")){
				NTT_SJ = new String(bbs_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("NTT_CN")){
				NTT_CN = new String(bbs_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("NTT_ORGIN")){
				NTT_ORGIN = new String(bbs_result.getResult(i,k));	
			}else if(selectFieldTITLE.equals("NTT_URL")){
				NTT_URL = new String(bbs_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("REG_DATE")){
				REG_DATE = new String(bbs_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("BBS_NM")){
				BBS_NM = new String(bbs_result.getResult(i,k));
			}
		}	
		String regdate = REG_DATE;
		if(!regdate.equals("")){ 
			regdate = REG_DATE.substring(0,4) + "." + REG_DATE.substring(4,6) + "." + REG_DATE.substring(6,8); 
		}
	%>
	<li>
		<dl>
			<dt> <a href="<%=ImgUrl%><%=NTT_URL%>" class="link" target="_blank" title="새창열림"><span class="fc_blue">[<%=NTT_CLS%>/<%=BBS_NM%>]</span> <%=NTT_SJ%> <span class="newwin"></span></a> <%if(!regdate.equals("")){%>- <%=regdate%><%}%></dt>
			<dd><%=NTT_CN%></dd>
			<dd class="link"><%=ImgUrl%><%=NTT_URL%></dd>
		</dl>
	</li>
	<%
	}
	%>
</ul>

<%if(!searchCategory.equals("total")){%>
	<%@include file="searchNavi.jsp" %>
<%}%>

<%}else{%>

<!-- 검색의 결과 값이 없을 경우 -->
<h5 class="sch_h5 sch_none"> 게시물(검색결과가 존재하지 않습니다) </h5>
<!-- //검색의 결과 값이 없을 경우 -->
<%}%>