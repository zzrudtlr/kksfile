<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ page import="Database.ConnectDB"%>
<%@ page import="Database.DInfo"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="com.mysql.jdbc.Connection"%>
<%@ page import="com.mysql.jdbc.PreparedStatement"%>
<%@ page import="java.util.*, java.text.*"%>
<%@page import="java.sql.SQLException"%>
<%

	String jsonData = "";

	DInfo dinfo = new DInfo();
	ConnectDB connectDB = new ConnectDB();
	
	Connection conn = connectDB.ConnectionDB(dinfo.DB_URL, dinfo.DB_ID, dinfo.DB_PW);
	PreparedStatement ps = null;
	try{
			                   // sql 쿼리
		//System.out.println(dinfo.PORTFOLIO_VIEW_TABLE+" : " + sql);
		ps = (PreparedStatement)conn.prepareStatement(dinfo.SQL_PORTFOLIO_VIEW_TOTAL_COUNT);    
		ResultSet rs = ps.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
		
		if(!rs.isBeforeFirst()){
			System.out.println("no data");
			 JSONObject json = new JSONObject();
			 json.put("result", "2");
			 json.put("message", "데이터가 없습니다.");
			 jsonData = json.toJSONString();
		}else{
			JSONObject json = new JSONObject();
			json.put("result", "1");
			json.put("message", "데이터를 성공적으로 가져왔습니다.");
		
			JSONObject jsonObject = new JSONObject();
			while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
				//ArrayList arraylist = new ArrayList();
				System.out.println("count : " + rs.getString("count"));
				
				jsonObject.put("count", rs.getString("count"));
				//jsonArray.add(jsonObject);
		
			}
			json.put("data", jsonObject.toJSONString());
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