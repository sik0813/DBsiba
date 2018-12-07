<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="project_army.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>정비 메인 화면</title>
</head>
<body>
	<%@ include file="top_machanic.jsp"%>
	<table width="75%" align="center" height="100%">
		<%
			if (session_id != null) {
		%>
		<tr>
			<td align="center"><b><%=session_name%></b>님 의 정비 현황.</td>
		</tr>
		<%
			} else {
		%>
		<tr>
			<td align="center">로그인한 후 사용하세요</td>
		</tr>
		<%
			}
		%>
	</table>
	<table align="center" border="1">
		<tr>
			<td>신청 번호</td>
			<td>물품 이름</td>
			<td>입고된 날짜</td>
			<td>신청자 이름</td>
			<td>물품 상태</td>
		</tr>
		<%
			DBhelper helper = new DBhelper();
			String userId = (String) session.getAttribute("user");
			ResultSet rs = helper.armySearch(userId);
			String status = null;
			int app_no = 0;
			String application_name = null;
			String applicator_name = null;
			Date applicate_date = null;
			try {
				while (rs.next()) {
					app_no = rs.getInt("app_no");
					application_name = rs.getString("application_title");
					applicator_name = rs.getString("applicator_name");
					applicate_date = rs.getDate("application_date");
					status = rs.getString("item_status");
		%>
		<tr>
			<td align="center"><%=app_no%></td>
			<td align="center"><%=application_name%></td>
			<td align="center"><%=applicate_date%></td>
			<td align="center"><%=applicator_name%></td>
			<td align="center"><%=status%></td>
		</tr>
	<%
		}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		rs.close();
	%>
		</table>
</body>
</html>
