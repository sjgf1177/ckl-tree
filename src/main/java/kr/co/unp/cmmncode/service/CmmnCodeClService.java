package kr.co.unp.cmmncode.service;

import java.util.List;
import java.util.Map;

import kr.co.unp.cmmncode.vo.CmmnCodeCl;
import kr.co.unp.cmmncode.vo.CmmnCodeClVO;

/**
 * 
 * 공통분류코드에 관한 서비스 인터페이스 클래스를 정의한다
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
public interface CmmnCodeClService {
	    
	/**
	 * 공통분류코드를 삭제한다.
	 * @param cmmnCodeCl
	 * @throws Exception
	 */
	void deleteCmmnCodeCl(CmmnCodeCl cmmnCodeCl) throws Exception;

	/**
	 * 공통분류코드를 등록한다.
	 * @param cmmnCodeCl
	 * @throws Exception
	 */
	void insertCmmnCodeCl(CmmnCodeCl cmmnCodeCl) throws Exception;

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * @param cmmnCodeCl
	 * @return CmmnCodeCl(공통분류코드)
	 * @throws Exception
	 */
	 CmmnCodeCl selectCmmnCodeClDetail(CmmnCodeCl cmmnCodeCl) throws Exception;
	
	/**
	 * 공통분류코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통분류코드 목록)
	 * @throws Exception
	 */
	List selectCmmnCodeClList(CmmnCodeClVO searchVO) throws Exception;

    /**
	 * 공통분류코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통분류코드 총 갯수)
     */
    int selectCmmnCodeClListTotCnt(CmmnCodeClVO searchVO) throws Exception;
	
	/**
	 * 공통분류코드를 수정한다.
	 * @param cmmnCodeCl
	 * @throws Exception
	 */
	void updateCmmnCodeCl(CmmnCodeCl cmmnCodeCl) throws Exception;

	/**
	 * 공통분류코드 COM080의 맥스값을 리턴한다.
     * @return int(공통분류코드 총 갯수)
     */
    int selectCOM080Max() throws Exception;
	
    
}
