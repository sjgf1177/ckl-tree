package kr.co.unp.auth.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.unp.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("authoDeptMenuDAO")
public class AuthoDeptMenuDAO extends EgovAbstractDAO{

	public void insertDeptMenuCreat_S(ZValue zvl) throws Exception
	{
		insert("authoDeptMenuDAO.insertDeptMenuCreat_S", zvl);
	}

	public void deleteDeptMenuCreat_S(String mapcreatId) throws Exception
	{
		delete("authoDeptMenuDAO.deleteDeptMenuCreat_S", mapcreatId);
	}

	public int selectDeptMenuCreatCnt_S(String mapcreatId) throws Exception
	{
		return (Integer)selectByPk("authoDeptMenuDAO.selectDeptMenuCreatCnt_S", mapcreatId);
	}

	public List selectDeptMenuCreat_S(ZValue zvl) throws Exception
	{
		return list("authoDeptMenuDAO.selectDeptMenuCreat_S", zvl);
	}

	public List selectProgramList(String siteId) throws Exception
	{
		return list("authoDeptMenuDAO.selectProgramList", siteId);
	}

	public void insertProgramList(ZValue zvl) throws Exception
	{
		insert("authoDeptMenuDAO.insertProgramList", zvl);
	}

	public void updateProgramList(ZValue zvl) throws Exception
	{
		insert("authoDeptMenuDAO.updateProgramList", zvl);
	}

	public int existMenuNoInProgramList(String menuNo) throws Exception
	{
		return (Integer)selectByPk("authoDeptMenuDAO.existMenuNoInProgramList", menuNo);
	}

    @SuppressWarnings("unchecked")
    public List<ZValue> selectNewEmployee()  throws Exception {
        return (List<ZValue>)list("authoDeptMenuDAO.selectNewEmployee", null);
    }

    public void insertNewEmployeeAuthor() throws Exception {
        insert("authoDeptMenuDAO.insertNewEmployeeAuthor", null);
    }

    @SuppressWarnings("unchecked")
    public List<ZValue> selectChangeInPersonnelList(ZValue zvl)  throws Exception {
        return (List<ZValue>)list("authoDeptMenuDAO.selectChangeInPersonnelList", zvl);
    }

    public void updateAuthorDeptId(ZValue zvl) throws Exception {
        insert("authoDeptMenuDAO.updateAuthorDeptId", zvl);
    }

    public void releaseChangeInPersonnel(ZValue zvl) throws Exception {
        insert("authoDeptMenuDAO.releaseChangeInPersonnel", zvl);
    }


}
