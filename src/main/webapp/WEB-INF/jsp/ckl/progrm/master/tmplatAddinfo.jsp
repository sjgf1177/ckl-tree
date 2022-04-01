<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
//<![CDATA[

    function check_txt(value) {
	    if (isNaN(value)) {
			alert("숫자로만 입력하셔야 합니다.");
			return "";
		}
	    else {
	    	return value;
	    }
	}

//]]>
</script>

<c:set var="idx" value="${param.idx}" />
<tr>
	<th scope="row"><c:if test="${param.addEssntlAt eq 'Y'}"><span class="hide_star"><span class="sr-only">(필수입력)</span></span></c:if> <c:out value="${param.iemNm}"/></th>
	<td>
		<%-- <input type="hidden" name="prgSn" value="<c:out value="${param.prgSn}"/>"/> --%>
		<input type="hidden" name="attrbUserSn${idx}" value="<c:out value="${param.reqstSn}"/>"/>
		<input type="hidden" name="addinfoSn${idx}" value="<c:out value="${param.addinfoSn}"/>"/>
		<input type="hidden" name="aattrb${idx}" value="<c:out value="${param.attrb}"/>"/>
		<input type="hidden" name="iemNm${idx}" value="<c:out value="${param.iemNm}"/>"/>
		<input type="hidden" name="addEssntlAt${idx}" value="<c:out value="${param.addEssntlAt}"/>"/>
		<input type="hidden" name="iemCodeId${idx}" value="<c:out value="${param.iemCodeId}"/>"/>
		<input type="hidden" name="sortOrdr${idx}" value="<c:out value="${param.sortOrdr}"/>"/>
		<c:choose>
			<c:when test="${param.attrb eq '01'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<input type="text" name="attrbDataCn${idx}" id="attrbDataCn${idx}" style="width:130px" value='<c:out value="${param.attrbDataCn}"/>' title="텍스트를 입력하세요." />
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '02'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<input type="text" name="attrbDataCn${idx}" id="attrbDataCn${idx}" style="width:230px" value='<c:out value="${param.attrbDataCn}"/>' title="텍스트를 입력하세요." />
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '03'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<input type="text" name="attrbDataCn${idx}" id="attrbDataCn${idx}" style="width:330px" value='<c:out value="${param.attrbDataCn}"/>' title="텍스트를 입력하세요." />
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '04'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<input type="text" name="attrbDataCn${idx}" id="attrbDataCn${idx}" class="sdate" title="일자 입력" style="width:130px" value='<c:out value="${param.attrbDataCn}"/>' readonly="readonly"/>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '05'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(param.attrbDataCn,'~')}" />
					<input type="text" id="attrbDataCn${idx}_1" name="attrbDataCn${idx}_1" class="sdate" title="기간 시작일 입력" style="width:130px" value='<c:out value="${data[0]}"/>' readonly="readonly"/> ~
					<input type="text" id="attrbDataCn${idx}_2" name="attrbDataCn${idx}_2" class="edate" title="기간 종료일 입력" style="width:130px" value='<c:out value="${data[1]}"/>' readonly="readonly"/>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '06'}">
				<c:if test="${param.mode eq 'M'}">
					<c:forEach var="code" items="${iemCodeList}" varStatus="status">
						<c:if test="${param.attrbDataCn eq code.code}" ><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
				</c:if>
				<c:if test="${empty param.mode}">
					<select name="attrbDataCn${idx}" id="attrbDataCn${idx}" title="선택해 주세요.">
						<option value="">선택</option>
						<c:forEach var="code" items="${iemCodeList}" varStatus="status">
							<option value="${code.code}" <c:if test="${param.attrbDataCn eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
						</c:forEach>
					</select>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '07'}">
				<c:if test="${param.mode eq 'M'}">
					<c:set var="num" value="0"/>
					<c:forEach var="code" items="${iemCodeList}" varStatus="status">
						<c:if test="${fn:indexOf(param.attrbDataCn, code.code) > -1}"><c:if test="${num > 0}">, </c:if>${code.codeNm}<c:set var="num" value="${num+1}"/></c:if>
					</c:forEach>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:forEach var="code" items="${iemCodeList}" varStatus="status">
						<input type="checkbox" name="attrbDataCn${idx}" value="${code.code}" id="attrbDataCn${idx}_${status.count}" <c:if test="${fn:indexOf(param.attrbDataCn, code.code) > -1}">checked="checked"</c:if>/><label for="attrbDataCn${idx}_${status.count}">${code.codeNm}</label><br/>
					</c:forEach>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '08'}">
				<c:if test="${param.mode eq 'M'}">
					<c:forEach var="code" items="${iemCodeList}" varStatus="status">
						<c:if test="${param.attrbDataCn eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:forEach var="code" items="${iemCodeList}" varStatus="status">
						<input type="radio" name="attrbDataCn${idx}" value="${code.code}" id="attrbDataCn${idx}_${status.count}" <c:if test="${param.attrbDataCn eq code.code}">checked="checked"</c:if>/><label for="attrbDataCn${idx}_${status.count}">${code.codeNm}</label><br/>
					</c:forEach>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '09'}">
				<c:if test="${param.mode eq 'M'}">
				</c:if>
				<c:if test="${empty param.mode}">
					<select name="attrbDataCn${idx}" id="attrbDataCn${idx}" title="대분류를 선택해 주세요.">
						<option value="">선택</option>
					</select>
					<select name="attrbDataCn${idx}" id="attrbDataCn${idx}" title="중분류를 선택해 주세요.">
						<option value="">선택</option>
					</select>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '10'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<textarea name="attrbDataCn${idx}" id="attrbDataCn${idx}" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" title="${param.iemNm}을 입력해 주세요." >${param.attrbDataCn}</textarea>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '11'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(param.attrbDataCn,'@')}" />
					<input type="text" id="attrbDataCn${idx}_1" name="attrbDataCn${idx}_1" class="emailid" title="이메일 아이디" value='<c:out value="${data[0]}"/>'/>
					@
					<input type="text" id="attrbDataCn${idx}_2" name="attrbDataCn${idx}_2" readonly="readonly" value='<c:out value="${data[1]}"/>' class="input_txt emaildomain emaildomain_form${idx}" title="이메일 도메인 직접입력 - 이메일 도메인 선택 옵션중 직접입력 선택시 자동활성화&amp;포커스" />
					<label for="sr_email_more" class="hidden">이메일 도메인 선택</label>
					<select id="sr_email_more" name="" class="input_select select_email_js${idx}" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
						<option selected="selected">메일주소선택</option>
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
	                    <option value="hanmail.net">hanmail.net</option>
	                    <option value="daum.net">daum.net</option>
	                    <option value="hotmail.com">hotmail.com</option>
	                    <option value="nate.com">nate.com</option>
	                    <option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="emaildomain_false${idx}">직접입력</option>
					</select>
				</c:if>
				<script type="text/javascript">
				//<![CDATA[
				jQuery(function(){
					$('.emaildomain_form${idx}').attr('readonly',true);
					$('select.select_email_js${idx}').change(function() {
						if ($(this).val()=='emaildomain_false${idx}') {
							$('.emaildomain_form${idx}:text[name=attrbDataCn${idx}_2]').val('');
							$('.emaildomain_form${idx}').attr('readonly',false).focus();
						}else{
							$('.emaildomain_form${idx}:text[name=attrbDataCn${idx}_2]').val('');
							$('.emaildomain_form${idx}:text[name=attrbDataCn${idx}_2]').val($(this).val());
							$('.emaildomain_form${idx}').attr('readonly',true);
						}
					});
				});
				//]]>
				</script>
			</c:when>
			<c:when test="${param.attrb eq '12'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(param.attrbDataCn,'-')}" />
					<select name="attrbDataCn${idx}_1" id="attrbDataCn${idx}_1" title="지역 국번 앞 3자리"  class="input_select" >
						<option value="">선택</option>
						<option value="02" <c:if test="${data[0] eq '02'}">selected="selected"</c:if>>02</option>
						<option value="070" <c:if test="${data[0] eq '070'}">selected="selected"</c:if>>070</option>
						<option value="051" <c:if test="${data[0] eq '051'}">selected="selected"</c:if>>051</option>
						<option value="053" <c:if test="${data[0] eq '053'}">selected="selected"</c:if>>053</option>
						<option value="032" <c:if test="${data[0] eq '032'}">selected="selected"</c:if>>032</option>
						<option value="062" <c:if test="${data[0] eq '062'}">selected="selected"</c:if>>062</option>
						<option value="042" <c:if test="${data[0] eq '042'}">selected="selected"</c:if>>042</option>
						<option value="052" <c:if test="${data[0] eq '052'}">selected="selected"</c:if>>052</option>
						<option value="044" <c:if test="${data[0] eq '044'}">selected="selected"</c:if>>044</option>
						<option value="031" <c:if test="${data[0] eq '031'}">selected="selected"</c:if>>031</option>
						<option value="033" <c:if test="${data[0] eq '033'}">selected="selected"</c:if>>033</option>
						<option value="043" <c:if test="${data[0] eq '043'}">selected="selected"</c:if>>043</option>
						<option value="041" <c:if test="${data[0] eq '041'}">selected="selected"</c:if>>041</option>
						<option value="063" <c:if test="${data[0] eq '063'}">selected="selected"</c:if>>063</option>
						<option value="061" <c:if test="${data[0] eq '061'}">selected="selected"</c:if>>061</option>
						<option value="054" <c:if test="${data[0] eq '054'}">selected="selected"</c:if>>054</option>
						<option value="055" <c:if test="${data[0] eq '055'}">selected="selected"</c:if>>055</option>
						<option value="064" <c:if test="${data[0] eq '064'}">selected="selected"</c:if>>064</option>
					</select>
					-
					<input type="text" id="attrbDataCn${idx}_2" name="attrbDataCn${idx}_2" value='<c:out value="${data[1]}"/>' title="전화번호 중간4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
					-
					<input type="text" id="attrbDataCn${idx}_3" name="attrbDataCn${idx}_3" value='<c:out value="${data[2]}"/>' title="전화번호 끝4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '13'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(param.attrbDataCn,'-')}" />
					<select id="attrbDataCn${idx}_1" name="attrbDataCn${idx}_1" title="휴대폰번호 앞 자리" >
						<option value="">선택</option>
						<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
						<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
						<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
						<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
						<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
						<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
					</select>
					-
					<input type="text" id="attrbDataCn${idx}_2" name="attrbDataCn${idx}_2" value='<c:out value="${data[1]}"/>'  maxlength="4" title="휴대폰번호 중간 자리" onkeyup="this.value=check_txt(this.value)"/>
					-
					<input type="text" id="attrbDataCn${idx}_3" name="attrbDataCn${idx}_3" value='<c:out value="${data[2]}"/>'  maxlength="4" title="휴대폰번호 끝 자리" onkeyup="this.value=check_txt(this.value)"/>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '14'}">
				<c:if test="${param.mode eq 'M'}">
					<c:set var="data" value="${fn:split(param.attrbDataCn,'|')}" />
					<c:out value="${data[0]}"/><br/><br/>
					<c:out value="${data[1] eq 'Y' ? '동의' : '비동의'}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(param.attrbDataCn,'|')}" />
					<textarea name="attrbDataCn${idx}_1" id="attrbDataCn${idx}_1" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';"  title="${param.iemNm}을 입력해 주세요."><c:out value="${data[0]}"/></textarea>
					<label for="attrbDataCn${idx}_2"><input type="checkbox" name="attrbDataCn${idx}_2" id="attrbDataCn${idx}_2" value="Y" <c:if test="${data[1] eq 'Y'}">checked="checked"</c:if>/><c:out value="${param.iemNm}"/>(항목명)에 동의합니다.</label>
				</c:if>
			</c:when>
			<c:when test="${param.attrb eq '15'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.attrbDataCn eq '[]' ? '' : param.fileNm}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<script type="text/javascript">
					//<![CDATA[
					$(function() {

						delFile = function(atchFileId, fileSn) {
							if (!confirm('삭제하시겠습니까?')) {
								return;
							}
							$.getJSON(
								"/ckl/cmm/fms/deleteFileInfs.json",
								{atchFileId : atchFileId, fileSn : fileSn},
								function(data)
								{
									var jdata = data.resultCode;
						            if (jdata == 'success') {
						            	alert("성공적으로 삭제하였습니다.");
						            	$("#atchFileId${idx}").val("");
						            	$("#file_${idx}").html("<input type='file' name='attrbDataCn${idx}' id='attrbDataCn${idx}' class='col-md-8'/>");
						            }
						            else {
						            	alert("삭제에 실패하였습니다.");
						            }
								}
							);
						};

					});
					//]]>
					</script>
					<c:set var="files" value="${fileMap[param.attrbDataCn]}" />
					<div id="file_${idx}">
						<c:if test="${not empty files}">
							<input type="hidden" name="atchFileId${idx}" id="atchFileId${idx}" value='<c:out value="${param.attrbDataCn}"/>'/>
				    		<a href="/ckl/cmm/fms/FileDown.do?atchFileId=${files[0].atchFileId}&amp;fileSn=${files[0].fileSn}">
				    			<c:out value="${files[0].orignlFileNm}"/>&nbsp;[<c:out value="${files[0].fileMg}"/>&nbsp;byte]
				    		</a>
				    		<a href="#self" onclick="javascript:delFile('${files[0].atchFileId}', '${files[0].fileSn}');"> <img src="<c:url value='/bos/images/btn_X.jpg'/>" alt="<c:out value="${files[0].fileCn}"/> 삭제" /></a>
						</c:if>
						<c:if test="${empty files}">
							<input type="file" name="attrbDataCn${idx}" id="attrbDataCn${idx}" title="첨부파일 등록" class="col-md-8" />
						</c:if>
					</div>
				</c:if>
			</c:when>
		</c:choose>
	</td>
</tr>