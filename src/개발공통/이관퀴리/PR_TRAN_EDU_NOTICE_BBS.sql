CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_NOTICE_BBS
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';

    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* 한국콘텐츠코리아랩 - 공지사항   */
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
        OPTION19,
        OPTION20
    )

	SELECT
    	v_maxNttId + ROWNUM AS NTT_ID,
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
        OPTION19,
        OPTION20
    FROM (
       SELECT
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
          OPTION19,
          OPTION20
      FROM (
          SELECT
            A.SEQ  AS NTT_ID,
            'B0000011' AS BBS_ID,
            A.LUSERID AS NTCR_ID,
            A.ADNAME AS NTCR_NM,
            A.ADTITLE AS NTT_SJ,
            A.CNT AS INQIRE_CO,
            'Y' AS USE_AT,
            TO_DATE(A.ADDATE,'YYYYMMDDHH24MISS') AS FRST_REGIST_PNTTM ,
            TO_DATE(A.LDATE,'YYYYMMDDHH24MISS') AS LAST_UPDT_PNTTM,
            A.ADUSERID AS FRST_REGISTER_ID,
            A.LUSERID AS LAST_UPDUSR_ID,
            0 AS PARNTS,
            0 AS NTT_NO,
            0 AS REPLY_LC,
            NULL AS ATCH_FILE_ID,
            '0' AS  DELETE_CODE,
            'N' AS SECRET_AT,
            '2' AS NTT_TYPE,
            'N' AS HTML_AT,
            A.ADCONTENT AS NTT_CN,
            '01' AS OPTION01,
            NULL AS OPTION19,
            NULL AS OPTION20
        FROM KOCCA.TZ_NOTICE A
        WHERE  A.TABSEQ= '12' AND A.GRCODECD LIKE '%N000001%' AND A.USEYN = 'Y'

        UNION ALL

        SELECT
            NOT_SEQ	AS NTT_I,
            'B0000011' AS BBS_ID,
            NULL	AS NTCR_ID,
            NOT_REGNAME	AS NTCR_NM,
            NOT_SUBJECT	AS NTT_SJ,
            NOT_HIT	AS INQIRE_CO,
            'Y' AS USE_AT,
            NOT_REGDATE	AS FRST_REGIST_PNTTM,
            NOT_REGDATE	AS LAST_UPDT_PNTTM,
            NULL	AS FRST_REGISTER_ID,
            NULL  AS LAST_UPDUSR_ID,
            0 AS PARNTS,
            0 AS NTT_NO,
            0 AS REPLY_LC,
            DECODE(NOT_FILE,NULL,NULL,'FILE_' || LPAD(NOT_SEQ+v_maxFileId ,15,'0')) AS ATCH_FILE_ID,
            '0' AS DELETE_CODE,
            'N' AS SECRET_AT,
            '2' AS NTT_TYPE,
            'N' AS HTML_AT,
            NOT_CLOB AS NTT_CN,
           '02' AS OPTION01,
            NULL AS OPTION19,
            NOT_SEQ AS OPTION20
        FROM CUS_NOTICE B
        WHERE DELFLAG = 'N' AND NOT_FLAG= 'A'
      ) A
      ORDER BY FRST_REGIST_PNTTM ASC, NTT_ID ASC
	);
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
    WHERE DECODE(OPTION20,NULL,0,1)  = 1
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
        '1',
        '/upload/culturist/',
		B.NOT_FILE,
        B.NOT_FILE,
    	SUBSTR(B.NOT_FILE, INSTR(B.NOT_FILE, '.', -1) + 1) AS FILE_EXTSN,
        0,
        NULL
    FROM TB_BBS_ESTN A, CUS_NOTICE B
    WHERE A.OPTION20 = B.NOT_SEQ
    AND B.NOT_FILE IS NOT NULL;

    UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1;

END PR_TRAN_EDU_NOTICE_BBS;