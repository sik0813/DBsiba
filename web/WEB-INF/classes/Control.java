package project_army;

import java.sql.*;

public class Control {
	private PreparedStatement pstmt;
	private Connection conn;
	private ResultSet rs;

	// DB를 연결할 시에 처음에 실행하는 함수
	public void init() {
		Connection conn = null;
		pstmt = null;
		rs = null;
		Boolean connect = false;
		String user = "ST2013112018";
		String passwd = "ST2013112018";

		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";

		try {
			Class.forName(dbdriver);
			conn = DriverManager.getConnection(dburl, user, passwd);

		} catch (Exception e) {
			connect = false;
			System.out.println(e);
		}
	}

	// 로그인 시 아이디와 비밀번호를 비교하여 찾는 함수
	public String Search(String id, String pwd) {
		String sql = "select s_name from student where id=? and pwd=? ";
		String temp = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();

			if (rs == null)
				temp = null;
			else {
				if (rs.next()) {
					temp = rs.getString("name");
				}
			}
			pstmt.close();
			conn.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return temp;
	}
}
