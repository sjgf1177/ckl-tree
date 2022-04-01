
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>

<div class="row mb5">
	<p><span class="icoDanger"></span>  찜 한 강좌는 최대 30개까지 보관되며 30개 초과시 오래된 순서로 자동 삭제 됩니다.</p>
</div>

<div class="photoGallery2 photoLine1">
	<ul>

		<!-- 열린강좌 찜목록  -->
		<c:forEach items="${resultList }" var="result" varStatus="status">
			<li>
			 <c:url var="url" value="/edu/onlineEdu/openLecture/view.do">
                 <c:param name="pSeq" value="${result.seq }"/>
                 <c:param name="pLectureCls" value="${param.pLectureCls }"/>
                 <c:param name="menuNo" value="${param.menuNo }"/>
                 <c:param name="myOpenLecture" value="Y"/>
             </c:url>
				<a href="<c:out value="${url }" />" >
					<span class="img">
							<img alt="<c:out value='${result.lecnm }' escapeXml='false'/>" src="<c:out value="${result.vodimg }" />"  />
					</span>
					<span class="title point tal"><strong><c:out value="${result.lecnm }" /></strong></span>
					<span class="db tal"><c:out value="${result.intro }" /></span>
				</a>
			</li>
		</c:forEach>
		<!-- 열린강좌 찜목록  -->
	</ul>
</div>
