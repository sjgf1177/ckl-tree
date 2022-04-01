package kr.co.unp.cmmncode.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgry;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgryVO;
import kr.co.unp.util.ZValue;

/**
 *
 * 공통코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("CmmnCodeCtgryDAO")
public class CmmnCodeCtgryDAO extends EgovAbstractDAO {

	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCodeCtgry
	 * @throws Exception
	 */
	public void deleteCmmnCodeCtgry(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
		delete("CmmnCodeCtgryDAO.deleteCmmnCodeCtgry", cmmnCodeCtgry);
	}


	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCodeCtgry
	 * @throws Exception
	 */
	public void insertCmmnCodeCtgry(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
        insert("CmmnCodeCtgryDAO.insertCmmnCodeCtgry", cmmnCodeCtgry);
	}


	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCodeCtgry
	 * @return CmmnCode(공통코드)
	 */
	public CmmnCodeCtgry selectCmmnCodeCtgryDetail(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
		return (CmmnCodeCtgry)selectByPk("CmmnCodeCtgryDAO.selectCmmnCodeCtgryDetail", cmmnCodeCtgry);
	}


    /**
	 * 공통코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통코드 목록)
     * @throws Exception
     */
    public List selectCmmnCodeCtgryList(CmmnCodeCtgryVO searchVO) throws Exception {
        return list("CmmnCodeCtgryDAO.selectCmmnCodeCtgryList", searchVO);
    }

    /**
	 * 공통코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통코드 총 갯수)
     */
    public int selectCmmnCodeCtgryListTotCnt(CmmnCodeCtgryVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("CmmnCodeCtgryDAO.selectCmmnCodeCtgryListTotCnt", searchVO);
    }

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCodeCtgry
	 * @throws Exception
	 */
	public void updateCmmnCodeCtgry(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
		update("CmmnCodeCtgryDAO.updateCmmnCodeCtgry", cmmnCodeCtgry);
	}

}
