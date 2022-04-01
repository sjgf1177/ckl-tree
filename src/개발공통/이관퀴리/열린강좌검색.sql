SELECT
	A.SEQ ,   --번호
   	A.LECNM , --제목
   	REPLACE(A.VODIMG,'\','/') AS VODIMG,   -- 이미지경로
   	A.TUTORNM , 		-- 강사명
   	A.LECTURE_CLS,  -- 분류코드
	DECODE(A.LECTURE_CLS,
    	'GC01','방송영상','GC02','게임','GC03','만화애니캐릭터','GC04','음악공연','GC05','기타',
        'GC06','콘텐츠 인사이트','GC07','마스터 클래스','GC08','휴넷열린강좌'
    ) AS LECTURE_CLS_NM,  -- 분류명
    TO_DATE(A.LDATE,'YYYYMMDDHH24MISS') AS LDATE,   -- 등록일
    '500085' AS MENU_NO,
    '열린강좌' AS MENU_NM,
    '/edu/onlineEdu/openLecture/view.do?pSeq' || A.SEQ || '&menuNo=500085'  AS LINK

FROM TZ_GOLDCLASS A ,
TZ_GOLDCLASS_GRMNG B ,
(
	SELECT SEQ,
        RANK() OVER( ORDER BY SUM(CNT) DESC, COUNT(SEQ) DESC, SEQ DESC) AS RNK
   	FROM TZ_VIEWCOUNT
  	WHERE VIEWDATE BETWEEN TO_CHAR(SYSDATE - 7, 'YYYYMMDD') AND TO_CHAR(SYSDATE, 'YYYYMMDD') /*WHERE VIEWDATE BETWEEN ADD_MONTHS(SYSDATE, -1) AND TO_CHAR(SYSDATE, 'YYYYMMDD') */
  	GROUP BY SEQ
) V
 WHERE A.USEYN = 'Y'
 AND B.GRCODE = 'N000001' /* getSession = tem_grcode */
 AND A.SEQ = B.SEQ(+)
 AND A.SEQ = V.SEQ(+)
ORDER BY V.RNK, A.LDATE DESC, A.SEQ DESC