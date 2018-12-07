<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.DBhelper"%>
<%
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String flag = request.getParameter("role"); //라디오박스를 선택해서 신청자인지 정비사인지 구분
    ResultSet rs = null;
	//PreparedStatement를 사용함
	DBhelper helper = new DBhelper();
	if(flag.equals("1"))
		rs = helper.search(userID, userPassword,flag);
	else
		rs = helper.search(userID,userPassword,flag);
	if(rs.next()){
    	session.setAttribute("user",userID);
    	if(flag.equals("1")){
    		response.sendRedirect("applicationMain.jsp");
    		session.setAttribute("name",rs.getString("applicator_name"));
    	}else if(flag == null){
    		%>
<script>
    		alert("구분을 선택해주세요");
    		location.href="login.jsp";</script>
<%
    	}else{
    		response.sendRedirect("machanic_main.jsp");
    		session.setAttribute("name",rs.getString("mechanic_name"));
    	}
    }else{
    %>
<script>
    alert("사용자 군번 혹은 암호가 틀렸습니다.");
    location.href="login.jsp";
    </script>
<%
    }
    %>
