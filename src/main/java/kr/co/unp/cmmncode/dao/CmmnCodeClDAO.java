package kr.co.unp.cmmncode.dao;

import java.util.List;


import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import kr.co.unp.cmmncode.vo.CmmnCodeCl;
import kr.co.unp.cmmncode.vo.CmmnCodeClVO;

/**
 * 
 * 공통분류코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("CmmnCodeClDAO")
public class CmmnCodeClDAO extends EgovAbstractDAO {

	/**
	 * 공통분류코드를 삭제한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	public void deleteCmmnCodeCl(CmmnCodeCl cmmnClCode) throws Exception {
		delete("CmmnCodeClDAO.deleteCmmnCodeCl", cmmnClCode);
	}


	/**
	 * 공통분류코드를 등록한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	public void insertCmmnCodeCl(CmmnCodeCl cmmnClCode) throws Exception {
        insert("CmmnCodeClDAO.insertCmmnCodeCl", cmmnClCode);
	}

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * @param cmmnClCode
	 * @return CmmnCodeCl(공통분류코드)
	 */
	public CmmnCodeCl selectCmmnCodeClDetail(CmmnCodeCl cmmnClCode) throws Exception {
		return (CmmnCodeCl)selectByPk("CmmnCodeClDAO.selectCmmnCodeClDetail", cmmnClCode);
	}


    /**
	 * 공통분류코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통분류코드 목록)
     * @throws Exception
     */
    public List selectCmmnCodeClList(CmmnCodeClVO searchVO) throws Exception {
        return list("CmmnCodeClDAO.selectCmmnCodeClList", searchVO);
    }

    /**
	 * 공통분류코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통분류코드 총 갯수)
     */
    public int selectCmmnCodeClListTotCnt(CmmnCodeClVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("CmmnCodeClDAO.selectCmmnCodeClListTotCnt", searchVO);
    }

	/**
	 * 공통분류코드를 수정한다.
	 * @param cmmnClCode
	 * @throws Exception
	 */
	public void updateCmmnCodeCl(CmmnCodeCl cmmnClCode) throws Exception {
		update("CmmnCodeClDAO.updateCmmnCodeCl", cmmnClCode);
	}
	
	/**
	 * 공통분류코드COM080의 맥스값을 구한다
     * @return int(공통분류코드 총 갯수)
     */
    public int selectCOM080Max() throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("CmmnCodeClDAO.selectCOM080CodeListMax");
    }
	
}
