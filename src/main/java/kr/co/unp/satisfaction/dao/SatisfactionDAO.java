package kr.co.unp.satisfaction.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Repository;

import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("satisfactionDAO")
public class SatisfactionDAO extends EgovAbstractDAO{

	public void saveSatisfaction(ZValue zvl) throws Exception
	{	
		insert("satisfactionDAO.saveSatisfaction", zvl);
	}
	
	public int existsUserIp(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("satisfactionDAO.existsUserIp", zvl);
	}

	public int selectOpinionListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("satisfactionDAO.selectOpinionListCnt", zvl);
	}

	public List<ZValue> selectOpinionList(ZValue zvl) throws Exception
	{
		return (List<ZValue>)list("satisfactionDAO.selectOpinionList", zvl);
	}

	public List<ZValue> selectStatusList(ZValue zvl) throws Exception
	{
		return (List<ZValue>)list("satisfactionDAO.selectStatusList", zvl);
	}
	
	public List<ZValue> menuStatusList(ZValue zvl) throws Exception
	{
		return (List<ZValue>)list("satisfactionDAO.menuStatusList", zvl);
	}
	
	public List<ZValue> menuStatusListExcel(ZValue zvl) throws Exception
	{
		return (List<ZValue>)list("satisfactionDAO.menuStatusListExcel", zvl);
	}
	
	public int menuStatusListCnt(ZValue zvl) throws Exception
	{
		return (Integer)selectByPk("satisfactionDAO.menuStatusListCnt", zvl);
	}
	
}
