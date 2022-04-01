package kr.co.unp.cmm.crud.mvr;

import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.DefaultRequestToViewNameTranslator;
import org.springframework.web.util.UrlPathHelper;
import org.springframework.web.util.WebUtils;

import egovframework.com.utl.HttpUtil;
/**
 * Request 요청에의해 ModelAndView를 찾기위한 클래스
 * 다음순서로 해당 뷰를 찾음
 * 1. RequestURI의 확장자가 xml, json, rss, xls인경우에는 스프링의 ContentNegotiatingViewResolver가 처리한다.
 * 2. Model에 GO_URL값이 있는경우 해당 GO_URL로 얼랏메세지가 있는경우 얼랏메세지와 함께 포워딩한다.
 * 3. Model에 INCLUDE_PAGE값이 있는경우 해당 INCLUDE_PAGE로 템플릿페이지에 인클루드한다.
 * 4. 사용자 정의 RequestURI매칭 jsp뷰가 정의되어있는 includePageMap이 없는경우
 *    관리자일경우 /bos/siteMng/list.do -> bos/siteMng/list
 *                 /bos/siteMng/forInsert.do, forUpdate.do -> bos/siteMng/reg
 *    사용자일경우 /portal/siteMng/list.do -> /portal/siteMng/list.jsp
 *                 /portal/siteMng/forInsert.do, forUpdate.do -> /protal/siteMng/reg.jsp
 * 5. 사용자 정의 RequestURI매칭 jsp뷰가 정의되어있는 includePageMap이 있는경우 .jsp포함이면 템플릿페이지에 인클루드한다.
 *    .jsp를 포함하지 않으면 해당 jsp뷰로 리턴
 * 6. 파라미터 viewType=BODY이면 header, footer, left를 제외한 BODY뷰를 리턴
 * @author KHD
 *
 * @param <T>
 */
public class UriModelAndViewResolver<T> implements ModelAndViewResolver<T> {

	Logger log = Logger.getLogger(this.getClass());

	//private final DefaultRequestToViewNameTranslator bosRequestToViewNameTranslator = new DefaultRequestToViewNameTranslator();
	private final DefaultRequestToViewNameTranslator userRequestToViewNameTranslator = new DefaultRequestToViewNameTranslator();

    /*
     * 스프링 ContentNegotiatingViewResolver가 처리하기 위해 빈뷰값을 리턴
     * 스프링은 뷰이름이 스트링형태가 아니고 구체적인 뷰형태일경우 ContentNegotiatingViewResolver가 각 확장자별로 뷰를 찾지않는다.
     * 그래서 xml, json, rss, xls형태의 확장자는 빈문자열 스트링인 EMPTY_VIEW를 리턴
     */
	public static final ModelAndView EMPTY_VIEW = new ModelAndView("");
	/*
	 * 스프링 ContentNegotiatingViewResolver가 처리할 확장자
	 */
	private final String[] IGNORED_EXTENTION = {"xml", "json", "xls", "rss"};
	private final UrlPathHelper urlPathHelper = new UrlPathHelper();
	private final AntPathMatcher matcher = new AntPathMatcher();
	private Map<String, String> includePageMap;

	public UriModelAndViewResolver(){
		userRequestToViewNameTranslator.setPrefix("/");
		userRequestToViewNameTranslator.setSuffix(".jsp");
	}

	public Map<String, String> getIncludePageMap() {
		return includePageMap;
	}

	public void setIncludePageMap(Map<String, String> includePageMap) {
		this.includePageMap = includePageMap;
	}

	@Override
	public ModelAndView getModelAndView(ParameterContext<T> paramCtx) throws Exception
	{
		HttpServletRequest request = paramCtx.getRequest();
		ModelMap model = paramCtx.getModel();
		String path = urlPathHelper.getLookupPathForRequest(request);
		String filename = WebUtils.extractFullFilenameFromUrlPath(path);
		String extension = StringUtils.getFilenameExtension(filename);
		extension = (StringUtils.hasText(extension)) ? extension.toLowerCase(Locale.ENGLISH) : null;
		//확장자가 xml, json, rss, xls인경우 스프링 ContentNegotiatingViewResolver에 의해 xml, json뷰를 찾음
		if( ArrayUtils.contains(IGNORED_EXTENTION, extension) ){
			return EMPTY_VIEW;
		}

		ModelAndView mv = null;
		String windowMode = (String)model.get(WINDOW_MODE);
		if( STREAM_WINDOW_MODE.equals(windowMode) ) {
			return null;
		}

		String goUrl = (String)model.get(GO_URL_KEY);
		//모델에 GO_URL_KEY값이 있는경우 얼랏메세지와함꼐 해당 URL로 포워딩
		if( goUrl != null || WIN_CLOSE_WINDOW_MODE.equals(windowMode) || WIN_CLOSE_RELOAD_WINDOW_MODE.equals(windowMode) ){
			log.debug("goUrl : " + goUrl);
			return getMessageModelAndView(paramCtx);
		}

		//사용자정의 포워딩 URL이 있는경우 얼랏메세지와 함께  해당 URL로 포워딩
		//ex) 게시판 등록, 수정, 삭제후 리스트 페이지로 포워딩 할 경우
		goUrl = determineTargetUri(paramCtx);
		if( goUrl != null )
		{
			log.debug("determineTargetUri goUrl : " + goUrl);
			model.addAttribute(GO_URL_KEY, goUrl);
			return getMessageModelAndView(paramCtx);
		}

		String siteName = getSiteName(paramCtx);
		String includePage = (String)model.get(INCLUDE_PAGE);
		if ( includePage != null ){
			if( "BODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(getBodyTemplatePage(siteName));
			}
			else if( "PORTALBODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(getBodyTemplatePage(SiteMngService.CKL_SITE_NAME));
			}
			else if( "CONTBODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(includePage.replaceAll(".jsp", ""));
			}
			else{
				mv = new ModelAndView(getTemplatePage(siteName));
			}
			return mv;
		}

		includePage = getIncludePage(paramCtx);
		//사용자 정의 RequestURI매칭 jsp뷰가 정의되어있는 includePageMap이 없는경우
		if( includePage == null ) {
			//기본 페이지뷰
			//ex) /portal/siteMng/list.do -> /portal/siteMng/list.jsp
			String viewName = userRequestToViewNameTranslator.getViewName(request);
			model.addAttribute(INCLUDE_PAGE, translateViewName(viewName));
			log.debug(INCLUDE_PAGE + " : " + translateViewName(viewName));
			if( "BODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(getBodyTemplatePage(siteName));
			}
			else if( "PORTALBODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(getBodyTemplatePage(SiteMngService.CKL_SITE_NAME));
			}
			else if( "CONTBODY".equals(request.getParameter("viewType")) ){
				includePage = (String)model.get(INCLUDE_PAGE);
				mv = new ModelAndView(includePage.replaceAll(".jsp", ""));
			}
			else{
				mv = new ModelAndView(getTemplatePage(siteName));
			}
		}
		//.jsp를 포함
		else if( isIncludePath(includePage) ){
			//viewType값이 BODY이면 헤더,푸터,레프트를 제외한 바디뷰리턴
			if( "BODY".equals(request.getParameter("viewType")) ){
				model.addAttribute(INCLUDE_PAGE, includePage);
				mv = new ModelAndView(getBodyTemplatePage(siteName));
			}
			else if( "PORTALBODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(getBodyTemplatePage(SiteMngService.CKL_SITE_NAME));
			}
			else if( "CONTBODY".equals(request.getParameter("viewType")) ){
				mv = new ModelAndView(includePage.replaceAll(".jsp", ""));
			}
			else{
				model.addAttribute(INCLUDE_PAGE, includePage);
				mv = new ModelAndView(getTemplatePage(siteName));
			}
			log.debug(INCLUDE_PAGE + " : " + includePage);
		}
		else{
			mv = new ModelAndView(includePage);
		}
		return mv;
	}

	protected String translateViewName(String viewName){
		viewName = StringUtils.replace(viewName, "forInsert", "reg");
		viewName = StringUtils.replace(viewName, "forUpdate", "reg");
		return viewName;

	}

	protected ModelAndView getMessageModelAndView(ParameterContext<T> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
		HttpServletResponse response = paramCtx.getResponse();
		String goUrl = (String)model.get(GO_URL_KEY);
		String msg = (String)model.get(MSG_KEY);
		String windowMode = (String)model.get(WINDOW_MODE);
		if( CONFIRM_URL_WINDOW_MODE.equals(windowMode) ){
			String confirmMsg = (String)model.get(CONFIRM_MSG_KEY);
			HttpUtil.goConfirmUrl(response, goUrl, confirmMsg);
		}
		else if( WIN_CLOSE_WINDOW_MODE.equals(windowMode) ){
			HttpUtil.winClose(response, msg);
		}
		else if( WIN_CLOSE_RELOAD_WINDOW_MODE.equals(windowMode) ){
			HttpUtil.winCloseReload(response, msg);
		}
		else if( WIN_CLOSE_LOCATION_WINDOW_MODE.equals(windowMode) ){
			HttpUtil.winCloseLocation(response, goUrl, msg);;
		}
		else{
			@SuppressWarnings("unchecked")
			Map<String, String> hiddenInput = (Map<String, String>)model.get(HIDDEN_INPUT_KEY);
			if( MapUtils.isNotEmpty(hiddenInput) ){
		    	HttpUtil.goUrl(response, goUrl, hiddenInput, msg);
			}
			else{
				HttpUtil.goUrl(response, goUrl, msg);
			}
		}
    	return null;
	}

	protected String getTemplatePage(String siteName){
		return new StringBuilder().append(siteName).append("/main/").append(siteName).append("Index").toString();
	}

	protected String getBodyTemplatePage(String siteName){
		String result = new StringBuilder().append(siteName).append("/main/").append(siteName).append("BodyIndex").toString();
		System.out.println(">>>" + result);
		return result;
	}

	public String getIncludePage(ParameterContext<T> paramCtx) throws Exception
	{
		if( MapUtils.isEmpty(includePageMap) ){
			return null;
		}

		HttpServletRequest request = paramCtx.getRequest();
		String requestUri = request.getRequestURI();
		String siteName = getSiteName(paramCtx);
		String includePage = null;
        Iterator<String> iterator = includePageMap.keySet().iterator();
		while(iterator.hasNext()){
			String path = iterator.next();
			if( matcher.match(path, requestUri) ){
				includePage = includePageMap.get(path);
				if( includePage != null ) {
					includePage = StrUtils.replace(includePage, "[siteName]", siteName);
					includePage = setAdditionalOperation(includePage, paramCtx);
				}
				break;
			}
		}
		return includePage;
	}

	/**
	 * 게시글 등록,수정,삭제후 포워딩할 URL을 결정한다.
	 * 디폴트 포워딩 URL은 리스트페이지이고 수정,등록시 에러발생할 경우 history.back()호출
	 * ex) /bos/siteMng/reg.do -> /bos/siteMng/list.do
	 * @param paramCtx - 파라미터컨텍스트
	 * @return 포워딩할 URL
	 * @throws Exception
	 */
	protected String determineTargetUri(ParameterContext<T> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ){
    		return null;
    	}
		StringBuilder defaultUrl = new StringBuilder();
    	if( ERROR.equals(resultCode) ){
    		defaultUrl.append("javascript:history.back();");
    	}
    	else{
    		HttpServletRequest request = paramCtx.getRequest();
    		String pageQueryString = request.getParameter(CmmProgramService.PAGE_QUERY_STRING);
    		String requestUri = urlPathHelper.getRequestUri(request);
    		int index = requestUri.lastIndexOf('/');
    		defaultUrl.append(requestUri.substring(0, index)).append("/list.do");
    		if( StringUtils.hasText(pageQueryString) ){
        		defaultUrl.append("?").append(pageQueryString);
    		}
    		else {
    			defaultUrl.append("?menuNo=").append(request.getParameter("menuNo"));
    		}
    	}
    	return defaultUrl.toString();
	}

	protected boolean isIncludePath(String includePage){
		if( includePage == null ) return false;
		return includePage.indexOf(".jsp") != -1;
	}

	protected String setAdditionalOperation(String includePage, ParameterContext<T> paramCtx){
		return includePage;
	}

	private String getSiteName(ParameterContext<T> paramCtx){
		T param = paramCtx.getParam();
		String siteName = null;
		if( param instanceof SearchVO ){
			siteName = ((SearchVO)param).getSiteName();
		}
		else if( param instanceof ZValue ){
			siteName = ((ZValue)param).getString("siteName");
		}
		return siteName;
	}
}
