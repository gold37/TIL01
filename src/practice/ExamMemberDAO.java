package practice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class ExamMemberDAO {
	private DataSource ds;	
	private Connection conn; 
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	public boolean isEmailExists(String email) throws SQLException {
		boolean isUse;
		
		try {

			conn = ds.getConnection();
			
			String sql = " select email " + 
						 " from exam_ajaxmember " + 
						 " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			isUse = !rs.next(); // false면 true 줌
					
		} finally {
			
			rs.close();
		}
		
		return isUse;
	
	}
	
	
}
