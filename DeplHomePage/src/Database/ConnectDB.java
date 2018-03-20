package Database;

import java.sql.DriverManager;
import java.util.ArrayList;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ConnectDB {
	 Connection conn = null;
	 PreparedStatement pstmt = null;
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
	 
	

}

