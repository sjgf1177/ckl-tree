CREATE OR REPLACE PROCEDURE PR_TRAN_QNA_BBS
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID�� ���ϱ� */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';

    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* �������ڸ��Ʒ� - �����ϱ�   */
    INSERT INTO TB_BBS_ESTN (
        NTT_ID,
        BBS_ID,
        NTCR_ID,
        NTCR_NM,
        NTT_SJ,
        INQIRE_CO,
    	USE_AT,
        FRST_REGIST_PNTTM,
        LAST_UPDT_PNTTM,
        FRST_REGISTER_ID,
        LAST_UPDUSR_ID,
        PARNTS,
        NTT_NO,
        REPLY_LC,
        ATCH_FILE_ID,
        DELETE_CODE,
        SECRET_AT,
        NTT_TYPE,
       	HTML_AT,
      	NTT_CN,
        NTCR_EMAIL,
        OPTION19,
        OPTION20,
        REPLY_AT
    )
     SELECT
        A.BBS_SEQ_N + v_maxNttId AS NTT_ID,
        'B0000037' AS BBS_ID,
        A.USER_ID_V,
        A.USER_NM_V,
        A.TITLE_V,
        A.READ_CNT_N,
        'Y',
        A.REG_DT_D,
        A.UPD_DT_D,
        A.REG_ID_V,
        A.UPD_ID_V,
        0,
        0,
        0,
        DECODE(B.BBS_SEQ_N,NULL,NULL,'FILE_' || LPAD(B.BBS_SEQ_N+ v_maxFileId,15,'0')),
        DECODE(A.DELETE_YN_C,'Y','1',0),
        'N',
        '2',
        'N',
        A.CONTENT_L,
        A.USER_EMAIL_V,
        A.BBS_CD_N,
        A.BBS_SEQ_N
        ,DECODE(PERMITS_DT_V,NULL,'N','Y')

    FROM CKLDBADMIN.TB_BBS_BASIC A
    LEFT OUTER JOIN (
    	SELECT
          BBS_SEQ_N,
          BBS_CD_N
      	FROM CKLDBADMIN.TB_BBS_FILE
      	GROUP BY BBS_CD_N ,BBS_SEQ_N
    ) B ON A.BBS_SEQ_N = B.BBS_SEQ_N AND A.BBS_CD_N = B.BBS_CD_N
    WHERE A.BBS_CD_N = '7'
    ORDER BY A.REG_DT_D ASC, A.BBS_SEQ_N ASC;

	--UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),'0'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    INSERT INTO TC_COMMNFILE (
       ATCH_FILE_ID,
       FRST_REGIST_PNTTM,
       USE_AT
    )
    SELECT
    	ATCH_FILE_ID,
        SYSDATE AS TODAY,
        'Y'
    FROM TB_BBS_ESTN
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1
    AND DECODE(ATCH_FILE_ID,NULL,0,1) = 1;



    INSERT INTO TC_COMMNFILE_DETAIL (
    	ATCH_FILE_ID,
        FILE_SN,
        FILE_STRE_COURS,
        STRE_FILE_NM,
        ORIGNL_FILE_NM,
        FILE_EXTSN,
        FILE_MG,
        FILE_CN

    )
    SELECT
    	A.ATCH_FILE_ID,
        FILE_SEQ_N,
        FILE_PATH_V,
		SUBSTR(FILE_PATH_V, INSTR(FILE_PATH_V, '/', -1) + 1) AS STRE_FILE_NM,
        FILE_NM_V,
    	SUBSTR(FILE_NM_V, INSTR(FILE_NM_V, '.', -1) + 1) AS FILE_EXTSN,
        FILE_SIZE_N,
        FILE_COMMENT_V
    FROM TB_BBS_ESTN A, CKLDBADMIN.TB_BBS_FILE B
    WHERE A.OPTION19 = B.BBS_CD_N
    AND A.OPTION20 = B.BBS_SEQ_N
    AND B.BBS_CD_N = '7';


	SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;

	/* �亯 ��� */
    INSERT INTO TB_BBS_ESTN (
        NTT_ID,
        BBS_ID,
        NTCR_ID,
        NTCR_NM,
        NTT_SJ,
        INQIRE_CO,
    	USE_AT,
        FRST_REGIST_PNTTM,
        LAST_UPDT_PNTTM,
        FRST_REGISTER_ID,
        LAST_UPDUSR_ID,
        PARNTS,
        NTT_NO,
        REPLY_LC,
        ATCH_FILE_ID,
        DELETE_CODE,
        SECRET_AT,
        NTT_TYPE,
       	HTML_AT,
      	NTT_CN,
        NTCR_EMAIL,
        NTCR_TEL,
        REPLY_AT
    )
    SELECT
        A.BBS_SEQ_N + v_maxNttId AS NTT_ID,
        'B0000037' AS BBS_ID,
        A.PERMITS_ID_V,
        A.PERMITS_NM_V,
        A.TITLE_V,
        0,
        'Y',
        A.PERMITS_DT_V,
        NULL,
        A.PERMITS_ID_V,
        NULL,
        B.NTT_ID,
        0,
        1,
        NULL,
        DECODE(A.DELETE_YN_C,'Y','1',0),
        'N',
        '2',
        'N',
        A.ANSWER_L,
        A.PERMITS_EMAIL_V,
        A.PERMITS_PHONE_V,
        'Y'

    FROM CKLDBADMIN.TB_BBS_BASIC A
    LEFT OUTER JOIN TB_BBS_ESTN B ON A.BBS_SEQ_N = B.OPTION20 AND A.BBS_CD_N = B.OPTION19 AND B.BBS_ID = 'B0000037'
    WHERE A.BBS_CD_N = '7'
    ORDER BY A.REG_DT_D ASC, A.BBS_SEQ_N ASC;

    UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1;

END PR_TRAN_QNA_BBS;