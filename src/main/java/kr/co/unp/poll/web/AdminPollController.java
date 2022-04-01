package kr.co.unp.poll.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.poll.service.PollServiceImpl;
import kr.co.unp.util.FileMngUtil;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.utl.HttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminPollController {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "pollService")
	private PollServiceImpl service;

	@Resource(name = "fnwFileMngService")
	private FnwFileMngService fnwFileMngService;

	@Resource(name = "fileMngUtil")
	private FileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM");
	
	private String getFilePath(ZValue param) throws Exception{
		String folder = simpleDateFormat.format(new Date());
		StringBuilder result = new StringBuilder();
		result.append(propertyService.getString("Globals.fileStorePath")).append("/");
		result.append("pol");
		result.append("/").append(folder).toString();
		return result.toString();
	}
	
	@RequestMapping("/bos/poll/list.do")
	public String selectCheckformList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue param = WebFactory.getAttributes(request);
		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		paramCtx.setParam(param);
		paramCtx.setRequest(request);
		paramCtx.setResponse(response);
		paramCtx.setModel(model);
		String returnURL = "/bos/poll/list";
		service.selectCheckformList2(paramCtx);
		return returnURL;
	}

	@RequestMapping("/bos/poll/forInsert.do")
	public String forInsertCheckform(ModelMap model) throws Exception {
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("user", user);
		return "/bos/poll/update";
	}

	@RequestMapping("/bos/poll/insert.do")
	public void insertCheckform(MultipartHttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		ZValue zvl = WebFactory.getAttributes(request);
		Map<String, MultipartFile> files = request.getFileMap();
		if( files != null ){
			String filePath = getFilePath(zvl);
			String atchFileId = fnwFileMngService.saveFile(files, null, filePath, zvl);
			if( StringUtils.hasText(atchFileId) ){
				zvl.put("atchFileId", atchFileId);
			}
		}
		service.insertCheckform(zvl, model);
		HttpUtil.goUrl(response, "/bos/poll/list.do", "성공적으로 등록되었습니다.");
	}

	@RequestMapping("/bos/poll/read.do")
	public String selectCheckform(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String returnURL = "/bos/poll/read";

		ZValue zvl = WebFactory.getAttributes(request);
		service.selectCheckform(zvl, model);

		return returnURL;
	}

	@RequestMapping("/bos/poll/forUpdate.do")
	public String forUpdateCheckform(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String returnURL = "/bos/poll/update";
		ZValue zvl = WebFactory.getAttributes(request);
		service.forUpdateCheckform(zvl, model);

		return returnURL;
	}

	@RequestMapping("/bos/poll/update.do")
	public void updateCheckform(MultipartHttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		ZValue zvl = WebFactory.getAttributes(request);
		Map<String, MultipartFile> files = request.getFileMap();
		if( files != null ){
			String atchFileId = zvl.getString("atchFileId");
			String filePath = getFilePath(zvl);
			atchFileId = fnwFileMngService.saveFile(files, atchFileId, filePath, zvl);
			if( StringUtils.hasText(atchFileId) ){
				zvl.put("atchFileId", atchFileId);
			}
		}
		service.updateCheckform(zvl, model);
		HttpUtil.goUrl(response, "/bos/poll/list.do", "성공적으로 수정되었습니다.");
	}

	@RequestMapping("/bos/poll/list_question.do")
	public String selectQuestionList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		ZValue zvl = WebFactory.getAttributes(request);
		// 리스트 조회
		service.selectQuestionList(zvl, model);
		String returnURL = "/bos/poll/list_question";
		return returnURL;
	}

	@RequestMapping("/bos/poll/forInsertQuestion1.do")
	public String forInsertQuestion(ModelMap model) {
		String returnURL = "/bos/poll/insert_question1";
		return returnURL;
	}

	@RequestMapping("/bos/poll/insertQuestion1.do")
	public String insertQuestion(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		ZValue zvl = WebFactory.getAttributes(request);
		service.insertQuestion(zvl, model);

		service.selectQuestionList(zvl, model);

		String returnURL = "/bos/poll/list_question";

		return returnURL;
	}

	@RequestMapping("/bos/poll/forUpdateQuestion1.do")
	public String forUpdateQuestion(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		String returnURL = "/bos/poll/update_question1";


		ZValue zvl = WebFactory.getAttributes(request);
		service.forUpdateQuestion(zvl, model);

		return returnURL;
	}

	@RequestMapping("/bos/poll/updateQuestion1.do")
	public String updateQuestion(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{

		ZValue zvl = WebFactory.getAttributes(request);
		service.updateQuestion(zvl, model);

		service.selectQuestionList(zvl, model);

		String returnURL = "/bos/poll/list_question";

		return returnURL;
	}

	@RequestMapping("/bos/poll/updateQuestion2.do")
	public void updateQuestion2(
			 HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);

		service.updateQuestion2(zvl, model);

		String forwardUrl =
			"/bos/poll/selectQuestion2ForUpdate.do" +
			"?viewState=select&masterCd="+zvl.getString("masterCd")+
			"&questionCd="+zvl.getString("questionCd")+
			"&question1Cd="+zvl.getString("question1Cd");
		HttpUtil.goUrl(response, forwardUrl, "성공적으로 저장되었습니다.");
	}

	@RequestMapping("/bos/poll/selectQuestion2ForUpdate.do")
	public String selectQuestion2(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		String returnURL = "/bos/poll/update_question2";
		ZValue zvl = WebFactory.getAttributes(request);
		service.selectQuestion2ForUpdate2(zvl, model);
		if("save".equals(zvl.getString("viewState"))) {
			zvl.put("viewState", "select");
			service.selectQuestion2ForUpdate2(zvl, model);
		}
		return returnURL;
	}

	@RequestMapping("/bos/poll/delete.do")
	public void delete(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{


		ZValue zvl = WebFactory.getAttributes(request);
		service.delete(zvl.getInt("masterCd"));

		String returnURL = "/bos/poll/list.do";

		HttpUtil.goUrl(response, returnURL, "성공적으로 삭제되었습니다.");
	}

	@RequestMapping("/bos/poll/deleteQuestion1.do")
	public String deleteQuestion(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{


		ZValue zvl = WebFactory.getAttributes(request);
		service.updateQuestionForDelete(zvl, model);


		service.selectQuestionList(zvl, model);

		String returnURL = "/bos/poll/list_question";


		return returnURL;
	}
/*
	@RequestMapping("/bos/poll/checkedList.do")
	public String checked_company_list(
			 HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) {

		ZValue zvl = WebFactory.getAttributes(request);

		// 페이징 처리 (1)
		bean.setPageUnit(10);
		bean.setPageSize(10);

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(bean.getPageIndex());
		paginationInfo.setRecordCountPerPage(bean.getPageUnit());
		paginationInfo.setPageSize(bean.getPageSize());

		bean.setFirstIndex(paginationInfo.getFirstRecordIndex());
		bean.setLastIndex(paginationInfo.getLastRecordIndex());
		bean.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		// 리스트 조회
		service.selectCheckedList(zvl, model);

		// 페이징 처리 (2)
		String returnURL = "/bos/poll/checkedList";

		String url = "/bos/poll/checkedList.do";
		url += "?master_cd="+bean.getMaster_cd();
		url += "&year_cd="+bean.getYear_cd();


		String pagination = PageUtil.getSgPageNavString(bean.getPageSize()
				, (Integer)model.get("resultListSize")
				, bean.getPageIndex(), url);

		model.addAttribute("pagingInfoString", pagination);


		return returnURL;
	}
*/

	@RequestMapping("/bos/poll/checkedList/delete.do")
	public void list_checked_company_delete (HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		ZValue zvl = WebFactory.getAttributes(request);
		service.deleteAnswerForCompanyId(zvl);

		String url = "/bos/poll/checkedList.do";
		url += "?master_cd="+zvl.getString("masterCd");
		HttpUtil.goUrl(response, url, "성공적으로 삭제되었습니다.");
	}

}
