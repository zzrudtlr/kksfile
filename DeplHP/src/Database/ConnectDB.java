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
			Class.forName("com.mysql.jdbc.Driver");                       // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
			conn=(Connection) DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.
			System.out.println("����� ����Ǿ����ϴ�.");                            // Ŀ�ؼ��� ����� ����Ǹ� ����ȴ�.
		}catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
			e.printStackTrace();
		}
		return conn;
	}
	 
	 public void updateSql(String sql,String getData){
		 PreparedStatement ps = null;
		 try{
			
			//String sql = "select fish_name, japan, China, English, weight, fish_img from "+databaseTable.FISH_TABLE+" where _id="+fish_id+";";                        // sql ����
			//System.out.println("fish option sql : " + sql);
			ps = (PreparedStatement) conn.prepareStatement(sql);    
			ResultSet rs =  ps.executeQuery();                                        // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.
			
			if(!rs.isBeforeFirst()){
				System.out.println("no data");
			}else{
				
			//	JSONObject data = new JSONObject();
				while(rs.next()){                                                        // ����� �� �྿ ���ư��鼭 �����´�.
					
					
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
	 * sql : insert�� sql����
	 * sendData : insert table�� insert�� �÷� json
	 * 
	 * */
	public void insertSql(String sql,String sendData,ArrayList dataTitle){
	
	
		 PreparedStatement ps = null;
		 try{
			
			//String sql = "select fish_id,fish_name,fish_show from "+databaseTable.FISH_VIEW_TABLE;                        // sql ����
		
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
			
				ps.executeUpdate();      // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.
	
			}
			ps.close();
			conn.close();
		 }catch(Exception e){
			e.printStackTrace();
		 }
	}



}

