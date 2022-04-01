<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script type="text/javascript">

	function checkForm() {
		var form = document.frm;
		var v = new MiyaValidator(form);

		v.add("realm", {
			required : true
		});
		v.add("tchNm", {
			required : true
		});
		v.add("psitn", {
			required : true
		});
		v.add("career", {
			required : true
		});
		v.add("tel1", {
			required : false,
			span : 3,
			glue : "-",
			option : "phone"
		});

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("${empty result ? '등록' : '수정'}하시겠습니까?")) {
			form.submit();
		}

	}

</script>

<form name="frm" method="post" action="/bos/progrm/instrctr/${empty result ? 'insert' : 'update'}.do" enctype="multipart/form-data">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}">
	<input type="hidden" name="tchSn" value="${empty result ? 0 : result.tchSn}">
	<fieldset>
	<legend>강사(전문가)관리 입력 화면</legend>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col span="2">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span><label for="PART1">분야</label></th>
					<td>
						<select name="realm" id="realm" title="분야">
							<option value="">분야선택</option>
							<c:forEach var="code" items="${COM076CodeList}" varStatus="status">
								<option value="${code.code}" <c:if test="${result.realm eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
							 </c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> <label for="tchNm">이름</label></th>
					<td><input type="text" name="tchNm" id="tchNm" value="${result.tchNm}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="psitn">현소속</label></th>
					<td><input type="text" name="psitn" id="psitn" value="${result.psitn}" class="col-md-12">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="career"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 주요경력</label></th>
					<td><textarea name="career" id="career" cols="120" rows="5" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';">${result.career}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="tel1">연락처</label></th>
					<td>
						<c:set var="data" value="${fn:split(result.tel,'-')}" />
						<c:choose>
							<c:when test="${fn:length(data) >= 3}">
								<select name="tel1" id="tel1" title="연락처 앞자리를 선택해 주세요." >
									<option value="">선택</option>
									<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
									<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
									<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
									<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
									<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
									<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
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
								<input type="text" id="tel2" name="tel2" value="${data[1]}" title="연락처 중간자리를 입력하세요." maxlength="4" />
								-
								<input type="text" id="tel3" name="tel3" value="${data[2]}" title="연락처 끝자리를 입력하세요." maxlength="4" />
							</c:when>
							<c:otherwise>
								<select name="tel1" id="tel1" title="연락처 국번 앞 3자리" >
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
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
								<input type="text" value="" id="tel2" name="tel2" title="연락처 중간자리를 입력하세요." maxlength="4" />
								-
								<input type="text" value="" id="tel3" name="tel3" title="연락처 끝자리를 입력하세요." maxlength="4" />
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="rm"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 비고</label></th>
					<td><textarea name="rm" id="rm" cols="120" rows="5" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';">${result.rm}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	</fieldset>
</form>

<div class="btnSet">
	<a class="btn btn-primary" href="javascript:checkForm();">
		<span>${empty result ? '등록' : '수정'}</span>
	</a>
	<c:url var="url" value="/bos/progrm/instrctr/list.do">
		<c:param name="menuNo" value="${param.menuNo}"></c:param>
		<c:param name="searchType" value="${param.searchType}"></c:param>
		<c:param name="searchTxt" value="${param.searchTxt}"></c:param>
		<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}"></c:param>
	</c:url>
	<a class="btn btn-primary" href="${url}">
		<span>취소</span>
	</a>
</div>
