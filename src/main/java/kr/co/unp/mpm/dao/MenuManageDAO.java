package kr.co.unp.mpm.dao;

import java.util.List;

import kr.co.unp.util.ZValue;
import kr.co.unp.mpm.vo.MenuCreatVO;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.mpm.vo.MenuSiteMapVO;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 DAO 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */

@Repository("menuManageDAO")
public class MenuManageDAO extends EgovAbstractDAO{

	public static final String MENU_CACHE_NAME = "storedMenu";

	
	/**
	 * 메뉴목록관리 기본정보를 조회
	 * @param vo ComDefaultVO 
	 * @return MenuManageVO 
	 * @exception Exception
	 */
	public MenuManageVO selectMenuManage(ComDefaultVO vo)throws Exception{
		return (MenuManageVO)selectByPk("menuManageDAO.selectMenuManage_D", vo); 
	}

	/**
	 * 메뉴목록 기본정보를 등록
	 * @param vo MenuManageVO 
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void insertMenuManage(MenuManageVO vo){
		int menuOrdr = (Integer)selectByPk("menuManageDAO.selectMaxMenuOrdr", vo);
		vo.setMenuOrdr(menuOrdr);
		insert("menuManageDAO.insertMenuManage_S", vo);
	}


	/**
	 * 메뉴목록 기본정보를 수정
	 * @param vo MenuManageVO 
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void updateMenuManage(MenuManageVO vo){
		update("menuManageDAO.updateMenuManage_S", vo);
	}

	/**
	 * 메뉴목록 기본정보를 삭제
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void deleteMenuManage(MenuManageVO vo){
		delete("menuManageDAO.deleteMenuManage_S", vo);
	}

	
	/**
	 * 메뉴번호 존재여부를 조회
	 * @param vo MenuManageVO 
	 * @return int 
	 * @exception Exception
	 */
	public int selectMenuNoByPk(MenuManageVO vo) throws Exception{
		return (Integer)selectByPk("menuManageDAO.selectMenuNoByPk", vo);  
	}
	
	/*********** 메뉴 생성 관리 ***************/
	/**
	 * 메뉴생성 내역을 조회
	 * @param vo MenuCreatVO
	 * @return List 
	 * @exception Exception
	 */
	public List selectMenuCreatList(MenuCreatVO vo) throws Exception{
		return list("menuManageDAO.selectMenuCreatList_D", vo);
	}

	/**
	 * ID에 대한 권한코드를 조회
	 * @param vo MenuCreatVO
	 * @return int 	 
	 * @exception Exception
	 */
	public MenuCreatVO selectAuthorByUsr(ComDefaultVO vo) throws Exception{
		return (MenuCreatVO)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectAuthorByUsr", vo);
	}

	/**
	 * ID 존재여부를 조회
	 * @param vo MenuManageVO 
	 * @return int 
	 * @exception Exception
	 */
	public int selectUsrByPk(ComDefaultVO vo) throws Exception{
		return (Integer)selectByPk("menuManageDAO.selectUsrByPk", vo);  
	}
	
	/**
	 * 메뉴생성내역 등록
	 * @param vo MenuCreatVO
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void insertMenuCreat(MenuCreatVO vo){
		insert("menuManageDAO.insertMenuCreat_S", vo);
	}

	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void insertDeptMenuCreat(ZValue zvl){
		insert("menuManageDAO.insertDeptMenuCreat_S", zvl);
	}

    /**
	 * 메뉴생성내역 존재여부 조회한다.
	 * @param vo MenuCreatVO
	 * @return int 
	 * @exception Exception
	 */
    public int selectMenuCreatCnt(MenuCreatVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectMenuCreatCnt_S", vo);
    }
	

	/**
	 * 메뉴생성내역 수정
	 * @param vo MenuCreatVO
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void updateMenuCreat(MenuCreatVO vo){
		update("menuManageDAO.updateMenuCreat_S", vo);
	}


	/**
	 * 메뉴생성내역 삭제
	 * @param vo MenuCreatVO
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void deleteMenuCreat(MenuCreatVO vo){
		delete("menuManageDAO.deleteMenuCreat_S", vo);
	}	

	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void deleteDeptMenuCreat(ZValue zvl){
		delete("menuManageDAO.deleteDeptMenuCreat_S", zvl);
	}	

	/**
	 * 메뉴생성관리 내역을 조회
	 * @param vo ComDefaultVO 
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatManagList(ComDefaultVO vo) throws Exception{
		return list("menuManageDAO.selectMenuCreatManageList_D", vo);
	}

    /**
	 * 메뉴생성관리 총건수를 조회한다.
	 * @param vo ComDefaultVO 
	 * @return int 
	 * @exception Exception
	 */
    public int selectMenuCreatManagTotCnt(ComDefaultVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectMenuCreatManageTotCnt_S", vo);
    }

	/**
	 * 메뉴생성 사이트맵 내용 조회
	 * @param vo MenuSiteMapVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatSiteMapList(MenuSiteMapVO vo) throws Exception{
		return list("menuManageDAO.selectMenuCreatSiteMapList_D", vo);
	}

	/**
	 * 사이트맵 등록
	 * @param vo MenuSiteMapVO
	 * @exception Exception
	 */
	public void creatSiteMap(MenuSiteMapVO vo){
		insert("menuManageDAO.insertSiteMap_S", vo);
	}
	
    /**
	 * 사이트맵 존재여부 조회한다.
	 * @param vo MenuSiteMapVO
	 * @return int 
	 * @exception Exception
	 */
    public int selectSiteMapCnt(MenuSiteMapVO vo) {
        return (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectSiteMapCnt_S", vo);
    }

	/**
	 * 메뉴정보 전체삭제 초기화
	 * @return boolean
	 * @exception Exception
	 */
	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public boolean deleteAllMenuList(){
		MenuManageVO vo = new MenuManageVO();
		insert("menuManageDAO.deleteAllMenuList", vo);
		return true;
	}

    /**
	 * 메뉴정보 존재여부 조회한다.
	 * @return int
	 * @exception Exception
	 */
    public int selectMenuListTotCnt() {
    	MenuManageVO vo = new MenuManageVO();
        return (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectMenuListTotCnt", vo);
    }
	
    
	/*### 메뉴관련 프로세스 ###*/
	/**
	 * MainMenu Head Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMainMenuHead(MenuManageVO vo) throws Exception{
		return list("menuManageDAO.selectMainMenuHead", vo);
	}    

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMainMenuLeft(MenuManageVO vo) throws Exception{
		return list("menuManageDAO.selectMainMenuLeft", vo);
	} 

	/**
	 * MainMenu Head MenuURL 조회
	 * @param vo MenuManageVO
	 * @return  String
	 * @exception Exception
	 */
	public String selectLastMenuURL(MenuManageVO vo) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectLastMenuURL", vo);
	} 
	
	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return int 	 
	 * @exception Exception
	 */
	public int selectLastMenuNo(MenuManageVO vo) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectLastMenuNo", vo);
	}
	
	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return int 	 
	 * @exception Exception
	 */
	public int selectLastMenuNoCnt(MenuManageVO vo) throws Exception{
		return (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectLastMenuNoCnt", vo);
	} 	
	

	public List<MenuManageVO> selectAllMenuBySiteId(MenuManageVO vo) throws Exception{
		return (List<MenuManageVO>)list("menuManageDAO.selectAllMenuBySiteId", vo);
	} 
	
	@Cacheable(value=MENU_CACHE_NAME)
	public List<MenuManageVO> selectAllMenu() throws Exception{
		return (List<MenuManageVO>)list("menuManageDAO.selectAllMenu", null);
	} 

	public List selectAuthoMenuList(ZValue zvl) throws Exception{	
		return list("menuManageDAO.selectAuthoMenuList", zvl);
	}

	public List selectAuthoAdminDeptMenuListByUserId(String userId) throws Exception{	
		return list("menuManageDAO.selectAuthoAdminDeptMenuListByUserId", userId);
	}

	public List selectAuthoMenuListByAuthorities(ZValue zvl) throws Exception{	
		return list("menuManageDAO.selectAuthoMenuListByAuthorities", zvl);
	}

	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void rearrangeMenu(MenuManageVO vo) throws Exception{	
		update("menuManageDAO.rearrangeMenu", vo);
	}

	@CacheEvict(value=MENU_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void rearrangeMenu2(MenuManageVO vo) throws Exception{	
		update("menuManageDAO.rearrangeMenu2", vo);
	}

	public String selectContentsPathByMenuNo(int menuNo) throws Exception{
		return (String)getSqlMapClientTemplate().queryForObject("menuManageDAO.selectContentsPathByMenuNo", menuNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> menuLinkSearch(ZValue zvl) throws Exception{
		List<ZValue> resultList = null;
		
		if (zvl.getString("searchType").equals("c1")){
			resultList = (List<ZValue>)list("menuManageDAO.menuLinkSearchC1", zvl);
		} else if (zvl.getString("searchType").equals("c2")){
			resultList = (List<ZValue>)list("menuManageDAO.menuLinkSearchC2", zvl);
		} else if (zvl.getString("searchType").equals("c3")){
			resultList = (List<ZValue>)list("menuManageDAO.menuLinkSearchC3", zvl);
		}
		
		return resultList;
	}
	
	public int menuLinkSearchCnt(ZValue zvl) throws Exception{
		int resultcnt = 0;
		
		if (zvl.getString("searchType").equals("c1")){
			resultcnt = (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.menuLinkSearchC1Cnt", zvl);
		} else if (zvl.getString("searchType").equals("c2")){
			resultcnt = (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.menuLinkSearchC2Cnt", zvl);
		} else if (zvl.getString("searchType").equals("c3")){
			resultcnt = (Integer)getSqlMapClientTemplate().queryForObject("menuManageDAO.menuLinkSearchC3Cnt", zvl);
		}
		
		return resultcnt;
	}
	
	public List selectMenuByGlobal(ZValue zvl) throws Exception{
		return list("menuManageDAO.selectMenuByGlobal", zvl);
	}
	
	public ZValue selectMenuByContents(ZValue zvl) throws Exception{
		 return (ZValue)selectByPk("menuManageDAO.selectMenuByContents", zvl); 
	}

	public void setModifyDayToToday(int menuNo) throws Exception{	
		update("menuManageDAO.setModifyDayToToday", menuNo);
	}

	
}