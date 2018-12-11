<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%
	String name = request.getParameter("name");
	String applicator_name = (String) session.getAttribute("name");
	String applicator_id = (String)session.getAttribute("user");
	String detail = request.getParameter("detail");
	String date = request.getParameter("date");
	String option1 = request.getParameter("first");
	String option2 = request.getParameter("second");
	String option3 = request.getParameter("third");
	String result = "";
	DBhelper helper = new DBhelper();
	ResultSet rs = helper.itemSearch(Integer.parseInt(option1), Integer.parseInt(option2),
			Integer.parseInt(option3));
	if (rs == null || name.isEmpty() || date.isEmpty()) {
%>
<script>
	alert("신청이 안됐습니다.");
	location.href="application.jsp";
</script>
<%
	} else {
	    /*insertCarschedule(
                            application_title,
                            application_date,
                            applicator_group_number,
                            applicator_name,
                            item_no,
                            item_name,
                            content,
                            result OUT VARCHAR2
                            )*/
		result = helper.insert(name, date, applicator_id, applicator_name);
%>
<script>
	alert(<%= result %>);
	location.href="applicationMain.jsp";
</script>
<%
	}
%>
