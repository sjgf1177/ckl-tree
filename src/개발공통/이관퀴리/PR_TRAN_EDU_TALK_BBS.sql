CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_TALK_BBS
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';

    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* 콘텐츠아카데미 - 아카데미 이야기   */
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
          A.SEQ  AS NTT_ID,
          'B0000023' AS BBS_ID,
          REG_ID AS NTCR_ID,
          '관리자' AS NTCR_NM,
          A.TITLE AS NTT_SJ,
          A.VIEW_COUNT AS INQIRE_CO,
          'Y' AS USE_AT,
          REG_DT AS FRST_REGIST_PNTTM ,
          MOD_DT AS LAST_UPDT_PNTTM,
          A.REG_ID AS FRST_REGISTER_ID,
          A.MOD_ID AS LAST_UPDUSR_ID,
          0 AS PARNTS,
          0 AS NTT_NO,
          0 AS REPLY_LC,
          NULL AS ATCH_FILE_ID,
          '0' AS  DELETE_CODE,
          'N' AS SECRET_AT,
          '2' AS NTT_TYPE,
          'N' AS HTML_AT,
          A.CONT AS NTT_CN,
          NULL AS OPTION19,
		  A.SEQ AS OPTION20
      FROM KOCCA.TZ_BOARD_TONG A
      LEFT OUTER JOIN (
      	SELECT
        	SEQ
        FROM KOCCA.TZ_BOARDFILE_TONG
        GROUP BY SEQ
      ) B ON A.SEQ = B.SEQ
      WHERE  A.USE_YN  = 'Y'
	  ORDER BY FRST_REGIST_PNTTM ASC, NTT_ID ASC
    ) A
    ;


    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1;

END PR_TRAN_EDU_TALK_BBS;