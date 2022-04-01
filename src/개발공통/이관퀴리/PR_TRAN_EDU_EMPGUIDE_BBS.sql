CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_EMPGUIDE_BBS
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';


	/* 콘텐츠아카데미 - 취업가이드   */
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
        OPTION5,
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
        OPTION5,
        OPTION19,
        OPTION20
    FROM (
    	SELECT
            A.B_NUM  AS NTT_ID,
            'B0000028' AS BBS_ID,
            B_M_ID AS NTCR_ID,
            '관리자' AS NTCR_NM,
            A.B_TITLE AS NTT_SJ,
            A.B_READ_CNT AS INQIRE_CO,
            'Y' AS USE_AT,
            B_W_DATE AS FRST_REGIST_PNTTM ,
            B_W_DATE AS LAST_UPDT_PNTTM,
            A.B_M_ID AS FRST_REGISTER_ID,
            A.B_M_ID AS LAST_UPDUSR_ID,
            0 AS PARNTS,
            0 AS NTT_NO,
            0 AS REPLY_LC,
            NULL AS ATCH_FILE_ID,
            '0' AS  DELETE_CODE,
            'N' AS SECRET_AT,
            '2' AS NTT_TYPE,
            'N' AS HTML_AT,
            '01' AS OPTION5,
            A.B_CONTENT AS NTT_CN,
            'HIS_GUIDE_KOR' AS OPTION19,
            A.B_NUM AS OPTION20
        FROM HIS_GUIDE_KOR A

        UNION ALL

        SELECT
            A.B_NUM  AS NTT_ID,
            'B0000028' AS BBS_ID,
            B_M_ID AS NTCR_ID,
            '관리자' AS NTCR_NM,
            A.B_TITLE AS NTT_SJ,
            A.B_READ_CNT AS INQIRE_CO,
            'Y' AS USE_AT,
            B_W_DATE AS FRST_REGIST_PNTTM ,
            B_W_DATE AS LAST_UPDT_PNTTM,
            A.B_M_ID AS FRST_REGISTER_ID,
            A.B_M_ID AS LAST_UPDUSR_ID,
            0 AS PARNTS,
            0 AS NTT_NO,
            0 AS REPLY_LC,
            NULL AS ATCH_FILE_ID,
            '0' AS  DELETE_CODE,
            'N' AS SECRET_AT,
            '2' AS NTT_TYPE,
            'N' AS HTML_AT,
            '02' AS OPTION5,
            A.B_CONTENT AS NTT_CN,
            'HIS_GUIDE_ENG' AS OPTION19,
            A.B_NUM AS OPTION20
        FROM HIS_GUIDE_ENG A

        UNION ALL

        SELECT
            A.B_NUM  AS NTT_ID,
            'B0000028' AS BBS_ID,
            B_M_ID AS NTCR_ID,
            '관리자' AS NTCR_NM,
            A.B_TITLE AS NTT_SJ,
            A.B_READ_CNT AS INQIRE_CO,
            'Y' AS USE_AT,
            B_W_DATE AS FRST_REGIST_PNTTM ,
            B_W_DATE AS LAST_UPDT_PNTTM,
            A.B_M_ID AS FRST_REGISTER_ID,
            A.B_M_ID AS LAST_UPDUSR_ID,
            0 AS PARNTS,
            0 AS NTT_NO,
            0 AS REPLY_LC,
            NULL AS ATCH_FILE_ID,
            '0' AS  DELETE_CODE,
            'N' AS SECRET_AT,
            '2' AS NTT_TYPE,
            'N' AS HTML_AT,
            '03' AS OPTION5,
            A.B_CONTENT AS NTT_CN,
            'SELF_INTRO_KO' AS OPTION19,
            A.B_NUM AS OPTION20
        FROM SELF_INTRO_KO A

        UNION ALL

        SELECT
            A.B_NUM  AS NTT_ID,
            'B0000028' AS BBS_ID,
            B_M_ID AS NTCR_ID,
            '관리자' AS NTCR_NM,
            A.B_TITLE AS NTT_SJ,
            A.B_READ_CNT AS INQIRE_CO,
            'Y' AS USE_AT,
            B_W_DATE AS FRST_REGIST_PNTTM ,
            B_W_DATE AS LAST_UPDT_PNTTM,
            A.B_M_ID AS FRST_REGISTER_ID,
            A.B_M_ID AS LAST_UPDUSR_ID,
            0 AS PARNTS,
            0 AS NTT_NO,
            0 AS REPLY_LC,
            NULL AS ATCH_FILE_ID,
            '0' AS  DELETE_CODE,
            'N' AS SECRET_AT,
            '2' AS NTT_TYPE,
            'N' AS HTML_AT,
            '04' AS OPTION5,
            A.B_CONTENT AS NTT_CN,
            'SELF_INTRO_EN' AS OPTION19,
            A.B_NUM AS OPTION20
        FROM SELF_INTRO_EN A

        UNION ALL

        SELECT
              A.B_NUM  AS NTT_ID,
              'B0000028' AS BBS_ID,
              B_M_ID AS NTCR_ID,
              '관리자' AS NTCR_NM,
              A.B_TITLE AS NTT_SJ,
              A.B_READ_CNT AS INQIRE_CO,
              'Y' AS USE_AT,
              B_W_DATE AS FRST_REGIST_PNTTM ,
              B_W_DATE AS LAST_UPDT_PNTTM,
              A.B_M_ID AS FRST_REGISTER_ID,
              A.B_M_ID AS LAST_UPDUSR_ID,
              0 AS PARNTS,
              0 AS NTT_NO,
              0 AS REPLY_LC,
              NULL AS ATCH_FILE_ID,
              '0' AS  DELETE_CODE,
              'N' AS SECRET_AT,
              '2' AS NTT_TYPE,
              'N' AS HTML_AT,
              '05' AS OPTION5,
              A.B_CONTENT AS NTT_CN,
              'INTER_CHEAT' AS OPTION19,
              A.B_NUM AS OPTION20
          FROM INTER_CHEAT A

        UNION ALL

        SELECT
              A.B_NUM  AS NTT_ID,
              'B0000028' AS BBS_ID,
              B_M_ID AS NTCR_ID,
              '관리자' AS NTCR_NM,
              A.B_TITLE AS NTT_SJ,
              A.B_READ_CNT AS INQIRE_CO,
              'Y' AS USE_AT,
              B_W_DATE AS FRST_REGIST_PNTTM ,
              B_W_DATE AS LAST_UPDT_PNTTM,
              A.B_M_ID AS FRST_REGISTER_ID,
              A.B_M_ID AS LAST_UPDUSR_ID,
              0 AS PARNTS,
              0 AS NTT_NO,
              0 AS REPLY_LC,
              NULL AS ATCH_FILE_ID,
              '0' AS  DELETE_CODE,
              'N' AS SECRET_AT,
              '2' AS NTT_TYPE,
              'N' AS HTML_AT,
              '06' AS OPTION5,
              A.B_CONTENT AS NTT_CN,
              'INTER_GUIDE' AS OPTION19,
              A.B_NUM AS OPTION20
          FROM INTER_GUIDE A


    ) A
    ORDER BY FRST_REGIST_PNTTM ASC, NTT_ID ASC;


    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1;

END PR_TRAN_EDU_EMPGUIDE_BBS;