<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.unp.co.kr/util" prefix="util" %>
<!-- contents -->
<!-- sub_layout -->
<div class="col-12 sub_contents_wrap">
    <div class="col-12 col-center mw-1200 over-visible">
        <div class="col-12 pr15 pl15">
            <div class="lnb_wrap">
                <div class="lnb_header">
                    <h3 class="show-tablecell vm tc">
                        인재캠퍼스 홈메인
                    </h3>
                </div>
                <ul class="lnb_con">
                    <li class="lnb_1"><a href="javascript:void(0)"><span>콘텐츠인재캠퍼스</span></a>
                        <!--<ul class="lnb_1_1depth">-->
                        <!--<li><a href="javascript:void(0)"><span>콘텐츠 인재 캠퍼스</span></a>-->
                        <!--</li>-->
                        <!--<li><a href="javascript:void(0)"><span>공지사항</span></a></li>-->
                        <!--<li><a href="javascript:void(0)"><span>문의하기</span></a></li>-->
                        <!--<li><a href="javascript:void(0)"><span>인사말</span></a></li>-->
                        <!--</ul>-->
                    </li>
                    <li class="lnb_2"><a href="javascript:void(0)"><span>공지사항</span></a></li>
                    <li class="lnb_3"><a href="javascript:void(0)"><span>문의하기</span></a></li>
                    <li class="lnb_4 active"><a href="javascript:void(0)"><span>인사말</span></a></li>
                </ul>
            </div>
            <!-- //sub_layout -->
            <div class="col-12 col-md-0 fn-md over-hidden fontsize0 sub_contents">
                <div class="col-12 sub_section sub_main_contents_section">
                    <div class="col-12">
                        <div class="col-12 col-md-6 recent_board">
                            <h3>공지사항</h3>
                            <p class="tr more_btn_con">
                                <a href="javascript:void(0)" class="show more_btn">더보기</a>
                            </p>
                            <hr class="h_line3">
                            <a href="javascript:void(0)" class="show-block recent_notice">
                                <h4 class="new"><span>[한국콘텐츠진흥원] 콘텐츠테크랩 사업설명회로 초대합니다</span></h4>
                                <p class="h_desc4">콘텐츠테크랩은 콘텐츠 창작자들에게 융복합 기술교육을 실시하여 창작역량을 강화 하고있습니다.</p>
                                <p class="h_date4">2017.06.29</p>
                            </a>
                            <ul class="list_style_0">
                            	
                            	<c:forEach var="result" items="${B0000011List}" varStatus="status">
								<li><a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008"><c:out value="${result.nttSj}"/></a></li>
								</c:forEach>
                            </ul>
                        </div>
                        <div class="col-12 col-md-6 recent_board question">
                            <h3>문의사항</h3>
                            <p class="tr more_btn_con">
                                <a href="javascript:void(0)" class="show more_btn">더보기</a>
                            </p>
                            <hr class="h_line3">
                            <a href="javascript:void(0)" class="show-block">
                                <h4 class="aqua_green new"><span>에듀코카 모바일앱을 실행하면 에러가 나네요</span></h4>
                            </a>
                            <p class="h_button_con go">
                                <a href="javascript:void(0)" class="h_btn go">
                                    진행중
                                </a>
                                <a href="javascript:void(0)" class="h_btn end">
                                    마감
                                </a>
                            </p>
                            <ul class="list_style_0 question">
                            	
                            	<c:forEach var="result" items="${cnslBoardList}" varStatus="status">
								<li>
									<a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500008">
									<c:choose>
										<c:when test="${result.option1 eq '01'}">[현장교육]</c:when>
										<c:when test="${result.option1 eq '02'}">[온라인교육]</c:when>
										<c:when test="${result.option1 eq '03'}">[창의인재동반]</c:when>
										<c:when test="${result.option1 eq '04'}">[취업정보]</c:when>
									</c:choose>
										<c:out value="${result.nttSj}"/>
									</a>
								</li>
								</c:forEach>
                            </ul>
                            <p class="tr add_btn_con">
                                <a href="javascript:void(0)" class="show add_btn">등록하기</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //contents -->