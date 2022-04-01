package kr.co.unp.cmmncode.service;

import java.util.List;

import kr.co.unp.cmmncode.vo.CmmnCodeDetail;
import kr.co.unp.cmmncode.vo.CmmnCodeDetailVO;
import kr.co.unp.util.ZValue;

/**
 *
 * 공통상세코드에 관한 서비스 인터페이스 클래스를 정의한다
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
public interface CmmnCodeDetailService {

	/**
	 * 공통상세코드를 삭제한다.
	 * @param cmmnCodeDetail
	 * @throws Exception
	 */
	void deleteCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception;

	/**
	 * 공통상세코드를 등록한다.
	 * @param cmmnCodeDetail
	 * @throws Exception
	 */
	void insertCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception;

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param cmmnCodeDetail
	 * @return CmmnCodeDetail(공통상세코드)
	 * @throws Exception
	 */
	CmmnCodeDetail selectCmmnCodeDetailDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception;

	/**
	 * 공통상세코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통상세코드 목록)
	 * @throws Exception
	 */
	List selectCmmnCodeDetailList(CmmnCodeDetailVO searchVO) throws Exception;

    /**
	 * 공통상세코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통상세코드 총 갯수)
     */
    int selectCmmnCodeDetailListTotCnt(CmmnCodeDetailVO searchVO) throws Exception;

	/**
	 * 공통상세코드를 수정한다.
	 * @param cmmnCodeDetail
	 * @throws Exception
	 */
	void updateCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception;

	/**
	 * 공통상세코드 리스트를 반환한다.
	 * @param zvl
	 * @throws Exception
	 */
	List<ZValue> getDetailCodeList(ZValue zvl) throws Exception;

	/**
	 * 선택된 상세코드의 정보를 보여준다.
	 * @param zvl
	 * @throws Exception
	 */
	List<ZValue> getSelectDetailCodeList(ZValue zvl) throws Exception;

	/**
	 * 공통상세코드 트리구조 리스트를 반환한다.
	 * @param zvl
	 * @throws Exception
	 */
	List<ZValue> getDetailCodeLists(ZValue zvl) throws Exception;

}
