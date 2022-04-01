package kr.co.unp.mpm.dao;

import java.util.List;

import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("commonContentsDAO")
public class CommonContentsDAO extends EgovAbstractDAO{
	
	public void modify(MenuManageVO vo) throws Exception {
		update("commonContentsDAO.menuAllNo", vo);
		insert("commonContentsDAO.modify", vo);
	}
	
	public int getMenuUserListTotCnt(ZValue zvl) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("commonContentsDAO.getMenuUserListTotCnt", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> getMenuUserList(ZValue zvl) throws Exception {
		return (List<ZValue>)list("commonContentsDAO.getMenuUserList", zvl);
	}
	
	public int getMenuUserDetailListTotCnt(ZValue zvl) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("commonContentsDAO.getMenuUserDetailListTotCnt", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> getMenuUserDetailList(ZValue zvl) throws Exception {
		return (List<ZValue>)list("commonContentsDAO.getMenuUserDetailList", zvl);
	}
	
	public ZValue getMenuUserDetail(ZValue zvl) throws Exception {
		return (ZValue)selectByPk("commonContentsDAO.getMenuUserDetail", zvl);
	}
	
	public void modifyProc(ZValue zvl) throws Exception {
		if (zvl.getString("useYn").equals("Y")){
			update("commonContentsDAO.menuAllNoZvl", zvl);
		}
		insert("commonContentsDAO.modifyZvl", zvl);
	}
	
	public void deleteProc(ZValue zvl) throws Exception {
		if (zvl.getString("useYn").equals("Y")){
			update("commonContentsDAO.lastUseUpdate", zvl);
		}
		insert("commonContentsDAO.deleteProc", zvl);
	}

	@SuppressWarnings("unchecked")
	public List<ZValue> selectNonAssignedContentsList(ZValue zvl) throws Exception {
		return (List<ZValue>)list("commonContentsDAO.selectNonAssignedContentsList", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> selectNonAssignedContentsExcelList(ZValue zvl) throws Exception {
		return (List<ZValue>)list("commonContentsDAO.selectNonAssignedContentsExcelList", zvl);
	}

	public int selectNonAssignedContentsListCnt(ZValue zvl) throws Exception {
		return (Integer)getSqlMapClientTemplate().queryForObject("commonContentsDAO.selectNonAssignedContentsListCnt", zvl);
	}

	public void assignContentsMenu(ZValue zvl) throws Exception {
		update("commonContentsDAO.assignContentsMenu", zvl);
	}
	
	@SuppressWarnings("unchecked")
	public List<ZValue> selectChangedCIPContentsList(ZValue zvl) throws Exception {
		return (List<ZValue>)list("commonContentsDAO.selectChangedCIPContentsList", zvl);
	}

	public void initContentsCIP(ZValue zvl) throws Exception {
		update("commonContentsDAO.initContentsCIP", zvl);
	}
	
}
