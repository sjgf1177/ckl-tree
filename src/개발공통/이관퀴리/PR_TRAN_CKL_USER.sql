CREATE OR REPLACE PROCEDURE PR_TRAN_CKL_USER
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN


	/* CKL ±¸ È¸¿ø   */
    INSERT INTO TM_OLD_CKL_USER (
    	USER_SN,
		USER_ID,
        EMAIL,
        MOBLPHON,
        USER_NM,
        LAST_JOIN_DT,
        SBSCRB_DT,
        PASSWORD
    )
      SELECT
      	ROWNUM AS RNUM,
        USER_ID_V,
        EMAIL_V,
        MOBILE_V,
        USER_NM_V,
        LAST_LOGIN_DT_D,
        REG_DT_D,
        USER_PW_V
      FROM CKLDBADMIN.TB_USER_INFO A
      WHERE USE_YN_C = 'Y';

END PR_TRAN_CKL_USER;






