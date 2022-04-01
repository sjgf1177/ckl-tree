

<%@page import="kr.co.unp.util.ZValue"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO"/>
		<!-- Step3 memberInfor -->
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
							<div class="step_wrap">
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
							<div class="step_wrap active">
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

						<div>
							<h3>기본정보입력</h3>
							<div class="sub_board_body">
								<table class="mb25 contents_insight_view contact_us_view style_1">
									<caption>입력내용 확인</caption>
									<colgroup>
									<col style="width:15%" />
									<col  />
									<col style="width:15%"  />
									<col  />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 기관명</th>
											<td colspan="3"><c:out value='${result.nttSj }' /></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 주소</th>
											<td colspan="3"><c:out value='${result.ntcrAddr1 }'/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 기관구분</th>
											<td colspan="3">
												<c:forEach var="code" items="${COM161CodeList}" varStatus="status">
													<c:if test="${code.code eq result.option12}">${code.codeNm}</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th>홈페이지</th>
											<td colspan="3"><c:out value="${result.option2 }" /></td>
										</tr>
										<tr>
											<th>운영목적</th>
											<td colspan="3"><c:out value="${result.option13 }" /></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 기관소개</th>
											<td colspan="3">
												<textarea name="option14" id="option14" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='텍스트를 입력하세요.')this.value='';" onkeyup="if(this.value=='텍스트를 입력하세요.')this.value='';" readonly="readonly" title="기관소개"><c:out value="${result.option14 }" /></textarea>
											</td>
										</tr>
										<tr>
											<th scope="row" colspan="4" style="text-align:center; height:35px;">담당자</th>
										</tr>
										<tr>
											<th scope="row">부서/직급</th>
											<td colspan="3"><c:out value="${result.option1 }"/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 성명</th>
											<td colspan="3"><c:out value="${result.ntcrNm }"/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span>유선전화</th>
											<td colspan="3"><c:out value="${result.ntcrTel1 }"/>-<c:out value="${result.ntcrTel2 }" />-<c:out value="${result.ntcrTel3 }"/></td>
										</tr>
										<tr>
											<th><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 이메일</th>
											<td colspan="3"><c:out value="${result.ntcrEmail1 }" />@<c:out value="${result.ntcrEmail2 }" /></td>
										</tr>
									</tbody>
								</table>
							</div>

							<div>
								<h3>학습정보입력</h3>
							</div>
							<div class="sub_board_body">
								<table class="mb25 contents_insight_view contact_us_view style_1">
								<caption>학습정보입력</caption>
									<colgroup>
									<col style="width:15%"  />
									<col  />
									<col style="width:15%"  />
									<col  />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 운영계획</th>
											<td colspan="3"><c:out value="${result.option15 }"/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 수강 신청기간</th>
											<td colspan="3"><c:out value="${result.option3 }"/> ~ <c:out value="${result.option4 }"/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 학습기간</th>
											<td colspan="3"><c:out value="${result.option16 }"/> ~ <c:out value="${result.option17 }"/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 신청분야</th>
											<td colspan="3">
												<c:forEach items="${COM074CodeList }" var="code"  varStatus="status"  >
												<span class="check_style_0_con">
													<input type="checkbox" value="${code.code }" onclick="return false;" class="check_style_0" id="option18Data${status.count }" name="option18Data${status.count }"
													<c:if test="${fn:indexOf(result.option18, code.code) != -1}">checked="checked"</c:if> />
													<label for="option18Data${status.count }">${code.codeNm }</label>
												</span>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 신청과정</th>
											<td colspan="3"><c:out value="${result.option9 }"/></td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 수료기준</th>
											<td colspan="3">진도 <c:out value="${result.option20 }"/>% 이상
											</td>
										</tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 예상 입과인원</th>
											<td><c:out value="${result.option7 }"/> 명</td>
										</tr>
										<tr>
											<th scope="row"><label for="DOMAIN"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> 요청 도메인</label></th>
											<td colspan="3">http://<input type="text" class="input_style_3" name="DOMAIN" id="DOMAIN" value="<c:out value="${result.option11 }"/>" readonly="readonly" />.edukocca.kr</td>
										</tr>
										<tr>
											<th scope="row"><span class="hide_star"><span class="ally-hidden">(필수입력)</span></span> LOGO 업로드</th>
											<td colspan="3">
												<c:forEach var="fileVO" items="${fileList}" varStatus="status">
													<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<c:out value="${fileVO.fileMg}"/>&nbsp;byte]
												</c:forEach>
											<br />
												 고객님께서 소속하신 단체(기업, 학교, 기관)의 로고이미지 입니다
											</td>
										</tr>
									</tbody>
								</table>
							</div>

						</div>
						<div class="fl board_util_btn_con">
							<a href="/edu/bbs/B0000036/join02.do?menuNo=<c:out value="${param.menuNo }" />&amp;locationTp=prev" class="btn_style_0 blue left">이전</a>
						</div>
						<div class="fr board_util_btn_con">
							<a href="/edu/bbs/<c:out value='${paramVO.bbsId}' />/insert.do?menuNo=<c:out value='${paramVO.menuNo }' />" class="btn_style_0 full right">다음</a>
							<a href="javascript:void(0);" class="btn_style_0 close">취소</a>
						</div>
					<!-- Step3 memberInfor -->
