<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="idx" value="${param.idx}" />
<tr>
	<th scope="row"><c:if test="${param.essntlAt eq 'Y'}"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span></c:if><c:out value="${param.title}"/></th>
	<td>
		<%-- <input type="hidden" name="prgSn" value="<c:out value="${param.prgSn}"/>"/> --%>
		<input type="hidden" name="key${idx}" value="<c:out value="${param.key}"/>"/>
		<input type="hidden" name="title${idx}" value="<c:out value="${param.title}"/>"/>
		<input type="hidden" name="sortOrdr${idx}" value="<c:out value="${param.sortOrdr}"/>"/>
		<input type="hidden" name="essntlAt${idx}" value="<c:out value="${param.essntlAt}"/>"/>
		<c:choose>
			<c:when test="${param.key eq 'nm'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<span class="input_style_1_con">
						<input type="text" class="input_style_1" title="${param.title}" name="infoData${idx}" id="infoData${idx}" style="width:130px" value='<c:out value="${empty info.nm ? user.userNm : info.nm}"/>' readonly="readonly">
					</span>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'brthdy'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
				<fmt:parseDate value="${user.brthdy}" var="brthdy" pattern="yyyy-MM-dd"/>
				<c:set var="brthdy"><fmt:formatDate value="${brthdy}" pattern="yyyy-MM-dd"/></c:set>
					<span class="input_style_1_con">
						<input type="text" name="infoData${idx}" id="infoData${idx}" class="sdate maskdate input_style_1" title="생년월일" style="width:130px" value='<c:out value="${empty info.brthdy ? brthdy : info.brthdy}"/>' />
					</span>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'sex'}">
				<c:if test="${param.mode eq 'M'}">
					<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
						<c:if test="${param.infoData eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="sex" value="${info.sex}" />
					<c:if test="${empty info.sex}"><c:set var="sex" value="${user.sex}" /></c:if>
					<c:forEach var="code" items="${COM079CodeList}" varStatus="status">
						<span class="radio_box_con">
							<c:set var="sexType" value="" />
							<c:if test="${code.codeNm eq '남'}">
								<c:set var="sexType" value="M" />
							</c:if>
							<c:if test="${code.codeNm eq '여'}">
								<c:set var="sexType" value="W" />
							</c:if>
							<input type="radio" name="infoData${idx}" id="infoData${idx}_${status.count}" value="${sexType}" <c:if test="${sex eq code.code}">checked="checked"</c:if> class="radio_style_0" title="성별 라디오 <c:out value="${code.codeNm}"/>"/>
							<label for="infoData${idx}_${status.count}"><c:out value="${code.codeNm}"/></label>
						</span>
					</c:forEach>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'email'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.email,'@')}" />
					<c:if test="${empty info.email}"><c:set var="data" value="${fn:split(user.email,'@')}" /></c:if>
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_1" name="infoData${idx}_1" class="emailid input_style_1 w20p" title="이메일 아이디"  value='<c:out value="${data[0]}"/>'/>
					</span>
					@
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_2" name="infoData${idx}_2"  value='<c:out value="${data[1]}"/>'readonly="readonly" class="input_style_1 w20p input_txt emaildomain emaildomain_form${idx}" title="이메일 도메인 직접입력 - 이메일 도메인 선택 옵션중 직접입력 선택시 자동활성화&amp;포커스" />
					</span>
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
				</c:if>
				<script type="text/javascript">
				//<![CDATA[
				jQuery(function(){
					$('.emaildomain_form${idx}').attr('readonly',true);
					$('select.select_email_js').change(function() {
						if ($(this).val()=='emaildomain_false') {
							$('.emaildomain_form${idx}:text[name=infoData${idx}_2]').val('');
							$('.emaildomain_form${idx}').attr('readonly',false).focus();
						}
						else {
							$('.emaildomain_form${idx}:text[name=infoData${idx}_2]').val('');
							$('.emaildomain_form${idx}:text[name=infoData${idx}_2]').val($(this).val());
							$('.emaildomain_form${idx}').attr('readonly',true);
						}
					});
				});
				//]]>
				</script>
			</c:when>
			<c:when test="${param.key eq 'addEmail'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.addEmail,'@')}" />
					<input type="text" id="infoData${idx}_1" name="infoData${idx}_1" class="emailid" title="추가 이메일 아이디"  value='<c:out value="${data[0]}"/>'/>
					@
					<input type="text" id="infoData${idx}_2" name="infoData${idx}_2" readonly="readonly"  value='<c:out value="${data[1]}"/>' class="input_txt emaildomain emaildomain_form${idx}" title="이메일 도메인 직접입력 - 이메일 도메인 선택 옵션중 직접입력 선택시 자동활성화&amp;포커스" />
					<label for="sr_email_more2" class="hidden">이메일 도메인 선택</label>
					<select id="sr_email_more2" name="" class="input_select select_email_js2" style="width:auto" title="직접입력 선택시 자동활성화&amp;포커스 이동">
						<option selected="selected">메일주소선택</option>
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
	                    <option value="hanmail.net">hanmail.net</option>
	                    <option value="daum.net">daum.net</option>
	                    <option value="hotmail.com">hotmail.com</option>
	                    <option value="nate.com">nate.com</option>
	                    <option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="emaildomain_false2">직접입력</option>
					</select>
				</c:if>
				<script type="text/javascript">
				//<![CDATA[
				jQuery(function(){
					$('.emaildomain_form${idx}').attr('readonly',true);
					$('select.select_email_js2').change(function() {
						if ($(this).val()=='emaildomain_false2') {
							$('.emaildomain_form${idx}:text[name=infoData${idx}_2]').val('');
							$('.emaildomain_form${idx}').attr('readonly',false).focus();
						}else{
							$('.emaildomain_form${idx}:text[name=infoData${idx}_2]').val('');
							$('.emaildomain_form${idx}:text[name=infoData${idx}_2]').val($(this).val());
							$('.emaildomain_form${idx}').attr('readonly',true);
						}
					});
				});
				//]]>
				</script>
			</c:when>
			<c:when test="${param.key eq 'ownhomTelno'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.ownhomTelno,'-')}" />
					<select name="infoData${idx}_1" id="infoData${idx}_1" title="자택 지역 국번 앞 3자리"  class="input_select" >
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
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_2" class="input_style_1 w20p" name="infoData${idx}_2" value='<c:out value="${data[1]}"/>' title="자택 전화번호 중간4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
					</span>
					-
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_3" class="input_style_1 w20p" name="infoData${idx}_3" value='<c:out value="${data[2]}"/>'  title="자택 전화번호 끝4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
					</span>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'mbtlnum'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.mbtlnum,'-')}" />
					<c:if test="${empty info.mbtlnum}"><c:set var="data" value="${fn:split(user.moblphon,'-')}" /></c:if>
					<select id="infoData${idx}_1" name="infoData${idx}_1" title="휴대폰번호 앞 자리" >
						<option value="">선택</option>
						<option value="010" <c:if test="${data[0] eq '010'}">selected="selected"</c:if>>010</option>
						<option value="011" <c:if test="${data[0] eq '011'}">selected="selected"</c:if>>011</option>
						<option value="016" <c:if test="${data[0] eq '016'}">selected="selected"</c:if>>016</option>
						<option value="017" <c:if test="${data[0] eq '017'}">selected="selected"</c:if>>017</option>
						<option value="018" <c:if test="${data[0] eq '018'}">selected="selected"</c:if>>018</option>
						<option value="019" <c:if test="${data[0] eq '019'}">selected="selected"</c:if>>019</option>
					</select>
					-
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_2" class="input_style_1 w20p" name="infoData${idx}_2" value='<c:out value="${data[1]}"/>' maxlength="4" title="휴대폰번호 중간 자리" onkeyup="this.value=check_txt(this.value)"/>
					</span>
					-
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_3" class="input_style_1 w20p" name="infoData${idx}_3" value='<c:out value="${data[2]}"/>' maxlength="4" title="휴대폰번호 끝 자리" onkeyup="this.value=check_txt(this.value)"/>
					</span>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'cmpnyTelno'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.cmpnyTelno,'-')}" />
					<select name="infoData${idx}_1" id="infoData${idx}_1" title="회사 지역 국번 앞 3자리"  class="input_select" >
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
					<input type="text" id="infoData${idx}_2" name="infoData${idx}_2" value='<c:out value="${data[1]}"/>' title="회사 전화번호 중간4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
					-
					<input type="text" id="infoData${idx}_3" name="infoData${idx}_3" value='<c:out value="${data[2]}"/>' title="회사 전화번호 끝4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'telno'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.telno,'-')}" />
					<select name="infoData${idx}_1" id="infoData${idx}_1" title="지역 국번 앞 3자리"  class="input_select" >
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
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_2" class="input_style_1 w20p" name="infoData${idx}_2" value='<c:out value="${data[1]}"/>' title="전화번호 중간4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
					</span>
					-
					<span class="input_style_1_con">
						<input type="text" id="infoData${idx}_3" class="input_style_1 w20p" name="infoData${idx}_3" value='<c:out value="${data[2]}"/>' title="전화번호 끝4자리" maxlength="4" onkeyup="this.value=check_txt(this.value)"/>
					</span>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'adres'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<span class="input_style_1_con address_input">
						<input type="text" class="input_style_1" name="infoData${idx}" id="infoData${idx}" value='<c:out value="${info.adres}"/>' title="주소" />
					</span>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'resdnc'}">
				<c:if test="${param.mode eq 'M'}">
					<c:set var="data" value="${fn:split(param.infoData,'|')}" />
					<c:forEach var="code" items="${COM063CodeList}">
						<c:if test="${data[0] eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
					<c:forEach var="code" items="${COM063CodeList}">
						<c:if test="${data[1] eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:set var="data" value="${fn:split(info.resdnc,'|')}" />
					<c:if test="${empty info.resdnc}"><c:set var="data" value="${fn:split(user.address,'|')}" /></c:if>
					<script type="text/javascript">
					//<![CDATA[
					var sidoVal = "${data[0]}";
					var gugunVal = "${data[1]}";

					jQuery(function(){
						if (sidoVal != "") getCodeList("infoData${idx}_2", 'COM063', $("#infoData${idx}_1").val(), 2, gugunVal);

						$("select[name=infoData${idx}_1]").change(function(){
							var val = $(this).val();
							getCodeList("infoData${idx}_2", 'COM063', val, 2);
						});
					});

					//공통 코드목록 화면처리
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
								$("<option>").text("구군 선택").attr("value","").appendTo($obj);
								$.each(data.list, function(key,item) {
									var $codeItem = $("<option>").attr("value", item.code).text(item.codeNm);
									if (code == item.code) $codeItem.attr("selected",true);
									$codeItem.appendTo($obj);
								});
								if ("infoData${idx}_2" == elemntId && "" == upperCode) {
									$("<option>").text("구군 선택").attr("value","").appendTo($("#infoData${idx}_2").empty());
								}
							}
						},"json");
					}
					//]]>
					</script>

					<%-- <input type="text" name="infoData${idx}" id="infoData${idx}" value='<c:out value="${info.resdnc}"/>' > --%>
					<select name="infoData${idx}_1" id="infoData${idx}_1" title="시도를 선택해 주세요.">
						<option value="">시도 선택</option>
						<c:forEach var="code" items="${COM063CodeList}">
							<c:if test="${code.upperCode eq 0}">
								<option value="<c:out value="${code.code}" />" <c:if test="${data[0] eq code.code}">selected="selected"</c:if>><c:out value="${code.codeNm}" /></option>
							</c:if>
						</c:forEach>
					</select>
					<select name="infoData${idx}_2" id="infoData${idx}_2" title="구군을 선택해 주세요.">
						<option value="">구군 선택</option>
					</select>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'job'}">
				<c:if test="${param.mode eq 'M'}">
					<c:forEach var="code" items="${COM056CodeList}" varStatus="status">
						<c:if test="${param.infoData eq code.code}"><c:out value="${code.codeNm}"/></c:if>
					</c:forEach>
				</c:if>
				<c:if test="${empty param.mode}">
					<c:forEach var="code" items="${COM056CodeList}" varStatus="status">
						<input type="radio" name="infoData${idx}" id="infoData${idx}_${status.count}" value="${code.code}" <c:if test="${info.job eq code.code}">checked="checked"</c:if>/><label for="infoData${idx}_${status.count}"><c:out value="${code.codeNm}"/></label>
					</c:forEach>
				</c:if>
			</c:when>
			<c:when test="${param.key eq 'psitn'}">
				<c:if test="${param.mode eq 'M'}">
					<c:out value="${param.infoData}"/>
				</c:if>
				<c:if test="${empty param.mode}">
					<input type="text" name="infoData${idx}" id="infoData${idx}" style="width:110px" value='<c:out value="${info.psitn}"/>' title="소속" />
				</c:if>
			</c:when>
		</c:choose>
	</td>
</tr>