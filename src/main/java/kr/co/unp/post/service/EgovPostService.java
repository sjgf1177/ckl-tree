package kr.co.unp.post.service;

import java.util.List;

import kr.co.unp.util.ZValue;

public interface EgovPostService {

	
	/**
	 * 시군구 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> getSiGunguList(EgovPostVO vo) throws Exception;

	/**
	 * 읍면동 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> getDongList(EgovPostVO vo) throws Exception;
	
	/**
	 * 리 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> getRiList(EgovPostVO vo) throws Exception;
	
	/**
	 * 목록 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> getPostList(EgovPostVO vo) throws Exception;
}
