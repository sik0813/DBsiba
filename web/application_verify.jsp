<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%@ page import="project_army.DBhelper" %>
<%@ page import="java.net.URLDecoder" %>
<%
	String name = request.getParameter("name");
	String applicator_name = (String) session.getAttribute("name");
	String applicator_id = (String)session.getAttribute("user");
	String detail = request.getParameter("detail");
	String date = request.getParameter("date");
	String option1 = request.getParameter("first");
	String option2 = request.getParameter("second");
	String option3 = request.getParameter("third");
	String item_list = request.getParameter("item_list");
	String content = request.getParameter("content");
	String[] itemArry = item_list.split("!");
	String result = "";
	DBhelper helper = new DBhelper();
	ResultSet rs = helper.itemSearch(Integer.parseInt(option1), Integer.parseInt(option2),
			Integer.parseInt(option3));
	System.out.println(itemArry[0]);
	System.out.println(itemArry[1]);
	if (rs == null || name.isEmpty() || date.isEmpty()) {
%>
<script>
	alert("신청이 안됐습니다.");
	location.href="application.jsp";
</script>
<%
	} else {
	    /*insertCarschedule(
                            application_title
                            application_date
                            applicator_group_number
                            item_no
                            item_name
                            content
                            result
                            )*/
		result = helper.insert(name, date, applicator_id, itemArry[0], itemArry[1], content);
		System.out.println(result);
        result = URLDecoder.decode(result, "UTF-8");
%>
<script>
	alert("<%= result %>");
	location.href="applicationMain.jsp";
</script>
<%
	}
%>
