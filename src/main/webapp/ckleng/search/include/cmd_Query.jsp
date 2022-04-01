<%!
	
	public static SelectSet[] kistep_getselectSet = null;
	public static SelectSet[] bbs_getselectSet = null;
	public static SelectSet[] orgin_getselectSet = null;  //05.21 추가
	public static SelectSet[] attfile_getselectSet = null;
	public static SelectSet[] kistep_selectSet = null; //검색 결과에서 가져올 필드명 설정하는데 필요한 변수
	public static SelectSet[] bbs_selectSet = null; //검색 결과에서 가져올 필드명 설정하는데 필요한 변수
	public static SelectSet[] orgin_selectSet = null; //검색 결과에서 가져올 필드명 설정하는데 필요한 변수
	public static SelectSet[] attfile_selectSet = null; //검색 결과에서 가져올 필드명 설정하는데 필요한 변수

	public static OrderBySet[] kistep_orderbys = null;
	public static FilterSet[] kistep_filterSet = null; //필터링하는데 필요한 필드를 필터링할 방법들을 같이 모아두는 변수

	public static String kistepwhereSetStr ="";
	public static String orginwhereSetStr ="";
	public static String attfilewhereSetStr ="";


	public static String nullCheck(String str) throws Exception {
		if(str == null || str == "") return "";
		str = str.replaceAll("<","&lt;");
		str = str.replaceAll(">","&gt;");
		str = str.replaceAll("&","&amp;");
		str = str.replaceAll("'","&#39;");
		return str.trim();
	}

	/*
	 * 공통 SelectSet
	*/
	public static SelectSet[] kistep_selectSet(String cate){
		SelectSet[] selectSet = null;

		if(cate.equals("orgin")){
			selectSet = new SelectSet[]{
				new SelectSet("NTT_CLS", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_SJ", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_CN", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_ORGIN", Protocol.SelectSet.HIGHLIGHT),
				new SelectSet("NTT_URL", Protocol.SelectSet.NONE),
				new SelectSet("REG_DATE", Protocol.SelectSet.NONE),
				new SelectSet("NTT_ORGIN_PH", Protocol.SelectSet.HIGHLIGHT),
				new SelectSet("WEIGHT", Protocol.SelectSet.NONE)
			};
		}else if(cate.equals("attfile")){ 
			selectSet = new SelectSet[]{
				new SelectSet("ORIGNL_FILE_NM", Protocol.SelectSet.HIGHLIGHT),
				new SelectSet("ATT_CN", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("ATT_URL", Protocol.SelectSet.NONE),
				new SelectSet("NTT_SJ", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_URL", Protocol.SelectSet.NONE),
				new SelectSet("REG_DATE", Protocol.SelectSet.NONE),
				new SelectSet("BBS_NM", Protocol.SelectSet.NONE),
				new SelectSet("WEIGHT", Protocol.SelectSet.NONE)	
					
			};
			
		}else if(cate.equals("bbs")){ 
			selectSet = new SelectSet[]{
				new SelectSet("NTT_CLS", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_SJ", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_CN", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_ORGIN", Protocol.SelectSet.HIGHLIGHT),
				new SelectSet("NTT_URL", Protocol.SelectSet.NONE),
				new SelectSet("REG_DATE", Protocol.SelectSet.NONE),
				new SelectSet("BBS_NM", Protocol.SelectSet.NONE),
				new SelectSet("WEIGHT", Protocol.SelectSet.NONE)					
			};
			
		}else{
			selectSet = new SelectSet[]{
				new SelectSet("NTT_CLS", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_SJ", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_CN", (byte)(Protocol.SelectSet.SUMMARIZE | Protocol.SelectSet.HIGHLIGHT), 200),
				new SelectSet("NTT_ORGIN", Protocol.SelectSet.HIGHLIGHT),
				new SelectSet("NTT_URL", Protocol.SelectSet.NONE),
				new SelectSet("REG_DATE", Protocol.SelectSet.NONE),
				new SelectSet("WEIGHT", Protocol.SelectSet.NONE)					
			};
		}

		return selectSet;
	}

	/*
	 * 공통 whereSet
	*/
	public static ArrayList kistep_whereSet (String searchQuery, String cate, String searchArea){
		
		int whereCheck =0;
		//검색한 결과의 리스트를 담는 변수
		ArrayList whereList = new ArrayList();
		String[] searchQueryArr = searchQuery.split("\\$\\|");
		
		for(int i=0; i < searchQueryArr.length; i++){
			whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_OPEN));

			if(!cate.equals("attfile")){
				if(searchArea.equals("total") || searchArea.equals("title")){
					whereList.add(new WhereSet ("NTT_SJ", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 1000));  //제목
					whereCheck++;
				}
				if(searchArea.equals("total") || searchArea.equals("contents")){
					if(whereCheck > 0){
						whereList.add(new WhereSet (Protocol.WhereSet.OP_OR)); 
					}
					whereList.add(new WhereSet ("NTT_CN", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 800));   //내용
					whereCheck++;
				}
				if(searchArea.equals("total") || searchArea.equals("orgin")){
					if(whereCheck > 0){
						whereList.add(new WhereSet (Protocol.WhereSet.OP_OR)); 
					}
					whereList.add(new WhereSet ("NTT_ORGIN", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 500));  //출처기관
					if(cate.equals("orgin")){
						whereList.add(new WhereSet (Protocol.WhereSet.OP_OR)); 
						whereList.add(new WhereSet ("NTT_ORGIN_PH", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 200));  //출처기관 패스
					}
					whereCheck++;
				}
				if(searchArea.equals("total") || searchArea.equals("keyword")){
					if(whereCheck > 0){
						whereList.add(new WhereSet (Protocol.WhereSet.OP_OR)); 
					}
					whereList.add(new WhereSet ("NTT_KEYWORD", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 300));   //키워드
				}
			}else{
				if(searchArea.equals("total") || searchArea.equals("title")){
					whereList.add(new WhereSet ("ORIGNL_FILE_NM", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 1000));  //원파일명
					whereList.add(new WhereSet (Protocol.WhereSet.OP_OR)); 
					whereList.add(new WhereSet ("NTT_SJ", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 1000));  //제목
					whereCheck++;
				}
				if(searchArea.equals("total") || searchArea.equals("contents")){
					if(whereCheck > 0){
						whereList.add(new WhereSet (Protocol.WhereSet.OP_OR)); 
					}
					whereList.add(new WhereSet ("ATT_CN", Protocol.WhereSet.OP_HASALL, searchQueryArr[i], 800));   //첨부파일 내용
					whereCheck++;
				}
			}
			whereList.add(new WhereSet(Protocol.WhereSet.OP_BRACE_CLOSE));
			if(i < searchQueryArr.length-1){
				whereList.add(new WhereSet (Protocol.WhereSet.OP_AND)); 
			}
		}
		
		
		return whereList;
	}

	/*
	 * 공통 OrderBySet
	*/
	public static OrderBySet[] kistep_orderBySet(String searchSort){
		
		OrderBySet[] orderbys = new OrderBySet[1]; 
		if(searchSort.equals("date")){  //최신순
			orderbys[0] = new OrderBySet(true, "REG_DATE", Protocol.OrderBySet.OP_POSTWEIGHT);
		}else{   //정확도
			orderbys[0] = new OrderBySet(true, "REG_DATE", Protocol.OrderBySet.OP_PREWEIGHT); 
		}
		return orderbys;
	}

	/*
	 * 공통 FilterSet
	*/
	public static FilterSet[] kistep_filterSet(String searchStartDate, String searchEndDate){
		FilterSet[] filterSet = null;
		ArrayList filterList = new ArrayList(); //필터링 할 리스트를 담는 변수

		if(!searchStartDate.equals("") && !searchEndDate.equals("")){
			String startDate = searchStartDate.replaceAll("-","");
			String endDate = searchEndDate.replaceAll("-","");
			filterList.add(new FilterSet(Protocol.FilterSet.OP_RANGE, "REG_DATE", new String[]{startDate, endDate}));
		}
		
		// arraylist 담긴 filter를 filterSet에 담는다.
		filterSet = new FilterSet[filterList.size()];
		for (int i = 0; i < filterList.size(); i++) {
			filterSet[i] = (FilterSet) filterList.get(i);
		}

		return filterSet;
	}

	/*
	 * 통합검색 API
	*/
	public static Result[] getSearchResults(String searchQuery, String allsearchQuery, String searchCategory, String searchSort,  String searchArea, String searchStartDate, String searchEndDate, String researchQuery,
	    int page_start, int page_size, String SEARCH_HOST,int SEARCH_PORT) throws Exception{
				
		Result[] resultlist = null; //검색결과를 가지고 있는 변수

		//공통 OrderBySet 지정=====================================================================================================
		kistep_orderbys = kistep_orderBySet(searchSort);
		//공통 OrderBySet 지정=====================================================================================================

		//공통 FilterSet 설정=====================================================================================================
		kistep_filterSet = kistep_filterSet(searchStartDate, searchEndDate);
		//공통 FilterSet 설정=====================================================================================================


		//HRST 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query hrst_m3Query = null; //쿼리를 담는 부분
		ArrayList whereList_hrst = new ArrayList();
		ArrayList whereList_hrst_where = new ArrayList();
		WhereSet[] hrst_whereSet = null; //검색에서 검색을 할 필드를 설정하는데 필요한 변수
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		//SelectSet 지정=====================================================================================================
		kistep_selectSet = kistep_selectSet("");
		//SelectSet 지정=====================================================================================================
		
		//WhereSet 지정=====================================================================================================	
		//결과내 재검색
		/*if (researchQuery.equals("on")) {
			System.out.println(kistepwhereSetStr);
			WhereSet[] old_whereSet = parser.parseWhereSet(kistepwhereSetStr);       
			for(int i = 0; i < old_whereSet.length; i++){
				whereList_hrst.add(old_whereSet[i]);
			}  
			whereList_hrst.add(new WhereSet(Protocol.WhereSet.OP_AND)); //이전쿼리와 현재쿼리가  and로 검색
			
		}*/
		whereList_hrst_where = kistep_whereSet(allsearchQuery, "", searchArea);
		
		for(int w=0; w < whereList_hrst_where.size(); w++ ){
			whereList_hrst.add(whereList_hrst_where.get(w));
		}

		//arraylist 담긴 where를 whereSet에 담는다.
		hrst_whereSet = new WhereSet[whereList_hrst.size()];
		for (int i = 0; i < whereList_hrst.size(); i++) {
			hrst_whereSet[i] = (WhereSet) whereList_hrst.get(i);
		}

		hrst_m3Query = new Query(startTag, endTag);
		hrst_m3Query.setOrderby(kistep_orderbys);
		hrst_m3Query.setSelect(kistep_selectSet);
		hrst_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			hrst_m3Query.setFilter(kistep_filterSet);
		}
		hrst_m3Query.setFrom("HRST"); // 사용할 콜렉션에 요청한다.
		
		hrst_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		hrst_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		hrst_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		hrst_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		hrst_m3Query.setPrintQuery(false); 
		hrst_m3Query.setLoggable(true);
		hrst_m3Query.setDebug(true);  
		hrst_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( hrst_m3Query );
		//System.out.print(queryStr);
		kistepwhereSetStr = parser.whereSetToString(hrst_whereSet);
		//System.out.println("kistepwhereSetStr " +kistepwhereSetStr);
		
		//RSTI 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query rsti_m3Query = null; //쿼리를 담는 부분
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		
		rsti_m3Query = new Query(startTag, endTag);
		rsti_m3Query.setOrderby(kistep_orderbys);
		rsti_m3Query.setSelect(kistep_selectSet);
		rsti_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			rsti_m3Query.setFilter(kistep_filterSet);
		}
		rsti_m3Query.setFrom("RSTI"); // 사용할 콜렉션에 요청한다.
		
		rsti_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//rsti_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		rsti_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		rsti_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		rsti_m3Query.setPrintQuery(false); 
		//rsti_m3Query.setLoggable(true);
		rsti_m3Query.setDebug(true);  
		//rsti_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( rsti_m3Query );
		//System.out.print(queryStr);
		
		//RDPS 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query rdps_m3Query = null; //쿼리를 담는 부분
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		
		rdps_m3Query = new Query(startTag, endTag);
		rdps_m3Query.setOrderby(kistep_orderbys);
		rdps_m3Query.setSelect(kistep_selectSet);
		rdps_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			rdps_m3Query.setFilter(kistep_filterSet);
		}
		rdps_m3Query.setFrom("RDPS"); // 사용할 콜렉션에 요청한다.
		
		rdps_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//rdps_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		rdps_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		rdps_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		rdps_m3Query.setPrintQuery(false); 
		//rdps_m3Query.setLoggable(true);
		rdps_m3Query.setDebug(true);  
		//rdps_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( rdps_m3Query );
		//System.out.print(queryStr);
		

		//ICST 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query icst_m3Query = null; //쿼리를 담는 부분
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		
		icst_m3Query = new Query(startTag, endTag);
		icst_m3Query.setOrderby(kistep_orderbys);
		icst_m3Query.setSelect(kistep_selectSet);
		icst_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			icst_m3Query.setFilter(kistep_filterSet);
		}
		icst_m3Query.setFrom("ICST"); // 사용할 콜렉션에 요청한다.
		
		icst_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//icst_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		icst_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		icst_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		icst_m3Query.setPrintQuery(false); 
		//icst_m3Query.setLoggable(true);
		icst_m3Query.setDebug(true);  
		//icst_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( icst_m3Query );
		//System.out.print(queryStr);
		
		//BIS 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query bis_m3Query = null; //쿼리를 담는 부분
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		
		bis_m3Query = new Query(startTag, endTag);
		bis_m3Query.setOrderby(kistep_orderbys);
		bis_m3Query.setSelect(kistep_selectSet);
		bis_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			bis_m3Query.setFilter(kistep_filterSet);
		}
		bis_m3Query.setFrom("BIS"); // 사용할 콜렉션에 요청한다.
		
		bis_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//bis_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		bis_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		bis_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		bis_m3Query.setPrintQuery(false); 
		//bis_m3Query.setLoggable(true);
		bis_m3Query.setDebug(true);  
		//bis_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( bis_m3Query );
		//System.out.print(queryStr);	
	
		//AIM 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query aim_m3Query = null; //쿼리를 담는 부분
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		
		aim_m3Query = new Query(startTag, endTag);
		aim_m3Query.setOrderby(kistep_orderbys);
		aim_m3Query.setSelect(kistep_selectSet);
		aim_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			aim_m3Query.setFilter(kistep_filterSet);
		}
		aim_m3Query.setFrom("AIM"); // 사용할 콜렉션에 요청한다.
		
		aim_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//aim_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		aim_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		aim_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		aim_m3Query.setPrintQuery(false); 
		//aim_m3Query.setLoggable(true);
		aim_m3Query.setDebug(true);  
		//aim_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( aim_m3Query );
		//System.out.print(queryStr);	

		//BBS 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query bbs_m3Query = null; //쿼리를 담는 부분
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수

		//SelectSet 지정=====================================================================================================
		bbs_selectSet = kistep_selectSet("bbs");
		//SelectSet 지정=====================================================================================================
		
		bbs_m3Query = new Query(startTag, endTag);
		bbs_m3Query.setOrderby(kistep_orderbys);
		bbs_m3Query.setSelect(bbs_selectSet);
		bbs_m3Query.setWhere(hrst_whereSet); 
		if (kistep_filterSet != null) {
			bbs_m3Query.setFilter(kistep_filterSet);
		}
		bbs_m3Query.setFrom("BBS"); // 사용할 콜렉션에 요청한다.
		
		bbs_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//bbs_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		bbs_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		bbs_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		bbs_m3Query.setPrintQuery(false); 
		//bbs_m3Query.setLoggable(true);
		bbs_m3Query.setDebug(true);  
		//bbs_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( bbs_m3Query );
		//System.out.print(queryStr);	
		

		//ORGIN 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query orgin_m3Query = null; //쿼리를 담는 부분
		ArrayList whereList_orgin = new ArrayList();
		ArrayList whereList_orgin_where = new ArrayList();
		WhereSet[] orgin_whereSet = null; //검색에서 검색을 할 필드를 설정하는데 필요한 변수
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		//SelectSet 지정=====================================================================================================
		orgin_selectSet = kistep_selectSet("orgin");
		//SelectSet 지정=====================================================================================================
		
		//WhereSet 지정=====================================================================================================	
		//결과내 재검색
		/*if (researchQuery.equals("on")) {
			WhereSet[] old_whereSet = parser.parseWhereSet(orginwhereSetStr);       
			for(int i = 0; i < old_whereSet.length; i++){
				whereList_orgin.add(old_whereSet[i]);
			}  
			whereList_orgin.add(new WhereSet(Protocol.WhereSet.OP_AND)); //이전쿼리와 현재쿼리가  and로 검색
			
		}
		*/
		whereList_orgin_where = kistep_whereSet(allsearchQuery, "orgin", searchArea);
		
		for(int w=0; w < whereList_orgin_where.size(); w++ ){
			whereList_orgin.add(whereList_orgin_where.get(w));
		}

		//arraylist 담긴 where를 whereSet에 담는다.
		orgin_whereSet = new WhereSet[whereList_orgin.size()];
		for (int i = 0; i < whereList_orgin.size(); i++) {
			orgin_whereSet[i] = (WhereSet) whereList_orgin.get(i);
		}

		
		orgin_m3Query = new Query(startTag, endTag);
		orgin_m3Query.setOrderby(kistep_orderbys);
		orgin_m3Query.setSelect(orgin_selectSet);
		orgin_m3Query.setWhere(orgin_whereSet); 
		if (kistep_filterSet != null) {
			orgin_m3Query.setFilter(kistep_filterSet);
		}
		orgin_m3Query.setFrom("ORGIN"); // 사용할 콜렉션에 요청한다.
		
		orgin_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//orgin_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		orgin_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		orgin_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		orgin_m3Query.setPrintQuery(false); 
		//orgin_m3Query.setLoggable(true);
		orgin_m3Query.setDebug(true);  
		//orgin_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( orgin_m3Query );
		//System.out.print(queryStr);
		orginwhereSetStr = parser.whereSetToString(orgin_whereSet);


		//ATTFILE 쿼리   ===========================================================================================================
		//아래의 경우는 엔진에 넘겨줄 셋팅 결과 그룹정보들을 설정하는데 필요한 정보타입설정..
		Query attfile_m3Query = null; //쿼리를 담는 부분
		ArrayList whereList_attfile = new ArrayList();
		ArrayList whereList_attfile_where = new ArrayList();
		WhereSet[] attfile_whereSet = null; //검색에서 검색을 할 필드를 설정하는데 필요한 변수
		
		// 엔진으로 넘겨줄 명령어 setting 
		//검색한 결과의 리스트를 담는 변수
		//SelectSet 지정=====================================================================================================
		attfile_selectSet = kistep_selectSet("attfile");
		//SelectSet 지정=====================================================================================================
		
		//WhereSet 지정=====================================================================================================	
		//결과내 재검색
		/*if (researchQuery.equals("on")) {
			WhereSet[] old_whereSet = parser.parseWhereSet(attfilewhereSetStr);       
			for(int i = 0; i < old_whereSet.length; i++){
				whereList_attfile.add(old_whereSet[i]);
			}  
			whereList_attfile.add(new WhereSet(Protocol.WhereSet.OP_AND)); //이전쿼리와 현재쿼리가  and로 검색
			
		}*/
		whereList_attfile_where = kistep_whereSet(allsearchQuery, "attfile", searchArea);
		
		for(int w=0; w < whereList_attfile_where.size(); w++ ){
			whereList_attfile.add(whereList_attfile_where.get(w));
		}

		//arraylist 담긴 where를 whereSet에 담는다.
		attfile_whereSet = new WhereSet[whereList_attfile.size()];
		for (int i = 0; i < whereList_attfile.size(); i++) {
			attfile_whereSet[i] = (WhereSet) whereList_attfile.get(i);
		}

		
		attfile_m3Query = new Query(startTag, endTag);
		attfile_m3Query.setOrderby(kistep_orderbys);
		attfile_m3Query.setSelect(attfile_selectSet);
		attfile_m3Query.setWhere(attfile_whereSet); 
		if (kistep_filterSet != null) {
			attfile_m3Query.setFilter(kistep_filterSet);
		}
		attfile_m3Query.setFrom("ATTFILE"); // 사용할 콜렉션에 요청한다.
		
		attfile_m3Query.setResult(page_start - 1, (page_start - 1)+ page_size - 1); //페이지 결과
		//attfile_m3Query.setQueryLogger("template"); //검색로그를 사용할 모듈이름 설정
		//검색옵션을 설정-> 검색캐쉬, 불용어, 금지어 사용
		attfile_m3Query.setSearchOption((byte)(Protocol.SearchOption.CACHE | Protocol.SearchOption.BANNED | Protocol.SearchOption.STOPWORD)); 
		//유의어 /동의어 확장 사용
		attfile_m3Query.setThesaurusOption((byte)(Protocol.ThesaurusOption.QUASI_SYNONYM | Protocol.ThesaurusOption.EQUIV_SYNONYM)); 
		attfile_m3Query.setPrintQuery(false); 
		//attfile_m3Query.setLoggable(true);
		attfile_m3Query.setDebug(true);  
		//attfile_m3Query.setLogKeyword(searchQuery.toCharArray());

		//queryStr = parser.queryToString( attfile_m3Query );
		//System.out.print(queryStr);
		attfilewhereSetStr = parser.whereSetToString(attfile_whereSet);

		//////검색 쿼리 셋팅 설정////////////////////////////////////////////////////////////////////////////
		QuerySet querySet =  null;

		if(searchArea.equals("orgin") || searchArea.equals("keyword")){
			querySet = new QuerySet(8);
			querySet.addQuery(hrst_m3Query);
			querySet.addQuery(rsti_m3Query);
			querySet.addQuery(rdps_m3Query);
			querySet.addQuery(icst_m3Query);
			querySet.addQuery(bis_m3Query);
			querySet.addQuery(aim_m3Query);
			querySet.addQuery(bbs_m3Query);
			querySet.addQuery(orgin_m3Query);

			kistep_getselectSet = hrst_m3Query.getSelectFields();
			orgin_getselectSet = orgin_m3Query.getSelectFields();
		}else {
			querySet = new QuerySet(9);
			querySet.addQuery(hrst_m3Query);
			querySet.addQuery(rsti_m3Query);
			querySet.addQuery(rdps_m3Query);
			querySet.addQuery(icst_m3Query);
			querySet.addQuery(bis_m3Query);
			querySet.addQuery(aim_m3Query);
			querySet.addQuery(bbs_m3Query);
			querySet.addQuery(orgin_m3Query);
			querySet.addQuery(attfile_m3Query);

			kistep_getselectSet = hrst_m3Query.getSelectFields();
			bbs_getselectSet = bbs_m3Query.getSelectFields();
			orgin_getselectSet = orgin_m3Query.getSelectFields();
			attfile_getselectSet = attfile_m3Query.getSelectFields();
		}


		CommandSearchRequest.setProps(SEARCH_HOST, SEARCH_PORT, 5000, 1, 10); //응답시간,min pool size, max pool size 값설정
		CommandSearchRequest command = new CommandSearchRequest(SEARCH_HOST, SEARCH_PORT);
		
		if(!searchQuery.equals("")){
			ret = command.request(querySet);
		}

		//System.out.print("-- wiz error0 : " + ret + "--");
		if (ret < 0) {
			resultlist = new Result[1];
			resultlist[0] = new Result();
		}else{
			resultlist = command.getResultSet().getResultList(); 
		}
		  
		return resultlist;
	}


%>
<%  request.setCharacterEncoding("utf-8"); %>
<%
	String ImgUrl = "http://pms.ccbrain.co.kr:9093";	

	int PageSize = 0;
    int InPageNumber = 0;
    int page_start = 1;
    int page_size = 3;
	int InreCnt=0;   

	int pagenavi_TotalSize = 0;
	int kistep_TotalSize = 0;

	int hrst_TotalSize = 0;
	int hrst_RealSize = 0;
	int rsti_TotalSize = 0;
	int rsti_RealSize = 0;
	int rdps_TotalSize = 0;
	int rdps_RealSize = 0;
	int icst_TotalSize = 0;
	int icst_RealSize = 0;
	int bis_TotalSize = 0;
	int bis_RealSize = 0;
	int aim_TotalSize = 0;
	int aim_RealSize = 0;
	int orgin_TotalSize = 0;
	int orgin_RealSize = 0;
	int bbs_TotalSize = 0;
	int bbs_RealSize = 0;
	int attfile_TotalSize = 0;
	int attfile_RealSize = 0;

	String NTT_CLS = "";
	String NTT_SJ = "";
	String NTT_CN = "";
	String NTT_ORGIN = "";
	String NTT_URL = "";
	String REG_DATE = "";
	String NTT_ORGIN_PH = "";
	String ORIGNL_FILE_NM = "";
	String ATT_URL = "";
	String ATT_CN = "";
	String BBS_NM = "";

	String searchQuery = "";  //검색 페이지 검색어
	String allsearchQuery = "";	//모든 검색어
	String searchCategory = "";  //카테고리 
	String searchArea = "";		//검색 영역
	String searchPeriod = "";	//검색 기간
	String searchStartDate = "";	//검색 기간 시작일
	String searchEndDate = "";	//검색 기간 종료일
	String searchSort = "";	//정렬
	String PageNumber              ="";    //페이지 번호
	String detailDisplay = "";	//상세검색 노출여부
	String researchQuery = "";	//재검색
	//String kistepwhereSetStr = "";	//이전 whereset
	//String orginwhereSetStr = "";	//이전 whereset
	//String attfilewhereSetStr = "";	//이전 whereset

	searchQuery = nullCheck(request.getParameter("searchQuery"));  
	allsearchQuery = nullCheck(request.getParameter("allsearchQuery"));  
	searchCategory = request.getParameter("searchCategory");    
    if (searchCategory == null || searchCategory == "") {searchCategory = "total";}
	searchArea = request.getParameter("searchArea");    
    if (searchArea == null || searchArea == "") {searchArea = "total";}
	searchPeriod = request.getParameter("searchPeriod");    
    if (searchPeriod == null || searchPeriod == "") {searchPeriod = "total";}
	searchStartDate = nullCheck(request.getParameter("searchStartDate")); 
	searchEndDate = nullCheck(request.getParameter("searchEndDate")); 
	searchSort = request.getParameter("searchSort");    
    if (searchSort == null || searchSort == "") {searchSort = "date";}
	PageNumber = request.getParameter("PageNumber");                //PageNumber값을 받는 부분, 값이 없으면 기본값 1
    if (PageNumber == null || PageNumber == "") {PageNumber = "1";}
	detailDisplay = nullCheck(request.getParameter("detailDisplay")); 
	researchQuery = nullCheck(request.getParameter("researchQuery")); 
	
	kistepwhereSetStr = nullCheck(request.getParameter("kistepwhereSetStr")); 
	kistepwhereSetStr = kistepwhereSetStr.replaceAll("&#39;","'");
	orginwhereSetStr = nullCheck(request.getParameter("orginwhereSetStr")); 
	orginwhereSetStr = orginwhereSetStr.replaceAll("&#39;","'");
	attfilewhereSetStr = nullCheck(request.getParameter("attfilewhereSetStr")); 
	attfilewhereSetStr = attfilewhereSetStr.replaceAll("&#39;","'");
	
		//모든 검색어 셋팅
	InreCnt =0;
    if(!researchQuery.equals("")){
        if(InreCnt == 0){
            allsearchQuery = allsearchQuery ;   
            InreCnt = 1;
        }                                                                                                             
        if(InreCnt > 0) {
            String[] tempArr = allsearchQuery.split("\\$\\|");
            String tempValue = allsearchQuery;
             for(int j=0; j<tempArr.length; j++){
                if(tempArr[j].equals(researchQuery)){
                
                  if(tempValue.substring(tempValue.lastIndexOf("$|"+researchQuery), tempValue.length()).equals("$|"+researchQuery)){
                      tempValue = tempValue.substring(0, tempValue.length() - (researchQuery.length()+2));
                  }
                }
             }           
            allsearchQuery = tempValue +"$|"+  researchQuery ;
        }
    }else{
        allsearchQuery = searchQuery;
    }
 
	try {
        InPageNumber = Integer.parseInt(PageNumber); //String형인 PageSz를 int형으로 변경
    } catch (Exception e) {
        InPageNumber = 1;
    }

	if(searchCategory.equals("total")){
		page_size = 3;
	}else{
		page_size = 10;
	}

	DecimalFormat formatter = new DecimalFormat("#,##0");       //숫자 천단위 , 표시

	 //시작페이지 설정
    if(!PageNumber.equals("")){
		page_start = 1 + (page_size * (InPageNumber - 1));
	}//String형인 PageNumber를 int형으로 변경

	Result hrst_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result rsti_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result rdps_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result icst_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result bis_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result aim_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result bbs_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result orgin_result = null;   //검색 결과를 가져오는데 필요한 변수
	Result attfile_result = null;   //검색 결과를 가져오는데 필요한 변수

	Result[] kistep_resultlist = null; //검색결과를 가지고 있는 변수

	if(!searchQuery.equals("")){
		
		kistep_resultlist = getSearchResults(searchQuery, allsearchQuery, searchCategory, searchSort, searchArea, searchStartDate, searchEndDate, researchQuery, page_start, page_size, SEARCH_HOST,SEARCH_PORT);
		
		if(ret > 0){
			if(kistep_resultlist[0] != null && kistep_resultlist.length > 1){
				hrst_result = kistep_resultlist[0];
				hrst_TotalSize =  hrst_result.getTotalSize();   // HRST 검색 결과
				hrst_RealSize = hrst_result.getRealSize();      // 한페이지에 표시되는 개수

				rsti_result = kistep_resultlist[1];
				rsti_TotalSize =  rsti_result.getTotalSize();   // RSTI 검색 결과
				rsti_RealSize = rsti_result.getRealSize();      // 한페이지에 표시되는 개수

				rdps_result = kistep_resultlist[2];
				rdps_TotalSize =  rdps_result.getTotalSize();   // RDPS 검색 결과
				rdps_RealSize = rdps_result.getRealSize();      // 한페이지에 표시되는 개수

				icst_result = kistep_resultlist[3];
				icst_TotalSize =  icst_result.getTotalSize();   // ICST 검색 결과
				icst_RealSize = icst_result.getRealSize();      // 한페이지에 표시되는 개수

				bis_result = kistep_resultlist[4];
				bis_TotalSize =  bis_result.getTotalSize();   // BIS 검색 결과
				bis_RealSize = bis_result.getRealSize();      // 한페이지에 표시되는 개수

				aim_result = kistep_resultlist[5];
				aim_TotalSize =  aim_result.getTotalSize();   // AIM 검색 결과
				aim_RealSize = aim_result.getRealSize();      // 한페이지에 표시되는 개수

				bbs_result = kistep_resultlist[6];
				bbs_TotalSize =  bbs_result.getTotalSize();   // 게시판 검색 결과
				bbs_RealSize = bbs_result.getRealSize();      // 한페이지에 표시되는 개수

				orgin_result = kistep_resultlist[7];
				orgin_TotalSize =  orgin_result.getTotalSize();   // 출처기관 검색 결과
				orgin_RealSize = orgin_result.getRealSize();      // 한페이지에 표시되는 개수

				if(!(searchArea.equals("orgin") || searchArea.equals("keyword"))){
					attfile_result = kistep_resultlist[8];
					attfile_TotalSize =  attfile_result.getTotalSize();   // 첨부파일 검색 결과
					attfile_RealSize = attfile_result.getRealSize();      // 한페이지에 표시되는 개수
				}

				kistep_TotalSize = hrst_TotalSize + rsti_TotalSize + rdps_TotalSize + icst_TotalSize + bis_TotalSize + aim_TotalSize + bbs_TotalSize + orgin_TotalSize + attfile_TotalSize;
				if(searchCategory.equals("hrst")){
					pagenavi_TotalSize = hrst_TotalSize;
				}else if(searchCategory.equals("rsti")){
					pagenavi_TotalSize = rsti_TotalSize;
				}else if(searchCategory.equals("rdps")){
					pagenavi_TotalSize = rdps_TotalSize;
				}else if(searchCategory.equals("icst")){
					pagenavi_TotalSize = icst_TotalSize;
				}else if(searchCategory.equals("bis")){
					pagenavi_TotalSize = bis_TotalSize;
				}else if(searchCategory.equals("aim")){
					pagenavi_TotalSize = aim_TotalSize;
				}else if(searchCategory.equals("bbs")){
					pagenavi_TotalSize = bbs_TotalSize;
				}else if(searchCategory.equals("orgin")){
					pagenavi_TotalSize = orgin_TotalSize;
				}else if(searchCategory.equals("attfile")){
					pagenavi_TotalSize = attfile_TotalSize;
				}
		   }
		}
	}

%>