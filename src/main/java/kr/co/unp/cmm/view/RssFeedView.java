package kr.co.unp.cmm.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.bbs.vo.BoardMasterVO;

import org.springframework.web.servlet.view.feed.AbstractRssFeedView;

import com.sun.syndication.feed.rss.Channel;
import com.sun.syndication.feed.rss.Item;

public class RssFeedView extends AbstractRssFeedView {

	@Override
	protected void buildFeedMetadata(Map<String, Object> model, Channel feed, HttpServletRequest request) {
		BoardMasterVO masterVO = (BoardMasterVO) model.get("masterVO");
		feed.setTitle("중랑구청 " + masterVO.getBbsNm());
		feed.setDescription("중랑구청 " + masterVO.getBbsNm());
		feed.setLanguage("ko-kr");
		feed.setCopyright("Copyright(c) 2013. 중랑구청 All rights reserved");
		feed.setWebMaster("중랑구청@email.go.kr");
		super.buildFeedMetadata(model, feed, request);
	}

	@Override
	protected List<Item> buildFeedItems(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		@SuppressWarnings("unchecked")
		List<Item> itemList = (List<Item>) model.get("itemList");
		return itemList;
	}
}
