
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


<%!
	String name = "";
	String p_type = "";
	String img_path = "";
	String contents = "";
	
	String result = "0";
	
	/*public boolean checkForm(){
		boolean check = true;
		if(name.matches("")){
			check = false;
		}else if(email.matches("")){
			check = false;
		}else if(title.matches("")){
			check = false;
		}else if(message.matches("")){
			check = false;
		}	
		return check;
	}*/
%>
<%
	request.setCharacterEncoding("UTF-8");
	String json = request.getParameter("json");
	int result = 0;
	try{
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(json);
		JSONArray jsonArray = (JSONArray) obj;
		JSONObject jsonObj = (JSONObject)jsonArray.get(0);
	
		name = ""+jsonObj.get("name");
		p_type = ""+jsonObj.get("p_type");
		img_path = ""+jsonObj.get("img_path");
		contents = ""+jsonObj.get("contents");
		
		DInfo dinfo = new DInfo();
		ConnectDB connectDB = new ConnectDB();
		
		Connection conn = connectDB.ConnectionDB(dinfo.DB_URL, dinfo.DB_ID, dinfo.DB_PW);
		PreparedStatement ps = null;
		try{
	
			
			ps = (PreparedStatement) conn.prepareStatement(dinfo.getInsertPortfo_SQL());
			ps.setString(1,null);
			ps.setInt(2,Integer.parseInt(p_type));
			ps.setString(3,img_path);
			ps.setString(4, contents);

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String today = formatter.format(new java.util.Date()); 
			ps.setString(5, today);
			result = ps.executeUpdate();      // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
			
			System.out.println("result : " + result);
			
			ps.close();
			conn.close();
		 }catch(SQLException e){
			 e.printStackTrace();
			 System.out.println("SQL error");
		 } catch(Exception e){
			e.printStackTrace();
			System.out.println("error");
		 }
	}catch(Exception e){
		e.printStackTrace();
		System.out.println("error");
	}
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result",result);
	out.print(jsonObject.toJSONString());
%>