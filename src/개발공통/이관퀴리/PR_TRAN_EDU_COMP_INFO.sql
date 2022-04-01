CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_COMP_INFO
IS
v_maxFileId	NUMBER;
BEGIN
	SELECT NEXT_ID INTO v_maxFileId FROM TC_CMMNSN WHERE TABLE_NAME = 'TC_COMMNFILE';

	/* 채용정보 - 기업정보   */
    INSERT INTO TN_ENTRPRS_INFO (
      ENTRPRS_SN,
      ENTRPRS_NM,
      LST_AT,
      RPRSNTV,
      EMPL_CO,
      FOND_YEAR,
      HMPG,
      CAPL,
      ENTRPRS_STLE,
      CHARGER,
      TELNO,
      EMAIL,
      USE_AT,
      FRST_REGIST_PNTTM,
      FRST_REGISTER_ID,
      LAST_UPDT_PNTTM,
      LAST_UPDUSR_ID,
      DELETE_AT,
      LOGO_URL
 )
  SELECT
      A.ENTRPRS_SN,
      A.ENTRPRS_NM,
      A.LST_AT,
      A.RPRSNTV,
      A.EMPL_CO,
      A.FOND_YEAR,
      A.HOMPAGE,
      A.CAPL,
      A.ENTRPRS_FORM,
      A.CHARGER_NM,
      A.TEL,
      A.EMAIL,
      'Y',
      A.FRST_REGIST_PNTTM,
      NULL,
      A.LAST_UPDT_PNTTM,
      NULL,
      '0',
      CASE
      WHEN INSTR(A.LOGO_URL,'http://') > 0 THEN A.LOGO_URL
      WHEN A.LOGO_URL IS NULL THEN A.LOGO_URL
      ELSE '/files/company/logo/' || A.LOGO_URL
      END AS LOGO_URL

    FROM COMP_INFO A;


    UPDATE TN_ENTRPRS_INFO A SET
    LOGO_URL = '/upload/culturist/careers' || REPLACE(REPLACE(LOGO_URL,'http://job.kocca.or.kr',''),'http://kocca.career.co.kr','');

    UPDATE TN_ENTRPRS_INFO A SET
    LOGO_URL = null
    WHERE LOGO_URL = '/upload/culturist/careers';

END PR_TRAN_EDU_COMP_INFO;

