<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript" defer="defer">
//<![CDATA[

function fncCheckAll() {
	var checkField = document.listForm.delYn;
    // alert(checkField);
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";

    var returnBoolean = false;
    var checkCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else
                	    returnValue = returnValue + ";" + checkField[i].value;
                    checkCount++;
                }
            }
            if(checkCount > 0)
                returnBoolean = true;
            else {
                alert("선택된 권한이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 권한이 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.authorCodes.value = returnValue;

    return returnBoolean;
}

function fncSelectAuthorList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/bos/cmm/sec/ram/AuthorList.do?menuNo=${param.menuNo}'/>";
    document.listForm.submit();
}

function fncSelectAuthor(author) {
    document.listForm.authorCode.value = author;
    document.listForm.action = "/bos/cmm/sec/ram/Author/" + author + ".do?menuNo=${param.menuNo}";
    document.listForm.submit();
}

function fncAddAuthorInsert() {
    location.replace("<c:url value='/bos/cmm/sec/ram/AuthorInsertView.do?menuNo=${param.menuNo}'/>");
}

function fncAuthorDeleteList() {

    if(fncManageChecked()) {
        if(confirm("삭제하시겠습니까?")) {
            document.listForm.action = "<c:url value='/bos/cmm/sec/ram/AuthorListDelete.do?menuNo=${param.menuNo}'/>";
            document.listForm.submit();
        }
    }
}

function fncAddAuthorView() {
    document.listForm.action = "<c:url value='/bos/cmm/sec/ram/AuthorUpdate.do?menuNo=${param.menuNo}'/>";
    document.listForm.submit();
}

function fncSelectAuthorRole(author) {
    document.listForm.searchKeyword.value = author;
    document.listForm.action = "<c:url value='/bos/cmm/sec/ram/AuthorRoleList.do?menuNo=${param.menuNo}'/>";
    document.listForm.submit();
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/bos/cmm/sec/ram/AuthorList.do?menuNo=${param.menuNo}'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
    	fncSelectAuthorList('1');
    }
}

$(function() {
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	$("#edate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});

	var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

	 if(strKey != ''){

		$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

	 }

	$( '.check-all' ).click( function() {
          $( '.input_check' ).prop( 'checked', this.checked );
    } );
});

//]]>
</script>

	<form name="listForm" action="<c:url value='/bos/cmm/sec/ram/AuthorList.do?menuNo=${param.menuNo}'/>" method="post">
		<input type="hidden" name="authorCode"/>
		<input type="hidden" name="authorCodes"/>
		<input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
		<div class="sh">
			<fieldset>
			<legend>게시판 게시물검색</legend>
			<%-- 	<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
			    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" /> --%>

				<label for="stributary" class="blind"></label>
				<select id="stributary" name="searchCondition" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCondition == '1'}">selected="selected"</c:if> >권한ID</option>
				   <option value="2" <c:if test="${paramVO.searchCondition == '2'}">selected="selected"</c:if> >권한명</option>
				</select>
				<label for="input1">
					<input id="input1" type="text" title="권한 명" style="width:130px" name="searchKeyword" value="${authorManageVO.searchKeyword}" onkeypress="press();" />
				</label>
				<label for="input2">
					<a href="javascript:fncSelectAuthorList('1');" class="btn btn-seach">검색</a>
				</label>
			</fieldset>
		</div>

	<div>
		<table class="table table-bordered table-striped table-hover">
			<caption>게시판 목록</caption>
			<colgroup>
				<col width="3%" />
				<col width="15%" />
				<col width="25%" />
				<col width="*" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()"></th>
					<th scope="col">권한 ID</th>
					<th scope="col">권한 명</th>
					<th scope="col">설명</th>
					<th scope="col" class="last">등록일자</th>
				</tr>
			</thead>
			<tbody>
			 <c:forEach var="author" items="${authorList}" varStatus="status">
			  <tr>
			    <td><input type="checkbox" name="delYn" class="check2"><input type="hidden" name="checkId" value="<c:out value="${author.authorCode}"/>" /></td>
			    <td><a href="javascript:fncSelectAuthor('<c:out value="${author.authorCode}"/>')"><c:out value="${author.authorCode}"/></a></td>
			    <td><c:out value="${author.authorNm}"/></td>
			    <td><c:out value="${author.authorDc}"/></td>
			    <td><c:out value="${author.authorCreatDe}"/></td>
			  </tr>
			 </c:forEach>
			<c:if test="${fn:length(authorList) == 0}"><tr><td colspan="5">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<a class="btn btn-info" href="javascript:fncAuthorDeleteList();"><span>삭제</span></a>

	<div class="btn_set">
		<a class="btn btn-primary" href="javascript:fncAddAuthorInsert();"><span>등록</span></a>
	</div>

	<c:if test="${fn:length(authorList) > 0}">
	<div class="paging">
		<div class="paging_con">
			${pageNav}
		</div>
	</div><!-- paging end //-->
	</c:if>
	</form>
