
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

<%@page import="com.google.android.gcm.server.*"%>
<%!
	String name = "";
	String email = "";
	String title = "";
	String message = "";
	
	String result = "0";
	
	public boolean checkForm(){
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
	}
	
	public void sendPush(String msg){
        ArrayList<String> token = new ArrayList<String>();    //token값을 ArrayList에 저장
          String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);    //메시지 고유 ID
          boolean SHOW_ON_IDLE = false;    //옙 활성화 상태일때 보여줄것인지
          int LIVE_TIME = 1;    //옙 비활성화 상태일때 FCM가 메시지를 유효화하는 시간
          int RETRY = 2;    //메시지 전송실패시 재시도 횟수
       
          
          String simpleApiKey = "AAAAa1rKtD0:APA91bGwJE9OK3D8zWPrrtRx6EBiVjFxBRRuljpY-M24LPT0svOSw7EUpzFRx6kYL34rjyRZBFM1tI10D1SYXI4ze-07OmFug7hsXkkYACCEklhosG2Hu4C-U9i_-9eGE1IEVxHVXDuj";
          String gcmURL = "https://android.googleapis.com/fcm/send";    

          try {
           
              String to = "d_ugWKDCZkk:APA91bGwKlLtRLAMOiac0eA8mKRio22a2PiOAhuShNPU-crKxZc_WseAP4-xkedSeesU9SrtmT5DSBoCNDi_wWJzOAITOwzQEMr1tBXzhQgFQ2yw9z3dadhdtQ3ZftGPNINA7cUmyI55";
                token.add(to);
              Sender sender = new Sender(simpleApiKey);
              Message message = new Message.Builder()
              .collapseKey(MESSAGE_ID)
              .delayWhileIdle(SHOW_ON_IDLE)
              .timeToLive(LIVE_TIME)
              .addData("message",msg)
              .build();
              MulticastResult result1 = sender.send(message,token,RETRY);
              if (result1 != null) {
                  List<Result> resultList = result1.getResults();
                  for (Result result : resultList) {
                      System.out.println(result.getErrorCodeName()); 
                  }
              }
          }catch (Exception e) {
              e.printStackTrace();
          }
   }

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
		email = ""+jsonObj.get("email");
		title = ""+jsonObj.get("title");
		message = ""+jsonObj.get("message");
		
		DInfo dinfo = new DInfo();
		ConnectDB connectDB = new ConnectDB();
		
		Connection conn = connectDB.ConnectionDB(dinfo.DB_URL, dinfo.DB_ID, dinfo.DB_PW);
		PreparedStatement ps = null;
		try{
	
			String sql = "insert into "+dinfo.REQUEST_TABLE+" values (?,?,?,?,?,?);";
			ps = (PreparedStatement) conn.prepareStatement(sql);
			ps.setString(1,null);
			ps.setString(2,name);
			ps.setString(3,email);
			ps.setString(4, title);
			ps.setString(5, message);

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String today = formatter.format(new java.util.Date()); 
			ps.setString(6, today);
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
	sendPush(title);
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("result",result);
	out.print(jsonObject.toJSONString());
%>