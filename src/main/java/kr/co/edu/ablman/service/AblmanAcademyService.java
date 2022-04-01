package kr.co.edu.ablman.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;


public class AblmanAcademyService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	public AblmanAcademyService() {
		super.setCountQueryId("ablmanAcademyDAO.listCnt");
		super.setListQueryId("ablmanAcademyDAO.list");
		super.setInsertQueryId("ablmanAcademyDAO.insert");
		super.setViewQueryId("ablmanAcademyDAO.view");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();

		super.list(paramCtx);

		model.addAttribute("COM050CodeList", codeList("COM050"));
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("frstRegisterId", user.getUserId());
		String email = param.getString("email1") + "@" + param.getString("email2");
		param.put("email", email);
		String telno = param.getString("telno1") + "-" + param.getString("telno2") + "-" + param.getString("telno3");
		param.put("telno", telno);
		String faxnum = param.getString("faxnum1") + "-" + param.getString("faxnum2") + "-" + param.getString("faxnum3");
		param.put("faxnum", faxnum);

		int lastVerAtCnt = sqlDao.selectCount("ablmanAcademyDAO.lastVerAtCnt", param);
		if (lastVerAtCnt > 0) {
			param.put("lastVerAtVal", "N");
			sqlDao.updateDAO("ablmanAcademyDAO.lastVerAtChange", param);
		}

		super.insert(paramCtx);
	}

	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.deleteDAO("ablmanAcademyDAO.delete", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 이력 목록 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void chghstPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue user = sqlDao.selectDAO("ablmanAcademyDAO.view", param);

		List<ZValue> chghstList = sqlDao.listDAO("ablmanAcademyDAO.chghstList", param);

		if (StringUtils.hasText(param.getString("histSn"))) {
			ZValue result = sqlDao.selectDAO("ablmanAcademyDAO.chghst", param);
			model.addAttribute("result", result);
		}

		model.addAttribute("user", user);
		model.addAttribute("chghstList", chghstList);
	}

	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"분류", "프로그램명", "아이디", "이름", "성별", "생년월일", "참여여부", "상태", "취/창업 일자", "회사구분", "회사명", "담당자명", "연락처", "팩스", "이메일", "기타"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("ablmanAcademyDAO.listExcel", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("융합아카데미 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}

}
