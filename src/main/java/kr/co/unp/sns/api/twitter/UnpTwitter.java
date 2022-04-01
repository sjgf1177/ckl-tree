package kr.co.unp.sns.api.twitter;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.StatusUpdate;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;

public class UnpTwitter {
	private twitter4j.Twitter twitter = null;

	public UnpTwitter(String ckey1, String ckey2, AccessToken accessToken){
		twitter = new TwitterFactory().getInstance();
		twitter.setOAuthConsumer(ckey1, ckey2);
		twitter.setOAuthAccessToken(accessToken);
	}

	public twitter4j.Twitter getTwitter() {
		return twitter;
	}

	/*
	public String write(HashMap data) throws Exception{
		StatusUpdate statusUpdate = new StatusUpdate(data.get("content").toString());
		Status status = this.twitter.updateStatus(statusUpdate);
		return Long.toString(status.getId());
	}*/

}
