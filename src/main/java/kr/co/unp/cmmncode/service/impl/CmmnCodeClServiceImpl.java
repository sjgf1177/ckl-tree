package kr.co.unp.cmmncode.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import kr.co.unp.cmmncode.dao.CmmnCodeClDAO;
import kr.co.unp.cmmncode.service.CmmnCodeClService;
import kr.co.unp.cmmncode.vo.CmmnCodeCl;
import kr.co.unp.cmmncode.vo.CmmnCodeClVO;



/**
 * 
 * 공통분류코드에 대한 서비스 구현클래스를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
@Service("CmmnCodeClService")
public class CmmnCodeClServiceImpl extends EgovAbstractServiceImpl implements CmmnCodeClService {

    @Resource(name="CmmnCodeClDAO")
    private CmmnCodeClDAO cmmnCodeClDAO;
    
	/**
	 * 공통분류코드를 삭제한다.
	 */
	public void deleteCmmnCodeCl(CmmnCodeCl cmmnCodeCl) throws Exception {
		cmmnCodeClDAO.deleteCmmnCodeCl(cmmnCodeCl);
	}

	/**
	 * 공통분류코드를 등록한다.
	 */
	public void insertCmmnCodeCl(CmmnCodeCl cmmnCodeCl) throws Exception {
    	cmmnCodeClDAO.insertCmmnCodeCl(cmmnCodeCl);    	
	}

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 */
	public CmmnCodeCl selectCmmnCodeClDetail(CmmnCodeCl cmmnCodeCl) throws Exception {
    	CmmnCodeCl ret = (CmmnCodeCl)cmmnCodeClDAO.selectCmmnCodeClDetail(cmmnCodeCl);
    	return ret;
	}

	/**
	 * 공통분류코드 목록을 조회한다.
	 */
	public List selectCmmnCodeClList(CmmnCodeClVO searchVO) throws Exception {
        return cmmnCodeClDAO.selectCmmnCodeClList(searchVO);
	}

	/**
	 * 공통분류코드 총 갯수를 조회한다.
	 */
	public int selectCmmnCodeClListTotCnt(CmmnCodeClVO searchVO) throws Exception {
        return cmmnCodeClDAO.selectCmmnCodeClListTotCnt(searchVO);
	}

	/**
	 * 공통분류코드를 수정한다.
	 */
	public void updateCmmnCodeCl(CmmnCodeCl cmmnCodeCl) throws Exception {
		cmmnCodeClDAO.updateCmmnCodeCl(cmmnCodeCl);
	}
	
	/**
	 * COM080의 맥스값을 구한다
	 */
	public int selectCOM080Max() throws Exception {
        return cmmnCodeClDAO.selectCOM080Max();
	}

}
