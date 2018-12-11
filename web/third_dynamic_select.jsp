<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.common.CommonUtils"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%
	String changedObj = CommonUtils.nullCheck(request.getParameter("changedObj"), "");
	String changedVal = CommonUtils.nullCheck(request.getParameter("changedVal"), "");
	String targetObj  = CommonUtils.nullCheck(request.getParameter("targetObj"), "");
    System.out.println("실행이 되었습");
	DBhelper helper = new DBhelper();
%>
<%
    int flag = 0;
    if(changedObj.equals("first")) flag = 1;
    else if(changedObj.equals("second")) flag = 2;
    else if(changedObj.equals("third")) flag = 3;

    ResultSet rs = helper.classSearch(flag, changedVal);
    Vector<classification_DAO> class_tV = new Vector<classification_DAO>();
    System.out.println("실행이 되었습");
    while (rs.next()) {
        if(flag == 1)
            {
                classification_DAO temp = new classification_DAO(rs.getString("second_name"), rs.getInt("second_code"), rs.getInt("first_code"));
                class_tV.add(temp);
            }
        if(flag == 2)
            {
                classification_DAO temp = new classification_DAO(rs.getString("third_name"), rs.getInt("third_code"), rs.getInt("second_code"));
                class_tV.add(temp);
            }
        if(flag == 3)
            {
                classification_DAO temp = new classification_DAO(rs.getString("item_name"), rs.getString("item_no"));
                class_tV.add(temp);
            }
    }


    if(changedObj.equals("first") || changedObj.equals("second"))
    {for (int i = 0; i < class_tV.size(); i++) {
		String temp = class_tV.get(i).getName();
		int code = class_tV.get(i).getNo();
        System.out.println(temp);
        System.out.println(code);
%>

<option value="<%=code%>"><%=temp%></option>
<%}
}
else if(changedObj.equals("third"))
    {
        for (int i = 0; i < class_tV.size(); i++) {
            String temp = class_tV.get(i).getName();
            String code = class_tV.get(i).getNumber();
            System.out.println(temp);

            System.out.println(code);
%>
<option value="<%=code%>"><%=temp%></option>
<%}
    }%>
