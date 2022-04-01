
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<%
		int year = egovframework.com.utl.DateUtil.getYear();
		pageContext.setAttribute("year", year);
%>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/job/${paramVO.programId}/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>
<%-- 데이터가 없을때 1 메인 테이블 키값으로 서브 테이블 돌기위한 출력 있을시 데이터 있는만큼 --%>
<c:set var="resultCnt" value="${fn:length(subResults) > 0 ? fn:length(subResults) : 1 }"/>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">

	var codeIdVal = "COM083";
	var ctgrySe1Val = "<c:out value="${ result.ctgrySe1 }" />";
	var ctgrySe2Val = "<c:out value="${ result.ctgrySe2 }" />";

	$(function(){
		//init
		getCodeList("ctgrySe1", codeIdVal, "0", 1, ctgrySe1Val);

		//지역선택 event
		$("#ctgrySe1").change(function() {
			getCodeList("ctgrySe2", codeIdVal, $(this).val(), 2);

		});

	});

	// 공통 코드목록 화면처리
	function getCodeList(elemntId, codeId, upperCode, depth, code) {
		var $obj = $("#"+ elemntId);
		var url = "/cmmn/cmmncode/codeListJson.do";
		var params = {
			codeId : codeId,
			upperCode : upperCode
		};
		$.get(url, params, function(data) {
			if (data) {
				$obj.empty();
				if (depth == 1) $("<option>").text("카테고리구분1 선택").attr("value","").appendTo($obj);
				else if (depth == 2) $("<option>").text("카테고리구분2 선택").attr("value","").appendTo($obj);
				$.each(data.list, function(key,item) {
					var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
					if (code == item.code) $codeItem.attr("selected",true);
					$codeItem.appendTo($obj);
				});

				if ("ctgrySe1" == elemntId) {
					getCodeList("ctgrySe2", codeIdVal, $("#ctgrySe1").val(), 2, ctgrySe2Val);
				}
				else if ("ctgrySe2" == elemntId && "" == upperCode) {
// 					$("<option>").text("카테고리구분1 선택").attr("value","").appendTo($("#ctgrySe1").empty());
// 					$("<option>").text("카테고리구분2 선택").attr("value","").appendTo($("#ctgrySe2").empty());
				}
			}
		},"json");
	}


	function addForm() {
		cntNum = $("#resultCnt").val();
		$("#resultCnt").val(parseInt(cntNum)+1);
		var addForms =
			  "<tr class='subSj"+cntNum+"'>"
			+ 	"<th scope='row'> <label for='subSj'>서브 제목 </label> </th>"
			+ 		"<td>"
			+ 			"<input type='text' title='서브제목' name='subSj'  class='w500' value='' />"
			+            "<a href='javascript:selectDelForm("+cntNum+");' class='btn btn-primary'><span>삭제</span></a>"
			+ 		"</td>"
			+ "</tr>"
			+ "<tr class='subCn"+cntNum+"'>"
			+ 	"<th scope='row'> <label for='subCn'>내용 </label> </th>"
			+ "<td>"
			+	"<span style='color:red;'> * 서브글내용  * </span> <br />"
			+ 	"<textarea  type='text' title='서브내용' name='subCn' cols='140' rows='5'  class='textarea' value='' /> "
			+ "</td>"
			+ "</tr>"
		 $('#board tbody:last').append(addForms);

	}


	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		v.add("dicarySj", {
			required : true
		});
		v.add("ctgrySe1", {
			required : true
		});
		v.add("ctgrySe2", {
			required : true

		});

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		var flag = false;
		$("input[name=subSj]").each(function(n) {

			var $content = $(this).closest("tr").next("tr").find("textarea[name=subCn]");
			if ($(this).val() == "") {
				alert("서브 제목을 입력해 주세요.");
				$(this).focus();
				flag = true;
				return false;
			}
			else if ($content.val() == "") {
				alert("서브 내용을 입력해 주세요.");
				$content.focus();
				flag = true;
				return false
			}
		});

		if (flag) return;


		if (!confirm('등록하시겠습니까?')) {
			d
			return;
		}
		form.submit();

	}


	function del() {
		var form = $("#board")[0];
		form.action = "/bos/job/${paramVO.programId}/delete.do";
		form.submit();

	}
	function selectDel(dicarySn, cnSn, sn) {
		if (!confirm('삭제하시겠습니까?')) {
			return;
		}

		var dicarySn = dicarySn;
		var cnSn = cnSn;
		$.ajax({
			url : '/bos/job/${paramVO.programId}/selectDelete.json',
			dataType : 'json',
			data : {
				"dicarySn" : dicarySn,
				"cnSn" : cnSn
			},
			success : function(data) {
				if (data.resultCode == 'success') {
					alert(data.msg);
					$(".subSj" + sn).remove();
					$(".subCn" + sn).remove();
				} else {
					alert(data.msg);
				}
			}
		});

	}
	function selectDelForm(sn) {
		$(".subSj" + sn).remove();
		$(".subCn" + sn).remove();

	}
</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>
<div id="content">
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" id="resultCnt" name="resultCnt" value="${resultCnt}">
	<input type="hidden" name="cnSn" value="${result.cnSn}" >
	<input type="hidden" name="frstRegisterId" value="<c:out value="frstRegisterId" />">
	<input type="hidden" name=lastUpdusrId value="<c:out value="lastUpdusrId" />">
	<input type="hidden" name="dicarySn" value="${result.dicarySn}" >

<div class="bdView">
	<table summary="<c:if test="${roleSuper eq 'Y'}">게시구분,게시기간,</c:if>제목,담당부서,내용<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if> 포함">
		<caption>${masterVO.bbsNm} - ${empty result ? '쓰기' : '수정'}</caption>
		<colgroup>
			<col style="width:15%"/>
			<col />
		</colgroup>
		<tbody>

		<tr>
			<th scope="row"><label for="ctgrySe">카테고리 구분</label></th>
			<td>
				<select name="ctgrySe1" id="ctgrySe1">
					<option value="">카테고리구분1 선택</option>

				</select>
				<select name="ctgrySe2" id="ctgrySe2">
						<option value="">카테고리구분2 선택</option>
				</select>

			</td>
		</tr>


		<tr>
			<th scope="row"><label for="dicarySj">메인 제목</label></th>
			<td>
				<input type="text" name="dicarySj" id="dicarySj" class="w500" value="${result.dicarySj}" />
			</td>
		</tr>



		<tr>
			<th colspan="4">서브 제목 하위 메뉴 </th>
		</tr>
		<c:forEach var="x" begin="0" end="${resultCnt-1}" >
			<tr class='subSj${x}'>
				<th scope="row"><label for="subSj">서브 제목</label></th>
				<td>
					<input type="text" name="subSj" title='서브제목' class="w500" value="${subResults[x].subSj}" />
					<c:if test="${x gt 0}">
					 <a href="javascript:selectDel(<c:out value='${subResults[x].dicarySn }'/>,<c:out value='${subResults[x].cnSn }'/>,${x});" class='btn btn-primary'><span>삭제</span></a>
					</c:if>

				</td>
			</tr>

			<tr class='subCn${x}'>
				<th scope="row" ><label for="subCn">내용</label></th>
				<td >
					<span style="color:red;"> * 서브글내용  *
					</span><br/>
					<textarea  name="subCn" title='서브내용' cols="140" rows="5" class="textarea">${subResults[x].subCn}</textarea>
				</td>
			</tr>
		</c:forEach>

			</tbody>
		</table>
	</div>
</form>
	<div class="fr" >
	<c:choose>
		<c:when test="${empty result}" >
			<a href="javascript:addForm();" class="btn btn-primary"><span>추가</span></a>
			<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a href="javascript:addForm();" class="btn btn-primary"><span>추가</span></a>
			<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
		<c:if test="${not empty result }" >
			<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		</c:if>
		</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/job/${paramVO.programId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>

</div>
