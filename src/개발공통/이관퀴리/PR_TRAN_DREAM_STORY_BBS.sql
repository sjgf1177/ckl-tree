CREATE OR REPLACE PROCEDURE PR_TRAN_DREAM_STORY_BBS( p_bbs_id IN VARCHAR2 )
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	/* MAX NTT_ID값 구하기 */
    SELECT NVL(MAX(NTT_ID),0) INTO v_maxNttId FROM TB_BBS_ESTN;
	UPDATE TRAN_TABLESN SET MAX_SN = v_maxNttId WHERE TABLE_NAME = 'TB_BBS_ESTN';


    SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

    /**
    B0000041 : 현장스토리
    B0000042 : 창의인물
    B0000044 : 진행프로젝트
    B0000040 : 보도자료
    B0000043 : 창의클럽커뮤니티
    **/

	/* 창의드림 - 공통   */
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
        OPTION2,
        OPTION18,
        OPTION19,
        OPTION20
    )
     SELECT
        A.IDX + v_maxNttId AS NTT_ID,
        DECODE(A.TYPE,'1001','B0000041','2001','B0000042','4009','B0000044','4007','B0000040','4008','B0000043',NULL),
        NULL,
        NULL,
        A.SUBJECT,
        A.HIT,
        'Y',
        A.REG_DATE,
        A.REG_DATE,
        NULL,
        NULL,
        0,
        0,
        0,
        DECODE(B.BOARD_IDX,NULL,NULL,'FILE_' || LPAD(B.BOARD_IDX+ v_maxFileId,15,'0')),
        0,
        'N',
        '2',
        'N',
        A.CONTENT,
        DECODE(A.TYPE,'2001',DECODE(A.CATEGORY1,'1','03','4','03','2','01','3','02','04'), NULL),
        A.RELATION_IDX,
        A.TYPE,
        A.IDX

    FROM SMARTWORLD.SM_BOARD A
    LEFT OUTER JOIN (
    	SELECT
         	BOARD_IDX
      	FROM SMARTWORLD.SM_BOARD_FILES
      	GROUP BY BOARD_IDX
    ) B ON A.IDX = B.BOARD_IDX
    WHERE A.TYPE = DECODE(p_bbs_id,'B0000041','1001','B0000042','2001','B0000044','4009','B0000040','4007','B0000043','4008',NULL)
    AND A.SHOW = 1
    ORDER BY A.REG_DATE ASC, A.IDX ASC;



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
        FILE_CN,
        FILE_FIELD_NM
    )
    SELECT
    	A.ATCH_FILE_ID,
        B.IDX,
        DECODE(p_bbs_id,
        	'B0000041', '/data/kocca/tmpupload/store/board/',
            'B0000042','/data/kocca/tmpupload/store/mentorstory/thurmb/',
            'B0000044','/data/kocca/tmpupload/store/board/',
            'B0000040','/data/kocca/tmpupload/store/board/',
            'B0000043','/data/kocca/tmpupload/store/board/'
        ) AS PATH,
		MEDIA_URL AS STRE_FILE_NM,
        FILE_NAME,
    	SUBSTR(MEDIA_URL, INSTR(MEDIA_URL, '.', -1) + 1) AS FILE_EXTSN,
        0,
        NULL,
        DECODE(p_bbs_id,
        	'B0000041', 'main_image',
            'B0000042','main_image',
            'B0000044','main_image',
            'B0000040','main_image',
            'B0000043','file' || B.idx
        ) AS FILE_FIELD_NM

    FROM TB_BBS_ESTN A, SMARTWORLD.SM_BOARD_FILES B
    WHERE A.OPTION20 = B.BOARD_IDX
    AND A.BBS_ID = p_bbs_id;

    UPDATE TC_CMMNSN SET NEXT_ID = (SELECT TO_NUMBER(NVL(REPLACE(MAX(ATCH_FILE_ID),'FILE_'),0))+1 FROM TC_COMMNFILE) WHERE TABLE_NAME = 'TC_COMMNFILE';

    UPDATE TB_BBS_ESTN SET
    	OPTION19 = NULL,
    	OPTION20 = NULL
    WHERE DECODE(OPTION19,NULL,0,1) = 1
    AND DECODE(OPTION20,NULL,0,1)  = 1;
	/*  */

END PR_TRAN_DREAM_STORY_BBS;