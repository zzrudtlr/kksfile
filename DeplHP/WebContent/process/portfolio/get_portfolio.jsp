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
	DInfo dinfo = new DInfo();
	ConnectDB connectDB = new ConnectDB();
	String jsonData = "";
	
	Connection conn = connectDB.ConnectionDB(dinfo.DB_URL, dinfo.DB_ID, dinfo.DB_PW);
	PreparedStatement ps = null;
	try{
			
		String sql = "select idx,type_idx,name,img,contents,regdate from "+ dinfo.PORTFOLIO_VIEW_TABLE;                        // sql 쿼리
		System.out.println(dinfo.PORTFOLIO_VIEW_TABLE+" : " + sql);
		ps = (PreparedStatement)conn.prepareStatement(sql);    
		 ResultSet rs = ps.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
		
		if(!rs.isBeforeFirst()){
			System.out.println("no data");
		}else{
			JSONObject json = new JSONObject();
			json.put("result", "1");
			json.put("message", "데이터를 성공적으로 가져왔습니다.");
			JSONArray jsonArray = new JSONArray();
			while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
				//ArrayList arraylist = new ArrayList();
				System.out.println("idx : " + rs.getString("idx") + " type_idx : " + rs.getString("type_idx") + " name : " + rs.getString("name") + " img : " + rs.getString("img"));
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("idx", rs.getString("idx"));
				jsonObject.put("type_idx", rs.getString("type_idx"));
				jsonObject.put("name", rs.getString("name"));
				jsonObject.put("img", rs.getString("img"));
				jsonObject.put("contents", rs.getString("contents"));
				jsonObject.put("regdate", rs.getString("regdate"));
				jsonArray.add(jsonObject);
		
			}
			json.put("data", jsonArray.toJSONString());
			jsonData = json.toJSONString();
		}
	
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