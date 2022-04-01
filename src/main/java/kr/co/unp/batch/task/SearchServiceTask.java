package kr.co.unp.batch.task;


import java.net.URL;
import java.net.URLConnection;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.stereotype.Service;

@Service(value="searchServiceTask")
public class SearchServiceTask {


	public void doTaskProc() throws Exception {
		System.out.println("test");
		/*
		http://solr.ckl.or.kr/solr/#/bbs/dataimport?command=full-import
		http://solr.ckl.or.kr/solr/#/menu/dataimport?command=full-import
		http://solr.ckl.or.kr/solr/#/files/dataimport?command=full-import
		http://solr.ckl.or.kr/solr/#/progrm/dataimport?command=full-import
		http://solr.ckl.or.kr/solr/#/onlineEdu/dataimport?command=full-import
		*/
		try {


			HttpClient client1 = new DefaultHttpClient();
			HttpGet request1 = new HttpGet("http://solr.ckl.or.kr/solr/bbs/dataimport?command=full-import");
			HttpResponse response1 = client1.execute(request1);

			HttpClient client2 = new DefaultHttpClient();
			HttpGet request2 = new HttpGet("http://solr.ckl.or.kr/solr/menu/dataimport?command=full-import");
			HttpResponse response2 = client2.execute(request2);

			HttpClient client3 = new DefaultHttpClient();
			HttpGet request3 = new HttpGet("http://solr.ckl.or.kr/solr/files/dataimport?command=full-import");
			HttpResponse response3 = client3.execute(request3);

			HttpClient client4 = new DefaultHttpClient();
			HttpGet request4 = new HttpGet("http://solr.ckl.or.kr/solr/progrm/dataimport?command=full-import");
			HttpResponse response4 = client4.execute(request4);

			HttpClient client5 = new DefaultHttpClient();
			HttpGet request5 = new HttpGet("http://solr.ckl.or.kr/solr/onlineEdu/dataimport?command=full-import");
			HttpResponse response5 = client5.execute(request5);

			HttpClient client6 = new DefaultHttpClient();
			HttpGet request6 = new HttpGet("http://solr.ckl.or.kr/solr/webpage/dataimport?command=full-import");
			HttpResponse response6 = client6.execute(request6);
		}
		catch (Exception e) {
			e.printStackTrace();
		}

	}

}
