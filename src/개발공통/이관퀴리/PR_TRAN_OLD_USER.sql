CREATE OR REPLACE PROCEDURE PR_TRAN_OLD_USER
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	DELETE FROM TM_OLD_CKL_USER;

    DELETE FROM TM_OLD_DREAM_USER;

	/* CKL 회원   */
    INSERT INTO TM_OLD_CKL_USER (
    	USER_SN,
    	USER_ID,
        PASSWORD,
       	EMAIL,
        MOBLPHON,
       	USER_NM,
       	LAST_JOIN_DT,
       	SBSCRB_DT
    )
    SELECT ROWNUM AS USER_SN, TB.* FROM (
      SELECT
          USER_ID_V,
          USER_PW_V,
          EMAIL_V,
          MOBILE_V,
          USER_NM_V,
          LAST_LOGIN_DT_D,
          REG_DT_D
      FROM CKLDBADMIN.TB_USER_INFO A
      WHERE A.USE_YN_C = 'Y'
      ORDER BY REG_DT_D ASC
    ) TB;


    /* 창의드림 회원   */
    INSERT INTO TM_OLD_DREAM_USER (
    	USER_SN,
    	USER_ID,
        PASSWORD,
       	EMAIL,
        MOBLPHON,
       	USER_NM,
       	LAST_JOIN_DT,
       	SBSCRB_DT
    )
    SELECT
        IDX,
        EMAIL,
        PASSWORD,
        EMAIL,
        HP_NUMBER,
        NAME,
        NULL AS LAST_JOIN_DT,
        REG_DATE
    FROM SMARTWORLD.SM_USERS A
    WHERE USE = '1' AND TYPE = '6'
    ORDER BY REG_DATE ASC;


END PR_TRAN_OLD_USER;