package kr.co.edu.job.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.edu.job.paging.EmpmnInfoQuery;
import kr.co.edu.job.vo.EmpmnInfoVO;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.digester.Digester;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class EmpmnInfoService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	public static final String GET_WORK_LIST_URL = "http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?callTp=L&returnType=XML&" +
			"occupation=013|203206|204100|204102|204201|204203|051|081102|081103|081104|081105|" +
			"084300|084301|084302|054|085400|085401|085402|085406|085500|085501|085502|085503|" +
			"085504|086100|086101|086102|05B|087900|087901|088100|203206|085500|085501|085502|" +
			"085503|085504|085505|085506|204100|204102|204201|204203";
	public static final String GET_WORK_VIEW_URL = "http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?callTp=D&returnType=XML&infoSvc=VALIDATION";

	/**
	 * 채용정보 리스트 정보
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		super.initCmmnParam(param);
		paramCtx.setPageQuery(new EmpmnInfoQuery());
		paramCtx.setPageInfo(pageInfo);


		int pageUnit = param.getInt("pageUnit", 10);
		int pageSize = param.getInt("pageSize", 10);
		int pageIndex = param.getInt("pageIndex", 1);

		int totCnt = 0;
		model.addAttribute("resultCnt", totCnt);

		List<EmpmnInfoVO> resultList = this.getWorkOpenApiList(param);

		if( CollectionUtils.isNotEmpty(resultList) ){
			EmpmnInfoVO resultVO = resultList.get(0);
			totCnt = Integer.parseInt(resultVO.getTotal());
			model.addAttribute("resultCnt", totCnt);
			resultList.remove(0);
		}

		model.addAttribute("list", resultList);


		int totalPage = (totCnt - 1) / pageUnit + 1;
		model.addAttribute("totalPage", totalPage);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		param.put("pageIndex", pageIndex);
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		param.put("totCnt", paginationInfo.getTotalRecordCount());




		HttpServletRequest request = paramCtx.getRequest();
		String link = param.getString(CmmProgramService.PAGE_LINK);
		if( !StringUtils.hasText(link) ){
			link = request.getRequestURI();
			String pageLinkQueryString = paramCtx.getPageQuery().getPageLinkQueryString(param);
			model.addAttribute("pageQueryString",pageLinkQueryString);
			if( pageLinkQueryString != null )
				link += "?" + pageLinkQueryString;
		}
		String pageNav = paramCtx.getPageInfo().getPageNavString(pageSize, pageUnit, totCnt, pageIndex, link);
		model.addAttribute("pageNav", pageNav);
	}

	/**
	 * 채용정보 상세 정보
	 */
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		paramCtx.setPageQuery(new EmpmnInfoQuery());
		String pageLinkQueryString = paramCtx.getPageQuery().getPageLinkQueryString(param);
		model.addAttribute("pageQueryString",pageLinkQueryString);

		EmpmnInfoVO resultVO = this.getWorkOpenApiDetail(paramCtx);
		model.addAttribute("result", resultVO);
	}


	@SuppressWarnings("unchecked")
	private List<EmpmnInfoVO> getWorkOpenApiList(ZValue param) throws Exception{
		String apiKey = propertyService.getString("Globals.oepnapi.WorkApikey");
		param.put("authKey", apiKey);
		List<EmpmnInfoVO> workList = new ArrayList<EmpmnInfoVO>();
		List<EmpmnInfoVO> resultList = null;

		try {

		Digester digester = new Digester();
		digester.push(workList);

		digester.addObjectCreate("wantedRoot/total", EmpmnInfoVO.class);
		digester.addBeanPropertySetter("wantedRoot/total", "total");
		digester.addSetNext( "wantedRoot/total", "add" );


		digester.addObjectCreate("wantedRoot/wanted", EmpmnInfoVO.class);
		digester.addBeanPropertySetter("wantedRoot/wanted/wantedAuthNo", "wantedAuthNo");
		digester.addBeanPropertySetter("wantedRoot/wanted/company", "company");
		digester.addBeanPropertySetter("wantedRoot/wanted/title", "title");
		digester.addBeanPropertySetter("wantedRoot/wanted/salTpNm", "salTpNm");
		digester.addBeanPropertySetter("wantedRoot/wanted/sal", "sal");
		digester.addBeanPropertySetter("wantedRoot/wanted/region", "region");
		digester.addBeanPropertySetter("wantedRoot/wanted/holidayTpNm", "holidayTpNm");
		digester.addBeanPropertySetter("wantedRoot/wanted/minEdubg", "minEdubg");
		digester.addBeanPropertySetter("wantedRoot/wanted/maxEdubg", "maxEdubg");
		digester.addBeanPropertySetter("wantedRoot/wanted/career", "career");
		digester.addBeanPropertySetter("wantedRoot/wanted/regDt", "regDt");
		digester.addBeanPropertySetter("wantedRoot/wanted/closeDt", "closeDt");
		digester.addBeanPropertySetter("wantedRoot/wanted/infoSvc", "infoSvc");
		digester.addBeanPropertySetter("wantedRoot/wanted/wantedInfoUrl", "wantedInfoUrl");
		digester.addBeanPropertySetter("wantedRoot/wanted/zipCd", "zipCd");
		digester.addBeanPropertySetter("wantedRoot/wanted/strtnmCd", "strtnmCd");
		digester.addBeanPropertySetter("wantedRoot/wanted/basicAddr", "basicAddr");
		digester.addBeanPropertySetter("wantedRoot/wanted/detailAddr", "detailAddr");

		digester.addSetNext("wantedRoot/wanted", "add");


		String url = null;
		StringBuffer parameter = null;


		parameter = new StringBuffer();
		parameter.append("&authKey=").append(apiKey);
		parameter.append("&startPage=").append(param.getString("pageIndex","1")).append("&display=").append(param.getString("pageUnit","10"));
		parameter.append("&region=").append(param.getString("region")).append("&education=").append(param.getString("education"));
		parameter.append("&career=").append(param.getString("career")).append("&empTp=").append(param.getString("empTp"));
		parameter.append("&minCareerM=").append(param.getString("minCareerM")).append("&maxCareerM=").append(param.getString("maxCareerM"));
		parameter.append("&keyword=").append(param.getString("keyword"));

		url = GET_WORK_LIST_URL + parameter.toString();
		//System.out.println("==============================================================================================");
		//System.out.println("url => " + url);
		//System.out.println("==============================================================================================");
		resultList = (List<EmpmnInfoVO>) digester.parse(url);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultList;
    }


	private EmpmnInfoVO getWorkOpenApiDetail(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		String apiKey = propertyService.getString("Globals.oepnapi.WorkApikey");
		param.put("authKey", apiKey);
		EmpmnInfoVO resultVO = null;

		try {

		Digester digester = new Digester();

		digester.addObjectCreate("wantedDtl", EmpmnInfoVO.class);
		//digester.addSetProperties("wantedDtl/corpInfo", "corpNm", "corpNm");
		digester.addBeanPropertySetter("wantedDtl/wantedAuthNo", "wantedAuthNo");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/corpNm", "corpNm");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/reperNm", "reperNm");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/totPsncnt", "totPsncnt");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/capitalAmt", "capitalAmt");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/yrSalesAmt", "yrSalesAmt");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/indTpCdNm", "indTpCdNm");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/busiCont", "busiCont");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/corpAddr", "corpAddr");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/homePg", "homePg");
		digester.addBeanPropertySetter("wantedDtl/corpInfo/busiSize", "busiSize");


		digester.addBeanPropertySetter("wantedDtl/wantedInfo/jobsNm", "jobsNm");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/wantedTitle", "wantedTitle");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/relJobsNm", "relJobsNm");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/jobCont", "jobCont");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/receiptCloseDt", "receiptCloseDt");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/empTpNm", "empTpNm");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/collectPsncnt", "collectPsncnt");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/salTpNm", "salTpNm");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/enterTpNm", "enterTpNm");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/eduNm", "eduNm");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/forLang", "forLang");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/major", "major");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/certificate", "certificate");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/mltsvcExcHope", "mltsvcExcHope");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/compAbl", "compAbl");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/pfCond", "pfCond");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/etcPfCond", "etcPfCond");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/selMthd", "selMthd");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/rcptMthd", "rcptMthd");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/submitDoc", "submitDoc");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/etcHopeCont", "etcHopeCont");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/workRegion", "workRegion");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/indArea", "indArea");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/nearLine", "nearLine");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/workdayWorkhrCont", "workdayWorkhrCont");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/fourIns", "fourIns");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/retirepay", "retirepay");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/etcWelfare", "etcWelfare");
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/disableCvntl", "disableCvntl");

		/*
		digester.addObjectCreate("wantedDtl/wantedInfo/attachFileInfo", EmpmnInfoVO.class);
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/attachFileInfo/attachFileUrl", "attachFileUrl");
		digester.addSetNext("wantedDtl/wantedInfo/attachFileInfo", "add");

		digester.addObjectCreate("wantedDtl/wantedInfo/corpAttachList", EmpmnInfoVO.class);
		digester.addBeanPropertySetter("wantedDtl/wantedInfo/corpAttachList/attachFileUrl", "attachFileUrl");
		digester.addSetNext("wantedDtl/wantedInfo/corpAttachList", "add");
		*/

		digester.addBeanPropertySetter("wantedDtl/empchargeInfo/empChargerDpt", "empChargerDpt");
		digester.addBeanPropertySetter("wantedDtl/empchargeInfo/contactTelno", "contactTelno");
		digester.addBeanPropertySetter("wantedDtl/empchargeInfo/chargerFaxNo", "chargerFaxNo");

		String url = null;
		StringBuffer parameter = null;


		parameter = new StringBuffer();
		parameter.append("&authKey=").append(apiKey);
		parameter.append("&wantedAuthNo=").append(param.getString("wantedAuthNo"));

		url = GET_WORK_VIEW_URL + parameter.toString();

		//InputStream is = new ByteArrayInputStream(soap.toString().getBytes("utf-8"));
		resultVO = (EmpmnInfoVO) digester.parse(url);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultVO;
    }

}
