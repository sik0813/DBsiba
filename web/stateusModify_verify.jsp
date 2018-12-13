<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%@page import="java.util.*" %>
<%
	DBhelper helper = new DBhelper();
	String userId = (String) session.getAttribute("user");
	ResultSet rs = helper.armySearch(userId);
	int row_count = helper.getRow(userId);
	Vector<Integer> v = new Vector<>();
	for(int i = 0 ; i< row_count ; i++){
		String temp = "sel"+i;
		v.add(i, Integer.parseInt(request.getParameter(temp)));
	}
	Boolean check = helper.update(v);
	if(check){
%>
<script>
alert("변경되었습니다!!");
location.href="machanic_main.jsp";
</script>
<%}else{
	%>
	<script>
	alert("실패하였습니다");
	location.href="statusModify.jsp";
	</script>
	<%} %>
