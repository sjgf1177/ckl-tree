package kr.co.unp.bbs.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.bbs.service.FnwBBSManager;
import kr.co.unp.bbs.vo.BoardMasterVO;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/{siteName}/bbs/{bbsId}")
public class FnwBBSController extends DefaultCmmProgramController implements InitializingBean{

    @Resource(name = "fnwBBSManager")
    protected FnwBBSManager fnwBBSManager;

	Logger log = Logger.getLogger(this.getClass());

	@Override
	public void afterPropertiesSet() throws Exception {
		super.setProgramManager(fnwBBSManager);
	}

	@Override
	protected ParameterContext<ZValue> setProperty(HttpServletRequest request, HttpServletResponse response, ZValue param, ModelMap model) throws Exception{
		ParameterContext<ZValue> paramCtx = super.setProperty(request, response, param, model);
		ZValue paramVO = paramCtx.getParam();
		setMasterVO(paramVO, model);
		return paramCtx;
	}

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx){
		return paramCtx.getParam().getString("bbsId");
	}

	private void setMasterVO(ZValue paramVO, ModelMap model){
		String bbsId = paramVO.getString("bbsId");
		Assert.hasText(bbsId);

		BoardMasterVO masterVO = fnwBBSManager.getMasterVO(bbsId);
		Assert.notNull(masterVO);
		log.debug("masterVO : " + masterVO);
		model.addAttribute("masterVO", masterVO);

		paramVO.put("tableNm", masterVO.getTableNm());
	}
}
