package kr.co.unp.mpm.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ServletContextAware;

import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("masterMenuManagerService")
public class MasterMenuManager implements InitializingBean, ServletContextAware{

	protected Log log = LogFactory.getLog(MasterMenuManager.class);

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	public static final String PREFIX = "menu_";
	public static final String CONTEXT_SCOPE_MENU_PREFIX = "menuAll";

	@Resource(name="SqlDAO")
    private ISqlDAO<MenuManageVO> menuManageDAO;

	private ServletContext servletContext;

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		if( "N".equals(Globals.TEST_MODE) ){
			HashMap<String, HashMap<String, List<MenuManageVO>>> menuMap = getMenuCategoryMap();
			if( menuMap != null && servletContext != null ){
				Iterator<String> it = menuMap.keySet().iterator();
				while( it.hasNext() )
				{
					String key = it.next();
					servletContext.setAttribute( key, menuMap.get(key) );
				}
			}
		}
	}

	public void rearrangeMenu2( HashMap<String, List<MenuManageVO>> menuMap ) throws Exception
	{
		Iterator<String> it = menuMap.keySet().iterator();
		while( it.hasNext() )
		{
			String key = it.next();
			List<MenuManageVO> list = menuMap.get( key );
			for( MenuManageVO vo : list )
			{
				menuManageDAO.updateDAO("menuManageDAO.rearrangeMenu2", vo);
			}
		}
	}

	public HashMap<String, HashMap<String, List<MenuManageVO>>> getMenuCategoryMap() throws Exception
	{
		HashMap<String, HashMap<String, List<MenuManageVO>>> result = new HashMap<String, HashMap<String, List<MenuManageVO>>>();
		List<MenuManageVO> menuStructure = menuManageDAO.listDAO("menuManageDAO.selectAllMenu", null);
		HashMap<String, List<MenuManageVO>> menuStructureMap = new HashMap<String, List<MenuManageVO>>();
		ArrayList<MenuManageVO> list = null;
		for( MenuManageVO vo : menuStructure )
		{
			String siteId = vo.getSiteId();
			List<MenuManageVO> obj = menuStructureMap.get( CONTEXT_SCOPE_MENU_PREFIX + siteId );
			if( obj == null )
			{
				list = new ArrayList<MenuManageVO>();
				list.add( vo );
				menuStructureMap.put( CONTEXT_SCOPE_MENU_PREFIX + siteId, list );
			}
			else
			{
				obj.add( vo );
			}
		}
		Iterator<String> it = menuStructureMap.keySet().iterator();
		while( it.hasNext() )
		{
			String key = it.next();
	    	HashMap<String, List<MenuManageVO>> menuCategoryMap = getMenuCategories( menuStructureMap.get(key) );
	    	HashMap<String, List<MenuManageVO>> obj = setMenuCategory(menuCategoryMap, PREFIX+"0", 0, new String[6]);

	    	//rearrangeMenu2( obj );

	    	result.put( key, obj );
		}

    	return result;
	}

	public HashMap<String, List<MenuManageVO>> getMenuCategoryMapBySiteId(String siteId) throws Exception
	{
		MenuManageVO param = new MenuManageVO();
		param.setSiteId(siteId);
		List<MenuManageVO> menuStructure = menuManageDAO.listDAO("menuManageDAO.selectAllMenuBySiteId", param);
    	HashMap<String, List<MenuManageVO>> menuCategoryMap = getMenuCategories(menuStructure);
    	HashMap<String, List<MenuManageVO>> obj = setMenuCategory(menuCategoryMap, PREFIX+"0", 0, new String[6]);

    	rearrangeMenu2( obj );

    	return obj;
	}

	public HashMap<String, List<MenuManageVO>> getMenuCategories(List<MenuManageVO> list)
	{
		HashMap<String, List<MenuManageVO>> categoryMap = new HashMap<String, List<MenuManageVO>>();
		//log.debug("list.size() : " + list.size());
		int size = list.size();
		for(int i=0; i<size; i++)
		{
			MenuManageVO vo = list.get(i);
			String parentId = PREFIX+vo.getUpperMenuId();
			if(categoryMap.containsKey(parentId))
			{
				List<MenuManageVO> categoryList = categoryMap.get(parentId);
				categoryList.add(vo);
			}
			else
			{
				ArrayList<MenuManageVO> categoryList = new ArrayList<MenuManageVO>();
				categoryList.add(vo);
				categoryMap.put(parentId, categoryList);
			}
		}
		return categoryMap;
	}

	public void markLeafMenu(HashMap<String, List<MenuManageVO>> menuCategoryMap, String key)
	{
		Collection<List<MenuManageVO>> menuList = menuCategoryMap.values();
		Iterator<List<MenuManageVO>> it = menuList.iterator();
		while(it.hasNext())
		{
			List<MenuManageVO> list = it.next();
			for(MenuManageVO vo : list)
			{
				int menuNo = StrUtils.parseInt(StrUtils.replace(key, PREFIX, ""));
				if(menuNo == vo.getMenuNo())
				{
					vo.setLeafNodeYn("Y");
					return;
				}
			}
		}
	}
	public HashMap<String, List<MenuManageVO>> setMenuCategory(
			HashMap<String, List<MenuManageVO>> menuCategoryMap,
			String parentId, int depth, String[] pos)
	{
		return setMenuCategory(menuCategoryMap, parentId, depth, pos, null);
	}

	public HashMap<String, List<MenuManageVO>> setMenuCategory(
			HashMap<String, List<MenuManageVO>> menuCategoryMap,
			String parentId, int depth, String[] pos, String gubun)
	{
		List<MenuManageVO> menuCategories = menuCategoryMap.get(parentId);
		//List<MenuManageVO> topCategories = menuCategoryMap.get(PREFIX+"0");
		if(menuCategories == null)
		{
			markLeafMenu(menuCategoryMap, parentId);
		}
		else
		{
			depth++;
			for(int i=0; i<menuCategories.size(); i++)
			{
				MenuManageVO vo = menuCategories.get(i);
				if(depth > 6) log.debug("6뎁스이상은 허용하지않습니다. [menuNo," + vo.getMenuNo() + "]");
				int menuNo = vo.getMenuNo();
				pos[depth-1] = StrUtils.fillZero(String.valueOf(i+1), 2, true);
				String position = getPosition(pos, depth);
				//MenuManageVO curVo = getCurrentMenuCategory(menuCategoryMap, position);
				MenuManageVO curVo = getCurrentMenuVO(menuCategoryMap, position);
				vo.setPath(curVo.getPath());
				//vo.setFullPath(curVo.getFullPath());

				if( !StringUtils.hasText(vo.getContentsPath()) )
				{
					String menuNoPath = curVo.getMenuNoPath();
					String[] pathData = StrUtils.split(menuNoPath, "|");
					String leafMenuNo = pathData[pathData.length-1];
					StringBuffer contentsPath = new StringBuffer();
					contentsPath.append("/").append(vo.getSiteName()).append("/cts/");
					contentsPath.append(leafMenuNo).append(".jsp");
					vo.setContentsPath(contentsPath.toString());
				}

				//일반컨텐츠 페이지
				StringBuffer menuLink = new StringBuffer(vo.getMenuLink() == null ? "" : vo.getMenuLink());
				if( !StringUtils.hasText(menuLink) )
				{
					menuLink.append("/").append(vo.getSiteName()).append("/main/contents.do?menuNo=").append(menuNo);
				}
				//팝업
				else if( !"Y".equals(vo.getMenuPopupYn()) )
				{
					if(menuLink.indexOf("menuNo=") == -1 && menuLink.indexOf("javascript:") == -1)
					{
						if(menuLink.indexOf("?") != -1)
							menuLink.append("&amp;menuNo=").append(menuNo);
						else
							menuLink.append("?menuNo=").append(menuNo);
					}
				}
				/*
				if( SiteMngService.DONG_SITE_ID.equals(siteId) ){
					if(menuLink.indexOf("?") != -1)
						menuLink.append("&dong=").append(position.substring(0, 2));
					else
						menuLink.append("?dong=").append(position.substring(0, 2));
				}
				else if( SiteMngService.DEPT_SITE_ID.equals(siteId) ){
					if(menuLink.indexOf("?") != -1)
						menuLink.append("&dept=").append(position.substring(0, 2));
					else
						menuLink.append("?dept=").append(position.substring(0, 2));
				}
				*/
				vo.setFullMenuLink(menuLink.toString());
				vo.setPosition(position);
				vo.setDepth(depth);

				int index = 0;
				for (MenuManageVO tmpvo :  menuCategories) {
					if (vo.getMenuNo() == tmpvo.getMenuNo()) {
						if (index > 0 && index < menuCategories.size()) {
							vo.setPreMenuNo(menuCategories.get(index-1).getMenuNo());
							vo.setPreMenuLink(menuCategories.get(index-1).getFullMenuLink());
						}
						if (index >= 0 && index < menuCategories.size()-1) {
							vo.setNextMenuNo(menuCategories.get(index+1).getMenuNo());
							vo.setNextMenuLink(menuCategories.get(index+1).getFullMenuLink());
						}
						break;
					}
					index++;
				}



				setMenuCategory(menuCategoryMap, PREFIX+menuNo, depth, pos, gubun);
			}
		}

		return menuCategoryMap;
	}

	public MenuManageVO getCurrentMenu(HashMap<String, List<MenuManageVO>> menuMap, int menuNo) throws Exception
	{

		int tmpMenuNo = getLeafMenuNo(menuMap, menuNo);
		MenuManageVO result = null;
		Iterator<String> it = menuMap.keySet().iterator();
		while(it.hasNext())
		{
			String key = it.next();
			List<MenuManageVO> list = menuMap.get(key);
			for(MenuManageVO vo : list)
			{
				if(menuNo == 0 && "Y".equals(vo.getLeafNodeYn()) )
				{
					vo.setcMenuNo(menuNo);
					return vo;
				}
				else if(vo.getMenuNo() == menuNo)
				{
					vo.setcMenuNo(tmpMenuNo);
					return vo;
				}
			}
		}
		return result;
	}


	public int getLeafMenuNo(HashMap<String, List<MenuManageVO>> menuMap, int menuNo)  throws Exception {
		String key = PREFIX+ String.valueOf(menuNo);
		List<MenuManageVO> list = menuMap.get(key);
		if (list != null && list.size() > 0 ) {
			return  this.getLeafMenuNo(menuMap, list.get(0).getMenuNo());
		}
		else {
			return menuNo;
		}
	}

	public MenuManageVO getCurrentMenuVO(HashMap<String, List<MenuManageVO>> menuCategoryMap, String position){
		return getCurrentMenuVO(menuCategoryMap, position, new MenuManageVO(), 0, 0);
	}

	public MenuManageVO getCurrentMenuVO(HashMap<String, List<MenuManageVO>> menuCategoryMap, String position, MenuManageVO savedMenuVO, int menuNo, int depth)
	{
		depth++;
		int depthIdx = 0;
		if(depth == 1) depthIdx = Integer.parseInt(position.substring(0,2)) -1;
		else if(depth == 2) depthIdx = Integer.parseInt(position.substring(2,4)) -1;
		else if(depth == 3) depthIdx = Integer.parseInt(position.substring(4,6)) -1;
		else if(depth == 4) depthIdx = Integer.parseInt(position.substring(6,8)) -1;
		else if(depth == 5) depthIdx = Integer.parseInt(position.substring(8,10)) -1;
		else if(depth == 6) depthIdx = Integer.parseInt(position.substring(10,12)) -1;

		List<MenuManageVO> menuCategories = menuCategoryMap.get(PREFIX+menuNo);
		if(menuCategories != null)
		{
			MenuManageVO curMenuVO = menuCategories.get(depthIdx);
			String path = savedMenuVO.getPath();
			String menuNoPath = savedMenuVO.getMenuNoPath();
			if( depth == 1){
				savedMenuVO.setTopMenuNo(curMenuVO.getMenuNo());
				path = curMenuVO.getMenuNm();
				menuNoPath = curMenuVO.getMenuNo()+"";
			}
			else{
				path += "|" + curMenuVO.getMenuNm();
				menuNoPath += "|" + curMenuVO.getMenuNo();
			}
			savedMenuVO.setPath(path);
			savedMenuVO.setMenuNoPath(menuNoPath);
			getCurrentMenuVO(menuCategoryMap, position, savedMenuVO, curMenuVO.getMenuNo(), depth);
		}
		return savedMenuVO;
	}

	@Deprecated
	public MenuManageVO getCurrentMenuCategory(HashMap<String, List<MenuManageVO>> menuCategoryMap, String menuId)
	{
		if(menuId == null || "".equals(menuId)) menuId = "010101010101";
		int d01 = Integer.parseInt(menuId.substring(0,2)) -1;
		int d02 = Integer.parseInt(menuId.substring(2,4)) -1;
		int d03 = Integer.parseInt(menuId.substring(4,6)) -1;
		int d04 = Integer.parseInt(menuId.substring(6,8)) -1;
		int d05 = Integer.parseInt(menuId.substring(8,10)) -1;
		int d06 = Integer.parseInt(menuId.substring(10,12)) -1;

		MenuManageVO vo = null;
		String path = "";
		String fullPath = "";
		String menuNoPath = "";
		List<MenuManageVO> d01MenuCategories = menuCategoryMap.get(PREFIX+"0");
		if(d01MenuCategories != null)
		{
			vo = d01MenuCategories.get(d01);
			int topMenuNo = vo.getMenuNo();
			vo.setTopMenuNo(vo.getMenuNo());
			path += vo.getMenuNm();
			fullPath += vo.getMenuLink();
			menuNoPath += vo.getMenuNo();

			List<MenuManageVO> d02MenuCategories = menuCategoryMap.get(PREFIX+vo.getMenuNo());
			if(d02MenuCategories != null)
			{
				vo = d02MenuCategories.get(d02);
				vo.setTopMenuNo(topMenuNo);
				path += "|" + vo.getMenuNm();
				fullPath += "|" + vo.getMenuLink();
				menuNoPath += "|" + vo.getMenuNo();

				List<MenuManageVO> d03MenuCategories = menuCategoryMap.get(PREFIX+vo.getMenuNo());
				if(d03MenuCategories != null)
				{
					vo = d03MenuCategories.get(d03);
					vo.setTopMenuNo(topMenuNo);
					path += "|" + vo.getMenuNm();
					fullPath += "|" + vo.getMenuLink();
					menuNoPath += "|" + vo.getMenuNo();
					List<MenuManageVO> d04MenuCategories = menuCategoryMap.get(PREFIX+vo.getMenuNo());
					if(d04MenuCategories != null)
					{
						vo = d04MenuCategories.get(d04);
						vo.setTopMenuNo(topMenuNo);
						path += "|" + vo.getMenuNm();
						fullPath += "|" + vo.getMenuLink();
						menuNoPath += "|" + vo.getMenuNo();
						List<MenuManageVO> d05MenuCategories = menuCategoryMap.get(PREFIX+vo.getMenuNo());
						if(d05MenuCategories != null)
						{
							vo = d05MenuCategories.get(d05);
							vo.setTopMenuNo(topMenuNo);
							path += "|" + vo.getMenuNm();
							fullPath += "|" + vo.getMenuLink();
							menuNoPath += "|" + vo.getMenuNo();
							List<MenuManageVO> d06MenuCategories = menuCategoryMap.get(PREFIX+vo.getMenuNo());
							if(d06MenuCategories != null)
							{
								vo = d06MenuCategories.get(d06);
								vo.setTopMenuNo(topMenuNo);
								path += "|" + vo.getMenuNm();
								fullPath += "|" + vo.getMenuLink();
								menuNoPath += "|" + vo.getMenuNo();
							}

						}

					}

				}

			}

		}
		if (vo!=null){
			vo.setPath(path);
			vo.setFullPath(fullPath);
			vo.setMenuNoPath(menuNoPath);
		}
		return vo;
	}

	public HashMap<String, Object> setContents(String siteId) throws Exception
	{
		HashMap<String, Object> result = new HashMap<String, Object>();

		//HashMap<String, MenuManageVO> menuMap = new HashMap<String, MenuManageVO>();
    	HashMap<String, List<MenuManageVO>> map = getMenuCategoryMapBySiteId(siteId);
    	Set<String> keyes = map.keySet();
    	for(String key : keyes)
    	{
    		List<MenuManageVO> values = map.get(key);
    		for(MenuManageVO vo : values)
    		{
    			String contentsPath = vo.getContentsPath();
    			String contentsPathRoot = propertyService.getString("contentsPathRoot");
    			if( contentsPathRoot.endsWith("/") ) contentsPathRoot = contentsPathRoot.substring(0, contentsPathRoot.length()-1);
    			String path = contentsPathRoot + contentsPath;
    			try {
					File file = new File(path);
					String contents = FileUtils.readFileToString(file, "UTF-8");
			    	contents = contents.replaceAll("<%\\s*@\\s*page .*%\\s*>", "");
					vo.setCvCon(contents);
					menuManageDAO.updateDAO("commonContentsDAO.menuAllNo", vo);
					menuManageDAO.insertDAO("commonContentsDAO.modify", vo);

					menuManageDAO.updateDAO("menuManageDAO.setModifyDayToToday", vo);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					//e.printStackTrace();
					log.debug(e.getMessage());
				}
    		}
    	}

    	return result;
	}

	public HashMap<String, Object> reloadMenu(String siteId) throws Exception
	{
		HashMap<String, Object> result = new HashMap<String, Object>();

		HashMap<String, MenuManageVO> menuMap = new HashMap<String, MenuManageVO>();
    	HashMap<String, List<MenuManageVO>> map = getMenuCategoryMapBySiteId(siteId);
    	Set<String> keyes = map.keySet();
    	for(String key : keyes)
    	{
    		List<MenuManageVO> values = map.get(key);
    		for(MenuManageVO vo : values)
    		{
    			menuMap.put(PREFIX+vo.getMenuNo(), vo);
				menuManageDAO.updateDAO("menuManageDAO.rearrangeMenu", vo);
    		}
    	}

    	return result;
	}

	public void rearrangeMenu(HashMap<String, MenuManageVO> map) throws Exception
	{
		Iterator<String> it = map.keySet().iterator();
		MenuManageVO vo = null;
		String key = null;
		while(it.hasNext())
		{
			key = it.next();
			vo = map.get(key);
			menuManageDAO.updateDAO("menuManageDAO.rearrangeMenu", vo);
		}
	}

	public void createTempContentsFile(String siteId) throws Exception
	{
		String content = "<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>";
		MenuManageVO param = new MenuManageVO();
		param.setSiteId(siteId);
		List<MenuManageVO> menuStructure = menuManageDAO.listDAO("menuManageDAO.selectAllMenuBySiteId", param);
		for(MenuManageVO vo : menuStructure)
		{
			String contentsPath = vo.getContentsPath();
			if( StringUtils.hasText(contentsPath) && !contentsPath.startsWith("/"))
			{
				contentsPath = "/" + contentsPath;
			}
			if( StringUtils.hasText(contentsPath) )
			{
				String realPath = "c:/Temp/temp_cts" + contentsPath;
				log.debug(">>realPath : " + realPath);

				String _content = content + "\n<div class=\"coomings\">컨텐츠 준비중 입니다.</div>";

				File des = new File(realPath);
				FileUtils.writeStringToFile(des, _content, "UTF-8");
			}
		}
	}

	public HashMap<String, ZValue> getCategoryMap(List<ZValue> categoryList)
	{
		HashMap<String, ZValue> categoryMap = new HashMap<String, ZValue>();
		for(ZValue category : categoryList)
		{
			categoryMap.put(PREFIX+category.getString("categoryId"), category);
		}
		return categoryMap;
	}

	public void setModifyDay(HashMap<String, List<MenuManageVO>> menuMap, int menuNo) throws Exception
	{
		MenuManageVO mvo = new MenuManageVO();
		mvo.setMenuNo(menuNo);
		menuManageDAO.updateDAO("menuManageDAO.setModifyDayToToday", mvo);
		if( menuMap != null && servletContext != null ){
			Iterator<String> it = menuMap.keySet().iterator();

			while( it.hasNext() )
			{
				String key = it.next();
				List<MenuManageVO> menuList = menuMap.get(key);
				for(MenuManageVO vo : menuList)
				{
					if( vo.getMenuNo() == menuNo )
					{
						vo.setModifyDay(new Date());
						return;
					}
				}

			}
		}
	}

	public void setChargeInPerson(HashMap<String, List<MenuManageVO>> menuMap, MenuManageVO menuVo) throws Exception
	{
		menuManageDAO.updateDAO("menuManageDAO.setModifyDayToToday", menuVo);

		if( MapUtils.isNotEmpty(menuMap) ){
			int menuNo = menuVo.getMenuNo();
			Iterator<String> it = menuMap.keySet().iterator();
			while( it.hasNext() )
			{
				String key = it.next();
				List<MenuManageVO> menuList = menuMap.get(key);
				if( CollectionUtils.isNotEmpty(menuList) ){
					for(MenuManageVO vo : menuList)
					{
						if( vo.getMenuNo() == menuNo )
						{
							vo.setModifyDay(new Date());
							vo.setUserId(menuVo.getUserId());
							vo.setUserName(menuVo.getUserName());
							vo.setTel(menuVo.getTel());
							vo.setDeptId(menuVo.getDeptId());
							vo.setTeamName(menuVo.getTeamName());
							vo.setDeptName(menuVo.getDeptName());
							log.debug("assigned menu  : " + vo);
							return;
						}
					}
				}

			}
		}
	}

	private String getPosition(String[] pos, int depth)
	{
		String position = "";
		for(int i=0; i<depth; i++)
		{
			position += pos[i];
		}

		for(int i=depth; i<6; i++)
		{
			position += "01";
		}

		return position;
	}

}
