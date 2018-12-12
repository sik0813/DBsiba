package project_army;

import java.sql.*;
import java.sql.Date;
import java.util.Vector;

public class DBhelper {
    private PreparedStatement pstmt;
    private ResultSet rs;
    private Connection conn;
    private CallableStatement cstmt;

    public DBhelper() {
        conn = null;
        pstmt = null;
        rs = null;
        cstmt = null;

        String user = "ST2014112024";
        String passwd = "ST2014112024";
        String name = null;
        String dbdriver = "oracle.jdbc.driver.OracleDriver";
        String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";

        try {
            Class.forName(dbdriver);
            conn = DriverManager.getConnection(dburl, user, passwd);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    // �α��� �Ҷ� Ž���ϴ� �Լ�
    public ResultSet search(String id, String pwd, String flag) {
        String sql = null;
        if (flag.equals("1"))
            sql = "select applicator_group_number, applicator_name, password from applicator where applicator_group_number=? and password=? ";
        else
            sql = "select mechanic_group_no, mechanic_name, password from mechanic where mechanic_group_no = ? and password = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pwd);
            rs = pstmt.executeQuery();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;

    }

    // ��û���� ���̴� �Լ�
    public ResultSet search(String id) {
        String sql = "select * from application_history where applicator_group_number=? order by app_no";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;

    }

    // 1��,2��,3���з��� �����ϴ� �Լ�
    public ResultSet classSearch(int flag, String limit) {
        String[] list = { "first_classification", "second_classification", "third_classification", "item_list"};
        String sql = "";
        System.out.println(flag);
        System.out.println(limit);
        if(flag == 0)
            sql = "select * from " + list[flag];
        else if(flag == 1)
            sql = "select * from "+ list[flag] + " where first_code = ?";
        else if(flag == 2)
            sql = "select * from "+ list[flag] + " where second_code = ?";
        else if(flag == 3)
            sql = "select * from "+ list[flag] + " where third_code = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            if(flag != 0)   pstmt.setInt(1, Integer.parseInt(limit));
            rs = pstmt.executeQuery();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    // ��ǰ 1��,2��,3�� �з��� �ɷ��� ���õ� ��ǰ�� ã�� �Լ�
    public ResultSet itemSearch(int op1, int op2, int op3) {
        String sql = "select * from item_list where first_code = ? and second_code = ? and third_code =? ";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, op1);
            pstmt.setInt(2, op2);
            pstmt.setInt(3, op3);
            rs = pstmt.executeQuery();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }

    // ��û�� �߰�
    public String insert(String name, String date, String user, String applicator_name) {
        Date d = Date.valueOf(date);
        String result = "";
		/*insertCarschedule(
                            application_title
                            application_date
                            applicator_group_number
                            item_no
                            item_name
                            content
                            result
                            )*/
        String sql = "{call insertCarschedule(?, ?, ?, ?, ?, ?, ?)}";

        try {
            cstmt = conn.prepareCall(sql);
            cstmt.setString(1, name); //title
            cstmt.setDate(2, d); //date
            cstmt.setString(3, user); //group number
            cstmt.setString(4, user); //item no
            cstmt.setString(5, user); //item name
            cstmt.setString(6, user); //content
            cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //result
            cstmt.execute();
            result = cstmt.getString(7);
            return "��û�� �Ϸ� �Ǿ����ϴ�.";
        } catch (SQLException ex) {
            ex.printStackTrace();
            return result;
        }
    }

    // �δ� �����ڵ带 �̿��Ͽ� ��û ������ ã�� �Լ�
    public ResultSet armySearch(String user) {
        String sql = "select maintenance_army_code from mechanic where mechanic_group_no=?";
        int army_code = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user);
            rs = pstmt.executeQuery();
            if (rs.next())
                army_code = rs.getInt("maintenance_army_code");
            pstmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // System.out.println(army_code);
        String sql1 = "select * from application_history where maintenance_army_code=? order by app_no";
        try {
            pstmt = conn.prepareStatement(sql1);
            pstmt.setInt(1, army_code);
            rs = pstmt.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

    // ���� �˱����� �Լ�
    public int getRow(String user) {
        String sql = "select maintenance_army_code from mechanic where mechanic_group_no =?";
        int army_code = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user);
            rs = pstmt.executeQuery();
            if (rs.next())
                army_code = rs.getInt("maintenance_army_code");
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String sql1 = "select * from application_history where maintenance_army_code=?";
        int index = 0;
        try {
            // application_history �÷����� �˱����� ����
            pstmt = conn.prepareStatement(sql1, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            pstmt.setInt(1, army_code);
            rs = pstmt.executeQuery();
            rs.last();
            index = rs.getRow();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return index;
    }

    public Boolean update(Vector<Integer> v) {
        String[] temp = { "�԰�", "ó����", "ó���Ϸ�" };
        Vector<String> t = new Vector<String>();

        for(int i = 0 ; i< v.size();i++) {
            t.add(i, temp[v.get(i)]);
        }

        String sql = "update application_history set item_status=? where app_no=?";

        try {

            pstmt = conn.prepareStatement(sql);
            for (int i = 0; i < v.size(); i++) {
                System.out.println(t.get(i));
                pstmt.setString(1,t.get(i));
                pstmt.setInt(2, i+1);
                int flag = pstmt.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
