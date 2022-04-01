CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_CAREERS
IS
v_maxFileId	NUMBER;
BEGIN
	SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* 채용정보   */
    INSERT INTO TN_EMPMN_PBLANC (
        PBLANC_SN,
        ENTRPRS_SN,
        PBLANC_NM,
        CHRG_JOB,
        KWRD,
        RCRIT_REALM,
        RCRIT_RQISIT,
        RCRIT_NMPR,
        WRKPRC,
        WORK_STLE,
        CAREER_SE,
        CAREER,
        ACDMCR_SE,
        SEX,
        AGE,
        SALARY,
        JOB_CN,
        PRESENTN_PAPERS_CN,
        SLECTN_MTH_CN,
        RCEPT_BEGIN_DT,
        RCEPT_END_DT,
        RCEPT_COMPT_AT,
        RCEPT_MTH_CN,
        USE_AT,
        FRST_REGIST_PNTTM,
        FRST_REGISTER_ID,
        LAST_UPDT_PNTTM,
        LAST_UPDUSR_ID,
        DELETE_AT
    )
    SELECT
        A.PBLANC_SN,
        A.ENTRPRS_SN,
        A.PBLANC_NM,
        C.TOP_CD,
        A.KWRD,
        A.KWRD,
        A.RCRIT_RQISIT,
        B.RCRIT_NMPR,
        A.AREA_CD,
        (SELECT WM_CONCAT(WORK_STLE_CD) FROM CAREER_WORK_STLE WHERE PBLANC_SN = A.PBLANC_SN) AS WORK_STLE_CD,
        '0' || A.CAREER_SE AS CAREER_SE,
        A.CAREER,
        '0' || A.ACDMCR_SE AS ACDMCR_SE,
        DECODE(A.SEX,'0','N','1','M','2','F','N'),
        B.AGE,
        DECODE (A.ANSLRY_CD,
        	--'1','급여공개 ' ||  A.ANSLRY_TOP_AMT || ' ~ ' || A.ANSLRY_BOTTOM_AMT || ' 만원',
            '0', '당사규정',
            '협의후 결정'
        ) AS ANSLRY,
        A.JOB_CN,
        B.SUBMIT_PAPERS,
        B.SLECTN_MTH_CN,
        A.FRST_REGIST_PNTTM,
        A.RCEPT_END_DT,
        A.RCEPT_END_KIND,
        DECODE(SUBSTR(A.RCEPT_MTH_CN,5,1),'1','[우편],','') || DECODE(SUBSTR(A.RCEPT_MTH_CN,7,1),'1','[이메일입사지원],','')
        || DECODE(SUBSTR(A.RCEPT_MTH_CN,9,1),'1','[내사],','') || DECODE(SUBSTR(A.RCEPT_MTH_CN,11,1),'1','[인터넷접수],','') || DECODE(SUBSTR(A.RCEPT_MTH_CN,13,1),'1','[입사양식 다운로드 후 전자우편],','')
        || DECODE(SUBSTR(A.RCEPT_MTH_CN,15,1),'1','[입사양식 다운로드 후 우편접수]','') AS RCEPT_MTH_CN,
        'Y',
        A.FRST_REGIST_PNTTM,
        NULL,
        NULL,
        NULL,
        '0'

    FROM CAREER_INFO A
    INNER JOIN CAREER_INFO2 B ON A.PBLANC_SN = B.PBLANC_SN
    LEFT OUTER JOIN (
    	SELECT PBLANC_SN, MIN(TOP_CD) AS TOP_CD FROM  CAREER_JSSFC GROUP BY PBLANC_SN
    ) C ON  A.PBLANC_SN = C.PBLANC_SN
    WHERE A.CONFIRM_CD = 1;



END PR_TRAN_EDU_CAREERS;

