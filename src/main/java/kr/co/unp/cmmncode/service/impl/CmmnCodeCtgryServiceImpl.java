package kr.co.unp.cmmncode.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import kr.co.unp.cmmncode.dao.CmmnCodeCtgryDAO;
import kr.co.unp.cmmncode.service.CmmnCodeCtgryService;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgry;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgryVO;
import kr.co.unp.util.ZValue;



/**
 *
 * 공통코드에 대한 서비스 구현클래스를 정의한다
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
@Service("CmmnCodeCtgryService")
public class CmmnCodeCtgryServiceImpl extends EgovAbstractServiceImpl implements CmmnCodeCtgryService {

    @Resource(name="CmmnCodeCtgryDAO")
    private CmmnCodeCtgryDAO cmmnCodeCtgryDAO;

    @Resource(name = "CmmnCodeIdGnrService")
    protected EgovIdGnrService idgenService;

	/**
	 * 공통코드를 삭제한다.
	 */
	public void deleteCmmnCodeCtgry(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
		cmmnCodeCtgryDAO.deleteCmmnCodeCtgry(cmmnCodeCtgry);
	}

	/**
	 * 공통코드를 등록한다.
	 */
	public void insertCmmnCodeCtgry(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
		cmmnCodeCtgry.setCodeId(idgenService.getNextStringId());
    	cmmnCodeCtgryDAO.insertCmmnCodeCtgry(cmmnCodeCtgry);
	}

	/**
	 * 공통코드 상세항목을 조회한다.
	 */
	public CmmnCodeCtgry selectCmmnCodeCtgryDetail(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
    	CmmnCodeCtgry ret = (CmmnCodeCtgry)cmmnCodeCtgryDAO.selectCmmnCodeCtgryDetail(cmmnCodeCtgry);
    	return ret;
	}

	/**
	 * 공통코드 목록을 조회한다.
	 */
	public List selectCmmnCodeCtgryList(CmmnCodeCtgryVO searchVO) throws Exception {
        return cmmnCodeCtgryDAO.selectCmmnCodeCtgryList(searchVO);
	}

	/**
	 * 공통코드 총 갯수를 조회한다.
	 */
	public int selectCmmnCodeCtgryListTotCnt(CmmnCodeCtgryVO searchVO) throws Exception {
        return cmmnCodeCtgryDAO.selectCmmnCodeCtgryListTotCnt(searchVO);
	}

	/**
	 * 공통코드를 수정한다.
	 */
	public void updateCmmnCodeCtgry(CmmnCodeCtgry cmmnCodeCtgry) throws Exception {
		cmmnCodeCtgryDAO.updateCmmnCodeCtgry(cmmnCodeCtgry);
	}

}
