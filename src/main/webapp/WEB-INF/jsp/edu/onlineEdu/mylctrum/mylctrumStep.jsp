<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="stepInline">
	<ul>
		<li <c:if test="${param.p_menuTab eq 'list' or param.p_menuTab eq '' }">class="on"</c:if>><a href="javascript:void(0);" onclick="fnCmdList('list'); return false;"><span>학습목록</span></a></li>
		<li <c:if test="${param.p_menuTab eq 'listDibs' }">class="on"</c:if>><a href="javascript:void(0);" onclick="fnCmdList('listDibs'); return false;"><span>찜목록</span></a></li>
		<li <c:if test="${param.p_menuTab eq 'listRecomendLrnCours' }">class="on"</c:if>><a href="javascript:void(0);" onclick="fnCmdList('listRecomendLrnCours'); return false;"><span>추천학습경로</span></a></li>
	</ul>
</div>


<script type="text/javascript">
//<![CDATA[
           
	//학습, 찜목록, 추천학습경로 변경
	function fnCmdList(str){
		
		$("#p_menuTab").val(str);
		$("#frm").attr({
					action:"/edu/onlineEdu/mylctrum/"+str+".do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
           
           
//]]>
</script>