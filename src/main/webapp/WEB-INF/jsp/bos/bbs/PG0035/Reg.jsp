<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%
org.springframework.context.ApplicationContext context = org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));

%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/bbs/${paramVO.bbsId}/update.do" />
</c:if>

<sec:authorize ifAnyGranted="ROLE_SUPER">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>

<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<!-- <script type="text/javascript" src="https://connect.facebook.net/ko_KR/all.js"></script>
<script type="text/javascript" src="/js/sns/facebook.js"></script> -->
<script type="text/javascript">

//공지글 상단 노출
$(function() {
	$(".sdate").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
});
<c:if test="${paramVO.bbsId eq 'B0000062'}">
	$(function() { 
		if($("#nttType2")[0].checked)
		{
			$("#ntcrDeTr").hide();
		}

		$("input[name=nttType]").click(function(){
			if(this.value == "${SearchVO.NOTICE_NTT_TYPE}")
			{
				$("#ntcrDeTr").show();
			}
			else
			{
				$("#ntcrBgnde").val("");
				$("#ntcrEndde").val("");
				$("#ntcrDeTr").hide();
			}
		});
	});
</c:if>
//--공지글 상단 노출

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		//공지글 상단 노출
		<c:if test="${ paramVO.bbsId eq 'B0000062' }">
	    v.add("nttType", {
	        required: true
	    });
	 	if($("#nttType1").attr("checked"))
		{
			v.add("ntceBgnde", {
				required: true
			});
			v.add("ntceEndde", {
				required: true
			});
		}
		</c:if>
		//--공지글 상단 노출

	    v.add("nttSj", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (CrossEditor.GetBodyValue() == "") {
			alert('내용을 입력해 주세요.');
		    CrossEditor.SetFocusEditor(); // 크로스에디터 Focus 이동
		    return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}

		var cont = CrossEditor.GetBodyValue();
		document.getElementById("nttCn").value= cont;
		form.submit();
	}


	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">

	<div class="bdView">
		<table>
			<caption>${masterVO.bbsNm} - ${empty result ? '등록' : '수정'}</caption>
			<colgroup>
				<col style="width:20%" />
				<col />
			</colgroup>
			
			<!-- 공지 상단 노출 -->
			<c:if test="${ paramVO.bbsId eq 'B0000062' }">
				<tr>
					<th scope="row">
						<span class="rq"><span>필수입력</span> </span><label for="nttType1">구분</label>
					</th>
					<td>
						<label> <input type="radio" id="nttType1" name="nttType" value="${SearchVO.NOTICE_NTT_TYPE}" <c:if test="${result.nttType eq SearchVO.NOTICE_NTT_TYPE}"> checked</c:if> /> 공지</label>
						<label> <input type="radio" id="nttType2" name="nttType" value="${SearchVO.BASIC_NTT_TYPE}" <c:if test="${result.nttType eq SearchVO.BASIC_NTT_TYPE}"> checked</c:if> /> 일반 </label>
					</td>
				</tr>
				<tr id="ntcrDeTr">
					<th scope="row">
						<label for="ntceBgnde">공지기간</label>
					</th>
					<td>
						<input id="ntceBgnde" name="ntceBgnde" value="${result.ntceBgnde}" readonly="readonly" type="text" class="board1 sdate" title="게시시작일" /> ~ <input id="ntceEndde" name="ntceEndde" value="${result.ntceEndde}" readonly="readonly" type="text" class="board1 edate" title="게시종료일" />
					</td>
				</tr>
			</c:if>
			<!-- //공지 상단 노출 -->
			
			<tr>
				<th scope="row"><label for="option1">공개여부</label></th>
				<td>
					
					<span class="radio_box_con">
						<input type="radio" class="radio_style_0" name="secret" id="secret1" value="N" <c:if test="${result.secret eq 'N' or empty result.secret}">checked="checked"</c:if>>
						<label for="secret1">공개</label>
					</span>
					<span class="radio_box_con">
						<input type="radio" class="radio_style_0" name="secret" id="secret2" value="Y" <c:if test="${result.secret eq 'Y' }">checked="checked"</c:if>>
						<label for="secret2">비공개</label>
					</span>
					
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="option1">공연명</label></th>
				<td>
					<input type="text" name="option1" id="option1" class="form-control" value="<c:out value="${result.option1}" />" />
				</td>
			</tr>
			
			<tr>
				<th scope="row"><label for="nttSj">제목</label></th>
				<td>
					<input type="text" name="nttSj" id="nttSj" class="form-control" value="<c:out value="${result.nttSj}" />" />
				</td>
			</tr>

			<tr>
				<th scope="row" ><label for="nttCn">내용</label></th>
				<td>
					<span style="color:red;">* 아래의 작성하시는 내용 (첨부파일 포함)중에 개인정보에 관한 내용이 있다면 개인정보가 타인에게 노출되어 침해 받을 수 있으므로 삭제 후 등록하여 주시기 바랍니다.
					(개인정보내용 : 주민등록번호, 계좌번호, 핸드폰번호 등)
					</span><br/>
					<%--
					<textarea id="nttCn" name="nttCn" cols="150" rows="30" class="textarea">${result.nttCn}</textarea>
					 --%>
					<textarea id="nttCn" name="nttCn" cols="150" rows="30" style="display:none;" class="textarea">${result.nttCn}</textarea>
				 	<script type="text/javascript">
					//<![CDATA[
						var CrossEditor = new NamoSE("crosseditor");
						CrossEditor.params.Font = {"Nanum Gothic":"나눔고딕", "Dotum":"돋움", "Gulim":"굴림", "Batang":"바탕", "Gungsuh":"궁서"};
						CrossEditor.EditorStart();
						var contentValue = document.getElementById("nttCn").value; // Hidden 값 참조
						function OnInitCompleted(){
							//contentValue = contentValue.replace(/#script#/gi, "script");
							CrossEditor.SetBodyValue(contentValue); // 컨텐츠 내용 에디터 삽입
						}
					//]]>
					</script>

				</td>
			</tr>

			<tr>
				<th scope="row" class="con_tit">대체텍스트 입력방법</th>
				<td>
				O 첨부파일이 있는 경우 : 내용 필드에 에디터를 이용하여 이미지 삽입하고 그림 설명에 반드시 "글제목 - 자세한 내용은 첨부파일 참조" 이라고 명시하고, 첨부파일 필드에 해당 첨부파일 등록<br />
				O 첨부파일이 없는 경우 : 내용 필드에 에디터를 이용하여 이미지 삽입하고 그림 설명에 반드시 "글제목 - 자세한 내용은 하단에 제공" 이라고 명시하고, 본문이미지 대체텍스트 필드에 내용 기입 함
				</td>
			</tr>

			<tr>
				<th scope="row" class="con_tit"><label for="imgDescCn"> 본문이미지<br/>대체텍스트</label></th>
				<td>
					<textarea name="imgDescCn" id="imgDescCn" cols="120" rows="10" class="col-md-12" title="본문이미지 대체텍스트을 입력해 주세요.">${result.imgDescCn}</textarea>
				</td>
			</tr>

			<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
			<c:if test="${not empty fileList}">
				<tr>
					<th scope="row">첨부된 첨부파일</th>
					<td>
						<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
					</td>
				</tr>
			</c:if>
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
				</td>
			</tr>
		</c:if>



			<c:if test="${not empty result}">
				<tr>
					<th scope="row">등록일</th>
					<td>${result.regDate}</td>
				</tr>
			</c:if>



			<c:if test="${not empty result}">
				<tr>
					<th scope="row">조회수</th>
					<td>${result.inqireCo}</td>
				</tr>
			</c:if>

		</table>
	</div>


</form>
	<c:if test="${not empty result}">
	<div class="fl">
<!-- 		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a> -->
	</div>
	</c:if>
	<div class="fr" >
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
	</c:when>
	<c:otherwise>
		<a class="btn btn-primary" href="javascript:checkForm();"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
		<a class="btn btn-inverse" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>복구</span></a>
	</c:if>
	</c:otherwise>
	</c:choose>
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"/>
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>
