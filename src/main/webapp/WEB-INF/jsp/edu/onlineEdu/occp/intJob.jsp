<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set value="${param.pGubun1 }${param.pGubun2 }" var="intJobGubun" />

<div class="grayBox2 mt10 intJob" <c:if test="${'G0S01T08' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">게임 시나리오 작가</dt>
		<dd>
			각종 캐릭터의 역할 및 특징, 기본적인 슽뢰 등에 대한 게임기획자의 설명을 듣고 게임의 전반적인 개념 이해와 게임흐름을 이해한다.<br />
			세부적인 게임스토리 창출을 위하여 설정, 주제설정, 소재탐구, 게임벤치마킹 등 게임의 전반적인 기획을 연구한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>게임 프로젝트 매니저, 엔터테인먼트 미디어 기획자, 게임운영자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'G0S01T09' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">컨셉 디자이너</dt>
		<dd>
			배경 / 인터페이스 / 캐릭터 / 아이템 등의 게임에 필요한 모든 것을 창조해내는 직업이다.
			게임의 전반적인 분위기를 만들어내는 가장 기본적이면서도 가장 중요한 역할을 한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>게임기획자, 게임 컨셉디자이너 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'B0S01T01' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">방송기획 PD</dt>
		<dd>
			PD란 말은 '프로그램 디렉터(program director)'의 약어이다.
			아이디어 개발은 기본이고, 제작 현장에서 제각기 다른 의견을 제시하는 많은 참여자들의 조정자 역할을 한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>CM플래너, PD프로덕션 PD, 크리에이티브 부티크 PD, 스토리보드 아티스트 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'B0S01T02' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">방송기획 제작자</dt>
		<dd>
			경영관리 총책임자, producer는 고유한 외래어 직함으로 금전적인 내용에 대한 책임을 지는 사람에 대한 호칭으로 쓰인다.
			일반적으로 영화 제작 회사의 사장에 대한 직함에 대한 용어로 사용한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>디지털케이블 방송제작자, 영화기획자, 인터넷 온라인 교육 프로그램 제작자 등</dd>
	</dl>
</div>




<div class="grayBox2 mt10 intJob" <c:if test="${'B0S01T03' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">구성작가</dt>
		<dd>
			텔레비전, 라디오, 인터넷 등의 오락프로그램, 교양물 등의 비드라마용 방송프로그램의 진행 원고를 작성한다.
			텔레비전의 오락물, 교양물 프로그램, 라디오 프로그램 등의 방송내용 기획과 방향을 방송프로듀서(방송연출가)와 협의한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>라디오 / 교양 / 다큐멘터리 / 예능 작가 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'B0S01T04' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">시나리오 작가</dt>
		<dd>
			기본적인 스토리를 토대로 세부적인 시나리오를 작성한다.
			세부적인 스토리 창출을 위하여 주제설정, 소재탐구, 벤치마킹 등 전반적인 기획을 연구한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>영화시나리오 작가, 드라마 작가 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'B0S02T01' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">방송제작 PD</dt>
		<dd>
			PD란 말은 '프로그램 디렉터(program director)'의 약어이다.
			아이디어 개발은 기본이고, 제작 현장에서 제각기 다른 의견을 제시하는 많은 참여자들의 조정자 역할을 한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>영화감독, 방송제작자, TV 드라마 연출가, 프로그램(예능, 교양, 다큐멘터리) PD 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'B0S02T05' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">촬영감독</dt>
		<dd>
			영화, 방송프로그램 제작을 위해 카메라 촬영 업무를 총괄하고, 촬영기사의 활동을 조정, 감독한다.
			촬영할 대본(시나리오)을 분석하여 촬영 방향 및 연출할 영상 효과에 대하여 논의한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>방송국카메라맨, 촬영기사, 촬영감독, 지미집 감독, 조명감독 등</dd>
	</dl>
</div>

<div class="grayBox2 mt10 intJob" <c:if test="${'B0S02T06' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">편집기술감독</dt>
		<dd>
			방송 프로그램의 제작기술업무를 총괄하며, 비디오믹서를 조작하여 여러 카메라 영상 중에 적합한 영상을 선택한다.
			영상, 음향, 조명감독 등 기술팀 회의를 주관하고 의견을 조율한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>지상파 및 케이블 방송사 기술 스텝, 기술인 컨소시엄 그룹, 방송통신산업기사, 방송영상 기사 등</dd>
	</dl>
</div>

<div class="grayBox2 mt10 intJob" <c:if test="${'B0S03T07' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">방송콘텐츠 마케팅 디렉터</dt>
		<dd>
			방송콘텐츠 마케팅 디렉터는 방송 콘텐츠 판매 뿐만 아니라 프로그램의 제작협찬, PPL등을 기획하고 하나의 콘텐츠를 영화, 게임,<br />
			음반 등 다양한 방식으로 판매하거나 콘텐츠의 부가가치를 올릴 수 있는 공연기획, 전시도 담당한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>방송콘텐츠 사업가, 엔터테인먼트 콘텐츠 수입 및 배급사, 방송콘텐츠 마케팅 디렉터, 영화 홍보/마케터 등</dd>
	</dl>
</div>

<div class="grayBox2 mt10 intJob" <c:if test="${'G0S02T10' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">모바일 게임 프로그래머</dt>
		<dd>
			게임기획자, 게임그래픽디자이너, 게임음악가 등으로부터 넘겨받을 자료를 어떻게 프로그램화할 것인지 설계 작업을 한다.
			모바일 게임을 제작하기 위한 툴인 게임엔진을 개발한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>멀티미디어 콘텐츠제작 전문가, 게임프로그래머, 게임툴 프로그래머, 서버 및 게임엔진관리자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'G0S02T11' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">그래픽 디자이너</dt>
		<dd>
			텔레비전과 영화, 광고에서 사용되는 그래픽을 전문적으로 구상, 기획하는 책임자 역할을 한다.
			포스터나 포장, 신문, 잡지광고 등의 인쇄매체를 중심으로 광범위한 작업을 한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>게임시스템 디자이너, 게임 스크립트 디자이너 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'G0S03T12' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">게임마케터</dt>
		<dd>
			게임시장의 동향과 게임이용자들의 성향 등을 파악하여 게임의 홍보 전략을 수립하고 소비자에게 게임을 홍보한다.
			관련업계 및 경쟁사의 자료를 수집하여 마케팅 동향을 파악하고 자사의 게임과 차별성에 대해 분석한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>웹 서비스 마스터, 게임마케터, 게임 퍼블리싱 전문가, QA, GM(게임 마스터) 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'K0S01T13' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">만화 스토리 작가</dt>
		<dd>
			만화 작품의 줄거리를 창작하는 사람이다. 만화 작가 또는 만화 원작자라고도 한다. 만화를 만화가가 전담하여 창작하지 않고
			만화 스토리와 작화를 분리하여 작업하는 경우에 만화 스토리 작가는 스토리를, 만화가는 작화를 담당한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>애니메이션 시나리오 작가, 만화 작가, 만화 원작자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'K0S01T14' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">애니메이션 제작자</dt>
		<dd>
			애니메이션 작품 제작과 관련한 예술적인 능력, 기술적인 일,
			기업적인 일 등의 모든 분야를 결합시키고 책임 관리하는 사람의 직책을 가리킨다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>애니메이션 아트 디렉터, 애니메이션 제작 및 기획자, 애니메이션 영화감독 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'K0S02T15' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">만화가</dt>
		<dd>
			만화의 주제 및 이야기를 창작하고 이에 따른 그림을 그린다.
			만화로 그릴 소재를 찾고 장르를 구분하여 주제를 정하는 등 아이디어를 구상한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>캐릭터 디자이너, 동화 일러스트레이터, 팬시캐릭터, 원화디자이너, 캐릭터 피규어 제작자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'K0S02T16' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">애니메이터</dt>
		<dd>
			애니메이션 만드는 것을 직업으로 하는 사람을 말한다.
			제작현장에서 동작을 그리는 사람, 즉 원화(밑그림) 및 동화(움직이는 그림) 연출을 담당한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>교육콘텐츠 개발 디자이너, VFX디자이너, 모델러, 2D/3D 애니메이터, 광고 애니메이터 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'K0S02T17' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">캐릭터 디자이너</dt>
		<dd>
			인물 또는 동물 등을 대상으로 특징적 혹은 상징적으로 표현한 일러스트레이션 형태의 캐릭터를 디자인한다.
			서적, 인터넷, 시장조사 등의 방법을 이용하여 온라인, 오프라인 상에서 유행하고 있는 캐릭터나 디자인의 흐름을 조사하고 분석한다. 
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>캐릭터 디자이너, 동화 일러스트레이터, 팬시캐릭터, 원화디자이너, 캐릭터 피규어 제작자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'K0S03T18' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">만화애니캐릭터콘텐츠 마케팅 디렉터</dt>
		<dd>
			만화애니캐릭터콘텐츠 마케팅의 전문가이다.
			즉 시장조사 및 그 분석을 한다. 주로 만화애니캐릭터콘텐츠를 주체로 콘텐츠기획부터 생산, 판매, 판촉에 이르게하는 작업을 한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>만화애니캐릭터 콘텐츠 사업가, 만화애니캐릭터 수입 및 배급사 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'M0S01T02' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">음악기획 제작자</dt>
		<dd>
			경영관리 총책임자, producer는 고유한 외래어 직함으로 금전적인 내용에 대한 책임을 지는 사람에 대한 호칭으로 쓰인다.
			일반적으로 영화 제작 회사의 사장에 대한 직함에 대한 용어로 사용한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>콘서트 프로듀서 및 기획자, 뮤지컬 프로듀서 및 기획자, 축제 연출가, 컨벤션 기획자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'M0S01T19' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">축제 기획자</dt>
		<dd>
			축제기획자는 기업의 이미지를 높이거나 지역 진흥을 위한
			전시회, 시사회, 축제, 자동차 시승회, 국제회의 등 다양한 축제의 기획 및 섭외, 실행을 한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>콘서트 프로듀서 및 기획자, 뮤지컬 프로듀서 및 기획자, 패션쇼 연출가, 축제 연출가, 컨벤션 기획자 등</dd>
	</dl>
</div>


<div class="grayBox2 mt10 intJob" <c:if test="${'M0S02T20' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">연출가</dt>
		<dd>
			각종 행사를 기획 준비하고 예산 일정에 맞추어 행사를 개최한다.
			각종 박람회 및 전시회, 문화행사, 판촉행사, 지역축제 등 의뢰받은 행사를 기획하기 위해 행사의 목적 및 특성을 파악한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>음악출제 연출가, 연극 연출가, 콘서트 연출가, 축제 연출가, 매니저, 무대감독, 패션쇼 연출가 등</dd>
	</dl>
</div>

<div class="grayBox2 mt10 intJob" <c:if test="${'M0S03T21' ne intJobGubun }">style="display: none;"</c:if>>

	<dl class="desc clearfix pb20" style="border-bottom:1px solid #d1d1d1">
		<dt class="point">예술 경영 컨설턴트</dt>
		<dd>
			예술경영컨설턴트는 예술경영에 관한 문제점을 분석하고 대책을 연구하며, 사업추진에 관한 상담과 자문을 제공한다.
			효율적인 경영을 위해 사업 및 조직체계를 검토, 분석하고 개선점을 제안한다.
		</dd>
	</dl>
	<dl class="clearfix inlineList">
		<dt>유사 직업군 -</dt>
		<dd>문화콘텐츠 마케터, 극장하우스 매니저, 공연예술 국제교류 전문가, 기업홍보대행사, 공연홍보대행사 등</dd>
	</dl>
</div>




<script type="text/javascript">
//<![CDATA[
           
	$(document).ready(function(){
		

	});
           
//]]>
</script>