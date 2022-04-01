package kr.co.unp.cmmncode.dao;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import kr.co.unp.cmmncode.vo.CmmnCodeDetail;
import kr.co.unp.cmmncode.vo.CmmnCodeDetailVO;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 *
 * 공통상세코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("CmmnCodeDetailDAO")
public class CmmnCodeDetailDAO extends EgovAbstractDAO {

	public static final String CMM_CODE_CACHE_NAME = "storedCmmCode";
	/**
	 * 공통상세코드를 삭제한다.
	 * @param cmmnCodeDetail
	 * @throws Exception
	 */
	@CacheEvict(value=CMM_CODE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void deleteCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
		delete("CmmnCodeDetailDAO.deleteCmmnCodeDetail", cmmnCodeDetail);
	}


	/**
	 * 공통상세코드를 등록한다.
	 * @param cmmnCodeDetail
	 * @throws Exception
	 */
	@CacheEvict(value=CMM_CODE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void insertCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
        insert("CmmnCodeDetailDAO.insertCmmnCodeDetail", cmmnCodeDetail);
	}

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param cmmnCodeDetail
	 * @return CmmnCodeDetail(공통상세코드)
	 */
	public CmmnCodeDetail selectCmmnCodeDetailDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
		return (CmmnCodeDetail) selectByPk("CmmnCodeDetailDAO.selectCmmnCodeDetailDetail", cmmnCodeDetail);
	}


    /**
	 * 공통상세코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통상세코드 목록)
     * @throws Exception
     */
	@SuppressWarnings("unchecked")
    public List<CmmnCodeDetail> selectCmmnCodeDetailList(CmmnCodeDetailVO searchVO) throws Exception {
        return (List<CmmnCodeDetail>)list("CmmnCodeDetailDAO.selectCmmnCodeDetailList", searchVO);
    }

    /**
	 * 공통상세코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통상세코드 총 갯수)
     */
    @SuppressWarnings("deprecation")
	public int selectCmmnCodeDetailListTotCnt(CmmnCodeDetailVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("CmmnCodeDetailDAO.selectCmmnCodeDetailListTotCnt", searchVO);
    }

	/**
	 * 공통상세코드를 수정한다.
	 * @param cmmnCodeDetail
	 * @throws Exception
	 */
	@CacheEvict(value=CMM_CODE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void updateCmmnCodeDetail(CmmnCodeDetail cmmnCodeDetail) throws Exception {
		update("CmmnCodeDetailDAO.updateCmmnCodeDetail", cmmnCodeDetail);
	}

	/**
	 * 코드 리스트 반환
	 * Summary :
	 * MethodName : getDetailCodeList
	 * @return List<ZValue>
	 * @exception
	 * @param zvl
	 * @return
	 * @throws Exception
	 * @desc
	 *
	 */
	@SuppressWarnings("unchecked")
	@Cacheable(value=CMM_CODE_CACHE_NAME)
	public List<ZValue> getDetailCodeList(ZValue zvl) throws Exception {
		return (List<ZValue>)list("CmmnCodeDetailDAO.getDetailCodeList", zvl);
	}

	/**
	 * 선택된 코드 정보 반환
	 * Summary :
	 * MethodName : getSelectDetailCodeList
	 * @return ZValue
	 * @exception
	 * @param zvl
	 * @return
	 * @throws Exception
	 * @desc
	 *
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> getSelectDetailCodeList(ZValue zvl) throws Exception {
		zvl.put("selectCode", "'" + zvl.getString("selectCode").replaceAll("#", "','")+"'");
		return (List<ZValue>)list("CmmnCodeDetailDAO.getSelectDetailCodeList", zvl);
	}


	/**
	 * 코드 리스트 반환
	 * Summary :
	 * MethodName : getDetailCodeList
	 * @return List<ZValue>
	 * @exception
	 * @param zvl
	 * @return
	 * @throws Exception
	 * @desc
	 *
	 */
	@SuppressWarnings("unchecked")
	public List<ZValue> getDetailCodeLists(ZValue zvl) throws Exception {
		return (List<ZValue>)list("CmmnCodeDetailDAO.getDetailCodeLists", zvl);
	}

	public List<String> getCodeNames(List<ZValue> codeList, ZValue val, String propertyName, String dellim){
		List<String> result = null;
		String codes = val.getString(propertyName);
		if( StringUtils.hasText(codes) ){
			String[] data = StrUtils.split(codes, dellim);
			result = new ArrayList<String>();
			for(String code : data){
				for(ZValue cmmnCode : codeList)
				{
					if(code.equals(cmmnCode.getString("code")))
					{
						result.add(cmmnCode.getString("codeNm"));
						break;
					}
				}
			}
		}
		return result;
	}

	public <T> String getCodeName(T vo, List<ZValue> codeList, String propertyName)
	{
		String result = null;
		String code = null;
		try {
			code = (String)PropertyUtils.getProperty(vo, propertyName);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
		if( StringUtils.hasText(code) ){
			for(ZValue cmmnCode : codeList)
			{
				if(code.equals(cmmnCode.getString("code")))
				{
					result = cmmnCode.getString("codeNm");
					break;
				}
			}
		}
		return result;
	}

}
