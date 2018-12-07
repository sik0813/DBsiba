<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신청서</title>
<style>
table {
	border-collapse: collapse;
}

td, th {
	text-align: left;
	padding: 5px;
	height: 20px;
	width: 100px;
}

div {
	align: center;
	margin-top: 10px;
}
</style>
<script type="text/javascript">
function button_event(){
	if(confirm("취소하시겠습니까?") == true){
		location.href="applicationMain.jsp";
	}else
		{
		return;
		}
}</script>
</head>
<%
	DBhelper helper = new DBhelper();
	ResultSet rs = helper.classSearch(0);
	Vector<classification_DAO> class_V = new Vector<classification_DAO>();
	while (rs.next()) {
		classification_DAO temp = new classification_DAO(rs.getString("first_name"), rs.getInt("first_code"));
		class_V.add(temp);
	}
	rs.close();
%>
<body>
	<h1 align="center">
		<b>신청서</b>
		<hr>
	</h1>
	<br>
	<form action="application_verify.jsp" method="post">
		<table align="center" border="1">
			<tr>
				<td align="center">물품명</td>
				<td><input type="text" name="name" size="20"></td>
			</tr>
			<tr>
				<td align="center">신청 날짜</td>
				<td><input type="date" name="date"></td>
			</tr>
			<tr>
				<td align="center">1차분류</td>
				<td><select name = "first" id="first">
				</select></td>
				<script>
		var sel = document.getElementById("first");
	<%for (int i = 0; i < class_V.size(); i++) {
				String temp = class_V.get(i).getName();
				int code = class_V.get(i).getNo();%>
				var option = document.createElement("option");
				option.text = "분류코드: " + <%=code%> + " 물품명: " + "<%=temp%>"
				option.value = <%=code%>
		sel.add(option);
	<%}%>
	</script>
			</tr>
			<tr>
				<td>2차분류</td>
				<td><select id="second" name="second"></select></td>
				<script>
				<%
				rs = helper.classSearch(1);
				Vector<classification_DAO> class_sV = new Vector<classification_DAO>();
				while (rs.next()) {
					classification_DAO temp = new classification_DAO(rs.getString("second_name"), rs.getInt("second_code"));
					class_sV.add(temp);
				}
			%>
				var sel = document.getElementById("second");
				<%for (int i = 0; i < class_sV.size(); i++) {
							String temp = class_sV.get(i).getName();
							int code = class_sV.get(i).getNo();%>
							var option = document.createElement("option");
							
							option.text = "분류코드: " + <%=code%> + " 물품명: " + "<%=temp%>"
							option.value = <%=code%>
					sel.add(option);
				<%}
				rs.close();%>
				</script>
			</tr>
			<tr>
				<td>3차분류</td>
				<td><select id="third" name="third"></select>
				<script>
				<%
				rs = helper.classSearch(2);
				Vector<classification_DAO> class_tV = new Vector<classification_DAO>();
				while (rs.next()) {
					classification_DAO temp = new classification_DAO(rs.getString("third_name"), rs.getInt("third_code"));
					class_tV.add(temp);
				}
			%>
				var sel = document.getElementById("third");
				<%for (int i = 0; i < class_tV.size(); i++) {
							String temp = class_tV.get(i).getName();
							int code = class_tV.get(i).getNo();%>
							var option = document.createElement("option");
							option.text = "분류코드: " + <%=code%> + " 물품명: " + "<%=temp%>"
							option.value = <%=code%>
					sel.add(option);
				<%}%>
				</script></td>
			</tr>
		</table>
		<div align="center"><input type="submit" id="application" value="신청" > <input
			type="button" name="cancel" value="취소" onClick="button_event()"></div>
	</form>

</body>
</html>