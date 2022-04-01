<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">


	$(function() {
		var telNo = $("#telNo", opener.document).val();

		$("#tel1").val(telNo.split("-")[0]);
		$("#tel2").val(telNo.split("-")[1]);
		$("#tel3").val(telNo.split("-")[2]);
	});

	function checkForm() {
		var form = document.frm;
		var v = new MiyaValidator(form);
		v.add("tel1", {
			required : true,
			span : 3,
			glue : "-",
			option : "phone"
		});
		v.add("msg", {
			required : true
		});
		
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		console.log(result);
		if (confirm("발송하시겠습니까?")) {
			form.submit();
		}

	}

</script>

<form name="frm" method="post" action="/bos/progrm/applcnt/smsSndng.do" >
	<fieldset>
	<legend>SMS발송 입력 화면</legend>
    <h1>SMS발송</h1>
	<div class="bdView">
		<table class="table table-bordered">
			<caption>
			</caption>
			<colgroup>
			<col style="width:15%">
			<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">수신수</th>
					<td>${resultCnt}</td>
				</tr>
				<tr>
					<th scope="row"><label for="tel1">발신번호</label></th>
					<td>
						<select name="tel1" id="tel1" title="발신번호 국번 앞 3자리" >
							<option value="">선택</option>
							<option value="02" >02</option>
							<option value="0505">0505</option>
							<option value="0606">0606</option>
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
						<input type="text" value="" id="tel2" name="tel2" style="width:80px" title="발신번호 중간자리를 입력하세요." maxlength="4" />
						-
						<input type="text" value="" id="tel3" name="tel3" style="width:80px" title="발신번호 끝자리를 입력하세요." maxlength="4" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="msg"><span class="hide_star"><span class="sr-only">(필수입력)</span></span> 내용</label></th>
					<td>
						<textarea name="msg" id="msg" cols="120" rows="5" class="col-md-12" ></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	</fieldset>
</form>

<div class="btnSet">
	<a class="btn btn-primary" href="javascript:checkForm();"><span>발송</span></a>
	<a class="btn btn-primary" href="javascript:window.close();"><span>취소</span></a>
</div>
