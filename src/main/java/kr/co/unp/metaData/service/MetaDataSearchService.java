package kr.co.unp.metaData.service;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;

import org.springframework.stereotype.Service;

@Service("metaDataSearchService")
public class MetaDataSearchService  extends DefaultCmmProgramService {

	public MetaDataSearchService() {
		super.setListQueryId("MetaDataSearchDAO.list");
		super.setCountQueryId("MetaDataSearchDAO.listCnt");
	}

}
