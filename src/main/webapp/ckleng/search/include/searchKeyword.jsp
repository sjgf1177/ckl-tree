<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%
if(hot_TotalSize > 0) {
%>
	<div class="keyword1">
		<h3>자주 찾는 <strong>키워드 [Keyword]</strong></h3>
		<ol>
		<%
		for (int i=0; i < hot_RealSize; i++) {
			for(int k=0 ; k < hot_result.getNumField() ; k++){

				selectFieldTITLE = new String(hot_getselectSet[k].getField()); //선택할 필드
				if(selectFieldTITLE.equals("KEYWORD")){
					KEYWORD = new String(hot_result.getResult(i,k));
				}else if(selectFieldTITLE.equals("RANKING")){
					RANKING = new String(hot_result.getResult(i,k));
				}else if(selectFieldTITLE.equals("PREV_RANK")){
					PREV_RANK = new String(hot_result.getResult(i,k));
				}
			}
			String keywordStr = KEYWORD;
			String rankImg = "";
			String rankAlt = "";
			int rankInt = Integer.parseInt(RANKING);
			int prevrankInt = Integer.parseInt(PREV_RANK);

			if(KEYWORD.length() > 10){ keywordStr = KEYWORD.substring(0,9)+".."; }
			if(PREV_RANK.equals("0")){
				rankImg = "new";
				rankAlt = "new";
			}else if(rankInt == prevrankInt){
				rankImg = "same";
				rankAlt = "변동없음";
			}else if(rankInt < prevrankInt){
				rankImg = "down";
				rankAlt = "하향";
			}else if(rankInt > prevrankInt){
				rankImg = "up";
				rankAlt = "상향";
			}
			
		%>
			<%if(i==0){%>
			<li class="key0<%=i+1%>"><span class="<%=rankImg%>"><%=rankAlt%></span> <strong><a href="javascript:goDirectSearch('<%=KEYWORD%>');" title="<%=KEYWORD%>"><%=keywordStr%></a></strong></li>
			<%}else{%>
			<li class="key0<%=i+1%>"><span class="<%=rankImg%>"><%=rankAlt%></span> <a href="javascript:goDirectSearch('<%=KEYWORD%>');" title="<%=KEYWORD%>"><%=keywordStr%></a></li>
			<%}%>
		<%}%>
		</ol>
	</div>
<%
}
%>