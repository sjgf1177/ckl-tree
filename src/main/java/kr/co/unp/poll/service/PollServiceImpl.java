package kr.co.unp.poll.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.handler.DefaultListHander;
import kr.co.unp.cmm.crud.paging.DefaultPageQuery;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.vo.QueryIdVO;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.poll.dao.PollDAO;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("pollService")
public class PollServiceImpl {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="pollDAO")
	private PollDAO dao;

    @Resource(name = "EgovFileMngUtil")
    protected EgovFileMngUtil fileUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name = "fnwFileMngService")
	protected FnwFileMngService fileService;

    @Resource(name = "egovPollUserCdGnrService")
    protected EgovIdGnrService idgenService;
    
    @Resource(name = "defaultListHander")
    protected DefaultListHander defaultListHander;

	public void selectMasterList(ZValue zvl, ModelMap model) {

		int pageUnit = zvl.getInt("pageUnit") == 0 ? propertyService.getInt("pageUnit") : zvl.getInt("pageUnit");
    	int pageSize = propertyService.getInt("pageSize");
    	int pageIndex = zvl.getInt("pageIndex", 1);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);

    	zvl.put("pageIndex", pageIndex);
    	zvl.put("pageUnit", pageUnit);
    	zvl.put("pageSize", pageSize);
    	zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
    	zvl.put("lastIndex", paginationInfo.getLastRecordIndex());
    	zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		int totCnt = 0;
		List<ZValue> resultList = dao.selectMasterList(zvl);
		if( CollectionUtils.isNotEmpty(resultList) ){
			totCnt = resultList.get(0).getInt("totalRows");
		}

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("zvl", zvl);

	}

	public HashMap<String, Object> selectAllMasterList(ZValue zvl) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<ZValue> ongoingResultList = dao.selectOngoingMasterList(zvl);

		List<ZValue> finishedResultList = dao.selectFinishedMasterList(zvl);
		int finishedCnt = dao.selectFinishedMasterListCnt(zvl);

		resultMap.put("ongoingResultList", ongoingResultList);
		resultMap.put("finishedResultList", finishedResultList);
		resultMap.put("finishedCnt", finishedCnt);

		return resultMap;
	}

	public void selectMasterDescList(ParameterContext<ZValue> paramCtx) throws Exception {
		if( paramCtx.getQueryIdVO() == null ){
			QueryIdVO qvo = new QueryIdVO();
			qvo.setListQueryId("pollDAO.selectMasterList");
			qvo.setCountQueryId("pollDAO.selectMasterListCnt");
			paramCtx.setQueryIdVO(qvo);
		}
		if( paramCtx.getPageQuery() == null ){
			paramCtx.setPageQuery(new DefaultPageQuery());
		}
		if( paramCtx.getPageInfo() == null ){
			paramCtx.setPageInfo(new PageInfo());
		}
		defaultListHander.invoke(paramCtx);
	}

	public void selectCheckformList2(ParameterContext<ZValue> paramCtx) throws Exception {
		if( paramCtx.getQueryIdVO() == null ){
			QueryIdVO qvo = new QueryIdVO();
			qvo.setListQueryId("pollDAO.selectMasterList");
			qvo.setCountQueryId("pollDAO.selectMasterListCnt");
			paramCtx.setQueryIdVO(qvo);
		}
		if( paramCtx.getPageQuery() == null ){
			paramCtx.setPageQuery(new DefaultPageQuery());
		}
		if( paramCtx.getPageInfo() == null ){
			paramCtx.setPageInfo(new PageInfo());
		}
		defaultListHander.invoke(paramCtx);
	}
	
	public List<ZValue> selectCheckformList(ModelMap model) throws Exception {
		
		List<ZValue> resultMany = dao.selectCheckformList();
		model.addAttribute("resultList", resultMany);
		Map<String, List<FileVO>> fileMap = defaultListHander.getFileMap(null, resultMany);
		model.addAttribute("fileMap", fileMap);
		
		return resultMany;
	}

	public void insertCheckform(ZValue zvl, ModelMap model) throws Exception
	{
		dao.insertCheckform(zvl);
	}

	public List<ZValue> selectCheckformList(ZValue zvl, ModelMap model) {
		List<ZValue> resultMany = null;
		resultMany = dao.selectCheckformList();

		if(resultMany != null) {
			model.addAttribute("resultList", resultMany);
		}
		return resultMany;
	}

	public ZValue selectCheckform(ZValue zvl, ModelMap model) {
		// 쿼리 수행
		ZValue result = dao.selectCheckform(zvl);
		model.addAttribute("result", result);

		return result;
	}

	public ZValue forUpdateCheckform(ZValue zvl, ModelMap model) throws Exception {
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("user", user);
		ZValue result = dao.selectCheckform(zvl);
		if(result != null) {
			model.addAttribute("result", result);

			String atchFileId = result.getString("atchFileId");
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			List<FileVO> fileList = fileService.selectFileInfs(fileVO);

			model.addAttribute("fileList", fileList);
			model.addAttribute("updateFlag", "Y");
			model.addAttribute("fileListCnt", result.size());
		}
		return result;
	}

	public void updateCheckform(ZValue zvl, ModelMap model) throws Exception
	{
		dao.updateCheckform(zvl);
	}

	public List<ZValue> selectQuestionList(ZValue zvl, ModelMap model)
	{
		ZValue checkformInfo = dao.selectCheckform(zvl);
		List<ZValue> resultMany = dao.selectQuestionList(zvl);
		List<ZValue> resultManyAnswerStatistics = null;
		for (ZValue question : resultMany) {
			zvl.put("questionCd", question.getString("questionCd"));			// 임시 결과 (답변 통계 리스트)
			resultManyAnswerStatistics = dao.selectAnswerStatisticsList(zvl); 	// 임시 결과 (답변 통계 불러오기)
			question.put("answer", resultManyAnswerStatistics);
			if( !"".equals(question.getString("question")) )
			{
				question.put("question", question.getString("question").replace("\n", "<br/>"));
			}
		}


		// 결과
		if(resultMany != null) {
			String contents = checkformInfo.getString("contents");
			if(contents != null) {
				checkformInfo.put("contents", contents.replace("\n", "<br/>"));
			}
			model.addAttribute("checkformInfo", checkformInfo);
			model.addAttribute("resultList", resultMany);
		}


		return resultMany;
	}

	/*
	public List<HashMap> selectTestQuestionList(Master bean, ModelMap model) {


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


		// 결과
		Master checkformInfo = new Master();
		List<HashMap> resultMany = new ArrayList<HashMap>();


		int totCnt = 0;

		// 파라메터
		int master_cd = bean.getMaster_cd();
		bean.setYear_cd(POLL_YEAR_CD);

		// 쿼리 수행
		checkformInfo = dao.selectCheckform(master_cd);
		resultMany = dao.selectTestQuestionList(bean);
		List<HashMap> resultManyAnswerStatistics = null;
		for (HashMap question : resultMany) {
			int question_cd = Integer.parseInt(question.get("QUESTION_CD").toString());
			bean.setQuestion_cd(question_cd);
			resultManyAnswerStatistics = new ArrayList<HashMap>();				// 임시 결과 (답변 통계 리스트)
			resultManyAnswerStatistics = dao.selectTestAnswerStatisticsList(bean); 	// 임시 결과 (답변 통계 불러오기)
			question.put("ANSWER", resultManyAnswerStatistics);
			if(question.get("QUESTION") != null) {
				question.put("QUESTION", question.get("QUESTION").toString().replace("\n", "<br/>"));
			}
		}


		// 결과
		if(resultMany != null) {
			String contents = checkformInfo.getContents();
			if(contents != null) {
				checkformInfo.setContents(contents.replace("\n", "<br/>"));
			}
			model.addAttribute("checkformInfo", checkformInfo);
			model.addAttribute("resultList", resultMany);
		}


		return resultMany;
	}
	*/

	public void insertQuestion(ZValue zvl, ModelMap model)
	{

		dao.insertQuestion(zvl);
	}

	public ZValue forUpdateQuestion(ZValue zvl, ModelMap model) {
		/* 질문 정보 가져오기 */
		ZValue result = null;

		// 쿼리 수행
		result = dao.selectQuestion(zvl);

		// 결과
		if(result != null) {
			model.addAttribute("result", result);
		}

		// 쿼리 수행
		ZValue checkformInfo = dao.selectCheckform(zvl);

		// 결과
		String contents = checkformInfo.getString("contents");
		if(contents != null) {
			checkformInfo.put("contents", contents.replace("\n", "<br/>"));
		}
		model.addAttribute("checkformInfo", checkformInfo);


		return result;
	}

	public List<ZValue> selectQuestion2ForUpdate(ZValue zvl, ModelMap model) {
		List<ZValue> result = null;

		// 쿼리 수행
		result = dao.selectQuestion2ForUpdate(zvl);

		// 결과
		model.addAttribute("result", result);

		return result;
	}

	public void updateQuestion2(ZValue zvl, ModelMap model) throws Exception {
		// TODO Auto-generated method stub

		dao.deleteQuestion2(zvl);

		List<String> arrQuestion2Data = zvl.getList("question2");
		List<String> arrOrderbyData = zvl.getList("orderby");

		for(int i=0; i<arrQuestion2Data.size(); i++)
		{
			zvl.put("orderby", arrOrderbyData.get(i));
			zvl.put("question2", arrQuestion2Data.get(i));
			dao.insertQuestion2(zvl);
		}
	}

	public List<ZValue> selectQuestion2ForUpdate2(ZValue zvl, ModelMap model) {
		List<ZValue> resultList = new ArrayList<ZValue>();
		int masterCd = zvl.getInt("masterCd");
		int question1Cd = zvl.getInt("question1Cd");
		String viewState = zvl.getString("viewState");
		if("select".equals(viewState) || "modify".equals(viewState)) {
			resultList = dao.selectQuestion2ForUpdate(zvl);
		} else {
			List<String> arrStatusData = zvl.getList("arrStatus");
			if(arrStatusData != null && arrStatusData.size() > 0)
			{
				List<String> arrQuestion2Data = zvl.getList("arrQuestion2");
				List<String> arrOrderbyData = zvl.getList("arrOrderby");
				List<String> arrQuestion2CdData = zvl.getList("arrQuestion2Cd");
				for(int i=0; i<arrQuestion2Data.size(); i++)
				{
					String validation = "N";
					String status = arrStatusData.get(i);
					int orderby = StrUtils.parseInt(arrOrderbyData.get(i));
					String question2 = arrQuestion2Data.get(i);
					int question2Cd = StrUtils.parseInt(arrQuestion2CdData.get(i));
					String validationOrdr = zvl.getString("validation");

					if(String.valueOf(orderby).equals(validationOrdr))
					{
						validation = "Y";
					}

					if(status.equals("Y") && question2Cd == 0) {
					} else {
						ZValue resultItem = new ZValue();
						resultItem.put("question2Cd", question2Cd);
						resultItem.put("status", status);
						resultItem.put("orderby", orderby);
						resultItem.put("question2", question2);
						resultItem.put("validation", validation);

						resultItem.put("question1Cd", question1Cd);
						resultItem.put("masterCd", masterCd);

						resultList.add(resultItem);
					}
				}
			}


			if("add".equals(viewState))
			{
				ZValue resultItem = new ZValue();
				resultItem.put("question1Cd", question1Cd);
				resultItem.put("masterCd", masterCd);
				resultItem.put("status", "N");
				resultItem.put("validation", "N");

				resultList.add(resultItem);

			} else if("save".equals(viewState)) {
				for (ZValue question2 : resultList)
				{
					if(question2.getInt("question2Cd") == 0)
					{
						dao.insertQuestion2(question2);
					}
					else
					{
						dao.updateQuestion2(question2);
					}
				}
			}

		}

		model.put("resultList", resultList);


		// 쿼리 수행
		ZValue resultQuestion1 = dao.selectQuestion(zvl);
		String question = resultQuestion1.getString("question");
		if( !"".equals(question) )
		{
			resultQuestion1.put("question", question.replace("\n", "<br/>"));
		}

		model.put("resultQuestion1", resultQuestion1);

		// 쿼리 수행
		ZValue checkformInfo = dao.selectCheckform(zvl);

		// 결과
		String contents = checkformInfo.getString("contents");
		if(contents != null) {
			checkformInfo.put("contents", contents.replace("\n", "<br/>"));
		}
		model.addAttribute("checkformInfo", checkformInfo);
		return resultList;
	}

	public void updateQuestion(ZValue zvl, ModelMap model) {
		dao.updateQuestion(zvl);
	}

	public void selectCheckStateView(ZValue zvl, ModelMap model) throws Exception {
		ZValue result = dao.selectMaster(zvl);
		if(result != null) {
			result.put("contents", result.getString("contents").replace("\n", "<br/>"));
			model.addAttribute("result", result);
		}

	}

	public void selectCompanyInfo(ZValue zvl, ModelMap model) throws Exception {

		String prefix = "Q";
		HashMap<String, ArrayList<ZValue>> answerMap = new HashMap<String, ArrayList<ZValue>>();
		ArrayList<ZValue> list = null;
		List<ZValue> questionList = dao.selectQuestionListM(zvl);
		model.addAttribute("questionList", questionList);

		List<ZValue> answerList = dao.selectAnswerListM(zvl);
		for( ZValue z : answerList )
		{
			String key = prefix + z.getString("question1Cd");
			list = answerMap.get(key);
			if( list == null )
			{
				list = new ArrayList<ZValue>();
				list.add( z );
				answerMap.put(key, list);
			}
			else
			{
				list.add( z );
			}
		}
		model.addAttribute("answerMap", answerMap);
	}

	public void check(ZValue zvl, List<ZValue> answerList, ModelMap model) throws Exception {
		int userCd = idgenService.getNextIntegerId();
		zvl.put("userCd", userCd);
		dao.checkQuestion(zvl);
		for (ZValue a2 : answerList) {
			a2.put("userCd", userCd);
			dao.checkQuestion2(a2);
		}
	}

	public void checkUpdate(ZValue zvl, List<ZValue> answerList, ModelMap model) throws Exception {

		dao.deleteAnswer2ForCompanyId(zvl);
		for (ZValue a2 : answerList) {
			dao.checkQuestion2(a2);
		}
	}


	public List<ZValue> selectOtherList(ZValue zvl) throws Exception {
		return dao.selectOtherList(zvl);

	}

	public List<ZValue> selectEssayList(ZValue zvl) throws Exception {
		return dao.selectEssayList(zvl);

	}

	public void updateQuestionForDelete(ZValue zvl, ModelMap model) {
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		bean.setUpdate_id(user.getId());
		dao.updateQuestionForDelete(zvl);
	}

	public int selectTempPollId() throws Exception {
		return dao.selectTempPollId();

	}

	public List<ZValue> selectCheckedList(ZValue zvl, ModelMap model) {
		// 결과
		ZValue checkformInfo = null;
		List<ZValue> resultMany = null;
		int totCnt = 0;

		// 쿼리 수행
		checkformInfo = dao.selectCheckform(zvl);
		resultMany = dao.selectCheckedList(zvl);
		totCnt = dao.selectCheckedListTotCnt(zvl);

		// 결과
		if(resultMany != null) {
			String contents = checkformInfo.getString("contents");
			if(contents != null) {
				checkformInfo.put("contents", contents.replace("\n", "<br/>"));
			}
			model.addAttribute("checkformInfo", checkformInfo);
			model.addAttribute("resultList", resultMany);
			model.addAttribute("resultListSize", totCnt);
		}
		return resultMany;
	}

	public void deleteAnswerForCompanyId(ZValue zvl)
	{
		dao.deleteAnswer2ForCompanyId(zvl);
	}

	public void delete(int masterCd)
	{
		dao.delete(masterCd);
	}

	public ZValue selectRescentPoll() {
		return dao.selectRescentPoll();
	}

	public HashMap<String, List<ZValue>> selectPollExceptSatisfaction() throws Exception {
		HashMap<String, List<ZValue>> map = new HashMap<String, List<ZValue>>();
		List<ZValue> tempList = null;
		List<ZValue> list = dao.selectPollExceptSatisfaction();
		for(ZValue zvl : list)
		{
			String companyId = zvl.getString("companyId");
			tempList = map.get(companyId);
			if(tempList == null)
			{
				tempList = new ArrayList<ZValue>();
				tempList.add(zvl);
			}
			else
			{
				tempList.add(zvl);
			}
			map.put(companyId, tempList);
		}

		return map;
	}

	public List<ZValue> getZvl(ZValue zvl)
	{
		int masterCd = zvl.getInt("masterCd");
		String userCd = zvl.getString("userCd");

		List<ZValue> list = new ArrayList<ZValue>();
		List<String> questionCdData = zvl.getList("questionCd");
		for(String qCd : questionCdData)
		{
			int questionCd = StrUtils.parseInt(qCd);
			String multiCheckYn = zvl.getString("multiCheckYn_"+qCd);
			String questTypeCd = zvl.getString("questTypeCd_"+qCd);
			String other = zvl.getString("other_"+qCd);
			String otherYn = zvl.getString("otherYn_"+qCd);

			if("B".equals(questTypeCd))
			{
				String question2CdObj = zvl.getString("question2Cd_"+qCd);
				int question2Cd = StrUtils.parseInt(question2CdObj);
				ZValue answer = new ZValue();
				answer.put("question2Cd", question2Cd);
				answer.put("questionCd", questionCd);
				answer.put("other", other);
				answer.put("masterCd", masterCd);
				answer.put("userCd", userCd);
				list.add(answer);
			}
			else
			{
				if("Y".equals(multiCheckYn))
				{
					List<String> question2CdData = zvl.getList("question2Cd_"+questionCd);
					for(String q2Cd : question2CdData)
					{
						ZValue answer = new ZValue();
						answer.put("question2Cd", q2Cd);
						answer.put("questionCd", questionCd);
						answer.put("other", other);
						answer.put("masterCd", masterCd);
						answer.put("userCd", userCd);
						list.add(answer);
					}

				}
				else if("N".equals(multiCheckYn))
				{

					int question2Cd = zvl.getInt("question2Cd_"+questionCd);
					ZValue answer = new ZValue();
					answer.put("question2Cd", question2Cd);
					answer.put("questionCd", questionCd);
					answer.put("other", other);
					answer.put("masterCd", masterCd);
					answer.put("userCd", userCd);
					list.add(answer);
				}

				//기타사용하고 체크박스값 체크되어있을경우에만 추가
				if("Y".equals(otherYn))
				{
					int question2Cd = zvl.getInt("question2Cd_"+questionCd);
					if(question2Cd == 9999)
					{
						ZValue answer = new ZValue();
						answer.put("question2Cd", 9999);
						answer.put("questionCd", questionCd);
						answer.put("other", other);
						answer.put("masterCd", masterCd);
						answer.put("userCd", userCd);
						list.add(answer);
					}
				}
			}
		}

		return list;
	}

}
