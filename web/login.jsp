<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>군수품 정비 시스템</title>
<style>
legend {
	margin-top: 20%;
}

fieldset {
	text-align: center;
}
label {
	marign: 5%;
}
</style>
<script>
	
</script>
</head>

<body>
	<form method="post" action="login_verify.jsp">
		<fieldset>
			<legend>
				<b>군수품 정비 시스템</b>
			</legend><br><br>
			<div>
				신청자 <input type="radio" name="role" value="1" checked="checked">
				정비사 <input type="radio" name="role" value="2"><br>

			<br>

				군번 : <input type="text" name="userID" size="20" placeholder="00-00000000">
				PassWord : <input type="password" name="userPassword" size="20"><br>

			<br>

				<input type="SUBMIT" name="Submit" value="로그인">
				<input type="RESET" value="취소">
			</div>
		</fieldset>
	</form>
</body>
</html>