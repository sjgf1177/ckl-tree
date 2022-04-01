<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="http://www.unp.co.kr/util" %>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
<c:choose>
	<c:when test="${param.bbsId == 'B0000177' }">
		<c:set var="formName" value="납세자"/>
	</c:when>
</c:choose>
<div class="board_view">
	<table class="viewTable" summary="${formName}의 성명,생년월일,연락처,핸드폰, SMS수신동의 입력">
		<caption>${formName } 정보 입력</caption>
		<colgroup>
		<col width="17%"/>
		<col width="35%"/>
		<col width="13%"/>
		<col width="35%"/>
		</colgroup>
		<tr>
			<th scope="row" class="required">성명</th>
			<td colspan="3"><c:out value="${user.userName}"/></td>
		</tr>
		<tr>
			<th scope="row" class="required"><span class="required"><span>필수입력</span></span>생년월일</th>
			<td colspan="3">
			<c:set var="birthdayData" value="${empty result ? fn:split(user.userBirthday,'-') : fn:split(result.option1,'/')}" />
			<c:set var="birthdayData0"><c:out value="${not empty birthdayData[0] ? birthdayData[0] : ''}"/></c:set>
				<select  name="tempValue1" class="input_select" title="생 년" >
					<option value="">생년선택</option>
				<c:forEach var="x" begin="1950" end="${sysYear}" step="1">
      				<option value="${x}" <c:if test="${birthdayData0 eq  x}">selected="selected"</c:if>>${x}</option>
     			</c:forEach>
				</select>
				-
				<select  name="tempValue2" class="input_select" title="생 월" >
					<option value="">생월선택</option>
				<c:forEach var="x" begin="1" end="12" step="1">
					<c:set var="data"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
					<c:set var="birthdayData1"><util:fz source="${not empty birthdayData[1] ? birthdayData[1] : ''}" resultLen="2" isFront="true" /></c:set>
      				<option value="${data}" <c:if test="${birthdayData1 eq data}">selected="selected"</c:if>>${data}</option>
     			</c:forEach>
				</select>
				-
				<select  name="tempValue3" class="input_select" title="생 일" >
				<option value="">생일선택</option>
				<c:forEach var="x" begin="1" end="31" step="1">
					<c:set var="data"><util:fz source="${x}" resultLen="2" isFront="true" /></c:set>
					<c:set var="birthdayData2"><util:fz source="${not empty birthdayData[2] ? birthdayData[2] : ''}" resultLen="2" isFront="true" /></c:set>
      				<option value="${data}" <c:if test="${birthdayData2 eq data}">selected="selected"</c:if>>${data}</option>
     			</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row">연락처</th>
			<td>
				<c:set var="data" value="${empty result ? fn:split(user.userPhone,'-') : fn:split(result.ntcrTel,'-')}" />
				<c:choose>
					<c:when test="${fn:length(data) >= 3}">
						<select id="ntcrTel1" name="ntcrTel1" class="input_select" title="${formName }연락처 앞 자리">
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
						<input type="text" id="ntcrTel2" name="ntcrTel2" value="${data[1]}" class="input_txt tel" title="${formName }연락처 중간 4자리" maxlength="4" />
						-
						<input type="text" id="ntcrTel3" name="ntcrTel3" value="${data[2]}" class="input_txt tel" title="${formName }연락처 끝 4자리" maxlength="4" />
					</c:when>
					<c:otherwise>
						<select id="ntcrTel1" name="ntcrTel1" class="input_select" title="${formName} 연락처 앞 자리">
							<option value="" selected="selected">선택</option>
							<option value="02" >02</option>
							<option value="070" >070</option>
							<option value="051" >051</option>
							<option value="053" >053</option>
							<option value="032" >032</option>
							<option value="062" >062</option>
							<option value="042" >042</option>
							<option value="052" >052</option>
							<option value="044" >044</option>
							<option value="031" >031</option>
							<option value="033" >033</option>
							<option value="043" >043</option>
							<option value="041" >041</option>
							<option value="063" >063</option>
							<option value="061" >061</option>
							<option value="054" >054</option>
							<option value="055" >055</option>
							<option value="064" >064</option>
						</select>
						-
						<input type="text" id="ntcrTel2" name="ntcrTel2" class="input_txt tel" title="${formName }연락처 중간 4자리" maxlength="4"/>
						-
						<input type="text" id="ntcrTel3" name="ntcrTel3" class="input_txt tel" title="${formName }연락처 끝 4자리" maxlength="4" />
					</c:otherwise>
				</c:choose>
			</td>
			<th scope="row">핸드폰</th>
			<td >
				<c:set var="data" value="${empty result ? fn:split(user.userMobile,'-') : fn:split(result.ntcrMobile,'-')}" />
				<c:choose>
					<c:when test="${fn:length(data) >= 3}">
						<select id="ntcrMobile1" name="ntcrMobile1" class="input_select" title="${formName} 핸드폰 앞 자리" >
							<option value="">선택</option>
							<option value="010" <c:if test="${data[0] eq '010'}"> selected="selected"</c:if>>010</option>
							<option value="011" <c:if test="${data[0] eq '011'}"> selected="selected"</c:if>>011</option>
							<option value="016" <c:if test="${data[0] eq '016'}"> selected="selected"</c:if>>016</option>
							<option value="017" <c:if test="${data[0] eq '017'}"> selected="selected"</c:if>>017</option>
							<option value="018" <c:if test="${data[0] eq '018'}"> selected="selected"</c:if>>018</option>
							<option value="019" <c:if test="${data[0] eq '019'}"> selected="selected"</c:if>>019</option>
						</select>
						-
						<input type="text" id="ntcrMobile2" name="ntcrMobile2" value="${data[1]}" class="input_txt tel" title="${formName} 핸드폰 중간 4자리" maxlength="4" />
						-
						<input type="text" id="ntcrMobile3" name="ntcrMobile3" value="${data[2]}" class="input_txt tel" title="${formName} 핸드폰 끝 4자리" maxlength="4" />
					</c:when>
					<c:otherwise>
						<select id="ntcrMobile1" name="ntcrMobile1" class="input_select" title="${formName} 핸드폰 앞 자리" >
							<option value="" selected="selected">선택</option>
							<option value="010" >010</option>
							<option value="011" >011</option>
							<option value="016" >016</option>
							<option value="017" >017</option>
							<option value="018" >018</option>
							<option value="019" >019</option>
						</select>
						-
						<input type="text" id="ntcrMobile2" name="ntcrMobile2" value="" class="input_txt tel" title="${formName} 핸드폰 중간 4자리" maxlength="4" />
						-
						<input type="text" id="ntcrMobile3" name="ntcrMobile3" value="" class="input_txt tel" title="${formName} 핸드폰 끝 4자리" maxlength="4" />
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th scope="row">SMS수신</th>
			<td colspan="3">
				<input type="radio" id="sr_sms_ok1" name="smsYn" value="Y" <c:if test="${result.smsYn eq 'Y'}">checked="checked"</c:if> class="input_radio"/> <label for="sr_sms_ok1">허용</label>
				<input type="radio" id="sr_sms_ok2" name="smsYn" value="N" <c:if test="${result.smsYn eq 'N' or empty result}">checked="checked"</c:if> class="input_radio"/> <label for="sr_sms_ok2">허용 안함</label>
			</td>
		</tr>
	</table>
</div>