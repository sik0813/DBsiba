<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	}else {
        return;
    }
}
//도메인 선택시 - 프로젝트 업데이트
$('#first').change(function(){ // first 리스트 값 변경시
    onSelectChange($(this),$('#second')); // second 리스트를 업데이트
});
$('#second').change(function(){ // second 리스트 값 변경시
    onSelectChange($(this),$('#third')); // third 리스트를 업데이트
});
$('#third').change(function(){ // third 리스트 값 변경시
    onSelectChange($(this),$('#item_list')); // item_list 리스트를 업데이트
});

//Select Box 값이 변경되었을 때 사용하는 이벤트
//srcElement 값을 보내고 destElement 값을 업데이트 한다
//JSON 방식으로 return data 를 얻어오는 Ajax 방식
function onSelectChange(srcElement, destElement)
{
    if (srcElement != null) {
        var selectedValue = srcElement.val(); // 선택된 값을 얻어온다.
        if (selectedValue == "") { // "" 일 경우 아무 동작도 하지 않는다.
            return;
        }

// id 의 조합으로 파일명 사용
        $.getJSON("action_" + srcElement.attr("id") + "_" + destElement.attr("id") + ".jsp",
            { value: selectedValue }, // 전달되는 인자. 선택된 값
            function(data) { // callback 후 수행부분
                destElement.empty(); // 프로젝트 리스트를 비운 후
// 기본 프로젝트선택을 추가하고
                destElement.append("<option value='" + "" + "'>" + destElement.attr("name") + "</option>");
// 넘겨받은 data 를 추가한다.
                for(var index=0;index<data.length;index++) {
                    destElement.append("<option value='" + data[index].id + "'>" + data[index].value + "</option>");
                }
                destElement.removeAttr("disabled"); // 프로젝트 리스트 활성화
            });
    }
}

</div>
</script>
</head>
<%
    DBhelper helper = new DBhelper();
	ResultSet rs = helper.classSearch(0, 0);
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
					<option value="">:: 선택 ::</option>
				</select></td>
				<script>
		var sel = document.getElementById("first");
	<%for (int i = 0; i < class_V.size(); i++) {
				String temp = class_V.get(i).getName();
				int code = class_V.get(i).getNo();%>
				var option = document.createElement("option");
				option.text = " 물품명: " + "<%=temp%>"
				option.value = <%=code%>
		sel.add(option);
	<%}%>
	</script>
			</tr>
			<tr>
				<td>2차분류</td>
				<td>
					<select id="second" name="second">
                    	<option value="">:: 선택 ::</option>
					</select>
                </td>
			</tr>
			<tr>
				<td>3차분류</td>
				<td>
					<select id="third" name="third">
                    	<option value="">:: 선택 ::</option>
					</select>
				</td>
			</tr>
            <tr>
                <td>물품목록</td>
                <td>
					<select id="item_list" name="item_list">
                    	<option value="">:: 선택 ::</option>

					</select>
                    </td>
            </tr>
		</table>

		<div align="center"><input type="submit" id="application" value="신청" > <input
			type="button" name="cancel" value="취소" onClick="button_event()"></div>
	</form>

</body>
</html>