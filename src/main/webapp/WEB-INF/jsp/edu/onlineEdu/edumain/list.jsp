﻿<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>


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
 <!-- contents -->
   <div class="col-12 col-md-0 fn-md over-hidden fontsize0 sub_contents">
                    <div class="col-12 sub_section sub_main_contents_section">
						<div class="posr">
							<h2>정규과정</h2>
							<a href="/edu/onlineEdu/realm/list.do?p_ordersnm=favorsubjcnt&amp;p_orders=desc&amp;menuNo=500027" class="more"><span class="hidden">정규과정 더보기</span></a>
						</div>
						<div class="photoGallery5">
							<ul id="subjrealm">
								<c:forEach items="${realmSubjList }" var="item" varStatus="status" end="2">
									<li>
										<a href="javascript:void(0);" onclick="fnCmdViewPage('${item.subj }', '${item.subjnm }', '${item.isonoff }', '${item.scupperclass }', '${item.uclassnm }', '${item.scyear }', '${item.subjseq }', '500027'); return false;" class="link">
											<% pageContext.setAttribute("crlf", "\\"); %>
											<c:choose>
												<c:when test="${item.introducefilenamenew != null and item.introducefilenamenew != '' }">
													<img alt="${item.subjnm }" src="<c:out value="${fn:replace(item.introducefilenamenew, crlf, '/') }" />" width="336px;" height="216px;" />
												</c:when>
												<c:otherwise>
													<img alt="${item.subjnm }" src="/upload/bulletin/Subject_introducefile_201407171657471_lee1.gif" width="336px;" height="216px;"/>
												</c:otherwise>
											</c:choose>
											<span>${item.subjnm }</span>
										</a>
										<div class="icoSet">
											<c:if test="${item.isnew eq 'Y' }">
												<button title="인기강좌" tytpe="button" class="i love">인기강좌</button>
											</c:if>
											<c:if test="${item.ishit eq 'Y' }">
											<button title="추천강좌" tytpe="button" class="i voit">추천강좌</button>
											</c:if>
											<c:if test="${item.mobileUseYn eq 'Y' }">
											<button title="모바일에서 재생가능" tytpe="button" class="i mobileLink">모바일에서 재생가능</button>
											</c:if>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
						<div class="posr">
							<h2>열린강좌</h2>
							<a href="/edu/onlineEdu/openLecture/list.do?sortOrder=newOrdr&amp;menuNo=500085" class="more"><span class="hidden">열린강좌 더보기</span></a>
						</div>
						<div class="photoGallery5">
							<ul>
								<c:forEach items="${selectMainGoldClassList }" var="item" varStatus="status" end="2">
									<c:url var="url" value="/edu/onlineEdu/openLecture/view.do?pSeq=${item.seq }&amp;menuNo=500085&${pageQueryString }"/>
									<li>
										<a href='<c:out value="${url }&amp;pageIndex2=&amp;pLectureCls=${param.pLectureCls }" escapeXml='false' />' class="link">
											<c:choose>
												<c:when test="${item.vodimg != null and item.vodimg != '' }">
													<img src="<c:out value="${item.vodimg }" />" alt="${item.lecnm }" width="336px;" height="216px;" />
												</c:when>
												<c:otherwise>
													<img src="/upload/bulletin/Subject_introducefile_201407171657471_lee1.gif" alt="${item.lecnm }" width="336px;" height="216px;"/>
												</c:otherwise>
											</c:choose>
											<span>${item.lecnm }</span>
										</a>
									</li>
								</c:forEach>
							</ul>
						</div>



						<div class="boxBtm1">
							<ul>
								<li><a href="/edu/onlineEdu/edcsystm/list.do?menuNo=500030"><img src="/edu/images/edupro/gallery2Ft_01.gif" alt="교육체계도" /></a></li>
								<li><a href="/edu/main/contents.do?menuNo=500090"><img src="/edu/images/edupro/gallery2Ft_02.gif" alt="원격지원 서비스" /></a></li>
								<li><a href="/edu/main/contents.do?menuNo=500086"><img src="/edu/images/edupro/gallery2Ft_03.gif" alt="학습 가이드" /></a></li>
								<li><a href="/edu/bbs/B0000046/list.do?menuNo=500073"><img src="/edu/images/edupro/gallery2Ft_04.gif" alt="자주하는 질문" /></a></li>
								<li><a href="/edu/onlineEdu/mylctrum/list.do?menuNo=500061" class="brn"><img src="/edu/images/edupro/gallery2Ft_05.gif" alt="수료증" /></a></li>
							</ul>
						</div>
                        
                        
                    </div>
                </div>
    <!-- //contents -->


<script type="text/javascript">
//<![CDATA[


	$(document).ready(function(){

		//탭 토글
		$("a.tabToggle").on("click", function(){
			tabToggle($(this));
		});

	});

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

