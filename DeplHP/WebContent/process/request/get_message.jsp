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

<%@ page import="java.util.*, java.text.*"  %>
<%@page import="java.sql.SQLException"%>
<%
	request.setCharacterEncoding("UTF-8");
	String r_json = request.getParameter("json");
	System.out.println("r_json : " + r_json);
	
	JSONParser parser = new JSONParser();
	Object obj = parser.parse(r_json);
	JSONArray r_jsonArray = (JSONArray) obj;
	JSONObject jsonObj = (JSONObject)r_jsonArray.get(0);
	
	String l_to = ""+jsonObj.get("l_to");
	String l_count = ""+jsonObj.get("l_count");
	
	String jsonData = "";
	DInfo dinfo = new DInfo();
	ConnectDB connectDB = new ConnectDB();
	
	Connection conn = connectDB.ConnectionDB(dinfo.DB_URL, dinfo.DB_ID, dinfo.DB_PW);
	PreparedStatement ps = null;
	try{
			
		//String sql = "select idx, name, email, title, regdate from " + dinfo.REQUEST_TABLE + " limit 0, 10;";                      // sql 쿼리
		//System.out.println(dinfo.PORTFOLIO_VIEW_TABLE+" : " + sql);
		ps = (PreparedStatement)conn.prepareStatement(dinfo.getMessage_SQL(l_to, l_count));    
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
				System.out.println("idx : " + rs.getString("idx") + " name : " + rs.getString("name") + " email : " + rs.getString("email") + " title : " + rs.getString("title")+ " regdate : " + rs.getString("regdate"));
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("idx", rs.getString("idx"));
				jsonObject.put("name", rs.getString("name"));
				jsonObject.put("email", rs.getString("email"));
				jsonObject.put("title", rs.getString("title"));
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