<%@page import="java.sql.ResultSet"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="Database.ConnectDB"%>
<%@ page import="Database.DInfo"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="com.mysql.jdbc.Connection"%>
<%@ page import="com.mysql.jdbc.PreparedStatement"%>
<%@ page import="java.util.*, java.text.*"  %>
<%@page import="java.sql.SQLException"%>

<%
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("id");
	String user_pw = request.getParameter("pw");
	DInfo dinfo = new DInfo();
	ConnectDB connectDB = new ConnectDB();
	String jsonData = "";
	
	Connection conn = connectDB.ConnectionDB(dinfo.DB_URL, dinfo.DB_ID, dinfo.DB_PW);
	PreparedStatement ps = null;
	try{
			
		ps = (PreparedStatement)conn.prepareStatement(dinfo.getLoginCheck_SQL(user_id,user_pw));    
		ResultSet rs = ps.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
		 JSONObject json = new JSONObject();
		if(!rs.isBeforeFirst()){
			System.out.println("no data");
			json.put("result", "0");
			json.put("message", "로그인을 실패하였습니다.");
		}else{
			json.put("result", "1");
			json.put("message", "로그인을 성공하였습니다.");
			session.setAttribute("id", user_id);
		}
		jsonData = json.toJSONString();
	 }catch(NullPointerException e){
		 System.out.println("NullPointerException : " + e.toString());
		 JSONObject json = new JSONObject();
		 json.put("result", "2");
		 json.put("message", "데이터가 없습니다.");
		 jsonData = json.toJSONString();
	 }catch(Exception e){
		e.printStackTrace();
		 JSONObject json = new JSONObject();
		 json.put("result", "0");
		 json.put("message", "데이터를 가져오는데 실패 하였습니다.");
		 jsonData = json.toJSONString();
	 }
	
	out.println(jsonData);
%>