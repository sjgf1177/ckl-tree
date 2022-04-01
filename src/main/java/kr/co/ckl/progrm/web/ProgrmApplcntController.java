package kr.co.ckl.progrm.web;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URI;
import java.nio.charset.Charset;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;

import kr.co.ckl.progrm.service.ProgrmApplcntService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.cmm.file.web.FileDownloadController;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

@Controller
@RequestMapping("/{siteName}/progrm/applcnt")
public class ProgrmApplcntController extends DefaultCmmProgramController{

	@Resource(name="progrmApplcntService")
	private ProgrmApplcntService progrmApplcntService;

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "progrmApplcnt";
	}


	/**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     *
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/downloadFile.do")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	ZValue param = WebFactory.getAttributes(request);
    	List<ZValue> list = progrmApplcntService.downloadFileList(param);

    	String prgNm = "download.zip";
    	if (list.size() > 0) prgNm = list.get(0).getString("prgNm") + "." + "zip";

    	final String targetDir = EgovProperties.getProperty("Globals.progrmApplcnt.zipDir");
    	final String filePath = targetDir + File.separator + "download.zip";
	    final Path path = Paths.get(targetDir);
	    Files.createDirectories(path);

	    //압축 파일 생성 옵션(새로생성, 파일명 캐릭터셋등)
	    final Map<String, String> zipProp = new HashMap<String,String>();
	    zipProp.put("create", Boolean.toString(true));
	    zipProp.put("encoding", Charset.defaultCharset().displayName());

	  //압축파일 경로
	    URI zipFileUri = URI.create("jar:file://" + targetDir + "/" + "download.zip");

	    //압축파일 파일 시스템생성
	    try (FileSystem zipfs = FileSystems.newFileSystem(zipFileUri, zipProp)) {

	    	for (ZValue fileVO : list) {
	    		String itemPath = fileVO.getString("fileStreCours") + File.separator + fileVO.getString("streFileNm");
        		Path targetFile = Paths.get(itemPath);
    	        Path targetPath = zipfs.getPath("/"+fileVO.getString("resveNo") +"_"+ fileVO.getString("userNm") +"_"+ fileVO.getString("fileSn") + "_" + fileVO.getString("orignlFileNm"));
    	        //압축 파일안에 압축할 파일 넣기
    	        Files.copy(targetFile, targetPath, StandardCopyOption.REPLACE_EXISTING);

        	}

	    } catch (Exception  e) {
	        e.printStackTrace();
	    }

	    File uFile = new File(filePath);
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			FileDownloadController.setDisposition(prgNm, request, response);
			response.setContentLength(fSize);


			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
			    in = new BufferedInputStream(new FileInputStream(uFile));
			    out = new BufferedOutputStream(response.getOutputStream());

			    FileCopyUtils.copy(in, out);
			    out.flush();

			    uFile.delete();

			} catch (Exception ex) {
			    //ex.printStackTrace();
			} finally {
			    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {

					}
			    }
			    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {

					}
			    }
			}

	    } else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + prgNm + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
	    }

    }



}
