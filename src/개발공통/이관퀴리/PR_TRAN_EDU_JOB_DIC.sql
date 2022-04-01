CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_JOB_DIC
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    --SELECT NVL(MAX(DICARY_SN),0) INTO v_maxNttId FROM TN_JOB_DICARY;

	/* 콘텐츠아카데미 - 직업사전  */
    INSERT INTO TN_JOB_DICARY (
		DICARY_SN,
       	CTGRY_SE1,
       	CTGRY_SE2,
       	DICARY_SJ,
       	FRST_REGIST_PNTTM,
       	FRST_REGISTER_ID,
       	LAST_UPDT_PNTTM,
       	LAST_UPDUSR_ID,
       	DELETE_AT
    )
    SELECT
    	JI_ID,
       	SUBSTR(DIV_CODE,0,1),
       	DIV_CODE,
       	JOB_NAME,
       	SYSDATE,
       	NULL,
       	NULL,
       	NULL,
       	'N'
    FROM JOB_INFO
    ORDER BY JI_ID ASC;


	INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '1' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','직무정의',
            'C','직업개요',
            'D','직무정의',
            'F','직업개요',
            'G','직무정의',
            'I','직무정의',
            'J','직무정의',
            'K','직무정의'
        ),
        INFO_SEQ_1
    FROM JOB_INFO WHERE INFO_SEQ_1 IS NOT NULL
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '2' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','직무모형',
            'C','준비방법',
            'D','직무모형',
            'F','준비방법',
            'G','직무모형',
            'I','직무모형',
            'J','직무모형',
            'K','직무모형'
        ),
        INFO_SEQ_2
    FROM JOB_INFO WHERE INFO_SEQ_2 IS NOT NULL
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '3' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','과정별 직무모형',
            'C','관련학과 자격',
            'D','역량모형',
            'F','관련학과 자격',
            'G','직급구분',
            'I','직무수행 관련 접촉자',
            'J','역량모형',
            'K','역량모형'
        ),
        INFO_SEQ_3
    FROM JOB_INFO WHERE INFO_SEQ_3 IS NOT NULL
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '4' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','주요 접촉자',
            'C','적성 및 흥미',
            'D','경력모형',
            'F','적성 및 흥미',
            'G','직무특성',
            'I','직무 내 위계구조',
            'J','경력모형',
            'K','경력모형'
        ),
        INFO_SEQ_4
    FROM JOB_INFO WHERE INFO_SEQ_4 IS NOT NULL
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '5' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','주요 장비 및 소프트웨어',
            'C','일자리 전망',
            'D','필요 교육, 훈련',
            'F','일자리 전망',
            'G','핵심역량',
            'I','핵심역량',
            'J','필요 교육, 훈련',
            'K','필요 교육, 훈련'
        ),
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'G',INFO_SEQ_5 || chr(13) || chr(10) || INFO_SEQ_6 || chr(13) || chr(10) || INFO_SEQ_7,
            'I',INFO_SEQ_5 || chr(13) || chr(10) || INFO_SEQ_6 || chr(13) || chr(10) || INFO_SEQ_7,
            INFO_SEQ_5
        )
    FROM JOB_INFO WHERE INFO_SEQ_5 IS NOT NULL
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '6' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','직무 내 위계구조',
            'C','관련단체 및 기관',
            'D','기타',
            'F','관련단체 및 기관',
            'G','',
            'I','',
            'J','기타',
            'K','기타'
        ),
        INFO_SEQ_6
    FROM JOB_INFO WHERE INFO_SEQ_6 IS NOT NULL AND SUBSTR(DIV_CODE,0,1) NOT IN ('G','I')
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '7' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','직무특성'
        ),
        INFO_SEQ_7
    FROM JOB_INFO WHERE INFO_SEQ_7 IS NOT NULL AND SUBSTR(DIV_CODE,0,1)  IN ('A')
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '8' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','핵심역량',
            'G','기타',
            'I','경력관리'
        ),
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A',INFO_SEQ_8 || chr(13) || chr(10) || INFO_SEQ_9 || chr(13) || chr(10) || INFO_SEQ_10,
            INFO_SEQ_8
        )
    FROM JOB_INFO WHERE INFO_SEQ_8 IS NOT NULL AND SUBSTR(DIV_CODE,0,1)  IN ('A','G','I')
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '11' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','경력관리'
        ),
        INFO_SEQ_11
    FROM JOB_INFO WHERE INFO_SEQ_11 IS NOT NULL AND SUBSTR(DIV_CODE,0,1)  IN ('A')
    ORDER BY JI_ID ASC;

    INSERT INTO TN_JOB_DICARY_CN (
    	DICARY_SN, CN_SN, FRST_REGIST_PNTTM, SUB_SJ, SUB_CN
    )
    SELECT
    	 JI_ID, '12' AS CN_SN, SYSDATE,
        DECODE(SUBSTR(DIV_CODE,0,1),
        	'A','기타 근무 및 취업상황'
        ),
        INFO_SEQ_12
    FROM JOB_INFO WHERE INFO_SEQ_12 IS NOT NULL AND SUBSTR(DIV_CODE,0,1)  IN ('A')
    ORDER BY JI_ID ASC;

END PR_TRAN_EDU_JOB_DIC;