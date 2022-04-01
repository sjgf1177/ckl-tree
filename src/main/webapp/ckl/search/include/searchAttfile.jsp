<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%if(attfile_TotalSize > 0 ){%>
		<%if(searchCategory.equals("total")){%>
<h5 class="sch_h5 sch_violet">첨부파일(검색결과 <%=formatter.format(Long.parseLong(Integer.toString(attfile_TotalSize))) %>건) <span class="sch_more"> <a href="javascript:goCategory('attfile');" > <img src="<%=ImgUrl%>/ckl/images/common/sch_btn_more_vio.gif" alt="첨부파일 더보기"> </a> </span></h5>
	<%}else{%>

<div class="sch_h5 sch_violet">
<h5>첨부파일(검색결과 <%=formatter.format(Long.parseLong(Integer.toString(attfile_TotalSize))) %>건)	</h5>
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

<ul class="list_sch">
	<%
	for (int i=0; i < attfile_RealSize; i++) {
		for(int k=0 ; k < attfile_result.getNumField() ; k++){

			selectFieldTITLE = new String(attfile_getselectSet[k].getField()); //선택할 필드
			if(selectFieldTITLE.equals("ORIGNL_FILE_NM")){
				ORIGNL_FILE_NM = new String(attfile_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("ATT_CN")){
				ATT_CN = new String(attfile_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("ATT_URL")){
				ATT_URL = new String(attfile_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("NTT_SJ")){
				NTT_SJ = new String(attfile_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("NTT_URL")){
				NTT_URL = new String(attfile_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("REG_DATE")){
				REG_DATE = new String(attfile_result.getResult(i,k));
			}else if(selectFieldTITLE.equals("BBS_NM")){
				BBS_NM = new String(attfile_result.getResult(i,k));
			}
		}	
		String regdate = REG_DATE;
		if(!regdate.equals("")){ 
			regdate = REG_DATE.substring(0,4) + "." + REG_DATE.substring(4,6) + "." + REG_DATE.substring(6,8); 
		}
	%>
	<li class="mb10">
		<dl>
			<dt> <a href="<%=ATT_URL%>" target="_blank" title="새창열림"><img src="<%=ImgUrl%>/ckl/images/icon/ico_hwp.jpg" width="29" height="24"  alt=""/><%=ORIGNL_FILE_NM%> <span class="newwin"></span></a> <%if(!regdate.equals("")){%>- <%=regdate%><%}%></dt>
			<dd><%=ATT_CN%> </dd>
			<dd>
				<ul class="list_page">
					<li>[<%=BBS_NM%>] | 원게시물보기 : <a href="<%=ImgUrl%><%=NTT_URL%>" class="link1"><%=NTT_SJ%></a></li>
				</ul>
			</dd>
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
<h5 class="sch_h5 sch_none"> 첨부파일(검색결과가 존재하지 않습니다) </h5>
<!-- //검색의 결과 값이 없을 경우 -->
<%}%>