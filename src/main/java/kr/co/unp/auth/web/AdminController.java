package kr.co.unp.auth.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.mpm.dao.MenuManageDAO;
import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.HttpUtil;

@Controller
public class AdminController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "masterMenuManagerService")
	protected MasterMenuManager masterMenuManagerService;

	@Resource(name = "menuManageDAO")
	protected MenuManageDAO menuManageDAO;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/bos/main/main", "/bos/loginProcess" })
	public String bosLoginProcess(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
		if( !UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY") ){
			HttpUtil.winClose(response, "관리자만 접속할 수 있습니다.");
			return null;
		}

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("adminUser", user);
		ZValue zvl = WebFactory.getAttributes(request);

		HashMap<String, List<MenuManageVO>> map = (HashMap<String, List<MenuManageVO>>) session.getAttribute("adminMenuMap");
		// 로그인후이거나 로그인한후 메뉴요청이 아닌경우(매번 권한별메뉴 불러올 필요가없음) 권한별메뉴 새로 불러옴
		if (map == null || "L".equals(zvl.getString("flag"))) {
			List<MenuManageVO> menuStructure = null;
			if (UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {
				MenuManageVO vo = new MenuManageVO();
				vo.setSiteId(SiteMngService.BOS_SITE_ID);
				menuStructure = menuManageDAO.selectAllMenuBySiteId(vo);
			} else {
				List<String> authorities = UnpUserDetailsHelper.getAuthorities();
				log.debug("################authorities : " + authorities);
				if (authorities == null) {
					HttpUtil.goUrl(response, "/bos/member/forLogin.do", "권한이 없습니다.");
					return null;
				}

				ZValue param = new ZValue();
				param.putObject("authorities", authorities);
				menuStructure = menuManageDAO.selectAuthoMenuListByAuthorities(param);
			}

			if (menuStructure == null || menuStructure.size() == 0) {
				HttpUtil.goUrl(response, "/bos/member/forLogin.do", "담당자 권한별메뉴가 등록되어있지 않습니다. 관리자에게 문의하세요.");
				return null;
			}
			
			Date nowDt = new Date();
			Date pwdChangeDt = user.getPwdChangeDt();
			
			if (pwdChangeDt == null || pwdChangeDt.before(nowDt)) {
				HttpUtil.goUrl(response, "/bos/member/pwdChange.do", "비밀번호를 변경한지 3개월 이상 경과 하였습니다. 비밀번호를 변경하여 주십시오.");
				return null;
			}

			HashMap<String, List<MenuManageVO>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuStructure);
			map = masterMenuManagerService.setMenuCategory(menuCategoryMap, "menu_0", 0, new String[5]);
			session.setAttribute("adminMenuMap", map);
		}
		
		String returnVal = "";

		Date nowDt = new Date();
		Date pwdChangeDt = user.getPwdChangeDt();
		
		if (pwdChangeDt == null || pwdChangeDt.before(nowDt)) {
			returnVal = "bos/member/pwdChange";
		} else {
			returnVal = "bos/main/bosMain";
		}
		

		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(map, zvl.getInt("menuNo", 0));
		currentVo = masterMenuManagerService.getCurrentMenuCategory(map, currentVo.getPosition());
		model.addAttribute("currentVo", currentVo);

		return returnVal;
	}

	@RequestMapping(value = "/bos/main/setContents")
	public void setContents(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
		String siteId = zvl.getString("siteId");
		Assert.hasText(siteId);
		if ("1".equals(siteId))
			throw new IllegalArgumentException("관리자는 허용하지 않습니다.");
		masterMenuManagerService.setContents(siteId);
	}

	@RequestMapping(value = "/bos/main/reloadMenu")
	public void giveStaffAuthoFromDept(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
		String siteId = zvl.getString("siteId");
		Assert.hasText(siteId);
		if (SiteMngService.BOS_SITE_ID.equals(siteId))
			throw new IllegalArgumentException("관리자는 허용하지 않습니다.");
		masterMenuManagerService.reloadMenu(siteId);
	}

	@RequestMapping(value = "/bos/main/createTempContentsFile")
	public void createTempContentsFile(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
		String siteId = zvl.getString("siteId");
		Assert.hasText(siteId);
		if (SiteMngService.BOS_SITE_ID.equals(siteId))
			throw new IllegalArgumentException("관리자는 허용하지 않습니다.");
		masterMenuManagerService.createTempContentsFile(siteId);

	}

}
