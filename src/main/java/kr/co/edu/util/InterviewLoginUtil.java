package kr.co.edu.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;


public class InterviewLoginUtil {
	
	final static private String LOGIN_URL = "https://kocca.selfview.co.kr/ajax/loginAndJoin.ajax.php";

	public static Map<String, Object> send(String userId, String userName){
		
		String sendUrl = LOGIN_URL;
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", false);
		result.put("msg", null);
		result.put("id", null);
		result.put("name", null);
		
		try{
			
			
			System.setProperty("jsse.enableSNIExtension", "false");
			
			// Create URL instance.
			URL url = new URL(sendUrl);
			 
			// create connection.
			HttpURLConnection conn;
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setUseCaches(false);
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setAllowUserInteraction(true);
			
			conn.setRequestMethod("POST"); //set method as POST or GET
			//conn.setRequestProperty("Content-Type","application/json");
			conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");


			
			
			//String parameter = "userid="+URLEncoder.encode(userId, "UTF-8") + "&name="+URLEncoder.encode(userName, "UTF-8");
			String parameter = "userid="+userId + "&name="+userName;
			System.out.println("parameter ==============> "+parameter);
			
			result.put("id", userId);
			result.put("name", userName);
			
			
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(parameter);
			wr.flush();
			
			int status = 0;
			
			
			if( null != conn ){
				status = conn.getResponseCode();
			}
			
			
			if( status != 0){
				
				if( status == 200 ){
					//SUCCESS message
					BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
					String line = null;
					String msg = "";
					while( ( line = reader.readLine() ) != null ){
						// process....
						System.out.println( "line ==========> " + line );
						msg += line;
					}
					
					result.put( "result", true );
					result.put( "msg", msg );
				}
			}else{
				result.put( "result", false );
			}
			
		}catch(MalformedURLException mlfexception){
			System.out.println("Error occurred while sending Login.." + mlfexception.getMessage()); // Prototcal Error
		}catch(IOException mlfexception){
			System.out.println("Reading URL, Error occurred while sending Login!.." + mlfexception.getMessage()); //URL problem
		}catch (Exception exception) {
			System.out.println("Error occurred while sending Login!.." + exception.getMessage()); //General Error or exception.
		}
		return result;
		
	}
	
}
