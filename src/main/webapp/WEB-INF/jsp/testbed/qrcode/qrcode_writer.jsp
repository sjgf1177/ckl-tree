<%@page import="java.io.BufferedOutputStream"%>
<%@page import="com.google.zxing.client.j2se.MatrixToImageWriter"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.zxing.qrcode.QRCodeWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="image/png; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 
String userAgent = request.getHeader("User-Agent"); 
boolean ie = userAgent.indexOf("MSIE") > -1; 

QRCodeWriter q = new QRCodeWriter();
String text = (String)request.getAttribute("content");
String fileName = "kocca.png"; 

if(ie){ 
	fileName = URLEncoder.encode(fileName, "UTF-8"); 

}else{ 
	fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1"); 
} 

text = new String(text.getBytes("UTF-8"), "ISO-8859-1");
/* response.setHeader("Content-Disposition", "attachment; filename=\""+fileName + "\";"); 
response.setHeader("Content-Transfer-Encoding", "binary"); */

BitMatrix bitMatrix = q.encode(text, BarcodeFormat.QR_CODE, 200, 200);

out.clear();
out=pageContext.pushBody();
ServletOutputStream outputStream = response.getOutputStream();
MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream);
outputStream.flush();
outputStream.close();

%>








