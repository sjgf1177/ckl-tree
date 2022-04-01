package kr.co.unp.cmm.sec.ram.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.mpm.dao.MenuManageDAO;
import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.util.CollectionUtils;

import egovframework.com.utl.HttpUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class BosSessionSavedRequestAwareAuthenticationHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "masterMenuManagerService")
	private MasterMenuManager masterMenuManagerService;

	@Resource(name = "menuManageDAO")
	private MenuManageDAO menuManageDAO;

	@Resource(name = "SqlDAO")
	private ISqlDAO<EgovMap> sqlDao;

    @SuppressWarnings("unchecked")
	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {

    	try {
			EgovMap param = new EgovMap();

			Object principal = authentication.getPrincipal();
			if( principal != null ){
				if( principal instanceof UnpUserDetails){
					UnpUserDetails details = (UnpUserDetails) authentication.getPrincipal();
					UsersVO user = details.getUsersVO();
					if( user!= null ){
						param.put("userId", user.getUserId());
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

    	HttpSession session = request.getSession();
		ZValue zvl = WebFactory.getAttributes(request);

		HashMap<String, List<MenuManageVO>> map = (HashMap<String, List<MenuManageVO>>) session.getAttribute("adminMenuMap");
		// 로그인후이거나 로그인한후 메뉴요청이 아닌경우(매번 권한별메뉴 불러올 필요가없음) 권한별메뉴 새로 불러옴
		if (map == null || "L".equals(zvl.getString("flag"))) {
			List<MenuManageVO> menuStructure = null;
			if (UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {

				MenuManageVO vo = new MenuManageVO();
				vo.setSiteId(SiteMngService.BOS_SITE_ID);
				try {
					menuStructure = menuManageDAO.selectAllMenuBySiteId(vo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				List<String> authorities = UnpUserDetailsHelper.getAuthorities();
				log.debug("################authorities : " + authorities);
				if (authorities == null) {
					HttpUtil.goUrl(response, "/bos/member/forLogin.do", "권한이 없습니다.");
					return;
				}

				ZValue param = new ZValue();
				param.putObject("authorities", authorities);
				try {
					menuStructure = menuManageDAO.selectAuthoMenuListByAuthorities(param);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			if (CollectionUtils.isEmpty(menuStructure)) {
				HttpUtil.goUrl(response, "/bos/member/forLogin.do", "담당자 권한별메뉴가 등록되어있지 않습니다. 관리자에게 문의하세요.");
				return;
			}

			HashMap<String, List<MenuManageVO>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuStructure);
			map = masterMenuManagerService.setMenuCategory(menuCategoryMap, "menu_0", 0, new String[6]);

			session.setAttribute("adminMenuMap", map);
		}

		super.onAuthenticationSuccess(request, response, authentication);

    }

}
