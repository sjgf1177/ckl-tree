
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

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
<script type="text/javascript" src="/crosseditor/js/namo_scripteditor.js"></script>
<script type="text/javascript">

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

	    v.add("ntcrNm", {
	        required: true
	    });
	    v.add("ntcrTel1", {
   	        required: false,
   	     	span : 3,
	        glue : "-",
   	        option : "phone"
   	    });
	    v.add("ntcrEmail1", {
   	        required: false,
			span: 2,
	       	glue: "@",
	       	option: "email"
	    });

	if ('${param.bbsId}' == "B0000038") {
	    v.add("option1", {
	        required: true
	    });
	}

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

		if (!confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			return;
		}

		var cont = CrossEditor.GetBodyValue();
		document.getElementById("nttCn").value= cont;

		form.submit();
	}

	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

</script>

<title><c:out value='${masterVO.bbsNm}'/> - 게시글쓰기</title>
</head>

<div id="content">

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" name="ntcrId" value="${result.ntcrId}" />
	<input type="hidden" id="atchFileId" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="htmlYn" value="${result.htmlYn}" />

	<div class="bdView">
		<table summary="<c:if test="${roleSuper eq 'Y'}">게시구분,게시기간,</c:if>제목,담당부서,작성자,전화번호,이메일,내용<c:if test="${not empty result}">등록일,</c:if><c:if test="${not empty result}">조회수,</c:if>답변상태, 포함">
			<caption>${masterVO.bbsIntrcn} - 쓰기</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>

			<c:if test="${not empty result}">
				<tr>
					<th scope="row">접수일시</th>
					<td>${result.regDate}</td>
				</tr>
				<%-- <tr>
					<th scope="row"><label for="replyAt">처리현황</label></th>
					<td>
						${result.replyAt eq 'Y' ? '완료' : '미완료'}
					</td>
				</tr> --%>
			</c:if>

				<tr>
					<th scope="row"><label for="ntcrNm">작성자</label></th>
					<td>
						<input type="text" name="ntcrNm" id="ntcrNm" class="board1 wr" value="${result.ntcrNm}" />
					</td>
				</tr>
				<%-- <tr>
					<th scope="row"><label for="deptNm">회사명</label></th>
					<td>
						<input type="text" name="deptNm" value="${result.deptNm}" id="deptNm" class="input_txt conection"/>
						<input type="hidden" name="deptId" value="${result.deptId}" id="deptId"/>
					</td>
				</tr> --%>
				<tr>
					<th scope="row"><label for="ntcrTel1">전화번호</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.ntcrTel,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="ntcrTel1" id="ntcrTel1" title="지역 국번 앞 3자리" class="input_select">
									<option value="">선택</option>
									<option value="02" <c:if test="${data[0] eq '02'}"> selected="selected"</c:if>>02</option>
									<option value="070" <c:if test="${data[0] eq '070'}"> selected="selected"</c:if>>070</option>
									<option value="051" <c:if test="${data[0] eq '051'}"> selected="selected"</c:if>>051</option>
									<option value="053" <c:if test="${data[0] eq '053'}"> selected="selected"</c:if>>053</option>
									<option value="032" <c:if test="${data[0] eq '032'}"> selected="selected"</c:if>>032</option>
									<option value="062" <c:if test="${data[0] eq '062'}"> selected="selected"</c:if>>062</option>
									<option value="042" <c:if test="${data[0] eq '042'}"> selected="selected"</c:if>>042</option>
									<option value="052" <c:if test="${data[0] eq '052'}"> selected="selected"</c:if>>052</option>
									<option value="044" <c:if test="${data[0] eq '044'}"> selected="selected"</c:if>>044</option>
									<option value="031" <c:if test="${data[0] eq '031'}"> selected="selected"</c:if>>031</option>
									<option value="033" <c:if test="${data[0] eq '033'}"> selected="selected"</c:if>>033</option>
									<option value="043" <c:if test="${data[0] eq '043'}"> selected="selected"</c:if>>043</option>
									<option value="041" <c:if test="${data[0] eq '041'}"> selected="selected"</c:if>>041</option>
									<option value="063" <c:if test="${data[0] eq '063'}"> selected="selected"</c:if>>063</option>
									<option value="061" <c:if test="${data[0] eq '061'}"> selected="selected"</c:if>>061</option>
									<option value="054" <c:if test="${data[0] eq '054'}"> selected="selected"</c:if>>054</option>
									<option value="055" <c:if test="${data[0] eq '055'}"> selected="selected"</c:if>>055</option>
									<option value="064" <c:if test="${data[0] eq '064'}"> selected="selected"</c:if>>064</option>
								</select>
							-
							<input type="text" id="ntcrTel2" name="ntcrTel2" value="${data[1]}" class="tel" title="전화번호 중간4자리" maxlength="4" />
							-
							<input type="text" id="ntcrTel3" name="ntcrTel3" value="${data[2]}" class="tel" title="전화번호 끝4자리" maxlength="4" />
							</c:when>
							<c:otherwise>
								<select name="ntcrTel1" id="ntcrTel1" title="지역 국번 앞 3자리" class="input_select">
									<option value="">선택</option>
									<option value="02">02</option>
									<option value="070">070</option>
									<option value="051">051</option>
									<option value="053">053</option>
									<option value="032">032</option>
									<option value="062">062</option>
									<option value="042">042</option>
									<option value="052">052</option>
									<option value="044">044</option>
									<option value="031">031</option>
									<option value="033">033</option>
									<option value="043">043</option>
									<option value="041">041</option>
									<option value="063">063</option>
									<option value="061">061</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="064">064</option>
								</select>
							-
							<input type="text" value="" id="ntcrTel2" name="ntcrTel2" class="tel" title="전화번호 중간4자리" maxlength="4" />
							-
							<input type="text" value="" id="ntcrTel3" name="ntcrTel3" class="tel" title="전화번호 끝4자리" maxlength="4" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="ntcrEmail1">이메일</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.ntcrEmail,'@')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 2}">
								<input name="ntcrEmail1" id="ntcrEmail1" type="text" title="이메일 아이디" value="${data[0]}" style="width: 100px" class="board1 email_id" />
								@
								<input name="ntcrEmail2" id="ntcrEmail2" type="text" title="이메일 주소" value="${data[1]}" style="width: 200px" readonly="readonly" class="board1 email_addr emaildomain_form" />
							</c:when>
							<c:otherwise>
								<input name="ntcrEmail1" id="ntcrEmail1" type="text" title="이메일 아이디" value="" style="width: 100px" class="board1 email_id" />
								@
								<input name="ntcrEmail2" id="ntcrEmail2" type="text" title="이메일 주소" value="" style="width: 200px" readonly="readonly" class="board1 email_addr emaildomain_form" />
							</c:otherwise>
						</c:choose>
							<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
							<select id="sr_email_more" name="" class="input_select select_email_js" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
								<option selected="selected">메일주소선택</option>
								<option value="gmail.com">gmail.com</option>
								<option value="naver.com">naver.com</option>
			                    <option value="hanmail.net">hanmail.net</option>
			                    <option value="daum.net">daum.net</option>
			                    <option value="hotmail.com">hotmail.com</option>
			                    <option value="nate.com">nate.com</option>
			                    <option value="yahoo.co.kr">yahoo.co.kr</option>
								<option value="emaildomain_false">직접입력</option>
							</select>
							<script type="text/javascript">
							//<![CDATA[
							jQuery(function(){
								$('select.select_email_js').change(function() {
									if ($(this).val()=='emaildomain_false') {
										$('.emaildomain_form:text[name=email2]').val('');
										$('.emaildomain_form').attr('readonly',false).focus();
									}else{
										$('.emaildomain_form:text[name=email2]').val('');
										$('.emaildomain_form:text[name=email2]').val($(this).val());
										$('.emaildomain_form').attr('readonly',true)
									}
								});
							});
							//]]>
							</script>
					</td>
				</tr>

			<c:if test="${param.bbsId eq 'B0000038'}">
				<tr>
					<th scope="row"><label for="option1">질문분야</label></th>
					<td>
						<select name="option1" id="option1">
							<option value="">분야선택</option>
							<option value="01" <c:if test="${result.option1 eq '01'}">selected="selected"</c:if>>현장교육</option>
							<option value="02" <c:if test="${result.option1 eq '02'}">selected="selected"</c:if>>온라인교육</option>
							<option value="03" <c:if test="${result.option1 eq '03'}">selected="selected"</c:if>>창의인재동반</option>
							<option value="04" <c:if test="${result.option1 eq '04'}">selected="selected"</c:if>>취업정보</option>
						</select>
					</td>
				</tr>
			</c:if>

				<tr>
					<th scope="row"><label for="nttSj">제목</label></th>
					<td>
						<input type="text" name="nttSj" id="nttSj" class="w500" value="${result.nttSj}" />
					</td>
				</tr>
				<tr>
					<th scope="row" class="con_tit"><label for="nttCn">내용</label></th>
					<td class="outputEditor">
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

		<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<jsp:include page="/WEB-INF/jsp/bos/share/EgovFileList.jsp" flush="true" />
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<jsp:include page="/WEB-INF/jsp/bos/share/FileSubmit.jsp" flush="true" />
				</td>
			</tr>
		</c:if>

			</tbody>
		</table>
	</div>
</form>
	<c:if test="${not empty result}">
	<div class="fl">
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
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
		<c:url var="url" value="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" />
		<a class="btn btn-primary" href="${url}"><span>목록</span></a>
	</div>

</div>
