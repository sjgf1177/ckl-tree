
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


<div class="tab_style_1_con"> 
	<ul class="tab_style_1 four_tab">
		<li>
			<a href="/edu/main/contents.do?menuNo=500086">
				<span>학습가이드</span>
			</a>
		</li>
		<li>
			<a href="/edu/main/contents.do?menuNo=500087">
				<span>학습환경 설정</span>
			</a>
		</li>
		<li>
			<a href="/edu/main/contents.do?menuNo=500090">
				<span>원격지원서비스</span>
			</a>
		</li>
		<li class="active">
			<a href="/edu/onlineEdu/edcsystm/list.do?menuNo=500030" title="현재탭">
				<span>교육체계도</span>
			</a>
		</li>
	</ul>
</div>

<!--content-->

<sec:authentication var="user" property="principal"/>
<c:set value="${user != 'anonymousUser' ? user.username : '' }" var="userVrify" />
<c:set value="${userVrify }" var="idCeck" />
<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
	<input type="hidden" name="p_chartcode" id="p_chartcode" value="" />
	<input type="hidden" name="p_jobtype" id="p_jobtype" value="" />
	
	<input type="hidden" name="p_subj" id="p_subj" value="" />
	<input type="hidden" name="p_year" id="p_year" value="" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" value="" />
	

</form>

<!-- 
<div class="contents_eduFrame_header">
	<img src="/edu/images/bm/sub_main_visual_img_007.png" style="text-align: center; width: 100%"/>
</div>
-->
<!-- 설명 텍스트 -->
<div class="mb37 alert big_box type_1">
    <p class="alert_desc is_margin_desc">
        온라인 과정의 <span class="apply_no_text">교육체계도 및 추천 Track</span>을 확인하실 수 있습니다.
    </p>
    <p class="alert_desc">
        원하는 Track을 클릭하셔서 <span class="apply_no_text">세부 내용을 확인</span>하세요.
    </p>
</div>
<!-- //설명 텍스트 -->
<c:forEach var="result1" items="${eduSystemAList}" varStatus="status">
	<div class="eduframe_wrap pr5">
	    <div class="eduframe_con">
	        <div class="eduframe_head">
	            <h5><c:out value='${result1.chartname}'/></h5>
	        </div>
	        <div class="eduframe_inner">
	            <h6>[ <c:out value='${result1.chartname}'/>분야 역량강화를 위한 추천트랙 ]</h6>
	            <ul class="eduframe_list">
	            	<c:choose>
		            	<c:when test="${result1.islast eq 'Y'}">
		            		<li><a href="javascript:void(0);"><c:out value='${result1.chartname }'/>&nbsp;Track</a></li>
		                </c:when>
		                <c:otherwise>
			                <c:forEach var="result2" items="${eduSystemBList}" varStatus="status">
			            		<c:if test="${result2.upperchartcode eq result1.chartcode}">
			                		<li><a href="javascript:void(0);"><c:out value='${result1.chartname }'/>&nbsp;<c:out value='${result2.chartname }'/> Track</a></li>
			                	</c:if>
			                </c:forEach>
		                </c:otherwise>
	                </c:choose>
	            </ul>
	        </div>
	    </div>
	</div>
</c:forEach>

<c:forEach var="result1" items="${eduSystemAList}" varStatus="status">
	<c:choose>
		<c:when test="${result1.islast eq 'N'}">
			<c:forEach var="result2" items="${eduSystemBList}" varStatus="status">
				<c:if test="${result2.upperchartcode eq result1.chartcode}">
					<div class="col-12 popup_wrap academy_pop" style="display:none;">
						<div class="col-10 col-center popup_con">
							<div class="col-12 popup_style_0 type1">
								
								<div class="col-12 popup_title_wrap">
						            <div class="popup_title">
						                 <c:out value='${result1.chartname}'/>&nbsp;<c:out value='${result2.chartname}'/>&nbsp;Track
						            </div>
						            <div class="popup_close_btn_con">
						                <a href="javascript:void(0)" class="popup_close_btn">
						                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
						                </a>
						            </div>
					        	</div>
					        	
					        	<div class="col-12 popup_contents_wrap">
					        		<div class="eduframe_pop_contents_con">
					        			<h7>개요</h7>
				                		<p class="desc" style="white-space:pre;"><c:out value='${result2.summary}'/></p>
					        		</div>
					        		<c:if test="${not empty result2.jobarea}">
						        		<div class="eduframe_pop_contents_con">
						        			<h7>직업군</h7>
					                		<p class="desc" style="white-space:pre;"><c:out value='${result2.jobarea}'/></p>
						        		</div>
					        		</c:if>
					        		<c:if test="${not empty result2.capacity}">
						        		<div class="eduframe_pop_contents_con">
						        			<h7>필요역량</h7>
					                		<p class="desc" style="white-space:pre;"><c:out value='${result2.capacity}'/></p>
						        		</div>
					        		</c:if>
					        		<div class="eduframe_pop_contents_con">
					        			<h7>추천과정</h7>
					        			<ol class="decimal">
						        			<c:forEach var="result3" items="${eduSystemSubjList}" varStatus="status">
						        				<c:if test="${result2.chartcode eq result3.chartcode}">
					                                <li><span class="list_num"><c:out value='${result3.no}'/></span>
					                                	<c:out value='${result3.subjnm}'/>
					                                	<button type="button" onclick="fnCmdViewPage('<c:out value='${result3.subj}'/>', '<c:out value='${result3.year}'/>', '<c:out value='${result3.subjseq}'/>'); return false;">상세보기</button>
					                                </li>
						        				</c:if>
						        			</c:forEach>
					        			</ol>
					        		</div>
					        	</div>	
							</div>
						</div>
						<div class="col-12 popup_dim"></div>
					</div>
				</c:if>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<div class="col-12 popup_wrap academy_pop" style="display:none;">
				<div class="col-10 col-center popup_con">
					<div class="col-12 popup_style_0 type1">
						<div class="col-12 popup_title_wrap">
				            <div class="popup_title">
				                 <c:out value='${result1.chartname}'/>&nbsp;Track
				            </div>
				            <div class="popup_close_btn_con">
				                <a href="javascript:void(0)" class="popup_close_btn">
				                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
				                </a>
				            </div>
			        	</div>
			        	<div class="col-12 popup_contents_wrap">
			        		<div class="eduframe_pop_contents_con">
			        			<h7>개요</h7>
		                		<p class="desc" style="white-space:pre;"><c:out value='${result1.summary}'/></p>
			        		</div>
			        		<c:if test="${not empty result2.jobarea}">
						   		<div class="eduframe_pop_contents_con">
						   			<h7>직업군</h7>
					            		<p class="desc" style="white-space:pre;"><c:out value='${result2.jobarea}'/></p>
						   		</div>
					        </c:if>
					        <c:if test="${not empty result2.capacity}">
						    	<div class="eduframe_pop_contents_con">
						    		<h7>필요역량</h7>
					             		<p class="desc" style="white-space:pre;"><c:out value='${result2.capacity}'/></p>
						    	</div>
					        </c:if>
			        		
			        		<div class="eduframe_pop_contents_con">
			        			<h7>추천과정</h7>
			        			<ol class="decimal">
				        			<c:forEach var="result3" items="${eduSystemSubjList}" varStatus="status">
				        				<c:if test="${result1.chartcode eq result3.chartcode}">
			                                <li><span class="list_num"><c:out value='${result3.no}'/></span>
			                                	<c:out value='${result3.subjnm}'/>
			                                	<button type="button" onclick="fnCmdViewPage('<c:out value='${result3.subj}'/>', '<c:out value='${result3.year}'/>', '<c:out value='${result3.subjseq}'/>'); return false;">상세보기</button>
			                                </li>
				        				</c:if>
				        			</c:forEach>
			        			</ol>
			        		</div>
			        	</div>
					</div>
				</div>
				<div class="col-12 popup_dim"></div>
			</div>
		</c:otherwise>
	</c:choose>
</c:forEach>

<!-- popup 교육체계도 - 방송영상 기획 Track-->
<%-- <div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                방송영상 기획 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    기획 Track의 직무는 크게 구성 및 제작기획과 시나리오(대본) 작성으로 분류됩니다.<br/>
                    본 Track의 직업군들은 시나리오 작가를 제외하고 두 직무의 기본 역량이 모두 필요하기 때문에 기본에 해당되는 교육은<br/>
                    공통 기초지식으로 수강하고, 실무에서 직업군에 따라 선택하여 듣는다면 방송영상 분야의 기획 직무 수행 시 도움이 될 것입니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>구성 및 제작 기획</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">제작자 : </span>디지털케이블 방송제작자, 영화기획자, 인터넷 온라인 교육 프로그램 제작자 등
                    </li>
                    <li><span class="eduframe_list_tit">PD : </span>TV 드라마 연출가, 프로그램(예능, 교양, 다큐멘터리) PD 등</li>
                </ul>
                <h8>시나리오(대본) 작성</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">구성작가 : </span>라디오/교양/다큐멘터리/예능 작가 등</li>
                    <li><span class="eduframe_list_tit">시나리오작가 : </span>영화시나리오 작가, 드라마 작가 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>구성 및 제작 기획</th>
            <td>프로그램 기획력(창의력) / 프로그램 분석력 / 제작 기획 능력 / 제작 관리 능력</td>
        </tr>
        <tr>
            <th>시나리오(대본) 작성</th>
            <td>스토리 구성 역량 / 자료 수집력 / 글쓰기 역량 / 장르별 시나리오 작성 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>구성 및 제작 기획 TRM</h7>
    <div class="trm_inner_con">
        <h8>제작자 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>구성 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송아나운싱<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB09139', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>방송영상콘텐츠기획<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB10012', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>성공적인프레젠테이션을 위한 Prezi 활용<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>아이디어발상<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CG12002', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>영상으로 이야기 전달하기 - 이해<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CB14001', '2015', '0059'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>구성 및 제작기획 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>다큐멘터리트레일러 만들기와 피칭전략<a href="javascript:void(0);"
                                                                                         onclick="fnCmdViewPage('CB10011', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>방송제작실무<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10022', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>영상으로이야기 전달하기 - 활용<a href="javascript:void(0);"
                                                                                       onclick="fnCmdViewPage('CB14002', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>프로듀서가이야기하는 우리 프로그램 이렇게 만들었다<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CK11005', '2015', '0066'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>프리프로덕션(다큐멘터리)<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB14005', '2015', '0012'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <h8>PD 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>구성 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송아나운싱<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB09139', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>방송영상콘텐츠기획<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB10012', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>성공적인프레젠테이션을 위한 Prezi 활용<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>시나리오 작성 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>11가지법칙으로 끝내는 스토리텔링<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CK10071', '2015', '0080'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>글쓰기를위한 창조적 사고<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB12003', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>디지털미디어스토리텔링<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CB09132', '2015', '0055'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>방송콘텐츠스토리텔링<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>스토리텔링개론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CK10006', '2015', '0067'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>스토리텔링의이해<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CK06093', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>통하는글쓰기 기본<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB12004', '2015', '0059'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>시나리오 작성 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>다큐멘터리트레일러 만들기와 피칭전략<a href="javascript:void(0);"
                                                                                         onclick="fnCmdViewPage('CB10011', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>방송제작실무<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10022', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>프로듀서가이야기하는 우리 프로그램 이렇게 만들었다<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CK11005', '2015', '0066'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>시나리오 작성 TRM</h7>
    <div class="trm_inner_con">
        <h8>구성 작가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>구성 및 제작기획</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송아나운싱<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB09139', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>방송영상콘텐츠기획<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB10012', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>성공적인프레젠테이션을 위한 Prezi 활용<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>시나리오 작성 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>11가지법칙으로 끝내는 스토리텔링<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CK10071', '2015', '0080'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>글쓰기를위한 창조적 사고<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB12003', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>디지털미디어스토리텔링<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CB09132', '2015', '0055'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>방송콘텐츠스토리텔링<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>스토리텔링개론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CK10006', '2015', '0067'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>스토리텔링의이해<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CK06093', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>통하는글쓰기 기본<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB12004', '2015', '0059'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>시나리오 작성 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송콘텐츠스토리텔링<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <h8>시나리오 작가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>시나리오 작성 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>11가지법칙으로 끝내는 스토리텔링<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CK10071', '2015', '0080'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>글쓰기를위한 창조적 사고<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB12003', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>디지털미디어스토리텔링<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CB09132', '2015', '0055'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>방송콘텐츠스토리텔링<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>스토리텔링개론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CK10006', '2015', '0067'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>스토리텔링의이해<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CK06093', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>통하는글쓰기 기본<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB12004', '2015', '0059'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>시나리오 작성 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송콘텐츠스토리텔링<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 방송영상 기획 Track-->

<!-- popup 교육체계도 - 방송영상 연출 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                방송영상 연출 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 연출,촬영,편집으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 최소 6과정 이상을 다양한 방법으로 이수할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>영상 연출</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">연출PD : </span>PD(기획 Track PD군과 중복),영화 감독 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>영상연출</th>
            <td>영상 구성력 / 영화 연출 스킬 / TV 연출 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>연출 TRM</h7>
    <div class="trm_inner_con">
        <h8>PD 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>연출 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>문화콘텐츠연출론<a href="javascript:void(0);" onclick="fnCmdViewPage('CG10012', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>촬영에서편집까지 비주얼 스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CB11002', '2015', '0068'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>촬영기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송음향기초<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10014', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>영상창작의 기본 - 조명<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB11001', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>영상미학<a href="javascript:void(0);"
                                                                          onclick="fnCmdViewPage('CB09150', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>영상촬영기본<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10026', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>전문가도부럽지 않은 DSLR 활용하기<a href="javascript:void(0);"
                                                                                          onclick="fnCmdViewPage('CB12007', '2015', '0074'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>정재형의영화로 보는 영상미학<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CB09154', '2015', '0062'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>편집기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>AdobePremiere Pro CS5<a href="javascript:void(0);"
                                                                                           onclick="fnCmdViewPage('CB10017', '2015', '0069'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>AfterEffect CS5<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CB10015', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>AutodeskMaya를 이용한 입체영상 제작<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10021', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>AvidMedia Composer Advanced<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10016', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>기초를다지기 위한 Cinema4D<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CB12006', '2015', '0062'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>연출실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>TV다큐멘터리의이론과 실제<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CB12002', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>스튜디오프로그램제작<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB09147', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>영상제작전문가특강(연출론)<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CB11003', '2015', '0049'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 방송영상 연출 Track-->

<!-- popup 교육체계도 - 방송영상 촬영 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                방송영상 촬영 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 연출,촬영,편집으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 최소 6과정 이상을 다양한 방법으로 이수할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>촬영 조명/음향/미술/카메라</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">촬영관련감독 : </span>방송국카메라맨, 촬영기사, 촬영감독, 지미집 감독, 조명감독</li>
                    <li><span class="eduframe_list_tit">편집기술감독 : </span>지상파 및 케이블 방송사 기술 스텝, 기술인 컨소시엄 그룹,
                        방송통신산업기사, 방송영상 기사, 영상편집기사(엔지니어). 편집감독
                    </li>
                    <li><span class="eduframe_list_tit">무대디자이너 : </span>무대 디자이너, 무대 연출가</li>
                    <li><span class="eduframe_list_tit">음향 전문가 : </span>:레코딩엔지니어, p.a 엔지니어, 사운드디자이너, 음향 연출가,
                        음악감독 등
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>촬영조명</th>
            <td>조명 기본 지식 / 방송 조명 / 장르별 조명 연출 스킬 / 상황별 조명 연출 스킬</td>
        </tr>
        <tr>
            <th>촬영음향</th>
            <td>음향 기본 지식 / 음향 기기 지식 / 음향 시스템 지식 / 음향 제작 기술</td>
        </tr>
        <tr>
            <th>촬영미술</th>
            <td>무대 연출 / 미술 제작</td>
        </tr>
        <tr>
            <th>촬영카메라</th>
            <td>영상 구현에 대한 지식 / 색채표현스킬 / 카메라촬영스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>촬영 TRM</h7>
    <div class="trm_inner_con">
        <h8>촬영 감독 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>촬영기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송음향기초<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10014', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>영상창작의 기본 - 조명<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB11001', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>영상미학<a href="javascript:void(0);"
                                                                          onclick="fnCmdViewPage('CB09150', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>영상촬영기본<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10026', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>전문가도부럽지 않은 DSLR 활용하기<a href="javascript:void(0);"
                                                                                          onclick="fnCmdViewPage('CB12007', '2015', '0074'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>정재형의영화로 보는 영상미학<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CB09154', '2015', '0062'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>편집기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>AdobePremiere Pro CS5<a href="javascript:void(0);"
                                                                                           onclick="fnCmdViewPage('CB10017', '2015', '0069'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>AfterEffect CS5<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CB10015', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>AutodeskMaya를 이용한 입체영상 제작<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10021', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>AvidMedia Composer Advanced<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10016', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>기초를다지기 위한 Cinema4D<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CB12006', '2015', '0062'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>촬영실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>3D입체촬영실무<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CB10024', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>영상제작전문가특강(영상론)<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CB11004', '2015', '0049'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 방송영상 촬영 Track-->

<!-- popup 교육체계도 - 방송영상 편집 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                방송영상 편집 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 연출,촬영,편집으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 최소 6과정 이상을 다양한 방법으로 이수할 수 있습니다
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>편집</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">촬영관련감독 : </span>방송국카메라맨, 촬영기사, 촬영감독, 지미집 감독, 조명감독</li>
                    <li><span class="eduframe_list_tit">편집기술감독 : </span>지상파 및 케이블 방송사 기술 스텝, 기술인 컨소시엄 그룹,
                        방송통신산업기사, 방송영상 기사, 영상편집기사(엔지니어). 편집감독
                    </li>
                    <li><span class="eduframe_list_tit">무대디자이너 : </span>무대 디자이너, 무대 연출가</li>
                    <li><span class="eduframe_list_tit">음향 전문가 : </span>레코딩엔지니어, p.a 엔지니어, 사운드디자이너, 음향 연출가, 음악감독
                        등
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>편집</th>
            <td>3D, 4D 그래픽 제작 및 변환스킬 / 색 보정 스킬 / 편집 Tool 이용 스킬 / 음향 보정 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>편집 TRM</h7>
    <div class="trm_inner_con">
        <h8>편집기술 감독 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>촬영기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송음향기초<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10014', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>영상창작의 기본 - 조명<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB11001', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>영상미학<a href="javascript:void(0);"
                                                                          onclick="fnCmdViewPage('CB09150', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>영상촬영기본<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10026', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>전문가도부럽지 않은 DSLR 활용하기<a href="javascript:void(0);"
                                                                                          onclick="fnCmdViewPage('CB12007', '2015', '0074'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>정재형의영화로 보는 영상미학<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CB09154', '2015', '0062'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>편집기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>AdobePremiere Pro CS5<a href="javascript:void(0);"
                                                                                           onclick="fnCmdViewPage('CB10017', '2015', '0069'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>AfterEffect CS5<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CB10015', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>AutodeskMaya를 이용한 입체영상 제작<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10021', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>AvidMedia Composer Advanced<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10016', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>기초를다지기 위한 Cinema4D<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CB12006', '2015', '0062'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>촬영실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>3D영상제작개론<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CB10025', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>3D입체편집<a href="javascript:void(0);"
                                                                            onclick="fnCmdViewPage('CB10023', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>Finalcut Pro의 Motion 제작 실무<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10019', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>디지털영상 색 보정<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10020', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>디지털포맷과 워크플로우<a href="javascript:void(0);"
                                                                                  onclick="fnCmdViewPage('CB10027', '2015', '0068'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 방송영상 편집 Track-->

<!-- popup 교육체계도 - 방송영상 비즈 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                방송영상 비즈 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    비즈 Track의 직무는 크게 전략과 마케팅으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 다양한 과정을 선택할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>전략/마케팅</h8>
                <ul class="desc eduframe_pop_list">
                    <li>방송콘텐츠 사업가, 엔터테인먼트 콘텐츠 수입 및 배급사, 방송콘텐츠 마케팅 디렉터, 영화 홍보/마케터 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>전략</th>
            <td>방송/영상 산업에 관한 지식 / 해외 시장에 관한 지식 / 관련 법률 지식 / 브랜드 커뮤니케이션에 관한 지식</td>
        </tr>
        <tr>
            <th>마케팅</th>
            <td>방송영상 유통 관련 지식 / 방송영상 홍보 및 마케팅 지식</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>전략 및 마케팅 TRM</h7>
    <div class="trm_inner_con">
        <h8>방송영상 비즈니스 전문가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>방송영상 전략 및 마케팅 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>다큐멘터리트레일러 만들기와 피칭전략<a href="javascript:void(0);"
                                                                                         onclick="fnCmdViewPage('CB10011', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>분야별로배우는 콘텐츠 마케팅<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CK10074', '2015', '0062'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="faq_tit_con">
                                        <h5>방송영상 전략 실무</h5>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 방송영상 비즈 Track-->

<!-- popup 교육체계도 - 방송영상 교양 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                방송영상 교양
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con mb40">
                <h7>개요</h7>
                <p class="desc">
                    본 과정은 Track 이수와 별개로 운영되며, 방송영상 산업에 대한 기본 교양 과정으로 추천하였습니다.<br/>
                    자유롭게 수강하시기 바랍니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_trm">
                <h7>공통과정</h7>
                <div class="trm_inner_con">
                    <h8>교양과정</h8>
                    <div>
                        <ul class="faq_con eduframe_trm_con">
                            <li>
                                <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>대중문화예술</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>글로컬문화콘텐츠의이해와 사례<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CK11004', '2015', '0066'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>대중문화예술인과인권<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CK10079', '2015', '0035'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>대중문화예술인의법적권리<a href="javascript:void(0);"
                                                                                  onclick="fnCmdViewPage('CK10078', '2015', '0055'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>방송영상 관련 지식</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>재미있는TV 읽기<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CK09165', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>재미있는광고 읽기<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CK09164', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>재미있는디자인 읽기<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CK09166', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>재미있는영화읽기<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CK06075', '2015', '0072'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                                        <h5>대중문화예술</h5>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 방송영상 교양 Track-->

<!-- popup 교육체계도 - 게임 기획 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                게임 기획 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    게임 Track의 직무는 크게 구성(디자인) 및 제작기획과 시나리오 작성으로 나누어지며, 그에 따른 필요역량과 진출가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>구성(디자인) 및 제작 기획</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">제작자 : </span>게임프로젝트 매니저, 엔터테인먼트 미디어 기획자, 게임운영자 등</li>
                    <li><span class="eduframe_list_tit">디자이너 : </span>게임 컨셉디자이너, 게임기획자 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>구성(디자인) 및 제작 기획</th>
            <td>게임 분석력 / 게임 컨셉 디자인 스킬 / 게임 시스템 디자인 스킬 / 게임 밸런싱/레벨 디자인 스킬 / 게임 서비스 디자인 스킬 / 제작 기획 능력
                / 제작 관리 능력
            </td>
        </tr>
        <tr>
            <th>시나리오 작성</th>
            <td>스토리 구성 역량 / 글쓰기 역량 / 게임 시나리오 작성 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>게임 기획 TRM</h7>
    <div class="trm_inner_con">
        <h8>게임 시나리오 작가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 디자인 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>게임기획 및 그래픽 실무자를 위한<a href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CG11001', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>게임디자인기초<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CG12005', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>성공적인프레젠테이션을 위한 Prezi 활용<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a>
                                </li>
                            </ol>

                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 시나리오 작성 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>11가지법칙으로 끝내는 스토리텔링<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CK10071', '2015', '0080'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>글쓰기를위한 창조적 사고<a href="javascript:void(0);"
                                                                                   onclick="fnCmdViewPage('CB12003', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>디지털미디어스토리텔링<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CB09132', '2015', '0055'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>방송콘텐츠스토리텔링<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>스토리텔링개론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CK10006', '2015', '0067'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>스토리텔링의이해<a href="javascript:void(0);"
                                                                              onclick="fnCmdViewPage('CK06093', '2015', '0059'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>통하는글쓰기 기본<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CB12004', '2015', '0059'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 디자인 및 제작기획 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>현장중심의 3D 게임레벨디자인-MMORPG, FPS, 레이싱
                                    게임<a href="javascript:void(0);"
                                         onclick="fnCmdViewPage('CG11002', '2015', '0034'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>게임 기획 TRM</h7>
    <div class="trm_inner_con">
        <h8>컨셉 디자이너 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 디자인 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>게임기획 및 그래픽 실무자를 위한 게임기술 이해<a href="javascript:void(0);" onclick="fnCmdViewPage('CG11001', '2015', '0034'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>게임디자인기초<a href="javascript:void(0);" onclick="fnCmdViewPage('CG12005', '2015', '0034'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>성공적인프레젠테이션을 위한 Prezi 활용<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 디자인 및 제작기획 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>기초게임시나리오 창작실습<a href="javascript:void(0);" onclick="fnCmdViewPage('CG06118', '2015', '0034'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>스토리보드<a href="javascript:void(0);" onclick="fnCmdViewPage('CG07175', '2015', '0055'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 게임 기획 Track-->

<!-- popup 교육체계도 - 게임 연출/그래픽/사운드 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                게임 연출/그래픽/사운드 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 연출/그래픽/사운드와 프로그래밍으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 최소 6과정 이상을 다양한 방법으로 이수할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>연출/그래픽/사운드</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">연출/그래픽 디자이너 : </span>게임원화/배경디자이너, 게임 그래픽 디자이너</li>
                    <li><span class="eduframe_list_tit">사운드 디자이너 : </span>게임 사운드 디자이너</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>연출/그래픽/사운드 - 연출</th>
            <td>시각 연출 / 논리 연출</td>
        </tr>
        <tr>
            <th>연출/그래픽/사운드 - 그래픽</th>
            <td>화면 설계 스킬 / 모바일 화면 설계 스킬 / 드로잉 및 디자인 스킬 / 배경디자인 및 구현 스킬 / 캐릭터디자인 및 구현 스킬 / 2D 구현 스킬 /
                3D 구현 스킬 / 게임 이펙트 구현 스킬 / 테크니컬 아트 스킬
            </td>
        </tr>
        <tr>
            <th>연출/그래픽/사운드 - 사운드</th>
            <td>게임 사운드 디자인 스킬 / 사운드 구현 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>연출/그래픽/사운드/프로그래밍 TRM</h7>
    <div class="trm_inner_con">
        <h8>모바일 게임 프로그래머 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">
                        <h5>연츨/그래픽/사운드 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>3D게임 텍스처 기초<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CG12007', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>AutodeskMaya를 이용한 입체영상 제작<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10021', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>게임기획 및 그래픽 실무자를 위한 게임기술 이해<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CG11001', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>게임캐릭터디자인1<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CG07126', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>기획자가알아야 할 2D 게임그래픽<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CG07165', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>기획자가알아야 할 3D 게임그래픽<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CG07166', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>스마트게임인터페이스 프로그래밍<a href="javascript:void(0);"
                                                                                      onclick="fnCmdViewPage('CG12015', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">8</span>애니메이션개론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CG06111', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">9</span>엔진별로살펴보는 게임이펙트 실무강좌<a href="javascript:void(0);"
                                                                                         onclick="fnCmdViewPage('CG12014', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">10</span>재미이론<a href="javascript:void(0);"
                                                                           onclick="fnCmdViewPage('CG07174', '2015', '0049'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>프로그래밍 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>3D엔진프로그래밍<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CG06102', '2015', '0040'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>3D프로그래밍 기초<a href="javascript:void(0);"
                                                                                onclick="fnCmdViewPage('CG12004', '2015', '0040'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>C#<a href="javascript:void(0);"
                                                                        onclick="fnCmdViewPage('CG08179', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>게임수학<a href="javascript:void(0);"
                                                                          onclick="fnCmdViewPage('CG07170', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>스마트게임인터페이스 프로그래밍<a href="javascript:void(0);"
                                                                                      onclick="fnCmdViewPage('CG12015', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>아이폰및 아이패드용 게임 제작(기초)<a href="javascript:void(0);"
                                                                                          onclick="fnCmdViewPage('CG10008', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>안드로이드게임 제작(기초)<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CG10010', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">8</span>알고리즘<a href="javascript:void(0);"
                                                                          onclick="fnCmdViewPage('CG09189', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">9</span>프로그래밍이론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CG12008', '2015', '0034'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>프로그래밍 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>DirectX10<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CG07162', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>UDK활용 방법(스크립트)<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CG10006', '2015', '0040'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>UDK활용 방법(툴)<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CG10007', '2015', '0040'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>Unity3d를이용한 게임 만들기<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CG12011', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>스케일폼을위한 액션스크립트<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CG12012', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>아이폰및 아이패드용 게임 제작(실무)<a href="javascript:void(0);"
                                                                                          onclick="fnCmdViewPage('CG10009', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>안드로이드게임 제작(실무)<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CG10011', '2015', '0034'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="trm_inner_con">
        <h8>그래픽 디자이너 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">
                        <h5>연출/그래픽/사운드 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>3D게임 텍스처 기초<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CG12007', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>AutodeskMaya를 이용한 입체영상 제작<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CB10021', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>게임기획 및 그래픽 실무자를 위한 게임기술 이해<a
                                        href="javascript:void(0);"
                                        onclick="fnCmdViewPage('CG11001', '2015', '0034'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>게임캐릭터디자인1<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CG07126', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">5</span>기획자가알아야 할 2D 게임그래픽<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CG07165', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">6</span>기획자가알아야 할 3D 게임그래픽<a href="javascript:void(0);"
                                                                                        onclick="fnCmdViewPage('CG07166', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">7</span>스마트게임인터페이스 프로그래밍<a href="javascript:void(0);"
                                                                                      onclick="fnCmdViewPage('CG12015', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">8</span>애니메이션개론<a href="javascript:void(0);"
                                                                             onclick="fnCmdViewPage('CG06111', '2015', '0049'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">9</span>엔진별로살펴보는 게임이펙트 실무강좌<a href="javascript:void(0);"
                                                                                         onclick="fnCmdViewPage('CG12014', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">10</span>재미이론<a href="javascript:void(0);"
                                                                           onclick="fnCmdViewPage('CG07174', '2015', '0049'); return false;">상세보기</a>
                                </li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>연출/그래픽/사운드 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>3D공간구조프로그래밍<a href="javascript:void(0);"
                                                                                 onclick="fnCmdViewPage('CG06103', '2015', '0040'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>MAX를이용한 3D그래픽 실습<a href="javascript:void(0);"
                                                                                      onclick="fnCmdViewPage('CG12003', '2015', '0055'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">3</span>게임캐릭터디자인2<a href="javascript:void(0);"
                                                                               onclick="fnCmdViewPage('CG07169', '2015', '0042'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">4</span>스케일폼을활용한 게임 UI개발<a href="javascript:void(0);"
                                                                                      onclick="fnCmdViewPage('CG12013', '2015', '0042'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 게임 연출/그래픽/사운드 Track-->

<!-- popup 교육체계도 - 게임 프로그래밍 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                게임 프로그래밍 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 연출/그래픽/사운드와 프로그래밍으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 최소 6과정 이상을 다양한 방법으로 이수할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>프로그래밍 구조 및 언어/게임구현</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">스템 디자이너 : </span>게임시스템 디자이너, 게임 스크립트 디자이너</li>
                    <li><span class="eduframe_list_tit">프로그래머 : </span>멀티미디어 콘텐츠제작 전문가, 게임프로그래머, 게임툴 프로그래머, 서버 및
                        게임엔진관리자, 모바일 게임 프로그래머
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
                        <tbody>
                        <tr>
                            <th>프로그래밍 구조 및 언어</th>
                            <td>프로그래밍 기본 지식 / 객체지향프로그래밍 스킬</td>
                        </tr>
                        <tr>
                            <th>프로그래밍 게임구현</th>
                            <td>게임제작 Tool 운용 스킬 / 네트워크 프로그래밍 / 모바일 프로그래밍</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 게임 프로그래밍 Track-->

<!-- popup 교육체계도 - 게임 비즈 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                게임 비즈 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    비즈 Track의 직무는 크게 전략과 마케팅으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 다양한 과정을 선택할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>전략/마케팅</h8>
                <ul class="desc eduframe_pop_list">
                    <li>웹 서비스 마스터, 게임마케터, 게임 퍼블리싱 전문가, QA, GM(게임 마스터) 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>전략</th>
            <td>게임 산업에 관한 지식 / 해외 시장에 관한 지식 / 관련 법률 지식</td>
        </tr>
        <tr>
            <th>마케팅</th>
            <td>게임유통 관련 지식 / 게임 홍보 및 마케팅 지식</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>전략 및 마케팅 TRM</h7>
    <div class="trm_inner_con">
        <h8>게임 비지니스 전문가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 전략 및 마케팅 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>분야별로배우는 콘텐츠 마케팅<a href="javascript:void(0);"
                                                                                     onclick="fnCmdViewPage('CK10074', '2015', '0062'); return false;">상세보기</a>
                                </li>
                                <li><span class="list_num">2</span>온라인게임의 해외진출 전략<a href="javascript:void(0);"
                                                                                    onclick="fnCmdViewPage('CG12001', '2015', '0041'); return false;">상세보기</a>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="faq_tit_con list_on">
                                        <h5>게임 전략 및 마케팅 실무</h5>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 게임 비즈 Track-->

<!-- popup 교육체계도 - 게임 교양-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                게임 교양
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    본 과정은 Track 이수와 별개로 운영되며, 게임 산업에 대한 기본 교양 과정을 추천하였습니다. 자유롭게 수강하시기 바랍니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_trm">
                <h7>공통과정</h7>
                <div class="trm_inner_con">
                    <h8>교양과정</h8>
                    <div>
                        <ul class="faq_con eduframe_trm_con">
                            <li>
                                <div class="faq_tit_con list_on">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 관련 지식</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>게임기획 및 그래픽 실무자를 위한 게임기술 이해<a href="javascript:void(0);" onclick="fnCmdViewPage('CG11001', '2015', '0034'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con list_on">  <!-- class: list_on 입력시 활성화 -->
                        <h5>게임 직업탐색</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>포트폴리오구성과 제작<a href="javascript:void(0);" onclick="fnCmdViewPage('CG08182', '2015', '0041'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con list_on">  <!-- class: list_on 입력시 활성화 -->
                        <h5>스마트환경 이해</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>모바일앱 비즈니스 기획부터 프로모션까지<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12001', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>사례로보는 SNS 비즈니스 전략<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11012', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>사례로알아보는 소셜네트워크<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10076', '2015', '0074'); return false;">상세보기</a></li>
                                <li><span class="list_num">4</span>스마트폰과문화<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11003', '2015', '0072'); return false;">상세보기</a></li>
                                <li><span class="list_num">5</span>트렌드워칭- 스마트 환경에서의 콘텐츠 비즈니스<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11013', '2015', '0062'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 게임 교양-->

<!-- popup 교육체계도 - 만화애니캐릭터 기획 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                만화애니캐릭터 기획 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    기획 Track의 직무는 크게 구성(디자인) 및 제작기획과 시나리오 작성으로 나누어지며, 그에 따른 필요역량과 진출가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>구성 및 제작 기획</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">감독 : </span>애니메이션 아트 디렉터, 애니메이션 제작 및 기획자, 애니메이션 영화감독 등
                    </li>
                </ul>
                <h8>시나리오 작성</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">시나리오작가 : </span>애니메이션 시나리오 작가, 만화 스토리 작가 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>구성 및 제작 기획</th>
            <td>컨셉 기획 / 분석 및 자료 수집력 / 제작 기획 능력 / 제작 관리 능력</td>
        </tr>
        <tr>
            <th>시나리오 작성</th>
            <td>스토리 구성 역량 / 자료 수집력 / 글쓰기 역량 / 장르별 시나리오 작성 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>만화애니캐릭터 기획 TRM</h7>
    <div class="trm_inner_con">
        <h8>만화 스토리 작가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>컨셉 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>성공적인프레젠테이션을 위한 Prezi 활용<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>애니메이션개론<a href="javascript:void(0);" onclick="fnCmdViewPage('CG06111', '2015', '0049'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>헐리웃에서이야기하는 컨셉 디자인<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11014', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>스토리 및 시나리오 작성 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>11가지법칙으로 끝내는 스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10071', '2015', '0080'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>글쓰기를위한 창조적 사고<a href="javascript:void(0);" onclick="fnCmdViewPage('CB12003', '2015', '0059'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>디지털미디어스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CB09132', '2015', '0055'); return false;">상세보기</a></li>
                                <li><span class="list_num">4</span>방송콘텐츠스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a></li>
                                <li><span class="list_num">5</span>스토리텔링개론<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10006', '2015', '0067'); return false;">상세보기</a></li>
                                <li><span class="list_num">6</span>스토리텔링의이해<a href="javascript:void(0);" onclick="fnCmdViewPage('CK06093', '2015', '0059'); return false;">상세보기</a></li>
                                <li><span class="list_num">7</span>통하는글쓰기 기본<a href="javascript:void(0);" onclick="fnCmdViewPage('CB12004', '2015', '0059'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>컨셉 및 제작기획 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>원천스토리로서의만화 읽기<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11011', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="trm_inner_con">
        <h8>애니메이션 제작자 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>컨셉 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>성공적인프레젠테이션을 위한 Prezi 활용<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>애니메이션개론<a href="javascript:void(0);" onclick="fnCmdViewPage('CG06111', '2015', '0049'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>헐리웃에서이야기하는 컨셉 디자인<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11014', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>컨셉 및 제작기획 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>헐리우드애니메이션 스토리텔링 전략<a href="javascript:void(0);" onclick="fnCmdViewPage('CK09167', '2015', '0062'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 만화애니캐릭터 기획 Track-->

<!-- popup 교육체계도 - 만화 제작 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                만화 제작 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 만화 분야, 애니 분야, 캐릭터 분야로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>만화/애니/캐릭터</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">만화.캐릭터 : </span>캐릭터 디자이너, 동화 일러스트레이터, 팬시캐릭터, 원화디자이너, 캐릭터
                        피규어 제작자 등
                    </li>
                    <li><span class="eduframe_list_tit">애니/캐릭터 : </span>교육콘텐츠 개발 디자이너, VFX디자이너, 모델러, 2D/3D
                        애니메이터, 광고 애니메이터 등
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
                        <tbody>
                        <tr>
                            <th>만화원화</th>
                            <td>인체 드로잉 스킬 / 자연물 및 풍경 드로잉 스킬 / 색채의 이해</td>
                        </tr>
                        <tr>
                            <th>만화구현</th>
                            <td>프로그램 및 Tool 사용 스킬 / 매체 사용 스킬</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 만화 제작 Track-->

<!-- popup 교육체계도 - 애니 제작 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                애니 제작 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 만화 분야, 애니 분야, 캐릭터 분야로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>만화/애니/캐릭터</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">만화.캐릭터 : </span>캐릭터 디자이너, 동화 일러스트레이터, 팬시캐릭터, 원화디자이너, 캐릭터
                        피규어 제작자 등
                    </li>
                    <li><span class="eduframe_list_tit">애니/캐릭터 : </span>교육콘텐츠 개발 디자이너, VFX디자이너, 모델러, 2D/3D
                        애니메이터, 광고 애니메이터 등
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
                        <tbody>
                        <tr>
                            <th>애니그래픽/연출</th>
                            <td>2D 제작 스킬 / 3D 제작 스킬 / 애니메이션 연출 스킬</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 애니 제작 Track-->

<!-- popup 교육체계도 - 캐릭터 제작 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                캐릭터 제작 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 크게 만화 분야, 애니 분야, 캐릭터 분야로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>만화/애니/캐릭터</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">만화.캐릭터 : </span>캐릭터 디자이너, 동화 일러스트레이터, 팬시캐릭터, 원화디자이너, 캐릭터
                        피규어 제작자 등
                    </li>
                    <li><span class="eduframe_list_tit">애니/캐릭터 : </span>교육콘텐츠 개발 디자이너, VFX디자이너, 모델러, 2D/3D
                        애니메이터, 광고 애니메이터 등
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
                        <tbody>
                        <tr>
                            <th>캐릭터디자인</th>
                            <td>팬시캐릭터 디자인 / 캐리커쳐 디자인 / 캐릭터 디자인 / 브랜드 캐릭터 디자인</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 캐릭터 제작 Track-->

<!-- popup 교육체계도 - 만화애니캐릭터 비즈 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                만화애니캐릭터 비즈 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    비즈 Track의 직무는 크게 전력과 마케팅으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 다양한 과정을 선택할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>전략/마케팅</h8>
                <ul class="desc eduframe_pop_list">
                    <li>만화애니캐릭터 콘텐츠 사업가, 만화애니캐릭터 수입 및 배급사, 만화애니캐릭터콘텐츠 마케팅 디렉터 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>전략</th>
            <td>만화애니캐릭터 산업에 관한 지식 / 해외 시장에 관한 지식 / 관련 법률 지식</td>
        </tr>
        <tr>
            <th>마케팅</th>
            <td>만화애니캐릭터 산업 유통 관련 지식 / 만화애니캐릭터 산업 홍보/ 마케팅 지식</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>전략 및 마케팅 TRM</h7>
    <div class="trm_inner_con">
        <h8>만화애니캐릭터 비지니스 전문가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>만화애니캐릭터 전략 및 마케팅 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>분야별로배우는 콘텐츠 마케팅<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10074', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                                        <h5>만화애니캐릭터 전략 및 마케팅 실무</h5>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 만화애니캐릭터 비즈 Track-->

<!-- popup 교육체계도 - 만화애니캐릭터 교양 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                만화애니캐릭터 교양
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con mb40">
                <h7>개요</h7>
                <p class="desc">
                    본 과정은 Track 이수와 별개로 운영되며, 만화애니캐릭터 산업에 대한 기본 교양 과정으로 추천하였습니다. 자유롭게 수강하시기 바랍니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_trm">
                <h7>공통과정</h7>
                <div class="trm_inner_con">
                    <h8>교양과정</h8>
                    <div>
                        <ul class="faq_con eduframe_trm_con">
                            <li>
                                <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>만화애니캐릭터 관련 지식</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>원천스토리로서의만화 읽기<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11011', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>만화애니캐릭터 직업탐색</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>포트폴리오구성과 제작<a href="javascript:void(0);" onclick="fnCmdViewPage('CG08182', '2015', '0041'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>스마트환경 이해</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>모바일앱 비즈니스 기획부터 프로모션까지<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12001', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>사례로보는 SNS 비즈니스 전략<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11012', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>사례로알아보는 소셜네트워크<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10076', '2015', '0074'); return false;">상세보기</a></li>
                                <li><span class="list_num">4</span>스마트폰과문화<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11003', '2015', '0072'); return false;">상세보기</a></li>
                                <li><span class="list_num">5</span>트렌드워칭- 스마트 환경에서의 콘텐츠 비즈니스<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11013', '2015', '0062'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 만화애니캐릭터 교양 Track-->

<!-- popup 교육체계도 - 음악공연 기획 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                음악공연 기획 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    기획 Track의 직무는 크게 구성 및 제작기획과 시나리오(큐시트) 작성으로 나누어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>구성(디자인) 및 제작 기획</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">감독 : </span>콘서트 프로듀서 및 기획자, 뮤지컬 프로듀서 및 기획자, 패션쇼 연출가,
                        축제연출가, 음악축제 프로그래머, 컨벤션 기획자 등
                    </li>
                </ul>
                <h8>시나리오(큐시트) 작성</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">시나리오 작가 : </span>애니메이션 시나리오 작가, 만화 스토리 작가 등</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>구성 및 제작 기획</th>
            <td>기획 프로세서의 이해 / 제작 기획 능력 / 제작 관리 능력</td>
        </tr>
        <tr>
            <th>시나리오(큐시트) 작성</th>
            <td>스토리 구성 역량 / 자료 수집력 / 글쓰기 역량 / 장르별 시나리오 작성 스킬</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>음악공연 기획 TRM</h7>
    <div class="trm_inner_con">
        <h8>공연 기확자/제작자 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>구성 및 제작기획 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송아나운싱<a href="javascript:void(0);" onclick="fnCmdViewPage('CB09139', '2015', '0068'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>성공적인프레젠테이션을 위한 Prezi 활용<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12010', '2015', '0080'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>축제기획과문화콘텐츠<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11002', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>큐시트 작성 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>11가지법칙으로 끝내는 스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10071', '2015', '0080'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>글쓰기를 위한 창조적 사고<a href="javascript:void(0);" onclick="fnCmdViewPage('CB12003', '2015', '0059'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>디지털미디어스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CB09132', '2015', '0055'); return false;">상세보기</a></li>
                                <li><span class="list_num">4</span>방송콘텐츠스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a></li>
                                <li><span class="list_num">5</span>스토리텔링개론<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10006', '2015', '0067'); return false;">상세보기</a></li>
                                <li><span class="list_num">6</span>스토리텔링의이해<a href="javascript:void(0);" onclick="fnCmdViewPage('CK06093', '2015', '0059'); return false;">상세보기</a></li>
                                <li><span class="list_num">7</span>통하는글쓰기 기본<a href="javascript:void(0);" onclick="fnCmdViewPage('CB12004', '2015', '0059'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>구성 및 제작기획 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>쉽게배우는 전시기획<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10082', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>스마트디바이스로 창조하는 콘텐츠<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12013', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>음반제작워크숍<a href="javascript:void(0);" onclick="fnCmdViewPage('CK06063', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">4</span>히트하는 뮤지컬,기획부터 홍보까지<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12012', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>큐시트 작성 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>방송콘텐츠스토리텔링<a href="javascript:void(0);" onclick="fnCmdViewPage('CB10013', '2015', '0068'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="trm_inner_con">
        <h8>공연 시나리오(큐시트)작가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>큐시트 작성 기본</h5>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                                        <h5>큐시트 작성 실무</h5>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 음악공연 기획 Track-->

<!-- popup 교육체계도 - 음악공연 제작 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                음악공연 제작 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    제작 Track의 직무는 제작사례를 통하여 학습하며, 분야별로 연출 및 제작에 대한 스킬이 요구됩니다.<br/>
                    그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>제작 사례</h8>
                <ul class="desc eduframe_pop_list">
                    <li><span class="eduframe_list_tit">연출가 : </span>음악축제 연출가, 연극 연출가, 콘서트 연출가, 축제 연출가, 매니저,
                        무대감독, 패션쇼 연출가, 이벤트 PD, Art 콜라보레이터
                    </li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>제작 사례</th>
            <td>음반 제작 및 콘서트 연출 스킬 / 공연 및 뮤지컬/쇼 연출 스킬 / 전시회 개최 및 연출 스킬 / 축제/이벤트 개최 및 연출 스킬 / 모바일 및
                IT기기를 통한 콘텐츠제작 스킬
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>음악공연 제작 TRM</h7>
    <div class="trm_inner_con">
        <h8>공연 연출가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>제작 사례 과정</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>쉽게배우는 전시기획<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10082', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>축제기획과문화콘텐츠<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11002', '2015', '0062'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 음악공연 제작 Track-->

<!-- popup 교육체계도 - 음악공연 비즈 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                음악공연 비즈 Track
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con">
                <h7>개요</h7>
                <p class="desc">
                    비즈 Track의 직무는 크게 전력과 마케팅으로 나우어지며, 그에 따른 필요역량과 진출 가능한 직업군은 아래와 같습니다.<br/>
                    본 Track은 직업군에 따라 해당 과정에서 다양한 과정을 선택할 수 있습니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_con">
                <h7>직업군</h7>
                <h8>전략/마케팅</h8>
                <ul class="desc eduframe_pop_list">
                    <li>문화콘텐츠 마케터, 예술경영 컨설턴트, 극장하우스 매니저, 공연예술 국제교류 전문가, 기업홍보대행사, 공연홍보대행사, 이벤트프로모션대행사</li>
                </ul>
            </div>
            <div class="eduframe_pop_contents_con mb40">
                <h7>필요역량</h7>
                <table class="eduframe_tb" summary="교육체계도 ">
                    <caption>필요역량</caption>
        <colgroup>
            <col width="20%">
            <col width="auto">
        </colgroup>
        <tbody>
        <tr>
            <th>전략</th>
            <td>엔터테인먼트 시작에 관한 지식 / 해외 시장에 관한 지식 / 관련 법률 지식</td>
        </tr>
        <tr>
            <th>마케팅</th>
            <td>음악공연 산업 유통 관련 지식 / 음악공연 산업 홍보 및 마케팅 지식</td>
        </tr>
        </tbody>
    </table>
</div>
<div class="eduframe_pop_contents_trm">
    <h7>전략 및 마케팅 TRM</h7>
    <div class="trm_inner_con">
        <h8>음악공연 비지니스 전문가 추천 학습 경로</h8>
        <div>
            <ul class="faq_con eduframe_trm_con">
                <li>
                    <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>음악공연 전략 및 마케팅 기본</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>대중음악콘텐츠기획과해외진출<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10073', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>히트하는뮤지컬, 기획부터 홍보까지<a href="javascript:void(0);" onclick="fnCmdViewPage('CK12012', '2015', '0062'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">  <!-- class: 입력시 활성화 -->
                        <h5>음악공연 전략 및 마케팅 실무</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>공연기획과홍보마케팅 실무<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10080', '2015', '0062'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>분야별로배우는 콘텐츠 마케팅<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10074', '2015', '0062'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div>
<!-- //popup 교육체계도 - 음악공연 비즈 Track-->

<!-- popup 교육체계도 - 음악공연 교양 Track-->
<div class="col-12 popup_wrap academy_pop" style="display:none;">
<div class="col-10 col-center popup_con">
    <div class="col-12 popup_style_0 type1">
        <div class="col-12 popup_title_wrap">
            <div class="popup_title">
                음악공연 교양
            </div>
            <div class="popup_close_btn_con">
                <a href="javascript:void(0)" class="popup_close_btn">
                    <img src="/edu/images/bm/popup_btn_cancel_img.png" alt="팝업 닫기 버튼">
                </a>
            </div>
        </div>
        <div class="col-12 popup_contents_wrap">
            <div class="eduframe_pop_contents_con mb40">
                <h7>개요</h7>
                <p class="desc">
                    본 과정은 Track 이수와 별개로 운영되며, 음악공연 산업에 대한 기본 교양 과정으로 추천하였습니다. 자유롭게 수강하시기 바랍니다.
                </p>
            </div>
            <div class="eduframe_pop_contents_trm">
                <h7>공통과정</h7>
                <div class="trm_inner_con">
                    <h8>교양과정</h8>
                    <div>
                        <ul class="faq_con eduframe_trm_con">
                            <li>
                                <div class="faq_tit_con">  <!-- class: list_on 입력시 활성화 -->
                        <h5>대중문화예술</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>글로컬문화콘텐츠의이해와 사례<a href="javascript:void(0);" onclick="fnCmdViewPage('CK11004', '2015', '0066'); return false;">상세보기</a></li>
                                <li><span class="list_num">2</span>대중문화예술인과 인권<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10079', '2015', '0035'); return false;">상세보기</a></li>
                                <li><span class="list_num">3</span>대중문화예술인의법적권리<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10078', '2015', '0055'); return false;">상세보기</a></li>
                            </ol>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="faq_tit_con">
                        <h5>음악공연 관련 지식</h5>
                        <p>
                            <img class="direc_off" src="/edu/images/bm/faq_direc_off.png"
                                 alt="faq 화살표 off 이미지">
                            <img class="direc_on" src="/edu/images/bm/faq_direc_on.png"
                                 alt="faq 화살표 on 이미지">
                        </p>
                    </div>
                    <div class="faq_reply_con">
                        <div>
                            <p>해당과정</p>
                            <ol class="decimal">
                                <li><span class="list_num">1</span>예술경영의실무<a href="javascript:void(0);" onclick="fnCmdViewPage('CK10075', '2015', '0062'); return false;">상세보기</a></li>
                                            </ol>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="popup_btn_con">
                    <a href="javascript:void(0)" class="btn_style_popup">확인</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 popup_dim"></div>
</div> --%>
<!-- //popup 교육체계도 - 음악공연 교양 Track-->



<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		$('.lnb_wrap').addClass('dn');
					
		var stepLinks= $(".step li>a");	//해당 탭리스트 링크 셀렉트
		$(stepLinks).each(function(index) {
			$(this).click(function() {
				if ($(this).parent().hasClass('on')) {
					$('.box').slideUp("fast");
					$(this).parent().removeClass("on");
				}else{
					var boxH = $(this).parent().find(".box").height()+120;
					$(stepLinks).parent().removeClass('on');
					$(stepLinks).removeClass("on");
					$(this).parent().addClass('on').siblings().removeClass('on');
					$(this).addClass('on').siblings().removeClass('on');
					$('.box').slideUp("fast");

					var boxHref = $(this).attr('href');
					$(boxHref).slideDown("fast");
				};
				return false;
			});
		});
		$(".step .closer").click(function(){
			$('.box').slideUp("fast");
			$(stepLinks).parent().removeClass('on');
		});
		
		
	});
	
	//스크랩
	function fnCmdInScrap(chartcode){
		
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/edcsystm/eduSystmScrapInsert.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			data:{
				"p_chartcode":chartcode
				},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				alert(data.system_msg);
				
			},
			error:function(){
				alert("서버와 통신 실패");
			}
			
		});
		
	}
	
	//해당과정 보여주기
	function fnCmdSubjList(chartcode, uppercode, item3){
		
		$(".item3Clear").removeClass("ing");
		$("#item3"+item3).addClass("ing");
		$(".hiddenSubjArea").hide();
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/edcsystm/listSubj.json?menuNo=<c:out value='${paramVO.menuNo }'/>",
			data:{
				"p_chartcode":chartcode
				},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				
				if(data.listSubj != ""){
					$("#subj_"+uppercode+"_"+item3).html(data.listSubj);
					$("#subjList_"+uppercode+"_"+item3).show();
				}
			},
			error:function(){
				alert("서버와 통신 실패");
			}
			
		});
		
	}
	
	
	//과정 상세화면
	function fnCmdViewPage(subj, year, subjseq){
		
		$("#p_subj").val(subj);
		$("#p_year").val(year);
		$("#p_subjseq").val(subjseq);
		
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/view.do?menuNo=500027",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}


//]]>
</script>





















