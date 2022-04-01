<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- + 추가시 param.mode = 'i' -->

<c:choose>
	<c:when test="${param.mode eq 'i'}"><c:set var="idxs" >{idx}</c:set></c:when>
	<c:otherwise><c:set var="idxs" >${param.idx}</c:set></c:otherwise>
</c:choose>
<tr class="trT${idxs}">
	<c:choose>
		<c:when test="${param.mode eq 'i'}">
			<td>
				<!-- <input type="text" name="iemNm{idx}" id="iemNm{idx}" value="{iemNm}" title="항목명" style="width:100%;"> -->
				<textarea name="iemNm{idx}" id="iemNm{idx}" title="항목명" rows="4" style="width:100%;">{iemNm}</textarea>
			</td>
			<td>
				<c:choose>
					<c:when test="${param.attrb eq '07' or param.attrb eq '08'}">
						{attrbNm}
						<button class="addbtn layer_btn btn-sm btn-primary" type="button" onclick="codePopOpen('${param.iemCodeId}', '{idx}');">설문보기(코드)추가</button>
						<br/>
					</c:when>				
					<c:otherwise>
						{attrbNm} :
					</c:otherwise>
				</c:choose>
		</c:when>
		<c:otherwise>
			<td>
				<%-- <input type="text" name="iemNm${param.idx}" id="iemNm${param.idx}" value="${param.iemNm}" title="항목명" style="width:100%;"> --%>
				<textarea class="iemTi col-md-12" name="iemNm${param.idx}" id="iemNm${param.idx}" title="항목명" style="width:100%;">${param.iemNm}</textarea>
			</td>
			
			<td>
				<c:choose>
					<c:when test="${param.attrb eq '07' or param.attrb eq '08'}">
						${param.attrbNm}
						<button class="addbtn layer_btn btn-sm btn-primary" type="button" onclick="codePopOpen('${param.iemCodeId}', '${param.idx}');">설문보기(코드)추가</button>
						<br/>
					</c:when>
					<c:otherwise>
						${param.attrbNm} :
					</c:otherwise>
				</c:choose>
		</c:otherwise>
	</c:choose>
		<c:choose>
			<c:when test="${param.attrb eq '01'}"><input type="text" class="pd_4_5" name="TEXTPT1" id="TEXTPT1" style="width:130px" value="" title="텍스트를 입력하세요." /></c:when>
			<c:when test="${param.attrb eq '02'}"><input type="text" class="pd_4_5" name="TEXTPT2" id="TEXTPT2" style="width:230px" value="" title="텍스트를 입력하세요." /></c:when>
			<c:when test="${param.attrb eq '03'}"><input type="text" class="pd_4_5" name="TEXTPT2" id="TEXTPT2" style="width:330px" value="" title="텍스트를 입력하세요." /></c:when>
			<c:when test="${param.attrb eq '04'}"><input type="text" class="txt_ct" id="sdate1" name="sdate1" title="일자 입력" style="width:130px" value="" /><img src="/bos/images/calendar.gif"/></c:when>
			<c:when test="${param.attrb eq '05'}">
				<input type="text" class="txt_ct" id="sdate" name="sdate" title="기간 시작일 입력" style="width:130px"value="" /><img src="/bos/images/calendar.gif"/> ~
				<input type="text" class="txt_ct" id="edate" name="edate" title="기간 종료일 입력" style="width:130px"value="" /><img src="/bos/images/calendar.gif"/>
			</c:when>
			<c:when test="${param.attrb eq '06'}">
				<select name="SELS1" id="SELS1" title="선택해 주세요.">
					<option value="">선택</option>
					<c:forEach var="code" items="${iemCodeList}" varStatus="status">
						<option value="${code.code}" >${code.codeNm}</option>
					</c:forEach>
				</select>
			</c:when>
			<c:when test="${param.attrb eq '07'}">
				<c:forEach var="code" items="${iemCodeList}" varStatus="status">
					<input type="checkbox" name="MUTICHKG" value="0" id="${status.count}" />${code.codeNm}<br/>
				</c:forEach>
			</c:when>
			<c:when test="${param.attrb eq '08'}">
				<c:forEach var="code" items="${iemCodeList}" varStatus="status">
					<input type="radio" name="MUTICHKG" value="0" id="${status.count}" />${code.codeNm}<br/>
				</c:forEach>
			</c:when>
			<c:when test="${param.attrb eq '09'}">
				<select name="SEQCC1" id="SEQCC1" title="대분류를 선택해 주세요.">
					<option>선택</option>
				</select>
				<select name="SEQCC2" id="SEQCC2" title="중분류를 선택해 주세요.">
					<option>선택</option>
				</select>
			</c:when>
			<c:when test="${param.attrb eq '10'}">
				<textarea name="TEXTA1" id="TEXTA1" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" >내용을 입력하여 주세요.</textarea>
			</c:when>
			<c:when test="${param.attrb eq '11'}">
				<input type="text" name="EMAILID" id="EMAILID" value="" title="이메일 아이디를 입력하세요." />
				@ <input type="text" name="EMAILADDR" id="EMAILADDR" value="" title="이메일 도메인 주소를 입력하세요." />
				<select name="EMILIN" id="EMILIN" title="이메일 도메인을 선택해 주세요.">
					<option>직접입력</option>
				</select>
			</c:when>
			<c:when test="${param.attrb eq '12'}">
				<select name="TPHONE1" id="TPHONE1" title="전화번호 지역번호를 선택해 주세요.">
					<option>지역번호</option>
				</select>
				-
				<input type="text" name="TPHONE2" id="TPHONE2" value="" title="전화번호 중간자리를 입력하세요." />
				-
				<input type="text" name="TPHONE3" id="TPHONE3" value="" title="전화번호 끝자리를 입력하세요." />
			</c:when>
			<c:when test="${param.attrb eq '13'}">
				<select name="MPHONES1" id="MPHONES1" title="이통사 번호를 선택해 주세요.">
					<option>이통사 번호</option>
				</select>
				-
				<input type="text" name="MPHONES2" id="MPHONES2" value="" title="전화번호(휴대폰) 중간자리를 입력하세요." />
				-
				<input type="text" name="MPHONES3" id="MPHONES3" value="" title="전화번호(휴대폰) 끝자리를 입력하세요." />
			</c:when>
			<c:when test="${param.attrb eq '14'}"><br>
				<textarea name="TEXTB1" id="TEXTB1" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';"  title="동의 내용을 입력해 주세요.">내용을 입력하여 주세요.</textarea>
				<label for="CHKSAGR"><input type="checkbox" name="CHKSAGR" id="CHKSAGR" />*****(항목명)에 동의합니다</label>
			</c:when>
			<c:when test="${param.attrb eq '15'}"><br><input type="file" name="FILE4" id="FILE4" title="첨부파일 등록" class="col-md-8" /></c:when>
		</c:choose>
	</td>

	<c:choose>
		<c:when test="${param.mode eq 'i'}">
			<td><input type="checkbox" name="essntlAt{idx}" id="essntlAt{idx}" title="필수여부" value="Y" ></td>
			<td><input type="text" name="sortOrdr{idx}" id="sortOrdr{idx}" value="" title="정렬순서" style="width:30px" maxlength="2" onkeyup="this.value=check_txt(this.value)" ></td>
			<td>
				<input type="hidden" name="iemCodeId{idx}" value="{iemCodeId}">
				<input type="hidden" name="attrb{idx}" value="{attrb}" />
				<a class="btn btn-default btn-sm" href="javascript:delField(this, '0', {idx}, 'N');"><span>- 삭제</span></a>
			</td>
		</c:when>
		<c:otherwise>
			<td class="txt_ct"><input type="checkbox" name="essntlAt${param.idx}" id="essntlAt${param.idx}" title="필수여부" value="Y" <c:if test="${param.essntlAt eq 'Y'}">checked="checked"</c:if>></td>
			<td><input type="text"  class="txt_ct" name="sortOrdr${param.idx}" id="sortOrdr${param.idx}" value="${param.sortOrdr}" title="정렬순서" style="width:30px" maxlength="2" onkeyup="this.value=check_txt(this.value)" ></td>
			<td>
				<input type="hidden" name="iemCodeId${param.idx}" value="${param.iemCodeId}">
				<input type="hidden" name="addinfoSn${param.idx}" value="${param.addinfoSn}" />
				<input type="hidden" name="attrb${param.idx}" value="${param.attrb}" />
				<a class="btn btn-default btn-sm" href="javascript:delField(this, ${param.addinfoSn}, ${param.idx}, 'Y');"><span>- 삭제</span></a>
			</td>
		</c:otherwise>
	</c:choose>
</tr>

