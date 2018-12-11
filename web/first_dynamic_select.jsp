<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.common.CommonUtils"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>

<%
    System.out.println("first_dynamic_select.jsp Start"); // 동작 확인용
    String result = "["; // jSON Object 의 배열 형태 포맷
    DBhelper helper = new DBhelper();
    ResultSet rs = helper.classSearch(1, value);
    Vector<classification_DAO> class_V = new Vector<classification_DAO>();
    while (rs.next()) {
        classification_DAO temp = new classification_DAO(rs.getString("first_name"), rs.getInt("first_code"));
        class_V.add(temp);
    }
    rs.close();
    String value = request.getParameter("value"); // 인자값 get. 사용되지는 않는다.

    for (int i = 0; i < class_V.size(); i++) {
        String temp = class_V.get(i).getName();
        int code = class_V.get(i).getNo();
        result += "{ " +
                "id: \"" + code + "\", " + // id 속성 추가
                "value: \"" + temp + "\" " + // value 속성 추가
                "} ";
        if(i < class_V.size()-1)
            result += ","; // 마지막 값이 아니면 , 추가
    }
    result += "]"; // jSON Object 의 배열 형태 포맷
    System.out.println("Return JSON : " + result); // 결과 확인용
%><%=result%><% //	return 되는 형태
    System.out.println("action_null_domainList.jsp End"); // 동작 확인용
%>