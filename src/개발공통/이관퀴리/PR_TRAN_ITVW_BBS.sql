CREATE OR REPLACE PROCEDURE CKL_TREE.PR_TRAN_ITVW_BBS

IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID�� ���ϱ� */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';


    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* �������ī���� - �������ͺ�  */
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
        OPTION1,
        OPTION2,
        OPTION3,
        OPTION4,
        OPTION19,
        OPTION20
    )
     SELECT
        v_maxNttId + JE_ID AS NTT_ID,
        'B0000027',
        '',
        '',
        A.JOB_NAME,
        0,
        'Y',
        A.REG_DATE,
        A.REG_DATE,
        '',
        '',
        0,
        0,
        0,
        DECODE(ATTACH_FILE,NULL,NULL,'FILE_' || LPAD(JE_ID+v_maxFileId,15,'0')) AS ATCH_FILE_ID,
        0,
        'N',
        '2',
        'N',
        A.CONT AS NTT_CN,
        A.REG_NAME AS OPTION1,
        A.JOB_NAME AS OPTION2,
        CASE WHEN A.DIV_CODE = 1 THEN '09'
             WHEN A.DIV_CODE = 2 THEN '10'
             WHEN A.DIV_CODE = 4 THEN '02'
             WHEN A.DIV_CODE = 5 THEN '05'
             WHEN A.DIV_CODE = 6 THEN '08'
             WHEN A.DIV_CODE = 7 THEN '01'
             WHEN A.DIV_CODE = 8 THEN '06'
             WHEN A.DIV_CODE = 9 THEN '07'
             WHEN A.DIV_CODE = 10 THEN '04'
             WHEN A.DIV_CODE = 11 THEN '03'
        ELSE '11'
        END AS OPTION3,
        A.ORGAN ||' '|| A.DEPART AS OPTION4,
        NULL AS OPTION19,
        JE_ID AS OPTION20
    FROM JOB_EXP A
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
    AND BBS_ID = 'B0000027';



    INSERT INTO TC_COMMNFILE_DETAIL (
    	ATCH_FILE_ID,
        FILE_SN,
        FILE_STRE_COURS,
        STRE_FILE_NM,
        ORIGNL_FILE_NM,
        FILE_EXTSN,
        FILE_MG,
        FILE_CN,
        FILE_FIELD_NM
    )
    SELECT
    	A.ATCH_FILE_ID,
        '1',
        '/upload/culturist/itvw/',
		B.REG_PICT,
        B.REG_PICT,
    	SUBSTR(B.REG_PICT, INSTR(B.REG_PICT, '.', -1) + 1) AS FILE_EXTSN,
        0,
        NULL,
        'main_image'
    FROM TB_BBS_ESTN A, JOB_EXP B
    WHERE A.OPTION20 = B.JE_ID
    AND B.REG_PICT IS NOT NULL
    AND A.BBS_ID = 'B0000027';

    UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1) = 1;
	/*  */

END PR_TRAN_ITVW_BBS;

