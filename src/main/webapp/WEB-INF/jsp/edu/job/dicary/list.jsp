
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<ccc:constantsMap className="kr.co.unp.bbs.vo.SearchVO" var="SearchVO" />
<script type="text/javascript">
//<![CDATA[
	$(function() {
		$(".cateDiv").click(function() {
			var $this = $(this);
			var cate1 = $(this).attr("data-cate1");
			var cate2 = $(this).attr("data-cate2");
			var codeId = $(this).attr("data-codeId");
			var url = "/edu/job/dicary/occpDetailList.do";
			var params = {
					ctgrySe1 : cate1,
					ctgrySe2 : cate2,
					codeId : codeId,
					viewType : "CONTBODY",
					menuNo : "${param.menuNo }"
			};
			$.post(url, params, function(data) {
				$this.closest("li").find(".box").html(data);
			},"html");

			return false;
		});
	});
//]]>
</script>



					<div class="alert alert-info">
						<ul class="bull">
							<li>문화콘텐츠산업의 장르 및 직업 분류 체계에 따라 직업의 직무내용, 자격요건, 직업전망 등의 상세한 정보를 제공합니다.</li>
						</ul>
					</div>
					<div class="hidden"><h2>상세정보</h2></div>
					<div class="stepSet stepSetTitle">
						<ul class="category categoryWork">

					<%-- 코드 1--%>
					<c:set var="iconNo" value="1"/><%-- 카테고리 폰트 구분 --%>
		 			<c:forEach items="${COM083CodeList }" var="code" varStatus="status">
			 			<c:if test="${code.depth eq 1 }"> <%--1뎁스 카테고리 출력 --%>
			 			<!-- 컬러코드 글자  -->
			 			<c:choose>
			 			<c:when test="${iconNo%8 eq 1 }"> <%--애니메이션 --%>
							<c:set value="537725" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 2 }"><%--만화 --%>
							<c:set value="ae4979" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 3 }"><%--캐릭터 --%>
							<c:set value="1F74AD" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 4 }"><%--음악 --%>
							<c:set value="6A468D" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 5 }"><%--영화 --%>
							<c:set value="CE772B" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 6 }"><%--방송 --%>
							<c:set value="a08456" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 7 }"><%--게임 --%>
							<c:set value="579dbc" var="colorText" />
			 			</c:when>
			 			<c:when test="${iconNo%8 eq 8 }"><%--광고 --%>
							<c:set value="d24646" var="colorText" />
			 			</c:when>
			 			</c:choose>
		 			<%-- 컬러코드 1 끝 --%>
								<li class="ico0<c:out value="${iconNo }" />" <c:out value='${iconNo eq 5 or iconNo eq 7 ? "style=height:240px":"" }' />>
									<div class="headers <c:out value="${iconNo eq 5 or iconNo eq 7 ? 'mt50':'' }" />">
										<h3 class="<c:out value="${iconNo eq 5 or iconNo eq 7 ? 'mt30':'mr30' }" />" style="color:#<c:out value="${colorText }"/>"><c:out value="${code.codeNm }" /></h3>
									</div>
									<div class="step step2">
										<ul>
										<c:forEach items="${COM083CodeList }" var="codeSe" varStatus="stat">
										<c:if test="${code.code eq codeSe.upperCode  }"> <%--2뎁스 메뉴 --%>
										<c:url value="/edu/job/dicary/occpDetailList.do?&menuNo=${param.menuNo }&ctgrySe1=${code.code }&ctgrySe2=${codeSe.code }&colorCode=${colorText }"  var="url"/>
											<li><a href="#sub${stat.count }" class="icos cateDiv" data-codeId="<c:out value="${code.codeId }" />" data-cate1="<c:out value="${code.code }" />" data-cate2="<c:out value="${codeSe.code }" />"><c:out value="${codeSe.codeNm  }" /><span class="arr"></span></a>
												<div class="box" id="sub${stat.count }">

												</div>


											</li>
										</c:if>
										</c:forEach>
										</ul>
									</div>
								</li>
								<c:set var="colorText" value=""/>
							<c:set var="iconNo" value="${iconNo+1 }"/>
							</c:if>
							<c:url value="" var="url"/>
						</c:forEach>
						</ul>
					</div>

				<script type="text/javascript">
					//<![CDATA[
					jQuery(function(){
						var stepLinks= $(".step li>a") // 해당 탭리스트 링크 셀렉트
						$(stepLinks).each(function(index) {
							$(this).click(function() {
								var boxH = $(this).parent().find(".box").height()+120;

								$(this).parent().addClass('on').siblings().removeClass('on');
								$(stepLinks).removeClass("on");
								$(this).addClass('on').siblings().removeClass('on');
								$('.box').slideUp("fast");
								var boxHref = $(this).attr('href')
								$(boxHref).slideDown("fast");
								return false;
							});
						});
						$(".step .closer").click(function(){
							$('.box').slideUp("fast");
							$(this).parent().parent().find("a").focus();
							return false;
						})
					});



					/*$(function(){
						var stepList = $('.step>ul>li>a');
						var stepListDetail = $('.step>ul>li>div');

						stepList.each(function(){
							$(this).bind('click' , function()    {
								var onoff = $(this).next().hasClass('on');
								var onoffget = $(this).next();
								if (onoff){
									stepListDetail.removeClass('on');
									$(onoffget).removeClass('on');
									$(this).focus();
								}else{
									stepListDetail.removeClass('on');
									$(onoffget).addClass('on');
								}
								//return false;
							});
						});
						$(".step .closer").click(function(){
							$('.box').slideUp("fast");
							$(this).parent().parent().find("a").focus();
							//return false;
						})
					});*/
				//]]>
				</script>

 <%-- ###################################################################################################################### --%>
