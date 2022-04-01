<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript">
//<![CDATA[

$(window).ready(function() {
// 	$.datepicker.setDefaults($.datepicker.regional['ko']);
// 	$(".calendar").datepicker({showOn: 'button', buttonImage: '/bos/images/calendar.gif', buttonImageOnly: true, changeMonth: true, changeYear: true, showMonthAfterYear:false});
	email_change();

});

	function checkForm() {

	 	var form = $("#agreeForm")[0];
		var v = new MiyaValidator(form);
		
		var option18 = "";
		$(":input[name^=option18Data]:checked").each(function() {
			option18 += $(this).val() + ",";
		});

		option18 = option18.substring(0, option18.length - 1);
		$("#option18").val(option18);


		v.add("nttSj", {
			required : true
		});

		v.add("ntcrAddr1", {
			required : true
		});

		v.add("option1", {
			required : true
		});
		
		v.add("ntcrNm", {
			required : true
		});

		v.add("ntcrTel1", {
			required : true
		});

		v.add("ntcrTel2", {
			required : true
		});

		v.add("ntcrTel3", {
			required : true
		});

		v.add("ntcrEmail1", {
			required : true
		});

		v.add("ntcrEmail2", {
			required : true
		});
		
		v.add("option12", {
		    required: true
		});
		
		v.add("option13", {
		    required: true
		});
		
		v.add("option14", {
		    required: true
		});
		
		v.add("option15", {
		    required: true
		});
		
		v.add("option3", {
			required : true
		});

		v.add("option4", {
			required : true
		});
		
		v.add("option16", {
			required : true
		});

		v.add("option17", {
			required : true
		});

		v.add("option18", {
		    required: true,
		    mincheck: 1,
		});
		
		v.add("option9", {
		    required: true,
		    mincheck: 1,
		});
		
		v.add("option20", {
		    required: true,
		    mincheck: 1,
		});
		
		v.add("option7", {
			required : true
		});
		
		v.add("option11", {
			required : true
		});

		v.add("logImage", {
			required : true
		});
		

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}

		if (!confirm('등록하시겠습니까?')) {
			return false;
		}

		

	}

	function email_change() {
		$('select.email_addr').change(function() {
			if ($(this).val() == 'emaildomain_false') {
				$('.email_addr:text[name=ntcrEmail2]').val('');
				$('.email_addr').attr('readonly', false).focus();
			} else {
				$('.email_addr:text[name=ntcrEmail2]').val('');
				$('.email_addr:text[name=ntcrEmail2]').val($(this).val());
				$('.email_addr').attr('readonly', true);
			}
		});
	}

//]]>
</script>
		<div class="signup_step_bar">
			<div class="step_wrap">
				<p class="step_box">
					<span class="step_title">
						STEP1
					</span>
					개인정보 동의
				</p>
			</div>
			<div class="step_line_wrap">
				<div class="step_right_arrow"></div>
			</div>
			<div class="step_wrap active">
				<p class="step_box">
					<span class="step_title">
						STEP2
					</span>
					신청 정보 입력
				</p>
			</div>
			<div class="step_line_wrap">
				<div class="step_right_arrow"></div>
			</div>
			<div class="step_wrap">
				<p class="step_box">
					<span class="step_title">
						STEP3
					</span>
					입력내용 확인
				</p>
			</div>
			<div class="step_line_wrap">
				<div class="step_right_arrow"></div>
			</div>
			<div class="step_wrap">
				<p class="step_box">
					<span class="step_title">
						STEP4
					</span>
					신청완료
				</p>
			</div>
		</div>
		<form name="agreeForm" id="agreeForm" action="/edu/bbs/B0000036/join03.do" method="post" enctype="multipart/form-data" class="form-inline"  onsubmit="return checkForm(this);return false;">
			<input type="hidden" name="pageQueryString" value="<c:out value='${pageQueryString }' />">
			<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
			<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
			<input type="hidden" value="${paramVO.menuNo }" name="menuNo">
			<input type="hidden" id="option18" name="option18" value="" />


			<div>
				<h3>기본정보입력</h3>
				<div class="sub_board_body">
					<p class="board_caption">
						<span><span class="ally-hidden">(필수)</span>표시 항목은 필수 입력 항목입니다.</span>
					</p>
					<table class="mb25 contents_insight_view contact_us_view style_1">
						<caption>신청정보입력</caption>
						<colgroup>
							<col style="width: 15%" />
							<col />
							<col style="width: 15%" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="nttSj"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 기관명</label></th>
								<td colspan="3">
									<input type="text" name="nttSj" id="nttSj" title="단체명" value="" class="input_style_3"/ >
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="ntcrAddr1"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 주소</label></th>
								<td colspan="3">
								<input type="text" name="ntcrAddr1" id="ntcrAddr1" style="width: 100%;" title="" value="" class="input_style_3"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>기관구분</th>
								<td colspan="3">
									<c:forEach items="${COM161CodeList }" var="code" varStatus="status">
									
										<span class="radio_box_con">
											<input type="radio" value="<c:out value='${code.code }'/>" id="option12Data${status.count }" title="신청분야" name="option12" class="radio_style_0"/>
											<label for="option12Data${status.count }">${code.codeNm }</label>
										</span>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<th><label for="option2">홈페이지</label></th>
								<td colspan="3"><input type="text" name="option2" id="option2" title="홈페이지" value="" class="input_style_3"/></td>
							</tr>
							<tr>
								<th><label for="option13"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>운영목적</label></th>
								<td colspan="3"><input type="text" name="option13" id="option13" title="운영목적" value="" class="input_style_3" style="width:100%"/></td>
							</tr>
							<tr>
								<th><label for="option14"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>기관소개</label></th>
								<td colspan="3"><textarea name="option14" id="option14" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='텍스트를 입력하세요.')this.value='';" onkeyup="if(this.value=='텍스트를 입력하세요.')this.value='';" title="기관소개를 입력해주세요." style="width:100%"></textarea></td>
							</tr>
							
							<tr>
								<th scope="row" colspan="4" style="text-align:center; height:35px;">담당자</th>
							</tr>
							<tr>
								<th scope="row"><label for="option1"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 부서/직급</label></th>
								<td colspan="3"><input type="text" name="option1" id="option1" value="" title="부서/직급" class="input_style_3" /></td>
							</tr>
							<tr>
								<th scope="row"><label for="ntcrNm"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 성명</label></th>
								<td colspan="3"><input type="text" name="ntcrNm" id="ntcrNm" value="" class="input_style_3"/></td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 유선전화</th>
								<td colspan="3">
									<select name="ntcrTel1" id="ntcrTel1" title="유선전화 앞자리를 선택해 주세요.">
										<option value="" selected="selected">선택</option>
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
										<option value="0505">0505</option>
										<option value="0506">0506</option>
									</select> - 
									<span class="input_style_0_con" style="display:inline">
										<input type="text" name="ntcrTel2" id="ntcrTel2" class="w20p input_style_3"  value="" maxlength="4" title="유선전화 중간자리를 입력하세요." />
									</span>
									 - 
									<input type="text" name="ntcrTel3" id="ntcrTel3" class="w20p input_style_3" value="" maxlength="4" title=" 유선전화 끝자리를 입력하세요." />
								</td>
							</tr>
							<tr>
								<th><label for="ntcrEmail1"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 이메일</label></th>
								<td colspan="3">
								<input type="text" name="ntcrEmail1" id="ntcrEmail1" class="w20p input_style_3" value="" title="이메일 아이디를 입력하세요."  style="min-width:120px;"/> @ <input type="text" name="ntcrEmail2" id="ntcrEmail2" class="w30p input_style_3 email_addr" readonly="readonly" value="" title="이메일 도메인 주소를 입력하세요." style="min-width:120px"/>
								<select id="sr_email_more" name="sr_email_more" class="input_select email_addr" style="width: auto" title="이메일 도메인 선택">
										<option value=""> 이메일 선택 </option>
										<option value="gmail.com">gmail.com</option>
										<option value="naver.com">naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="daum.net">daum.net</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="emaildomain_false">직접입력</option>

								</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div>
						<h3>학습정보입력</h3>
					</div>
					<p class="board_caption">
						<span>표시 항목은 필수 입력 항목입니다.</span>
					</p>
					<table class="mb25 contents_insight_view contact_us_view style_1">
						<caption>학습정보입력</caption>
						<colgroup>
							<col style="width: 15%" />
							<col />
							<col style="width: 15%" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>운영계획</th>
								<td colspan="3">
									<span class="radio_box_con">
										<input type="radio" value="정기" id="option15Data1" title="운영계획" name="option15" class="radio_style_0"/>
										<label for="option15Data1">정기</label>
									</span>
									
									<span class="radio_box_con">
										<input type="radio" value="비정기" id="option15Data2" title="운영계획" name="option15" class="radio_style_0"/>
										<label for="option15Data2">비정기</label>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 수강 신청기간</th>
								<td colspan="3">
									<input type="text" id="option3" name="option3" class="sdate input_style_3" title="수강신청 시작일 입력" readonly="readonly" style="width: 130px" value="" />~ 
									<input type="text" id="option4" name="option4" class="edate input_style_3" readonly="readonly" title="수강신청 종료일 입력" style="width: 130px" value="" />
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="option6"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>학습기간</label></th>
								<td colspan="3">
									<input type="text" id="option16" name="option16" class="sdate input_style_3" title="학습 시작일 입력" readonly="readonly" style="width: 130px" value="" />~ 
									<input type="text" id="option17" name="option17" class="edate input_style_3" readonly="readonly" title="학습 종료일 입력" style="width: 130px" value="" />
								</td>
								
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>신청분야</th>
								<td colspan="3">
								<c:forEach items="${COM074CodeList }"  varStatus="status"  var="code">
									<span class="check_style_0_con">
										<input type="checkbox" name="option18Data" class="check_style_0" id="option18Data${status.count }" value="<c:out value='${code.code }'/>" />
										<label for="option18Data${status.count }" class="option18Data${status.count }">${code.codeNm }</label>
									</span>
								</c:forEach>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 신청과정 </th>
								<td colspan="3">
									<%-- <div>
										<c:forEach items="${COM075CodeList }" var="code" varStatus="status">
											<span class="check_style_0_con">
												<input type="checkbox" name="option19Data" class="check_style_0" id="option19Data${status.count }" value="<c:out value='${code.code }'/>" />
												<label for="option19Data${status.count }" class="option19Data${status.count }">${code.codeNm }</label>
											</span>
										</c:forEach>
									</div> --%>
									<input type="text" name="option9" id="option9" title="신청과정" value="" class="input_style_3" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>수료기준</th>
								<td colspan="3">
									<span class="radio_box_con">
										<input type="radio" value="60" id="option20Data1" title="수료기준" name="option20" class="radio_style_0"/>
										<label for="option20Data1">진도 60% 이상</label>
									</span>
									<span class="radio_box_con">
										<input type="radio" value="80" id="option20Data2" title="수료기준" name="option20" class="radio_style_0"/>
										<label for="option20Data2">진도 80% 이상</label>
									</span>
									<span class="radio_box_con">
										<input type="radio" value="100" id="option20Data3" title="수료기준" name="option20" class="radio_style_0"/>
										<label for="option20Data3">진도 100% 이상</label>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="option7"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 예상 입과인원</label></th>
								<td><input type="text" class="input_style_3" name="option7" id="option7" value="" style="max-width:80px;"/> 명</td>
							</tr>
							<tr>
								<th scope="row"><label for="option11"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 요청 도메인</label></th>
								<td colspan="3">http://<input type="text" class="input_style_3" name="option11" id="option11" value="" title="요청도메인" />.edukocca.kr
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="logImage"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> LOGO 업로드</label></th>
								<td colspan="3">
									<input type="file" name="logImage" id="logImage" title="대표이미지 등록 " class="col-md-8" style="border:1px solid #e3e6e9; border-radius:3px; margin-bottom:8px;"/><br />
									<div class="text-danger clear">고객님께서 소속하신 단체(기업, 학교, 기관)의 로고이미지(gif, jpg, png)를 등록하여 주세요.</div>
								</td>
							</tr>
						</tbody>
					</table>
					
				</div>

			</div>
			<div class="fl board_util_btn_con">
				<a href="/edu/bbs/B0000036/join01.do?menuNo=<c:out value="${param.menuNo }" />&amp;locationTp=prev" class="btn_style_0 blue left">이전</a>
			</div>
			<div class="fr board_util_btn_con">
				<button type="submit" class="btn_style_0 full right">다음</button>
				<a href="javascript:void(0);" class="btn_style_0 close">취소</a>
			</div>
		</form>


<%--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>


