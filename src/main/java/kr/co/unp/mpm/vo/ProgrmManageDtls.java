package kr.co.unp.mpm.vo;

/**
 * 프로그램변경요청 관리 생성을 위한 모델 클래스를 정의한다.
 * @author 공통서비스 개발팀 이 용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이용          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */

public class ProgrmManageDtls {

	/**
	 * 변경요청내용
	 */
	private String changerqesterCn;
	/**
	 * 처리자ID
	 */
	private String opetrId;
	/**
	 * 처리일자
	 */
	private String processDe;
	/**
	 * 처리상태코드
	 */
	private String processSttus;
	/**
	 * 프로그램파일명
	 */
	private String progrmFileNm;
	/**
	 * 요청일자
	 */
	private String rqesterDe;
	/**
	 * 요청번호
	 */
	private int rqesterNo;
	/**
	 * 요청자ID
	 */
	private String rqesterpersonId;
	/**
	 * 요청처리내용
	 */
	private String rqesterProcessCn;
	/**
	 * 요청제목
	 */
	private String rqesterSj;
}