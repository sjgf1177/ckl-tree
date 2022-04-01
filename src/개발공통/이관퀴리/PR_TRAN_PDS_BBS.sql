
CREATE OR REPLACE PROCEDURE CKL_TREE.PR_TRAN_PDS_BBS

IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';


    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* 콘텐츠아카데미 - 취업자료실  */
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
        v_maxNttId + A.PDS_ID AS NTT_ID,
        'B0000031',
        '',
        '',
        A.TITLE,
        A.HIT_NUM,
        'Y',
        A.REG_DATE,
        A.REG_DATE,
        '',
        '',
        0,
        0,
        0,
        DECODE(A.ATTACH_FILE,NULL,NULL,'FILE_' || LPAD(A.PDS_ID+v_maxFileId,15,'0')) AS ATCH_FILE_ID,
        0,
        'N',
        '2',
        'N',
        A.CONT AS NTT_CN,
        CASE WHEN A.DATA_GUBUN = 54 THEN '01'
             WHEN A.DATA_GUBUN = 55 THEN '02'
        ELSE '03'
        END AS OPTION5,
        NULL AS OPTION19,
        A.PDS_ID AS OPTION20
    FROM PDS A
    ORDER BY A.REG_DATE ASC;



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
    WHERE DECODE(OPTION20,NULL,0,1) = 1
    AND DECODE(ATCH_FILE_ID,NULL,0,1) = 1
    AND BBS_ID = 'B0000031';



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
        '/upload/culturist/pds/',
		B.ATTACH_FILE,
        B.ATTACH_FILE,
    	SUBSTR(B.ATTACH_FILE, INSTR(B.ATTACH_FILE, '.', -1) + 1) AS FILE_EXTSN,
        0,
        NULL
    FROM TB_BBS_ESTN A, PDS B
    WHERE A.OPTION20 = B.PDS_ID
    AND B.ATTACH_FILE IS NOT NULL
    AND A.BBS_ID = 'B0000031';

    UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1) = 1;
	/*  */

END PR_TRAN_PDS_BBS;

