<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="project_army.*"%>
<%@ page import="project_army.DBhelper" %>
<%@ page import="project_army.classification_DAO" %>
<%@ page import="java.util.Vector" %>

<%
    System.out.println("first_dynamic_select.jsp Start"); // 동작 확인용
    String result = "["; // jSON Object 의 배열 형태 포맷
    String value = request.getParameter("value"); // 인자값 get. 사용되지는 않는다.
    DBhelper helper = new DBhelper();
    ResultSet rs = helper.classSearch(3, value);
    Vector<classification_DAO> class_V = new Vector<classification_DAO>();
    while (rs.next()) {
        classification_DAO temp = new classification_DAO(rs.getString("item_no"), rs.getString("item_name"));
        class_V.add(temp);
    }
    rs.close();

    int class_size = class_V.size();
    for (int i = 0; i < class_size; i++) {
        String temp = class_V.get(i).getName();
        String code = class_V.get(i).getNumber();
        result += "{ " +
                "\"id\" : \"" + code + "\", " + // id 속성 추가
                "\"value\" : \"" + temp + "\" " + // value 속성 추가
                "} ";
        if(i < class_size-1)
            result += ","; // 마지막 값이 아니면 , 추가
    }
    result += "]"; // jSON Object 의 배열 형태 포맷
    System.out.println("Return JSON : " + result); // 결과 확인용
%><%=result%><% //	return 되는 형태
    System.out.println("action_null_domainList.jsp End"); // 동작 확인용
%>