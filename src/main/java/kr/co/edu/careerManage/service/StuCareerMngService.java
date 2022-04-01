package kr.co.edu.careerManage.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.ui.ModelMap;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import kr.co.edu.careerManage.paging.StuCareerMngPageQuery;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.util.StringUtil;
import kr.co.unp.util.ZValue;
import net.sf.json.JSONArray;

public class StuCareerMngService extends DefaultCmmProgramService{
	Logger log = Logger.getLogger(this.getClass());
	
	public StuCareerMngService (){
		
	}
	
	/**
	 * 경력관리 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new StuCareerMngPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		List<String> interFieldList = Arrays.asList(param.getString("interField").split(","));
		param.put("interFieldList", interFieldList);
		
		if ("edu".equals(param.getString("siteName")) || "edueng".equals(param.getString("siteName"))) param.put("pageUnit", 9);

		super.setCountQueryId("CareerManageDAO.listStuCnt");
		super.setListQueryId("CareerManageDAO.listStu");
		super.list(paramCtx);
		
		List<ZValue> eduList = sqlDao.listDAO("CareerManageDAO.listEduMng", param);
		model.addAttribute("eduList", eduList);
		
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);
		
	}
	
	/**
	 * 경력관리 수료생 상세보기
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new StuCareerMngPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		super.setViewQueryId("CareerManageDAO.viewStu");
		super.view(paramCtx);
	}
	
	/**
	 * 경력관리 수료생 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new StuCareerMngPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		super.setUpdateQueryId("CareerManageDAO.updateStu");
		super.update(paramCtx);
	}
	
	/**
	 * 경력관리 수료생 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new StuCareerMngPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		super.setInsertQueryId("CareerManageDAO.insertStu");
		super.insert(paramCtx);
	}
	
	/**
	 * 경력관리 수료생 참여사업/학력 등록화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinEduView(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		ZValue stuInfo = sqlDao.selectDAO("CareerManageDAO.viewStu", param);
		model.addAttribute("stuInfo", stuInfo);
		
		List<ZValue> schoolList = sqlDao.listDAO("CareerManageDAO.schoolList", param);
		model.addAttribute("schoolList", schoolList);
		
		List<ZValue> joinEduList = sqlDao.listDAO("CareerManageDAO.joinEduList", param);
		model.addAttribute("joinEduList", joinEduList);
		
		param.put("useAt", "Y");
		List<ZValue> eduList = sqlDao.listDAO("CareerManageDAO.listEduMng", param);
		model.addAttribute("eduList", eduList);
	}
	
	/**
	 * 경력관리 수료생 학력 사용여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void changeSchoolUseAt(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.changeSchoolUseYn", param);
	}
	
	/**
	 * 경력관리 수료생 학력 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void schUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		List<Map<String, Object>> schoolDataList = JSONArray.fromObject(param.getString("schoolDataList"));
		
		for(Map<String, Object> m : schoolDataList) {
			ZValue pParam = new ZValue();
			if("old".equals(m.get("data"))) {
				pParam.put("schSn", m.get("schSn"));
				ZValue oldSchInfo = sqlDao.selectDAO("CareerManageDAO.viewSchool", pParam);
				
				boolean compare = false;
				if(oldSchInfo.getString("schGubun").equals(m.get("schGubun")) && 
						oldSchInfo.getString("schNm").equals(m.get("schNm")) &&
						oldSchInfo.getString("major").equals(m.get("major")) &&
						oldSchInfo.getString("graduatedYn").equals(m.get("graduatedYn")) &&
						oldSchInfo.getString("graduatedYear").equals(m.get("graduatedYear")) &&
						oldSchInfo.getString("qualificationExam").equals(m.get("qualificationExam")) &&
						oldSchInfo.getString("transferYn").equals(m.get("transferYn")) &&
						oldSchInfo.getString("majorField").equals(m.get("majorField"))) {
					compare = true;
				} else {
					compare = false;
				}
				
				if(!compare) {
					pParam.put("stuSn", m.get("stuSn"));
					pParam.put("schGubun", m.get("schGubun"));
					pParam.put("schNm", m.get("schNm"));
					pParam.put("major", m.get("major"));
					pParam.put("graduatedYn", m.get("graduatedYn"));
					pParam.put("graduatedYear", m.get("graduatedYear"));
					pParam.put("qualificationExam", m.get("qualificationExam"));
					pParam.put("transferYn", m.get("transferYn"));
					pParam.put("majorField", m.get("majorField"));
					
					sqlDao.updateDAO("CareerManageDAO.updateSchool", pParam);
				}
			} else {
				pParam.put("stuSn", m.get("stuSn"));
				pParam.put("schGubun", m.get("schGubun"));
				pParam.put("schNm", m.get("schNm"));
				pParam.put("major", m.get("major"));
				pParam.put("graduatedYn", m.get("graduatedYn"));
				pParam.put("graduatedYear", m.get("graduatedYear"));
				pParam.put("qualificationExam", m.get("qualificationExam"));
				pParam.put("transferYn", m.get("transferYn"));
				pParam.put("majorField", m.get("majorField"));
				
				sqlDao.insertDAO("CareerManageDAO.insertSchool", pParam);
			}
		}
		
	}
	
	/**
	 * 경력관리 수료생 참여사업 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinEduUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		List<Map<String, Object>> joinEduDataList = JSONArray.fromObject(param.getString("joinEduDataList"));
		
		for(Map<String, Object> m : joinEduDataList) {
			ZValue pParam = new ZValue();
			if("old".equals(m.get("data"))) {
				pParam.put("joinSn", m.get("joinSn"));
				ZValue oldJoinEduInfo = sqlDao.selectDAO("CareerManageDAO.viewJoinEdu", pParam);
				
				boolean compare = false;
				if(oldJoinEduInfo.getString("eduSn").equals(m.get("eduSn")) && 
						oldJoinEduInfo.getString("stuSn").equals(m.get("stuSn")) &&
						oldJoinEduInfo.getString("year").equals(m.get("year")) &&
						oldJoinEduInfo.getString("joineduDtl").equals(m.get("joineduDtl"))) {
					compare = true;
				} else {
					compare = false;
				}
				
				if(!compare) {
					pParam.put("eduSn", m.get("eduSn"));
					pParam.put("year", m.get("year"));
					pParam.put("graduateYn",  m.get("graduateYn"));
					pParam.put("joineduDtl", m.get("joineduDtl"));
					
					sqlDao.updateDAO("CareerManageDAO.updateJoinEdu", pParam);
				}
			} else {
				pParam.put("eduSn", m.get("eduSn"));
				pParam.put("stuSn", m.get("stuSn"));
				pParam.put("year", m.get("year"));
				pParam.put("graduateYn", m.get("graduateYn"));
				pParam.put("joineduDtl", m.get("joineduDtl"));
				
				sqlDao.insertDAO("CareerManageDAO.insertJoinEdu", pParam);
			}
		}
		
	}
	
	public void schDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.deleteSch", param);
		
	}
	
	public void joinEduDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.deleteJoinEdu", param);
		
	}
	
	public void careerView(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		ZValue stuInfo = sqlDao.selectDAO("CareerManageDAO.viewStu", param);
		model.addAttribute("stuInfo", stuInfo);
		
		List<ZValue> careerList = sqlDao.listDAO("CareerManageDAO.careerList", param);
		model.addAttribute("careerList", careerList);
	}
	
	public void changeFieldCareerYn(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.changeFieldCareerYn", param);
	}
	
	public void careerUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		List<Map<String, Object>> careerDataList = JSONArray.fromObject(param.getString("careerDataList"));
		
		for(Map<String, Object> m : careerDataList) {
			ZValue pParam = new ZValue();
			if("old".equals(m.get("data"))) {
				pParam.put("careerSn", m.get("careerSn"));
				ZValue oldCareerInfo = sqlDao.selectDAO("CareerManageDAO.viewCareer", pParam);
				
				boolean compare = false;
				if(oldCareerInfo.getString("careerSn").equals(m.get("eduSn")) && 
						oldCareerInfo.getString("stuSn").equals(m.get("stuSn")) &&
						oldCareerInfo.getString("compNm").equals(m.get("compNm")) &&
						oldCareerInfo.getString("joinYear").equals(m.get("joinYear")) &&
						oldCareerInfo.getString("resignYear").equals(m.get("resignYear")) &&
						oldCareerInfo.getString("employmentYn").equals(m.get("employmentYn")) &&
						oldCareerInfo.getString("workerType").equals(m.get("workerType")) &&
						oldCareerInfo.getString("rank").equals(m.get("rank")) 
						) {
					compare = true;
				} else {
					compare = false;
				}
				
				if(!compare) {
					pParam.put("stuSn", m.get("stuSn"));
					pParam.put("compNm", m.get("compNm"));
					pParam.put("joinYear", m.get("joinYear"));
					pParam.put("resignYear", m.get("resignYear"));
					pParam.put("employmentYn", m.get("employmentYn"));
					pParam.put("workerType", m.get("workerType"));
					pParam.put("rank", m.get("rank"));

					sqlDao.updateDAO("CareerManageDAO.updateCareer", pParam);
				}
			} else {
				pParam.put("stuSn", m.get("stuSn"));
				pParam.put("compNm", m.get("compNm"));
				pParam.put("joinYear", m.get("joinYear"));
				pParam.put("resignYear", m.get("resignYear"));
				pParam.put("employmentYn", m.get("employmentYn"));
				pParam.put("workerType", m.get("workerType"));
				pParam.put("rank", m.get("rank"));
				
				sqlDao.insertDAO("CareerManageDAO.insertCareer", pParam);
			}
		}
	}
	
	public void careerDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.deleteCareer", param);
		
	}
	
	public void createView(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		ZValue stuInfo = sqlDao.selectDAO("CareerManageDAO.viewStu", param);
		model.addAttribute("stuInfo", stuInfo);
		
		List<ZValue> createList = sqlDao.listDAO("CareerManageDAO.createList", param);
		model.addAttribute("createList", createList);
	}
	
	public void changeFieldCreate(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.changeFieldCreate", param);
	}
	
	public void createUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		List<Map<String, Object>> createDataList = JSONArray.fromObject(param.getString("createDataList"));
		
		for(Map<String, Object> m : createDataList) {
			ZValue pParam = new ZValue();
			if("old".equals(m.get("data"))) {
				pParam.put("createSn", m.get("createSn"));
				ZValue oldCreateInfo = sqlDao.selectDAO("CareerManageDAO.viewCreate", pParam);
				
				boolean compare = false;
				if(oldCreateInfo.getString("createSn").equals(m.get("createSn")) && 
						oldCreateInfo.getString("stuSn").equals(m.get("stuSn")) &&
						oldCreateInfo.getString("createNm").equals(m.get("createNm")) &&
						oldCreateInfo.getString("createYear").equals(m.get("createYear")) &&
						oldCreateInfo.getString("contractGroup").equals(m.get("contractGroup"))
						) {
					compare = true;
				} else {
					compare = false;
				}
				
				if(!compare) {
					pParam.put("stuSn", m.get("stuSn"));
					pParam.put("createNm", m.get("createNm"));
					pParam.put("createYear", m.get("createYear"));
					pParam.put("contractGroup", m.get("contractGroup"));

					sqlDao.updateDAO("CareerManageDAO.updateCreate", pParam);
				}
			} else {
				pParam.put("stuSn", m.get("stuSn"));
				pParam.put("createNm", m.get("createNm"));
				pParam.put("createYear", m.get("createYear"));
				pParam.put("contractGroup", m.get("contractGroup"));
				
				sqlDao.insertDAO("CareerManageDAO.insertCreate", pParam);
			}
		}
	}
	
	public void createDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		sqlDao.updateDAO("CareerManageDAO.deleteCreate", param);
		
	}
	
	public void excelCareerInsert(ParameterContext<ZValue> paramCtx) throws Exception{
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		String stuSn = "";
		List<Map<String, Object>> excelDataList = JSONArray.fromObject(param.getString("excelDataList"));
		for(Map<String, Object> m : excelDataList) {
			ZValue pParam = new ZValue();
			if("B".equals(m.get("datatype"))) {
				pParam.put("stuNm", m.get("stuNm"));
				pParam.put("gender", m.get("gender"));
				pParam.put("birth", m.get("birth"));
				pParam.put("phone", m.get("phone"));
				pParam.put("email", m.get("email"));
				pParam.put("jobSearchYn", m.get("jobSearchYn"));
				pParam.put("interField", m.get("interField"));
				pParam.put("interJob", m.get("interJob"));
				pParam.put("fldStrDtl", m.get("fldStrDtl"));
				pParam.put("fldEtcDtl", m.get("fldEtcDtl"));
				pParam.put("jobEtcDtl", m.get("jobEtcDtl"));
				pParam.put("schoolUseYn", "Y");
				pParam.put("fieldCareerYn", m.get("fieldCareerYn"));
				pParam.put("fieldCreateYn", m.get("fieldCreateYn"));
				pParam.put("fieldCreatePeriod", m.get("fieldCreatePeriod"));
				
				ZValue stuDuplCheck = sqlDao.selectDAO("CareerManageDAO.excelStuDuplCheck", pParam);
				
				if(stuDuplCheck == null) {
					sqlDao.insertDAO("CareerManageDAO.insertStu", pParam);
					stuSn = sqlDao.selectDAO("CareerManageDAO.excelStuDuplCheck", pParam).getString("stuSn");
				} else {
					stuSn = stuDuplCheck.getString("stuSn");
					pParam.put("stuSn", stuSn);
					sqlDao.updateDAO("CareerManageDAO.updateStu", pParam);
				}
			} else if("E".equals(m.get("datatype"))) {
				pParam.put("stuSn", stuSn);
				pParam.put("schGubun", m.get("schGubun"));
				pParam.put("schNm", m.get("schNm"));
				pParam.put("graduatedYn", m.get("graduatedYn"));
				pParam.put("graduatedYear", m.get("graduatedYear"));
				pParam.put("qualificationExam", m.get("qualificationExam"));
				pParam.put("majorField", m.get("majorField"));
				pParam.put("major", m.get("major"));
				pParam.put("transferYn", m.get("transferYn"));
				
				ZValue schDuplCheck = sqlDao.selectDAO("CareerManageDAO.excelSchDuplCheck", pParam);
				if(schDuplCheck == null) {
					sqlDao.insertDAO("CareerManageDAO.insertSchool", pParam);
				} else {
					pParam.put("schSn", schDuplCheck.getString("schSn"));
					sqlDao.updateDAO("CareerManageDAO.updateSchool", pParam);
				}
			} else if("P".equals(m.get("datatype"))) {
				pParam.put("stuSn", stuSn);
				pParam.put("eduCode", m.get("eduCode"));
				pParam.put("year", m.get("eduYear"));
				pParam.put("joineduDtl", m.get("joineduDtl"));
				ZValue joinEduDuplCheck = sqlDao.selectDAO("CareerManageDAO.excelJoinEduDuplCheck", pParam);
				ZValue eduInfoForCode = sqlDao.selectDAO("CareerManageDAO.eduInfoForCode", pParam);
				if(joinEduDuplCheck == null) {
					pParam.put("eduSn", eduInfoForCode.getString("eduSn"));
					sqlDao.insertDAO("CareerManageDAO.insertJoinEdu", pParam);
				} else {
					pParam.put("joinSn", joinEduDuplCheck.getString("joinSn"));
					pParam.put("eduSn", eduInfoForCode.getString("eduSn"));
					sqlDao.updateDAO("CareerManageDAO.updateJoinEdu", pParam);
				}
			} else if("C".equals(m.get("datatype"))) {
				pParam.put("stuSn", stuSn);
				pParam.put("compNm", m.get("compNm"));
				pParam.put("joinYear", m.get("joinYear"));
				pParam.put("resignYear", m.get("resignYear"));
				pParam.put("employmentYn", m.get("employmentYn"));
				pParam.put("workerType", m.get("workerType"));
				pParam.put("rank", m.get("rank"));
				
				ZValue careerDuplCheck = sqlDao.selectDAO("CareerManageDAO.excelCareerDuplCheck", pParam);
				if(careerDuplCheck == null) {
					sqlDao.insertDAO("CareerManageDAO.insertCareer", pParam);
				} else {
					pParam.put("careerSn", careerDuplCheck.getString("careerSn"));
					sqlDao.updateDAO("CareerManageDAO.updateCareer", pParam);
				}
			} else if("W".equals(m.get("datatype"))) {
				pParam.put("stuSn", stuSn);
				pParam.put("createYear", m.get("createYear"));
				pParam.put("contractGroup", m.get("contractGroup"));
				pParam.put("createNm", m.get("createNm"));
				
				ZValue createDuplCheck = sqlDao.selectDAO("CareerManageDAO.excelcreateDuplCheck", pParam);

				if(createDuplCheck == null) {
					sqlDao.insertDAO("CareerManageDAO.insertCreate", pParam);
				} else {
					pParam.put("createSn", createDuplCheck.getString("createSn"));
					sqlDao.updateDAO("CareerManageDAO.updateCreate", pParam);
				}
			}
	
		}

	}
	
	
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
    	ModelMap model = paramCtx.getModel();
    	ZValue param = paramCtx.getParam();

    	List<ZValue> tmpList = new ArrayList<ZValue>();
    	
    	List<ZValue> stuList = sqlDao.listDAO("CareerManageDAO.listStuExcel", param);
    	for (int i=0; i<stuList.size(); i++) {
    		ZValue stuVO = new ZValue();
    		stuVO.put("datatype", "B");
    		stuVO.put("stuNm", stuList.get(i).get("stuNm"));
    		stuVO.put("gender", stuList.get(i).get("gender"));
    		stuVO.put("birth", stuList.get(i).get("birth"));
    		stuVO.put("phone", stuList.get(i).get("phone"));
    		stuVO.put("email", stuList.get(i).get("eamil"));
    		stuVO.put("jobSearchYn", stuList.get(i).get("jobSearchYn"));
    		stuVO.put("interField", stuList.get(i).get("interField"));
    		stuVO.put("interJob", stuList.get(i).get("interJob"));
    		stuVO.put("fldStrDtl", stuList.get(i).get("fldStrDtl"));
    		stuVO.put("fldEtcDtl", stuList.get(i).get("fldEtcDtl"));
    		stuVO.put("jobEtcDtl", stuList.get(i).get("jobEtcDtl"));
    		stuVO.put("fieldCareerYn", stuList.get(i).get("fieldCareerYn"));
    		stuVO.put("fieldCreateYn", stuList.get(i).get("fieldCreateYn"));
    		stuVO.put("fieldCreatePeriod", stuList.get(i).get("fieldCreatePeriod"));
    		
    		tmpList.add(stuVO);

    		ZValue pParam = new ZValue();
    		pParam.put("stuSn", stuList.get(i).get("stuSn"));
    		
    		List<ZValue> schList = sqlDao.listDAO("CareerManageDAO.schoolList", pParam);
    		if(!schList.isEmpty()) {
    			for (int j=0; j<schList.size(); j++) {
        			ZValue tmpVO = new ZValue();
        			tmpVO.put("datatype", "E");
        			tmpVO.put("schGubun", schList.get(j).get("schGubun"));
        			tmpVO.put("schNm", schList.get(j).get("schNm"));
        			tmpVO.put("graduatedYn", schList.get(j).get("graduatedYn"));
        			tmpVO.put("graduatedYear", schList.get(j).get("graduatedYear"));
        			tmpVO.put("majorField", schList.get(j).get("majorField"));
        			tmpVO.put("major", schList.get(j).get("major"));
        			tmpVO.put("qualificationExam", schList.get(j).get("qualificationExam"));
        			tmpVO.put("transferYn", schList.get(j).get("transferYn"));
        			
        			tmpList.add(tmpVO);
        		}
    		}
    		
    		List<ZValue> joinEduList = sqlDao.listDAO("CareerManageDAO.joinEduList", pParam);
    		if(!joinEduList.isEmpty()) {
    			for (int j=0; j<joinEduList.size(); j++) {
        			ZValue tmpVO = new ZValue();
        			tmpVO.put("datatype", "P");
        			tmpVO.put("eduCode", joinEduList.get(j).get("eduCode"));
        			tmpVO.put("year", joinEduList.get(j).get("year"));
        			tmpVO.put("joineduDtl", joinEduList.get(j).get("joineduDtl"));
        			
        			tmpList.add(tmpVO);
        		}
    		}

    		List<ZValue> careerList = sqlDao.listDAO("CareerManageDAO.careerList", pParam);
    		if(!careerList.isEmpty()) {
    			for (int j=0; j<careerList.size(); j++) {
        			ZValue tmpVO = new ZValue();
        			tmpVO.put("datatype", "C");
        			tmpVO.put("compNm", careerList.get(j).get("compNm"));
        			tmpVO.put("joinYear", careerList.get(j).get("joinYear"));
        			tmpVO.put("resignYear", careerList.get(j).get("resignYear"));
        			tmpVO.put("employmentYn", careerList.get(j).get("employmentYn"));
        			tmpVO.put("workerType", careerList.get(j).get("workerType"));
        			tmpVO.put("rank", careerList.get(j).get("rank"));
        			
        			tmpList.add(tmpVO);
        		}
    		}
    		
    		List<ZValue> createList = sqlDao.listDAO("CareerManageDAO.createList", pParam);
    		if(!createList.isEmpty()) {
    			for (int j=0; j<createList.size(); j++) {
    				ZValue tmpVO = new ZValue();
        			tmpVO.put("datatype", "W");
        			tmpVO.put("createYear", createList.get(j).get("createYear"));
        			tmpVO.put("contract", createList.get(j).get("contract"));
        			tmpVO.put("createNm", createList.get(j).get("createNm"));
        			
        			tmpList.add(tmpVO);
    			}
    		}
    	}
    	
    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
    	String day = date.format(today);
    	ExcelGenerateVO vo = new ExcelGenerateVO("All_Student_Career_data_"+day, null, tmpList);
    	
    	model.addAttribute("customTp", "Y");
    	HSSFWorkbook wookBook = this.customTrExcelOutputModel(tmpList);
    	
    	model.addAttribute("workBook", wookBook);
		model.addAttribute("excel", vo);

		paramCtx.setModel(model);

	}
	
	private HSSFWorkbook customTrExcelOutputModel(List<ZValue> tmpList) throws Exception {
		
		HSSFWorkbook objWorkBook = new HSSFWorkbook();
    	HSSFSheet objSheet = objWorkBook.createSheet(); 

        HSSFRow row = null;
        HSSFCell cell = null;
        
        row = objSheet.createRow(0);
        String[] headerKey = {"구분", "이름", "성별", "생년월일", "연락처","이메일","구직/이직 의사","관심분야","관심분야 스토리 상세","관심분야 기타 상세","관심직업형태","관심직업 기타 상세","관련분야 근무경력 유무","관련분야 작품활동 경력 유무","관련분야 작품활동 경력 기간","학력","학교명","졸업여부","졸업년도","전공계열","전공","검정고시","편입여부","사업명","참여년도","사업상세","회사명","입사년도","퇴사년도","재직여부","근무형태","직급","작품활동 연도","활동 소속명","활동 작품명"};
    	
        for(int i=0; i<headerKey.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(headerKey[i]);
        }
        
        for(int i=0; i<tmpList.size(); i++) {
        	row = objSheet.createRow(i + 1);
        	
        	cell = row.createCell(0);
        	cell.setCellValue(tmpList.get(i).getString("datatype"));
        	
        	cell = row.createCell(1);
        	cell.setCellValue(tmpList.get(i).getString("stuNm"));
        	
        	cell = row.createCell(2);
        	cell.setCellValue(tmpList.get(i).getString("gender"));
        	
        	cell = row.createCell(3);
        	cell.setCellValue(tmpList.get(i).getString("birth"));
        	
        	cell = row.createCell(4);
        	cell.setCellValue(tmpList.get(i).getString("phone"));
        	
        	cell = row.createCell(5);
        	cell.setCellValue(tmpList.get(i).getString("email"));
        	
        	cell = row.createCell(6);
        	cell.setCellValue(tmpList.get(i).getString("jobSearchYn"));
        	
        	cell = row.createCell(7);
        	cell.setCellValue(tmpList.get(i).getString("interField"));
        	
        	cell = row.createCell(8);
        	cell.setCellValue(tmpList.get(i).getString("fldStrDtl"));
        	
        	cell = row.createCell(9);
        	cell.setCellValue(tmpList.get(i).getString("fldEtcDtl"));
        	
        	cell = row.createCell(10);
        	cell.setCellValue(tmpList.get(i).getString("interJob"));
        	
        	cell = row.createCell(11);
        	cell.setCellValue(tmpList.get(i).getString("jobEtcDtl"));
        	
        	cell = row.createCell(12);
        	cell.setCellValue(tmpList.get(i).getString("fieldCareerYn"));
        	
        	cell = row.createCell(13);
        	cell.setCellValue(tmpList.get(i).getString("fieldCreateYn"));
        	
        	cell = row.createCell(14);
        	cell.setCellValue(tmpList.get(i).getString("fieldCreatePeriod"));
        	
        	cell = row.createCell(15);
        	cell.setCellValue(tmpList.get(i).getString("schGubun"));
        	
        	cell = row.createCell(16);
        	cell.setCellValue(tmpList.get(i).getString("schNm"));
        	
        	cell = row.createCell(17);
        	cell.setCellValue(tmpList.get(i).getString("graduatedYn"));
        	
        	cell = row.createCell(18);
        	cell.setCellValue(tmpList.get(i).getString("graduatedYear"));
        	
        	cell = row.createCell(19);
        	cell.setCellValue(tmpList.get(i).getString("majorField"));
        	
        	cell = row.createCell(20);
        	cell.setCellValue(tmpList.get(i).getString("major"));
        	
        	cell = row.createCell(21);
        	cell.setCellValue(tmpList.get(i).getString("qualificationExam"));
        	
        	cell = row.createCell(22);
        	cell.setCellValue(tmpList.get(i).getString("transferYn"));
        	
        	cell = row.createCell(23);
        	cell.setCellValue(tmpList.get(i).getString("eduCode"));
        	
        	cell = row.createCell(24);
        	cell.setCellValue(tmpList.get(i).getString("year"));
        	
        	cell = row.createCell(25);
        	cell.setCellValue(tmpList.get(i).getString("joineduDtl"));
        	
        	cell = row.createCell(26);
        	cell.setCellValue(tmpList.get(i).getString("compNm"));
        	
        	cell = row.createCell(27);
        	cell.setCellValue(tmpList.get(i).getString("joinYear"));
        	
        	cell = row.createCell(28);
        	cell.setCellValue(tmpList.get(i).getString("resignYear"));
        	
        	cell = row.createCell(29);
        	cell.setCellValue(tmpList.get(i).getString("employmentYn"));
        	
        	cell = row.createCell(30);
        	cell.setCellValue(tmpList.get(i).getString("workerType"));
        	
        	cell = row.createCell(31);
        	cell.setCellValue(tmpList.get(i).getString("rank"));
        	
        	cell = row.createCell(32);
        	cell.setCellValue(tmpList.get(i).getString("createYear"));
        	
        	cell = row.createCell(33);
        	cell.setCellValue(tmpList.get(i).getString("contract"));
        	
        	cell = row.createCell(34);
        	cell.setCellValue(tmpList.get(i).getString("createNm"));
        	
        }
        
    	return objWorkBook;
	}
	
}
