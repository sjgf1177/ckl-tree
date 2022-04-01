CREATE OR REPLACE PROCEDURE PR_TRAN_DREAM_USER
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN


	/* 창의동반 구 회원   */
    INSERT INTO TM_OLD_DREAM_USER (
    	USER_SN,
		USER_ID,
        EMAIL,
        MOBLPHON,
        USER_NM,
        LAST_JOIN_DT,
        SBSCRB_DT,
        PASSWORD,
        BIRTH
    )
      SELECT
      	ROWNUM AS RNUM,
        EMAIL,
        EMAIL,
        HP_NUMBER,
        NAME,
        NULL,
        REG_DATE,
        PASSWORD,
        NULL
        --TO_DATE(REPLACE(REPLACE(A.BIRTH,'null',''),'0','') ,'YYYY-MM-DD')  AS BIRTH
      FROM SMARTWORLD.SM_USERS A
      WHERE USE = '1';

END PR_TRAN_DREAM_USER;







