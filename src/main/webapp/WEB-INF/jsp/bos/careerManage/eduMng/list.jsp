<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
//<![CDATA[
	var modal = document.getElementById("eduMngPop");
	var span = document.getElementsByClassName("close")[0];
	
	$(document).ready(function(){
		$("#searchCnd").on("change", function(){
			var searchCnd = $("#searchCnd").val();
			if (searchCnd == "01"){
				$("#eduNm").show();
				$("#eduCode").hide();
			} else if (searchCnd == "02") {
				$("#eduNm").hide();
				$("#eduCode").show();
			}
		});
		
		$("#popClose").on("click", function(){
			$("#eduMngPop").css("display", "none");
		});
		
		$("#insertEduCode").on("change keyup paste", function(){
			$("#duplbtn").css("display", "inline-block");
			$("#eduCodeDuplVal").val("");
		});
		
	});
	
	function insertPop (){
		$("#modal_btnbox").empty();
		$("#insertEduCode").val("");
		$("#insertEduNm").val("");
		$("#eduCodeDuplVal").val("");
		$("#eduMngInsertForm").prop("action", "/bos/careerManage/eduMng/insert.do?menuNo=100244");
		$("#insertUseAt").prop("selectedIndex", 0);
		$("#modal_btnbox").html("<a class='btn btn-info' href='javaScript:insert();'><span>등록</span></a>");
		$("#duplbtn").css("display", "inline-block");
		$("#eduMngPop").css("display", "block");
	}
	
	function insert(){
		var checkVal = check();
		if(checkVal){
			$("#eduMngInsertForm").submit();
		} else {return false;}

	}
	
	function duplEduCode(){
		var insertEduCode = $("#insertEduCode").val();
		$.ajax({
			type:"POST",
			url:"/bos/careerManage/eduMng/ajaxEduCodeDupl.json?menuNo=<c:out value='${param.menuNo }' />",
			data:{"eduCode":insertEduCode},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				if (data.resultCnt > 0){
					alert("이미 사용중인 사업코드 입니다. 다시 확인하여 주십시오.");
					$("#insertEduCode").focus();
					$("#eduCodeDuplVal").val("");
				} else {
					alert("사용가능한 사업코드입니다. 계속 진행하여 주십시오.");
					$("#insertEduNm").focus();
					$("#eduCodeDuplVal").val(true);
				}
				
			},
			error:function(){
				alert("서버와 통신 실패");
			}
		});
	}
	
	function check (){
		var insertEduCode = $("#insertEduCode").val();
		var insertEduNm = $("#insertEduNm").val();
		var eduCodeDuplVal = $("#eduCodeDuplVal").val();
		var insertUseAt = $("#insertUseAt").val();
		
		if (!insertEduCode){
			alert("사업코드를 입력해주십시오.");
			$("#insertEduCode").focus();
			return false;
		}
		if (!insertEduNm){
			alert("사업명을 입력해주십시오.");
			$("#insertEduNm").focus();
			return false;
		}
		if (!eduCodeDuplVal){
			alert("중복확인을 해주십시오.");
			$("#duplbtn").focus();
			return false;
		}
		if (!insertUseAt){
			alert("사용여부를 확인하여주십시오.");
			$("#insertUseAt").focus();
			return false;
		}
		return true;
	}
	
	function detailPop(eduSn){
		$("#modal_btnbox").empty();
		$("#modal_btnbox").html("<a class='btn btn-info' href='javaScript:update(" + eduSn + ");'><span>수정</span></a>");
		$("#duplbtn").css("display", "none");
		
		$("#eduMngPop").css("display", "block");
		$.ajax({
			type:"POST",
			url:"/bos/careerManage/eduMng/ajaxEduDetail.json?menuNo=<c:out value='${param.menuNo }' />",
			data:{"eduSn":eduSn},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				$("#insertEduCode").val(data.result.eduCode);
				$("#insertEduNm").val(data.result.eduNm);
				$("#eduMngInsertForm").prop("action", "/bos/careerManage/eduMng/update.do?menuNo=100244");
				$("#insertUseAt").val(data.result.useAt).prop("selected", true);
			},
			error:function(){
				alert("서버와 통신 실패");
			}
		});
		
	}
	
	function update(eduSn){
		$("#eduMngInsertForm").append("<input type='hiden' name='eduSn' value='" + eduSn + "'/>");
		$("#eduMngInsertForm").submit();
	}
	
	function del(eduSn, eduNm){
		var del_confirm = confirm("해당사업(" + eduNm + ")을 삭제하시겠습니까?");
		if (del_confirm){
			$.ajax({
				type:"POST",
				url:"/bos/careerManage/eduMng/ajaxEduDelete.json?menuNo=<c:out value='${param.menuNo }' />",
				data:{"eduSn":eduSn},
				cache:false,
				async:false,
				dataType:"JSON",
				success:function(data){
					location.reload(true);
				},
				error:function(){
					alert("서버와 통신 실패");
				}
			});
		}
	}
//]]>
</script>

<form id="eduMngListForm" name="eduMngListForm" method="get" action="/bos/careerManage/eduMng/list.do?menuNo=100244" class="form-inline">
	<input type="hidden" name="menuNo" id="menuNo" value="<c:out value="${param.menuNo }" />" />
	<fieldset>
		<legend></legend>
		<div class="bdView mb0">
			<table class="table table-bordered">
				<caption></caption>
				<colgroup>
					<col width="20%"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" ><label for="searchCnd">검색구분</label></th>
						<td>
							<select name="searchCnd" id="searchCnd">
								<option value="01" <c:if test="${ param.searchCnd eq '01' }">selected</c:if>>사업명</option>
								<option value="02" <c:if test="${ param.searchCnd eq '02' }">selected</c:if>>사업코드</option>
							</select>
							<input type="text" name="eduNm" id="eduNm" value="<c:out value='${param.eduNm}'/>" style="display:inline-block;"/>
							<input type="text" name="eduCode" id="eduCode" value="<c:out value='${param.eduCode}'/>" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<th scope="row" ><label for="useAt">사용여부</label></th>
						<td>
							<select name="useAt" id="useAt">
								<option value="">전체</option>
								<option value="Y" <c:if test="${param.useAt eq 'Y'}">selected</c:if>>사용</option>
								<option value="N" <c:if test="${param.useAt eq 'N'}">selected</c:if>>미사용</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btnSet tar">
			<input type="submit" class="btn btn-primary" value="검색" />
		</div>
	</fieldset>
	
	<hr />

	<div class="row mt10 mb5">
		<div class="col-md-6"> 총 : <strong class="text-danger"><c:out value="${resultCnt }" /></strong>건 | <strong class="text-danger"><c:out value="${paramVO.pageIndex }" /> / <c:out value="${totalPage }" /></strong> Page </div>
		<div class="col-md-6 tar">
			<label for="pageUnit">표시수 :</label>
			<select name="pageUnit" id="pageUnit">
				<option value="10" <c:if test="${paramVO.pageUnit eq 10 }">selected="selected"</c:if>>10개</option>
				<option value="20" <c:if test="${paramVO.pageUnit eq 20 }">selected="selected"</c:if>>20개</option>
				<option value="30" <c:if test="${paramVO.pageUnit eq 30 }">selected="selected"</c:if>>30개</option>
				<option value="40" <c:if test="${paramVO.pageUnit eq 40 }">selected="selected"</c:if>>40개</option>
				<option value="50" <c:if test="${paramVO.pageUnit eq 50 }">selected="selected"</c:if>>50개</option>
			</select>
		</div>
	</div>
</form>

<div class="bdList">
	<table class="table table-bordered tac">
		<colgroup>
			<col width="5%"/>
			<col width="12%"/>
			<col />
			<col width="12%"/>
			<col width="15%"/>
			<col width="12%"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="row" >번호</th>
				<th scope="row" >사업코드</th>
				<th scope="row" >사업명</th>
				<th scope="row" >사용여부</th>
				<th scope="row" >등록일</th>
				<th scope="row" >삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td><c:out value="${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1)) }" /></td>
					<td><c:out value="${result.eduCode }" /></td>
					<td><a href="javaScript:detailPop(<c:out value='${result.eduSn}' />);"><c:out value="${result.eduNm }" /></a></td>
					
					<td><c:out value="${result.useAt eq 'Y' ? '사용' : '미사용'}" /></td>
					<td><c:out value="${result.regDate}" /></td>
					<td><a href="javaScript:del(<c:out value='${result.eduSn}' />, '<c:out value="${result.eduNm }" />')" class="btn btn-sm btn-default">삭제</a></td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
				<tr><td colspan="7">- 검색 결과가 없습니다 -</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="btn_set"><a class="btn btn-primary" href="javaScript:insertPop();"><span>등록</span></a></div>

<!-- paging -->
<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
		${pageNav}
	</div><!-- paging end //-->
</c:if>
<!-- //paging -->

<div id="eduMngPop" class="modal">
	<div class="modal-header">
		<span id="popClose" class="close">&times;</span>
		<p>사업등록</p>
	</div>
	<div class="modal-content">
		<div class="bdView mb0">
			<form id="eduMngInsertForm" name="eduMngInsertForm" method="post" action="">
				<input type="hidden" id="eduCodeDuplVal" value=""/>
				<table class="table table-bordered">
					<caption></caption>
					<colgroup>
						<col width="20%"/>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" ><label for="insertEduCode">사업코드</label></th>
							<td>
								<input type="text" name="insertEduCode" id="insertEduCode">
								<a id="duplbtn" class='btn btn-sm btn-default' href='javaScript:duplEduCode();'><span>중복확인</span></a>
							</td>
						</tr>
						<tr>
							<th scope="row" ><label for="insertEduNm">사업영</label></th>
							<td><input type="text" name="insertEduNm" id="insertEduNm"></td>
						</tr>
						<tr>
							<th scope="row" ><label for="insertUseAt">사용여부</label></th>
							<td>
								<select name="insertUseAt" id="insertUseAt">
									<option value="">선택</option>
									<option value="Y">사용</option>
									<option value="N">미사용</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</form>		
		</div>
		<div id="modal_btnbox"></div>
	</div>
</div>

<style>
/* The Modal (background) */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  padding-top: 10%;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}


.modal-header {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 30%;
	font-size: 18px;
	font-weight: bold;
}
/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 30%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	position:relative;
	top: -5px;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.modal input{width:300px; margin-right:5px; padding-left:5px;}
.modal label{margin-top:6px;}
.modal #modal_btnbox{text-align: center; margin-top: 5px;}
#duplbtn{display:none;}
</style>
