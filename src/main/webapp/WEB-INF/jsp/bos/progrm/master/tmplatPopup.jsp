<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<div id="content">
	<div id="wrap" class="popupWrap">
           <div class="row">
               <div class="col-md-12">
                   <h1>신청부가정보 속성 항목</h1>
                   <div class="panel panel-default">
                       <div class="panel-body">

						<div class="bdList">
							<table class="table table-bordered">
								<caption>
								</caption>
								<colgroup>
								<col  span="3" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">속성</th>
										<th scope="col">표시형태</th>
										<th scope="col">설명</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="tal"><select name="PROCEL1" id="PROCEL1" title="텍스트 입력 10자를 선택해 주세요.">
										<option>텍스트 입력 10자</option>
										</select></td>
										<td class="tal"><input type="text" name="TEXTPT1" id="TEXTPT1" value="" style="width:130px" title="텍스트를 입력하세요." /></td>
										<td>텍스트 입력 라인 – 최대 10자</td>
									</tr>
									<tr>
										<td class="tal"><select name="PROCEL2" id="PROCEL2" title="텍스트 입력 20자를 선택해 주세요.">
										<option>텍스트 입력 20자</option>
										</select></td>
										<td class="tal"><input type="text" name="TEXTPT2" id="TEXTPT2" value="" style="width:230px" title="텍스트를 입력하세요." /></td>
										<td>텍스트 입력 라인 – 최대 20자</td>
									</tr>
									<tr>
										<td class="tal"><select name="PROCEL3" id="PROCEL3" title="텍스트 입력 30자를 선택해 주세요.">
										<option>텍스트 입력 30자</option>
										</select></td>
										<td class="tal"><input type="text" name="TEXTPT3" id="TEXTPT3" value="" style="width:330px" title="텍스트를 입력하세요." /></td>
										<td>텍스트 입력 라인 – 최대 30자</td>
									</tr>
									<tr>
										<td class="tal"><select name="DATE1" id="DATE1" title="일자를 선택해 주세요.">
										<option>일자</option>
										</select></td>
										<td class="tal"><input type="text" id="sdate" name="sdate"  class="sdate" title="일자 입력" style="width:130px"value="" /></td>
										<td>년월일 입력 선택</td>
									</tr>
									<tr>
										<td class="tal"><select name="DATES2" id="DATES2" title="기간을 선택해 주세요.">
										<option>기간</option>
										</select></td>
										<td class="tal"><input type="text" id="sdate" name="sdate"  class="sdate" title="기간 시작일 입력" style="width:130px"value="" /> ~
											<input type="text" id="edate" name="edate"  class="edate" title="기간 종료일 입력" style="width:130px"value="" /></td>
										<td>기간에 해당하는 년월일 입력 선택</td>
									</tr>
									<tr>
										<td class="tal"><select name="LISTS1" id="LISTS1" title="목록을 선택해 주세요.">
											<option>목록선택</option>
											</select>
											<input type="text" name="LISTTXT" id="LISTTXT" value="" title="선택 코드명을 입력하세요." />
											<a class="btn btn-default btn-sm" href="#self"><span>찾기</span></a>
										</td>
										<td class="tal"><select name="SELS1" id="SELS1" title="선택해 주세요.">
											<option>선택</option>
											</select></td>
										<td>코드 정보를 참조하여 셀렉트박스로 목록 선택</td>
									</tr>
									<tr>
										<td class="tal"><select name="MUTILT1" id="MUTILT1" title="다중선택을 해 주세요.">
											<option>다중선택</option>
											</select>
											<input type="text" name="MULTITXT" id="MULTITXT" value="" title="선택 코드명을 입력하세요." />
											<a class="btn btn-default btn-sm" href="#self"><span>찾기</span></a>
										</td>
										<td><label for="MUTICHKG_0"><input type="checkbox" name="MUTICHKG" value="0" id="MUTICHKG_0" />
												1번 </label>
											<label for="MUTICHKG_1"><input type="checkbox" name="MUTICHKG" value="1" id="MUTICHKG_1" />
												2번</label>
											<label for="MUTICHKG_2"><input type="checkbox" name="MUTICHKG" value="2" id="MUTICHKG_2" />
												3번</label>
											<label for="MUTICHKG_3"><input type="checkbox" name="MUTICHKG" value="3" id="MUTICHKG_3" />
												4번</label></td>
										<td>코드 정보를 참조하여 다중선택 체크로 목록 선택</td>
									</tr>
									<tr>
										<td class="tal"><select name="SINGLE1" id="SINGLE1" title="단일선택을 해 주세요.">
											<option>단일선택</option>
											</select>
											<input type="text" name="SINGLETXT" id="SINGLETXT" value="" title="선택 코드명을 입력하세요." />
											<a class="btn btn-default btn-sm" href="#self"><span>찾기</span></a>
										</td>
										<td><label for="SINGLEGP1_0"><input type="radio" name="SINGLEGP1" value="라디오" id="SINGLEGP1_0" /> 1번</label>
											<label for="SINGLEGP1_1"><input type="radio" name="SINGLEGP1" value="라디오" id="SINGLEGP1_1" /> 2번 </label>
											<label for="SINGLEGP1_3"><input type="radio" name="SINGLEGP1" value="라디오" id="SINGLEGP1_3" /> 3번</label>
											<label for="SINGLEGP1_4"><input type="radio" name="SINGLEGP1" value="라디오" id="SINGLEGP1_4" /> 4번 </label></td>
										<td>코드 정보를 참조하여 단일선택 라디오버튼으로 목록 선택</td>
									</tr>
									<!-- <tr>
										<td class="tal"><select name="SEQS1" id="SEQS1" title="계층형 선택을 해 주세요.">
											<option>계층형 선택</option>
											</select>
											<input type="text" name="SEQSTXT" id="SEQSTXT" value="" title="선택 코드명을 입력하세요." />
											<a class="btn btn-default btn-sm" href="#self"><span>찾기</span></a>
										</td>
										<td class="tal"><select name="SEQCC1" id="SEQCC1" title="대분류를 선택해 주세요.">
											<option>선택</option>
											</select>
											<select name="SEQCC2" id="SEQCC2" title="중분류를 선택해 주세요.">
											<option>선택</option>
											</select>
											</td>
										<td>2depth 항목을 순서대로 선택하는계층구조 선택</td>
									</tr> -->
									<tr>
										<td class="tal"><select name="TEXTARAS1" id="TEXTARAS1" title="텍스트(AREA)를 선택해 주세요.">
											<option>텍스트(AREA)</option>
											</select>
										</td>
										<td class="tal"><textarea name="TEXTA1" id="TEXTA1" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';" >내용을 입력하여 주세요.</textarea>
										</td>
										<td>텍스트 AREA – 최대 3000자</td>
									</tr>
									<tr>
										<td class="tal"><select name="EML1" id="EML1" title="이메일를 선택해 주세요.">
											<option>이메일</option>
											</select></td>
										<td class="tal"><input type="text" name="EMAILID" id="EMAILID" value="" title="이메일 아이디를 입력하세요." />
											@ <input type="text" name="EMAILADDR" id="EMAILADDR" value="" title="이메일 도메인 주소를 입력하세요." />
											<select name="EMILIN" id="EMILIN" title="이메일 도메인을 선택해 주세요.">
											<option>직접입력</option>
											</select>
										</td>
										<td>이메일 정보를 입력직접입력 및 목록선택 템플릿</td>
									</tr>
									<tr>
										<td class="tal"><select name="TPHO1" id="TPHO1" title="전화번호(지역)를 선택해 주세요.">
											<option>전화번호(지역)</option>
											</select></td>
										<td class="tal"><select name="TPHONE1" id="TPHONE1" title="전화번호 지역번호를 선택해 주세요.">
												<option>지역번호</option>
											</select>
											-
											<input type="text" name="TPHONE2" id="TPHONE2" value="" title="전화번호 중간자리를 입력하세요." />
											-
											<input type="text" name="TPHONE3" id="TPHONE3" value="" title="전화번호 끝자리를 입력하세요." />
										</td>
										<td>지역번호 선택 및 입력</td>
									</tr>
									<tr>
										<td class="tal"><select name="MPHONE1" id="MPHONE1" title="휴대폰번호를 선택해 주세요.">
												<option>전화번호(휴대폰)</option>
											</select></td>
										<td class="tal"><select name="MPHONES1" id="MPHONES1" title="이통사 번호를 선택해 주세요.">
												<option>이통사 번호</option>
											</select>
											-
											<input type="text" name="MPHONES2" id="MPHONES2" value="" title="전화번호(휴대폰) 중간자리를 입력하세요." />
											-
											<input type="text" name="MPHONES3" id="MPHONES3" value="" title="전화번호(휴대폰) 끝자리를 입력하세요." /></td>
										<td>휴대폰 국번 선택 및 입력</td>
									</tr>
									<tr>
										<td class="tal"><select name="AGRES1" id="AGRES1" title="이통사 번호를 선택해 주세요.">
												<option>동의선택</option>
											</select>
											<textarea name="TEXTB1" id="TEXTB1" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';"  title="동의 내용을 입력해 주세요.">내용을 입력하여 주세요.</textarea>


										</td>
										<td class="tal"><textarea name="TEXTB1" id="TEXTB1" cols="120" rows="12" class="col-md-12" onfocus="if(this.value=='내용을 입력하여 주세요.')this.value='';" onkeyup="if(this.value=='내용을 입력하여 주세요.')this.value='';"  title="동의 내용을 입력해 주세요.">내용을 입력하여 주세요.</textarea>
											<label for="CHKSAGR"><input type="checkbox" name="CHKSAGR" id="CHKSAGR" />
											  *****(항목명)에 동의합니다</label>

										</td>
										<td>사용자에게 &lsquo;저작권 이용정책&rsquo; 등 운영상의 권리사항에 대한 동의를 얻는 기능</td>
									</tr>
									<tr>
										<td class="tal"><select name="AFIL1" id="AFIL1" title="파일첨부를 선택해 주세요.">
												<option>파일첨부</option>
											</select></td>
										<td class="tal"><input type="file" name="FILE4" id="FILE4" title="첨부파일 등록" class="col-md-8" /> </td>
										<td>파일 첨부 기능<br />
										※ 최대 10MB 가능</td>
									</tr>
								</tbody>
							</table>
						</div>

                       </div>
                   </div>
			</div>
		</div>
	</div>
</div>