<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<link href="/bos/css/board.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/js/miya_validator.js"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript">
	
	function modifyEmstJob(_emstCode){
		if(!$("#emstJob"+_emstCode).val()){
			alert("업무를 입력하세요.");
			return;
		}
		$.post( 
			"/bos/member/modifyEmstJob.do",
			{emstCode:_emstCode, emstJob:$("#emstJob"+_emstCode).val()},
			function(data){
				var jdata = data.result;
				if( jdata == "0" ){
					alert("상태변경에 실패하였습니다.");
				}
				else{
					alert("성공적으로 수정되였습니다..");
				}
			}
		);
	}

	function checkForm(form)
	{			
		var v = new MiyaValidator(form);
	    v.add("searchType", {
	        required: true
	    });
		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		} 
		else
		{
			return true;
		}
	}

</script>

				<h3 class="tit_03">직원관리</h3>
				
<fieldset>
	<legend>게시판검색</legend>
		<form name="frm" method="post" action="/bos/member/selectEmpList.do">
		<div class="bbs_search">
			<div class="search_left">
				<label for="selectquarter" class="blind">소속선택</label>				
					<select name="brnhCode" class="vam" id="selectquarter" title="항목선택">
						<option value="">소속선택</option> 
						<c:forEach var="brnh" items="${brnhList}" varStatus="status">
					   <option value="${brnh.brnhCode}" <c:if test="${param.brnhCode == brnh.brnhCode}">selected="selected"</c:if> >${brnh.brnhName}</option>
						</c:forEach>
					</select>
			</div>
			<div class="search_right">
				<label for="name1"><span>검색어</span></label>
					<select id="name1" name="searchType" class="vam">
						<option value="">선택</option>
						<option value="0" <c:if test="${param.searchType == 0}">selected</c:if>>성명</option>
						<option value="1" <c:if test="${param.searchType == 1}">selected</c:if>>담당업무</option>
					</select>
					<input type="text" class="board1 vam" style="width:125px;" id="name2" name="searchTxt" value="${param.searchTxt}" />
					<label for="input2">
						<input id="input2" class="vam" type="image" alt="검색" src="/bos/images/common/btn_search.gif" />
					</label>
			</div>
		</div>
		</form>
</fieldset>

				
<!-- board list start -->
<form name="frm2" method="post">
<table class="list_type01" summary="민원업무 및 담당자를 검색하여 소속과, 성명, 전화번호, 담당업무를 검색결과로 보실 수 있습니다">
	<caption>민원업무 및 담당자를 검색</caption>
	<colgroup>
		<col width="8%" />
		<col width="10%" />
		<col width="8%" />
		<col width="9%" />
		<col width="12%" />
		<col width="15%" />
		<col width="*" />
		<col width="8%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" class="fir">번호</th>
			<th scope="col">이름</th>
			<th scope="col">직책</th>
			<th scope="col">소속</th>
			<th scope="col">부서</th>
			<th scope="col">연락처</th>
			<th scope="col">담당업무</th>
			<th scope="col">수정</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${fn:length(resultList) > 0}" >
		<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}">  
		<tr>
			<td>${zvl.totCnt - (zvl.pageIndex-1)*zvl.pageUnit - x}</td>
			<td>${resultList[x].emstName}</td>
			<td>${resultList[x].jcheName}</td>
			<td>${resultList[x].brnhName}</td>
			<td>${resultList[x].deptFull}</td>
			<td>${resultList[x].emstHtel}</td>
			<td><input type="text" name="emstJob" id="emstJob${resultList[x].emstCode}" style="width:250px" class="board1" value="${resultList[x].emstJob}" /></td>
			<td><input type="button" name="btn" id="btn${resultList[x].emstCode}" value="수정" onclick="modifyEmstJob('${resultList[x].emstCode}');"/></td>
		</tr>
		</c:forEach>
		</c:if>		
		<c:if test="${fn:length(resultList) == 0}" >
		<tr><td colspan="8">데이터가없습니다.</td></tr>
		</c:if>		
	</tbody>
</table>
<!-- board list end //-->
</form>

<c:if test="${fn:length(resultList) > 0}" >
<div class="paging">
	<div class="paging_con">${pageNav}</div>
</div><!-- paging end //-->
</c:if>

<c:catch var="catchException">
	<jsp:include page="/WEB-INF/jsp/bos/share/printPath.jsp" flush="true" />
</c:catch>
</body>
</html>