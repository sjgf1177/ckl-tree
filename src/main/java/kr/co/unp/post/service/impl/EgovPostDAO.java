package kr.co.unp.post.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.unp.post.service.EgovPostVO;
import kr.co.unp.util.ZValue;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("egovPostDAO")
public class EgovPostDAO extends EgovAbstractDAO{

	public List<ZValue> getPostList(EgovPostVO vo) throws Exception{
		
		return (List<ZValue>)list("egovPostDAO.getPostList", vo);
	}
	
	
	public List<ZValue> getSiGunguList(EgovPostVO vo) throws Exception{
		
		return (List<ZValue>)list("egovPostDAO.getSiGunguList", vo);
	}
	
	public List<ZValue> getDongList(EgovPostVO vo) throws Exception{
		
		return (List<ZValue>)list("egovPostDAO.getDongList", vo);
	}
	
	public List<ZValue> getRiList(EgovPostVO vo) throws Exception{
		
		return (List<ZValue>)list("egovPostDAO.getRiList", vo);
	}
}
