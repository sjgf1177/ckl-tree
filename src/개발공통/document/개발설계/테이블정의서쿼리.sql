SELECT
		(SELECT COMMENTS FROM ALL_TAB_COMMENTS WHERE TABLE_TYPE='TABLE' AND TABLE_NAME=a.TABLE_NAME AND ROWNUM=1 AND OWNER= 'CKL_TREE') AS TABLE_COMMENTS,
    a.TABLE_NAME,
       a.COLUMN_NAME,
       b.COMMENTS ,
       a.DATA_TYPE || '(' || a.DATA_LENGTH || ')' AS f_size, a.DATA_LENGTH,
       NVL
       (
              DECODE(
              (SELECT
                  COUNT(*)
              FROM USER_CONSTRAINTS tA, USER_CONS_COLUMNS tB
              WHERE tA.CONSTRAINT_NAME = tB.CONSTRAINT_NAME
              AND tA.CONSTRAINT_TYPE = 'P'
              AND tA.TABLE_NAME=a.TABLE_NAME
              AND tB.COLUMN_NAME=a.COLUMN_NAME

              ),0,'','PK')

              ,''
          ) AS pk,

       NVL
       (
       		DECODE(
              (SELECT
                  COUNT(*)
              FROM USER_CONSTRAINTS tA, USER_CONS_COLUMNS tB
              WHERE tA.CONSTRAINT_NAME = tB.CONSTRAINT_NAME
              AND tA.CONSTRAINT_TYPE = 'R'
              AND tA.TABLE_NAME=a.TABLE_NAME
              AND tB.COLUMN_NAME=a.COLUMN_NAME
			),0,'','FK' )

            ,''
          ) AS fk,
       DECODE(a.NULLABLE,'N','Not null',''),
       a.DATA_DEFAULT

     FROM ALL_TAB_COLUMNS a,
          ALL_COL_COMMENTS b
    WHERE a.TABLE_NAME=b.TABLE_NAME
          AND a.COLUMN_NAME=b.COLUMN_NAME
          AND a.OWNER='CKL_TREE'
          AND b.OWNER='CKL_TREE'

       	AND (
        	b.TABLE_NAME LIKE 'TB_%'
            OR b.TABLE_NAME LIKE 'TC_%'
            OR b.TABLE_NAME LIKE 'TM_%'
            OR b.TABLE_NAME LIKE 'TN_%'
            OR b.TABLE_NAME LIKE 'TS_%'

        )
        AND b.TABLE_NAME != 'TBL_MCAST_MAGAZINE'

 ORDER BY a.OWNER,
          a.TABLE_NAME,
          COLUMN_ID ASC;




SELECT DISTINCT * FROM (
  SELECT
      (SELECT COMMENTS FROM ALL_TAB_COMMENTS WHERE TABLE_TYPE='TABLE' AND TABLE_NAME=b.TABLE_NAME AND ROWNUM=1 AND OWNER= 'CKL_TREE') AS TABLE_COMMENTS,
      b.TABLE_NAME
  FROM ALL_COL_COMMENTS b
  WHERE b.OWNER='CKL_TREE'
  AND (
      b.TABLE_NAME LIKE 'TB_%'
      OR b.TABLE_NAME LIKE 'TC_%'
      OR b.TABLE_NAME LIKE 'TM_%'
      OR b.TABLE_NAME LIKE 'TN_%'
      OR b.TABLE_NAME LIKE 'TS_%'

  )
  AND b.TABLE_NAME != 'TBL_MCAST_MAGAZINE'

)
ORDER BY TABLE_NAME