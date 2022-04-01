/**
 *
 *
 * @author 김명구
 * @since 2010. 1. 21.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      	수정자      	수정내용
 *  -------    		--------    --------------------------
 *   2010. 1. 21.  김명구      	최초 생성
 *
 * Copyright (C) 2010 by MOPAS  All right reserved.
 * </pre>
 */


package kr.co.unp.banner.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import kr.co.unp.banner.vo.Banner;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("BannerDAO")
public class BannerDAO extends EgovAbstractDAO {

	public int selectBannerPK() {
		return (Integer) getSqlMapClientTemplate().queryForObject("BannerDAO.selectBannerPK");
	}

	public int selectListTotCnt(Banner bean) {
		return (Integer)getSqlMapClientTemplate().queryForObject("BannerDAO.selectBannerListTotCnt", bean);
	}

    @SuppressWarnings("unchecked")
	public List<Banner> selectAllList(Banner bean) {
    	List<Banner> resultMany = null;
    	try {
    		resultMany = (List<Banner>) list("BannerDAO.selectAllBannerList", bean);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}

    @SuppressWarnings("unchecked")
	public List<Banner> selectList(Banner bean) {
    	List<Banner> resultMany = null;
    	try {
    		resultMany = (List<Banner>) list("BannerDAO.selectBannerList", bean);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}

    public Banner select(Banner bean, ModelMap model) {
    	Banner resultOne = null;
    	try {
    		resultOne = (Banner) selectByPk("BannerDAO.selectBannerDetail", bean);
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	return resultOne;
	}

    @SuppressWarnings("unchecked")
	public List<Banner> selectPublishList(Banner param) {
    	List<Banner> resultMany = null;
    	try {
    		resultMany = (List<Banner>) list("BannerDAO.selectPublishList", param);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}


	public void insert(Banner bean) {
		try {
			insert("BannerDAO.insertBanner", bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void update(Banner bean) {
		try {
			update("BannerDAO.updateBanner", bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(Banner bean) {
		delete("BannerDAO.deleteBanner", bean);
	}
}