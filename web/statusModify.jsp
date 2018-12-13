<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상태 수정</title>
	<script type="text/javascript">
        function button_event(){
            if(confirm("취소하시겠습니까?") == true){
                location.href="machanic_main.jsp";
            }else {
                return;
            }
        }
	</script>
</head>
<h1 align="center">상태 수정</h1>
<body>
	<%
		DBhelper helper = new DBhelper();
		String userId = (String) session.getAttribute("user");
		ResultSet rs = helper.armySearch(userId);
		int row_count = helper.getRow(userId);
		int count = 0;
		String status = null;
		int int_status = 0;
		String temp = null;
		int app_no = 0;
		String application_name = null;
		String applicator_name = null;
		Date applicate_date = null;
		//item_status = list[Integer.parseInt(item_status)];
	%>
	<form action="stateusModify_verify.jsp" method="post">
		<table align="center" border= "1">
			<tr>
				<td>신청 번호</td>
				<td>물품 이름</td>
				<td>입고된 날짜</td>
				<td>신청자 이름</td>
				<td>물품 상태</td>
			</tr>
			<%
				try {
					while (rs.next()) {
						app_no = rs.getInt("app_no");
						application_name = rs.getString("application_title");
						applicator_name = rs.getString("applicator_name");
						applicate_date = rs.getDate("application_date");
						status = rs.getString("item_status");
						int_status = Integer.parseInt(status.trim());
						temp = "sel" + count;
			%>
			<tr>
				<td align="center"><%=app_no%></td>
				<td align="center"><%=application_name%></td>
				<td align="center"><%=applicate_date%></td>
				<td align="center"><%=applicator_name%></td>
				<td align="center"><select name="<%=temp%>" id="<%=temp%>"></select></td>
			</tr>
			<script>
			var sel = document.getElementById("<%=temp%>");
			 temp1 = ['신청완료', '입고','처리중','처리완료'];
				for (var j = 0; j < temp1.length; j++) {
					var option = document.createElement("option");
				if(j == "<%=int_status%>")
					option.selected = true;
				    option.text = temp1[j];
					option.value = j;
					sel.appendChild(option);
				}
			</script>
			<%
				count++;
					}
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			%>

		</table>
		<div align="center" style="margin-top: 10px">
			<input type="submit" value="상태 제출"> <input type="reset"
				value="취소" onClick="button_event()">
		</div>
	</form>
</body>
</html>