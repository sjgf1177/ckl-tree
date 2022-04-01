package kr.co.unp.post.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.unp.post.service.EgovPostService;
import kr.co.unp.post.service.EgovPostVO;
import kr.co.unp.util.ZValue;

@Service("egovPostService")
public class EgovPostServiceImpl implements EgovPostService{

	@Resource(name="egovPostDAO")
	public EgovPostDAO egovPostDAO;
	
	/**
	 * 시군구 조회
	 */
	public List<ZValue> getSiGunguList(EgovPostVO vo) throws Exception{
		
		return egovPostDAO.getSiGunguList(vo);
	}
	
	/**
	 * 읍면동 조회
	 */
	public List<ZValue> getDongList(EgovPostVO vo) throws Exception{
		
		return egovPostDAO.getDongList(vo);
	}
	
	/**
	 * 리 조회
	 */
	public List<ZValue> getRiList(EgovPostVO vo) throws Exception{
		
		return egovPostDAO.getRiList(vo);
	}
	
	/**
	 * 목록 조회
	 */
	public List<ZValue> getPostList(EgovPostVO vo) throws Exception{
		
		return egovPostDAO.getPostList(vo);
	}
}
