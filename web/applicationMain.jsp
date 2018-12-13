<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="project_army.DBhelper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신청 메인 화면</title>
<style>
div {
	margin-left: 15%;
	margin-bottom: 2%;
}
#table {
margin-left: 15%;
}
</style>
</head>
<body>
	<%@ include file="top.jsp"%>
	<table width="75%" align="center" height="100%">
		<%
			if (session_id != null) {
		%>
		<tr>
			<td align="center"><b><%=session_name%></b> 님 방문을 환영 합니다.</td>
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
	<%
		ResultSet rs = null;
		DBhelper helper = new DBhelper();
		String id = (String) session.getAttribute("user");
		rs = helper.search(id);
		String item_status = null; //물품의 상태
		String content;
        int int_status = 0;
		Date applicate_date = null; //신청한 날짜
		int app_no = 0; //신청서 번호
		String application_title = null; //물품 이름
	%>
	<div>
		<b>현재 신청 현황</b>
	</div>
	<table border="1" id="table" >
		<tr>
			<td align="center">번호</td>
			<td align="center">신청서 제목</td>
			<td align="center">날짜</td>
			<td align="center">상태</td>
			<td width="500px" align="center">상세 내용</td>
		</tr>
		<%
        String[] list = {"신청완료", "입고", "처리중", "처리완료"};
		while (rs.next()) {
			application_title = rs.getString("application_title");
			item_status = rs.getString("item_status");
			System.out.println(item_status);
			applicate_date = rs.getDate("application_date");
			app_no = rs.getInt("app_no");
			content = rs.getString("content");
            int_status = Integer.parseInt(item_status.trim());
            item_status = list[int_status];
	%>
		<tr>
			<td align="center"><%=app_no%></td>
			<td align="center"><%=application_title %></td>
			<td align="center"><%=applicate_date%></td>
			<td align="center"><%=item_status%></td>
			<td align="center"><%=content%></td>
		</tr>
		<%
		}
	%>
	</table>
</body>
</html>
