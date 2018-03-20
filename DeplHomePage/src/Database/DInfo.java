package Database;

public class DInfo {
	
	/*public final String DB_URL = "jdbc:mysql://localhost:3306";
	public final String DB_ID = "devisesolution";
	public final String DB_PW = "depl0316!!";*/
	public final String DB_URL = "jdbc:mysql://localhost:3306/depl?useUnicode=true&characterEncoding=utf8";
	public final String DB_ID = "root";
	public final String DB_PW = "020428";
	public final String REQUEST_TABLE="request";
	public final String PORTFOLIO_VIEW_TABLE = "portfo_view";
	public final String PORTFOLIO_TABLE = "portfolio";
	public final String PORTFOLIO_TYPE_TABLE = "portfolio_type";
	public final String USER_TABLE = "user";
	public final String SQL_REQUEST_TOTAL_COUNT = "select count(*) as count from "+REQUEST_TABLE+";";
	public final String SQL_PORTFOLIO_VIEW_TOTAL_COUNT = "select count(*) as count from "+PORTFOLIO_VIEW_TABLE+";";
	public final String SQL_PORTFOLIO_TYPE = "select idx,name from " + PORTFOLIO_TYPE_TABLE;
	public String getMessage_SQL(String l_to, String l_count) {
		return "select idx, name, email, title, regdate from " + REQUEST_TABLE + " limit "+l_to+","+l_count+";"; 
	}
	public String getMessage_detail_SQL(String idx) {
		return "select idx,name,email,title,message,regdate from "+REQUEST_TABLE+" where idx = "+idx+";";
	}
	
	public String getPortfolio_SQL(String l_to, String l_count) {
		return "select idx, name, img, contents, regdate from " + PORTFOLIO_VIEW_TABLE + " limit "+l_to+","+l_count+";"; 
	}
	
	public String getInsertPortfo_SQL() {
		return "insert into "+PORTFOLIO_TABLE+" values (?,?,?,?,?);";
	}
	
	public String getPortfoImg_SQL(String idx) {
		return "select img from "+PORTFOLIO_TABLE+" where idx = "+idx;
	}
	
	public String getDeletePortfo_SQL(String idx) {
		return "delete from "+PORTFOLIO_TABLE+" where idx="+idx;
	}
	public String getDprotfolio_SQL(String idx) {
		return "select idx,type_idx,name,img,contents,regdate from "+ PORTFOLIO_VIEW_TABLE + " where idx = "+idx; 
	}
	
	public String getLoginCheck_SQL(String id, String pw) {
		return "select idx from "+USER_TABLE+" where id='"+id+"' and pw='"+pw+"';";
	}
}
