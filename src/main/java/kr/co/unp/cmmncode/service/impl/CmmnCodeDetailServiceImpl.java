package kr.co.unp.cmmncode.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.unp.cmmncode.service.CmmnCodeDetailService;
import kr.co.unp.cmmncode.vo.CmmnCodeDetail;
import kr.co.unp.cmmncode.vo.CmmnCodeDetailVO;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.util.ZValue;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;



/**
 *
 * 공통상세코드에 대한 서비스 구현클래스를 정의한다
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
@Service("CmmnCodeDetailService")
public class CmmnCodeDetailServiceImpl extends EgovAbstractServiceImpl implements CmmnCodeDetailService {

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;

	/**
	 * 공통상세코드를 삭제한다.
	 */
	public void deleteCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
		cmmnCodeDetailDAO.deleteCmmnCodeDetail(cmmnCodeDetail);
	}

	/**
	 * 공통상세코드를 등록한다.
	 */
	public void insertCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
    	cmmnCodeDetailDAO.insertCmmnCodeDetail(cmmnCodeDetail);
	}

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 */
	public CmmnCodeDetail selectCmmnCodeDetailDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
    	CmmnCodeDetail ret = (CmmnCodeDetail)cmmnCodeDetailDAO.selectCmmnCodeDetailDetail(cmmnCodeDetail);
    	return ret;
	}

	/**
	 * 공통상세코드 목록을 조회한다.
	 */
	public List selectCmmnCodeDetailList(CmmnCodeDetailVO searchVO) throws Exception {
        return cmmnCodeDetailDAO.selectCmmnCodeDetailList(searchVO);
	}

	/**
	 * 공통상세코드 총 갯수를 조회한다.
	 */
	public int selectCmmnCodeDetailListTotCnt(CmmnCodeDetailVO searchVO) throws Exception {
        return cmmnCodeDetailDAO.selectCmmnCodeDetailListTotCnt(searchVO);
	}

	/**
	 * 공통상세코드를 수정한다.
	 */
	public void updateCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
		cmmnCodeDetailDAO.updateCmmnCodeDetail(cmmnCodeDetail);
	}

	/**
	 * 코드 리스트
	 */
	public List<ZValue> getDetailCodeList(ZValue zvl) throws Exception {
		return cmmnCodeDetailDAO.getDetailCodeList(zvl);
	}

	/**
	 * 선택된 코드 정보
	 */
	public List<ZValue> getSelectDetailCodeList(ZValue zvl) throws Exception{
		return cmmnCodeDetailDAO.getSelectDetailCodeList(zvl);
	}

	/**
	 * 코드 리스트
	 */
	public List<ZValue> getDetailCodeLists(ZValue zvl) throws Exception {
		return cmmnCodeDetailDAO.getDetailCodeLists(zvl);
	}


}
