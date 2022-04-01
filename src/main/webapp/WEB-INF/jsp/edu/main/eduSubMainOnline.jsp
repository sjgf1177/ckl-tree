<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<%-- <ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" /> --%>
<!--content-->

<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post" class="form-inline">
	<input type="hidden" name="p_gubun1" id="p_gubun1" value="" />
	<input type="hidden" name="p_gubun2" id="p_gubun2" value="" />
	<input type="hidden" name="p_gubun3" id="p_gubun3" value="" />
	
	<input type="hidden" name="p_subj" id="p_subj" value="" />
	<input type="hidden" name="p_subjnm" id="p_subjnm" value="" />
	<input type="hidden" name="p_isonoff" id="p_isonoff" value="" />
	<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="" />
	<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="" />
	<input type="hidden" name="p_year" id="p_year" value="" />
	<input type="hidden" name="p_subjseq" id="p_subjseq" value="" />
	
	<input type="hidden" name="pTabgubun" id="pTabgubun" value='<c:out value="${param.pTabgubun }" />' />
</form>

<body id="subContainer">
	<div class="wrapper sub_layout_main">
    	<!-- header -->
    	<div class="col-12 print_out">
	        <!--GNBhead-->
    	    <jsp:include page="/WEB-INF/jsp/edu/inc/subMainHead.jsp" flush="true" />
        	<!--//GNBhead-->
		</div>
	 	<div class="col-12">
        	<div class="col-12 col-center visual_inner print_out">
            	<div class="col-12 col-center mw-1200">
                	<div class="col-12 pr15 pl15">
                    	<div class="col-12 tc visual_wrap">
                        	<div class="col-12 visual_util_wrap">
                            	<div class="fl fontsize0 linemap_wrap">
                                	<ul class="col-12 linemap_con">
                                    	<li><a href="/edu/main/main.do"><span style="clip: rect(1px, 1px, 1px, 1px); position:relative;">Home</span></a></li>
                                    	<li><a href="javascript:void(0)" tabindex="-1"><span>온라인교육</span></a></li>
                                	</ul>
                            	</div>
                            	<ul class="tr sharing_util_icon">
	                            	<li>
	                            		<a href="javascript:void(0);" class="ico01 snsToggleOpen"><span class="hidden">SNS 공유하기</span></a>
		                            	<div class="snsDrop" style="display:none;">
			                            	<c:url value="https://www.facebook.com/sharer.php" var="fbUrl">
			                                	<c:param name="t" value="${title}" />
				                                <c:param name="u" value="${currMenu.fullMenuLink}" />
				                            </c:url>
				                            <c:url value="https://twitter.com/share" var="twitterUrl">
				                                <c:param name="text" value="${title}" />
			    	                            <c:param name="url" value="${currMenu.fullMenuLink}" />
			        	                    </c:url>
			            	                <ul>
				            	                <li><a href="<c:out value='${fbUrl}' escapeXml='true' />" class="icos01" onclick="return facebookOpen();" title="(새창열림)페이스북 링크 공유하기" target="_blank"><span class="hidden">페이스북</span></a></li>
				                	            <li><a href="<c:out value='${twitterUrl}' escapeXml='true' />" class="icos02" onclick="return twitterOpen();" title="(새창열림)트위터 링크 공유하기" target="_blank"><span class="hidden">트위터</span></a></li>
			                        	    </ul>
		                            	</div>
	                            	</li>
                            		<li>
                            			<a href="#self" Class="ico02 CopyClipOpen"><span Class="hidden">URL 복사하기</span></a>
		                            	<script type="text/javascript">
			                            //<![CDATA[
			                            var linkURL = document.URL;
			                            var param = "";
			                            $(document).ready(function(){
				                            $(':hidden').each(function(){
					                            if(null != $(this).attr('name') && $(this).val() != ""){
						                            if( linkURL.indexOf($(this).attr('name')) < 0){
						                            	param += "&"+$(this).attr('name')+"="+$(this).val();
						                            }
					                            }
				                            });
				
				                            $(".sharing_util_icon .ico02").click(function(){
				                            	urlLink();
				                            	return false;
				                            });
			                            });
			
			                            //$("#COPYCP").prop("value", linkURL);
			                            function urlLink() {
				                            var IE = (document.all) ? true : false;
				                            if (IE) {
					                            window.clipboardData.setData('Text', linkURL + param);
					                            alert('주소가 복사되었습니다. 브라우저의 URL 입력창에 Ctrl+V로 붙여 넣기 하세요.');
				                            } else {
				                            	temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", linkURL + param );
				                            }
				                            return false;
			                            }
			                            //]]>
			                            </script>
	                            	</li>
	                            	<li>
	                            		<a href="/edu/forPrint.jsp" class="ico03" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기"><span class="hidden">인쇄하기</span></a>
	                            	</li>
                            	</ul>
                        	</div>
                        </div>
					</div>
				</div>
			</div>
    	</div>
    	<!-- //header -->

    	<!-- contents -->
    	<!-- sub_layout -->
    	<div class="col-12 sub_contents_wrap sub_main_online_edu_tab_contents_wrap" id="content_sub_wrap">
        	<div class="col-12 col-center over-visible mw-1200">
            	<div class="col-12 pr15 pl15">
                	<div class="col-12 col-md-0 fn-md over-hidden fontsize0 sub_contents sub_section">
                		<h3>온라인 교육</h3>
                   		<div class="col-12">
		            		<div class="col-xl-6 col-lg-6 col-md-8 col-sm-12 col-center">
								<form class="online_search" id="form_search" name="form_search" method="post" onsubmit="return false;" >
									<input type="hidden" name="menuNo" id="menuNo" value="" />
									<input type="hidden" name="searchCnd" id="searchCnd" value="1" />
									<input type="hidden" name="p_searchtext" id="p_searchtext" value="" />
									<input type="hidden" name="searchWrd" id="searchWrd" value="" />
									<select id="search_type" >
										<option value="">과정구분</option>
										<option value="01">정규과정</option>
										<option value="02">열린과정</option>
									</select>
									<label for="search_type">과정구분</label>
									<input type="text" id="search_word" placeholder="과정검색">
									<label for="search_word">과정검색</label>
									<a class="onlineSearchBtn" id="searchBtn" href="javascript:void(0);" title="검색 확인"></a>
								</form>
							</div>
						</div>
						<div class="col-12  sub_main_online_education_section" style="padding-top:20px; padding-bottom:50px;">
						
                    		<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 contentBox"><!-- 정규과정 -->
                    			<div class="box_ct">
                    				<span class="ct_title">정규과정</span>
                   					<span class="btn_more float-right"><a href="/edu/onlineEdu/realm/list.do?p_ordersnm=favorsubjcnt&amp;p_orders=desc&amp;menuNo=500027">더보기</a></span>
                   					<div class="vertical_slide scroll-none">
                   						<ul>
                    						<c:forEach items="${realmSubjList }" var="item" varStatus="status" end="8">
                    							<li>
                    								<a href="javascript:void(0);" onclick="fnCmdViewPage('${item.subj }', '${item.subjnm }', '${item.isonoff }', '${item.scupperclass }', '${item.uclassnm }', '${item.scyear }', '${item.subjseq }', '500027'); return false;" class="show-block">
                    									<div class="img_box">
	                    									<c:choose>
		                    									<c:when test="${item.introducefilenamenew != null and item.introducefilenamenew != '' }">
		                    										<img alt="${item.subjnm}" src="<c:out value="${fn:replace(item.introducefilenamenew, crlf, '/') }" />" />
		                    									</c:when>
		                    									<c:otherwise>
		                    										<img alt="${item.subjnm}" src="/upload/bulletin/Subject_introducefile_201407171657471_lee1.gif"/>
		                    									</c:otherwise>
	                    									</c:choose>
                    									</div>
                    									<div class="edu_info">
                    										<span class="point_blue edu_title abbreviation">
                    											<c:out value="${item.subjnm}" />
                    										</span>
                    										<p class="edu_content abbreviation3">
                    											<c:if test="${not empty item.subjsummary }">
                    												<c:set var="arrayofsubjintro" value="${fn:split(item.subjsummary,'-')}"/>
                    												<c:forEach var="i" begin="0" end="${fn:length(arrayofsubjintro)-1 }">
                    													${arrayofsubjintro[i] }<br />
                    												</c:forEach>
                    											</c:if>
                    										</p>
                    									</div>
                    								</a>
                    							</li>
                    						</c:forEach>
                   						</ul>
                   					</div>
                    			</div>
                    		</div>


							
                    		<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 contentBox"><!-- 열린과정 -->
                    			<div class="box_ct">
                    				<span class="ct_title">열린과정</span>
	                       			<span class="btn_more float-right"><a href="/edu/onlineEdu/openLecture/list.do?sortOrder=newOrdr&amp;menuNo=500085" class="process_more_btn">더보기</a></span>
                       				<div class="vertical_slide scroll-none">
		                            	<ul>
			                            	<c:forEach items="${selectMainGoldClassList }" var="item" varStatus="status" end="8">
			                            		<c:url var="url" value="/edu/onlineEdu/openLecture/view.do?pSeq=${item.seq }&amp;menuNo=500085&${pageQueryString }"/>
				                                <li>
				                                    <a href="<c:out value="${url }&amp;pageIndex2=&amp;pLectureCls=${param.pLectureCls }" escapeXml='false' />" class="show-block">
				                                        <div class="img_box">
				                                            <c:choose>
						                                        <c:when test="${item.vodimg != null and item.vodimg != '' }">
						                                            <img src="<c:out value="${item.vodimg }" />" alt="${item.lecnm }" width="336px;" height="216px;" />
						                                        </c:when>
						                                        <c:otherwise>
						                                            <img src="/upload/bulletin/Subject_introducefile_201407171657471_lee1.gif" alt="${item.lecnm }" width="336px;" height="216px;"/>
						                                        </c:otherwise>
						                                    </c:choose>
				                                        </div>
				                                        <div class="edu_info">
				                                            <span class="point_blue edu_title abbreviation">
	                                                        	<c:out value="${item.lecnm }" />
				                                            </span>
				                                            <p class="edu_content abbreviation3">
				                                                <c:out value="${item.intro }" />
				                                            </p>
				                                        </div>
				                                    </a>
				                                </li>
				                         	</c:forEach>
				                         </ul>
									</div>
								</div>
							</div>
		                
		                <!-- 테마과정 -->
		                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 contentBox">
                    		 <div class="box_ct">
                       			<span class="ct_title">테마과정</span>
                       			<span class="btn_more float-right">
                       				<a href="/edu/onlineEdu/themeLecture/list.do?menuNo=500157" class="process_more_btn">더보기</a>
                       			</span>
                       			
                       			<div class="vertical_slide scroll-none">
		                            <ul>
		                            	<c:forEach items="${themeList }" var="item" varStatus="status" end="8">
		                            		<c:url var="url" value="/edu/onlineEdu/themeLecture/view.do">
												<c:param name="pId" value="${item.id }"/>
											</c:url>
			                                <li>
			                                    <a href='<c:out value="${url }" />&amp;${pageQueryString }&amp;menuNo=500157' class="show-block">
			                                        <div class="img_box">
                                                   		<img src="${item.img }" alt="온라인교육 최신트랜드와 기술을 접하다" style="max-height: 230px;">
			                                        </div>
			                                        <div class="edu_info">
			                                            <span class="point_blue edu_title abbreviation">
			                                            	${item.title }
			                                            </span>
			                                            <p class="edu_content abbreviation3">
			                                                <c:out value="${item.description }" />
			                                            </p>
			                                        </div>
			                                    </a>
			                                </li>
			                         	</c:forEach>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
                    	
                    	<!-- 인기과정 -->
                    	<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 contentBox">
                    		 <div class="box_ct">
                       			<span class="ct_title">인기과정</span>
                       			<!-- <span class="btn_more float-right">
                       				<a href="/edu/onlineEdu/themeLecture/list.do?menuNo=500157" class="process_more_btn">더보기</a>
                       			</span> -->
                       			
                       			<div class="vertical_slide scroll-none">
		                            <ul>
		                            	<c:forEach items="${hitSubjList }" var="item" varStatus="status" end="8">
			                                <li>
			                                    <a href="javascript:void(0)" onclick="fnCmdViewPage('${item.subj }', '${item.subjnm }', '${item.isonoff }', '${item.scupperclass }', '${item.uclassnm }', '${item.scyear }', '${item.subjseq }', '500027'); return false;" class="show-block">
			                                        <div class="img_box">
			                                            <c:choose>
						                                    <c:when test="${item.introducefilenamenew != null and item.introducefilenamenew != '' }">
						                                        <img alt="${item.subjnm }" src="<c:out value="${fn:replace(item.introducefilenamenew, crlf, '/') }" />" />
						                                    </c:when>
						                                    <c:otherwise>
						                                        <img alt="${item.subjnm }" src="/upload/bulletin/Subject_introducefile_201407171657471_lee1.gif"/>
						                                    </c:otherwise>
						                                </c:choose>
			                                        </div>
			                                        <div class="edu_info">
			                                            <span class="point_blue edu_title abbreviation">
			                                            	${item.subjnm }
			                                            </span>
			                                            <p class="edu_content abbreviation3">
			                                            	<c:if test="${not empty item.subjsummary }">
																<c:set var="arrayofsubjintro" value="${fn:split(item.subjsummary,'-')}"/>
																<c:forEach var="i" begin="0" end="${fn:length(arrayofsubjintro)-1 }">
																	${arrayofsubjintro[i] }<br />
																</c:forEach>
															</c:if>
			                                            </p>
			                                        </div>
			                                    </a>
			                                </li>
			                         	</c:forEach>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
		                
		                <!-- 아카데미이야기 -->
                    	<div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 contentBox">
                    		 <div class="box_ct">
                       			<span class="ct_title">콘텐츠 이야기</span>
                       			<span class="btn_more float-right">
                       				<a href="/edu/bbs/B0000023/list.do?menuNo=500013" class="process_more_btn">더보기</a>
                       			</span>
                       			
		                        <div class="list_box">
		                            <ul>
		                            	<c:forEach var="result" items="${academyBoardList}" varStatus="status">
			                                <li>
			                                    <a href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500013">
			                                        <span class="abbreviation"><c:out value="${result.nttSj}"/></span>
			                                        <span><c:out value="${fn:substring(result.regDate,0,10)}"/></span>
			                                    </a> 
			                                </li>
										</c:forEach>
		                            </ul>
		                        </div>
			            	</div>
		                </div>
		                
		                <!-- 맞춤교육지원사업 -->
		                <!-- 
		                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 contentBox">
		                    <div class="box_ct full_banner" data-image="/edu/new_image/background/sub_main_visual_img_003.jpg">
		                        <span>맞춤교육지원사업</span>
		                        <a class="btn_go" href="/edu/main/contents.do?menuNo=500005">바로가기</a>
		                        <p>단체 맞춤 사업은 한국콘텐츠진흥원에서 운영하는<br/>온라인교육과정을 기업, 교육청, 대학 등<br/>기관 및 단체에게 제공하는 교육 서비스입니다.</p>
		                    </div>
		                </div> 
		                -->
		                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 swiper-container contentBox" id="full_banner_slide">
		            		<div class="swiper-wrapper">
		            			<!-- 반복 -->
		            			<c:forEach var="result" items="${eventList }" varStatus="status">
		            			<div class="swiper-slide">
		            				<a class="btn_go" href="/edu/bbs/<c:out value="${result.bbsId}"/>/view.do?nttId=<c:out value="${result.nttId}"/>&amp;menuNo=500018">
		            				<div class="full_banner">
		            					<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&fileSn=<c:out value="${result.fileSn}"/>" alt="<c:out value="${result.nttSj}"/>">
			            				<span>&nbsp;</span>
				                        <p>&nbsp;</p>
	                                </div>
	                                </a>
		            			</div>
		            			</c:forEach>
		            			<!-- //반복 -->
		            			<!-- 반복 -->
		            			<c:forEach var="result" items="${themeEvent }" varStatus="status">
		            			<div class="swiper-slide">
		            				<a class="btn_go" href="<c:out value="${result.ntcnUrl}"/>">
		            				<div class="full_banner">
		            					<img src="/cmm/fms/getImage.do?atchFileId=<c:out value="${result.atchFileId}"/>&fileSn=<c:out value="${result.fileSn}"/>" alt="<c:out value="${result.ntcnNm}"/>">
			            				<span>&nbsp;</span>
				                        <p>&nbsp;</p>
	                                </div>
	                                </a>
		            			</div>
		            			</c:forEach>
		            			<!-- //반복 -->
			            	</div>
			            	<!-- <div class="swiperControlBox">
				            	<div class="col-12 swiper-pagination"></div>
				            	<div class="swiper-button-prev"><i class="fas fa-chevron-left"></i></div>
   								<div class="swiper-button-next"><i class="fas fa-chevron-right"></i></div>
   								<div class="swiper-autoplay-stop"><i class="fas fa-pause"></i></div>
  							</div> -->
  						</div>
  						
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //contents -->
	<div class="print_out">
    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/edu/inc/eduFooter.jsp" flush="true" />
    <!-- //footer -->
    </div>
    </div>
</body>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		//탭 토글
		$("a.tabToggle").on("click", function(){
			tabToggle($(this));
		});
		
		//과정 조회 enter key
		$("#search_word").keydown(function(e) {
			if (e.keyCode == 13) {
				fn_search();
				
			}
		});
		
		$("#searchBtn").click(function(){
			fn_search();
		});
	});
	
	function fn_search(){
		if($("#search_type").val() == ""){
			alert("과정구분을 선택해 주세요.");
			$("#search_type").focus();
			return false;
		}
		
		if($("#search_word").val() == ""){
			alert("검색어를 입력해 주세요.");
			return false;
		}
		
		if($("#search_type").val() == "01"){
			$("#form_search").attr("action", "/edu/onlineEdu/realm/list.do");
			$("#menuNo").val("500027");
			$("#p_searchtext").val($("#search_word").val());
			$("#form_search")[0].submit();
			//location.href = '/edu/onlineEdu/realm/list.do?menuNo=500027&p_searchtext='+$("#searchWrd").val();
		}
		if($("#search_type").val() == "02"){
			$("#form_search").attr("action", "/edu/onlineEdu/openLecture/list.do");
			$("#menuNo").val("500085");
			$("#searchCnd").val("1");
			$("#searchWrd").val($("#search_word").val());
			$("#form_search")[0].submit();
			//location.href = '/edu/onlineEdu/openLecture/list.do?menuNo=500085&searchCnd=1&searchWrd='+$("#searchWrd").val();
		}
	}

	//탭 토글
	function tabToggle($this){

		var tabId = $this.parent().attr("id");

		$("#pTabgubun").val(tabId);

		$("a.tabToggle").parent().removeClass("active");
		$this.parent().attr("class", "active");

		$("#subjrealm").hide();
		$("#subjoccp").hide();
		$("#subj"+tabId).show();

	}


	//과정 상세화면
	function fnCmdViewPage(subj, subjnm, isonoff, scupperclass, uclassnm, scyear, subjseq, mununo){

		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_isonoff").val(isonoff);
		$("#p_scupperclass").val(scupperclass);
		$("#p_uclassnm").val(uclassnm);
		$("#p_year").val(scyear);
		$("#p_subjseq").val(subjseq);

		$("#frm").attr({
					action:"/edu/onlineEdu/realm/view.do?menuNo="+mununo,
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}



//]]>
</script>
