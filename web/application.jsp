<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신청서</title>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
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
<script>
	var fn_ajax_sub = {
		fn_html : function(changedObj, changedVal){
			var targetObj = jQuery("#"+changedObj).attr("onchangeTarget") ;
			jQuery.post(
				"application_dynamic_select.jsp",
				{
					changedObj : changedObj,
					changedVal : changedVal,
					targetObj  : targetObj ,
					ts : new Date().getTime()
				},
				function(html, textStatus){
					if(textStatus == "success"){
						jQuery("#"+targetObj).empty();
						jQuery("#"+targetObj).append(html);
						if(targetObj != undefined){
							fn_ajax_sub.fn_html(targetObj, jQuery("#"+targetObj).val(), jQuery("#"+targetObj).attr("onchangeTarget"));
						}
					}
				},
				"html"
			);
		}
	};
</script>

<script type="text/javascript">
function button_event(){
	if(confirm("취소하시겠습니까?") == true){
		location.href="applicationMain.jsp";
	}else {
        return;
    }
}
</script>

</head>
<%
    DBhelper helper = new DBhelper();
	ResultSet rs = helper.classSearch(0, "0");
	Vector<classification_DAO> class_V = new Vector<classification_DAO>();
	while (rs.next()) {
		classification_DAO temp = new classification_DAO(rs.getString("first_name"), rs.getInt("first_code"));
		class_V.add(temp);
	}
	rs.close();
%>
<body>
<script>
    //Select Box 값이 변경되었을 때 사용하는 이벤트
    //srcElement 값을 보내고 destElement 값을 업데이트 한다
    //JSON 방식으로 return data 를 얻어오는 Ajax 방식
    document.write("test");
    function onSelectChange(srcElement, destElement)
    {

        if (srcElement == null) {
            $.ajax(
                {
                    type: "GET",
                    url: "init_dynamic_select.jsp",
                    data: {value : 0},
                    dataType: "JSON",
                    error: function () {
                        alert("실패");
                    },
                    success: function (data) { // callback 후 수행할 부분
                        //document.write(data.length);
                        //alert("성공");
                        destElement.empty(); // 도메인 리스트를 비운 후 기본값인 도메인선택을 추가

                        destElement.append("<option value=" + "" + ">::  선택  ::</option>");// 넘겨받은 data 에 대한 항목들을 추가
                        for (var index = 0; index < data.length; index++) {
                            destElement.append("<option value=" + data[index].id + ">" + data[index].value + "</option>");
                        }
                        destElement.removeAttr("disabled"); // 도메인 리스트 활성화
                    }
                }
            )
        }
        if (srcElement != null) {
            var selectedValue = srcElement.val(); // 선택된 값을 얻어온다.
            if (selectedValue == "") { // "" 일 경우 아무 동작도 하지 않는다.
                return;
            }// id 의 조합으로 파일명 사용
            $.ajax(
                {
                    type: "GET",
                    url: srcElement.attr("id") + "_dynamic_select.jsp",
                    data: {value : selectedValue},
                    dataType: "JSON",
                    error: function () {
                        alert("실패");
                    },
                    success: function (data) { // callback 후 수행할 부분
                        //alert("성공");
                        destElement.empty(); // 도메인 리스트를 비운 후 기본값인 도메인선택을 추가
                        destElement.append("<option value=" + "" + ">::  선택  ::</option>");// 넘겨받은 data 에 대한 항목들을 추가
                        for (var index = 0; index < data.length; index++) {
                            destElement.append("<option value=" + data[index].id + ">" + data[index].value + "</option>");
                        }
                        destElement.removeAttr("disabled"); // 도메인 리스트 활성화
                    }
                }
            )
        }
    }

</script>
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
                    <%for (int i = 0; i < class_V.size(); i++) {
                        String temp = class_V.get(i).getName();
                        int code = class_V.get(i).getNo();%>
                    <option value="<%=code%>">물품명: <%=temp%></option>
                    <%}%>
				</select></td>
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
        <script>
            onSelectChange(null, $('#first'));
            //도메인 선택시 - 프로젝트 업데이트
            $('#first').change(function(){ // first 리스트 값 변경
                onSelectChange($('#first'),$('#second')); // second 리스트를 업데이트
            });
            $('#second').change(function(){ // second 리스트 값 변경시
                onSelectChange($('#second'),$('#third')); // third 리스트를 업데이트
            });
            $('#third').change(function(){ // third 리스트 값 변경시
                onSelectChange($('#third'),$('#item_list')); // item_list 리스트를 업데이트
            });
        </script>
		<div align="center"><input type="submit" id="application" value="신청" > <input
			type="button" name="cancel" value="취소" onClick="button_event()"></div>
	</form>

</body>
</html>