package Database;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ConnectDB {
	 Connection conn = null;
	 PreparedStatement pstmt = null;
	 public ConnectDB() {
		 
	 }
	 
	 public Connection ConnectionDB(String url, String id, String pw){
		
		try{
			Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
			conn=(Connection) DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
			System.out.println("제대로 연결되었습니다.");                            // 커넥션이 제대로 연결되면 수행된다.
		}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
			e.printStackTrace();
		}
		return conn;
	}
	 
	 public void updateSql(String sql,String getData){
		 PreparedStatement ps = null;
		 try{
			
			//String sql = "select fish_name, japan, China, English, weight, fish_img from "+databaseTable.FISH_TABLE+" where _id="+fish_id+";";                        // sql 쿼리
			//System.out.println("fish option sql : " + sql);
			ps = (PreparedStatement) conn.prepareStatement(sql);    
			ResultSet rs =  ps.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
			
			if(!rs.isBeforeFirst()){
				System.out.println("no data");
			}else{
				
			//	JSONObject data = new JSONObject();
				while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
					
					
					//System.out.println("id : " + rs.getString("_id") + " fish_name : " + rs.getString("fish_name") + " show : " + rs.getString("fish_show"));
					
					/*data.put("fish_name",rs.getString("fish_name"));
					data.put("japan",rs.getString("japan"));
					data.put("China",rs.getString("China"));
					data.put("English",rs.getString("English"));
					data.put("weight",rs.getString("weight"));
					data.put("fish_img",rs.getString("fish_img"));
					data.put("fish_price",fish_price);*/
					
				// out.println("content : " + rs.getString("content"));
				}
				//tableHtml = data.toJSONString();
				ps.close();
				conn.close();
			}
		 }catch(Exception e){
				e.printStackTrace();
		 }
	 }

	/*
	 * sql : insert할 sql구문
	 * sendData : insert table에 insert할 컬럼 json
	 * 
	 * */
	public void insertSql(String sql,String sendData,ArrayList dataTitle){
	
	
		 PreparedStatement ps = null;
		 try{
			
			//String sql = "select fish_id,fish_name,fish_show from "+databaseTable.FISH_VIEW_TABLE;                        // sql 쿼리
		
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(sendData);
			JSONArray jsonArray = (JSONArray) obj;
			for(int i=0;i<jsonArray.size();i++){
				JSONObject jsonObj = (JSONObject)jsonArray.get(i);
				System.out.println("jsonArray : " + jsonObj.get("id") + " name : " + jsonObj.get("name") + " price : " + jsonObj.get("price") + " date : " + jsonObj.get("date"));
				
			//	String sql = "insert  into fish_info values (?,?,?,?)";
				ps = (PreparedStatement) conn.prepareStatement(sql);
				ps.setString(1, null);
				ps.setInt(2,Integer.parseInt(""+jsonObj.get("id")));
				ps.setString(3,""+jsonObj.get("price"));
				ps.setString(4, ""+jsonObj.get("date"));
				//String sql = "insert  into fish_info values (null,"+jsonObj.get("id")+","+jsonObj.get("price")+",'"+jsonObj.get("date")+"');";
			
				ps.executeUpdate();      // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
	
			}
			ps.close();
			conn.close();
		 }catch(Exception e){
			e.printStackTrace();
		 }
	}



}

