package kr.co.ckl.search;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.response.SpellCheckResponse.Suggestion;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.params.CommonParams;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.DateUtil;

public class SearchService extends DefaultCmmProgramService {

	private static String SERVER_URL = EgovProperties.getProperty("Globals.Solr.url");
	private List<String> bbsFieldList;
	private List<String> progrmFieldList;
	private List<String> filesFieldList;
	private List<String> menuFieldList;
	private List<String> webpageFieldList;
	private List<String> onlineEduFieldList;

	@Resource(name="cacheUtil")
	private CacheUtil cacheUtil;

	public SearchService(){
	}

	public static enum SOLR_CORE {
		PROGRM("progrm"),
		WEBPAGE("webpage"),
		BBS("bbs"),
		MENU("menu"),
		FILES("files"),
		ONLINE_EDU("onlineEdu");

		private String value;

		private SOLR_CORE(String value){
			this.value = value;
		}

		public String getValue(){
			return this.value;
		}
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String range = param.getString("range");
		String rangeView = param.getString("rangeView");
		List<ZValue> bbsResultList = null;
		List<ZValue> progrmResultList = null;
		List<ZValue> filesResultList = null;
		List<ZValue> menuResultList = null;
		List<ZValue> webpageResultList = null;
		List<ZValue> onlineEduResultList = null;
		boolean rangeAll = !StringUtils.hasText(range) || "all".equals(range);
		if( rangeAll ){
			bbsResultList = getResultList(SOLR_CORE.BBS, bbsFieldList, param);
			model.addAttribute("bbsResultList", bbsResultList);

			progrmResultList = getResultList(SOLR_CORE.PROGRM, progrmFieldList, param);
			model.addAttribute("progrmResultList", progrmResultList);

			filesResultList = getResultList(SOLR_CORE.FILES, filesFieldList, param);
			model.addAttribute("filesResultList", filesResultList);

			menuResultList = getResultList(SOLR_CORE.MENU, menuFieldList, param);
			model.addAttribute("menuResultList", menuResultList);

			webpageResultList = getResultList(SOLR_CORE.WEBPAGE, webpageFieldList, param);
			model.addAttribute("webpageResultList", webpageResultList);

			onlineEduResultList = getResultList(SOLR_CORE.ONLINE_EDU, onlineEduFieldList, param);
			model.addAttribute("onlineEduResultList", onlineEduResultList);
		}
		else{
			if( "bbs".equals(range) ){
				bbsResultList = getResultList(SOLR_CORE.BBS, bbsFieldList, param);
				model.addAttribute("resultList", bbsResultList);
			}
			else if( "progrm".equals(range) ){
				progrmResultList = getResultList(SOLR_CORE.PROGRM, progrmFieldList, param);
				model.addAttribute("resultList", progrmResultList);
			}
			else if( "files".equals(range) ){
				filesResultList = getResultList(SOLR_CORE.FILES, filesFieldList, param);
				model.addAttribute("resultList", filesResultList);
			}
			else if( "menu".equals(range) ){
				menuResultList = getResultList(SOLR_CORE.MENU, menuFieldList, param);
				model.addAttribute("resultList", menuResultList);
			}
			else if( "webpage".equals(range) ){
				webpageResultList = getResultList(SOLR_CORE.WEBPAGE, webpageFieldList, param);
				model.addAttribute("resultList", webpageResultList);
			}
			else if( "onlineEdu".equals(range) ){
				onlineEduResultList = getResultList(SOLR_CORE.ONLINE_EDU, onlineEduFieldList, param);
				model.addAttribute("resultList", onlineEduResultList);
			}
		}

		long totalCount = 0;
		long bbsCnt = 0;
		long progrmCnt = 0;
		long filesCnt = 0;
		long menuCnt = 0;
		long webpageCnt = 0;
		long onlineEduCnt = 0;
		if( CollectionUtils.isNotEmpty(bbsResultList) ){
			bbsCnt = bbsResultList.get(0).getLong("numFound");
		}
		if( CollectionUtils.isNotEmpty(progrmResultList) ){
			progrmCnt = progrmResultList.get(0).getLong("numFound");
		}
		if( CollectionUtils.isNotEmpty(filesResultList) ){
			filesCnt = filesResultList.get(0).getLong("numFound");
		}
		if( CollectionUtils.isNotEmpty(menuResultList) ){
			menuCnt = menuResultList.get(0).getLong("numFound");
		}
		if( CollectionUtils.isNotEmpty(webpageResultList) ){
			webpageCnt = webpageResultList.get(0).getLong("numFound");
		}
		if( CollectionUtils.isNotEmpty(onlineEduResultList) ){
			onlineEduCnt = onlineEduResultList.get(0).getLong("numFound");
		}
		totalCount = progrmCnt + bbsCnt + filesCnt + menuCnt + webpageCnt + onlineEduCnt;
		model.addAttribute("totalCount", totalCount);


		if( StringUtils.hasText(rangeView) && totalCount > 0 ){
			int total = 0;
			if( "bbs".equals(rangeView) ){
				total = (int)bbsCnt;
			}
			else if( "progrm".equals(rangeView) ){
				total = (int)progrmCnt;
			}
			else if( "files".equals(rangeView) ){
				total = (int)filesCnt;
			}
			else if( "menu".equals(rangeView) ){
				total = (int)menuCnt;
			}
			else if( "webpage".equals(rangeView) ){
				total = (int)webpageCnt;
			}
			else if( "onlineEdu".equals(rangeView) ){
				total = (int)onlineEduCnt;
			}
			StringBuilder link = new StringBuilder();
			link.append("/"+param.getString("siteName")+"/search/list.do");
			link.append("?").append(pageQuery.getPageLinkQueryString(param));
			String pageNav = pageInfo.getPageNavStringToFunc(param.getInt("pageSize", 10), total, param.getInt("pageIndex",1), "paging");
			model.addAttribute("pageNav", pageNav);
			
		}
		
		System.out.println(model);

		//검색어 등록
		String q = param.getString("q");
		if( StringUtils.hasText(q) ){
			param.put("srchwrd", q);
			param.put("frstRegistPnttm", DateUtil.getToday("yyyyMMdd"));
			if( sqlDao.selectCount("popularSrchwrdDAO.selectCnt", param) > 0){
				sqlDao.updateDAO("popularSrchwrdDAO.update", param);
			}
			else{
				sqlDao.insertDAO("popularSrchwrdDAO.insert", param);
			}
		}

		@SuppressWarnings("unchecked")
		List<ZValue> psList =  (List<ZValue>)cacheUtil.load("storedPopSrchwrd", "popularSrchwrdDAO.list");
		if( psList == null ){
			psList = sqlDao.listDAO("popularSrchwrdDAO.list", param);
			cacheUtil.save("storedPopSrchwrd", "popularSrchwrdDAO.list", psList);
		}
		model.addAttribute("psList", psList);
	}

	public void suggest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String q = param.getString("q");
		q = URLDecoder.decode(q, "UTF-8");
		Set<String> resultList = new LinkedHashSet<String>();

		SolrQuery query = new SolrQuery();
	    query.setParam(CommonParams.QT, "/suggest");
		query.setQuery(q);

		String serverUrl = SERVER_URL.endsWith("/") ? SERVER_URL : SERVER_URL + "/";
		for(SOLR_CORE sc : SOLR_CORE.values()){
			HttpSolrServer server = new HttpSolrServer(serverUrl+sc.getValue());
			server.setMaxRetries(1);
			server.setConnectionTimeout(1000);
			QueryResponse rsp;
			try {
				rsp = server.query(query);
				List<Suggestion> suggestions = rsp.getSpellCheckResponse().getSuggestions();
				if( CollectionUtils.isNotEmpty(suggestions) ){
					for(Suggestion s : suggestions){
						resultList.addAll(s.getAlternatives());
					}
				}
			} catch (SolrServerException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		model.addAttribute("resultList", resultList);
	}

	private SolrQuery makeQuery(ZValue param){
		String q = param.getString("q");
		String s = param.getString("s");
		String re = param.getString("re");
		//List<String> categories = param.getList("category");
		String sdate = param.getString("sdate");
		String edate = param.getString("edate");
		int pageIndex = param.getInt("pageIndex", 1);
		int start = (pageIndex -1) * 10;
		SolrQuery query = new SolrQuery();
		query.setStart(start);
		StringBuilder _q = new StringBuilder();
		if( "Y".equals(re) ){
			String prevQ = param.getString("prevQ");
			if( StringUtils.hasText(q) && StringUtils.hasText(prevQ) ){
				_q.append(q).append(" AND ").append(prevQ);
			}
			else if( StringUtils.hasText(prevQ) ){
				_q.append(prevQ);
			}
			else if( StringUtils.hasText(q) ){
				_q.append(q);
			}
			else{
				_q.append("*:*");
			}
		}
		else{
			if( !StringUtils.hasText(q) ){
				_q.append("*:*");
			}
			else{
				_q.append(q);
			}
		}
		if( !"*:*".equals(_q.toString()) ){
			_q.append("*");
		}
		/*if( CollectionUtils.isNotEmpty(categories) ){
			boolean categoryAll = categories.contains("all");
			if( !categoryAll ){
				StringBuilder fq = new StringBuilder();
				fq.append("category:(").append(StringUtils.collectionToDelimitedString(categories, " OR ")).append(")");
				query.setParam("fq", fq.toString());
				param.put("categories", StringUtils.collectionToDelimitedString(categories, ","));
			}
		}*/
		if( SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName")) ){
			query.addFilterQuery("siteNm:"+SiteMngService.EDU_SITE_NAME);
		}
		else {
			query.addFilterQuery("siteNm:"+SiteMngService.CKL_SITE_NAME);
		}

		if (StringUtils.hasText(param.getString("progrsSttus"))) query.addFilterQuery("progrsSttus:"+param.getString("progrsSttus"));
		if (StringUtils.hasText(param.getString("prgSe"))) query.addFilterQuery("prgSe:"+param.getString("prgSe"));
		if (StringUtils.hasText(param.getString("prgCl"))) query.addFilterQuery("prgCl:"+param.getString("prgCl"));
		if (StringUtils.hasText(param.getString("beginDt")) && StringUtils.hasText(param.getString("endDt"))) query.addFilterQuery("beginDt:["+param.getString("beginDt")+" TO "+param.getString("endDt")+"]");
		if (StringUtils.hasText(param.getString("beginDt")) && StringUtils.hasText(param.getString("endDt"))) query.addFilterQuery("endDt:["+param.getString("beginDt")+" TO "+param.getString("endDt")+"]");
		if (StringUtils.hasText(param.getString("gubunSe"))) query.addFilterQuery("gubunSe:"+param.getString("gubunSe"));
		if (StringUtils.hasText(param.getString("gubun"))) query.addFilterQuery("gubun:"+param.getString("gubun"));
		if (StringUtils.hasText(param.getString("category01"))) query.addFilterQuery("category:"+param.getString("category01"));
		if (StringUtils.hasText(param.getString("category02"))) query.addFilterQuery("category:"+param.getString("category02"));
		if (StringUtils.hasText(sdate) && StringUtils.hasText(edate)) query.addFilterQuery("regDate:["+sdate+" TO "+edate+"]");

		query.setQuery(_q.toString());
		query.setHighlight(true).setHighlightSnippets(1);
		query.setParam("hl.fl", param.getString("hl.fl", "text"));
		if( StringUtils.hasText(s) ){
			query.addSort(s, SolrQuery.ORDER.desc);
		}
		return query;
	}

	private List<ZValue> getResultList(SOLR_CORE core, List<String> fieldList, ZValue param){
		List<ZValue> resultList = new ArrayList<ZValue>();

		String serverUrl = SERVER_URL.endsWith("/") ? SERVER_URL : SERVER_URL + "/";
		HttpSolrServer server = new HttpSolrServer(serverUrl+core.getValue());
		server.setMaxRetries(1);
		server.setConnectionTimeout(1000);
		SolrQuery query = makeQuery(param);
		try {
			QueryResponse rsp = server.query(query);
			Iterator<SolrDocument> iter = rsp.getResults().iterator();
			long numFound = rsp.getResults().getNumFound();
			while (iter.hasNext()) {
				ZValue resultMap = new ZValue();
				SolrDocument resultDoc = iter.next();
				for(String field : fieldList){
					resultMap.put(field, resultDoc.getFieldValue(field));
				}
				Object id = resultDoc.getFieldValue("id");
				Map<String, Map<String, List<String>>> highlighting = rsp.getHighlighting();
				if( highlighting.get(id.toString()) != null ){
					Map<String, List<String>> highlightSnippetMap = highlighting.get(id);
					List<String> highlightSnippets = highlightSnippetMap.get(param.getString("hl.fl", "text"));
					if( CollectionUtils.isNotEmpty(highlightSnippets) ){
						resultMap.put("hl", highlightSnippets.get(0));
					}
				}
				resultMap.put("numFound", numFound);
				resultList.add(resultMap);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultList;
	}

	public List<String> getBbsFieldList() {
		return bbsFieldList;
	}

	public void setBbsFieldList(List<String> bbsFieldList) {
		this.bbsFieldList = bbsFieldList;
	}

	public List<String> getProgrmFieldList() {
		return progrmFieldList;
	}

	public void setProgrmFieldList(List<String> progrmFieldList) {
		this.progrmFieldList = progrmFieldList;
	}

	public List<String> getFilesFieldList() {
		return filesFieldList;
	}

	public void setFilesFieldList(List<String> filesFieldList) {
		this.filesFieldList = filesFieldList;
	}

	public List<String> getMenuFieldList() {
		return menuFieldList;
	}

	public void setMenuFieldList(List<String> menuFieldList) {
		this.menuFieldList = menuFieldList;
	}

	public List<String> getWebpageFieldList() {
		return webpageFieldList;
	}

	public void setWebpageFieldList(List<String> webpageFieldList) {
		this.webpageFieldList = webpageFieldList;
	}

	public List<String> getOnlineEduFieldList() {
		return onlineEduFieldList;
	}

	public void setOnlineEduFieldList(List<String> onlineEduFieldList) {
		this.onlineEduFieldList = onlineEduFieldList;
	}

}
