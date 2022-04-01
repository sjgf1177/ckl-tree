SELECT ROWNUM RN,
       TABLE_NAME || '(' || (SELECT COMMENTS FROM ALL_TAB_COMMENTS WHERE OWNER='KI_POTAL' AND  TABLE_NAME=tb.TABLE_NAME) || ')' AS TABLE_NAME,
       TABLESPACE_NAME,
       (SELECT (COUNT(*) + SUM
              (
                  CASE
                      WHEN DATA_LENGTH>250
                      THEN 1
                      ELSE 0
                  END
              )
              ) COLUMN_CNT
         FROM ALL_TAB_COLUMNS
        WHERE TABLE_NAME = tb.TABLE_NAME
       )  COLUMN_CNT,
       (SELECT ROUND((SUM(DATA_LENGTH)/COUNT(*)),0)  FROM ALL_TAB_COLUMNS WHERE TABLE_NAME=tb.TABLE_NAME) AS AVG_DATA,
       100000 AS "레코드수(상황고려 수정)",
        PCT_FREE,
        '' "SIZE(KB)",
        '' "변경비율",
        '' "Total Size(MB)"
  FROM ALL_TABLES  tb
 WHERE OWNER='KI_POTAL'


===========================
INDEX 산정
===========================
SELECT index_name,
       MAX(tablespace_name),
       COUNT(column_name) column_cnt,
       --SUM(NUM_ROWS) ,
       SUM(DATA_LENGTH)
  FROM
       (SELECT C.table_name,
              C.index_name,
              tablespace_name,
              C.column_name,
              C.column_position,
              T.num_rows ,
              (SELECT DATA_LENGTH
                FROM ALL_TAB_COLUMNS
               WHERE TABLE_NAME=C.table_name
                     AND COLUMN_NAME=C.column_name
              ) AS DATA_LENGTH
         FROM all_ind_columns C,
              (SELECT table_name,
                     num_rows,
                     tablespace_name
                FROM all_tables
               WHERE owner = 'KI_POTAL'
                     AND num_rows > 0
              ) T
        WHERE C.table_name = T.table_name
       ) tb
 GROUP BY index_name
