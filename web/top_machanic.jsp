<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String session_id = (String) session.getAttribute("user");
	String session_name = (String) session.getAttribute("name");

	String log;
	if (session_id == null)
		log = "<a href=login.jsp>로그인</a>";
	else
		log = "<a href=logout.jsp>로그아웃</a>";
%>
<table width="75%" align="center" bgcolor="#ffff99" border>
	<tr>
		<td align="center"><b><%=log%></b></td>
		<td align="center"><b><a href="statusModify.jsp">상태 수정</a></b></td>
	</tr>
</table>