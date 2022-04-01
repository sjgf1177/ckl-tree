CREATE OR REPLACE PROCEDURE PR_TRAN_EDU_USER
IS
v_maxNttId NUMBER;
v_maxFileId	NUMBER;
BEGIN
	SELECT NVL(MAX(USER_SN),0) INTO v_maxNttId FROM TM_USER;

	/* EDU 회원(통합회원)   */
    INSERT INTO TM_USER (
       USER_SN,
       MBER_SE,
       USER_ID,
       PASSWORD,
       USER_NM,
       EMAIL,
       MBTLNUM,
       --BRTHDY,
       SEX,
       EMAIL_AT,
       SMS_AT,
       PWD_CHANGE_DT,
       SBSCRB_DT,
       LAST_LOGIN_DT,
       AGRE_AT,
       AGRE_DT,
       AUTH_SE,
       AUTH_DT,
       USER_STTUS,
       LAST_UPDT_PNTTM,
       AUTH_EMAIL_AT,
       USE_AT
    )
    SELECT ROWNUM+v_maxNttId AS USER_SN , TB.* FROM (
      SELECT
      		'01' AS MBER_SE,
          	USERID,
			PWD,
            NAME,
            EMAIL,
            HANDPHONE,
            --TO_DATE(A.MEMBERYEAR ||'-'|| A.MEMBERMONTH ||'-'|| A.MEMBERDAY,'YYYY-MM-DD')  AS BRTHDY,
           -- DECODE(A.MEMBERMONTH, NULL,TO_DATE(A.MEMBERYEAR ||'-'|| LPAD(A.MEMBERMONTH,2,'0') ||'-'|| LPAD(A.MEMBERDAY,2,'0'),'YYYY-MM-DD'),NULL) AS BRTHDY,
            DECODE(SEX, '1', 'M','2','W') AS SEX,
            ISMAILING,
            ISSMS,
            SYSDATE AS PWD_CHANGE_DT,
            TO_DATE(REPLACE(REPLACE(REPLACE(INDATE,'-',''),':',''),' ',''),'YYYYMMDDHH24MISS') AS INDATE1,
            TO_DATE(REPLACE(REPLACE(REPLACE(LGLAST,'-',''),':',''),' ',''),'YYYYMMDDHH24MISS') AS LGLAST,
            'N' AS AGRE_AT,
            null,
            '01' AS AUTH_SE,
            TO_DATE(REPLACE(REPLACE(REPLACE(INDATE,'-',''),':',''),' ',''),'YYYYMMDDHH24MISS') AS INDATE3,
            'Y' AS USER_STTUS,
            NULL AS LDATE4,
            --TO_DATE(REPLACE(REPLACE(REPLACE(LDATE,'-',''),':',''),' ',''),'YYYYMMDDHH24MISS') AS LDATE4,
            'Y' AS AUTH_EMAIL_AT,
            'Y' AS USE_AT
      FROM kocca.TZ_MEMBER A
      WHERE  GRCODE = 'N000001' AND STATE = 'Y'
      ORDER BY INDATE1 ASC
    ) TB;

END PR_TRAN_EDU_USER;