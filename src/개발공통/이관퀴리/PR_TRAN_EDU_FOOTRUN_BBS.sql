CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_FOOTRUN_BBS
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';

    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* 콘텐츠아카데미 - 발로뛰는 취창업지원실   */
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
          IDX AS NTT_ID,
          'B0000047' AS BBS_ID,
          NULL	AS NTCR_ID,
          '관리자'	AS NTCR_NM,
          SUBJECT	AS NTT_SJ,
          VIEWCOUNT	AS INQIRE_CO,
          'Y' AS USE_AT,
          REGDATE	AS FRST_REGIST_PNTTM,
          REGDATE	AS LAST_UPDT_PNTTM,
          REGIST_ID	AS FRST_REGISTER_ID,
          NULL  AS LAST_UPDUSR_ID,
          0 AS PARNTS,
          0 AS NTT_NO,
          0 AS REPLY_LC,
          DECODE(ETC_IMAGE1,NULL,NULL,'FILE_' || LPAD(IDX + v_maxFileId ,15,'0')) AS ATCH_FILE_ID,
          '0' AS DELETE_CODE,
          'N' AS SECRET_AT,
          '2' AS NTT_TYPE,
          'N' AS HTML_AT,
          REPLACE(contents,CHR(13) || CHR(10), '<br />') AS NTT_CN,
          CATEGORY AS OPTION19,
          IDX AS OPTION20
      FROM TBL_MCAST_MAGAZINE B
      WHERE OPENYN = 'Y' AND category = '4'
      ORDER BY FRST_REGIST_PNTTM ASC, NTT_ID ASC
    ) A
    ;


    INSERT INTO TC_COMMNFILE (
       ATCH_FILE_ID,
       FRST_REGIST_PNTTM,
       USE_AT
    )
    SELECT
    	ATCH_FILE_ID,
        SYSDATE AS TODAY,
        'Y'
    FROM TB_BBS_ESTN A
    WHERE DECODE(OPTION20,NULL,0,1)  = 1
    AND DECODE(ATCH_FILE_ID,NULL,0,1) = 1
    AND A.BBS_ID = 'B0000047';

	/* IMG1 */
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
        '/data2/cklupload/culturist/img/',
		B.ETC_IMAGE1,
        B.ETC_IMAGE1,
    	SUBSTR(B.ETC_IMAGE1, INSTR(B.ETC_IMAGE1, '.', -1) + 1) AS FILE_EXTSN,
        0,
        'main_image'
    FROM TB_BBS_ESTN A, TBL_MCAST_MAGAZINE B
    WHERE A.OPTION20 = B.IDX
    AND B.OPENYN = 'Y' AND B.category = '4'
    AND ATCH_FILE_ID IS NOT NULL
    AND B.ETC_IMAGE1 IS NOT NULL
    AND A.BBS_ID = 'B0000047';

    /* IMG2 */
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
        '2',
        '/data2/cklupload/culturist/img/',
		B.ETC_IMAGE2,
        B.ETC_IMAGE2,
    	SUBSTR(B.ETC_IMAGE2, INSTR(B.ETC_IMAGE2, '.', -1) + 1) AS FILE_EXTSN,
        0,
        'sub_image1'
    FROM TB_BBS_ESTN A, TBL_MCAST_MAGAZINE B
    WHERE A.OPTION20 = B.IDX
    AND B.OPENYN = 'Y' AND B.category = '4'
    AND ATCH_FILE_ID IS NOT NULL
    AND B.ETC_IMAGE2 IS NOT NULL
    AND A.BBS_ID = 'B0000047';

    /* IMG3 */
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
        '3',
        '/data2/cklupload/culturist/img/',
		B.ETC_IMAGE3,
        B.ETC_IMAGE3,
    	SUBSTR(B.ETC_IMAGE3, INSTR(B.ETC_IMAGE3, '.', -1) + 1) AS FILE_EXTSN,
        0,
        'sub_image2'
    FROM TB_BBS_ESTN A, TBL_MCAST_MAGAZINE B
    WHERE A.OPTION20 = B.IDX
    AND B.OPENYN = 'Y' AND B.category = '4'
    AND ATCH_FILE_ID IS NOT NULL
    AND B.ETC_IMAGE3 IS NOT NULL
    AND A.BBS_ID = 'B0000047';

    /* IMG4 */
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
        '4',
        '/data2/cklupload/culturist/img/',
		B.ETC_IMAGE4,
        B.ETC_IMAGE4,
    	SUBSTR(B.ETC_IMAGE4, INSTR(B.ETC_IMAGE4, '.', -1) + 1) AS FILE_EXTSN,
        0,
        'sub_image3'
    FROM TB_BBS_ESTN A, TBL_MCAST_MAGAZINE B
    WHERE A.OPTION20 = B.IDX
    AND B.OPENYN = 'Y' AND B.category = '4'
    AND ATCH_FILE_ID IS NOT NULL
    AND B.ETC_IMAGE4 IS NOT NULL
    AND A.BBS_ID = 'B0000047';

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
        '5',
        '/data2/cklupload/culturist/img/',
		B.ETC_IMAGE5,
        B.ETC_IMAGE5,
    	SUBSTR(B.ETC_IMAGE5, INSTR(B.ETC_IMAGE5, '.', -1) + 1) AS FILE_EXTSN,
        0,
        'sub_image4'
    FROM TB_BBS_ESTN A, TBL_MCAST_MAGAZINE B
    WHERE A.OPTION20 = B.IDX
    AND B.OPENYN = 'Y' AND B.category = '4'
    AND ATCH_FILE_ID IS NOT NULL
    AND B.ETC_IMAGE5 IS NOT NULL
    AND A.BBS_ID = 'B0000047';


    UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1;

END PR_TRAN_EDU_FOOTRUN_BBS;