<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<style>
.visual_wrap h2{margin-bottom:80px !important;}
@media all and(min-width:992px){
	.visual_wrap h2{margin-bottom:100px !important;}
}
.lnb_wrap {display: none !important;}
.sub_contents_wrap .sub_contents {padding-left:0 !important;}
</style>

<!--content-->

	<!-- <div class="board_util_btn_con left">
		<a href="/upload/onlineEdu/kocca_subj.xlsx" class="btn_style_0 full down">한국 콘텐츠 아카데미 과정 리스트 다운로드</a>
	</div> -->
	
	
	<div>
		<ul class="photoTab photoTab-size5 online_edu_tab_style mg_b50" id="tabNavCtrl">
			<!-- 분류별 탭 목록 s -->
			<c:forEach items="${realmTabList }" var="item" varStatus="status">
					<c:set var="selectedGubun" value=""/>
					<c:set var="selectedGubunAtag" value=""/>
					<c:if test="${(empty param.pGubun1 and empty param.gubun and item.code eq 'A') or param.pGubun1 eq item.code or param.gubun eq item.code}">
						<c:set var="selectedGubun" value="class=\"active\""/>
						<c:set var="selectedGubunAtag" value="title=\"현재탭\""/>
					</c:if>
					<c:if test="${(fn:length(item.code) < 3 && item.code ne 'O0')}">
					<li ${selectedGubun } <c:if test="${(item.code eq 'T0' && param.pGubun1 ne 'T0') }">style="display:none"</c:if> >
						<a href="javascript:void(0);" onclick="fnCmdSearchList('${item.code }', '', '', '', ''); return false;" ${selectedGubunAtag}>
							${item.codenm }
						</a>
					</li>
					</c:if>
			</c:forEach>
			<c:if test="${userVO.userId eq 'kkj9699' or userVO.userId eq 'jmh8263' or userVO.userId eq 'lee1'}">
				<li <c:if test="${param.pGubun1 eq 'T0' or param.gubun eq 'T0' }">class="active"</c:if>>
					<a href="javascript:void(0);" onclick="fnCmdSearchList('T0', '', '', '', ''); return false;">콘텐츠검수</a>
				</li>
			</c:if>
		</ul>
	</div>

	<div class="d_flex col-12 show-table sub_board_header control_board_header mg_b20">
		<div>
			<span>과정검색 </span>
			<div>
				<c:if test="${param.pGubun1 eq 'A' or empty param.pGubun1}">
					<select  class="relation_site SL01 gubunBox" ordr="2">
						<option value="">장르</option>
						<c:forEach items="${realmTabList}" var="item" varStatus="status">
							<c:if test="${fn:length(item.code) < 3 and item.code ne 'T0' and item.code ne 'A' and item.code ne 'O0'}">
								<option value="${item.code}" <c:if test="${param.p_type eq item.code}">selected="selected"</c:if>>${item.codenm}</option>
							</c:if>
						</c:forEach>
				    </select>
				</c:if>

			    <select class="relation_site SL02 gubunBox" ordr="3">
			    	<option value="">대분류</option>
			    	
			    	<c:if test="${param.pGubun1 ne 'A' or not empty param.pGubun1}">
			    		<c:forEach items="${gubunList}" var="item" varStatus="status">
			    			<option value="${item.code}" <c:if test="${param.p_gcd1 eq item.code}">selected="selected"</c:if>>${item.codenm}</option>
			    		</c:forEach>
			    	</c:if>
			    </select>
			    <select class="relation_site SL03">
			    	<option value="">소분류</option>
			    </select>
			    <select class="relation_site SL04">
			    	<option value="">난이도</option>
			    	
			    	<c:if test="${param.pGubun1 ne 'A' or not empty param.pGubun1}">
			    		<c:forEach items="${levelList}" var="item" varStatus="status">
			    			<option value="${item.code}" <c:if test="${param.p_level eq item.code}">selected="selected"</c:if>>${item.codenm}</option>
			    		</c:forEach>
			    	</c:if>			    	
			    </select>
			</div>
		</div>
		
		<div class="show-tablecell fn vm tr board_sorting_con">
			<form id="frm" name="frm" action="/edu/onlineEdu/${paramVO.programId}/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>" method="post">
					
				<input type="hidden" name="pGubun1" id="pGubun1" value='<c:out value="${not empty param.pGubun1?param.pGubun1:param.gubun }" />' />
				<input type="hidden" name="pGubun2" id="pGubun2" value='<c:out value="${not empty param.pGubun2?param.pGubun2:param.option1 }" />' />
				<input type="hidden" name="pGubun3" id="pGubun3" value='<c:out value="${not empty param.pGubun3?param.pGubun3:param.option5 }" />' />
				
				<input type="hidden" name="p_ordersnm" id="p_ordersnm" value='<c:out value="${param.p_ordersnm }"/>' />
				<input type="hidden" name="p_orders" id="p_orders" value='<c:out value="${param.p_orders }"/>' />
				
				<input type="hidden" name="p_subj" id="p_subj" value="" />
				<input type="hidden" name="p_subjnm" id="p_subjnm" value="" />
				<input type="hidden" name="p_isonoff" id="p_isonoff" value="" />
				<input type="hidden" name="p_scupperclass" id="p_scupperclass" value="" />
				<input type="hidden" name="p_uclassnm" id="p_uclassnm" value="" />
				<input type="hidden" name="p_year" id="p_year" value="" />
				<input type="hidden" name="p_subjseq" id="p_subjseq" value="" />
			
				<input type="hidden" name="s_subj" id="s_subj" value="" />
				<input type="hidden" name="s_year" id="s_year" value="" />
				<input type="hidden" name="s_subjseq" id="s_subjseq" value="" />
				
				<input type="hidden" name="p_type" id="p_type" value="${param.p_type }" />
				<input type="hidden" name="p_gcd1" id="p_gcd1" value="${param.p_gcd1}" />
				<input type="hidden" name="p_gcd2" id="p_gcd2" value="${param.p_gcd2}" />
				<input type="hidden" name="p_level" id="p_level" value="${param.p_level}" />
				<input type="hidden" name="p_sort" id="p_sort" value="${param.p_sort}" />
				
				<!-- paging s -->
				<input type="hidden" name="gubun" id="gubun" value="<c:out value='${param.gubun }' />" />
				<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${param.pageIndex }' />" />
				<!-- paging e -->
				
				<fieldset class="mo-ta_lt">
					<legend>검색 입력폼</legend>
					<span class="process_icon_wrap">
						<span class="icon_con">
							<img src="/edu/images/bm/online_pc_icon.png" alt="pc과정">
						</span>
						<span class="icon_text">
							PC과정
						</span>
					</span>
					<span class="process_icon_wrap">
						<span class="icon_con">
							<img src="/edu/images/bm/online_mobile_icon.png" alt="모바일과정">
						</span>
						<span class="icon_text">
							모바일과정
						</span>
					</span>
					<span class="tl input_search_con">
						<input type="text" name="p_searchtext" id="p_searchtext" placeholder="검색어 입력" title="검색어를 입력해 주세요." value="${param.p_searchtext }" maxlength="30" class="board_search"/> 
						<a href="javascript:void(0);" onclick="fnCmdSearchList2('${empty param.pGubun1 ? 'A':param.pGubun1}', '${param.pGubun2 }', '${param.pGubun3 }', '', ''); return false;" class="search_summit">검색</a>
					</span>
				</fieldset>
			</form>
		</div>
	</div>
	
	<div class="mo-ta_lt mo-mb_20 show-tablecell fn vm board_title online_edu_board_title">
		<h4 class="display_IB pd_t12">
			검색 건 수 :  <span class="board_count">${resultCnt}</span> 건
		</h4>
		<select class="relation_site sortBox" id="s_sort" name="s_sort" title="정렬순서">
			<option value="N" title="최신순" <c:if test="${param.p_sort eq 'N'}">selected="selected"</c:if>>최신순</option>
			<option value="O" title="오래된순" <c:if test="${param.p_sort eq 'O'}">selected="selected"</c:if>>오래된순</option>
			<option value="V" title="시청많은순" <c:if test="${param.p_sort eq 'V'}">selected="selected"</c:if>>시청많은순</option>
	    </select>
	</div>	
	
	<div class="photoGallery2 photoLine1 mg_t5">
		<div class="col-12 calc_wrap20">
			<c:if test="${fn:length(resultList) > 0}">
			<c:forEach items="${resultList }" var="item3" varStatus="status3">
				<div class="col-12 col-md-3 online_edu_card_wrap">
					<div class="col-12 online_edu_card_list">
						<a class="show-block" href="javascript:void(0);" onclick="fnCmdViewPage('${item3.subj }', '${item3.subjnm }', '${item3.isonoff }', '${item3.scupperclass }', '${item3.uclassnm }', '${item3.scyear }', '${item3.subjseq }'); return false;">
							<% pageContext.setAttribute("crlf", "\\"); %>
							<div class="img_box">
								<c:choose>
									<c:when test="${item3.introducefilenamenew == null or item3.introducefilenamenew == '' }">
										<img src="/edu/images/bm/kofac_card_img_001.jpg" style="width:100%" alt="${item3.subjnm } 임시 이미지"/>
									</c:when>
									<c:otherwise>
										<img alt="${item3.subjnm } - 메인 이미지" src="<c:out value="${item3.introducefilenamenew}" />"  />
									</c:otherwise>
								</c:choose>
							</div>
							<div class="text_box">
								<div class="online_edu_card_icon_con">
									<span class="online_edu_card_icon">
										<img src="/edu/images/bm/online_pc_icon.png" alt="pc에서 재생가능" title="pc에서 재생가능">
									</span>
									
									<c:if test="${item3.mobileUseYn eq 'Y' }">
										<span class="online_edu_card_icon">
											<img src="/edu/images/bm/online_mobile_icon.png" alt="모바일에서 재생가능" title="모바일에서 재생가능" />
										</span>
									</c:if>
									
						<c:if test="${not empty item3.lvnm}">
							<c:choose>
								<c:when test="${item3.lvcd eq 'L0101' or item3.lvcd eq 'L0201'}">
									<span class="tag L1">${item3.lvnm}</span>
								</c:when>
								<c:when test="${item3.lvcd eq 'L0102' or item3.lvcd eq 'L0202'}">
									<span class="tag L2">${item3.lvnm}</span>
								</c:when>
								<c:when test="${item3.lvcd eq 'L0103' or item3.lvcd eq 'L0203'}">
									<span class="tag L3">${item3.lvnm}</span>
								</c:when>								
							</c:choose>
						</c:if>
						
								<c:if test="${not empty item3.g3nm}">
									<span class="gray_txt">${item3.g3nm}</span>
								</c:if>		
								
								<c:if test="${empty item3.g3nm}">
									<span class="gray_txt">${item3.g2nm}</span>
								</c:if>					
									
								</div>
								<div class="online_edu_card_title">
									<h4>
										<c:if test="${item3.isnew eq 'Y' }">
											<c:if test="${ item3.ishit eq 'N'}">
												<c:if test="${ item3.isrecom eq 'Y'}">
													<span style="color: #FF5200;">[New]</span>
													<!--
													<img src="http://mail2.kocca.kr:8090/template/template/20180703152920/561/New_2_2.jpg" alt="New" >
													-->
												</c:if>
											</c:if>
										</c:if>
										${item3.subjnm }
									</h4>
								</div>
								<div class="online_edu_desc">
									<c:if test="${not empty item3.subjsummary }">
										<c:set var="arrayofsubjintro" value="${fn:split(item3.subjsummary,'-')}"/>
										<c:forEach var="i" begin="0" end="${fn:length(arrayofsubjintro)-1 }">
											${arrayofsubjintro[i] }<br />
										</c:forEach>
									</c:if>
								</div>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${fn:length(resultList) < 1}">
				<div style="text-align: center; vertical-align: middle">검색된 데이터가 없습니다.</div>
			</c:if>
		</div>
	</div>
	
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">${pageNav}</div>
	</c:if>



<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		var tabNavControl = $('#tabNavCtrl>li>a').not(':first');
		var subNavLayer = $('.tabSubNav')
		$(tabNavControl).each(function(index, el) {
			$(this).click(function(event) {
				$(this).parent().addClass('active').siblings().removeClass('active');
				$(subNavLayer).hide();
				$(this).next('.tabSubNav').show();
				return false;
			});
		});
		var subNavLayer = $('.tabSubNav')
		$('.tabSubClose').each(function(index, el) {
			$(this).click(function(event) {
				$(subNavLayer).hide();
			});
		});
		
		//과정 조회 enter key
		$("#p_searchtext").keydown(function(e) {
		    if (e.keyCode == 13) fnCmdSearchList2('${empty param.pGubun1 ? "A":param.pGubun1}', '${param.pGubun2 }', '${param.pGubun3 }', '', '');
		});
		
		$(".item2Tab").change(function(){
			$(this).parent(".tabSubNav").find(".subList").hide();
			$("#"+$(this).val()).show();
		});
		
		$('#option1').change(fnComChangeGubun);
		$('#option5').change(fnComChangeGubun);
		
		$(".gubunBox").change(function (){
			fnLvCodeList($(this));
		});
		
		$(".sortBox").change(function (){
			fnCmdSearchList2('${param.pGubun1}', '', '', '', '');
		});
		
		if($(".SL01").val() != ""){
			fnLvCodeList($(".SL01"));
		}
		
 		if($(".SL02").val() != ""){
			fnLvCodeList($(".SL02"));
		}		
	});
	
	//하위 분류코드 목록
	function fnLvCodeList($this){
		var ordr = $this.attr("ordr");
		var code = $this.val();
		
		$.ajax({
			type:"POST",
			url:"/edu/onlineEdu/realm/gubunList.json",
			data:{
				"p_ordr":ordr,
				"p_code":code
				},
			cache:false,
			async:false,
			dataType:"JSON",
			success:function(data){
				if(ordr == 2){
					$(".SL02").empty();
					$(".SL02").append("<option value=''>대분류</option>");
	         		$.each(data.gubunList, function(idx, item) {
	         			if('${param.p_gcd1}' == item.code){
		        			$(".SL02").append("<option value=\""+item.code+"\" selected='selected'>"+ item.codenm +"</option>");
	         			}else{
	         				$(".SL02").append("<option value=\""+item.code+"\">"+ item.codenm +"</option>");
	         			}
		        	});
	         		
					$(".SL03").empty();
					$(".SL03").append("<option value=''>소분류</option>");
					
					$(".SL04").empty();
					$(".SL04").append("<option value=''>난이도</option>");
	         		$.each(data.levelList, function(idx, item) {
	         			if('${param.p_level}' == item.code){
		        			$(".SL04").append("<option value=\""+item.code+"\" selected='selected'>"+ item.codenm +"</option>");
	         			}else{
	         				$(".SL04").append("<option value=\""+item.code+"\">"+ item.codenm +"</option>");
	         			}
		        	});					
				}else if(ordr == 3){
					$(".SL03").empty();
					$(".SL03").append("<option value=''>소분류</option>");
	         		$.each(data.gubunList, function(idx, item) {
	         			if('${param.p_gcd2}' == item.code){
		        			$(".SL03").append("<option value=\""+item.code+"\" selected='selected'>"+ item.codenm +"</option>");
	         			}else{
	         				$(".SL03").append("<option value=\""+item.code+"\">"+ item.codenm +"</option>");
	         			}
		        	});
				}
				
			},
			error:function(){
				alert("서버와 통신 실패");
			}
		});		
	}	
	
	//과정 조회
	function fnCmdSearchList(gubun1, gubun2, gubun3, ordersnm, orders){
		$("#pGubun1").val(gubun1);
		$("#pGubun2").val(gubun2);
		$("#pGubun3").val(gubun3);
		$("#option1").val(gubun2);
		$("#option5").val(gubun3);
		$("#p_ordersnm").val(ordersnm);
		$("#p_orders").val(orders);
		
		$("#pageIndex").val("1");
		$("#p_searchtext").val("");
		$("#p_type").val("");
		$("#p_gcd1").val("");
		$("#p_gcd2").val("");
		$("#p_level").val("");
		$("#p_sort").val("N");

		$("#frm").attr({
					action:"/edu/onlineEdu/realm/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
	//과정 조회
	function fnCmdSearchList2(gubun1, gubun2, gubun3, ordersnm, orders){
		$("#pGubun1").val(gubun1);
		$("#pGubun2").val(gubun2);
		$("#pGubun3").val(gubun3);
		$("#option1").val(gubun2);
		$("#option5").val(gubun3);
		$("#p_ordersnm").val(ordersnm);
		$("#p_orders").val(orders);
		
		$("#p_type").val($(".SL01").val());
		$("#p_gcd1").val($(".SL02").val());
		$("#p_gcd2").val($(".SL03").val());
		$("#p_level").val($(".SL04").val());
		$("#p_sort").val($("#s_sort").val());
		
		$("#pageIndex").val("1");
		$("#p_searchtext").val($.trim($("#p_searchtext").val()));

		$("#frm").attr({
					action:"/edu/onlineEdu/realm/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}	
	
	function fnComChangeGubun(){
		$("#pGubun1").val("${empty param.pGubun1 ? 'A' : param.pGubun1}");
		$("#pGubun2").val($('#option1').val());
		$("#pGubun3").val($('#option5').val());
		$("#p_ordersnm").val('');
		$("#p_orders").val('');
		
		$("#pageIndex").val("1");
		$("#p_searchtext").val($.trim($("#p_searchtext").val()));
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/list.do?menuNo=<c:out value='${paramVO.menuNo }'/>",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
	
	//과정 상세화면
	function fnCmdViewPage(subj, subjnm, isonoff, scupperclass, uclassnm, year, subjseq){
		$("#p_subj").val(subj);
		$("#p_subjnm").val(subjnm);
		$("#p_isonoff").val(isonoff);
		$("#p_scupperclass").val(scupperclass);
		$("#p_uclassnm").val(uclassnm);
		$("#p_year").val(year);
		$("#p_subjseq").val(subjseq);
		
		$("#s_subj").val(subj);
		$("#s_year").val(year);
		$("#s_subjseq").val(subjseq);
		
		$("#frm").attr({
					action:"/edu/onlineEdu/realm/view.do?menuNo=<c:out value='${paramVO.menuNo }'/>&gubun="+$("#pGubun1").val()+"&option1="+$("#pGubun2").val()+"&option5="+$("#pGubun3").val()+"&pageIndex=<c:out value='${param.pageIndex}' />",
					method:"post",
					target:"_self"
					});
		$("#frm").submit();
	}
//]]>
</script>
