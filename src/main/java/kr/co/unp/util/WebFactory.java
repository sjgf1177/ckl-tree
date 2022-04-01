package kr.co.unp.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("webFactory")
public class WebFactory {

	protected Log log = LogFactory.getLog(WebFactory.class);

	public static ZValue getAttributes(HttpServletRequest request) {
		ZValue zvl = new ZValue();
		Enumeration<?> enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()){
			String key = (String) enumeration.nextElement();
			String[] values = request.getParameterValues(key);
			if(values!=null){
				zvl.putObject(key, (values.length > 1) ? values:values[0] );
			}
		}
		return zvl;
	}

	public ZValue getParameterInit(HttpServletRequest request) {
		ZValue zvl = getAttributes(request);


    	int pageIndex = 0;
    	int pageUnit = 10;
    	int pageSize = 10;
    	int stRn = 0;
    	int enRn = 0;

    	String baseUrl = "/";
    	String isUrl = "";
    	pageIndex = zvl.getInt("pageIndex", 1);

    	try{pageUnit=Integer.parseInt(zvl.getString("pageUnit"));}catch(Exception e1){pageUnit=10;}
    	try{pageSize=Integer.parseInt(zvl.getString("pageSize"));}catch(Exception e1){pageSize=10;}
    	stRn = pageSize*(pageIndex-1)+1;
    	enRn = pageSize*pageIndex;

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(zvl.getInt("pageIndex"));
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);

		String url = request.getRequestURI().toString();
		if (url.lastIndexOf("/")>-1){
			baseUrl = url.substring(0, url.lastIndexOf("/"));
		}
		isUrl = request.getRequestURI().toString();
		if (request.getQueryString()!=null && request.getQueryString().length()>0){
			isUrl += "?" + request.getQueryString();
		}

		zvl.put("pageIndex", pageIndex);
    	zvl.put("pageUnit", pageUnit);
    	zvl.put("pageSize", pageSize);
    	zvl.put("stRn", stRn);
    	zvl.put("enRn", enRn);
    	zvl.put("firstIndex", paginationInfo.getFirstRecordIndex());
    	zvl.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
    	zvl.put("baseUrl", baseUrl);
    	zvl.put("isUri", request.getRequestURI().toString());
    	zvl.put("isUrl", URLEncoder.encode(isUrl));
    	zvl.put("paramUrl", getParamUrl(zvl));
    	zvl.put("paramPageUrl", getParamUrl(zvl)+"&pageIndex="+zvl.getInt("pageIndex"));

		return zvl;
	}


	/**
	 * 기본적인 파라미터를 세팅하여 리턴한다.
	 * @param zvl
	 * @return
	 */
	public String getParamUrl(ZValue zvl){
    	String temp_param_url = "";
    	temp_param_url+="menuNo="+zvl.getString("menuNo");

    	if (!zvl.getString("sLangId").equals("")) temp_param_url+="&sLangId="+zvl.getString("sLangId");
    	if (!zvl.getString("pcode").equals("")) temp_param_url+="&pcode="+zvl.getString("pcode");
    	if (!zvl.getString("lang").equals("")) temp_param_url+="&lang="+zvl.getString("lang");
    	if (!zvl.getString("pageSize").equals("")) temp_param_url+="&pageSize="+zvl.getString("pageSize");
    	if (!zvl.getString("searchKey").equals("")) temp_param_url+="&searchKey="+zvl.getString("searchKey");
    	if (!zvl.getString("searchStr").equals("")) temp_param_url+="&searchStr="+zvl.getString("searchStr");

    	return temp_param_url;
	}

	public void contentsDownload(String path, HttpServletRequest request, HttpServletResponse response)
		throws Exception
	{
    	ZValue zvl = getAttributes(request);

		String fileName = zvl.getString("filename");
		String fileName2 = URLDecoder.decode(zvl.getString("filename"), "UTF-8");
		log.debug( "contents download path : " + path );
		log.debug( "contents download fileName : " + fileName );
		log.debug( "contents download decoded fileName : " + fileName2 );

        String encFileName  = EgovStringUtil.toEng(fileName);
		log.debug( "encFileName " + encFileName );
        String extension    = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
        String mimeType     = null;
        String userAgent    = request.getHeader("User-Agent");  //클라이언트의 브라우저 유형 정보

	    File uFile = new File(path, fileName);
	    int fSize = (int)uFile.length();

	    if (fSize > 0)
	    {
            //브라우저에 전송될 파일 형식 지정(Internet Media Type)
            if ( extension.equals("xls") )
                mimeType="Content-type: APPLICATION/VND.MS-EXCEL;";
            else if ( extension.equals("doc") )
                mimeType="Content-type: APPLICATION/MSWORD;";
            else if ( extension.equals("ppt") )
                mimeType="Content-type: APPLICATION/VND.MS-POWERPOINT;";
            else if ( extension.equals("hwp") )
                mimeType="Content-type: APPLICATION/UNKNOWN;";
            else
                mimeType="Content-type: APPLICATION/STREAM;";

            mimeType += "charset=utf-8";

            response.setContentType(mimeType);
			response.setBufferSize(fSize);

            if( userAgent != null && userAgent.indexOf("MSIE 5.5") != -1 ) {
                //response.setHeader("Content-Disposition","filename=" + encFileName + ";");
                response.setHeader("Content-Disposition","filename=" + encFileName + ";");
            }
            else {
                //response.setHeader("Content-Disposition","attachment;filename=" + encFileName + ";");
                response.setHeader("Content-Disposition","attachment;filename=" + encFileName + ";");
            }

            response.setHeader("Accept-Ranges",             "bytes");
            response.setHeader("Content-Transfer-Encoding", "binary;");
            response.setHeader("Content-Length",            String.valueOf(fSize) ); //Message-Body의 길이

    		InputStream in = null;
    		OutputStream out = null;
            try {

    		    in = new FileInputStream(uFile);
    		    out = response.getOutputStream();

    		    byte buffer[] = new byte[4096];
    	        long count = 0L;
    	        for(int n = 0; -1 != (n = in.read(buffer));)
    	        {
    	        	out.write(buffer, 0, n);
    	            count += n;
    			    out.flush();
    	        }
			} catch (Exception e) {
			} finally {
				if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
					    // no-op
					    log.debug("IGNORED: " + ignore.getMessage());
					}
				    }
				    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
					    // no-op
					    log.debug("IGNORED: " + ignore.getMessage());
					}
				    }
			}
	    }
	    else
	    {
			response.setContentType("application/x-msdownload");
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + zvl.getString("orgFileName") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
	    }
	}

	public void printHtmlAfterSSO(HttpServletResponse response, String msg,
			String forwardUrl) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"ko\" lang=\"ko\">");
		out.println("<head>");
		out.println("<title>KISTIP</title");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\" />");
        out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + forwardUrl + " \" />");
		out.println("</head>");
		out.println("<body>");
		out.println("<script type=\"text/javascript\">");
		if (StringUtils.hasText(msg)){
		out.println("alert('" + msg + "');");
		}
		out.println("location.href='" + forwardUrl + "';");
		out.println("</script><noscript>");
		out.println("새로운 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/>1초 후 자동으로 이동합니다.");
		out.println("</noscript>");
		out.println("</body>");
		out.println("</html>");
		out.flush();
		out.close();
	}

	public void printHtml(HttpServletResponse response, String msg,
			String forwardUrl) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
        out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + forwardUrl + " \">");
		out.println("<script type=\"text/javascript\">");
		if (StringUtils.hasText(msg)){
		out.println("alert('" + msg + "');");
		}
		out.println("location.href='" + forwardUrl + "';");
		out.println("</script><noscript>");
		out.println("새로운 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/>1초 후 자동으로 이동합니다.");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		out.close();
	}

	public void printWinClose(HttpServletResponse response, String msg) throws Exception {
		printWinClose(response, msg, false);
	}

	public void printWinClose(HttpServletResponse response, String msg, boolean openerReload) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		if (openerReload){
			out.println("opener.location.reload();");
		}
		if (StringUtils.hasText(msg)){
		out.println("alert('" + msg + "');");
		}
		out.println("self.close();");
		out.println("</script><noscript>");
		out.println("창을 닫는 스크립트 입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		out.close();
	}

	public void printHtml(HttpServletResponse response, String msg,
			String forwardUrl, String pre) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
        out.println("<meta http-equiv=\"refresh\" content=\"1;url=" + forwardUrl + " \">");
		out.println("<script type=\"text/javascript\">");
		if (StringUtils.hasText(msg)){
		out.println("alert('" + msg + "');");
		}
		if (pre!=null && !pre.equals("")){
		out.println("if("+pre+".location){");
		out.println(pre+".location.href='" + forwardUrl + "';");
		out.println("}");
		} else {
		out.println("location.href='" + forwardUrl + "';");
		}
		out.println("</script><noscript>");
		out.println("새로운 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/>1초 후 자동으로 이동합니다.");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		out.close();
	}

	public void printHtmlBack(HttpServletResponse response, String msg) throws Exception {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		if (StringUtils.hasText(msg)){
		out.println("alert('" + msg + "');");
		}
		out.println("history.back();");
		out.println("</script><noscript>");
		out.println("이전 페이지로 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/'>[바로 이동하기]</>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		out.close();
	}

	public void printHtmlReload(HttpServletResponse response, String msg) throws Exception {
		printHtmlReload(response, msg, null);
	}

	public void printHtmlReload(HttpServletResponse response, String msg, String pre) throws Exception {
		pre = (pre==null) ? "" : pre+".";
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">");
		out.println("<script type=\"text/javascript\">");
		if (StringUtils.hasText(msg)){
			out.println("alert('" + msg + "');");
		}
			out.println(pre + "location.reload();");
		if (pre.indexOf("opener")>-1){
			out.println(pre + "self.close();");
		}
		out.println("</script><noscript>");
		out.println("페이지를 새로고침 하는 이동하는 스크립트입니다.");
		out.println("<br/>자바스크립트를 지원하지 않아 일부기능이 동작을 하지 않을 수 있습니다.");
		out.println("<br/><a href='/'>[바로 이동하기]</>");
		out.println("</noscript>");
		out.println("</head>");
		out.flush();
		out.close();
	}

	public void setUserConfirmForwardPage(HttpServletRequest request,
			HttpServletResponse response, String msg) throws Exception {

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.print("<script>\n");
		out.print("if(confirm('"+msg+"'))\n");
		out.print("location.href='/portal/member/loginPage.do?menuNo=200069'\n");
		out.print("else history.back();\n");
		out.print("</script>");
		out.flush();
		out.close();
		return;
	}

	public void goUserConfirmForwardPage(HttpServletResponse response, String msg, String goUrl) throws Exception {

		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();

		out.print("<script>\n");
		out.print("if(confirm('"+msg+"'))\n");
		out.print("location.href='"+goUrl+"'\n");
		out.print("else history.back();\n");
		out.print("</script>");
		out.flush();
		out.close();
		return;
	}

	public static void main(String[] args) throws Exception
	{
		//System.out.println(WebFactory.readPetitionWebContents("http://localhost:8080/admin/portal/apply/petition/selectPetitionView.do?applyCode=RELY&petiGubun=1&applyId=6"));
	}

}
