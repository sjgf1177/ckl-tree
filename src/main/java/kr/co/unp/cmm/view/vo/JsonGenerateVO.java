package kr.co.unp.cmm.view.vo;

import java.util.Map;

public class JsonGenerateVO  {
	
	/**
	 * JSON 객체를 생성한다.
	 * @param actionType - 화면처리종류(MOVE,POPUP,C,R,U,D 등)
	 * @param rep - HttpServletResponse
	 * @param req - HttpServletRequest
	 */
	public JsonGenerateVO(String actionType) {
		this.actionType = actionType;
	}
	
	/** 화면처리종류 (MOVE : 화면이동 ,POPUP : 팝업 ,  C : 등록, R : 조회, U : 수정, D : 삭제 ) */
	private String actionType = null;
	
	/** List<EgovMap> 타입의 형식 */
	private Map egovListMapTypeJsonData = null;
	
	/** 사용자가 임의로 키/값을 정하는 형식 */
	private Map mapTypeJsonData = null;
	
	/** 이벤트 발생시 필요 파라미터 */
	private Map eventActionData = null;	
	
	private String charSet = "utf-8";
	
	/**
	 * List<EgovMap> 형의 파라미터
	 * @param parameterMap
	 */
	public void setEgovListMapTypeJsonData(Map egovListMapTypeJsonData) {
		this.egovListMapTypeJsonData = egovListMapTypeJsonData;
	}

	public Map getEgovListMapTypeJsonData() {
		return egovListMapTypeJsonData;
	}
	public Map getMapTypeJsonData() {
		return mapTypeJsonData;
	}

	public void setMapTypeJsonData(Map mapTypeJsonData) {
		this.mapTypeJsonData = mapTypeJsonData;
	}
	public String getActionType() {
		return actionType;
	}
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	public Map getEventActionData() {
		return eventActionData;
	}
	public void setEventActionData(Map eventActionData) {
		this.eventActionData = eventActionData;
	}
	public String getCharSet() {
		return charSet;
	}
	public void setCharSet(String charSet) {
		this.charSet = charSet;
	}

}
