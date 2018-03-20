<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="com.mysql.jdbc.Connection"%>
<%@ page import="com.mysql.jdbc.PreparedStatement"%>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realFolder="";

	String saveFolder="video";
	String encType="utf-8";
	String jsonData = "";
	int maxSize=1024*1024*100;
	
	String contents = request.getParameter("contents");
	System.out.print("test : " + contents);
	ServletContext context = this.getServletContext();
	
	realFolder = context.getRealPath(saveFolder);
	
	System.out.println("실제 서블릿 상 경로 : " + realFolder);
	//out.print("실제 서블릿 상 업로드 경로 : " + realFolder);
	
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String file_name = formatter.format(new java.util.Date()); 
	long mils = System.currentTimeMillis();
	file_name = file_name+mils;
	Random random = new Random();
	file_name = file_name + random.nextInt(10000) + ".mp4";
	
	JSONObject json = new JSONObject();
	MultipartRequest multi = null;
	
	try{
		multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
		File file = multi.getFile("agentInstallFile");
		File newFile = new File(realFolder + "/" + file_name); 
		file.renameTo(newFile);
		
		System.out.println("newfile path : " + newFile.getPath());
		System.out.println("file path : " + file.getPath());
		
		json.put("result", "1");
		json.put("message", "데이터를 성공적으로 가져왔습니다.");
		json.put("img_path", newFile.getPath());
		jsonData = json.toJSONString();
		System.out.println("jsonData : " +jsonData);
		out.print(jsonData);
	}catch(Exception e){
		json.put("result", "0");
		json.put("message", "파일 전송에 실패하였습니다.");
		out.println(json);
	}
	
%>