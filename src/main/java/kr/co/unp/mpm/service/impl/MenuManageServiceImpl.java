package kr.co.unp.mpm.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.unp.mpm.vo.MenuCreatVO;
import kr.co.unp.mpm.dao.MenuManageDAO;
import kr.co.unp.mpm.dao.ProgrmManageDAO;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.mpm.service.MenuManageService;
import kr.co.unp.mpm.vo.MenuSiteMapVO;
import kr.co.unp.mpm.vo.ProgrmManageVO;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 메뉴목록관리, 생성, 사이트맵을 처리하는 비즈니스 구현 클래스를 정의한다.
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

@Service("meunManageService")
public class MenuManageServiceImpl extends EgovAbstractServiceImpl implements MenuManageService{

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name="menuManageDAO")
    private MenuManageDAO menuManageDAO;
	@Resource(name="progrmManageDAO")
    private ProgrmManageDAO progrmManageDAO;

	@Resource(name = "multipartResolver")
	CommonsMultipartResolver mailmultipartResolver;

	/**
	 * 메뉴 상세정보를 조회
	 * @param vo ComDefaultVO
	 * @return MenuManageVO
	 * @exception Exception
	 */
	public MenuManageVO selectMenuManage(ComDefaultVO vo) throws Exception{
        return menuManageDAO.selectMenuManage(vo);
	}


	/**
	 * 메뉴번호 존재 여부를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectMenuNoByPk(MenuManageVO vo) throws Exception {
        return menuManageDAO.selectMenuNoByPk(vo);
	}

	/**
	 * 메뉴 정보를 등록
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void insertMenuManage(MenuManageVO vo) throws Exception {
		menuManageDAO.insertMenuManage(vo);
	}

	/**
	 * 메뉴 정보를 수정
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void updateMenuManage(MenuManageVO vo) throws Exception {
		menuManageDAO.updateMenuManage(vo);
	}


	/**
	 * 메뉴 정보를 삭제
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void deleteMenuManage(MenuManageVO vo) throws Exception {
		menuManageDAO.deleteMenuManage(vo);
	}

	/**
	 * 화면에 조회된 메뉴 목록 정보를 데이터베이스에서 삭제
	 * @param checkedMenuNoForDel String
	 * @exception Exception
	 */
	public void deleteMenuManageList(String checkedMenuNoForDel) throws Exception {
		MenuManageVO vo = null;

		String [] delMenuNo = checkedMenuNoForDel.split(",");

		if (delMenuNo == null || (delMenuNo.length ==0)){ throw new Exception("String Split Error!"); }
        for (int i=0; i<delMenuNo.length ; i++){
			vo = new MenuManageVO();
			vo.setMenuNo(Integer.parseInt(delMenuNo[i]));
			menuManageDAO.deleteMenuManage(vo);
		}
	}


	/*  메뉴 생성 관리  */


	/**
	 * 메뉴생성 내역을 조회
	 * @param  vo MenuCreatVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatList(MenuCreatVO vo) throws Exception {
   		return menuManageDAO.selectMenuCreatList(vo);
	}

	/**
	 * 화면에 조회된 메뉴정보로 메뉴생성내역 데이터베이스에서 입력
	 * @param checkedAuthorForInsert  String
	 * @param checkedMenuNoForInsert String
	 * @exception Exception
	 */
	public void insertMenuCreatList(
			String checkedAuthorForInsert,
			String checkedMenuNoForInsert
			) throws Exception{
		MenuCreatVO menuCreatVO = new MenuCreatVO();
		menuCreatVO.setAuthorCode(checkedAuthorForInsert);
		menuManageDAO.deleteMenuCreat(menuCreatVO);

		if( StringUtils.hasText(checkedMenuNoForInsert) ){
			log.debug("###############checkedMenuNoForInsert : " + checkedMenuNoForInsert);

			String [] insertMenuNo = checkedMenuNoForInsert.split(",");
			log.debug("###############insertMenuNo.length : " + insertMenuNo.length);
			for (int i=0; i<insertMenuNo.length ; i++){
				if(!"".equals(insertMenuNo[i]))
				{
					menuCreatVO.setMenuNo(Integer.parseInt(insertMenuNo[i]));
					menuManageDAO.insertMenuCreat(menuCreatVO);
				}
			}
		}
	}

	public void insertDeptMenuCreatList(ZValue zvl) throws Exception
	{
		String checkedMenuNoForInsert = zvl.getString("checkedMenuNoForInsert");
		String checkedAuthorForInsert = zvl.getString("checkedAuthorForInsert");
		String mapcreatId = zvl.getString("mapcreatId");
		MenuCreatVO menuCreatVO = null;
		String [] insertMenuNo = checkedMenuNoForInsert.split(",");

		String     insertAuthor = checkedAuthorForInsert;
		menuCreatVO = new MenuCreatVO();
		menuCreatVO.setAuthorCode(insertAuthor);

		for (int i=0; i<insertMenuNo.length ; i++){
			if(!"".equals(insertMenuNo[i]))
			{
				log.debug("###############insertMenuNo[i] : [" + insertMenuNo[i] + "]");
				ZValue param = new ZValue();
				param.put("authorCode", insertAuthor);
				param.put("menuNo", insertMenuNo[i]);
				param.put("mapcreatId", mapcreatId);
				menuManageDAO.insertDeptMenuCreat(param);
			}
		}
	}

	/**
	 * 메뉴생성관리 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatManagList(ComDefaultVO vo) throws Exception {
   		return menuManageDAO.selectMenuCreatManagList(vo);
	}

	/**
	 * ID에 대한 권한코드를 조회
	 * @param vo ComDefaultVO
	 * @return MenuCreatVO
	 * @exception Exception
	 */
	public MenuCreatVO selectAuthorByUsr(ComDefaultVO vo) throws Exception{
        return menuManageDAO.selectAuthorByUsr(vo);
	}

	/**
	 * ID 존재여부를 조회
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectUsrByPk(ComDefaultVO vo) throws Exception {
        return menuManageDAO.selectUsrByPk(vo);
	}


	/**
	 * 메뉴생성관리 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectMenuCreatManagTotCnt(ComDefaultVO vo) throws Exception {
        return menuManageDAO.selectMenuCreatManagTotCnt(vo);
	}

	/**
	 * 메뉴생성 사이트맵 내용 조회
	 * @param vo MenuSiteMapVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMenuCreatSiteMapList(MenuSiteMapVO vo) throws Exception {
   		return menuManageDAO.selectMenuCreatSiteMapList(vo);
	}

	/**
	 * 사이트맵 등록
	 * @param menuSiteMapvo MenuSiteMapVO
	 * @param vHtmlValue   String
	 * @return boolean
	 * @exception Exception
	 */
	public boolean creatSiteMap(MenuSiteMapVO menuSiteMapvo, String vHtmlValue ) throws Exception {
		boolean chkCreat     = false;
		String  vSiteMapName = null;
		int     SiteMapCnt   = 0;
		String  newMapCreatId = null;
		MenuCreatVO menuCreatVO = new MenuCreatVO();

		menuCreatVO.setMenuNo(menuSiteMapvo.getMenuNo());
		menuCreatVO.setAuthorCode(menuSiteMapvo.getAuthorCode());
//		vSiteMapName  = menuSiteMapvo.getTmp_rootPath()+"/"+menuSiteMapvo.getBndeFileNm();
		vSiteMapName  = menuSiteMapvo.getTmp_rootPath()+menuSiteMapvo.getBndeFilePath()+menuSiteMapvo.getBndeFileNm();
		chkCreat = siteMapCreat(vSiteMapName,vHtmlValue);
		if(chkCreat){
			SiteMapCnt = menuManageDAO.selectSiteMapCnt(menuSiteMapvo);
			if(SiteMapCnt>0){
				menuCreatVO.setMapCreatId(menuSiteMapvo.getMapCreatId() + Integer.toString(SiteMapCnt));
				menuSiteMapvo.setMapCreatId(menuSiteMapvo.getMapCreatId() + Integer.toString(SiteMapCnt));
			}else{
				menuCreatVO.setMapCreatId(menuSiteMapvo.getMapCreatId());
			}
   			menuManageDAO.updateMenuCreat(menuCreatVO);
			menuManageDAO.creatSiteMap(menuSiteMapvo);
		}
		return chkCreat;
	}

	/**
	 * 메뉴생성 사이트맵 Html 파일 생성
	 * @param vSiteMapName String
	 * @param vHtmlValue   String
	 * @return boolean
	 * @exception Exception
	 */
	private boolean siteMapCreat(String vSiteMapName, String vHtmlValue)throws Exception{
		boolean success = false;
	    String FileName = null;
	    BufferedWriter out = null;
	    char FILE_SEPARATOR     = File.separatorChar;
	    FileWriter fw =null;
		try {
			FileName = vSiteMapName.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
			File file = new File(FileName);
			fw = new FileWriter(file);
			out = new BufferedWriter(fw);
			out.write(vHtmlValue);
 			success = true;
		} catch (IOException e) {
	        e.printStackTrace();
		} finally {
			try { if (out!=null) {out.flush(); out.close();} } catch (Exception e2) { e2.printStackTrace();}
			try { if (fw!=null) {fw.flush(); fw.close();} } catch (Exception e2) { e2.printStackTrace();}
		}
		return  success ;
	}

	/*### 메뉴관련 프로세스 ###*/
	/**
	 * MainMenu Head Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMainMenuHead(MenuManageVO vo) throws Exception {
   		return menuManageDAO.selectMainMenuHead(vo);
	}

	/**
	 * MainMenu Head Left 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List selectMainMenuLeft(MenuManageVO vo) throws Exception {
   		return menuManageDAO.selectMainMenuLeft(vo);
	}

	/**
	 * MainMenu Head MenuURL 조회
	 * @param  iMenuNo  int
	 * @param  sUniqId  String
	 * @return String
	 * @exception Exception
	 */
	public String selectLastMenuURL(int iMenuNo, String sUniqId) throws Exception {
		MenuManageVO vo = new MenuManageVO();
		vo.setMenuNo(selectLastMenuNo(iMenuNo, sUniqId)) ;
   		return menuManageDAO.selectLastMenuURL(vo);
	}

	/**
	 * MainMenu Head Menu MenuNo 조회
	 * @param  iMenuNo  int
	 * @param  sUniqId  String
	 * @return String
	 * @exception Exception
	 */
	private int selectLastMenuNo(int iMenuNo, String sUniqId) throws Exception {
		int chkMenuNo = iMenuNo;
		int cntMenuNo = 0;
		for(;chkMenuNo > -1;){
			chkMenuNo = selectLastMenuNoChk(chkMenuNo, sUniqId);
			if(chkMenuNo > 0){
				cntMenuNo = chkMenuNo;
			}
		}
   		return cntMenuNo;
	}

	/**
	 * MainMenu Head Menu Last MenuNo 조회
	 * @param  iMenuNo  int
	 * @param  sUniqId  String
	 * @return String
	 * @exception Exception
	 */
	private int selectLastMenuNoChk(int iMenuNo, String sUniqId) throws Exception {
		MenuManageVO vo = new MenuManageVO();
		vo.setMenuNo(iMenuNo);
		vo.setTempValue(sUniqId) ;
		int chkMenuNo = 0;
		int cntMenuNo = 0;
		cntMenuNo = menuManageDAO.selectLastMenuNoCnt(vo);
		if(cntMenuNo>0){
			chkMenuNo = menuManageDAO.selectLastMenuNo(vo);
		}else{
			chkMenuNo = -1;
		}
		return  chkMenuNo;
	}

/*### 일괄처리 프로세스 ###*/
	/**
	 * 메뉴일괄초기화 프로세스 메뉴목록테이블, 프로그램 목록테이블 전체 삭제
	 * @return boolean
	 * @exception Exception
	 */
	public boolean menuBndeAllDelete() throws Exception {
       	if(!deleteAllProgrmDtls()){return false;} // 프로그램변경요청 테이블
       	if(!deleteAllMenuList()){return false;}   // 메뉴정보 테이블
       	if(!deleteAllProgrm()){return false;}     // 프로그램목록 테이블
       	return true;
	}

	/**
	 * 메뉴일괄등록 프로세스
	 * @param  vo MenuManageVO
	 * @param  inputStream InputStream
	 * @exception Exception
	 */
	public String menuBndeRegist(MenuManageVO vo, InputStream inputStream) throws Exception {

	   //String message = bndeRegist(inputStream);
		String message = "2013.5.3 김우정 임시";
	   String sMessage = null;

	   switch(Integer.parseInt(message))
	   {
	    case 99:
	    	log.debug("프로그램목록/메뉴정보테이블 데이타 존재오류 - 초기화 하신 후 다시 처리하세요.");
	    	sMessage = "프로그램목록/메뉴정보테이블 데이타 존재오류 - 초기화 하신 후 다시 처리하세요.";
	     break;
	    case 90:
	    	log.debug("파일존재하지 않음.");
	    	sMessage = "파일존재하지 않음.";
	     break;
	    case 91:
	    	log.debug("프로그램시트의 cell 갯수 오류.");
	    	sMessage = "프로그램시트의 cell 갯수 오류.";
	     break;
	    case 92:
	    	log.debug("메뉴정보시트의 cell 갯수 오류.");
	    	sMessage = "메뉴정보시트의 cell 갯수 오류.";
	     break;
	    case 93:
	    	log.debug("엑셀 시트갯수 오류.");
	    	sMessage = "엑셀 시트갯수 오류.";
	     break;
	    case 95:
	    	log.debug("메뉴정보 입력시 에러.");
	    	sMessage = "메뉴정보 입력시 에러.";
	     break;
	    case 96:
	    	log.debug("프로그램목록입력시 에러.");
	    	sMessage = "프로그램목록입력시 에러.";
	     break;
	    default:
	    	log.debug("일괄배치처리 완료.");
	    sMessage = "일괄배치처리 완료.";
	     break;
	   }
	   log.debug(message);
	   return sMessage;
	}

	/**
	 * 프로그램목록 일괄등록
	 * @param  progrmSheet HSSFSheet
	 * @return  boolean
	 * @exception Exception
	 */
	private boolean progrmRegist(HSSFSheet progrmSheet)throws Exception{
        int count=0;
		boolean success = false;
		try {
            int rows=progrmSheet.getPhysicalNumberOfRows(); //행 갯수 가져오기
            for(int j=1; j<rows; j++){ //row 루프
            	ProgrmManageVO vo = new ProgrmManageVO();
                HSSFRow row=progrmSheet.getRow(j); //row 가져오기
                if(row!=null){
                    int cells=row.getPhysicalNumberOfCells(); //cell 갯수 가져오기

                    HSSFCell cell = null;
                	cell = row.getCell(0);  //프로그램명
                	if(cell!=null){
                       vo.setProgrmFileNm(""+cell.getStringCellValue());
                	}
                    cell = row.getCell(1); //프로그램한글명
                    if(cell!=null){
                       vo.setProgrmKoreanNm(""+cell.getStringCellValue());
                	}
                    cell = row.getCell(2); //프로그램저장경로
                    if(cell!=null){
                        vo.setProgrmStrePath(""+cell.getStringCellValue());
                    }
                    cell = row.getCell(3); //프로그램 URL
                    if(cell!=null){
                        vo.setURL(""+cell.getStringCellValue());
                    }
                    cell = row.getCell(4); //프로그램설명
                    if(cell!=null){
                        vo.setProgrmDc(""+cell.getStringCellValue());
                    }
                }
                if(insertProgrm(vo)){count++;}
            }
            if(count==rows-1){
                success = true;
            }else{
            	success = false;
            }
		}catch(Exception e){
           e.printStackTrace();
        }
		return success;
	}

	/**
	 * 메뉴정보 일괄등록
	 * @param menuSheet HSSFSheet
	 * @return boolean
	 * @exception Exception
	 */
	private boolean menuRegist(HSSFSheet menuSheet)throws Exception{
		boolean success = false;
		int count=0;
		try {
            int rows=menuSheet.getPhysicalNumberOfRows(); //행 갯수 가져오기
            for(int j=1; j<rows; j++){ //row 루프
            	MenuManageVO vo = new MenuManageVO();
                HSSFRow row=menuSheet.getRow(j); //row 가져오기
                if(row!=null){
                    int cells=row.getPhysicalNumberOfCells(); //cell 갯수 가져오기
                    HSSFCell cell = null;
                	cell = row.getCell(0);  //메뉴번호
                	if(cell!=null){
                		Double doubleCell = new Double(cell.getNumericCellValue());
                        vo.setMenuNo(Integer.parseInt(""+doubleCell.longValue()));
                	}
                    cell = row.getCell(1); //메뉴순서
                    if(cell!=null){
                		Double doubleCell = new Double(cell.getNumericCellValue());
                        vo.setMenuOrdr(Integer.parseInt(""+doubleCell.longValue()));
                	}
                    cell = row.getCell(2); //메뉴명
                    if(cell!=null){
                        vo.setMenuNm(""+cell.getStringCellValue());
                    }
                    cell = row.getCell(3); //상위메뉴번호
                    if(cell!=null){
                		Double doubleCell = new Double(cell.getNumericCellValue());
                        vo.setUpperMenuId(Integer.parseInt(""+doubleCell.longValue()));
                    }
                    cell = row.getCell(4); //메뉴설명
                    if(cell!=null){
                        vo.setMenuDc(""+cell.getStringCellValue());
                    }
                    cell = row.getCell(5); //관련이미지경로
                    if(cell!=null){
                        vo.setRelateImagePath(""+cell.getStringCellValue());
                    }
                    cell = row.getCell(6); //관련이미지명
                    if(cell!=null){
                        vo.setRelateImageNm(""+cell.getStringCellValue());
                    }
                    cell = row.getCell(7); //프로그램파일명
                    if(cell!=null){
                        vo.setProgrmFileNm(""+cell.getStringCellValue());
                    }
                }
                if(insertMenuManageBind(vo)){count++;}
            }
            if(count==rows-1){
                success = true;
            }else{
            	success = false;
            }
		}catch(Exception e){
           e.printStackTrace();
        }
		return success;
	}

	/**
	 * 메뉴정보 전체데이타 초기화
	 * @return boolean
	 * @exception Exception
	 */
	private boolean deleteAllMenuList() throws Exception {
		return menuManageDAO.deleteAllMenuList();
	}

	/**
	 * 프로그램 정보를 등록
	 * @param  vo ProgrmManageVO
	 * @return boolean
	 * @exception Exception
	 */
	private boolean insertProgrm(ProgrmManageVO vo) throws Exception {
		progrmManageDAO.insertProgrm(vo);
    	return true;
	}

	/**
	 * 메뉴정보를 일괄 등록
	 * @param  vo MenuManageVO
	 * @return boolean
	 * @exception Exception
	 */
	private boolean insertMenuManageBind(MenuManageVO vo) throws Exception {
		menuManageDAO.insertMenuManage(vo);
    	return true;
	}

	/**
	 * 프로그램 정보 전체데이타 초기화
	 * @return boolean
	 * @exception Exception
	 */
	private boolean deleteAllProgrm() throws Exception {
		progrmManageDAO.deleteAllProgrm();
		return true;
	}

	/**
	 * 프로그램변경내역 정보 전체데이타 초기화
	 * @return boolean
	 * @exception Exception
	 */
	private boolean deleteAllProgrmDtls() throws Exception {
		progrmManageDAO.deleteAllProgrmDtls();
		return  true;
	}

	public List selectAllMenuBySiteId(String siteId) throws Exception{
		MenuManageVO vo = new MenuManageVO();
		vo.setSiteId(siteId);
		return menuManageDAO.selectAllMenuBySiteId(vo);
	}

	public List selectAuthoMenuList(ZValue zvl) throws Exception{
		return menuManageDAO.selectAuthoMenuList(zvl);
	}


	public List selectAuthoAdminDeptMenuListByUserId(String userId) throws Exception{
		return menuManageDAO.selectAuthoAdminDeptMenuListByUserId(userId);
	}

	public List selectAuthoMenuListByAuthorities(ZValue zvl) throws Exception{
		return menuManageDAO.selectAuthoMenuListByAuthorities(zvl);
	}

	public void rearrangeMenu(HashMap map) throws Exception
	{
		Iterator it = map.keySet().iterator();
		ArrayList<MenuManageVO> menuList = null;
		String key = null;
		while(it.hasNext())
		{
			key = (String)it.next();
			menuList = (ArrayList)map.get(key);
			for(MenuManageVO vo : menuList)
				menuManageDAO.rearrangeMenu(vo);
		}
	}

	public String selectContentsPathByMenuNo(int menuNo) throws Exception{
		return menuManageDAO.selectContentsPathByMenuNo(menuNo);
	}

	public List<ZValue> menuLinkSearch(ZValue zvl) throws Exception{
		return menuManageDAO.menuLinkSearch(zvl);
	}

	public int menuLinkSearchCnt(ZValue zvl) throws Exception{
		return menuManageDAO.menuLinkSearchCnt(zvl);
	}

	public List selectMenuByGlobal(ZValue zvl) throws Exception{
		return menuManageDAO.selectMenuByGlobal(zvl);
	}

	public ZValue selectMenuByContents(ZValue zvl) throws Exception {
		return menuManageDAO.selectMenuByContents(zvl);
	}

}